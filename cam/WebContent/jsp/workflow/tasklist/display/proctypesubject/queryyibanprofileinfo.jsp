<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>

<html>
	<head><style>a{TEXT-DECORATION:none}</style>
		<title>已办任务概要信息查询</title>
		<next:ScriptManager></next:ScriptManager>
	</head>
<body>

<model:datasets>
	<model:dataset pageSize="10" id="yiBanProfileInfoDataset" cmd="org.loushang.workflow.tasklist.taskinfo.cmd.YiBanTaskQueryCmd" autoLoad="true" method="queryProcTypeYiBanTaskTableProfileInfo" global="true">
		<model:record>
			<model:field name="procTypeId" type="string" />
			<model:field name="procTypeName" type="string" />
			<model:field name="yiBanTaskCount" type="string" />
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
									<td class="FieldInput"><input type="text"  id="procTypeQueryName" class="TextEditor" title="流程类型名称"  size="40"/></td>
									<td class="FieldButton" width="15%"><button onclick="query()">查询</button> </td>
								</tr>
							</table>
						</form>		
					</div>
				</fieldset>
				</next:Html>
			</next:Panel>
			<next:GridPanel id="yiBanTaskGridPanel" name="yiBanTaskGridPanel" anchor="100%" height="100%" dataset="yiBanProfileInfoDataset"     title="已办任务概要信息列表" notSelectFirstRow="true">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="procTypeId" header="内码" field="procTypeId" width="50" hidden="true" >
					<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="流程类型名称" field="procTypeName" width="150" renderer="addLink">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="已办任务个数" field="yiBanTaskCount" width="150" renderer="addLink">
						<next:TextField allowBlank="false"/>
					</next:Column>	
				</next:Columns>
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>			
					<next:ToolBarItem iconCls="select"  text="查看详细信息" handler="handle"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="yiBanProfileInfoDataset"/>
				</next:BottomBar>
			</next:GridPanel>
			</next:AnchorLayout>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script language="javascript"  type="text/javascript" >
 //查询条件面板打开合并函数
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
//已办任务概要信息查询
function query(){
	var procTypeQueryName=document.getElementById("procTypeQueryName").value;
	if(procTypeQueryName.indexOf("'")!=-1){
		  L5.Msg.alert("提示", "不接受单引号输入!");
		  return;
	}
	if(procTypeQueryName!="")
	{
		yiBanProfileInfoDataset.setParameter("procTypeName",procTypeQueryName);
	}
	yiBanProfileInfoDataset.load();
}
//通过链接查看已办任务详细信息
function addLink(value,second,record)
{
	var procTypeId=record.get("procTypeId");
	return "<a href=\"javascript:viewYiBanTaskDetaiInfo('"+procTypeId+"')\">"+value+"</a>";
}

//通过按钮查看已办任务详细信息
function handle()
{
	var userGrid=L5.getCmp('yiBanTaskGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		alert("请选择一条记录进行处理!");
		return false;
	}
	var rec=selected[0];
	viewYiBanTaskDetaiInfo(rec.get("procTypeId"));
}

//查看已办任务详细信息
function viewYiBanTaskDetaiInfo(procTypeId)
{			
	var url="jsp/workflow/tasklist/display/proctypesubject/queryyibandetailinfo.jsp";
	var query="?procTypeId="+procTypeId;
	L5.forward(url+query,"已办任务详细信息");
}
</script>
</html>