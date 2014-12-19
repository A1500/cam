function init() {
}

/**
 * 定义根节点结构
 */
var rootdata = function() {
   	var command=new L5.Command("org.loushang.bsp.organization.cmd.StruCommand");
   	var rootRecord;
   	//根结点的struId
   	command.setParameter("rootid",rootId);
    command.setParameter("struTypeId",struTypeId);
    command.execute("getRootForHelp");
    if(!command.error) {
		rootRecord=command.getReturn("rootRecord");
	}else {
		L5.Msg.alert("提示",command.error);
	}
   return {
    id : rootRecord.struId,//唯一标志record,如果是前台配置生成record,需要指定id
	struId:rootRecord.struId,
	organId:rootRecord.organId,
	struType:rootRecord.struType,
	parentId:rootRecord.parentId,
	struLevel:rootRecord.struLevel,
	struPath:rootRecord.struPath,
	struOrder:rootRecord.struOrder,
	isLeaf:rootRecord.isLeaf,
	inUseStru:rootRecord.inUseStru,
	organName:rootRecord.organName,
	shortName:rootRecord.shortName,
	organType:rootRecord.organType,
	organTypeName:rootRecord.organTypeName,
	struTypeName:rootRecord.struTypeName,
	inUseOrgan:rootRecord.inUseOrgan,
	recordType : 'struRecord'
	};
};
function getStruParent(rec){
	var parentId = rec.get('parentId');
	return parentId;
}
function getOrganId(rec){
	var struId=rec.get('organId');
	return struId?struId:"rootId";
}
function getStruId(rec){
	var struId=rec.get('struId');
	if(struId.trim()==""||struId=="null") struId ="rootId";
    return struId;
}

function getStruType(rec){
	if( struTypeId == null || struTypeId.trim()=="") {
		struTypeId="00";
	}
	var struType=rec.get('struType');
	return struType?struType:"00";
}
function getStrudisabled(rec){
	return false;
}

function getChoiceBox(rec){
	return  "checkbox";
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
	if(rcdTp == "userRecord"){
		file = figpath + "/l5/bsp_employee.gif";
	}
	return file;
}
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

function userLoaderTrigger(record){
	var rcdTp = record.recordType;
	if(rcdTp == "struRecord"){
		return true;
	}

	return false;
}

function getRoleId(){
   return roleId;
}


function confirmValue() {
    var tree = L5.getCmp('usertree');
	var userId = tree.getChecked("userId");
	var userName =tree.getChecked("userName");
	var organId=tree.getChecked("userEmployeeId");
	var len=userId.length;
	var arr=new Array(len);
	if(returnValueType=="array"){
	  for(var i=0;i<len;i++){
	    arr[i]=new Array();
	    arr[i][0]=userId[i];
	    arr[i][1]=userName[i];
	    arr[i][2]=organId[i];
	  }
	  window.returnValue=arr;
	}else{
     window.returnValue=userId+";"+userName+";"+organId;
	}
	window.close();
}

function closeDig(){
	window.returnValue="";
	window.close();
}

//当前节点类型返回后台作为判断查询用户参数的条件
function getNodeType(record){
	if(record.isRoot)
		return "isRoot";

	return record.recordType;
}