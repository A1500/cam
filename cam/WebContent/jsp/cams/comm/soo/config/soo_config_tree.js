function init(){
  var tree = L5.getCmp('usertree');
  tree.root.expand();
}

/**
 * 定义根节点结构
 */
var rootdata = {
	id : 'rootId',//唯一标志record,如果是前台配置生成record,需要指定id
	struId:'',
	organId:'',
	struType:'00',
	parentId:'-1',
	struLevel:'',
	struPath:'0',
	struOrder:'',
	isLeaf:'',
	inUse:'',
	organName:'用户树',
	shortName:'用户树',
	organType:'0',
	organTypeName:'单位',
	struTypeName:'人力资源',
	recordType : 'struRecord'
};

/**
*  触发加载组织机构类型的record，岗位和职工类型的不加载
*/
function struLoaderTrigger(record){
	var rcdTp = record.recordType;
	if(rcdTp == "struRecord"){
		var organType = record.get('organType');
		var type = parseInt(organType.substring(0, 1));
		if(type == 0 || type == 1 || type == 2){
			return true;
		}
	}
	return false;
}

/**
*  触发加载用户类型的record
*/
function userLoaderTrigger(record){
	var rcdTp = record.recordType;
	if(rcdTp == "struRecord"){
		return true;
	}

	return false;
}

/**
 * 事件处理：获得 TreebaseParams的值
 */
function getStruParent(rec){
	var parentId = rec.get('parentId');

	return parentId;
}
function getStruId(rec){
	var struId=rec.get('struId');
	return struId?struId:"rootId";
}
function getOrganType(rec){
	var organType = rec.get('organType');
	return organType?organType:"0";
}
function getOrganId(rec){
	var organId = rec.get('organId');
	return organId?organId:"rootId";
}
function getStruType(rec){
	var struType=rec.get('struType');
	return struType?struType:"00";
}
function getStruTypeId(rec){

	return struTypeId?struTypeId:"00";
}
/**
 * 事件处理：设置organId为空
 */
function getStrudisabled(rec){
	return false;
}

//当前节点类型返回后台作为判断查询用户参数的条件
function getNodeType(record){
	if(record.isRoot)
		return "isRoot";

	return record.recordType;
}

function istRoot(record){
	if(record.isRoot)
		return false;
	return true;
}
//function isRoot(record){
	//if(record.isRoot)
	//	return true;
	//return false;
//}

//根据类型值获取图标路径
function getIcon(record){
	var figpath=L5.webPath + "/skins/images";
	var file=figpath + "/l5/bsp_department&corporation.gif";
	if(!record){
		return file;
	}
	var rcdTp = record.recordType;
	if(rcdTp == "struRecord"){
		var organType = record.get('organType');
		var type = organType.substring(0, 1);
		var value = parseInt(type);
		switch(value){
			case 0: //根结点
				file = figpath + "/l5/root.gif";
				break;
			case 1: // 法人
				file = figpath +"/l5/bsp_department&corporation.gif";
				break;
			case 2: // 部门
				file = figpath + "/l5/bsp_department&corporation.gif";
				break;
			default:
				file = figpath + "/other_img.gif";
		}
		return file;
	}


	if(rcdTp == "userRecord"){
		file = figpath + "/l5/bsp_employee.gif";
	}
	return file;
}

/**
* 事件处理：点击节点显示维护页面
*/
function selectedNode(record){
//	var win = window.frames["appFrame"].window;
	if(record.recordType != "userRecord"){
		return;
	}
	var parentRecord = record.parentRecord;
	var frame = document.getElementById("nodeFrame");
    var url;
	url = "soo_fonfig.jsp?"
	url+="primeKey="+encodeURIComponent(encodeURIComponent(record.get("userId")));
	frame.setAttribute("src", url);
}

function handler(record){
    if(record.get("struId")=="rootId"){
    	return true;
    }
    return false;
}

function handlerOther(record){
	if(record.get("struType")!="00"){
    	return true;
    }
    return false;
}

//定义用户
function  addUser(menuitem){
	alert(1);
}

//查询用户
function  queryUser(menuitem){
	var frame = document.getElementById("nodeFrame");
    var url;
	url = "user_list.jsp";
	frame.setAttribute("src", url);
}

//删除用户
function  configSoo(menuitem){
	alert(2);
}

