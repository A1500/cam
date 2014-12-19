<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>志愿者信息列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="cdcVoluntaryInfoList.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<body>
<model:datasets>
	<!-- 志愿者Ds -->
	<model:dataset id="cdcVoluntaryInfoDataSet"
		cmd="com.inspur.cams.cdc.base.cmd.CdcVoluntaryInfoQueryCmd"
		pageSize="10" sortField="CREATE_TIME DESC,VOLUNTARY_ID">
		<model:record
			fromBean="com.inspur.cams.cdc.base.data.CdcVoluntaryInfo" />
	</model:dataset>

	<!-- 政治面貌-->
	<model:dataset id="sorgPoliticsDS" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="sexDs" enumName="COMM.SEX" autoLoad="true"
		global="true"></model:dataset>
	<!-- 文化程度 -->
	<model:dataset id="educationDs" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EDUCATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="yesOrNoDs" enumName="COMM.YESORNO" autoLoad="true"
		global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel"><label>姓名:</label></td>
				<td class="FieldInput"><input type="text" id="qName" /></td>
				<td class="FieldLabel"><label>身份证号:</label></td>
				<td class="FieldInput"><input type="text" id="qIdCard" /></td>
				<td class="FieldLabel"><label>性别:</label></td>
				<td class="FieldInput"><select id="qSex">
					<option dataset="sexDs"></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>文化程度:</label></td>
				<td class="FieldInput"><select id="qEduCode">
					<option dataset="educationDs"></option>
				</select></td>
				<td class="FieldLabel"><label>政治面貌:</label></td>
				<td class="FieldInput"><select id="qPoliticalCode">
					<option dataset="sorgPoliticsDS"></option>
				</select></td>
				<td class="FieldLabel"><label>联系电话:</label></td>
				<td class="FieldInput"><input type="text" id="qTel" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>电子邮箱:</label></td>
				<td class="FieldInput"><input type="text" id="qEmail" /></td>
				<td class="FieldLabel"><label>家庭住址:</label></td>
				<td class="FieldInput"><input type="text" id="qAddress" /></td>
				<td class="FieldButton" style="width: 20%" colspan="2">
				<button onclick="query()">查询</button>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="reset">重置</button>
				</td>
			</tr>
		</table>
		</form>
		</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="grid" dataset="cdcVoluntaryInfoDataSet"
	width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="insert" id="btnAdd"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="update" id="btnEdit"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detail"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="del" id="btnDel"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="voluntaryId" header="志愿者编号" hidden="true" />
		<next:Column field="name" header="姓名" width="90" sortable="false" align="center"/>
		<next:Column field="idCard" header="身份证号" width="140" sortable="false" />
		<next:Column field="sex" header="性别" width="60" sortable="false" dataset="sexDs" align="center"/>
		<next:Column field="birthday" header="出生日期" width="80"
			sortable="false" align="center"/>
		<next:Column field="eduCode" header="文化程度" width="150" sortable="false" dataset="educationDs"/>
		<next:Column field="politicalCode" header="政治面貌" width="150" dataset="sorgPoliticsDS"
			sortable="false" />
		<next:Column field="workUnit" header="工作单位" width="100"
			sortable="false" />
		<next:Column field="tel" header="联系电话" width="100" sortable="false" />
		<next:Column field="email" header="电子邮箱" width="100" sortable="false" />
		<next:Column field="address" header="家庭住址" width="100"
			sortable="false" />
		<next:Column field="postCode" header="邮编" width="100" sortable="false" />
		<next:Column field="forte" header="特长" width="100" sortable="false" />
		<next:Column field="caperNums" header="志愿活动累计次数" width="130"
			sortable="false" align="right"/>
		<next:Column field="caperTimes" header="志愿活动累计时间(分钟)" width="150"
			sortable="false" align="right"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="cdcVoluntaryInfoDataSet" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>