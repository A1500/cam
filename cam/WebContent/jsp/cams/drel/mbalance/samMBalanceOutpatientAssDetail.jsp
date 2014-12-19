<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.DateUtil"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>定点医疗机构门规信息列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="samMBalanceOutpatientAssDetail.js"></script>
<script type="text/javascript" src="samMBalanceComm.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript">
			 var hospitalId ='<%=request.getParameter("hospitalId")%>';
			 var beginTime  ='<%=request.getParameter("beginTime")%>';
			 var endTime ='<%=request.getParameter("endTime")%>';
			var organId='<%=BspUtil.getCorpOrgan().getOrganId()%>'
			var organCode='<%=BspUtil.getCorpOrgan().getOrganCode()%>';;
		</script>
	</head>
	
<body>
<model:datasets>
	<!-- 医疗救助类型 -->
	<model:dataset id="assitanceTypeDataset" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_assitance_Type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
			<model:param name="includeCode" value='01,02,03,11'></model:param>
		</model:params>
	</model:dataset>
    <model:dataset id="ds" cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalClinicSpQueryCmd" method="queryBySql" pageSize="10">
	</model:dataset>
	<model:dataset id="ds2" cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalClinicSpQueryCmd">
      <model:record fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalClinicSp">
      		<model:field name="dateBegin" type="string"  rule="require"/>
      		<model:field name="dateEnd" type="string"  rule="require"/>
      		<model:field name="totalExpense" type="string"  rule="require"/>
      		<model:field name="hospitalPay" type="string"  rule="require"/>
      		<model:field name="specialPay" type="string"  rule="require"/>
      		<model:field name="personalPay" type="string"  rule="require"/>
      		<model:field name="num" type="string"  rule="require|integer"/>
      		<model:field name="doctor" type="string"  rule="require"/>
      		<model:field name="diagnosis" type="string"  rule="require|length{500}"/>
      </model:record>
	</model:dataset>	
	<model:dataset id="ds3" cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalClinicSpQueryCmd" method="queryBySql" pageSize="10">
	</model:dataset>	
<!-- 个人信息 -->
	<model:dataset id="peopleDS" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
		</model:record>
	</model:dataset>	
	<!-- 个人信息 -->
	<model:dataset id="basePeopleDs" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
		</model:record>
	</model:dataset>
	<model:dataset id="basePeopleDs2" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
		</model:record>
	</model:dataset>
	<model:dataset id="signDS" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="typeDS" enumName="EXT.BPTTYPE" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="sexDS" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:GridPanel id="rule_Grid" name="rule_Grid"   dataset="ds" title="机构门规信息列表" stripeRows="true" notSelectFirstRow="true" autoScroll="true" collapsible="true"  width="100%" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="查看明细" iconCls="detail" handler="detail_rules"></next:ToolBarItem>
		<next:ToolBarItem text="返回" iconCls="return" handler="back_report"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
	     <next:RowNumberColumn width="10"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="id" header=" 门规ID" field="ID" hidden="true" width="10%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="gpeopleId" header="人员id" field="PEOPLE_ID" hidden="true" width="10%"  >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="name" header="姓名" field="NAME" sortable="true" width="7%">
			<next:TextField />
		</next:Column>
		<next:Column id="psex" header="性别" field="SEX" width="5%">
			<next:TextField />
		</next:Column>
		<next:Column id="page" header="年龄" field="AGE" width="5%">
			<next:TextField />
		</next:Column>
		<next:Column id="gidCard" header="身份证号码" field="ID_CARD" width="15%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="hospitalId" header="就诊机构" field="HOSPITAL_ID" hidden="true">
			<next:TextField />
		</next:Column>
		<next:Column id="dateBegin" header="就诊时间起" field="DATE_BEGIN" sortable="true" width="10%">
			<next:TextField />
		</next:Column>
		<next:Column id="dateEnd" header="就诊时间止" field="DATE_END" sortable="true" width="10%">
			<next:TextField />
		</next:Column>
		<next:Column  header="人次" field="NUM" sortable="true" width="5%" align="right">
			<next:TextField />
		</next:Column>
		<next:Column id="totalExpense" header="总费用(元)" field="TOTAL_EXPENSE" width="10%" align="right" >
			<next:TextField />
		</next:Column>
		<next:Column id="specialPay" header="救助金额(元)" field="SPECIAL_PAY" width="10%" align="right" >
			<next:TextField />
		</next:Column>
		<next:Column id="specialPay" header="自付费用(元)" field="PERSONAL_PAY" width="10%" align="right" >
			<next:TextField />
		</next:Column>
		<next:Column id="sign"  header="是否已提交" field="SIGN" sortable="true">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
			<next:PagingToolBar dataset="ds"  />
	</next:BottomBar>
