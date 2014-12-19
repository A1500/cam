//doc
/**
 * @ignore
 * 如果没有说明,文中出现的TreePanel、dataset等名词都是loushang里的组件 
 * 
 * 设想中的树需要与后台多隔离,也就是说,后台的数据都是业务数据,前台的展现不依赖于后台。前台有单独的mvc模型
 * 树前端mvc模型:
 * 	control:TreePanel以及各种监听器,我们强制所有的显示相关的事件都需要经过TreePanel处理
 * 	view:dom、html
 * 	model:treenode-nodemodel
 * 前台的后台模型：dataset与record
 * 
 * 树的数据可以同步加载,即由前台提供;也可以后台加载.可以是xml,也可以是json,由dataset负责提供统一处理,
 * 处理后交给树的统一是record,一个record代表后台的一条记录
 * 
 * 一棵树,好比原来loushang中的组织机构树,业务数据分为四种,法人、部门、岗位、员工,这四种类型对前台节点的展现要求都不相同,
 * 针对这种情况,我们使用nodemodel,让用户可以针对不同的业务数据类型来定制节点展现;当然,使用nodemoel也有性能方面的考虑,原
 * 来ext中的treenode,存放了很多相同的属性配置,当树的节点很多时,对于内存的要求就高,现在按照类型分解为几个nodemode后,treenode
 * 就不需要存放这么多属性。
 * 
 * 树会根据record组装treenode,创建时,nodemodel就起作用了
 * 
 * 需要考虑的是树的根结点
 * 	1如果没有根,提供一个虚拟根,不显示,自动展开子节点
 * 	配置了根,并且显示,则显示根。根也可以结合nodemodel使用,也可以为其配置齐全各种属性,
 * 	nodemodel中需要配置的属性都可以在根中配置
 * 	2树的根,有实际的根,用于作为整棵树的数据入口,此根由用户配置,不允许变化;另外还有一种根:当前显示的根节点,
 * 	如果用户设置了当前显示根,则整棵树从此节点开始显示,往上的节点都隐藏
 * 	3用户可以给根在前台配置子节点,如此,只有展开到末级时,才会由dataset去获取数据
 * 
 * 需要记录当前节点:
 * 	点击节点时,记录
 * 	右键节点时,记录
 * 
 * 用户在浏览器上对树节点可以施加的操作有：
 * 	点击节点,包括单击、双击,可以点击节点图标,可以点击节点的+/-,可以点击节点文本,点击节点所在的行
 * 		展开节点
 * 	鼠标移动越过节点
 * 		高亮
 * 	鼠标停留在节点
 * 		显示提示信息
 * 	右键
 * 		菜单
 * 	拖拽
 * 		改变节点
 * 	F2
 * 		修改节点
 * 	ctrl+z
 * 		撤销修改
 * 	checkbox,选中若干
 * 		记录若干个选中的节点,这种节点记录不进行关系排序,所谓关系排序是指子节点在父节点之前,
 * 		这样后台就可以比如按照数据传送顺序操作数据库,无须再去判断节点的子节点是否存在
 * 程序员页面需要进行的操作
 * 	增加节点
 * 	修改节点
 * 	删除节点
 * 	刷新节点
 * 	排序节点
 * 	查询节点
 * 	过滤节点
 * 	根据节点获取对应的dataset
 * 	设置树形的显示根
 * 	获取到根节点的路径
 * 	获取某两个节点之间的路径
 * 树应该通过全局控制的行为是:
 * 	节点展开时的动画效果
 * 	节点单击或是双击展开
 * 	节点提示信息控制
 * 	节点鼠标移动时的高亮显示
 * 	节点路径的分割符号
 * 
 * 树需要与别的组件联合使用的场景
 * 	form,这个很常见,用于显示明细等等,一般修改放在右边,增加、删除的入口还是放在树这边
 * 	grid,这个用在批量修改记录时用
 * 	tree,两颗树联动,这个是假想的情况,与grid类似处理
 * 
 * tree需要触发的事件
 * 	主要是对节点的操作
 * 	比如node remove/node insert
 * treenode需要触发的事件
 * 	node change/node expand/node collapse/node click/dblclick
 * nodemodel强制不允许修改,这个触发事件,潜在的性能问题是个问题
 * 
 * 重构过程,L5 treepanel:
 * 迭代一:初步引入record,主要是将原来需要传入的attributes改造成根据record与nodemodel生成
 * 第一步:先改造ext treenode,将其改成record与nodemodel
 * 	TreeNode构造方法改造
 * 	AsyncTreeNode改造
 * 第二步:修改ext treepanel,增加nodemodelmgr,增加nodeModels配置项
 * 	根节点处理,我们将树的根结点配置信息解析为simplerecord与simplenodemodel
 * 	使用treeloader来创建simplerecord,使用treeloader来创建node
 * 第三步:将ext loader的创建node改为针对record创建
 * 	添加根据属性值对象创建record的方法
 * 	修改createNode方法,改为针对record创建
 * 第三步:将ext loader加载结果改为record
 * 	规定服务器端返回的数据格式为:
 * 	{total:'',
 * 	rows:[{children:{rows:[{},{}]},{}]},
 * 	metaData:{totalProperty:'total',root:'rows',successProperty:'success',id:''},
 * 	success:true}
 * 	修改load方法,请求返回的是attr,然后解析为record
 * 以上几个步骤完成后可以考虑下一阶段的迭代
 * 
 * 前面几个步骤完成后,node可以获取到record,但是record无法获取到node
 * 	node的id与record的id
 * dataset还没有出来
 * 
 * 迭代二:引入dataset,替代原来的treeloader,并且强化功能
 * 	第一步，创建dataset,这是外部可以感知的
 *  第二步,创建treeloader,用来加载数据,用户可以对其一无所知,当然,如果了解了treeloader可以更细粒度的加载数据
 *  第三步,创建treejsonreader,用来解析加载的数据
 *  第四步,创建treerecord,解析数据的结果
 *  
 * 迭代三
 *  第一步,treepanel中添加NodeBuilder,负责node的创建,由NodeBuilder负责管理nodemodel
 * 	第二步,将treenode改回原来ext的attribute构建方式,NodeBuilder中控制attribute生成
 *  第三步,将root改为由dataset提供
 * 	第四步,将treenode中的加载数据改为record加载
 * 	第五步,将treenode的展开节点加载数据改为使用record加载
 * 	第六步,让treepanel绑定DataSet,监听record insert、update、remove、sort等事件,完成节点操作
 * 	第七步,修改treenodeui,支持radio与checkbox,以及checkbox的级联选中
 * 
 * 迭代四
 *  第一步,修改treeeventmodel,添加当前treenode的支持
 * 	第二步,为nodemodel添加事件,用于支持节点选中、节点右键事件
 *  第三步,全面替换Ext.tree为L5.tree
 * 迭代五
 *  第三步,修改默认的selectionmodel,使其支持nodemodel
 *  第四步,修改radio、checkbox,使其使用selectionmodel
 *  
 * {treenodeid}={treeId}+"_"+{recordId}
 * 
 * @cfg {Boolean} rootExpanded true 展开根节点,false,不展开根节点,默认不需要配置,结合rootVisible使用
 */
