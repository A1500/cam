<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<script language="javascript">
	 	 //查询条件打开合并函数
		 function collapse(element){
			var fieldsetParent=L5.get(element).findParent("fieldset");
			if(element.expand==null||element.expand==true){	
				fieldsetParent.getElementsByTagName("div")[0].style.display="none";
				element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';
				element.expand=false;
			}else{
				fieldsetParent.getElementsByTagName("div")[0].style.display="";
				element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";
				element.expand =true;
			}
		}
	</script>
<title>本地操作组定义查询</title>
<next:ScriptManager></next:ScriptManager>
</head>
<body>
<model:datasets>
	<model:dataset id="actiongroupdef" cmd="org.loushang.workflow.ecgapform.actiongroupdef.cmd.ActionGroupDefQueryCmd"	autoLoad="true" pageSize="10">
		<model:record	fromBean="org.loushang.workflow.ecgapform.actiongroupdef.data.ActionGroupDef"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
	<next:Panel>
<next:Panel  name="form" width="100%" height="100" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>	
	<fieldset style="overflow: visible;" class="GroupBox">
		<legend class="GroupBoxTitle">查询条件 <img	class="GroupBoxExpandButton"	src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
			onclick="collapse(this);" /> </legend>
			<div class="GroupBoxDiv" >
			<form onsubmit="return false;"  class="L5form">
			<table border="1" width="90%">
				<tr>
					<td class="FieldLabel">组名称：</td>
					<td class="FieldInput"><input type="text" id="groupName"   size="50" title="组名称" /></td>
					<td class="FieldLabel"><button onclick="query()">查询</button>
					</td>
				</tr>
			</table>
			</form>
		</div>
	</fieldset>
</next:Html>
</next:Panel>

<next:GridPanel id="ecgapGridPanel" name="ecgapGrid" notSelectFirstRow="true"
	dataset="actiongroupdef" stripeRows="true" width="100%"
	trackMouseOver="true" height="370" enableHdMenu="false" 
	enableColumnMove="true" enableColumnHide="false" autoScroll="false">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="新增" iconCls="add" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"></next:ToolBarItem>
		<next:ToolBarItem text="删除" iconCls="delete" handler="del"></next:ToolBarItem>

	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column header="组名称" width="200" field="groupName"></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="actiongroupdef"  displayMsg="从第{0}条到{1}条，一共{2}条"
			displayInfo="true"></next:PagingToolBar>
	</next:BottomBar>
</next:GridPanel>
		</next:Panel>
</next:ViewPort>
</body>
</html>
<script>
function init(){	
	var actiongroupdef = L5.DatasetMgr.lookup("actiongroupdef");
	actiongroupdef.load();
}
function insert(){
    var node={};
    var url="jsp/workflow/ecgapform/actiongroupdef/forinsert.jsp";
    L5.forward(url,"本地操作组增加");
}
function update(){
    var ecgapGrid=L5.getCmp('ecgapGridPanel');
    var selected=ecgapGrid.getSelectionModel().getSelections();
    if(selected.length!=1){
     alert("请选择一条记录修改");
     return false;
    }
    var groupId=selected[0].get('groupId');
    var url="jsp/workflow/ecgapform/actiongroupdef/forupdate.jsp?groupId="+groupId;
   L5.forward(url,"本地操作组修改");
}
function del(){
    var ecgapGrid=L5.getCmp('ecgapGridPanel');
    var selected=ecgapGrid.getSelectionModel().getSelections();
    if(selected.length<1){
     alert("请选择要删除的记录！");
     return false;
    }
    L5.MessageBox.confirm('确定','确定要删除选中的记录吗?',function(state){
       if(state=="yes"){
         var ecgapRecords=[];
         
         for(var i=0;i<selected.length;i++){
            ecgapRecords[i]=selected[i];
            var actiongroupdef=L5.DatasetMgr.lookup("actiongroupdef");
            actiongroupdef.remove(selected[i]);
         }
         var command=new L5.Command("org.loushang.workflow.ecgapform.actiongroupdef.cmd.ActionGroupDefCmd");
         command.setParameter("record",ecgapRecords);
         command.execute("delete");
         if(!command.error){
            L5.Msg.alert("成功","成功删除记录！");
         }else{
            alert(command.error.code);
         }
         }else{
            return false;
         }
   });
}
function query(){
	var actiongroupdef=L5.DatasetMgr.lookup("actiongroupdef");
    actiongroupdef.baseParams["GROUP_NAME@like"] = document.getElementById("groupName").value;
	actiongroupdef.load();
}
</script>
