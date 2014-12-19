<%@page import="com.inspur.cams.drel.mbalance.util.BalanceConfig"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@ page import="com.inspur.cams.comm.util.DateUtil"%>
<%
	boolean needConnect ;
	if("false".equals(request.getParameter("needConnect"))){
		needConnect = false;
	} else {
    	needConnect = BalanceConfig.needConnect(ExtBspInfo.getUserInfo(request).getAreaCode());;
	}
%>
<html>
<head>
<title>入院备案人员信息查询</title>
<next:ScriptManager />
<script type="text/javascript">
	var organCode='<%=ExtBspInfo.getUserInfo(request).getAreaCode() %>'
	var organId='<%=ExtBspInfo.getUserInfo(request).getOrganId()%>';
	var organName='<%=ExtBspInfo.getUserInfo(request).getOrganName()%>';
	var userId='<%=ExtBspInfo.getUserInfo(request).getUserId()%>';
	var userName='<%=ExtBspInfo.getUserInfo(request).getUserName()%>';
	var needConnect='<%=needConnect%>';
</script>
<script type="text/javascript" src="samMBalancePeople.js"></script>
<script type="text/javascript" src="samMBExtComm.js"></script>
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
	<!-- 一站式救助查询救助人员基本信息 -->
	<model:dataset id="dsPeo"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="queryPeople">
	</model:dataset>
	<!-- 一站式救助未出院人员 -->
	<model:dataset id="SMBDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		global="true" method="queryForInCheck">
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
	<!-- 行政区划 -->
	<model:dataset id="cityDataset" global="true" autoLoad="false"
		cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand">
		<model:record fromBean="com.inspur.cams.comm.diccity.data.DicCity"></model:record>
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
		</model:params>
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
	<!-- 一站式结算登记信息 -->
	<model:dataset id="ds"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMBalance">

		</model:record>
	</model:dataset>
	<!-- 家庭成员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet1"
		cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd" global="true">
		<model:record
			fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 人员基本信息 -->
	<model:dataset id="PeoDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="queryPeople">
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
	<!-- 医疗救助类型 -->
	<model:dataset id="assitanceTypeDataset" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_assitance_Type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 家庭信息基本 -->
	<model:dataset id="BaseinfoFamilyDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.SamBaseFamilyQueryCmd"
		method="queryFamily" global="true">
		<model:record
			fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily"></model:record>
	</model:dataset>
	<!-- 救助基本信息 -->
	<model:dataset id="SamFamilyAssistanceDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.SamFamilyAssistanceCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.sam.data.SamFamilyAssistance"></model:record>
	</model:dataset>
	<!-- 行政区划 -->
	<model:dataset id="cityDataset" global="true" autoLoad="false"
		cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand">
		<model:record fromBean="com.inspur.cams.comm.diccity.data.DicCity"></model:record>
	</model:dataset>
	<!-- 个人信息 -->
	<model:dataset id="BaseinfoPeopleDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd" global="true">
		<model:record
			fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 家庭成员信息 -->
	<model:dataset id="BaseinfoPeoDataSetMem"
		cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd" global="true">
		<model:record
			fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 封顶线 -->
	<model:dataset id="topLineDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalTopLineQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalTopLine">
			<model:field name="domicileName" type="string" />
		</model:record>
	</model:dataset>
	<!--  家庭成员详细信息 -->
	<model:dataset id="BaseinfoPeoDataSetMemDetail"
		cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd" global="true">
		<model:record
			fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 一站式结算住院历史信息 -->
	<model:dataset id="hosDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="queryForSamList">
	</model:dataset>
	
	<!-- 新农合接口查询结果 -->
	<model:dataset id="insuranceDS"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="doInfoXML">
		<model:record>
			<model:field name="NAME"/>
			<model:field name="ID_CARD"/>
			<model:field name="INSURANCE_NO"/>
			<model:field name="RECORD_NO"/>
			<model:field name="IN_DATE"/>
			<model:field name="HOSPITAL_DEP"/>
			<model:field name="DISEASE_CODE"/>
			<model:field name="DISEASE"/>
		</model:record>
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
	<!-- 与户主关系 -->
	<model:dataset id="relationshipDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="nationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="domicileDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DOMICILE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 婚姻状况 -->
	<model:dataset id="marriageDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MARRIAGE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="disbilityLevelDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISABILITY_LEVEL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 人员照片 -->
	<model:dataset id="comPhotoDs"
		cmd="com.inspur.cams.comm.comphoto.cmd.ComPhotoQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.comphoto.data.ComPhoto"></model:record>
	</model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0"
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
				<td class="FieldLabel" width="10%">姓名：</td>
				<td class="FieldInput" width="30%"><input type="text" id="name"
					maxlength="25" class="TextEditor" title="人员姓名" /></td>
				<td class="FieldLabel" width="10%">身份证号：</td>
				<td class="FieldInput" width="30%"><input type="text"
					id="idCard" maxlength="18" class="TextEditor" title="身份证件号码"
					style="width: 70%" onblur="validIdCard(this)"/></td>
				<td class="FieldButton">
				<button onclick="query()">查 询</button>
				
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" width="10%">证件类型：</td>
				<td class="FieldInput" width="30%"><select id="cardType"
					name="cardType" field="cardType">
					<option dataset="cardTypeDataset"></option>
				</select></td>
				<td class="FieldLabel" width="10%">证件编码：</td>
				<td class="FieldInput" width="30%"><input type="text"
					id="cardNo" maxlength="30" class="TextEditor" title="证件号码"
					style="width: 70%" /></td>
				<td class="FieldButton">
				<button type="reset">重 置</button>
				</td>
			</tr>
			
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<!-- 家庭信息 -->
<next:Panel id="funCreate" title="" collapsible="true" width="100%"
	height="100%" autoHeight="true">
	<next:TabPanel name="tabpanel-div" height="100%" activeTab="0">
		<next:Tabs>
			<next:Panel autoWidth="ture" title="家庭基本信息" width="100%">
				<next:Panel>
					<next:Html>
						<form id="BaseinfoFamilyForm" method="post"
							dataset="BaseinfoFamilyDataSet" onsubmit="return false"
							style="padding: 5px;" class="L5form">
						<table border="0" width="100%">
							<tr>
								<td class="FieldLabel" style="width: 15%">户主姓名</td>
								<td class="FieldInput" style="width: 15%"><label
									name="familyName" field="familyName" /></td>
								<td class="FieldLabel" style="width: 15%">困难居民类型</td>
								<td class="FieldInput" style="width: 20%"><label
									id="assistanceType" name="assistanceType"
									dataset="assitanceTypeDataset"></label></td>
								<td class="FieldLabel" style="width: 15%">证件号码</td>
								<td class="FieldInput" style="width: 20%"><label
									name="homeCardNo" id="homeCardNo" /></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 15%">家庭人口数</td>
								<td class="FieldInput" style="width: 15%"><label
									name="peopleNum" field="peopleNum" /></td>
								<td class="FieldLabel" style="width: 15%">家庭住址</td>
								<td class="FieldInput" colspan="3" style="width: 55%"><label
									id="address" name="address" field="address" /></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 15%">宅电</td>
								<td class="FieldInput" style="width: 15%"><label
									name="familyPhone" field="familyPhone" /></td>
								<td class="FieldLabel" style="width: 15%">手机</td>
								<td class="FieldInput" style="width: 20%"><label
									name="familyMobile" field="familyMobile" /></td>
								<td class="FieldLabel" style="width: 15%">其他联系方式</td>
								<td class="FieldInput" style="width: 20%"><label
									name="familyOtherPhone" field="familyOtherPhone" /></td>
							</tr>
						</table>
						</form>
					</next:Html>
				</next:Panel>

				<next:GridPanel id="peoEditGridPanel" name="sammedicalbalanceGrid"
					width="100%" stripeRows="true" height="100%"
					dataset="BaseinfoPeoDataSetMem">
					<next:TopBar>
						<next:ToolBarItem text="家庭成员"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem id="inHosRegButton" iconCls="add" text="入院备案"
							handler="inHosReg" />
						<next:ToolBarItem iconCls="detail" text="查看明细" handler="peoDetail" />
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="15" />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="peopleId" header="姓名" field="name" width="10%">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="peopleId" header="性别" field="sex" width="10%">
							<next:ComboBox dataset="SexDataset" displayField="text"
								valueField="value" typeAhead="true" />
						</next:Column>
						<next:Column id="peopleId" header="与户主关系" field="relationshipType"
							width="10%">
							<next:ComboBox dataset="relationshipDataset" displayField="text"
								valueField="value" typeAhead="true" />
						</next:Column>
						<next:Column id="peopleId" header="出生日期" field="birthday"
							width="10%">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="peopleId" header="身份证号" field="idCard"
							width="18%">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="insuranceType" header="保险险种"
							field="safeguardType" width="20%">
							<next:ComboBox dataset="SafeguardDataset" displayField="text"
								valueField="value" typeAhead="true" />
						</next:Column>
						<next:Column header="工作单位" field="workUnitName" width="15%"
							sortable="true">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="photoId" header="照片ID" field="photoId"
							hidden="true">
							<next:TextField allowBlank="false" />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="BaseinfoPeoDataSetMem" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
			<next:Panel title="历史救助信息" width="100%">
				<next:GridPanel id="editGridPanel" name="sammedicalbalanceGrid"
					width="100%" stripeRows="true" height="100%" dataset="hosDataset">
					<next:Columns>
						<next:RowNumberColumn width="15" />
						<next:Column id="peopleId" header="姓名" field="NAME" width="10%">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column header="病种" field="DISEASE" width="30%">
							<next:TextField allowBlank="false" />
						</next:Column>

						<next:Column id="TOTAL_EXPENSE" header="住院总费用"
							field="TOTAL_EXPENSE" width="10%">
							<next:TextField />
						</next:Column>

						<next:Column id="INSURANCE_EXPENSE" header="纳入保险报销费用"
							field="INSURANCE_EXPENSE" width="15%">
							<next:TextField />
						</next:Column>

						<next:Column id="INSURANCE_PAY" header="保险支付金额"
							field="INSURANCE_PAY" width="90">
							<next:TextField />
						</next:Column>

						<next:Column id="ASSITANCE_PAY" header="救助金额"
							field="ASSITANCE_PAY" width="90">
							<next:TextField />
						</next:Column>

						<next:Column id="PERSONAL_PAY" header="自付费用" field="PERSONAL_PAY"
							width="90">
							<next:TextField />
						</next:Column>

					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="hosDataset" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<!-- 入院登记事项窗口 -->
