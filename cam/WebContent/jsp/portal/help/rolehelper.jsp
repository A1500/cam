<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<next:ScriptManager ></next:ScriptManager>
<title>选择角色</title>
</head>
<body>

<next:Panel   anchor="100% 100%" border="false">
<next:TopBar>
<next:ToolBarItem symbol="->"></next:ToolBarItem>
<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
</next:TopBar>
<next:Tree id="roletree" allowCheck="isCheckedSub" rootVisible="true" border="false" lines="true" >
<next:TreeDataSet dataset="roletempdataset" root="rootdata">
	<next:TreeLoader cmd="org.loushang.portal.permit.cmd.PortalPermitQueryCmd" method="getCorpPortalStruForRole" trigger="organLoaderTrigger">
		<next:treeRecord name="struRecord"  idField="roleId" fromBean="org.loushang.portal.permit.data.PortalStru"></next:treeRecord>
		<next:TreeBaseparam name="struId"    value="getStruId" />
		<next:TreeBaseparam name="struType" value="getStruType"/>
	</next:TreeLoader>
	<next:TreeLoader cmd="org.loushang.portal.permit.cmd.PortalPermitQueryCmd" method="queryPortalRoleList" trigger="roleGroupLoaderTrigger">
		<next:treeRecord name="roleRecord"  idField="struId" fromBean="org.loushang.portal.permit.data.PortalRole"></next:treeRecord>
		<next:TreeBaseparam name="struId" value="getStruId"></next:TreeBaseparam>
	</next:TreeLoader>
</next:TreeDataSet>
<next:TreeNodemodel recordType="roleRecord">
	<next:TreeNodeAttribute name="text" mapping="roleName"></next:TreeNodeAttribute>
	<next:TreeNodeAttribute name="leaf" handler="isLeaf"></next:TreeNodeAttribute>
	<next:TreeNodeAttribute name="showType" handler="getChoiceBox"></next:TreeNodeAttribute>
	<next:TreeNodeAttribute name="checked" handler="getChecked" ></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
</next:TreeNodemodel>
<next:TreeNodemodel recordType="struRecord">
	<next:TreeNodeAttribute name="text" mapping="organName"></next:TreeNodeAttribute>
	<next:TreeNodeAttribute name="leaf" handler="isLeaf"></next:TreeNodeAttribute>
	<next:TreeNodeAttribute name="showType" handler="getChoiceBoxStru"></next:TreeNodeAttribute>
	<next:TreeNodeAttribute name="checked" handler="getChecked" ></next:TreeNodeAttribute>
    <next:TreeNodeAttribute name="changeParent" handler="getChangeParent" ></next:TreeNodeAttribute>
	<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
</next:TreeNodemodel>
</next:Tree>
</next:Panel>
</body>
<script type="text/javascript">
//定义根节点结构
var rootdata = {
		id : 'rootId',//唯一标志record,如果是前台配置生成record,需要指定id
		struId:'rootId',
		struType:'00',
		organName:'角色列表',
		isLeaf:'0',
		hasCheckBox:'0',
		organType:'0',
		recordType : 'struRecord'
}

//从父窗口传递来的值
var obj = window.dialogArguments;

var permitIdArray=[];
var permitNameArray=[];
if(obj.permitIds)
{
	permitIdArray=obj.permitIds.split(",");
	permitNameArray=obj.permitNames.split(",");
}

//初始化
function init(){
	var tree = L5.getCmp('roletree');
	tree.on("checkchange",roleCheckChange);
	tree.root.expand();
}

//选中或取消checkbox时触发的方法
function roleCheckChange(node,checked){
   var roleId =node.record.get("roleId");
   var roleName =node.record.get("roleName");
   
   //选中checkbox
   if(checked)
	{
	   permitIdArray.push(roleId);
	   permitNameArray.push(roleName);
	}
	//取消选中checkbox
	else
	{
		for(var i=0;i<permitIdArray.length;i++)
		{
			if(roleId==permitIdArray[i])
			{
				permitIdArray.splice(i,1)
				permitNameArray.splice(i,1)
				break;
			}
		}
	}
}

function getStruId(rec){
	var struId=rec.get('struId');
	return struId?struId:"rootId";
}
function getStruType(rec){
	var struType=rec.get('struType');
	return struType?struType:"00";
}

function isLeaf(rec){
	if(rec.get("isLeaf")=='0')
		return false;
	else
		return true;
}
function  confirmValue(){
	var tree = L5.getCmp('roletree');
	if(permitIdArray.length>0)
	{
		var roleId = permitIdArray.join(",");
		var roleName = permitNameArray.join(",");
		window.returnValue=roleId+";"+roleName;
		window.close();
	}else{
		L5.MessageBox.alert("消息提示","请选择组织节点");
	return false;
	}
}

function closew(){
	window.close();
}

function clears(){
	window.returnValue=""+";"+"";
	window.close();

}
function getChoiceBoxStru(record){
	var hasCheckBox = record.get("hasCheckBox");
	if(hasCheckBox == "1"){
		return 'checkbox';
	}
	return '';
}
function getChoiceBox(record){
	return  'checkbox';
}

/**
*  触发加载组织类型的record
*/
function organLoaderTrigger(record){
	var isLeaf=record.get('isLeaf');
	if(isLeaf == "0"){
		return true;
	}
	return false;
}

/**
*  触发加载角色组类型的record
*/
function roleGroupLoaderTrigger(record){
	var isLeaf=record.get('isLeaf');
	if(isLeaf == "0"){
		return true;
	}
	return false;
}
function getIcon(rec){
	var iconPath=L5.webPath+"/jsp/portal/images/help/";
	var file=iconPath+"root.gif";
	if(rec){
		var rcdTp = rec.recordType;
		if(rcdTp == "struRecord"){
			  var organType=rec.get('organType');
			  var type=organType.substring(0, 1);
	
			  switch(type){
					case "0": //根结点
						file =iconPath+"root.gif";
						break;
					case "1": // 法人
						file =iconPath+"department.gif";
						break;
					case "2": // 部门
						file =iconPath+ "department.gif";
						break;
					default:{
						if(rec.get('roleId')=='PUBLIC'  ){
							file = iconPath + "role_public.gif";
						}
						else if(rec.get('roleId')=='SUPERADMIN'){
							file = iconPath + "role_superadmin.gif";
						}
						}				
			  }
		}
		else if(rcdTp == "roleRecord"){
				file = iconPath + "role.gif";
		}
		}

	return file;
}
//选择父节点时，是否级联选中节点的下级
function isCheckedSub(node,parentNode){

	return false;
}
//选择子节点时，是否级联选择节点的上级
function getChangeParent(record)
{
	return false;
}
//是否选中该节点
function getChecked(record)
{
  var roleId=record.get("roleId");

  for(var i=0;i<permitIdArray.length;i++)
	{
	  if(roleId==permitIdArray[i])
		{
			return true;
		}
	}

	return undefined;
}
</script>
</html>
