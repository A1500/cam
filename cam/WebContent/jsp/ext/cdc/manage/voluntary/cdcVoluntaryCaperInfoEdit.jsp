<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>志愿者活动信息维护</title>
<next:ScriptManager />
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var caperId='<%=request.getParameter("caperId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<script type="text/javascript" src="PublicTimeControl.js"></script>
<script type="text/javascript" src="cdcVoluntaryCaperInfoEdit.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<!-- 志愿者活动信息DS -->
	<model:dataset id="cdcCaperInfoDataSet"
		cmd="com.inspur.cams.cdc.base.cmd.CdcCaperInfoQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcCaperInfo">
			<model:field name="startTime" type="string" rule="require" />
			<model:field name="endTime" type="string" rule="require" />
			<model:field name="address" type="string" rule="require" />
			<model:field name="content" type="string" rule="require" />
			<model:field name="entrepreneur" type="string" rule="require" />
		</model:record>
	</model:dataset>

	<!-- 志愿者Ds -->
	<model:dataset id="cdcVoluntaryInfoDataSet"
		cmd="com.inspur.cams.cdc.base.cmd.CdcVoluntaryInfoQueryCmd"
		method="queryByCaper" pageAble="false" global="true">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcVoluntaryInfo">
			<model:field name="startTime" type="string" rule="require" />
			<model:field name="endTime" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 志愿者Ds-查询 -->
	<model:dataset id="cdcVoluntaryInfoDataSetQuery"
		cmd="com.inspur.cams.cdc.base.cmd.CdcVoluntaryInfoQueryCmd"
		pageSize="15" sortField="CREATE_TIME DESC,VOLUNTARY_ID" global="true">
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
</model:datasets>
<next:Panel width="100%" height="100%" autoScroll="false">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveBack" />
		<next:ToolBarItem iconCls="return" text="关闭" handler="back" />
	</next:TopBar>
	<next:Panel width="100%" autoScroll="false">
		<next:TopBar>
			<next:ToolBarItem symbol="志愿者活动信息"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
		</next:TopBar>
		<next:Html>
			<form id="editForm" method="post" dataset="cdcCaperInfoDataSet"
				onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 180px;">开始时间</td>
					<td class="FieldInput">						
				        <input type="text" id="startTime" field="startTime" name="开始时间" 
				        	onpropertychange="changeDateStyle(this)" onblur="checktime(this)"  
				        	format="Y-m-d H:i" maxlength="16"/>
						<font color="red">*</font></td>
					<td class="FieldLabel" style="width: 180px;">结束时间</td>
					<td class="FieldInput">
						<input type="text" id="endTime" field="endTime" name="结束时间" 
				       	 	onpropertychange="changeDateStyle(this)" onblur="checktime(this)"  
				       	 	format="Y-m-d H:i" maxlength="16"/>
						<font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel">地点</td>
					<td class="FieldInput" colspan="3"><input type="text" id="address" name="地点" 
						field="address" style="width: 80%" maxlength="100" /><font
						color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel">活动内容</td>
					<td class="FieldInput" colspan="3"><input type="text"
						name="活动内容" field="content" style="width: 80%" maxlength="150" /><font
						color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel">主办单位/组织者姓名</td>
					<td class="FieldInput"><input type="text" name="主办单位/组织者姓名"
						field="entrepreneur" style="width: 150px" maxlength="100" /><font
						color="red">*</font></td>
					<td class="FieldLabel">参加人数</td>
					<td class="FieldInput"><label id="caperNums" field="caperNums" /></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:EditGridPanel id="grid" dataset="cdcVoluntaryInfoDataSet"
		width="99.9%" stripeRows="true" height="535" notSelectFirstRow="true">
		<next:TopBar>
			<next:ToolBarItem symbol="志愿者信息"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="add" text="增加" handler="addSel"></next:ToolBarItem>
			<next:ToolBarItem iconCls="remove" text="移除" handler="removeSel"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn></next:RowNumberColumn>
			<next:CheckBoxColumn></next:CheckBoxColumn>
			<next:Column field="voluntaryId" header="志愿者编号" hidden="true" />
			<next:Column field="name" header="姓名" width="90" sortable="false"
				align="center" editable="false" />
			<next:Column field="startTime" header="开始时间" width="120"
				sortable="false" align="center">
				<next:DateTimeField format="Y-m-d H:i"></next:DateTimeField>
			</next:Column>
			<next:Column field="endTime" header="结束时间" width="120"
				sortable="false" align="center">
				<next:DateTimeField format="Y-m-d H:i"></next:DateTimeField>
			</next:Column>
			<next:Column field="idCard" header="身份证号" width="140"
				sortable="false" editable="false" />
			<next:Column field="sex" header="性别" width="60" sortable="false"
				dataset="sexDs" align="center" editable="false" />
			<next:Column field="birthday" header="出生日期" width="80"
				sortable="false" align="center" editable="false" />
			<next:Column field="eduCode" header="文化程度" width="150"
				sortable="false" dataset="educationDs" editable="false" />
			<next:Column field="politicalCode" header="政治面貌" width="150"
				dataset="sorgPoliticsDS" sortable="false" editable="false" />
			<next:Column field="tel" header="联系电话" width="100" sortable="false" editable="false" />
			<next:Column field="email" header="电子邮箱" width="100" sortable="false" editable="false" />
			<next:Column field="address" header="家庭住址" width="100"
				sortable="false" editable="false" />
			<next:Column field="forte" header="特长" width="100" sortable="false" editable="false" />
			<next:Column field="caperNums" header="志愿活动累计次数" width="130"
				sortable="false" align="right" editable="false" />
			<next:Column field="caperTimes" header="志愿活动累计时间" width="130"
				sortable="false" align="right" editable="false"/>
		</next:Columns>
	</next:EditGridPanel>