<next:Window id="inRegiste" height='<%=needConnect?"400":"250"%>' width="700" closeAction="hide"
	title="入院备案">
	<next:Panel autoHeight="true">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="save" text="保存" handler="save" />
			<next:ToolBarItem iconCls="undo" text="取消" handler="undoReg" />
		</next:TopBar>
		<next:Html>
			<form id="editForm" dataset="ds" onsubmit="return false"
				style="padding: 5px;" class="L5form">
				<input type="hidden" id="sex" />
				<input type="hidden" id="birthday"/>
				<input type="hidden" id="domicileCode" />
				
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" width="17%">姓名</td>
					<td class="FieldInput"><label id="hosName" name="姓名"></label></td>
					<td class="FieldLabel" width="17%">身份证件号码</td>
					<td class="FieldInput"><label id="hosIdCard" name="身份证件号码"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" width="17%">证书类型</td>
					<td class="FieldInput"><label id="hosCardType" name="证书类型"
						dataset="cardTypeDataset"></label></td>

					<td class="FieldLabel" width="17%">证书编号</td>
					<td class="FieldInput"><label id="hosCardNo" name="证书编号"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" width="17%">保险险种</td>
					<td class="FieldInput">
					    <select id="hosInsuranceType" name="保险险种" field="insuranceType"> 
					      <option dataset="SafeguardDataset">
					    </select></td>
					<td class="FieldLabel" width="17%">医疗证号</td>
					<td class="FieldInput"><input type="text" id="medicalCode" field="medicalCode" />
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" width="17%">住院号：</td>
					<td class="FieldInput"><input type="text" maxlength="30" id="hospitalRecordId"
						name="住院号" field="hospitalRecordId" onchange="checkOnlyRecordId();" <%=needConnect?"readonly='readonly'":"" %> />
						<font color="red">*</font>
					</td>
					<td class="FieldLabel" width="17%">入院日期：</td>
					<td class="FieldInput"><input type="text" name="入院日期"
						readonly="readonly" id="inDate" field="inDate" format="Y-m-d"
						onclick="LoushangDate(this)"><font color="red">*</font>
						<%if(needConnect){ %>
					<button onclick="queryFromInsurance()">信息检索</button></td>
					<%} %>
				</tr>
				<tr>
					<td class="FieldLabel" width="17%">入住科室：</td>
					<td class="FieldInput"><input type="text" name="入住科室" id="hospitalDep"
						maxlength="15" field="hospitalDep" <%=needConnect?"readonly='readonly'":"" %> /></td>
					<td class="FieldLabel" width="17%">病种：</td>
					<td class="FieldInput"><input name="病种" id="disease" field="disease" <%=needConnect?"readonly='readonly'":"" %> />
					<input type="hidden" name="balanceId" id="balanceId"
					    value="<%=IdHelp.getUUID30() %>" title="住院流水ID" />
				    <input type="hidden" name="hospitalId" id="hospitalId"
					    value="<%=ExtBspInfo.getUserInfo(request).getOrganId()%>"
					    title="医院ID" />
				    <input type="hidden" name="hospitalArea" id="hospitalArea"
					    value="<%=ExtBspInfo.getUserInfo(request).getAreaCode() %>"
					    title="医院所属行政区划" />
				    <input type="hidden" name="regTime" id="regTime"
					value="<%=DateUtil.getTime() %>" title="录入时间" />
					<font color="red">*</font></td>
				</tr>
				
			</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:GridPanel id="insuranceGrid" title="新农合（城镇医保）系统查询结果" height="60%" width="98%"
		autoScroll="true" autoWidth="true" dataset="insuranceDS" hidden="<%=!needConnect%>">
		<next:Columns>
			<next:RowNumberColumn width="15" />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column id="peopleId" header="姓名" field="NAME" width="10%">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:Column header="身份证号" field="ID_CARD" width="20%">
				<next:TextField />
			</next:Column>

			<next:Column id="INSURANCE_NO" header="医疗证号" field="INSURANCE_NO"
				width="12%">
				<next:TextField />
			</next:Column>

			<next:Column id="RECORD_NO" header="住院号"
				field="RECORD_NO" width="15%">
				<next:TextField />
			</next:Column>

			<next:Column id="IN_DATE" header="入院日期" field="IN_DATE"
				width="10%">
				<next:TextField />
			</next:Column>

			<next:Column id="HOSPITAL_DEP" header="入院科室" field="HOSPITAL_DEP"
				width="11%">
				<next:TextField />
			</next:Column>

			<next:Column id="DISEASE" header="病种名称" field="DISEASE"
				width="11%">
				<next:TextField />
			</next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="insuranceDS" />
		</next:BottomBar>
	</next:GridPanel>
