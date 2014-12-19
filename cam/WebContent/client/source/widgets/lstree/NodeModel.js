//doc
/**
 * @ignore
 * 节点模型,描述树的一个节点的显示信息，类似于L5 grid的columnmodel
 * 对于一颗树来说，节点类型不会很多，将原来在L5 treenode中的一些信息放到nodemodel中有利于降低内存消耗
 * 目前来看，L5 treenode中的各种配置都需要挪到nodemodel中
 * tree根据节点提供的recordType查询NodeModelMgr来获取nodemodel
 * 	var record = record1;
 * 	var ndmdl = nodeModelMgr.getNodeModel(record);
 * tree使用NodeModelMgr来解析其配置项nodes的值
 * 
 * NodeModel的配置项可以从后台取值，也可以从前台配置,比如icon，我们可以配置
 * icon:'d:/img/node.jpg'，也可以配置icon:'deptImg'，
 * text:'部门'，也可以配置text:'struName'
 * 另一方面，我们还可以根据record来组合某些属性，比如节点的描述信息text，我们可以配置为
 * text:function(record){
 * 	return record.get("struName")+'部门,'+record.get("struCorpration")+'公司';
 * }
 */

/**
 * @ignore
 * 配置示例:
 * 简单的配置:
 * {
 * 	recordType : L5.tree.SimpleTreeRecord,
 * 	attrs : {
 * 		text : "struName",
 * 		icon : '/a/b/c.jpg'
 * 	},
 * 	renderer : function(){
 * 	},
 * 	listeners:{
 * 	}
 * }
 * 复杂的配置
 * {
 * 	recordType : L5.tree.SimpleTreeRecord,
 * 	attrs :[{
 * 		name : 'text',
 * 		mapping : 'struName',
 * 		hanlder : function(record){}
 * 	},{
 * 		name : 'icon',
 * 		handler : '/a/b/c.jpg'
 * 	},{
 * 		name : 'href',
 * 		mapping :'struName,struId'
 * 		handler : '',
 * 	}],
 * 	renderer : function(){
 * 	},
 * 	listeners : {
 * 	}
 * }
 * @param {TreeRecord||string} recordType
 * @param {Object} attrs
 */

