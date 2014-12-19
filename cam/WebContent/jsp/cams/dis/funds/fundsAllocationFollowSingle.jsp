<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
<head>
<title>单笔资金拨付进度追踪</title>
<next:ScriptManager />
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript">
	var organCode='<%=BspUtil.getOrganCode()%>';
	var organName='<%=BspUtil.getOrganName()%>';
	var organType='<%=BspUtil.getOrganType()%>';
	var sourceId = '<%=request.getParameter("sourceId")%>';
</script>
<script type="text/javascript" src="fundsComm.js"></script>
<script type="text/javascript" src="../comm/disComm.js"></script>
<script type="text/javascript" src="fundsAllocationFollowSingle.js"></script>
<script language="javascript">
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
</head>
<body>
<model:datasets>
	<!--拨付-->
	<model:dataset id="disFundsSourceDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd" pageAble="false" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>
	
	<!--拨付明细汇总-->
	<model:dataset id="disFundsSourceFollowDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd" method="queryFundsFollow"
		pageAble="false" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>
	<!--拨付明细-->
	<model:dataset id="disFundsSourceFollowDetailDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd" method="queryFundsFollowDetail"
		pageAble="false" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>
	
	<!--资金拨付追踪-->
	<model:dataset id="disFundsSourceAlloDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd" method="queryFundsFollowAllo"
		pageAble="false" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>
	<!--物资折款追踪-->
	<model:dataset id="disFundsSourceSwapDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd" method="queryFundsFollowSwap"
		pageAble="false" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>
	
	<!-- 资金来源类型 -->
	<model:dataset id="disSourceTypeDs" enumName="DIS.SOURCE_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 预算类型 -->
	<model:dataset id="disBudgetType" enumName="DIS.BUDGET_TYPE"
		global="true" autoLoad="true">
	</model:dataset>
	<!-- 采购方式 -->
	<model:dataset id="disSwapTypeDs" enumName="DIS.SWAP_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="commYesOrNoDS" enumName="COMM.YESORNO"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 资金类型 -->
	<model:dataset id="disAllocationTypeDs" enumName="DIS.ALLOCATION_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="disAllocationPurposeDs"
		enumName="DIS.ALLOCATION_PURPOSE" autoLoad="true" global="true">
	</model:dataset>
</model:datasets>

<next:ViewPort>
	<!--记录明细-提示-->
	<next:Panel id="singleSourcePanel" title="资金明细">
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="disFundsSourceDs">
			<table border="0" width="100%">
				<tr>
					<td class="FieldLabel" width="15%">年度:</td>
					<td class="FieldInput"><label field="disYear" /></td>
					<td class="FieldLabel" width="15%"><label id="trUat">拨款类型:</label></td>
					<td class="FieldInput"><label id="upAllocationType" field="upAllocationType"
						dataset="disAllocationTypeDs" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" width="15%">拨款日期:</td>
					<td class="FieldInput"><label field="allocationTime" /></td>
					<td class="FieldLabel" width="15%">拨款金额:</td>
					<td class="FieldInput"><label field="amount"
						style="text-align: right;"></label>&nbsp;万元</td>
				</tr>
				<tr id="trAlloNum">
					<td class="FieldLabel" width="15%">拨款文号:</td>
					<td class="FieldInput" colspan="3"><label
						field="upAllocationNum" /></td>
				</tr>
				<tr id="trBudget">
					<td class="FieldLabel" width="15%">预算类型:</td>
					<td class="FieldInput" colspan="3"><label field="budgetType"
						dataset="disBudgetType" /></td>
				</tr>
				<tr id="trUap">
					<td class="FieldLabel" width="15%">资金用途:</td>
					<td class="FieldInput" colspan="3"><input type="checkbox"
						name="upAllocationPurpose" value="DC" field="upAllocationPurpose"
						label="冬春生活救助" disabled="disabled" />冬春生活救助 <br />
					<input type="checkbox" name="upAllocationPurpose" value="YJ"
						field="upAllocationPurpose" label="应急生活救助" disabled="disabled" />应急生活救助
					<br />
					<input type="checkbox" name="upAllocationPurpose" value="CJ"
						field="upAllocationPurpose" label="灾区民房恢复重建补助 "
						disabled="disabled" />灾区民房恢复重建补助 <br />
					<input type="checkbox" name="upAllocationPurpose" value="GD"
						field="upAllocationPurpose" label="过渡性生活补助" disabled="disabled" />过渡性生活补助
					<br />
					<input type="checkbox" name="upAllocationPurpose" value="SW"
						field="upAllocationPurpose" label="遇难人员家属抚慰"
						disabled="disabled" />遇难人员家属抚慰 </td>
				</tr>
				<tr>
					<td class="FieldLabel" width="15%">备注:</td>
					<td class="FieldInput" colspan="3"><label field="note" /></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
	<!--使用情况汇总-->
	<next:Panel id="singleSourcePanel2" title="资金拨付情况">
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="disFundsSourceFollowDs">
			<table border="0" width="100%">
				<tr>
					<td class="FieldLabel" width="15%">其中，拨付资金:</td>
					<td class="FieldInput"><label field="AMOUNT_BF"
						style="text-align: right;" renderer="formatMoneyForDis"></label>&nbsp;万元</td>
					<td class="FieldLabel" width="15%" rowspan="3">结余:</td>
					<td class="FieldInput" rowspan="3"><label field="AMOUNT_BALANCE"
						style="text-align: right;" renderer="formatMoneyForDis"></label>&nbsp;万元</td>
				</tr><tr>
					<td class="FieldLabel" width="15%">其中，物资折款:</td>
					<td class="FieldInput"><label field="AMOUNT_WZ"
						style="text-align: right;" renderer="formatMoneyForDis"></label>&nbsp;万元</td>
				</tr><tr>
					<td class="FieldLabel" width="15%">其中，发放资金:</td>
					<td class="FieldInput"><label field="AMOUNT_FF"
						style="text-align: right;" renderer="formatMoneyForDis"></label>&nbsp;万元</td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
	<!--使用情况明细-->
	<next:GridPanel id="followAlloGrid2" width="100%" stripeRows="true"
		height="100%" dataset="disFundsSourceFollowDetailDs">
		<next:TopBar>
			<next:ToolBarItem symbol="资金拨付明细列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:Column id="ALLOCATION_TIME" header="使用日期" field="ALLOCATION_TIME" align="left"
				width="80">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="USE_TYPE" header="使用方式" field="USE_TYPE" align="right"
				width="100" renderer="useTypeRenderer">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="UP_ALLOCATION_NUM" header="拨款文号" field="UP_ALLOCATION_NUM" align="left"
				width="140">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="AMOUNT" header="使用金额(万元)" field="AMOUNT" align="right"
				width="100" renderer="amountUseRenderer">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="FILL_ORGAN_NAME" header="操作单位" field="FILL_ORGAN_NAME" align="left"
				width="100">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="FILL_PEOPLE_NAME" header="操作人" field="FILL_PEOPLE_NAME" align="left"
				width="100">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
		</next:Columns>
	</next:GridPanel>
