<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>结束流程实例列表</title>
		<next:ScriptManager/>
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
			function query(){
				if($("SUBJECT")!=undefined&&$("SUBJECT")!="")
					ds.setParameter("VALUE@like",$("SUBJECT"));
				if($("CREATE_TIME")!=undefined&&$("CREATE_TIME")!="")
					ds.setParameter("CREATE_TIME@>",$("CREATE_TIME"));
				if($("END_TIME")!=undefined&&$("END_TIME")!="")
					ds.setParameter("END_TIME@<",$("END_TIME"));
				if($("RESOURCE_REQ_NAME")!=undefined&&$("RESOURCE_REQ_NAME")!="")
					ds.setParameter("RESOURCE_REQ_NAME@=",$("RESOURCE_REQ_NAME"));
				if($("PROCESS_TYPE")!=undefined&&$("PROCESS_TYPE")!="")
					ds.setParameter("PROCESS_TYPE@=",$("PROCESS_TYPE"));;
				ds.setParameter("isWithLinkToTheLastActEndTaskForm","<%=request.getParameter("isWithLinkToTheLastActEndTaskForm")%>");;
				ds.load();
			}
			function $(id){
				return document.getElementById(id).value;
			}
			function selectProcessType()
			{
				var processTypeurl ="../../processtype/queryhelp.jsp";
				var win = showModalDialog(processTypeurl,window,"scroll:yes;status:no;dialogWidth:500px;dialogHeight:450px"); 
			    if (win == null) {  
			         return;
			    }
			    document.getElementById("PROCESS_TYPE").value=win[0];
			    document.getElementById("PROCESS_TYPE_NAME").value=win[1];
			}
			function processTypeChangedHandler(){
				if($("PROCESS_TYPE_Name")==undefined||$("PROCESS_TYPE_Name")=="")
					document.getElementById("PROCESS_TYPE").value="";
			}

			function init(){
				var process_type="<%=request.getParameter("processType")%>";
				if(process_type!=undefined&&process_type!=""&&process_type!="null")
				{
					ds.setParameter("PROCESS_TYPE@=",process_type);
					document.getElementById("PROCESS_TYPE").value=process_type;
					var cmd=new L5.Command("org.loushang.workflow.processtype.cmd.ProcessTypeCmd");
					cmd.setParameter("typeId",process_type);
					cmd.execute("get");
					if(!cmd.error)
					{
						document.getElementById("PROCESS_TYPE_Name").value=cmd.getReturn("processTypeName");;
					}
				}
				ds.setParameter("isWithLinkToTheLastActEndTaskForm","<%=request.getParameter("isWithLinkToTheLastActEndTaskForm")%>");;
				ds.load();
			}
			
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" pageSize="10" cmd="org.loushang.workflow.client.common.help.cmd.QueryProcessEndCmd" global="true">
		<model:record>
			<model:field name="processId" type="string" />
			<model:field name="subject" type="string" />
			<model:field name="processName" type="string" />
			<model:field name="processType" type="string" />
			<model:field name="createOrganName" type="string" />
			<model:field name="procCreateTime" type="string" />
			<model:field name="procEndTime" type="string" />
			<model:field name="endTaskForwardUrl" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox">
		<legend class="GroupBoxTitle">查询条件<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/></legend>
		<div class="GroupBoxDiv" style="width: 100%;height: 100%;">
			<form onsubmit="return false;"  class="L5form">
				<table  border="1" width="100%" >
					<tr >
						<td class="FieldLabel">标题:</td>
						<td class="FieldInput"><input type="text"  id="SUBJECT" class="TextEditor" title="标题" /></td>
						<td class="FieldLabel">开始时间:</td>
						<td class="FieldInput"><input type="text"  id="CREATE_TIME" class="TextEditor" title="开始时间" onclick="LoushangDatetime(this)" /></td>
						<td class="FieldLabel">结束时间:</td>
						<td class="FieldInput"><input type="text"  id="END_TIME" class="TextEditor" title="结束时间" onclick="LoushangDatetime(this)" /></td>
					</tr>
					<tr >
						<td class="FieldLabel">发起人:</td>
						<td class="FieldInput"><input type="text"  id="RESOURCE_REQ_NAME" class="TextEditor" title="发起人" /></td>
						<td class="FieldLabel">流程类型:</td>
						<td class="FieldInput">
							<input type="hidden"  id="PROCESS_TYPE" class="TextEditor" title="流程类型" />
							<input type="text"  id="PROCESS_TYPE_Name" class="TextEditor" onchange="processTypeChangedHandler()" title="流程类型" />
							<button onclick="selectProcessType()">选择</button> 
						</td>
						<td class="FieldLabel"></td>
						<td class="FieldInput"><button onclick="query()">查 询</button> </td>
					</tr>
				</table></form></div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="processEndGrid" name="processEndGrid" width="100%" stripeRows="true" height="100%"
dataset="ds" title="结束流程实例" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="确定" handler="confirmSelect"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:RadioBoxColumn  ></next:RadioBoxColumn>
		<next:Column id="vprocessId" header="流程实例ID" field="processId" width="200" hidden="true">
		</next:Column>
		<next:Column id="vsubject" header="标题" field="subject" width="200" renderer="addEndTaskForwardUrlLink">
		</next:Column>
		<next:Column id="vprocDefName" header="流程名称" field="processName" width="200" renderer="addSubjectLink">
		</next:Column>
		<next:Column id="vprocessType" header="流程类型" field="processType" width="200" >
		</next:Column>
		<next:Column id="vcreateOrganName" header="流程发起人" field="createOrganName" width="200" >
		</next:Column>
		<next:Column id="vcreateTime" header="开始时间" field="procCreateTime"  width="150" >
		</next:Column>
		<next:Column id="vendTime" header="结束时间" field="procEndTime" width="150" >
		</next:Column>
		<next:Column id="vendTaskForwardUrl" header="结束任务转向URL" field="endTaskForwardUrl" width="150" hidden="true" >
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>

<script language="javascript"  type="text/javascript" >
	var isWithLinkToTheLastActEndTaskForm='<%=request.getParameter("isWithLinkToTheLastActEndTaskForm")%>';
	function confirmSelect(){
		var processEndGrid=L5.getCmp('processEndGrid');
	    var processEnds=processEndGrid.getSelectionModel().getSelections();
	    if(processEnds.length<1)
	    {
			alert("请选择流程实例！");
			return ;
	    }
	    var processEnd=processEnds[0];
		var returnV=new Array(4);
		returnV[0]=processEnd.get("processId");
		returnV[1]=processEnd.get("subject");
		parent.returnValue=returnV;
		parent.close();
	}
	function addEndTaskForwardUrlLink(value,second,record)
	{
		if(isWithLinkToTheLastActEndTaskForm=="true")
		{
			var endTaskForwardUrl=record.get("endTaskForwardUrl");
			return "<a href=\"javascript:forwardToEndTaskForwardUrl('"+endTaskForwardUrl+"')\">"+value+"</a>";
		}
		return value;

	}
	function addSubjectLink(value,second,record)
	{
	  var processId=record.get("processId");
	  return "<a href=\"javascript:showProcessInstanceFlowView('"+processId+"')\">"+value+"</a>";

	}

	function forwardToEndTaskForwardUrl(endTaskForwardUrl)
	{
	  var url="<%=request.getContextPath()%>"+"/"+endTaskForwardUrl;
	  showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:950px;dialogHeight:650px"); 
	}
	function showProcessInstanceFlowView(processId)
	{
	  var url="../../monitor/flowview.jsp?processId="+processId;
	  showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:950px;dialogHeight:650px"); 
	}
			
</script>