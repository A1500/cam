/**
 * 处理DataSet的事件，转化为对treepanel的操作
 * 目前暂不考虑分页的实现
 * @param {Object} tree
 */
L5.tree.DataSetEventObserver = function(tree){
	this.closed = false;//用来标识当前DataSetEventObserver是否有效,如果closed为true,说明TreePanel已经销毁了
						//则TreePanel不应当继续处理treerecord事件
	this.tree = tree;
	this.id = tree.id;
	this.addEvents(
		'rootchange',
		'loaderinit',
		'beforebatchload',
		'batchload',
		'batchloadexception',
		'add',
		'update',
		'remove',
		'sort',
		'beforeload',
		'load',
		'loadexception'
	);
	L5.tree.DataSetEventObserver.superclass.constructor.call(this);
	this.initHandler();
};
L5.extend(L5.tree.DataSetEventObserver, L5.util.Observable,{
	fireEvent : function (){
		if(this.closed){
			return false;
		}
		var nodeHash = this.tree.nodeHash;
		if(nodeHash==null){
			this.closed = true;
			return false;
		}
		return L5.tree.DataSetEventObserver.superclass.fireEvent.apply(this,arguments);
	},
	
	initHandler : function(){
		this.on('rootchange',this.OnRootChange,this);
		this.on('add',this.OnRecordAdd,this);
		this.on('update',this.OnRecordUpdate,this);
		this.on('remove',this.OnRecordRemove,this);
		this.on('sort',this.OnRecordSort,this);
		this.on('beforeload',this.OnBeforeload,this);
		this.on('load',this.OnLoad,this);
		this.on('loadexception',this.OnLoadexception,this);
	},
	
	OnRootChange : function(oldrec,newrec){
		this.tree.setRootNode(newrec);
	},
	
	/**
	 * 增加子record时需要同步刷新树形节点
	 * 获取parent对应的node
	 * 	如果没有,说明父节点不存在,用户还没有展开到这一级,直接返回
	 * 	如果存在,说明父节点已经展开过了,因此可以添加新的节点
	 *  获取节点插入的位置
	 *  对每一个需要增加的record
	 *  	构建node
	 *  	将node插入到父节点的指定位置之前
	 * @param {TreeRecord} parent
	 * @param {Array TreeRecord} recs
	 * @param {int} index
	 * @param {int} insetnums
	 */
	OnRecordAdd : function(parent,recs,index,insertnums){
		var builder = this.tree.getNodeBuilder();
		var pnode = this.getNodeByRecord(parent);
		if(!pnode){
			return;
		}
		//增加节点时设置其父节点为非叶子节点:pnode.leaf和pnode.ui.wasLeaf为false(叶子节点不会被刷新，增加的节点无法展现)
		pnode.leaf=false;
		pnode.ui.wasLeaf=false;
		var before = pnode.item(index);
		if(!before){//暂时不考虑分页节点等情况的处理
			before = null;
		}
		pnode.beginUpdate();
		var len = recs.length;
		var curnode;
		var i=0;
		while(i<len){
			var rec = recs[i];
			i++;
			curnode = this.getNodeByRecord(rec);
			if(curnode){//相同的id时,略过不处理
				continue;
			}
			curnode = builder.createNode(rec);
			pnode.insertBefore(curnode,before);
		}
		pnode.endUpdate();
	},
	
	/**
	 * 修改record,一般都是对应修改树形节点的显示文本,复杂一点的可能修改成checkbox,这点需要考量
	 * 首先根据record寻找对应的node
	 * 然后根据
	 * @param {Object} record
	 * @param {Object} modify
	 * @param {Object} status
	 */
	OnRecordUpdate : function(record,modify,status){
		if(status==L5.model.Record.COMMIT){//如果是提交,由于以前已经更新过节点,因此直接返回
			return;
		}
		var builder = this.tree.getNodeBuilder();
		var node = this.getNodeByRecord(record);
		if(!node){
			return;
		}
		//最省事儿的办法是删除节点,再创建一个新的节点
		var nodemodel = builder.getNodeModel(record);
		for(var key in modify){
			nodemodel.refreshNodeWithField(node,key,record);
		}
	},
	
	/**
	 * 需要移除节点
	 * 如果是移除全部的节点,先收缩节点,然后移除所有的节点
	 * @param {Object} parent
	 * @param {Object} recs
	 * @param {Object} index
	 */
	OnRecordRemove : function(parent,recs,index){
		var pnode = this.getNodeByRecord(parent);
		if(!pnode){
			return;
		}
		var count = pnode.childNodes.length;

		if(count==recs.length){//删除全部节点
			pnode.collapse(false, false);
			while(pnode.firstChild){
				pnode.removeChild(pnode.firstChild).destroy();
			}
			pnode.childrenRendered = false;
			pnode.loaded = false;
			if(pnode.isHiddenRoot()){
				pnode.expanded = false;
			}
		} else {//删除部分节点
			for(var i=0,len=recs.length;i<len;i++){
				var rec = recs[i];
				var curnode = this.getNodeByRecord(rec);
				if(curnode){
					pnode.removeChild(curnode);
				}
			}
		}
		
		//处理当前节点
		var selectnode = this.tree.curNode;
		if(selectnode!==pnode){
			pnode.nodeModel.onNodeSelected(pnode);//父节点被选中
		}
	},
	
	/**
	 * sort其实相当于removeAll，然后insert,不过这样节点刷新的代价比较大
	 * @param {Object} parent
	 * @param {Object} recs
	 * @param {Object} index
	 */
	OnRecordSort : function(parent,recs,index){
		var builder = this.tree.getNodeBuilder();
		var pnode = this.getNodeByRecord(parent);
		if(!pnode){
			return;
		}
		var count = parent.getCount();
		
		var expand = pnode.expanded || false;
		pnode.collapse(false, false);//收缩节点
		pnode.childrenRendered = false;
		
		var end = recs.length+index-1;
		var start = index;
		for(var i=end;i>=start;i--){//移除节点
			pnode.removeChild(pnode.item(i)).destroy();
		}
		
		var posnode = pnode.item(index);
		for(var i=0,len=recs.length;i<len;i++){//增加节点
			var curnode = builder.createNode(recs[i]);
			pnode.insertBefore(curnode,posnode);
		}
		if(expand)
			pnode.expand(false,false);//展开节点
	},
	
	OnBeforeload : function(loader,rec){
		
	},
	
	OnLoad : function(loader,rec,reponse){
		
	},
	
	OnLoadexception : function(loader,rec,reponse){
		
	},
	
	OnBeforebatchLoad : function(){
		
	},
	
	OnBatchLoad : function(){
		
	},
	
	OnBatchLoadexception : function(){
		
	},
	
	getNodeByRecord : function(record){
		var builder = this.tree.getNodeBuilder();
		var nodeid = builder.getNodeIdByRecId(record.id);
		var node = this.tree.getNodeById(nodeid);
		return node;
	}
});