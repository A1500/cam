<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>住院结算报表查询</title>
<next:ScriptManager />
<script type="text/javascript">
   var struId='<%=BspUtil.getStruId()%>';
	var organId='<%=BspUtil.getCorpOrgan().getOrganId()%>'
	var organCode='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
	var organName='<%=BspUtil.getCorpOrgan().getOrganName()%>';
	var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
</script>
<script type="text/javascript" src="samMBalanceGvnReport.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
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
</head>
<body>
<model:datasets>
	<!-- 一站式救助信息 -->
	<model:dataset id="gvnReportDS" pageSize="8"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="queryForDetailReport" >
		<model:record>
			<model:field name="bptName" type="string" />
			<model:field name="NAME" type="string" />
			<model:field name="SEX" type="string" />
			<model:field name="AGE" type="string" />
			<model:field name="SAM_CARD_NO" type="string" />
			<model:field name="ASSITANCE_TYPE" type="string" />
			<model:field name="CITY_NAME" type="string" />
			<model:field name="BPT_CARD_NO" type="string" />
			<model:field name="ORGAN_NAME" type="string" />
			<model:field name="DISEASE" type="string" />
			<model:field name="INSURANCE_TYPE" type="string" />
			<model:field name="TOTAL_EXPENSE" type="string" />
			<model:field name="INSURANCE_EXPENSE" type="string" />
			<model:field name="INSURANCE_PAY" type="string" />
			<model:field name="BPT_BASE" type="string" />
			<model:field name="SPECIAL_PAY" type="string" />
			<model:field name="INSURANCE_BASE" type="string" />
			<model:field name="ASSITANCE_PAY" type="string" />
			<model:field name="OTHER_PAY" type="string" />
			<model:field name="BALANCE_TIME" type="string" />
			<model:field name="PERSONAL_PAY" type="string" />
			<model:field name="HOSPITAL_PAY" type="string" />
			<model:field name="HOSPITAL_NAME" type="string" />
			<model:field name="ID_CARD" type="string" />
			<model:field name="DISEASE_CODE" type="string" />
			<model:field name="BALANCE_ID" type="string" />
			<model:field name="ILLNESS_INSURANCE_PAY" type="string" />
		</model:record>
	</model:dataset>
	<!-- 一站式救助信息 -->
	<model:dataset id="repordDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="queryForSamBalanceReport" global="true">
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
	<!-- 病种 -->
	<model:dataset id="diseaseDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISEASE'></model:param>
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
			<model:param name="includeCode" value='01,02,03'></model:param>
		</model:params>
	</model:dataset>
	<!-- 医院 -->
	<model:dataset id="extOrganDs"
		cmd="com.inspur.cams.comm.extuser.cmd.ComExtOrganQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtOrgan"></model:record>
	</model:dataset>
	
	<!-- 费用明细 -->
	<model:dataset id="expDetailDS"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalDetailExpenseQueryCmd"
		global="true" sortField="EXP_DATE,EXPENSE_ID" >
		<model:record fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalDetailExpense"></model:record>
	</model:dataset>
	<!-- 数据来源字典 -->
	<model:dataset id="dataSourceDS" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value="DATA_SOURCE"></model:param>
		</model:params>
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
				<td class="FieldLabel" width="15%">救助对象属地</td>
				<td class="FieldInput" width="18%">
				  <input type="text" onclick="forCityHelp(this.id)" id="qapanage" style="width:120px"/>
				  <input type="hidden" id="qapanageCode" />
				</td>
				<td class="FieldLabel" width="15%">救助对象类别</td>
                <td class="FieldInput"  width="18%">
                  <select id="qAssistanceType" name="救助对象类别" style="width:200px">
                    <option dataset=assitanceTypeDataset></option>
                  </select>
                </td>
				<td class="FieldLabel" width="15%">医院名称</td>
				<td class="FieldInput"  width="18%">
				  <input type="text" id="hosName" style="width:120px" readonly="readonly" onclick="backHos();" />
				  <input  type="hidden"  id="hosId" />
				</td>
				<td class="FieldButton">
				<button onclick="query()">查 询</button>
				</td>
			</tr>
			<tr>
			    <td class="FieldLabel">姓名</td>
                <td class="FieldInput">
                  <input type="text" id="name" style="width:120px"/>
                </td>
                <td class="FieldLabel">身份证号码</td>
                <td class="FieldInput">
                  <input type="text" id="idCard" maxlength="18" style="width:200px"/>
                </td>
				<td class="FieldLabel">性别</td>
				<td class="FieldInput"><select id="qSex" name="qSex" style="width:120px">
					<option dataset="SexDataset"></option>
				</select></td>
				<td class="FieldButton" />
			</tr>
			<tr>
				<td class="FieldLabel"nowrap="nowrap">年龄</td>
                <td class="FieldInput" nowrap="nowrap">
                  <input type="text" id="sAge" style="width:53px" />~ 
                  <input type="text" id="eAge" style="width:53px" />
                </td>
				<td class="FieldLabel"nowrap="nowrap">救助（补助）日期</td>
				<td class="FieldInput" nowrap="nowrap">
				  <input type="text" id="beginTime"style="width:93px" format="Y-m-d" name="beginTime" onclick="LoushangDate(this)" readonly="readonly" />~ 
				  <input type="text" id="endTime" style="width:93px"  format="Y-m-d" name="endTime" onclick="LoushangDate(this)" readonly="readonly" />
				</td>
				<td class="FieldLabel">数据来源</td>
                <td class="FieldInput"><select id="dataSource" name="dataSource">
                    <option dataset="dataSourceDS"></option>
                </select></td>
				<td class="FieldButton"><button type="reset">重 置</button></td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
