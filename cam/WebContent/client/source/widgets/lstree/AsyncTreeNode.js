/**
 * @class L5.tree.L5AsyncTreeNode
 * @extends L5.tree.TreeNode
 * @constructor
 * @param {Object/String} attributes The attributes/config for the node or just a string with the text for the node 
 */
//TODO 给treerecord.load添加回调方法
L5.tree.L5AsyncTreeNode = function(config){
    this.loaded = config && config.loaded === true;
    this.loading = false;
    L5.tree.L5AsyncTreeNode.superclass.constructor.apply(this, arguments);
    /**
    * @event beforeload
    * Fires before this node is loaded, return false to cancel
    * @param {Node} this This node
    */
    this.addEvents('beforeload', 'load');
    /**
    * @event load
    * Fires when this node is loaded
    * @param {Node} this This node
    */
};
L5.extend(L5.tree.L5AsyncTreeNode, L5.tree.TreeNode, {
    expand : function(deep, anim, callback){
        if(this.loading){ // if an async load is already running, waiting til it's done
            var timer;
            var f = function(){
                if(!this.loading){ // done loading
                    clearInterval(timer);
                    this.expand(deep, anim, callback);
                }
            }.createDelegate(this);
            timer = setInterval(f, 200);
            return;
        }
        if(!this.loaded){
			/**
			 * 使用record加载数据
			 */
			var record = this.record;
			//如果record正在加载数据,设置200ms的间隔检查时间，每隔200ms检查一次loading:如果loading=false，表示前一次加载完成，调用expand方法执行新一次加载
			if(record.loading==true){
				var timer;
	            var f = function(){
	                if(!record.loading){ // 前一次加载完成后(loading被设置为false)，清空间隔检查时间(即不再检查)，再调用expand方法执行新一次加载
	                    clearInterval(timer);
	                    this.expand(deep, anim, callback);
	                }
	            }.createDelegate(this);
	            timer = setInterval(f, 200);//每隔200sm执行f函数
	            return;
			}
			if(record.hasSynData()){//如果存在需要同步的数据,加载数据
				this.loading = true;
				this.ui.beforeLoad(this);
				record.load({
					callback:this.loadComplete.createDelegate(this, [deep, anim, callback])
				});//加载全部数据,暂时不支持分页
			} else {//如果不存在需要同步的数据
				this.loading = true;
				this.ui.beforeLoad(this);
				var count = record.getCount();
				var chnodesize = this.childNodes.length;
				if(chnodesize==0&&count!=chnodesize){//不同的dataset可以被多个树共享
										//因此,可能dataset中存在record,而当前的树却没有节点
					this.ownerTree.getDataSetEventDispacher().fireEvent('add',record,record.getChildren(),0,count);
				}
				this.loading = false;
				this.loaded = true;
				this.ui.afterLoad(this);
				L5.tree.L5AsyncTreeNode.superclass.expand.call(this, deep, anim, callback);
			}
			return;
        }
        L5.tree.L5AsyncTreeNode.superclass.expand.call(this, deep, anim, callback);
    },
    
    /**
     * Returns true if this node is currently loading
     * @return {Boolean}
     */
    isLoading : function(){
        return this.loading;  
    },
    
    loadComplete : function(deep, anim, callback){
        this.loading = false;
        this.loaded = true;
        this.ui.afterLoad(this);
        this.expand(deep, anim, callback);
    },
    
    /**
     * Returns true if this node has been loaded
     * @return {Boolean}
     */
    isLoaded : function(){
        return this.loaded;
    },
    
    hasChildNodes : function(){
        if(!this.isLeaf() && !this.loaded){
            return true;
        }else{
            return L5.tree.L5AsyncTreeNode.superclass.hasChildNodes.call(this);
        }
    }
});

L5.tree.L5TreePanel.nodeTypes.async = L5.tree.L5AsyncTreeNode;