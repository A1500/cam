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
  <next:Tree id="organtree" allowCheck="isCheckedSub" rootVisible="true" border="false" lines="true" >
    <next:TreeDataSet dataset="organtempdataset" root="rootdata">
    <next:TreeLoader cmd="org.loushang.portal.permit.cmd.PortalPermitQueryCmd" method="getCorpAndDeptPortalStru">
	  <next:treeRecord name="organTempRecord"  idField="struId" fromBean="org.loushang.portal.permit.data.PortalStru">
	  </next:treeRecord>
	  <next:TreeBaseparam name="struId"    value="getStruId" />
	  <next:TreeBaseparam name="struType" value="getStruType"/>
    </next:TreeLoader>
    </next:TreeDataSet>
    <next:TreeNodemodel recordType="organTempRecord">
      <next:TreeNodeAttribute name="text" mapping="organName"></next:TreeNodeAttribute>
      <next:TreeNodeAttribute name="leaf" handler="isLeaf"></next:TreeNodeAttribute>
      <next:TreeNodeAttribute name="showType" handler="getChoiceBox"></next:TreeNodeAttribute>
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
		id : 'rootId',
		struId : 'rootId',
		organId : 'rootId',
		struType : '00',
		isLeaf : '0',
		organName : '组织树',
		organType : '0',
		recordType : 'organTempRecord'
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
	var tree = L5.getCmp('organtree');
	tree.on("checkchange",organCheckChange);
	tree.root.expand();
}

//选中或取消checkbox时触发的方法
function organCheckChange(node,checked){
   var organId =node.record.get("organId");
   var organName =node.record.get("organName");
   
   //选中checkbox
   if(checked)
	{
	   permitIdArray.push(organId);
	   permitNameArray.push(organName);
	}
	//取消选中checkbox
	else
	{
		for(var i=0;i<permitIdArray.length;i++)
		{
			if(organId==permitIdArray[i])
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
	var tree = L5.getCmp('organtree');
	if(permitIdArray.length>0)
	{
		var organId = permitIdArray.join(",");
		var organName = permitNameArray.join(",");
		window.returnValue=organId+";"+organName;
		window.close();
	}
	else{
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

function getChoiceBox(record){
	var struId=record.get("struId");
	if(struId=="rootId"){
		if(record.isRoot){
			return '';
		}
	}
	if(struId==""){
		return '';
	}else{
		return  'checkbox';
	}
	
}
function getIcon(rec){
	var iconPath=L5.webPath+"/jsp/portal/images/help/";
	var file=iconPath+"root.gif";
	if(rec){
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
function getChecked(record)
{
  var organId=record.get("organId");

  for(var i=0;i<permitIdArray.length;i++)
	{
	  if(organId==permitIdArray[i])
		{
			return true;
		}
	}

	return undefined;
}
</script>
</html>