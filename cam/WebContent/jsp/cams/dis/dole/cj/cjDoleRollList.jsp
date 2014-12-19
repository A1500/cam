<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
<head>
<title>灾区民房恢复重建-资金发放名册管理</title>
<next:ScriptManager />
<script language="javascript">
	 var organCode = '<%=BspUtil.getOrganCode()%>';
	 var organName = '<%=BspUtil.getOrganName()%>';
     var organType = '<%=BspUtil.getOrganType()%>';
     var ifPrint = '<%=request.getParameter("ifPrint")%>';
     var ifDetail = '<%=request.getParameter("ifDetail")%>';
     var ifFill = '<%=request.getParameter("ifFill")%>';
     var batchId = '<%=request.getParameter("batchId")%>';
     var batchDetailId = '<%=request.getParameter("batchDetailId")%>';
     var doleId = '<%=request.getParameter("doleId")%>';
     var uu32='<%=IdHelp.getUUID32()%>';
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
</script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript" src="../../comm/disComm.js"></script>
<script type="text/javascript" src="cjDoleRollList.js"></script>
</head>
<body>
<model:datasets>
	<!-- 档案信息 -->
	<model:dataset id="infoDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCmd"
		method="queryReliefInfo" global="true" pageAble="false">
	</model:dataset>
	<!-- 发放流水信息 -->
	<model:dataset id="doleDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefDoleQueryCmd" global="true"
		pageAble="false">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefDole">
			<model:field name="fillPeopleName" type="string" rule="require"></model:field>
			<model:field name="fillTime" type="string" rule="require"></model:field>
		</model:record>
	</model:dataset>
	<!--批次-->
	<model:dataset id="batchds"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchQueryCmd"
		global="true" pageAble="false">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefBatch">
		</model:record>
	</model:dataset>
	<!--拨付使用资金关系表-->
	<model:dataset id="disFundsBatchSourceDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd"
		method="queryFundsBatchSource" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>
	<!-- 资金来源类型 -->
	<model:dataset id="disSourceTypeDs" enumName="DIS.SOURCE_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="disAllocationPurposeDs"
		enumName="DIS.ALLOCATION_PURPOSE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 资金类型 -->
	<model:dataset id="disAllocationTypeDs" enumName="DIS.ALLOCATION_TYPE"
		autoLoad="true" global="true">
	</model:dataset>

	<!-- 提交状态 -->
	<model:dataset id="ReliefinfoWorkflowState"
		enumName="DIS.RELIEFINFO_WORKFLOW_STATE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 灾害类型 -->
	<model:dataset id="DisDisasterType" enumName="DIS.DISASTER_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 家庭类型 -->
	<model:dataset id="DisFamilyType" enumName="DIS.FAMILY_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
</model:datasets>
<next:Panel name="form" width="100%" border="0" autoHeight="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem id="btnSave" text="保存" iconCls="add" handler="save" />
		<next:ToolBarItem id="btnConfirm" text="确认" iconCls="edit"
			handler="inConfirm" />
		<next:ToolBarItem text="导出Excel" iconCls="export" handler="forExcel" />
		<next:ToolBarItem id="btnPrint" text="打印救助卡" iconCls="print"
			handler="printCard" />
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"
			dataset="doleDs">
		<table border="0" width="100%">
			<tr>
				<td class="FieldLabel">发放人:</td>
				<td class="FieldInput"><input type="text" id="fillPeopleName"
					field="fillPeopleName" class="TextEditor" title="发放人"/><font color="red">*</font></td>
				<td class="FieldLabel">发放日期:</td>
				<td class="FieldInput"><input type="text" id="fillTime" field="fillTime"
					title="发放日期" format="Y-m-d" style="width: 100px;" maxlength="10"
					onpropertychange="changeDateStyle(this)" /><img id="timeImg"
					src="../../../../../skins/images/default/rl.gif" align="middle"
					onclick="getTimes(this);" /><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel">备注:</td>
				<td class="FieldInput" colspan="3"><input type="text" id="note"
					field="note" class="TextEditor" title="备注" style="width: 80%" /></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="cjGrid" name="cjGrid" width="100%"
	clickToSelectedForChkSM="true" stripeRows="true" height="100%"
	dataset="infoDs" notSelectFirstRow="true" hasSum="true">
	<next:TopBar>
		<next:ToolBarItem text="救助名册列表信息" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="40" header="序号" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="NAME" header="户主姓名" field="NAME" width="90"></next:Column>
		<next:Column id="ID_CARD" header="身份证号码" field="ID_CARD" width="135"></next:Column>
		<next:Column id="FAMILY_TYPE" header="家庭类型" field="FAMILY_TYPE"
			width="80" dataset="DisFamilyType" align="center"></next:Column>
		<next:Column id="yhTr" header="开户银行" field="BANK" width="120"
			align="left"></next:Column>
		<next:Column id="yhTr2" header="开户银行帐号" field="ACCOUNT_CODE"
			width="120" align="left"></next:Column>
		<next:Column id="APPROVAL_REBUILED_HOUSE" header="核准重建间数（间）"
			field="APPROVAL_REBUILED_HOUSE" width="130" align="right"></next:Column>
		<next:Column id="APPROVAL_REPAIRED_HOUSE" header="核准修缮间数（间）"
			field="APPROVAL_REPAIRED_HOUSE" width="130" align="right"></next:Column>
		<next:Column id="APPROVAL_MONEY" header="核准救助资金（元）"
			field="APPROVAL_MONEY" width="130" align="right" summaryType="sum"
			editable="false" renderer="formatMoneyForDis">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
		</next:Column>
		<next:Column id="AMOUNT" header="实际发放金额(元)" field="AMOUNT"
			width="120" align="right" summaryType="sum" renderer="formatMoneyForDis">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="infoDs" />
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>


