//doc
/**
 * @class L5.tree.TreeNode
 * @extends L5.model.Node 
 */
/**
 * @ignore
 * @cfg {String} text The text for this node
 * @cfg {Boolean} expanded true to start the node expanded
 * @cfg {Boolean} allowDrag False to make this node undraggable if {@link #draggable} = true (defaults to true)
 * @cfg {Boolean} allowDrop False if this node cannot have child nodes dropped on it (defaults to true)
 * @cfg {Boolean} disabled true to start the node disabled
 * @cfg {String} icon The path to an icon for the node. The preferred way to do this
 * is to use the cls or iconCls attributes and add the icon via a CSS background image.
 * @cfg {String} cls A css class to be added to the node
 * @cfg {String} iconCls A css class to be added to the nodes icon element for applying css background images
 * @cfg {String} href URL of the link used for the node (defaults to #)
 * @cfg {String} hrefTarget target frame for the link
 * @cfg {String} qtip An L5 QuickTip for the node
 * @cfg {Boolean} expandable If set to true, the node will always show a plus/minus icon, even when empty
 * @cfg {String} qtipCfg An L5 QuickTip config for the node (used instead of qtip)
 * @cfg {Boolean} singleClickExpand True for single click expand on this node
 * @cfg {Function} uiProvider A UI <b>class</b> to use for this node (defaults to L5.tree.TreeNodeUI)
 * @cfg {Boolean} checked True to render a checked checkbox for this node, false to render an unchecked checkbox
 * (defaults to undefined with no checkbox rendered)
 * @cfg {Boolean} draggable True to make this node draggable (defaults to false)
 * @cfg {Boolean} isTarget False to not allow this node to act as a drop target (defaults to true)
 * @cfg {Boolean} allowChildren False to not allow this node to have child nodes (defaults to true)
 * @cfg {Boolean} checkedOnDblClick 双击节点时实现单选多选的选中效果
 * @constructor
 * @param {Object/String} attributes The attributes/config for the node or just a string with the text for the node
 */
