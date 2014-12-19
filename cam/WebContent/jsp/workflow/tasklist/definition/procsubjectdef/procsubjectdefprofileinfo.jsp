<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.*"%>

<html>
	<head><style>a{TEXT-DECORATION:none}</style>
		<title>流程定义层次任务标题概要信息</title>
		<next:ScriptManager></next:ScriptManager>
	</head>
<body>

<model:datasets>
	<model:dataset pageSize="15" id="procSubjectDefQueryDataset" cmd="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefQueryCmd" autoLoad="false" method="getAllProcSubjectDefProfileInfo" global="true">
		<model:record>
			<model:field name="procDefUniqueId" type="string" />
			<model:field name="procDefName" type="string" />
			<model:field name="procCreateTime" type="string" />
			<model:field name="procSubjectFrom" type="string" />
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
									<td class="FieldLabel" width="15%">流程名称：</td>
									<td class="FieldInput"><input type="text"  id="procDefNameQuery" class="TextEditor" title="流程名称"  size="40"/></td>
									<td class="FieldButton" width="15%"><button onclick="query()">查询</button> </td>
								</tr>
							</table>
						</form>		
					</div>
				</fieldset>
				</next:Html>
			</next:Panel>	
			<next:GridPanel id="procSubjectDefQueryGridPanel" name="procSubjectDefQueryGridPanel" anchor="100%" height="100%" dataset="procSubjectDefQueryDataset"     title="标题概要信息" notSelectFirstRow="true">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column  header="内码" field="procDefUniqueId" width="50" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="流程名称" field="procDefName" width="150">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="流程创建时间" field="procCreateTime" width="150" >
						<next:TextField allowBlank="false"/>
					</next:Column>	
					<next:Column header="标题来源" field="procSubjectFrom" width="150" renderer="setProcSubjectFrom">
						<next:TextField allowBlank="false"/>
					</next:Column>
				</next:Columns>
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>	
                    <next:ToolBarItem iconCls="add"  text="标题来源定义" handler="procSubjectFromDef"/>
				    <next:ToolBarItem iconCls="add"  text="标题定义" handler="procSubjectDef"/>	
                    <next:ToolBarItem iconCls="detail"  text="预览" handler="preview"></next:ToolBarItem>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="procSubjectDefQueryDataset"/>
				</next:BottomBar>
			</next:GridPanel>
			</next:AnchorLayout>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script language="javascript"  type="text/javascript" >
//流程标题来源定义
function procSubjectFromDef()
{
	var procSubjectDefQueryGridPanel=L5.getCmp('procSubjectDefQueryGridPanel');
	var selected = procSubjectDefQueryGridPanel.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示", "请选择一条记录进行处理!!");
		return;
	}
	var rec=selected[0];
	var subjectfromurl ="../subjectfromdef.jsp";
	var win = showModalDialog(subjectfromurl,window,"scroll:yes;status:no;dialogWidth:300px;dialogHeight:100px"); 
    if (!win) {  
         return;
    }
    var subjectFrom=win[0];
    
    var command=new L5.Command("org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefCmd");
    command.setParameter("procDefUniqueId",rec.get("procDefUniqueId"));
    command.setParameter("procSubjectFrom",subjectFrom);
    command.execute("saveProcSubjectScType");
    if(!command.error){
    	   procSubjectDefQueryDataset.reload();
     }
    else{
       alert(command.error);
    }
}
//流程标题定义
function procSubjectDef()
{
	var procSubjectDefQueryGridPanel=L5.getCmp('procSubjectDefQueryGridPanel');
	var selected = procSubjectDefQueryGridPanel.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示", "请选择一条记录进行处理!");
		return;
	}
	var rec=selected[0];
	var procSubjectFrom=rec.get("procSubjectFrom");
	if(procSubjectFrom=="-1")
	{
		var subjectfromurl ="../subjectfromdef.jsp";
		var win = showModalDialog(subjectfromurl,window,"scroll:yes;status:no;dialogWidth:300px;dialogHeight:100px"); 
	    if (!win) {  
	         return;
	    }
	    var subjectFrom=win[0];
	    
	    var command=new L5.Command("org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefCmd");
	    command.setParameter("procDefUniqueId",rec.get("procDefUniqueId"));
	    command.setParameter("procSubjectFrom",subjectFrom);
	    command.execute("saveProcSubjectScType");
	    if(!command.error){
	    	if(subjectFrom=="0")
	    	{
	    		url="jsp/workflow/tasklist/definition/procsubjectdef/procsubjectdefdetailinfowithbiztable.jsp?procDefUniqueId="+rec.get("procDefUniqueId");
	    	}
	    	else if(subjectFrom=="1")
	    	{
	    		url="jsp/workflow/tasklist/definition/procsubjectdef/procsubjectdefdetailinfowithformfield.jsp?procDefUniqueId="+rec.get("procDefUniqueId");
	    	}
	     }
	    else{
	       alert(command.error);
	    }
	}
	if(procSubjectFrom=="0")
	{
		url="jsp/workflow/tasklist/definition/procsubjectdef/procsubjectdefdetailinfowithbiztable.jsp?procDefUniqueId="+rec.get("procDefUniqueId");
	}
	else if(procSubjectFrom=="1")
	{
		url="jsp/workflow/tasklist/definition/procsubjectdef/procsubjectdefdetailinfowithformfield.jsp?procDefUniqueId="+rec.get("procDefUniqueId");
	}	
	L5.forward(url,"流程定义任务标题");
}
//预览流程定义标题
function preview() {
	var procSubjectDefQueryGridPanel=L5.getCmp('procSubjectDefQueryGridPanel');
	var selected = procSubjectDefQueryGridPanel.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示", "请选择要预览的流程!");
		return false;
	}
	var rec=selected[0];
	var url="jsp/workflow/tasklist/definition/procsubjectdef/procsubjectdefpreview.jsp?procDefUniqueId="+
			rec.get("procDefUniqueId");
	L5.forward(url,"流程定义任务标题预览");
}
//设置流程来源标题显示名称
function setProcSubjectFrom(rec)
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
	procSubjectDefQueryDataset.load();
}
//查询指定流程的标题
function query()
{
   var procDefNameQuery=document.getElementById("procDefNameQuery").value;
   if(procDefNameQuery.indexOf("'")!=-1){
		  L5.Msg.alert("提示", "不接受单引号输入!");
		  return;
	}
   procSubjectDefQueryDataset.setParameter("procDefName",procDefNameQuery); 
   procSubjectDefQueryDataset.load();
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