</next:Panel>
</body>
</html>

<!-- 选择志愿者窗口 -->
<next:Window id="addSelWin" closeAction="hide" title="选择志愿者"
	height="600" width="900" modal="true" modal="true">
	<next:Panel width="98%" height="100%" border="0">
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
						<td class="FieldButton" colspan="2">
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
		<next:GridPanel id="selectedGrid" dataset="cdcVoluntaryInfoDataSetQuery"
			width="100%" stripeRows="true" height="440" notSelectFirstRow="true">
			<next:TopBar>
				<next:ToolBarItem symbol="志愿者信息"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="add" text="新增" handler="addAgain"></next:ToolBarItem>
				<next:ToolBarItem iconCls="return" text="关闭" handler="closeWin"></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn></next:RowNumberColumn>
				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column field="voluntaryId" header="志愿者编号" hidden="true" />
				<next:Column field="name" header="姓名" width="90" sortable="false"
					align="center" />
				<next:Column field="idCard" header="身份证号" width="140"
					sortable="false" />
				<next:Column field="sex" header="性别" width="60" sortable="false"
					dataset="sexDs" align="center" />
				<next:Column field="birthday" header="出生日期" width="80"
					sortable="false" align="center" />
				<next:Column field="eduCode" header="文化程度" width="150"
					sortable="false" dataset="educationDs" />
				<next:Column field="politicalCode" header="政治面貌" width="150"
					dataset="sorgPoliticsDS" sortable="false" />
				<next:Column field="workUnit" header="工作单位" width="100"
					sortable="false" />
				<next:Column field="tel" header="联系电话" width="100" sortable="false" />
				<next:Column field="email" header="电子邮箱" width="100"
					sortable="false" />
				<next:Column field="address" header="家庭住址" width="100"
					sortable="false" />
				<next:Column field="postCode" header="邮编" width="100"
					sortable="false" />
				<next:Column field="forte" header="特长" width="100" sortable="false" />
				<next:Column field="caperNums" header="志愿活动累计次数" width="130"
					sortable="false" align="right" />
				<next:Column field="caperTimes" header="志愿活动累计时间" width="130"
					sortable="false" align="right" />
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="cdcVoluntaryInfoDataSetQuery" />
			</next:BottomBar>
		</next:GridPanel>
	</next:Panel>
</next:Window>