</next:GridPanel>
<next:Window id="rule_detail" title="门规信息"  width="700" height="300" closeAction="hide" closeAction="hide" resizable="true" animCollapse="true">
	<next:Panel id="detail_rule" autoScroll="true" widget="100%" height="100%">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="关闭" iconCls="delete" handler="detail_rule"></next:ToolBarItem>
		</next:TopBar>
		<next:Html>
			<form class="L5form" dataset="ds3">
				<table width="100%">
					<tr>
						<td class="FieldLabel" width="15%">身份证号码：</td>
						<td class="FieldInput" width="20%">
							<label id="didCard" field="ID_CARD"></label>
						</td>
						<td class="FieldLabel" width="15%">姓名：</td>
						<td class="FieldInput" width="15%">
							<label id="rname" field="NAME"></label>
						</td>
						<td class="FieldLabel" width="15%">性别:</td>
						<td class="FieldInput" width="15%">
							<label id="rsex" field="SEX"   dataset="sexDS"></label>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">年龄：</td>
						<td class="FieldInput">
							<label id="rage" field="AGE"></label>
						</td>
						<td class="FieldLabel">救助对象类别：</td>
						<td class="FieldInput" colspan="3">
							<label id="rbptType" field="ASSITANCE_TYPE"  dataset="assitanceTypeDataset"></label>
						</td>	
					</tr>
					<tr >
						<td class="FieldLabel">就诊时间起：</td>
						<td class="FieldInput">
							<label id="dateBegin" name="就诊时间起：" field="DATE_BEGIN"  ></label>
						</td>
						<td class="FieldLabel">就诊时间止：</td>
						<td class="FieldInput">
							<label id="dateEnd" name="就诊时间止：" field="DATE_END" ></label>
						</td>
						<td class="FieldLabel">总费用(元)：</td>
						<td class="FieldInput">
							<label id="totalExpense" name="总费用：" field="TOTAL_EXPENSE" ></label>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">救助金额(元)：</td>
						<td class="FieldInput">
							<label id="specialPay" name="优抚补助金额：" field="SPECIAL_PAY" ></label>
						</td>
						<td class="FieldLabel">自付费用(元)：</td>
						<td class="FieldInput">
							<label id="personalPay" name="自付费用：" field="PERSONAL_PAY" ></label>
						</td>
						<td class="FieldLabel"></td>
						<td class="FieldInput"></td>
					</tr>
					<tr>
						<td class="FieldLabel">人次：</td>
						<td class="FieldInput">
							<label id="num" name="人次：" field="NUM" ></label>
						</td>
						<td class="FieldLabel">门诊医师：</td>
						<td class="FieldInput">
							<label id="doctor" name="门诊医师：" field="DOCTOR" ></label>
						</td>
						<td class="FieldLabel"></td>
						<td class="FieldInput"></td>
					</tr>
					<tr>
						<td class="FieldLabel">门诊诊断：</td>
						<td class="FieldInput" colspan="5">
							<textArea type="text" id="diagnosis" name="门诊诊断：" field="DIAGNOSIS"  cols="2" rows="5" readonly="readonly" style="width:98%;"></textArea>
						</td>
					</tr>
				</table>
			</form>
		</next:Html>
	</next:Panel>
</next:Window>
</body>
</html>