<next:Panel height="100%" width="99.9%">
	<next:GridPanel id="editGridPanel" name="sammedicalbalanceGrid"
		width="100%" stripeRows="true" height="100%" dataset="gvnReportDS"
		title="住院结算报表"><next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="导出Excel" iconCls="detail" handler="ToExcel"></next:ToolBarItem>
	</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn width="20" />
			<next:Column id="peopleId" header="姓名" field="NAME" width="60" renderer="showExpDetails" >
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:Column id="peopleId" header="身份证号" field="ID_CARD" width="90" hidden="true">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:Column id="peopleId" header="性别" field="SEX" width="50"
				dataset="sexDataset">
				<next:ComboBox dataset="SexDataset" displayField="text"
					valueField="value" typeAhead="true" />
			</next:Column>
			<next:Column id="peopleId" header="年龄" field="AGE" width="50">
				<next:TextField allowBlank="false" />
			</next:Column>
			
			<next:Column id="assitanceType" header="救助对象类别"
				field="ASSITANCE_TYPE" width="100">
				<next:ComboBox dataset="assitanceTypeDataset" displayField="text"
					valueField="value" typeAhead="true" />
			</next:Column>
				
			<next:Column id="cityName" header="救助对象属地" field="CITY_NAME"
				width="100">
				<next:TextField allowBlank="false" />
			</next:Column>			
			<next:Column id="hospitalName" header="入住医院" field="HOSPITAL_NAME"
				width="120">
				<next:TextField allowBlank="false" />
			</next:Column>
			
			<next:Column header="病种" field="DISEASE" width="130" sortable="true">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:Column id="insuranceType" header="保险险种" field="INSURANCE_TYPE" hidden="true"
				width="120">
				<next:ComboBox dataset="SafeguardDataset" displayField="text"
					valueField="value" typeAhead="true" />
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
			<next:Column id="balanceTime" header="救助日期" field="BALANCE_TIME"
				width="90">
				<next:TextField />
			</next:Column>
			
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="gvnReportDS" />
		</next:BottomBar>
	</next:GridPanel>
</next:Panel>
<next:Window id="selectHosWin" height="300" width="380"
	closeAction="hide">
	<next:Panel>
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="查询" iconCls="query" handler="selectHos"></next:ToolBarItem>
			<next:ToolBarItem text="确定" iconCls="select" handler="pickHos"></next:ToolBarItem>
			<next:ToolBarItem text="关闭" iconCls="return" handler="colseWin"></next:ToolBarItem>
			<next:ToolBarItem text="清除" iconCls="no" handler="removeName"></next:ToolBarItem>
		</next:TopBar>
		<next:Panel>
			<next:Html>
				<table>
					<tr>
						<td>医院：</td>
						<td><input type="text" id="qhosName" /></td>
					</tr>
				</table>
			</next:Html>
		</next:Panel>
		<next:GridPanel id="hosGrid" dataset="extOrganDs" height="230">
			<next:Columns>
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column field="organName" header="医院名称" width="320">
					<next:TextField></next:TextField>
				</next:Column>
				<next:Column hidden="true" field="organId" header="医院ID" width="10">
					<next:TextField></next:TextField>
				</next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="extOrganDs" />
			</next:BottomBar>
		</next:GridPanel>
	</next:Panel>
</next:Window>	
	
<next:Window id="expDetailWin" height="320" width="750"
	closeAction="hide" title="费用明细">
		<next:Panel>
			<next:Html>
				<form style="width: 100%; height: 100%;" class="L5form">
					<table width="100%">
						<tr>
							<td class="FieldLabel" width="10%">姓名：</td>
							<td class="FieldInput"><label id="peoName"></label></td>
						</tr>
					</table>
				</form>
			</next:Html>
		</next:Panel>
		<next:GridPanel id="detailGrid" dataset="expDetailDS" height="250">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
		</next:TopBar>
			<next:Columns>
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column field="expName" header="费用名称">
					<next:TextField></next:TextField>
				</next:Column>
				<next:Column  field="type" header="规格">
					<next:TextField></next:TextField>
				</next:Column>
				<next:Column  field="form" header="剂型">
					<next:TextField></next:TextField>
				</next:Column>
				<next:Column  field="expDate" header="日期">
					<next:TextField></next:TextField>
				</next:Column>
				<next:Column  field="num" header="数量" width="70">
					<next:TextField></next:TextField>
				</next:Column>
				<next:Column  field="price" header="单价(元)" renderer="formatNum">
					<next:TextField></next:TextField>
				</next:Column>
				<next:Column  field="expMoney" header="金额(元)" renderer="formatNum" width="120">
					<next:TextField></next:TextField>
				</next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="expDetailDS" />
			</next:BottomBar>
		</next:GridPanel>
</next:Window>
</body>
</html>
