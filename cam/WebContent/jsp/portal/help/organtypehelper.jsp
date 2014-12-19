<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<next:ScriptManager ></next:ScriptManager>
<title>选择岗位类型</title>
</head>
<body>

<next:Panel   anchor="100% 100%" border="false">
<next:TopBar>
<next:ToolBarItem symbol="->"></next:ToolBarItem>
<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
</next:TopBar>
<next:Tree id="organtypetree" allowCheck="isCheckedSub" rootVisible="true" border="false" lines="true" >
<next:TreeDataSet dataset="organtype" root="organtypetree.organrootdata">
<next:TreeLoader cmd="org.loushang.portal.permit.cmd.PortalPermitQueryCmd" method="queryPortalOrganTypeList">
	<next:treeRecord name="portalorgantype"  idField="organType" fromBean="org.loushang.portal.permit.data.PortalOrganType">
		<model:field name="isLeaf" mapping="isLeaf"/>
	</next:treeRecord>
	<next:TreeBaseparam name="parentType"    value="getParentType" />
</next:TreeLoader>
</next:TreeDataSet>
<next:TreeNodemodel recordType="portalorgantype">
	<next:TreeNodeAttribute name="text" mapping="typeName"></next:TreeNodeAttribute>
  	<next:TreeNodeAttribute name="leaf" handler="getIsTypeLeaf"></next:TreeNodeAttribute>
  	<next:TreeNodeAttribute name="showType" handler="getChoiceBox"></next:TreeNodeAttribute>
  	<next:TreeNodeAttribute name="checked" handler="getChecked" ></next:TreeNodeAttribute>
  	<next:TreeNodeAttribute name="changeParent" handler="getChangeParent" ></next:TreeNodeAttribute>
  	<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
</next:TreeNodemodel>
</next:Tree>
</next:Panel>
</body>
<script type="text/javascript">
//根组织类型节点
var rootOrganType='6';
//定义根节点结构
var organtypetree={
		//获取组织类型根节点
		organrootdata:function(){
			var command=new L5.Command("org.loushang.portal.permit.cmd.PortalPermitCmd");
			command.setParameter("organType",rootOrganType);
			command.execute("getPortalOrganTypeRoot");
			var rootRecord;
		    if(!command.error){
				rootRecord=command.getReturn("rootRecord");
			}else{
				L5.MessageBox.alert("消息提示",command.error);
				return;
			}
		    return{
		    	id:rootRecord.organType,
		    	organType:rootRecord.organType,
		    	typeName:rootRecord.typeName,
		    	parentType:rootRecord.parentType,
		    	inUse:rootRecord.inUse,
		    	isLeaf:"0",
		    	recordType : 'portalorgantype'
		    };
		}
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
	var tree = L5.getCmp('organtypetree');
	tree.on("checkchange",organTypeCheckChange);
	tree.root.expand();
}

//选中或取消checkbox时触发的方法
function organTypeCheckChange(node,checked){
   var organType =node.record.get("organType");
   var organTypeName =node.record.get("typeName");
   
   //选中checkbox
   if(checked)
	{
	   permitIdArray.push(organType);
	   permitNameArray.push(organTypeName);
	}
	//取消选中checkbox
	else
	{
		for(var i=0;i<permitIdArray.length;i++)
		{
			if(organType==permitIdArray[i])
			{
				permitIdArray.splice(i,1)
				permitNameArray.splice(i,1)
				break;
			}
		}
	}
}

function getParentType(rec){
	return rec.get("organType");
}
function getIsTypeLeaf(rec){
	var leaf1=rec.get('isLeaf');
	if(leaf1=='1'){
		return true;
	}else{
		return false;
	}
}
function  confirmValue(){
	var tree = L5.getCmp('organtypetree');
	if(permitIdArray.length>0)
	{
		var organType = permitIdArray.join(",");
		var organTypeName = permitNameArray.join(",");
		window.returnValue=organType+";"+organTypeName;
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

function getChoiceBox(record){
	return 'checkbox';
}
function getIcon(rec){
	return L5.webPath+"/jsp/portal/images/help/post.png";
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
  var organType=record.get("organType");

  for(var i=0;i<permitIdArray.length;i++)
	{
	  if(organType==permitIdArray[i])
		{
			return true;
		}
	}

	return undefined;
}
</script>
</html>
