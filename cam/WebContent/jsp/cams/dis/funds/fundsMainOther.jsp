<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<head>
<title>当前业务动态</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript">
	var organCode='<%=BspUtil.getOrganCode()%>';
	var organName='<%=BspUtil.getOrganName()%>';
	var organType='<%=BspUtil.getOrganType()%>';
	var nowYear='<%=DateUtil.getYear()%>';
</script>
<script type="text/javascript" src="../comm/disComm.js"></script>
<script type="text/javascript" src="fundsMainOther.js"></script>
</head>
<body>
<model:datasets>
	<!--资金总表-->
	<model:dataset id="disFundsTempDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsTempQueryCmd"
		method="queryFunds" global="true">
	</model:dataset>
	
	<!--现有物资明细-->
	<model:dataset id="disDetailBatchSourceDs"
		cmd="com.inspur.cams.dis.base.cmd.DisDetailBatchSourceQueryCmd"
		method="queryMeterialSums" global="true">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisDetailBatchSource"></model:record>
	</model:dataset>
	
	
	
	

	<!-- 发放物资类型-->
	<model:dataset id="dmDisMaterialTypeDs"
		cmd="com.inspur.cams.dis.base.cmd.DicDisMaterialTypeQueryCmd"
		autoLoad="true" pageAble="false" global="true">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DicDisMaterialType">
			<model:field name="value" mapping="code" type="string" />
			<model:field name="text" mapping="name" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:Panel>
	<next:ColumnLayout>
		<next:Panel id="panel" title="资金总表（单位：万元）" columnWidth=".5">
			<next:Html>
				<form method="post" onsubmit="return false" class="L5form" dataset="disFundsTempDs">
				<table border="0" width="100%">
					<tr>
						<td class="FieldLabel" width="150">总资金:</td>
						<td class="FieldInput" colspan="2"><label
							field="AMOUNT_BALANCE" renderer="amountBalanceRenderer"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="150" rowspan="4">其中，上级下拨:</td>
						<td class="FieldLabel" rowspan="2">未使用：</td>
						<td class="FieldInput"><label field="SJ_NUM"
							renderer="sjNumRenderer"></label></td>
					</tr>
					<tr>
						<td class="FieldInput"><label field="SJ_AMOUNT"
							renderer="sjAmountRenderer"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" rowspan="2" width="80">合计:</td>
						<td class="FieldInput"><label field="SJ_NUM_ALL"
							renderer="sjNumAllRenderer"></label></td>
					</tr>
					<tr>
						<td class="FieldInput"><label field="SJ_AMOUNT_ALL"
							renderer="sjAmountAllRenderer"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="150" rowspan="4">其中，本级投入:</td>
						<td class="FieldLabel" rowspan="2">未使用：</td>
						<td class="FieldInput"><label field="BJ_NUM"
							renderer="bjNumRenderer"></td>
					</tr>
					<tr>
						<td class="FieldInput"><label field="BJ_AMOUNT"
							renderer="bjAmountRenderer"></td>
					</tr>
					<tr>
						<td class="FieldLabel" rowspan="2" width="80">合计:</td>
						<td class="FieldInput"><label field="BJ_NUM_ALL"
							renderer="bjNumAllRenderer"></td>
					</tr>
					<tr>
						<td class="FieldInput"><label field="BJ_AMOUNT_ALL"
							renderer="bjAmountAllRenderer"></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="150" rowspan="4">其中，社会捐赠:</td>
						<td class="FieldLabel" rowspan="2">未使用：</td>
						<td class="FieldInput"><label field="SH_NUM"
							renderer="shNumRenderer"></td>
					</tr>
					<tr>
						<td class="FieldInput"><label field="SH_AMOUNT"
							renderer="shAmountRenderer"></td>
					</tr>
					<tr>
						<td class="FieldLabel" rowspan="2" width="80">合计:</td>
						<td class="FieldInput"><label field="SH_NUM_ALL"
							renderer="shNumAllRenderer"></td>
					</tr>
					<tr>
						<td class="FieldInput"><label field="SH_AMOUNT_ALL"
							renderer="shAmountAllRenderer"></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="text-align: left;" colspan="4"><b>资金拨付情况:</b></td>
					</tr>
					<tr>
						<td class="FieldLabel">未确认：</td>
						<td class="FieldInput" colspan="2"><label field="BF_NUM"
							renderer="bfNumRenderer"></td>
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
		<next:Panel id="otherPanel" columnWidth=".5" title="物资总表">
			<next:GridPanel id="grid" width="100%" height="240"
				dataset="disDetailBatchSourceDs">
				<next:TopBar>
					<next:ToolBarItem text="总物资"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn></next:RowNumberColumn>
					<next:Column header='物资类型' field="METERIAL_TYPE"
						renderer="meterialTypeRenderer" width="130">
						<next:TextField editable="false" />
					</next:Column>
					<next:Column header="物资单位" field="METERIAL_UNIT" align="center"
						width="80">
						<next:TextField editable="false" />
					</next:Column>
					<next:Column header="物资数量" field="METERIAL_NUM_BALANCE"
						align="right" renderer="formatMoneyForDis" summaryType="sum" width="120">
						<next:ExtendConfig>
			                    summaryRenderer : formatMoneyForDis
			                </next:ExtendConfig>
						<next:TextField />
					</next:Column>
				</next:Columns>
			</next:GridPanel>
			<next:Panel id="panel2" height="100%" hidden="true">
				<next:Html>
					<form method="post" onsubmit="return false" class="L5form">
					<table border="0" width="100%">
						<tr>
							<td class="FieldLabel" style="text-align: left;" colspan="4"><b>捐赠物资情况:</b></td>
						</tr>
						<tr>
							<td class="FieldLabel">未使用：</td>
							<td class="FieldInput" colspan="2"><a href="#" onclick="openUrls('fundsGoodReceivedList.jsp')">1</a>笔记录，请尽快使用！</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="text-align: left;" colspan="4"><b>物资采购情况:</b></td>
						</tr>
						<tr>
							<td class="FieldLabel">未确认：</td>
							<td class="FieldInput" colspan="2"><a href="#" onclick="openUrls('fundsGoodSwapList.jsp')">1</a>笔记录，请尽快确认！</td>
						</tr>
						<tr>
							<td class="FieldLabel">确认未使用：</td>
							<td class="FieldInput" colspan="2"><a href="#" onclick="openUrls('fundsGoodSwapList.jsp')">2</a>笔记录，请尽快使用！</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="text-align: left;" colspan="4"><b>物资调拨情况:</b></td>
						</tr>
						<tr>
							<td class="FieldLabel">未确认：</td>
							<td class="FieldInput" colspan="2"><a href="#" onclick="openUrls('fundsGoodAllocationList.jsp')">2</a>笔记录，请尽快确认！</td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>
		</next:Panel>
	</next:ColumnLayout>
</next:Panel>
</body>
</html>