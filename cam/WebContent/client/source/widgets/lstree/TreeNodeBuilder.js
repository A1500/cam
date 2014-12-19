/**
 * 负责node的创建,
 * 根据nodemodel、record生成node的构造函数的参数,然后生成node
 * 同时保证node与record之间的一一对应关系,node.id = treeid + '_' +record.id
 */
L5.tree.TreeNodeBuilder = function(treeid,config){
	this.treeid = treeid;
	config = config || {};
	if(config.getNodeModelByType){
		this.nodeModelMgr = config;
	} else {
		this.nodeModelMgr = new L5.tree.NodeModelMgr(config);
	}
};
(function(){
	var proto = L5.tree.TreeNodeBuilder.prototype;
	
	/**
	 * 根据record创建treenode
	 * @param {Object} rec
	 */
	proto.createNode = function(rec){
		var nodemoel = this.nodeModelMgr.getNodeModel(rec);
		var attr = nodemoel.buildAttribute(rec);
		attr.id = this.getNodeIdByRecId(rec.id);
		var node = new L5.tree.L5AsyncTreeNode(attr);
		node.record = rec;
		node.nodeModel = nodemoel;
		return node;
	};
	
	/**
	 * 获取nodeid
	 * @param {Object} recid
	 */
	proto.getNodeIdByRecId = function(recid){
		return this.treeid + "_"+recid;
	};
	
	/**
	 * 
	 * @param {Object} record
	 */
	proto.getNodeModel = function(record){
		return this.nodeModelMgr.getNodeModel(record);
	};
	
	/**
	 * 注册节点模型
	 * @param {Object} nodemodel
	 */
	proto.registNodeModel = function(nodemodel){
		this.nodeModelMgr.register(nodemodel);
	};
	
	proto.destroy = function(){
		this.nodeModelMgr.destroy();
		delete this.nodeModelMgr;
	}
})();
