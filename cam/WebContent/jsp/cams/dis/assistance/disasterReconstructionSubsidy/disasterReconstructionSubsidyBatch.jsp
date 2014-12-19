<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");  
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");  
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
	response.setHeader("Pragma", "no-cache");  
%>
<html>
	<head>
		<title>灾区民房恢复重建补助批次表</title>
		<next:ScriptManager/>
		<script language="javascript">
   			var userOrganCode = '<%=BspUtil.getOrganCode()%>';
		 	 //查询条件打开合并函数
			 function collapse(element){
				var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){
					fieldsetParent.getElementsByTagName("div")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("div")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
					element.expand =true;
				}
			}
			 var organCode = '<%=BspUtil.getOrganCode()%>';
			 var struId='<%=BspUtil.getStruId()%>';
             var organType='<%=BspUtil.getOrganType()%>';
		</script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
		<script type="text/javascript" src="disasterReconstructionSubsidyBatch.js"></script>	
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchDetailQueryCommand" method="queryAssistanceBatch" sortField="FILL_TIME" sortDirection="DESC"  global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefBatchDetail">
			<model:field name="batchDetailId" type="string" mapping="BATCH_DETAIL_ID"></model:field>
			<model:field name="reliefType" type="string" mapping="RELIEF_TYPE"></model:field>
			<model:field name="batchId" type="string" mapping="BATCH_ID"></model:field>
			<model:field name="batchName" type="string" mapping="BATCH_NAME"></model:field>
			<model:field name="requiredOrganCode" type="string" mapping="REQUIRED_ORGAN_CODE"></model:field>
			<model:field name="requiredOrganName" type="string" mapping="REQUIRED_ORGAN_NAME"></model:field>
			<model:field name="fillState" type="string" mapping="FILL_STATE"></model:field>
		</model:record>
	</model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="ReliefTypeDataset" enumName="DIS.ALLOCATION_PURPOSE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 填报状态 -->
	<model:dataset id="BatchdetailFillState" enumName="DIS.BATCHDETAIL_FILL_STATE" autoLoad="true" global="true">
	</model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
					onclick="collapse(this)"/> </legend>
				<div>
					<form style="width: 95%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel" nowrap="nowrap">批次名称：</td>
								<td class="FieldInput"><input type="text"  id="cx_batchName" class="TextEditor" title="批次名称" />
								
								<td class="FieldLabel"><button onclick="query()" id="search">查 询</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="disasterReconstructionSubsidyBatchGrid" name="disasterReconstructionSubsidyBatchGrid" width="100%" clickToSelectedForChkSM="true" stripeRows="true" height="100%" dataset="ds"
	notSelectFirstRow="false">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="提交" iconCls="select" handler="selectBatch" id="selectBatch"/>
		<next:ToolBarItem text="办理" iconCls="detail" handler="detail" id="detail"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="40" header="序号"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="batchDetailId" header="批次明细ID" field="batchDetailId" hidden="true"></next:Column>
		<next:Column id="reliefType" header="救助类型" field="reliefType" width="180" dataset="ReliefTypeDataset"></next:Column>
		<next:Column id="batchId" header="批次号" field="batchId" width="90" hidden="true"></next:Column>
		<next:Column id="batchName" header="批次名称" field="batchName" width="90"></next:Column>
		<next:Column id="requiredOrganCode" header="所需填报单位区划" field="requiredOrganCode" width="90" hidden="true"></next:Column>
		<next:Column id="requiredOrganName" header="所需填报单位名称" field="requiredOrganName" width="200"></next:Column>
		<next:Column id="fillState" header="填报状态" field="fillState" width="90" dataset="BatchdetailFillState"></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>