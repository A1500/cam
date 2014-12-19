<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>资金来源管理-上级下拨</title>
<next:ScriptManager />
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript">
	var organCode='<%=BspUtil.getOrganCode()%>';
	var organName='<%=BspUtil.getOrganName()%>';
	var organType='<%=BspUtil.getOrganType()%>';
</script>
<script type="text/javascript" src="fundsComm.js"></script>
<script type="text/javascript" src="../comm/disComm.js"></script>
<script type="text/javascript" src="fundsSourceListOfUpDepartment.js"></script>
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
	<!--上级下拨资金-->
	<model:dataset id="allocationDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd" sortField="DIS_YEAR DESC,ALLOCATION_TIME DESC,FILL_TIME">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>
	<!--直管县资金-->
	<model:dataset id="lowerAllocationDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd" sortField="DIS_YEAR DESC,ALLOCATION_TIME DESC,FILL_TIME">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>

	<!--单笔资金来源，增改使用-->
	<model:dataset id="singleSourceDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource">
			<model:field name="disYear" type="string" rule="require"></model:field>
			<model:field name="amount" type="float" rule="require"></model:field>
			<model:field name="allocationTime" type="string" rule="require"></model:field>
			<model:field name="upAllocationType" type="string" rule="require"></model:field>
		</model:record>
	</model:dataset>

	<!-- 预算类型 -->
	<model:dataset id="disBudgetType" enumName="DIS.BUDGET_TYPE"
		global="true" autoLoad="true">
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
<!--	上级下拨-省/县/市		-->
<next:Panel name="allocationPanel" width="100%" height="100%">
	<next:Panel width="100%" border="0">
		<next:Html>
			<div>
			<form class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" nowrap>年度：</td>
					<td class="FieldInput"><input type="text" id="cx_disYear_up"
						class="TextEditor" title="年度" maxlength="4" /></td>
					<td class="FieldLabel" nowrap>拨款文号：</td>
					<td class="FieldInput"><input type="text"
						id="cx_upAllocationNum_up" class="TextEditor" title="上级拨款文号" /></td>
					
				</tr>
				<tr>
					<td class="FieldLabel" nowrap>资金用途：</td>
					<td class="FieldInput"><select id="cx_upAllocationPurpose_up"
						class="TextEditor" title="资金用途" style="width: 180px;">
						<option dataset="disAllocationPurposeDs"></option>
					</select></td>
					<td nowrap="nowrap" class="FieldLabel" colspan="2">
					<button onclick="queryAllocation()">查 询</button>
					&nbsp;
					<button type="reset">重 置</button>
					</td>
				</tr>
			</table>
			</form>
			</div>
		</next:Html>
	</next:Panel>

	<next:Panel width="100%" height="100%">
		<next:AccordionLayout>
			<next:Panel width="100%" title="上级下拨资金管理">
				<next:GridPanel id="allocationGridPanel" dataset="allocationDs"
					autoExpandColumn="upAllocationPurpose" name="allocationGridPanel"
					width="99.9%" height="95%" notSelectFirstRow="true" hasSum="true">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="detail" text="明细" handler="detailUp" />
						<next:ToolBarItem iconCls="search" text="追踪" handler="followUp"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="45" />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="sourceId" header="来源表ID" field="sourceId"
							align="center" hidden="true">
							<next:TextField allowBlank="false" />
						</next:Column>

						<next:Column id="disYear" header="年度" field="disYear"
							align="center" width="50">
							<next:TextField />
						</next:Column>
						<next:Column id="allocationTime" header="拨款日期"
							field="allocationTime" align="center" width="80">
							<next:TextField />
						</next:Column>
						<next:Column id="upAllocationType" header="拨款类型"
							field="upAllocationType" align="center" width="70"
							dataset="disAllocationTypeDs">
							<next:TextField />
						</next:Column>
						<next:Column id="upAllocationPurpose" header="资金用途"
							field="upAllocationPurpose" align="left"
							renderer="upAllocationPurposeRenderer">
							<next:TextField />
						</next:Column>
						<next:Column id="upAllocationNum" header="拨款文号"
							field="upAllocationNum" align="left" width="120">
							<next:TextField />
						</next:Column>

						<next:Column id="amount" header="拨款金额(万元)" field="amount"
							align="right" width="90" renderer="formatMoneyForDis" summaryType="sum">
							<next:ExtendConfig>
	                    	summaryRenderer : formatMoneyForDis
	                	</next:ExtendConfig>
							<next:TextField />
						</next:Column>
						<next:Column id="amountTown" header="另拨付直管县金额(万元)" field="amountTown"
							align="right" width="140" renderer="initTown">
							<next:TextField />
						</next:Column>
						<next:Column id="amountPay" header="支出金额(万元)" field="amountPay"
							align="right" width="90" renderer="amountPayRenderer"
							summaryType="sum">
							<next:ExtendConfig>
	                    	summaryRenderer : formatMoneyForDis
	                	</next:ExtendConfig>
							<next:TextField />
						</next:Column>
						<next:Column id="amountBalance" header="结余金额(万元)"
							field="amountBalance" align="right" width="90"
							renderer="formatMoneyForDis" summaryType="sum">
							<next:ExtendConfig>
	                    	summaryRenderer : formatMoneyForDis
	                	</next:ExtendConfig>
							<next:TextField />
						</next:Column>
						<next:Column id="note" header="备注" field="note" align="left"
							width="110" renderer="noteRenderer">
							<next:TextField />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="allocationDs" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>

			<next:Panel width="100%" title="直管县资金管理">
				<next:GridPanel id="lowerGridPanel" dataset="lowerAllocationDs"
					autoExpandColumn="upAllocationPurpose" name="lowerGridPanel"
					width="99.9%" height="100%" notSelectFirstRow="true" hasSum="true">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="detail" text="明细" handler="detailLower" />
						<next:ToolBarItem iconCls="search" text="追踪" handler="followLower"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="45" />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="sourceId" header="来源表ID" field="sourceId"
							align="center" hidden="true">
							<next:TextField allowBlank="false" />
						</next:Column>

						<next:Column id="disYear" header="年度" field="disYear"
							align="center" width="50">
							<next:TextField />
						</next:Column>
						<next:Column id="allocationTime" header="拨款日期"
							field="allocationTime" align="center" width="80">
							<next:TextField />
						</next:Column>
						<next:Column id="upAllocationType" header="拨款类型"
							field="upAllocationType" align="center" width="70"
							dataset="disAllocationTypeDs">
							<next:TextField />
						</next:Column>
						<next:Column id="receiveOrganName" header="接收单位"
							field="receiveOrganName" align="center" width="100">
							<next:TextField />
						</next:Column>
						<next:Column id="upAllocationPurpose" header="资金用途"
							field="upAllocationPurpose" align="left"
							renderer="upAllocationPurposeRenderer">
							<next:TextField />
						</next:Column>
						<next:Column id="upAllocationNum" header="拨款文号"
							field="upAllocationNum" align="left" width="120">
							<next:TextField />
						</next:Column>

						<next:Column id="amount" header="拨款金额(万元)" field="amount"
							align="right" width="90" renderer="formatMoneyForDis" summaryType="sum">
							<next:ExtendConfig>
	                    	summaryRenderer : formatMoneyForDis
	                	</next:ExtendConfig>
							<next:TextField />
						</next:Column>
						<next:Column id="amountPay" header="支出金额(万元)" field="amountPay"
							align="right" width="90" renderer="amountPayRenderer"
							summaryType="sum">
							<next:ExtendConfig>
	                    	summaryRenderer : formatMoneyForDis
	                	</next:ExtendConfig>
							<next:TextField />
						</next:Column>
						<next:Column id="amountBalance" header="结余金额(万元)"
							field="amountBalance" align="right" width="90"
							renderer="formatMoneyForDis" summaryType="sum">
							<next:ExtendConfig>
	                    	summaryRenderer : formatMoneyForDis
	                	</next:ExtendConfig>
							<next:TextField />
						</next:Column>
						<next:Column id="note" header="备注" field="note" align="left"
							width="110" renderer="noteRenderer">
							<next:TextField />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="lowerAllocationDs" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
		</next:AccordionLayout>
	</next:Panel>
