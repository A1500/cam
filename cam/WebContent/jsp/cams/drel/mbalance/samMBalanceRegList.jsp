<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>一站结算住院登记列表</title>
<next:ScriptManager />
<script type="text/javascript">
	var organId='<%=BspUtil.getCorpOrgan().getOrganId()%>'
	var organCode='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
</script>
<script type="text/javascript" src="samMBalanceRegList.js"></script>
<script type="text/javascript" src="samMBalanceComm.js"></script>
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
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>
<model:datasets>
	<!-- 住院登记信息 -->
	<model:dataset id="gvnListDS"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="queryForSamList"  sortField="inTime" sortDirection="desc">
		
	</model:dataset>
	<model:dataset id="hosDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMBalance"></model:record>
	</model:dataset>
	<!-- 救助状态 -->
	<model:dataset id="statusDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMStatusQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMStatus"></model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 医疗保障方式 -->
	<model:dataset id="SafeguardDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MEDICAL_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="assitanceTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_assitance_Type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
			<model:param name="includeCode" value='01,02,03,11'></model:param>
		</model:params>
	</model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="hosStatusDataset" enumName="HOS_STATUS"
		autoLoad="true">
	</model:dataset>
	<!-- 证书类型 -->
	<model:dataset id="cardTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_sam_card_Type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 救助状态 -->
	<model:dataset id="StatusDataset" enumName="STATUS" autoLoad="true">
	</model:dataset>
</model:datasets>

<next:Panel name="form" width="99.9%" border="0"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 100%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel">住院号：</td>
				<td class="FieldInput"><input type="text" maxlength="30" id="hospitalRecordId"
					class="TextEditor" title="住院号" /></td>
				<td class="FieldLabel">入院时间：</td>
				<td class="FieldInput"><input type="text" name="inTime"
					id="inTime" format="Y-m-d" readonly="readonly"
					onclick="LoushangDate(this)"></td>
				<td class="FieldLabel"><button onclick="query()">查 询</button></td>
			</tr>
			<tr>
				<td class="FieldLabel">保险险种：</td>
				<td class="FieldInput"><select id="insuranceType"
					name="insuranceType" field="insuranceType">
					<option dataset="SafeguardDataset"></option>
				</select></td>
				<td class="FieldLabel">医疗救助类型：</td>
				<td class="FieldInput"><select id="assitanceType"
					name="assitanceType" field="assitanceType">
					<option dataset="assitanceTypeDataset"></option>
				</select></td>
				<td class="FieldLabel"><button type="reset">重 置</button></td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="sammedicalbalanceGrid"
	width="99.9%" stripeRows="true" height="100%" dataset="gvnListDS"
	title="住院登记信息列表">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="结算登记" iconCls="add" handler="reg" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>

		<next:Column id="peopleId" header="姓名" field="NAME" width="90">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="peopleId" header="身份证号" field="ID_CARD" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="病种" field="DISEASE" width="130" sortable="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="insuranceType" header="保险险种" field="INSURANCE_TYPE"
			width="130">
			<next:ComboBox dataset="SafeguardDataset" displayField="text"
				valueField="value" typeAhead="true" />
		</next:Column>
		<next:Column id="assitanceType" header="医疗救助类型" field="ASSITANCE_TYPE"
			width="90">
			<next:ComboBox dataset="assitanceTypeDataset" displayField="text"
				valueField="value" typeAhead="true" />
		</next:Column>
		<next:Column id="inTime" header="入院日期" field="IN_DATE" width="90">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="leaveTime" header="出院日期" field="LEAVE_DATE"
			width="90">
			<next:TextField />
		</next:Column>
		<next:Column id="totalExpense" header="住院总费用（元）" field="TOTAL_EXPENSE" align="right" 
				width="120">
				<next:TextField />
			</next:Column>

			<next:Column id="insuranceExpense" header="纳入保险报销费用（元）" align="right" 
				field="INSURANCE_EXPENSE" width="150">
				<next:TextField />
			</next:Column>

			<next:Column id="INSURENCE_PAY" header="保险支付金额（元）" align="right" 
				field="INSURANCE_PAY" width="150">
				<next:TextField />
			</next:Column>			
			
			<next:Column id="ILLNESS_INSURANCE_PAY" header="商业保险金额（元）" align="right" 
				field="ILLNESS_INSURANCE_PAY" width="150">
				<next:TextField />
			</next:Column>	
			
			<next:Column id="HOSPITAL_PAY" header="医院减免金额（元）" align="right" 
				field="HOSPITAL_PAY" width="150">
				<next:TextField />
			</next:Column>	
			
			<next:Column id="assitancePay" header="救助金额（元）" field="ASSITANCE_PAY" align="right" 
				width="130">
				<next:TextField />
			</next:Column>

			<next:Column id="OTHER_PAY" header="其他救助金额（元）" field="OTHER_PAY" align="right" 
				width="130">
				<next:TextField />
			</next:Column>
			<next:Column id="personalPay" header="自付费用（元）" field="PERSONAL_PAY" align="right" 
				width="130">
				<next:TextField />
			</next:Column>
		<next:Column id="balanceTime" header="结算日期" field="BALANCE_TIME"
			width="90">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="gvnListDS" />
	</next:BottomBar>
</next:GridPanel>


</body>
</html>
