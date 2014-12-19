function init() {
	var tree = L5.getCmp('roletree');
	if(parentStruId !== null ) {
		tree.dataset.root.data['struId'] = parentStruId;
		tree.dataset.root.isRoot = false;
	}

	if(expandAll ==='true') {
		tree.expandAll();
	}
}

/**
 * 定义根节点结构
 */
var rootdata = {
	id : 'rootId',//唯一标志record,如果是前台配置生成record,需要指定id
	struId:'rootId',
	organId:'',
	struType:'00',
	parentId:'-1',
	struLevel:'',
	struPath:'0',
	struOrder:'',
	isLeaf:'',
	inUse:'',
	organName:'角色树',
	shortName:'角色树',
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
*  触发加载角色组类型的record
*/
function roleGroupLoaderTrigger(record){
	var rcdTp = record.recordType;
	if(rcdTp == "struRecord"){
		return true;
	}

	return false;
}

/**
*  触发加载角色类型的record
*/
function roleLoaderTrigger(record){
	var rcdTp = record.recordType;
	if(rcdTp == "struRecord" || rcdTp == "roleGroupRecord"){
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
function getRoleGroupId(rec){
	var roleGroupId=rec.get('roleGroupId');
	return roleGroupId?roleGroupId:"";
}
function getStruType(rec){
	if( struTypeId !== null) {
		return struTypeId;
	}
	var struType=rec.get('struType');
	return struType?struType:"00";
}

//function getStruTypeId(rec){
//return struTypeId?struTypeId:"00";
//}
/**
 * 事件处理：设置organId为空
 */
function getStrudisabled(rec){
	return false;
}

function istRoot(record){
	if(record.isRoot)
		return false;
	return true;
}

function isStruRole(record){
	var parentRecord = record.parentRecord;
	if(parentRecord.recordType == "struRecord")
		return true;

	return false;
}

//当前节点类型返回后台作为判断查询角色参数的条件
function getNodeType(record){
	if(record.isRoot)
		return "isRoot";

	return record.recordType;
}

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
	if(rcdTp == "roleRecord"){
		file = figpath + "/l5/role.gif";
	}
	return file;
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

function confirmValue() {
	var tree = L5.getCmp("roletree");
	var roleId = tree.getChecked("roleId");
	var roleName = tree.getChecked("roleName");
	var leng = roleId.length;
	if(roleId!="" && roleName!=""){
     if(returnValueType=="array"){
	  var arr=new Array(2);
	  for(var i=0;i<roleId.length;i++){
	     arr[0]=roleId;
	     arr[1]=roleName;
	  }
	  window.returnValue=arr;
	}else {
     var ret = "";
	 for(var i=0; i<leng-1; i++) {
		ret +=roleId[i]+";"+roleName[i]+",";
	 }
		ret +=roleId[leng-1]+";"+roleName[leng-1];
		window.returnValue = ret;
	 }
		window.close();
	}
	else {
	  L5.MessageBox.alert("提示","请选择角色!");
	  return false;
	}
}

function closeDig(){
	window.returnValue="";
	window.close();
}

function getChoiceBox(record){
	if(nodeType !== null) {
		return nodeType;
	}
	return  "radiobox";
}