<!--使用资金选择窗口-->
<next:Window id="fundsWin" width="850" height="550" collapsible="false"
	closable="close" resizable="false" modal="true" title="发放确认划拨资金维护">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存确认" handler="onSaveConfirm"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="取消确认" handler="onCancel"></next:ToolBarItem>
	</next:TopBar>
	<next:Panel width="100%" height="100%">
		<next:Panel>
			<next:Html>
				<form method="post" onsubmit="return false" class="L5form">
				<table border="0" width="100%">
					<tr>
						<td class="FieldLabel" width="15%">发放金额:</td>
						<td class="FieldInput"><label id="doleMoney" /></td>
						<td class="FieldLabel" width="15%">发放记录数:</td>
						<td class="FieldInput"><label id="doleNums" /></td>
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
		<next:EditGridPanel id="winGrid" dataset="disFundsBatchSourceDs"
			height="455" width="98%" hasSum="true" stripeRows="true"
			notSelectFirstRow="true">
			<next:TopBar>
				<next:ToolBarItem text="使用资金明细(明细支出金额总和与发放金额绑定)"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn width="45" />
				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column id="sourceId" header="来源表ID" field="sourceId"
					align="center" hidden="true">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column id="disYear" header="年度" field="disYear" align="center"
					width="60">
					<next:TextField allowBlank="false" editable="false" />
				</next:Column>
				<next:Column id="sourceType" header="来源类型" field="sourceType"
					align="center" width="80" dataset="disSourceTypeDs">
					<next:TextField allowBlank="false" editable="false" />
				</next:Column>
				<next:Column id="allocationTime" header="拨款日期"
					field="allocationTime" align="center" width="80">
					<next:TextField allowBlank="false" editable="false" />
				</next:Column>
				<next:Column id="upAllocationNum" header="拨款文号"
					field="upAllocationNum" align="left" width="80">
					<next:TextField allowBlank="false" editable="false" />
				</next:Column>
				<next:Column id="upAllocationType" header="拨款类型"
					field="upAllocationType" align="center" width="80"
					dataset="disAllocationTypeDs">
					<next:TextField allowBlank="false" editable="false" />
				</next:Column>

				<next:Column id="amountBalanceTotal" header="可用金额(万元)"
					field="amountBalanceTotal" align="right" width="90"
					renderer="formatMoneyForDis" summaryType="sum">
					<next:ExtendConfig>
	                    	summaryRenderer : formatMoneyForDis
	                	</next:ExtendConfig>
					<next:TextField allowBlank="false" editable="false" />
				</next:Column>
				<next:Column id="amountPay" header="<b>支出金额(万元)</b>"
					field="amountPay" align="right" width="95" renderer="formatMoneyForDis"
					summaryType="sum">
					<next:ExtendConfig>
	                    	summaryRenderer : formatMoneyForDis
	                	</next:ExtendConfig>
					<next:TextField allowBlank="false" />
				</next:Column>

				<next:Column id="upAllocationPurpose" header="资金用途"
					field="upAllocationPurpose" align="left" width="100"
					renderer="upAllocationPurposeRenderer">
					<next:TextField allowBlank="false" editable="false" />
				</next:Column>
				<next:Column id="note" header="备注" field="note" align="left"
					width="90" renderer="noteRenderer">
					<next:TextField allowBlank="false" editable="false" />
				</next:Column>
			</next:Columns>
		</next:EditGridPanel>
	</next:Panel>
</next:Window>