</next:Panel>
</body>
</html>

<!--新增资金来源-->
<next:Window id="sourceWin" width="700" height="300" collapsible="false"
	closable="close" resizable="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="保存" handler="confirmSave"></next:ToolBarItem>
		<next:ToolBarItem iconCls="no" text="取消" handler="cancelSave"></next:ToolBarItem>
	</next:TopBar>
	<next:Panel id="singleSourcePanel">
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="singleSourceDs">
			<table border="0" width="100%">
				<tr>
					<td class="FieldLabel" width="15%">年度:</td>
					<td class="FieldInput"><input type="text" name="年度"
						maxlength="4" field="disYear"><font color="red">*</font></td>
					<td class="FieldLabel" width="15%">拨款类型:</td>
					<td class="FieldInput"><select name="拨款类型"
						style="width: 150px;" field="upAllocationType" disabled="disabled">
						<option dataset="disAllocationTypeDs"></option>
					</select><font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel" width="15%">拨款日期:</td>
					<td class="FieldInput"><input type="text"
						field="allocationTime" name="拨款日期" format="Y-m-d"
						style="width: 100px;" maxlength="10"
						onpropertychange="changeDateStyle(this)" /><img
						src="../../../../skins/images/default/rl.gif" align="middle"
						onclick="getTimes(this);" /><font color="red">*</font></td>
					<td class="FieldLabel" width="15%">拨款金额:</td>
					<td class="FieldInput"><input type="text" name="拨款金额"
						field="amount" onchange="checkAssMon(this.id)"
						style="text-align: right" />万元<font color="red">*</font></td>
				</tr>
				<tr id="trAlloNum">
					<td class="FieldLabel" width="15%">拨款文号:</td>
					<td class="FieldInput" colspan="3"><input type="text"
						name="拨款文号" field="upAllocationNum" maxlength="75"
						style="width: 80%" /><font color="red">*</font></td>
				</tr>
				<tr id="trBudget">
					<td class="FieldLabel" width="15%">预算类型:</td>
					<td class="FieldInput" colspan="3"><select name="预算类型"
						style="width: 150px;" field="budgetType">
						<option dataset="disBudgetType"></option>
					</select><font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel" width="15%">资金用途:</td>
					<td class="FieldInput" colspan="3"><input type="checkbox"
						name="upAllocationPurpose" value="DC" field="upAllocationPurpose"
						label="冬春生活救助" />冬春生活救助 <br />
					<input type="checkbox" name="upAllocationPurpose" value="YJ"
						field="upAllocationPurpose" label="应急生活救助" />应急生活救助 <br />
					<input type="checkbox" name="upAllocationPurpose" value="CJ"
						field="upAllocationPurpose" label="灾区民房恢复重建补助 " />灾区民房恢复重建补助 <br />
					<input type="checkbox" name="upAllocationPurpose" value="GD"
						field="upAllocationPurpose" label="过渡性生活补助" />过渡性生活补助 <br />
					<input type="checkbox" name="upAllocationPurpose" value="SW"
						field="upAllocationPurpose" label="遇难人员家属抚慰" />遇难人员家属抚慰
					<font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel" width="15%">备注:</td>
					<td class="FieldInput" colspan="3"><input type="text"
						name="备注" field="note" maxlength="100" style="width: 80%" /></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