</next:Window>
<next:Window id="peoDetailWin" height="260" width="650" title="家庭成员详细信息"
	closeAction="hide">
	<next:Panel width="100%">
		<next:Html>
			<form class="L5form" dataset="BaseinfoPeoDataSetMemDetail">
			<table width="100%">
				<tr>
					<td class="FieldLabel" width="15%">姓名</td>
					<td class="FieldInput" width="25%"><label name="name"
						field="name"></label></td>
					<td class="FieldLabel" width="15%">性别</td>
					<td class="FieldInput" width="25%"><label name="sex"
						field="sex" dataset="SexDataset"></label></td>
					<td rowspan="4" width="20%"><img id="peoPhoto"
						name="PHOTO_IMG" width=90 " height=120
						onerror="javascript:this.src='<%=SkinUtils.getImage(request,"default.jpg")%>'"
						alt="暂无图片" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">出生日期</td>
					<td class="FieldInput"><label field="birthday"></label></td>
					<td class="FieldLabel">身份证件号码</td>
					<td class="FieldInput"><label field="idCard"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel">民族</td>
					<td class="FieldInput"><label field="nation"
						dataset="nationDataset"></label></td>
					<td class="FieldLabel">对象属地</td>
					<td class="FieldInput"><label id="domicileName"
						field="domicileCode"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel">婚姻状况</td>
					<td class="FieldInput"><label field="marriageCode"
						dataset="marriageDataset"></label></td>
					<td class="FieldLabel">户口类型</td>
					<td class="FieldInput"><label name="domicileType"
						field="domicileType" dataset="domicileDataset"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel">参保种类</td>
					<td class="FieldInput"><label name="safeguardType"
						field="safeguardType" dataset="SafeguardDataset"></label></td>
					<td class="FieldLabel">工作单位</td>
					<td class="FieldInput" colspan="2"><label name="workUnitName"
						field="workUnitName"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel">封顶线（元）</td>
					<td class="FieldInput"><label id="topLine"></label></td>
					<td class="FieldLabel">本年救助金额（元）</td>
					<td class="FieldInput" colspan="2"><label id="hYearMoney"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel">证书类型</td>
					<td class="FieldInput"><label id="detailCardType"
						name="cardType" dataset="cardTypeDataset"></label></td>
					<td class="FieldLabel">证书编号</td>
					<td class="FieldInput" colspan="2"><label id="detailCardNo"
						name="cardNo"></label></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
</next:Window>
</body>
</html>
