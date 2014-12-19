/**
*定义根节点
*/
var rootdata = {
	id : 'rootId',//唯一标志record,如果是前台配置生成record,则指定id
	appCode:'-1',
	appName:PUB_FUNCTIONS_TITLE,
	recordType:'appRecord',
	moduleCode:'-1'
};

/**
 * 页面初始函数
 */
function init() {
	L5.QuickTips.init();
	tree = L5.getCmp('functiontree');
	tree.root.expand();
}

/**
*  触发加载应用类型的record，只有点击根节点才加载应用
*/
function appLoaderTrigger(record){
	var rcdTp = record.recordType;
	if(rcdTp == "appRecord" && record.get("appCode") == "-1"){
		return true;
	}
	return false;
}

/**
*  触发加载模块类型的record，点击应用节点和非末级模块加载
*/
function moduleLoaderTrigger(record){
    var rcdTp = record.recordType;
    if(showType < 2){
    	return false;
    }
    //under app
	if(rcdTp == "appRecord"){
       		return true;
	}

	if(rcdTp == "moduleRecord" && record.get("isLeafModule") != "1"){
        //load but no under leaf module
        return true;
	}
	return false;
}

/**
*  触发加载功能类型的record，点击末级模块加载
*/
function functionLoaderTrigger(record){
	if(showType < 3){
    	return false;
    }
    var rcdTp = record.recordType;

	if(rcdTp == "moduleRecord" && record.get("isLeafModule") == "1" ){
         return true;
    }

	return false;
}
/**
*  触发加载操作类型的record，点击功能加载
*/
function operationLoaderTrigger(record){
	if(showType < 4){
    	return false;
    }
    var rcdTp = record.recordType;
	if( rcdTp== "functionRecord" ){
       return true;
    }
	return false;
}
//获取不同类型树节点的显示图标
//configure node icon
function getIcon(record){
	var recordType = record.recordType;
	if(recordType == "appRecord" && record.get("appCode") == "-1"){
		return L5.webPath+"/skins/images/l5/root.gif";
	}

	if(recordType== "appRecord" && record.get("appCode") != "-1"){
		return L5.webPath+"/skins/images/l5/app.gif";
	}

	if(recordType == "moduleRecord"){
		return L5.webPath+"/skins/images/l5/module.gif";
	}

	if(recordType == "functionRecord"){
		return L5.webPath+"/skins/images/l5/function.gif";
	}

	if(recordType == "operationRecord"){
		return L5.webPath+"/skins/images/l5/operation.gif";
	}
}

/**
* 获取当前模块的应用，作为下级模块查询条件
*/
function getModuleApp(rec){
	var appId = rec.get("appCode");
	if(!appId)appId  = rec.get('moduleAppCode');
	return appId;
}
/**
* 获取当前模块编码，作为下级模块查询条件
*/
function getParentModule(rec){
	//顶级模块的上级模块存在
	if(rec.recordType=="appRecord" || rec.recordType=="appRecord2")
		return "-1";
	var parentModule = rec.get("moduleCode");
	return parentModule;
}
/**
* 获取当前模块编码，作为功能查询条件
*/
function getFunctionModule(rec){
	var module = rec.get("moduleCode");
	return module;
}

/**
* 获取当前功能编码，作为操作查询条件
*/
function getOperationFunction(rec){
	var module = rec.get("functionCode");
	return module;
}
/**radiobox || ''
 */
function getChoiceBox(rcd){
    var rcdtype = rcd.recordType;
    if(rcd.isRoot){
    	return "";
    }
    if(rcdtype == "appRecord" && showType == "1" ){
    	return "radiobox";
    }
    if(rcdtype == "moduleRecord" && showType == "2"){
    	return "radiobox";
    }
    if(rcdtype == "functionRecord" && showType == "3"){
    	return "radiobox";
    }
    if(rcdtype == "operationRecord" && showType == "4"){
    	return "radiobox";
    }
    return "";
}

function isAppNode(rcd){
	return rcd.recordType == 'appRecord';//app record type
}
function isModuleNode(rcd){
	return rcd.recordType == 'moduleRecord';//module record type
}
function isFunctionNode(rcd){
	return rcd.recordType == 'functionRecord';//function record type
}
function isOprNode(rcd){
	return rcd.recordType == 'operationRecord';//function record type
}
function isRootNode(rcd){
	return rcd.isRoot;
}
function isLeafModule(rcd){
	return (rcd.recordType == 'moduleRecord' && rcd.get('isLeafModule') == '1');
}

function confirmValue(){
	var tree = L5.getCmp("functiontree");
	var rcds = tree.getChecked();
	var rcd=tree.getNodeByRecordId(rcds[0]).record;
	if(rcd==undefined){
		window.close();
		return;
	}
	if(rcd.recordType == "appRecord"){
		window.returnValue = tree.getChecked("appCode") + ";" + tree.getChecked("appName");
	}
	if(rcd.recordType == "moduleRecord"){
		window.returnValue = tree.getChecked("moduleCode") + ";" + tree.getChecked("moduleName");
	}
	if(rcd.recordType == "functionRecord"){
		window.returnValue = tree.getChecked("functionCode") + ";" + tree.getChecked("functionName");
	}
	if(rcd.recordType == "operationRecord"){
		window.returnValue = tree.getChecked("operationCode") + ";" + tree.getChecked("operationName");
	}
	window.close();
}

function closeDig(){
	window.returnValue="";
	window.close();
}
