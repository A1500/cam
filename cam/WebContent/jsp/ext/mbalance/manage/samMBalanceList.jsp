
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<html>
<head>
<title>入院备案信息列表</title>
<next:ScriptManager />
<script type="text/javascript">
	var organCode='<%=ExtBspInfo.getUserInfo(request).getAreaCode() %>'
	var userId='<%=ExtBspInfo.getUserInfo(request).getUserId()%>';
	var userName='<%=ExtBspInfo.getUserInfo(request).getUserName()%>';
	var organName='<%=ExtBspInfo.getUserInfo(request).getOrganName()%>';
	var organId='<%=ExtBspInfo.getUserInfo(request).getOrganId()%>';
	var needConnect='<%=request.getParameter("needConnect")%>';
</script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js") %>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript" src="samMBalanceList.js"></script>
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
	<!-- 住院登记信息 -->
	<model:dataset id="ds"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="queryForSamList" global="true" pageSize="8">
	</model:dataset>
	<model:dataset id="printDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd"
		method="queryForSamList">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMBalance"></model:record>
	</model:dataset>
	<model:dataset id="hosDataset"
		cmd="com.inspur.cams.drel.mbalance.cmd.SamMBalanceQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.mbalance.data.SamMBalance"></model:record>
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
	<!-- 救助状态 -->
	<model:dataset id="StatusDataset" enumName="STATUS"
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
	<!-- 行政区划 -->
	<model:dataset id="cityDataset" global="true" autoLoad="true"
		cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand">
		<model:record fromBean="com.inspur.cams.comm.diccity.data.DicCity"></model:record>
		<model:params>
			<model:param name="ID" value="<%=ExtBspInfo.getUserInfo(request).getAreaCode()%>"></model:param>
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
				<td class="FieldLabel">住院号：</td>
				<td class="FieldInput"><input type="text" id="hospitalRecordId" maxlength="30"
					class="TextEditor" title="住院号" /></td>
				<td class="FieldLabel">入院时间：</td>
				<td class="FieldInput"><input type="text" name="inTime"
					id="inTime" format="Y-m-d" readonly="readonly"
					onclick="LoushangDate(this)"></td>
				
				<td class="FieldButton">
				<button onclick="query()">查 询</button>
				</td>
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
				<td class="FieldLabel"></td>
			</tr>
			<tr>
				<td class="FieldLabel">状态：</td>
				<td class="FieldInput"><select id="hosStatus" name="hosStatus"
					field="insuranceType">
					<option dataset="hosStatusDataset"></option>
				</select></td>
				<td class="FieldLabel">病种：</td>
				<td class="FieldInput">
				<input type="text" id="disease" maxlength="30"
					class="TextEditor" title="病种" />
				</td>
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

<next:GridPanel id="editGridPanel" name="sammedicalbalanceGrid" notSelectFirstRow="true"
	width="100%" stripeRows="true" height="100%" dataset="ds" clickToSelectedForChkSM="true"
	title="入院备案信息列表">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="费用结算" iconCls="edit" handler="leave" />
		<next:ToolBarItem text="打印结算单" iconCls="edit" handler="printBillClick" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="pay" />
		<next:ToolBarItem text="重新结算" iconCls="edit" handler="strikePay" />
		<next:ToolBarItem text="删除" iconCls="remove" handler="del" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="15" />
		<next:CheckBoxColumn></next:CheckBoxColumn>

		<next:Column id="hospitalRecordId" header="住院号"
			field="HOSPITAL_RECORD_ID" width="10%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="peopleId" header="姓名" field="NAME" width="10%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="peopleId" header="身份证号" field="ID_CARD" width="20%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="status" header="救助状态" field="STATUS" dataset="StatusDataset" width="10%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="病种" field="DISEASE" width="15%" sortable="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="insuranceType" header="保险险种" field="INSURANCE_TYPE"
			width="20%">
			<next:ComboBox dataset="SafeguardDataset" displayField="text"
				valueField="value" typeAhead="true" />
		</next:Column>
		<next:Column id="assitanceType" header="医疗救助类型" field="ASSITANCE_TYPE"
			width="20%">
			<next:ComboBox dataset="assitanceTypeDataset" displayField="text"
				valueField="value" typeAhead="true" />
		</next:Column>
		<next:Column id="inTime" header="入院日期" field="IN_DATE" width="10%">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="leaveTime" header="出院日期" field="LEAVE_DATE"
			width="10%">
			<next:TextField />
		</next:Column>

		<next:Column id="balanceTime" header="结算日期" field="BALANCE_TIME"
			width="10%">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
<next:Window id="pay" closeAction="hide" width="550" height="170" title="入院备案信息修改">
	<next:AnchorLayout>
		<next:Panel >
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存" handler="save" />
				<next:ToolBarItem iconCls="undo" text="返回" handler="back" />
			</next:TopBar>
			<next:Html>
				<form id="editForm" dataset="hosDataset" onsubmit="return false"
					style="padding: 5px;" class="L5form">
				<table border="1">
					<tr>
						<td class="FieldLabel" width="17%">姓名</td>
						<td class="FieldInput"><label id="hosName" name="姓名"></label></td>
						<td class="FieldLabel" width="20%">身份证件号码</td>
						<td class="FieldInput"><label id="hosIdCard" name="身份证件号码"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel">住院号</td>
						<td class="FieldInput"><input type="text" maxlength="30"
							name="住院号" field="hospitalRecordId" /><font
							color="red">*</font></td>
						<td class="FieldLabel">病种</td>
						<td class="FieldInput">
						<input name="病种" id="disease" field="disease" />
						<font color="red">*</font></td>
					</tr>
					<tr>
						<td width="100" class="FieldLabel">入住科室</td>
						<td class="FieldInput"><input type="text" name="入住科室" maxlength="15"
							field="hospitalDep" /><font color="red">*</font></td>
						<td class="FieldLabel">入院日期</td>
						<td class="FieldInput"><input type="text" name="入院日期"
							field="inDate"  format="Y-m-d" readonly="readonly"
					onclick="LoushangDate(this)"/><font color="red">*</font></td>
					</tr>
				</table>
				<input type="hidden" name="modID" id="modID" 
					value="<%=ExtBspInfo.getUserInfo(request).getUserId()%>" title="修改人ID" />
				</form>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
</next:Window>

</body>
</html>