(function(){
/**
 * @ignore
 * 节点属性模型
 * 配置
 * 1
 * 	text:'1'
 * 	text:'stru'
 * 2
 * 	{
 * 		name : 'text',
 * 		mapping : 'struName',
 * 		hanlder : function(record){}
 * 	}
 */
L5.tree.NodeFieldModel = function(name,handler){
	this.name = name;
	if(handler){
		this.handleRecord = handler;
	}
}
L5.tree.NodeFieldModel.prototype = {
	handleRecord : function(record){
		return record.get(this.name);
	},
	
	handleNode : function(node,value){
		node.attributes[name] = value;
		node[name] = value;
	}
}
//默认的映射配置
var baseattrs = [
	{name : "text"},
	{name : "expanded"},
	{name : "allowDrag"},
	{name : "allowDrop"},
	{name : "disabled"},
	{name : "icon"},
	{name : "cls"},
	{name : "iconCls"},
	{name : "href"},
	{name : "hrefTarget"},
	{name : "qtip"},
	{name : "expandable"},
	{name : "qtipCfg"},
	{name : "singleClickExpand"},
	{name : "uiProvider"},
	{name : "checked"},
	{name : "draggable"},
	{name : "isTarget"},
	{name : "allowChildren"}
];

/**
 * @ignore
 * @cfg L5.tree.TreeRecord Class recordType
 * @cfg Object\Array attrs  {leaf:'struLeaf',text:'struName'}
 * 		[
 * 			{name:'text',handler : 'struName'},
 * 			{name:'leaf',handler:true},
 * 			{},
 * 		]
 * 	可配置的属性与L5.tree.TreeNode的cfg配置属性一样
 * @cfg string binding 模型绑定的dom组件id,目前只支持dom组件id
 * @cfg listeners 监听器
 */
/**
 * @class L5.tree.NodeModel
 * @extends L5.util.Observable
 * @cfg {String} text 节点文本
 * @cfg {Boolean} expanded true表示启动节点的展开
 * @cfg {Boolean} disabled true表示启动节点禁用
 * @cfg {String} icon 节点图标路径，首选方式是使用cls或iconCls属性和通过css背景图片方式增加图标
 * @cfg {String} cls 添加到节点上的css类
 * @cfg {String} iconCls 通过采用css背景图片方式添加到节点图标元素的css类
 * @cfg {String} href 节点所使用链接的URL(默认为#)
 * @cfg {Boolean} expandable 如果设置为true，节点将总是显示一个+或-图标，即使节点为空
 * @cfg {Boolean} singleClickExpand true表示点击即可展开节点
 * @cfg {Function} uiProvider 节点的UI <b>class</b>(默认为L5.tree.TreeNodeUI)
 * @cfg {Boolean} checked true表示节点展现为一个选中的checkbox，false表示节点展现为一个未选择的checkbox
 * (默认为undefined表示没有checkbox)
 * @cfg {Boolean} allowChildren false表示不允许节点包含子节点(默认为true)
 */
/**
 * @ignore
 * 
 * @cfg {Boolean} allowDrag False to make this node undraggable if {@link #draggable} = true (defaults to true)
 * @cfg {Boolean} allowDrop False if this node cannot have child nodes dropped on it (defaults to true)
 * @cfg {String} qtip An L5 QuickTip for the node
 * @cfg {String} qtipCfg An L5 QuickTip config for the node (used instead of qtip)
 * @cfg {String} hrefTarget target frame for the link
 * @cfg {Boolean} draggable True to make this node draggable (defaults to false)
 * @cfg {Boolean} isTarget False to not allow this node to act as a drop target (defaults to true)
 */
L5.tree.NodeModel = function(config){
 //* @cfg renderer 还未实现
	config = config || {};
	var rec = config.recordType||L5.tree.SimpleTreeRecord;
	if(typeof rec == 'string'){
		rec = L5.tree.TreeRecord.recordTypes[rec];
	}
	var rectype = rec.recordType;
	var attrs = config.attrs;
	if(!attrs){
		attrs = baseattrs;
		rec = L5.tree.SimpleTreeRecord;
		rectype = L5.tree.SimpleTreeRecord.recordType;
	}
	
	this.record = rec;
	this.recordType = rectype;
	this.render = config.render;//注意:以后将NodeModel与NodeUi合并的时候会起作用
	this.listeners = config.listeners;
	this.binding = config.binding;
	
	this.fieldModels = new L5.util.MixedCollection(false, function(fieldModel){
		return fieldModel.name;
	});
	this.recordMapping = {};//{struName:['leaf','text']}
	
	//创建FieldModel
	if(L5.isArray(attrs)){
		//[{name:'leaf',mapping:'struLeaf',hanlder:function(){}},{name:'leaf',handler:'leaf'},{name:'leaf',handler:true}]
		for(var i=0,len=attrs.length;i<len;i++){
			var cfg = attrs[i];
			var fdmodel = this.createFieldModel(cfg);
			if(fdmodel!=null){
				this.fieldModels.add(fdmodel);
			}
		}
	}	else {
		for(var nodeprop in attrs){
			var fdname = attrs[nodeprop];
			if(fdname==undefined||fdname==null||fdname===""){
				continue;
			}
			var cfg = {name:nodeprop,handler:fdname};
			var fdmodel = this.createFieldModel(cfg);
			if(fdmodel!=null){
				this.fieldModels.add(fdmodel);
			}
		}
	}
	this.dealFieldModel();
	
	this.addEvents(
	//理论上应该将treepanel中的所有事件都交给这里处理,不过暂时看来,只有节点选中/右键是常用功能
	//可能拖拽也会用到,暂不考虑
		/**
		 * @ignore
		 * 节点选中前事件
		 * oldrec
		 * currec
		 * oldnode
		 * node
		 */
		'beforeselected',
		/**
		 * @ignore
		 * 选中事件
		 * record
		 * node
		 */
		'selected',
		/**
		 * @ignore
		 * record
		 * modify field
		 * mapping modify node propertys
		 * node
		 */
		'update',
		/**
		 * @ignore
		 * 右键事件
		 * record
		 * e
		 * node
		 */
		'contextmenu'
//		,'beforerender'
	);
	
	L5.tree.NodeModel.superclass.constructor.call(this);
	
		if(this.binding){
			L5.tree.FormBinding(this,this.binding);
		}
};

var getFixvalue = function(record){
	return this.value;
};
var getFieldValue = function(record){
	return record.get(this.fdName);
};

var texthandleNode = function(node,value){
	node.setText(value);
};
var disabledhandleNode = function(node,value){
	node.attributes[name] = value;
	node[name] = value;
	if(value){
		node.disable();
	} else {
		node.enable();
	}
};
var checkedhandleNode = function(node,value){
	node.attributes[name] = value;
	node[name] = value;
	if(node.rendered){
		node.ui.toggleCheck(value);
	}
};
var handleNodefuncs = {//处理node属性的函数,每个属性一个
		text : texthandleNode,
		disabled : disabledhandleNode,
		checked : checkedhandleNode

//	下面这些属性,没有展现效果,因此使用默认的处理方式,
//		expandable :expandable,
//		expanded : expanded,
//		allowDrag : allowDrag,
//		allowDrop : allowDrop,
//		href : href,
//		hrefTarget : hrefTarget,
//		qtip : qtip,
//		singleClickExpand : singleClickExpand,
//		isTarget : isTarget,
//这些属性用户最好不要动态改变
//		cascadeChecked : cascadeChecked,
//		showType : showType,
//		draggable : draggable,
//		allowChildren : allowChildren,
//		iconCls : iconClshandleNode,
//		cls : clshandleNode,
//		icon : iconhandleNode,
//		qtipCfg : qtipCfg,
//		uiProvider : uiProvider,
};

//未来可以将TreeNodeUi的功能转移到NodeModel
L5.extend(L5.tree.NodeModel,L5.util.Observable,{
	/**
	 * @ignore 
	 * 创建field模型
	 * {name:'text',mapping:'struName',handler:function(rec){}}
	 * {name:'text',mapping:'struName'}
	 * {name:'text',handler:true}
	 * {name:'text',handler:'struName'}
	 */
	createFieldModel : function(config){
		var nodeprop = config.name;
		if(!nodeprop){
			return null;
		}
		var fdname = config.mapping;
		var handler = config.handler;
		
		if(handler===undefined){
			handler = fdname;
		}
		
		var wrapkey = null;
		var wrapvalue = null;
		if(handler != undefined && typeof handler != 'function'){
			var fd = this.record.getField(handler);
			if(fd){//存在对应的fieldname,因此从record中取值
				fdname = fdname || handler;
				wrapkey='fdName';
				wrapvalue = handler;
				handler = getFieldValue;
			} else {//不存在fieldname,说明是一个形如handler:true的配置
				wrapkey = 'value';
				wrapvalue = handler;
				handler = getFixvalue;
			}
		}
		fdname = fdname || nodeprop;//默认nodename与fieldname相同的属性进行值映射
		
		if(fdname){
			var fds = fdname.split(',');
			for(var i=0,len=fds.length;i<len;i++){
				var fdn = fds[i];
				var fd = this.record.getField(fdn);
				if(fd){
					if(this.recordMapping[fdn]){
						this.recordMapping[fdn].push(nodeprop);
					} else {
						this.recordMapping[fdn] = [nodeprop];//用于record反向映射node属性，比如用户修改record后
														//需要同步node,这时候不可能说重新生成一个node,
														//或者刷新node所有属性
					}
				}
			}
		}
		var fdmodel = new L5.tree.NodeFieldModel(nodeprop,handler);
		if(wrapkey!=null){
			fdmodel[wrapkey] = wrapvalue;
		}
		return fdmodel;
	},
	
	/**
	 * @ignore
	 * 替换掉模型默认的节点处理函数
	 * 比如node.text属性,其处理方式是调用node.setText
	 * node.disable属性,其处理方式是调用
	 */
	//private
	dealFieldModel : function(){
		var nodehandls = handleNodefuncs ;
		for(var key in nodehandls){
			var func = nodehandls[key];
			var fdmodel = this.fieldModels.item(key);
			if(fdmodel){
				fdmodel.handleNode = func;
			}
			
		}
	},
	
	buildAttribute:function(record){//创建record对应的node,不处理子节点
		var attr = {};
		var fldmodels = this.fieldModels;
		
		for(var i=0,len=fldmodels.getCount();i<len;i++){
			var fdmdl = fldmodels.itemAt(i);
			var vl = fdmdl.handleRecord(record);
			if(vl===""){
				continue;
			}
			attr[fdmdl.name] = vl;
		}
		return attr;
	},
	
	/**
	 * @ignore
	 * 刷新Node
	 * @param node 当前树节点
	 * @param recfdname record中的某一个fieldname
	 * @param record
	 */
	refreshNodeWithField : function(node,recfdname,record){//TODO
		var recordmappings = this.recordMapping[recfdname];//获取recfdname影响的treenode属性
		if(!recordmappings){
			return;
		}
		for(var i=0,len=recordmappings.length;i<len;i++){//获取record的反向映射
			var nodeprop = recordmappings[i];
			var fielmodel = this.fieldModels.item(nodeprop);//获取fieldmodel
			if(!fielmodel){
				continue;
			}
			var vl = fielmodel.handleRecord(record);
			fielmodel.handleNode(node,vl);//处理fieldmodel
		}
		this.fireEvent('update',record,recfdname,recordmappings,node);
	},
	
	/**
	 * @ignore
	 * 节点选中
	 */
	onNodeSelected : function(node,noevent){//TODO
		var oldnode = node.ownerTree.curNode;
		var oldrec;
		var currec = node.record;
		var ds = currec.getDataSet();
		if(oldnode){
			oldrec = oldnode.record;
		}
		if(this.fireEvent('beforeselected',oldrec,currec,oldnode,node)===false){
			return;
		};
		
		if(oldrec){
			oldrec.reject(false);
		}
		
		node.ownerTree.curNode = node;
		if(!noevent)//右键选中节点，但是可以不触发selected事件
			this.fireEvent('selected',currec,node);
	},
	
	/**
	 * @ignore
	 * 右键事件
	 */
	onNodeContextMenu : function(e,node){
        if (this.hasListener("contextmenu")) {
            e.preventDefault();
            node.ui.focus();
            this.onNodeSelected(node,true);//给右键增加选中节点功能。添加不触发selected事件参数
            node.select();
            this.fireEvent("contextmenu", node.record,e,node);
        }
	},
	
	destroy : function(){
		this.purgeListeners();
		if(this.binding){
			L5.tree.FormUnBinding(this.binding);
		}
	}
});

	/**
	 * @ignore
	 * config是一个节点模型配置信息数组，创建出来的节点类型存放两份，一个是以recordType为key的map，一个是所有nodemodel的数组
	 * 外界使用recordType获取nodemodel时，map是个快捷方式;由于有些nodemoedel并不显示声明recordType，当使用record获取nodemodel时，
	 * 就可以根据数组就比较全面，这时候使用的NodeModel提供的check方法来判断
	 * @param {Object} config
	 */
	L5.tree.NodeModelMgr = function(config){
		this.nodesmap = {};
		
		var ss = new L5.tree.NodeModel();
		this.register(ss);
		
		if(!config.length)
			config = [config];
		var len = config.length;
		for(var ind=0;ind<len;ind++){
			var ndl = new L5.tree.NodeModel(config[ind]);
			this.register(ndl);
		}
	};

	var modelmgr = L5.tree.NodeModelMgr.prototype;
	
	modelmgr.getNodeModelByType = function(recordType){
		return this.nodesmap[recordType];
	};
	
	//如果record中指示了recordType，则按照其指示查询节点模型
	//如果没有指定，或是指定了一个不存在的，都会遍历所有的节点模型，直到找到一个节点模型
	modelmgr.getNodeModel = function(record){
		var recordType = record.getType();
		return this.getNodeModelByType(recordType);
	};
	 
	//注册模型,如果声明了recordType，则保存一份到map中
	modelmgr.register = function(nodemodel){
		this.nodesmap[nodemodel.recordType] = nodemodel;
		nodemodel.manager = this;
	};
	
	modelmgr.destroy = function(){
		for(var key in this.nodesmap){
			var nodemodel = this.nodesmap[key];
			nodemodel.destroy();
		}
		this.nodesmap = null;
	};
})();