</next:ViewPort>
</body>
</html>


<!--资金拨付追踪-->
<next:Window id="FollowAlloWin" closeAction="hide" title="资金拨付追踪"
	width="800" height="330" autoScroll="true" modal="true"
	closable="false">
	<next:GridPanel id="followAlloGrid" width="98%" stripeRows="true"
		height="88%" dataset="disFundsSourceAlloDs">
		<next:TopBar>
			<next:ToolBarItem symbol="资金拨付追踪列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="yes" text="查看" handler="onFollowAlloDetail"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="onCloseFollowAlloWin"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column id="DIS_YEAR" header="年度" field="DIS_YEAR" align="left"
				width="60">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="ALLOCATION_TIME" header="拨款日期" field="ALLOCATION_TIME" align="left"
				width="80">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="UP_ALLOCATION_NUM" header="拨款文号" field="UP_ALLOCATION_NUM" align="left"
				width="120">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="FILL_ORGAN_NAME" header="填报单位" field="FILL_ORGAN_NAME" align="left"
				width="100">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="AMOUNT" header="拨款金额(万元)" field="AMOUNT" align="right"
				width="100" renderer="formatMoneyForDis">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="IN_CONFIRM" header="是否下拨" field="IN_CONFIRM" align="center"
				width="70" dataset="commYesOrNoDS">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="NOTE" header="备注" field="NOTE" align="left"
				width="150">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
		</next:Columns>
	</next:GridPanel>
</next:Window>

<!--物资折款追踪-->
<next:Window id="FollowSwapWin" closeAction="hide" title="物资折款追踪"
	width="800" height="330" autoScroll="true" modal="true"
	closable="false">
	<next:GridPanel id="followSwapGrid" width="98%" stripeRows="true"
		height="88%" dataset="disFundsSourceSwapDs">
		<next:TopBar>
			<next:ToolBarItem symbol="物资折款追踪列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="yes" text="查看" handler="onFollowSwapDetail"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="onCloseFollowSwapWin"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column id="DIS_YEAR" header="年度" field="DIS_YEAR" align="left"
				width="60">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="RECEIVE_TIME" header="采购日期" field="RECEIVE_TIME" align="left"
				width="80">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="UP_ALLOCATION_TYPE" header="采购方式" field="UP_ALLOCATION_TYPE" align="center"
				width="80" dataset="disSwapTypeDs">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="FILL_ORGAN_NAME" header="采购单位" field="FILL_ORGAN_NAME" align="left"
				width="100">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="AMOUNT" header="采购金额(万元)" field="AMOUNT" align="right"
				width="100" renderer="formatMoneyForDis">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="IN_CONFIRM" header="是否使用" field="IN_CONFIRM" align="center"
				width="70" dataset="commYesOrNoDS">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="NOTE" header="备注" field="NOTE" align="left"
				width="100">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
		</next:Columns>
	</next:GridPanel>
</next:Window>