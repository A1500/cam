<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<next:ScriptManager></next:ScriptManager>
<title>选择组织机构</title>
</head>
<body>
<next:Panel   anchor="100% 100%" border="false">
<next:TopBar>
<next:ToolBarItem symbol="->"></next:ToolBarItem>
<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
</next:TopBar>
<next:Tree id="usertree" allowCheck="isCheckedSub" rootVisible="true" border="false" lines="true" >
	<next:TreeDataSet dataset="usertempdataset" root="rootdata">
		<next:TreeLoader cmd="org.loushang.portal.permit.cmd.PortalPermitQueryCmd" method="getCorpPortalStruForUser" trigger="struLoaderTrigger">
			<next:treeRecord name="struRecord"  idField="struId" fromBean="org.loushang.portal.permit.data.PortalStru">
			</next:treeRecord>
			<next:TreeBaseparam name="struId"    value="getStruId" />
			<next:TreeBaseparam name="struType" value="getStruType"/>
		</next:TreeLoader>
		<next:TreeLoader cmd="org.loushang.portal.permit.cmd.PortalPermitQueryCmd" method="getCorpPortalUnderlingUserForUser" trigger="underlinguserLoaderTrigger">
			<next:treeRecord name="userRecord"  idField="userId" fromBean="org.loushang.portal.permit.data.PortalUser">
			</next:treeRecord>
			<next:TreeBaseparam name="struId"    value="getStruId" />
		</next:TreeLoader>
	</next:TreeDataSet>
	<next:TreeNodemodel recordType="struRecord">
		<next:TreeNodeAttribute name="text" mapping="organName"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="leaf" handler="isLeaf"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="showType" handler="getStruChoiceBox"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="checked" handler="getChecked" ></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
	</next:TreeNodemodel>
	<next:TreeNodemodel recordType="userRecord">
		<next:TreeNodeAttribute name="text" mapping="userName"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="leaf" handler="isLeaf"></next:TreeNodeAttribute>
		<next:TreeNodeAttribute name="showType" handler="getUserChoiceBox"></next:TreeNodeAttribute>
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
		struId : 'rootId',
		organId : 'rootId',
		struType : '00',
		isLeaf : '0',
		hasCheckBox : '0',
		organName : '用户列表',
		organType : '0',
		recordType : 'struRecord'
};

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
	var tree = L5.getCmp('usertree');
	tree.on("checkchange",userCheckChange);
	tree.root.expand();
}

//选中或取消checkbox时触发的方法
function userCheckChange(node,checked){
   var userId =node.record.get("userId");
   var userName =node.record.get("userName");
   
   //选中checkbox
   if(checked)
	{
	   permitIdArray.push(userId);
	   permitNameArray.push(userName);
	}
	//取消选中checkbox
	else
	{
		for(var i=0;i<permitIdArray.length;i++)
		{
			if(userId==permitIdArray[i])
			{
				permitIdArray.splice(i,1)
				permitNameArray.splice(i,1)
				break;
			}
		}
	}
}

function getStruType(rec){
	var struType=rec.get('struType');
	return struType?struType:"00";
}

function  getStruId(record){
	var struId=record.get('struId');
	return struId?struId:"rootId";
}

function isLeaf(rec){
	if(rec.get("isLeaf")=='0')
		return false;
	else
		return true;
}

function  confirmValue(){
	var tree = L5.getCmp('usertree');
	if(permitIdArray.length>0)
	{
		var userId = permitIdArray.join(",");
		var userName = permitNameArray.join(",");
		window.returnValue=userId+";"+userName;
		window.close();
	}else{
		L5.MessageBox.alert("消息提示","请选择组织节点!");
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

function struLoaderTrigger(record){
	var organType = record.get("organType");
	var reg=/^[0-2]/;//以0、1、2开头，查询某公司或部门下所有部门
	if(reg.test(organType) ){
		return true;
	}
	return false;
}

function underlinguserLoaderTrigger(record){
	var organType = record.get("organType");
	var reg=/^[0-2]/;//以0、1、2开头，查询某公司下所有员工
	if(reg.test(organType) ){
		return true;
	}
	return false;
}

function getStruChoiceBox(record){
	var hasCheckBox = record.get("hasCheckBox");
	if(hasCheckBox == "1"){
		return 'checkbox';
	}
	return '';

}

function getUserChoiceBox(record){
	return 'checkbox';

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
						if(rec.get('userId')=='PUBLIC'  ){
							file = iconPath + "employee.gif";
						}
						else if(rec.get('userId')=='SUPERADMIN'){
							file = iconPath + "employee.gif";
						}
						}
			  }
		}
		else if(rcdTp == "userRecord"){
				file = iconPath + "employee.gif";
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
  var userId=record.get("userId");

  for(var i=0;i<permitIdArray.length;i++)
	{
	  if(userId==permitIdArray[i])
		{
			return true;
		}
	}

	return undefined;
}
</script>
</html>