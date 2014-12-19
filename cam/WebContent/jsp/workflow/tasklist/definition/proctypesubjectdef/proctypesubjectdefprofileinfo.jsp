<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.*"%>

<html>
	<head><style>a{TEXT-DECORATION:none}</style>
		<title>流程类型层次任务标题概要信息</title>
		<next:ScriptManager></next:ScriptManager>
	</head>
<body>

<model:datasets>
	<model:dataset pageSize="15" id="procTypeSubjectDefQueryDataset" cmd="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefQueryCmd" autoLoad="false" method="queryProcTypeSubjectDefProfileInfo" global="true">
		<model:record>
			<model:field name="procTypeId" type="string" />
			<model:field name="procTypeName" type="string" />
			<model:field name="procTypeSubjectFrom" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
	<next:BorderLayout>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0" >
			<next:Panel>
			<next:AnchorLayout>
			<next:Panel width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:0px;">
				<next:Html>			
				<fieldset style="overflow: visible;" class="GroupBox">
					<legend class="GroupBoxTitle">查询条件
						<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>									
					</legend>
					<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
						<form onsubmit="return false;" class="L5form">				
							<table  border="1" width="100%">
								<tr>
									<td class="FieldLabel" width="15%">流程类型名称：</td>
									<td class="FieldInput"><input type="text"  id="procTypeNameQuery" class="TextEditor" title="流程类型名称"  size="40"/></td>
									<td class="FieldButton" width="15%"><button onclick="query()">查询</button> </td>
								</tr>
							</table>
						</form>		
					</div>
				</fieldset>
				</next:Html>
			</next:Panel>	
			<next:GridPanel id="procTypeSubjectDefQueryGridPanel" name="procTypeSubjectDefQueryGridPanel" anchor="100%" height="100%" dataset="procTypeSubjectDefQueryDataset"     title="标题概要信息" notSelectFirstRow="true">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column  header="内码" field="procTypeId" width="50" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="流程类型名称" field="procTypeName" width="150">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="标题来源" field="procTypeSubjectFrom" width="150" renderer="setProcTypeSubjectFrom">
						<next:TextField allowBlank="false"/>
					</next:Column>
				</next:Columns>
				<next:TopBar>
				   <next:ToolBarItem symbol="->"></next:ToolBarItem>	
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
                    <next:ToolBarItem iconCls="add"  text="标题来源定义" handler="procSubjectFromDef"/>
				    <next:ToolBarItem iconCls="add"  text="标题定义" handler="procSubjectDef"/>	
				    <next:ToolBarItem iconCls="detail"  text="预览" handler="forPreview"></next:ToolBarItem>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="procTypeSubjectDefQueryDataset"/>
				</next:BottomBar>
			</next:GridPanel>
			</next:AnchorLayout>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script language="javascript"  type="text/javascript" >
//流程类型标题来源定义
function procSubjectFromDef()
{
	var procTypeSubjectDefQueryGridPanel=L5.getCmp('procTypeSubjectDefQueryGridPanel');
	var selected = procTypeSubjectDefQueryGridPanel.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示", "请选择一条记录进行处理!");
		return;
	}
	var rec=selected[0];
	var subjectfromurl ="../subjectfromdef.jsp";
	var win = showModalDialog(subjectfromurl,window,"scroll:yes;status:no;dialogWidth:300px;dialogHeight:100px"); 
    if (!win) {  
         return;
    }
    var subjectFrom=win[0];
    
    var command=new L5.Command("org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefCmd");
    command.setParameter("procTypeId",rec.get("procTypeId"));
    command.setParameter("procTypeSubjectFrom",subjectFrom);
    command.execute("saveProcTypeSubjectScType");
    if(!command.error){
    	   procTypeSubjectDefQueryDataset.reload();
     }
    else{
       alert(command.error);
    }
}
//流程类型标题定义
function procSubjectDef()
{
	var procTypeSubjectDefQueryGridPanel=L5.getCmp('procTypeSubjectDefQueryGridPanel');
	var selected = procTypeSubjectDefQueryGridPanel.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示", "请选择一条记录进行处理!");
		return;
	}
	var rec=selected[0];
	var procTypeSubjectFrom=rec.get("procTypeSubjectFrom");
	if(procTypeSubjectFrom=="-1")
	{
		var subjectfromurl ="../subjectfromdef.jsp";
		var win = showModalDialog(subjectfromurl,window,"scroll:yes;status:no;dialogWidth:300px;dialogHeight:100px"); 
	    if (!win) {  
	         return;
	    }
	    var subjectFrom=win[0];
	    
	    var command=new L5.Command("org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.cmd.ProcTypeSubjectDefCmd");
	    command.setParameter("procTypeId",rec.get("procTypeId"));
	    command.setParameter("procTypeSubjectFrom",subjectFrom);
	    command.execute("saveProcTypeSubjectScType");
	    if(!command.error){
	    	if(subjectFrom=="0")
	    	{
	    		url="jsp/workflow/tasklist/definition/proctypesubjectdef/proctypesubjectdefdetailinfowithbiztable.jsp?procTypeId="+rec.get("procTypeId");
	    	}
	    	else if(subjectFrom=="1")
	    	{
	    		url="jsp/workflow/tasklist/definition/proctypesubjectdef/proctypesubjectdefdetailinfowithformfield.jsp?procTypeId="+rec.get("procTypeId");
	    	}
	     }
	    else{
	       alert(command.error);
	    }
	}
	if(procTypeSubjectFrom=="0")
	{
		url="jsp/workflow/tasklist/definition/proctypesubjectdef/proctypesubjectdefdetailinfowithbiztable.jsp?procTypeId="+rec.get("procTypeId");
	}
	else if(procTypeSubjectFrom=="1")
	{
		url="jsp/workflow/tasklist/definition/proctypesubjectdef/proctypesubjectdefdetailinfowithformfield.jsp?procTypeId="+rec.get("procTypeId");
	}
	L5.forward(url,"流程类型任务标题");
}
//预览流程类型标题
function forPreview() {
	var procTypeSubjectDefQueryGridPanel=L5.getCmp('procTypeSubjectDefQueryGridPanel');
	var selected = procTypeSubjectDefQueryGridPanel.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示", "请选择要预览的流程类型!");
		return false;
	}
	var rec=selected[0];
	var url="jsp/workflow/tasklist/definition/proctypesubjectdef/proctypesubjectdefpreview.jsp?procTypeId="+rec.get("procTypeId");
	L5.forward(url,"流程类型任务标题预览");
}
//设置流程来源标题显示名称
function setProcTypeSubjectFrom(rec)
{
  //来自业务表
  if(rec=="0"){
	  return "业务表";	
   }
  //来自表单域
  else if(rec=="1"){
	   return "表单域";
   }
  //未设置
   else if(rec=="-1")
   {
	   return "未定义";
   }
}
function init()
{
	procTypeSubjectDefQueryDataset.load();
}
//查询指定流程类型的标题
function query()
{
   var procTypeNameQuery=document.getElementById("procTypeNameQuery").value;
   if(procTypeNameQuery.indexOf("'")!=-1){
		  L5.Msg.alert("提示", "不接受单引号输入!");
		  return;
	}
   procTypeSubjectDefQueryDataset.setParameter("procTypeName",procTypeNameQuery); 
   procTypeSubjectDefQueryDataset.load();
}
//查询条件面板打开合并函数
function collapse(element)
{
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
</html>