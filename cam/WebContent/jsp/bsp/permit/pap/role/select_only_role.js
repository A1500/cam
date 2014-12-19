function init() {
	var tree = L5.getCmp('roletree');
	tree.expandAll();
}

/**
 * 定义根节点结构
 */
var rootdata = {
	id : 'rootId',//唯一标志record,如果是前台配置生成record,需要指定id
	roleName:'角色树' ,
	recordType : 'roleRecord'
};
/**
*  触发加载角色类型的record
*/
function roleLoaderTrigger(record){
	var rcdTp = record.recordType;

	return true;
}

//根据类型值获取图标路径
function getIcon(record){
	var figpath=L5.webPath + "/skins/images";
	var file=figpath + "/l5/bsp_department&corporation.gif";
	if(!record){
		return file;
	}
	if(record.isRoot){
		file = figpath + "/l5/root.gif";
		return file;
	}
	var rcdTp = record.recordType;
	if(rcdTp == "roleRecord"){
		file = figpath + "/l5/role.gif";
	}
	return file;
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
	if(record.isRoot)
		return "isRoot";
	return  "radiobox";
}