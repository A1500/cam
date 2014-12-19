<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.List"%>
<HTML>
<%
  String assignmentId=(String)request.getParameter("assignmentId");
  if(assignmentId==null||"".equals(assignmentId))
  {
	  assignmentId=(String)request.getAttribute("assignmentId"); 
  }	  
  if(assignmentId==null)
	  assignmentId="";
%>
<HEAD>
<TITLE>选择跳转环节以及参与者</TITLE>
<next:ScriptManager></next:ScriptManager>
</HEAD>
<BODY style="margin:0px;padding: 0px;">
<model:datasets>
	<model:dataset id="actDataSet"
		cmd="org.loushang.workflow.client.common.help.cmd.TaskHelpCmd" global="true" autoLoad="true" method="selectJumpActivitiesAndEmployees">
		<model:record >
			<model:field name="text" mapping="actDefName" type="string"></model:field>
			<model:field name="value" mapping="actDefUniqueId" type="string"></model:field>
			<model:field name="actDefId" type="string"></model:field>
			<model:field name="actType"  type="string"></model:field>
		</model:record>
	</model:dataset>
	<model:dataset pageSize="10" id="partiesDataset" cmd="org.loushang.workflow.client.common.help.cmd.TaskHelpCmd" method="selectActivityEmployees">
		<model:record >
			<model:field name="organId"  type="string"></model:field>
			<model:field name="organName"  type="string"></model:field>
		</model:record>
	</model:dataset>
	</model:datasets>

	<div style="width:100%;border:1px;background-color:#d4e1f1;">
		<div class="FieldLabel" style="width:60%;text-align:left;float:left">选择跳转环节:
			<select name="actDefInfo" id="actDefInfo" style="width:200" onchange="selectedActChanged();">
				<option dataset="actDataSet" ></option>
			</select>
		</div>
		<div style="width:40%;float:right;text-align:right;">
			<input class="FieldButton" type="button" value="确定" onclick="confirmSelect()"/>
			<input class="FieldButton" type="button" value="取消" onclick="cancleSelect()"/>
		</div>
	</div>
	<next:Panel  height="100%">
		<next:Html>
    		<next:GridPanel id="userGridPanel" height="400" width="100%" name="partiesGridPanel"  dataset="partiesDataset"     title="参与者选择" notSelectFirstRow="true">
				<next:Columns>
	    			<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column id="organId" header="参与者ID" field="organId" width="50" hidden="true">
					<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="参与者名称" field="organName" width="100%">
						<next:TextField allowBlank="false"/>
					</next:Column>
				</next:Columns>
			</next:GridPanel>
   		</next:Html>
	</next:Panel>
</BODY>
</HTML>
<script language="javascript">
var assignmentId="<%=assignmentId%>";

function cancleSelect(){
	parent.close();
}

function confirmSelect(){}

function selectedActChanged(){
	var actDefInfo=document.getElementById("actDefInfo").value;
	if(actDefInfo==null||actDefInfo=="")
	{
		alert("请先选择环节!");
		return;
	}
	var record = actDataSet.getById(actDefInfo);

	var actDefUniqueId=actDefInfo;
	var actType=record.get("actType");

	if(actType=="1"||actType=="3")
	{
		alert("您选择的环节类型没有参与者");
		return;
	}
	var partiesDataset = L5.DatasetMgr.lookup("partiesDataset");
	partiesDataset.baseParams["assignmentId"]=assignmentId;
	partiesDataset.baseParams["actDefUniqueId"]=actDefUniqueId;
	partiesDataset.load();
}

function confirmSelect(){
	var actDefInfo=document.getElementById("actDefInfo").value;
	if(actDefInfo==null||actDefInfo=="")
	{
		alert("请先选择环节!");
		return;
	}
	var userGridPanel=L5.getCmp('userGridPanel');
    var participants=userGridPanel.getSelectionModel().getSelections();
    if(participants.length<1)
    {
		alert("请选择参与者！");
		return ;
    }
    var organIds="";
    var organNames="";
    for(i=0;i<participants.length;i++)
    {
		organIds+=participants[i].get("organId");
		organNames+=participants[i].get("organName");
		if(i<participants.length-1)
		{
			organIds+=",";
			organNames+=",";
		}
    }
	var returnV=new Array(4);
	var record = actDataSet.getById(actDefInfo);
	returnV[0]=actDefInfo;
	returnV[1]=organIds;
	returnV[2]=organNames;
	returnV[3]=record.get("text");
	parent.returnValue=returnV;
	parent.close();
}
</script>