L5.tree.TreeNode = function(attributes){
    attributes = attributes || {};
    if(typeof attributes == "string"){
        attributes = {text: attributes};
    }
	if(!attributes.singleClickExpand){
		attributes.singleClickExpand = true;
	}
    this.childrenRendered = false;
    this.rendered = false;
    L5.tree.TreeNode.superclass.constructor.call(this, attributes);
    this.expanded = attributes.expanded === true;
    this.isTarget = attributes.isTarget !== false;
    this.draggable = attributes.draggable !== false && attributes.allowDrag !== false;
    this.allowChildren = attributes.allowChildren !== false && attributes.allowDrop !== false;

    /**
     * 节点的文本，只读属性，可以使用setText()方法修改
     * @type String
     */
    this.text = attributes.text;
    /**
     * @ignore
     * True if this node is disabled.
     * @type Boolean
     */
    this.disabled = attributes.disabled === true;
    
    this.changeParent = true;
    if(attributes.changeParent !=undefined){
    	if((typeof attributes.changeParent)=='string'){
    		this.changeParent = attributes.changeParent==='true';
    	}else if((typeof attributes.changeParent)=='boolean'){
    		this.changeParent = attributes.changeParent===true;
    	}
    }
    this.addEvents(
        /**
        * @event textchange
        * 节点文本被改变时触发
        * @param {Node} this 当前节点
        * @param {String} text 新文本
        * @param {String} oldText 原文本
        */
        "textchange",
        /**
        * @event beforeexpand
        * 节点被展开之前触发，返回false表示取消
        * @param {Node} this 当前节点
        * @param {Boolean} deep
        * @param {Boolean} anim
        */
        "beforeexpand",
        /**
        * @event beforecollapse
        * 节点被收缩之前触发，返回false表示取消
        * @param {Node} this 当前节点
        * @param {Boolean} deep
        * @param {Boolean} anim
        */
        "beforecollapse",
        /**
        * @event expand
        * 节点被展开时触发
        * @param {Node} this 当前节点
        */
        "expand",
        /**
        * @ignore
        * @event disabledchange
        * Fires when the disabled status of this node changes
        * @param {Node} this This node
        * @param {Boolean} disabled
        */
        "disabledchange",
        /**
        * @event collapse
        * 节点被收缩时触发
        * @param {Node} this 当前节点
        */
        "collapse",
        /**
        * @event beforeclick
        * 点击处理之前被触发，返回false表示取消默认操作
        * @param {Node} this 当前节点
        * @param {L5.EventObject} e 事件对象
        */
        "beforeclick",
        /**
        * @event click
        * 节点被点击时触发
        * @param {Node} this 当前节点
        * @param {L5.EventObject} e 事件对象
        */
        "click",
        /**
        * @event checkchange
        * 带有checkbox的节点的选中属性被改变时触发
        * @param {Node} this 当前节点
        * @param {Boolean} checked
        */
        "checkchange",
        /**
        * @event dblclick
        * 节点被双击时触发
        * @param {Node} this 当前节点
        * @param {L5.EventObject} e 事件对象
        */
        "dblclick",
        /**
        * @event contextmenu
        * 节点被右击时触发
        * @param {Node} this 当前节点
        * @param {L5.EventObject} e 事件对象
        */
        "contextmenu",
        /**
        * @ignore
        * @event beforechildrenrendered
        * Fires right before the child nodes for this node are rendered
        * @param {Node} this This node
        */
        "beforechildrenrendered"
    );

    var uiClass = this.attributes.uiProvider || this.defaultUI || L5.tree.TreeNodeUI;

    /**
     * 节点UI，只读属性
     * @type TreeNodeUI
     */
    this.ui = new uiClass(this);
};
L5.extend(L5.tree.TreeNode, L5.model.Node, {
    preventHScroll: true,
    /**
     * Returns true if this node is expanded
     * @return {Boolean}
     */
    isExpanded : function(){
        return this.expanded;
    },

/**
 * 返回节点UI对象
 * @return {TreeNodeUI} TreeNodeUI对象为节点提供用户界面。
 * 除非另有规定{@link #uiProvider}，否则就是一个{@link L5.tree.TreeNodeUI}实例
 */
    getUI : function(){
        return this.ui;
    },

    // private override
    setFirstChild : function(node){
        var of = this.firstChild;
        L5.tree.TreeNode.superclass.setFirstChild.call(this, node);
        if(this.childrenRendered && of && node != of){
            of.renderIndent(true, true);
        }
        if(this.rendered){
            this.renderIndent(true, true);
        }
    },

    // private override
    setLastChild : function(node){
        var ol = this.lastChild;
        L5.tree.TreeNode.superclass.setLastChild.call(this, node);
        if(this.childrenRendered && ol && node != ol){
            ol.renderIndent(true, true);
        }
        if(this.rendered){
            this.renderIndent(true, true);
        }
    },

    // these methods are overridden to provide lazy rendering support
    // private override
    appendChild : function(n){
        var node = L5.tree.TreeNode.superclass.appendChild.call(this, n);
        if(node && this.childrenRendered){
            node.render();
        }
        this.ui.updateExpandIcon();
        return node;
    },

    // private override
    removeChild : function(node){
        this.ownerTree.getSelectionModel().unselect(node);
        L5.tree.TreeNode.superclass.removeChild.apply(this, arguments);
        // if it's been rendered remove dom node
        if(this.childrenRendered){
            node.ui.remove();
        }
        if(this.childNodes.length < 1){
            this.collapse(false, false);
        }else{
            this.ui.updateExpandIcon();
        }
        if(!this.firstChild && !this.isHiddenRoot()) {
            this.childrenRendered = false;
        }
        return node;
    },

    // private override
    insertBefore : function(node, refNode){
        var newNode = L5.tree.TreeNode.superclass.insertBefore.apply(this, arguments);
        if(newNode && refNode && this.childrenRendered){
            node.render();
        }
        this.ui.updateExpandIcon();
        return newNode;
    },

    /**
     * 设置节点文本
     * @param {String} text
     */
    setText : function(text){
        var oldText = this.text;
        this.text = text;
        this.attributes.text = text;
        if(this.rendered){ // event without subscribing
            this.ui.onTextChange(this, text, oldText);
        }
        this.fireEvent("textchange", this, text, oldText);
    },

    /**
     * @ignore
     * Triggers selection of this node
     */
    select : function(){
        this.getOwnerTree().getSelectionModel().select(this);
    },

    /**
     * @ignore 
     * Triggers deselection of this node
     */
    unselect : function(){
        this.getOwnerTree().getSelectionModel().unselect(this);
    },

    /**
     * 返回节点是否被选中，true表示选中
     * @return {Boolean}
     */
    isSelected : function(){
        return this.getOwnerTree().getSelectionModel().isSelected(this);
    },

    /**
     * 展开节点
     * @param {Boolean} deep (可选) true表示展开节点以及所有子节点
     * @param {Boolean} anim (可选) false表示取消默认动画
     * @param {Function} callback (可选) 回调函数(包含一个参数，表示该节点)，当展开这个节点时回调。
     */
    expand : function(deep, anim, callback){
        if(!this.expanded){
            if(this.fireEvent("beforeexpand", this, deep, anim) === false){
                return;
            }
            if(!this.childrenRendered){
                this.renderChildren();
            }
            this.expanded = true;
            if(!this.isHiddenRoot() && (this.getOwnerTree().animate && anim !== false) || anim){
                this.ui.animExpand(function(){
                    this.fireEvent("expand", this);
                    if(typeof callback == "function"){
                        callback(this);
                    }
                    if(deep === true){
                        this.expandChildNodes(true);
                    }
                }.createDelegate(this));
                return;
            }else{
                this.ui.expand();
                this.fireEvent("expand", this);
                if(typeof callback == "function"){
                    callback(this);
                }
            }
        }else{
           if(typeof callback == "function"){
               callback(this);
           }
        }
        if(deep === true){
            this.expandChildNodes(true);
        }
    },
    
    /**
     * 是否隐藏根节点
     */
    isHiddenRoot : function(){
        return this.isRoot && !this.getOwnerTree().rootVisible;
    },

    /**
     * 收缩节点.
     * @param {Boolean} deep (可选) true表示收缩节点以及所有子节点
     * @param {Boolean} anim (可选) false表示取消默认动画
     */
    collapse : function(deep, anim){
        if(this.expanded && !this.isHiddenRoot()){
            if(this.fireEvent("beforecollapse", this, deep, anim) === false){
                return;
            }
            this.expanded = false;
            if((this.getOwnerTree().animate && anim !== false) || anim){
                this.ui.animCollapse(function(){
                    this.fireEvent("collapse", this);
                    if(deep === true){
                        this.collapseChildNodes(true);
                    }
                }.createDelegate(this));
                return;
            }else{
                this.ui.collapse();
                this.fireEvent("collapse", this);
            }
        }
        if(deep === true){
            var cs = this.childNodes;
            for(var i = 0, len = cs.length; i < len; i++) {
            	cs[i].collapse(true, false);
            }
        }
    },

    // private
    delayedExpand : function(delay){
        if(!this.expandProcId){
            this.expandProcId = this.expand.defer(delay, this);
        }
    },

    // private
    cancelExpand : function(){
        if(this.expandProcId){
            clearTimeout(this.expandProcId);
        }
        this.expandProcId = false;
    },

    /**
     * @ignore
     * Toggles expanded/collapsed state of the node
     */
    toggle : function(){
        if(this.expanded){
            this.collapse();
        }else{
            this.expand();
        }
    },

    /**
     * @ignore
     * Ensures all parent nodes are expanded, and if necessary, scrolls
     * the node into view.
     * @param {Function} callback (optional) A function to call when the node has been made visible.
     */
    ensureVisible : function(callback){
        var tree = this.getOwnerTree();
        tree.expandPath(this.parentNode ? this.parentNode.getPath() : this.getPath(), false, function(){
            var node = tree.getNodeById(this.id);  // Somehow if we don't do this, we lose changes that happened to node in the meantime
            tree.getTreeEl().scrollChildIntoView(node.ui.anchor);
            L5.callback(callback);
        }.createDelegate(this));
    },

    /**
     * 展开所有子节点
     * @param {Boolean} deep (可选) true表示子节点的所有子节点也要展开
     */
    expandChildNodes : function(deep){
        var cs = this.childNodes;
        for(var i = 0, len = cs.length; i < len; i++) {
        	cs[i].expand(deep);
        }
    },

    /**
     * 收缩所有子节点
     * @param {Boolean} deep (可选) true表示子节点的所有子节点也要收缩
     */
    collapseChildNodes : function(deep){
        var cs = this.childNodes;
        for(var i = 0, len = cs.length; i < len; i++) {
        	cs[i].collapse(deep);
        }
    },

    /**
     * 禁用此节点
     */
    disable : function(){
        this.disabled = true;
        this.unselect();
        if(this.rendered && this.ui.onDisableChange){ // event without subscribing
            this.ui.onDisableChange(this, true);
        }
        this.fireEvent("disabledchange", this, true);
    },

    /**
     * 启用此节点
     */
    enable : function(){
        this.disabled = false;
        if(this.rendered && this.ui.onDisableChange){ // event without subscribing
            this.ui.onDisableChange(this, false);
        }
        this.fireEvent("disabledchange", this, false);
    },

    // private
    renderChildren : function(suppressEvent){
        if(suppressEvent !== false){
            this.fireEvent("beforechildrenrendered", this);
        }
        var cs = this.childNodes;
        var parentChecked = this.attributes.checked;
		
        for(var i = 0, len = cs.length; i < len; i++){
            cs[i].render(true);
            /*
             * 修改bug：当allowCheck为false的时候父节点选中，初始展开子节点，子节点也会被选中，特修正此bug
             */
            var allowCheck=this.getOwnerTree().allowCheck;
            if(L5.type(allowCheck)=="function")//如果是函数就取返回值，参数是当前子节点和当前节点
    			allowCheck=allowCheck(cs[i],cs[i].parentNode);
    		if(allowCheck===undefined){//默认是只选择同一种类型的
    			var nodemodel = cs[i].nodeModel;
        		var pnodemodel = cs[i].parentNode?cs[i].parentNode.nodeModel:cs[i].nodeModel;
    			allowCheck=(nodemodel==pnodemodel);
    		}
            
            
            if(parentChecked == true && allowCheck && cs[i].attributes.showType=== 'checkbox')//如果父节点是选中状态则子节点也全部选中
            	cs[i].ui.toggleCheck(true,true);
//            if(cs[i].attributes.showType=== 'checkbox')//如果子节点的类型是checkbox才执行onCheckChange
//            	cs[i].ui.onCheckChange(true);//子节点的record添加到checks里去
        }
        this.childrenRendered = true;
    },

    // private
    sort : function(fn, scope){
        L5.tree.TreeNode.superclass.sort.apply(this, arguments);
        if(this.childrenRendered){
            var cs = this.childNodes;
            for(var i = 0, len = cs.length; i < len; i++){
                cs[i].render(true);
            }
        }
    },

    // private
    render : function(bulkRender,amin){
        this.ui.render(bulkRender);
        if(!this.rendered){
            // make sure it is registered
            this.getOwnerTree().registerNode(this);
            this.rendered = true;
            if(this.expanded){
                this.expanded = false;
                this.expand(false, amin||false);
            }
        }
    },

    // private
    renderIndent : function(deep, refresh){
        if(refresh){
            this.ui.childIndent = null;
        }
        this.ui.renderIndent();
        if(deep === true && this.childrenRendered){
            var cs = this.childNodes;
            for(var i = 0, len = cs.length; i < len; i++){
                cs[i].renderIndent(true, refresh);
            }
        }
    },

    beginUpdate : function(){
        this.childrenRendered = false;
    },

    endUpdate : function(){
        if(this.expanded && this.rendered){
            this.renderChildren();
        }
    },

    destroy : function(){
        if(this.childNodes){
	        for(var i = 0,l = this.childNodes.length; i < l; i++){
	            this.childNodes[i].destroy();
	        }
            this.childNodes = null;
        }
        if(this.ui.destroy){
            this.ui.destroy();
        }
    }
});

L5.tree.L5TreePanel.nodeTypes.node = L5.tree.TreeNode;