/**
 * @class L5.tree.L5TreePanel
 * @extends L5.Panel
 */
L5.tree.L5TreePanel = L5.extend(L5.Panel,{
    rootVisible : true,
    animate: L5.enableFx,
    lines : true,
    enableDD : false,
    hlDrop : L5.enableFx,
    pathSeparator: "/",

    initComponent : function(){
        L5.tree.L5TreePanel.superclass.initComponent.call(this);
		
        if(!this.eventModel){
            this.eventModel = new L5.tree.TreeEventModel(this);
        }
        this.nodeHash = {};
		//this.checks = [];//树形存在checkbox或者radio时,用于存放用户选中的节点
        this.radioboxChecked = null;
		this.initTree();
		
        this.addEvents(

            /**
            * @event append
            * 当在节点下追加一个新的子节点时触发
            * @param {Tree} tree 所属树对象
            * @param {Node} parent 父节点
            * @param {Node} node 新追加的节点
            * @param {Number} index 新追加节点的索引
            */
           "append",
           /**
            * @event remove
            * 当从一个节点下删除子节点时触发
            * @param {Tree} tree 所属树对象
            * @param {Node} parent 父节点
            * @param {Node} node 要删除的子节点
            */
           "remove",
           /**
            * @ignore
            * @event movenode
            * 当一个节点被移动到一个新的位置时触发
            * @param {Tree} tree 所属树对象
            * @param {Node} node 被移动的节点
            * @param {Node} oldParent 移动前的父节点
            * @param {Node} newParent 移动后的父节点
            * @param {Number} index 移动后的索引
            */
           "movenode",
           /**
            * @event insert
            * 当一个新的子节点被插入到某个节点下时触发
            * @param {Tree} tree 所属树对象
            * @param {Node} parent 父节点
            * @param {Node} node 被插入的子节点
            * @param {Node} refNode 被插入子节点之前的子节点
            */
           "insert",
           /**
            * @event beforeappend
            * 当一个新的子节点被追加到某个节点之前触发，返回false就取消追加
            * @param {Tree} tree 所属树对象
            * @param {Node} parent 父节点
            * @param {Node} node 要追加的子节点
            */
           "beforeappend",
           /**
            * @event beforeremove
            * 当一个子节点被从某个节点下删除之前触发，返回false则取消删除
            * @param {Tree} tree 所属树对象
            * @param {Node} parent 父节点
            * @param {Node} node 要被删除的子节点
            */
           "beforeremove",
           /**
            * @ignore
            * @event beforemovenode
            * 当一个节点被移动到一个新位置之前触发，返回false则取消移动
            * @param {Tree} tree 所属树对象
            * @param {Node} node 被移动的节点
            * @param {Node} oldParent 移动之前的父节点
            * @param {Node} newParent 将要移动到的父节点
            * @param {Number} index 将要移动到的索引
            */
           "beforemovenode",
           /**
            * @event beforeinsert
            * 当一个新的子节点被插入到一个节点下之前触发，返回false则取消插入
            * @param {Tree} tree 所属树对象
            * @param {Node} parent 父节点
            * @param {Node} node 要被插入的子节点
            * @param {Node} refNode 被插入子节点之前的子节点
            */
            "beforeinsert",

            /**
            * @event beforeload
            * 当一个节点被加载前触发，返回false则取消加载
            * @param {Node} node 要被加载的节点
            */
            "beforeload",
            /**
            * @event load
            * 当一个节点被加载时触发
            * @param {Node} node 被加载的节点
            */
            "load",
            /**
            * @event textchange
            * 当节点的文本被修改时触发
            * @param {Node} node 当前节点
            * @param {String} text 新文本
            * @param {String} oldText 原文本
            */
            "textchange",
            /**
            * @event beforeexpandnode
            * 节点展开前触发，返回false表示取消
            * @param {Node} node 当前节点
            * @param {Boolean} deep
            * @param {Boolean} anim
            */
            "beforeexpandnode",
            /**
            * @event beforecollapsenode
            * 节点收缩前触发，返回false表示取消
            * @param {Node} node 当前节点
            * @param {Boolean} deep
            * @param {Boolean} anim
            */
            "beforecollapsenode",
            /**
            * @event expandnode
            * 节点展开时触发
            * @param {Node} node 当前节点
            */
            "expandnode",
            /**
            * @ignore
            * @event disabledchange
            * Fires when the disabled status of a node changes
            * @param {Node} node 当前节点
            * @param {Boolean} disabled
            */
            "disabledchange",
            /**
            * @event collapsenode
            * 当节点收缩时被触发
            * @param {Node} node 当前节点
            */
            "collapsenode",
            /**
            * @event beforeclick
            * 单击节点事件执行之前触发，返回false取消默认操作
            * @param {Node} node 当前节点
            * @param {L5.EventObject} e 事件对象
            */
            "beforeclick",
            /**
            * @event click
            * 当节点被点击时触发
            * @param {Node} node 当前节点
            * @param {L5.EventObject} e 事件对象
            */
            "click",
            /**
            * @event checkchange
            * 当带有checkbox的节点的选中属性被改变时触发
            * @param {Node} this 当前节点
            * @param {Boolean} checked 是否被选中
            */
            "checkchange",
            /**
            * @event dblclick
            * 当节点被双击时触发
            * @param {Node} node 当前节点
            * @param {L5.EventObject} e 事件对象
            */
            "dblclick",
            /**
            * @event contextmenu
            * 当节点被右击时触发。
            * 该事件被触发后会显示上下文菜单，首先创建一个菜单对象(相关细节请查看{@link L5.menu.Menu})，然后为该事件添加一个handler:<code><pre>
new L5.tree.L5TreePanel({
    title: 'My TreePanel',
    root: new L5.tree.L5AsyncTreeNode({
        text: 'The Root',
        children: [
            { text: 'Child node 1', leaf: true },
            { text: 'Child node 2', leaf: true }
        ]
    }),
    contextMenu: new L5.menu.Menu({
        items: [{
            id: 'delete-node',
            text: 'Delete Node'
        }],
        listeners: {
            itemclick: function(item) {
                switch (item.id) {
                    case 'delete-node':
                        var n = item.parentMenu.contextNode;
                        if (n.parentNode) {
                            n.remove();
                        }
                        break;
                }
            }
        }
    }),
    listeners: {
        contextmenu: function(node, e) {
//          Register the context node with the menu so that a Menu Item's handler function can access
//          it via its {@link L5.menu.BaseItem#parentMenu parentMenu} property.
            node.select();
            var c = node.getOwnerTree().contextMenu;
            c.contextNode = node;
            c.showAt(e.getXY());
        }
    }
});
</pre></code>
            * @param {Node} node 当前节点
            * @param {L5.EventObject} e 事件对象
            */
            "contextmenu",
            /**
            * @ignore
            * @event beforechildrenrendered
            * Fires right before the child nodes for a node are rendered
            * @param {Node} node The node
            */
            "beforechildrenrendered",
           /**
             * @ignore
             * @event startdrag
             * Fires when a node starts being dragged
             * @param {L5.tree.L5TreePanel} this
             * @param {L5.tree.TreeNode} node
             * @param {event} e The raw browser event
             */
            "startdrag",
            /**
             * @ignore
             * @event enddrag
             * Fires when a drag operation is complete
             * @param {L5.tree.L5TreePanel} this
             * @param {L5.tree.TreeNode} node
             * @param {event} e The raw browser event
             */
            "enddrag",
            /**
             * @ignore
             * @event dragdrop
             * Fires when a dragged node is dropped on a valid DD target
             * @param {L5.tree.L5TreePanel} this
             * @param {L5.tree.TreeNode} node
             * @param {DD} dd The dd it was dropped on
             * @param {event} e The raw browser event
             */
            "dragdrop",
            /**
             * @ignore
             * @event beforenodedrop
             * Fires when a DD object is dropped on a node in this tree for preprocessing. Return false to cancel the drop. The dropEvent
             * passed to handlers has the following properties:<br />
             * <ul style="padding:5px;padding-left:16px;">
             * <li>tree - The TreePanel</li>
             * <li>target - The node being targeted for the drop</li>
             * <li>data - The drag data from the drag source</li>
             * <li>point - The point of the drop - append, above or below</li>
             * <li>source - The drag source</li>
             * <li>rawEvent - Raw mouse event</li>
             * <li>dropNode - Drop node(s) provided by the source <b>OR</b> you can supply node(s)
             * to be inserted by setting them on this object.</li>
             * <li>cancel - Set this to true to cancel the drop.</li>
             * <li>dropStatus - If the default drop action is cancelled but the drop is valid, setting this to true
             * will prevent the animated "repair" from appearing.</li>
             * </ul>
             * @param {Object} dropEvent
             */
            "beforenodedrop",
            /**
             * @ignore
             * @event nodedrop
             * Fires after a DD object is dropped on a node in this tree. The dropEvent
             * passed to handlers has the following properties:<br />
             * <ul style="padding:5px;padding-left:16px;">
             * <li>tree - The TreePanel</li>
             * <li>target - The node being targeted for the drop</li>
             * <li>data - The drag data from the drag source</li>
             * <li>point - The point of the drop - append, above or below</li>
             * <li>source - The drag source</li>
             * <li>rawEvent - Raw mouse event</li>
             * <li>dropNode - Dropped node(s).</li>
             * </ul>
             * @param {Object} dropEvent
             */
            "nodedrop",
             /**
             * @ignore
             * @event nodedragover
             * Fires when a tree node is being targeted for a drag drop, return false to signal drop not allowed. The dragOverEvent
             * passed to handlers has the following properties:<br />
             * <ul style="padding:5px;padding-left:16px;">
             * <li>tree - The TreePanel</li>
             * <li>target - The node being targeted for the drop</li>
             * <li>data - The drag data from the drag source</li>
             * <li>point - The point of the drop - append, above or below</li>
             * <li>source - The drag source</li>
             * <li>rawEvent - Raw mouse event</li>
             * <li>dropNode - Drop node(s) provided by the source.</li>
             * <li>cancel - Set this to true to signal drop not allowed.</li>
             * </ul>
             * @param {Object} dragOverEvent
             */
            "nodedragover"
        );
        if(this.singleExpand){
            this.on("beforeexpandnode", this.restrictExpand, this);
        }
    },

	/**
	 * 初始化树的数据
	 */
	initTree : function(){
		this.initNodeBuilder();
		this.initDataSet();
		
		var dataset = this.dataset;
		var builder = this.nodeBuilder;
		
		var rootrec = dataset.getRoot();
		if(rootrec){
			var node = builder.createNode(rootrec);
			this.setRootNode(node);
//			this.curNode = this.root;
		}
	},
	
	initNodeBuilder : function(){
			//添加nodemodelmgr
		this.nodeBuilder = new L5.tree.TreeNodeBuilder(this.getId(),this.nodeModels);
		delete this.nodeModels;
	},
	
	/**
	 * 初始化dataset，同时处理root
	 */
	initDataSet : function(){
		var dataset = this.dataset;
		if(dataset){
			if(typeof dataset == 'object' && !dataset.registRecord){//TreeDataSet config
				dataset = new L5.tree.TreeDataSet(dataset);
			} else if(typeof dataset=='string'){
				dataset = L5.DatasetMgr.lookup(dataset);
			}
			this.dataset = dataset;
		}
	},
	
	setDataSet : function(ds){
		if(ds != this.dataset){//树与dataset的根一一对应
			this.dataset.removeDispacherById(this.getId());
		}
		this.dataset = ds;
		var obser = new L5.tree.DataSetEventObserver(this);
		ds.registDispacher(this.getId(),obser);
	},
	
	getNodeByRecord : function(rec){
		return this.getNodeByRecordId(rec.id);
	},
	
	getNodeByRecordId : function(recid,recType){
		var newrecid = recType?(recType+"_"+recid):recid;
		var nodeid = this.nodeBuilder.getNodeIdByRecId(newrecid);
		return this.getNodeById(nodeid);
	},
	
    // private
    proxyNodeEvent : function(ename, a1, a2, a3, a4, a5, a6){
        if(ename == 'collapse' || ename == 'expand' || ename == 'beforecollapse' || ename == 'beforeexpand' || ename == 'move' || ename == 'beforemove'){
            ename = ename+'node';
        }
        // args inline for performance while bubbling events
        return this.fireEvent(ename, a1, a2, a3, a4, a5, a6);
    },


    /**
     * 返回树的根节点
     * @return {Node}
     */
    getRootNode : function(){
        return this.root;
    },

    /**
     * 树初始化时设置根节点
     * @param {Node} node
     * @return {Node}
     */
    setRootNode : function(node,amin){
		if(!node.render){ // record passed
			node = this.nodeBuilder.createNode(node);
        }
		var rootrec = node.record;
		if(!rootrec){
			return;
		}
		//在setRoot时,将dataset与树绑定在一起,实际就是让tree能够监听dataset的事件
		var dataset = rootrec.getDataSet();
		this.setDataSet(dataset);
		
        if(this.rootVisible===false){//注意:如果根结点隐藏,自动展开下级
        	if(this.rootExpanded == undefined){
        		node.expanded = true;
        	} else {
        		node.expanded = this.rootExpanded;
        	}
        }else{
        	node.expanded = this.rootExpanded;
        }
		if(this.root){//清除原有数据
        	this.root.destroy();
       		this.nodeHash = {};
		}
		this.curNode = false;
        this.root = node;
        node.ownerTree = this;
        node.isRoot = true;
        this.registerNode(node);
        if(!this.rootVisible){
        	var uiP = node.attributes.uiProvider;
        	node.ui = uiP ? new uiP(node) : new L5.tree.RootTreeNodeUI(node);
        }
		if(this.rendered){
			node.render(true,amin||false);
			if(node.attributes.showType=== 'checkbox')//如果为checkbox才执行onCheckChange
				node.ui.onCheckChange(true);//将根节点的record加到checks里去
		}
        return node;
    },

    /**
     * 根据id获取节点
     * @param {String} id
     * @return {Node}
     */
    getNodeById : function(id){
        return this.nodeHash[id];
    },

    // private
    registerNode : function(node){
        this.nodeHash[node.id] = node;
    },

    // private
    unregisterNode : function(node){
        delete this.nodeHash[node.id];
    },

    // private
    toString : function(){
        return "[Tree"+(this.id?" "+this.id:"")+"]";
    },

    // private
    restrictExpand : function(node){
        var p = node.parentNode;
        if(p){
            if(p.expandedChild && p.expandedChild.parentNode == p){
                p.expandedChild.collapse();
            }
            p.expandedChild = node;
        }
    },

    /**
     * 我们使用checks属性存放选中的节点,可以直接使用tree.checks获取,checks是一个数组
     * 返回一个选中节点的数组，或一个选中节点特定属性的数组(如 "id")
     * @param {String} attribute (可选) 节点属性，默认为null
     * @param {TreeNode} startNode (可选) 开始节点，默认为根节点
     * @return {Array}
     */
    getChecked : function(a, startNode){
        startNode = startNode || this.root;
        var r = [];
//        if(!a)a='id';
        var f = function(){
            if(this.attributes.checked==true){
            	var val = !a ? (this.record ? this.record.id : this.id) : (this.record ? this.record.get(a) : this.attributes[a]);
            	if(val != undefined){
            		r.push(val);
            	}
//            	r.push(!a ? this : (a == 'id' ? (this.record ? this.record.id : this.id): (this.record ? this.record.get(a) : this.attributes[a]) ));
            }
        }
        startNode.cascade(f);
        return r;
//		var r = [];
//		for(var i=0,len=this.checks.length;i<len;i++){
//			var rec = this.checks[i];
//			var val = a?rec.get(a):rec.id;
//			if(val != undefined){
//				r.push(a?rec.get(a):rec.id);
//			}
//			
//		}
//		return r;
    },

    /**
     * 返回TreePanel的容器
     * @return {Element} TreePanel的容器
     */
    getEl : function(){
        return this.el;
    },

    /**
     * 返回TreePanel的默认 {@link L5.tree.TreeDataSet}
     * @return {L5.tree.TreeDataSet} TreePanel的Dataset
     */
    getDataSet : function(){
        return this.dataset;
    },
	
	/**
	 * 返回treenode的构建者
	 */
	getNodeBuilder : function(){
		return this.nodeBuilder;
	},
	
	/**
	 * 返回当前操作的节点
	 */
	getCurrentNode : function(){
		return this.curNode;
	},
	
	/**
	 * 返回当前操作的Record
	 */
	getCurrentRecord : function(){
		return this.curNode?this.curNode.record:null;
	},
	
    /**
     * 展开所有节点
     */
    expandAll : function(){
        this.root.expand(true);
    },

    /**
     * 收缩所有节点
     */
    collapseAll : function(){
        this.root.collapse(true);
    },

    /**
     * @ignore
     * Returns the selection model used by this TreePanel.
     * @return {TreeSelectionModel} The selection model used by this TreePanel
     */
    getSelectionModel : function(){
        if(!this.selModel){
            this.selModel = new L5.tree.DefaultSelectionModel();
        }
        return this.selModel;
    },

    /**
     * 根据指定路径展开节点。节点路径的获取方式{@link L5.model.Node#getPath}
     * @param {String} path
     * @param {String} attr (可选) 该属性用于路径(更多信息请见{@link L5.model.Node#getPath})
     * @param {Function} callback (可选) 回调函数，当节点展开完毕时回调。
     * 该回调函数包括参数(bSuccess, oLastNode)，其中bSuccess表示展开是否成功，oLastNode表示最后被展开的节点.
     */
    expandPath : function(path, attr, callback){
        attr = attr || "id";
        var keys = path.split(this.pathSeparator);
        var curNode = this.root;
        if(curNode.attributes[attr] != keys[1]){ // invalid root
            if(callback){
                callback(false, null);
            }
            return;
        }
        var index = 1;
        var f = function(){
            if(++index == keys.length){
                if(callback){
                    callback(true, curNode);
                }
                return;
            }
            var c = curNode.findChild(attr, keys[index]);
            if(!c){
                if(callback){
                    callback(false, curNode);
                }
                return;
            }
            curNode = c;
            c.expand(false, false, f);
        };
        curNode.expand(false, false, f);
    },

    /**
     * @ignore
     * Selects the node in this tree at the specified path. A path can be retrieved from a node with {@link L5.model.Node#getPath}
     * @param {String} path
     * @param {String} attr (optional) The attribute used in the path (see {@link L5.model.Node#getPath} for more info)
     * @param {Function} callback (optional) The callback to call when the selection is complete. The callback will be called with
     * (bSuccess, oSelNode) where bSuccess is if the selection was successful and oSelNode is the selected node.
     */
    selectPath : function(path, attr, callback){
        attr = attr || "id";
        var keys = path.split(this.pathSeparator);
        var v = keys.pop();
        if(keys.length > 0){
            var f = function(success, node){
                if(success && node){
                    var n = node.findChild(attr, v);
                    if(n){
                        n.select();
                        if(callback){
                            callback(true, n);
                        }
                    }else if(callback){
                        callback(false, n);
                    }
                }else{
                    if(callback){
                        callback(false, n);
                    }
                }
            };
            this.expandPath(keys.join(this.pathSeparator), attr, f);
        }else{
            this.root.select();
            if(callback){
                callback(true, this.root);
            }
        }
    },

    /**
     * @ignore
     * Returns the underlying Element for this tree
     * @return {L5.Element} The Element
     */
    getTreeEl : function(){
        return this.body;
    },

    // private
    onRender : function(ct, position){
        L5.tree.L5TreePanel.superclass.onRender.call(this, ct, position);
        this.el.addClass('l-tree');
        this.innerCt = this.body.createChild({tag:"ul",
               cls:"l-tree-root-ct " +
               (this.useArrows ? 'l-tree-arrows' : this.lines ? "l-tree-lines" : "l-tree-no-lines")});
    },

    // private
    initEvents : function(){
        L5.tree.L5TreePanel.superclass.initEvents.call(this);

        if(this.containerScroll){
            L5.dd.ScrollManager.register(this.body);
        }
        if((this.enableDD || this.enableDrop) && !this.dropZone){
           /**
        	* @ignore
        	* The dropZone used by this tree if drop is enabled
            * @type L5.tree.TreeDropZone
            */
             this.dropZone = new L5.tree.TreeDropZone(this, this.dropConfig || {
               ddGroup: this.ddGroup || "TreeDD", appendOnly: this.ddAppendOnly === true
           });
        }
        if((this.enableDD || this.enableDrag) && !this.dragZone){
           /**
            * @ignore
            * The dragZone used by this tree if drag is enabled
            * @type L5.tree.TreeDragZone
            */
            this.dragZone = new L5.tree.TreeDragZone(this, this.dragConfig || {
               ddGroup: this.ddGroup || "TreeDD",
               scroll: this.ddScroll
           });
        }
        this.getSelectionModel().init(this);
    },

    // private
    afterRender : function(){
        L5.tree.L5TreePanel.superclass.afterRender.call(this);
        this.root.render();
        if(this.root.attributes.showType=== 'checkbox')//如果为checkbox才执行onCheckChange
        	this.root.ui.onCheckChange(true);//将根节点的record加到checks里去
        if(!this.rootVisible){
            this.root.renderChildren();
        }
    },
	
	getDataSetEventDispacher : function(){
		return this.dataset.getDispacherById(this.getId());
	},
	
    onDestroy : function(){
        if(this.rendered){
            this.body.removeAllListeners();
            L5.dd.ScrollManager.unregister(this.body);
            if(this.dropZone){
                this.dropZone.unreg();
            }
            if(this.dragZone){
               this.dragZone.unreg();
            }
        }
        this.root.destroy();
        this.nodeHash = null;
		
		
		if(this.dataset){//解除绑定
			this.dataset.removeDispacherById(this.getId());
		}
		this.dataset = null;
		this.nodeBuilder.destroy();
		this.nodeBuilder = null;
		
		
        L5.tree.L5TreePanel.superclass.onDestroy.call(this);
    }
	
});
L5.tree.L5TreePanel.nodeTypes = {};
L5.reg('lstreepanel', L5.tree.L5TreePanel);