</next:Window>

<!--新增资金来源-明细(市)-->
<next:Window id="sourceDetailWin" width="700" height="360"
	collapsible="false" closable="close" resizable="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="no" text="取消" handler="hideDetailWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Panel id="singleSourcePanel2">
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="singleSourceDs">
			<table border="0" width="100%">
				<tr>
					<td class="FieldLabel" width="15%">年度:</td>
					<td class="FieldInput"><label field="disYear" /></td>
					<td class="FieldLabel" width="15%">拨款类型:</td>
					<td class="FieldInput"><label field="upAllocationType"
						dataset="disAllocationTypeDs" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" width="15%">拨款日期:</td>
					<td class="FieldInput"><label field="allocationTime" /></td>
					
					<td class="FieldLabel" width="15%">拨款文号:</td>
					<td class="FieldInput"><label
						field="upAllocationNum" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" width="15%" rowspan="2">拨款金额:</td>
					<td class="FieldInput" rowspan="2"><label field="amount"
						style="text-align: right;"></label>&nbsp;万元<br /><br />
						<button>使用资金明细</button></td>
					<td class="FieldLabel" width="15%">其中，中央财政:</td>
					<td class="FieldInput"><label field="amountCentral"
						style="text-align: right;"></label>&nbsp;万元</td>
				</tr>
				<tr>
					<td class="FieldLabel" width="15%">其中，省财政:</td>
					<td class="FieldInput"><label field="amountDepartment"
						style="text-align: right;"></label>&nbsp;万元</td>
				</tr>
				<tr>
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
						disabled="disabled" />遇难人员家属抚慰</td>
				</tr>
				<tr>
					<td class="FieldLabel" width="15%">备注:</td>
					<td class="FieldInput" colspan="3"><label field="note" /></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
</next:Window>