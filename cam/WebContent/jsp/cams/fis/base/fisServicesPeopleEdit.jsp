<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>服务机构人员信息维护</title>
<next:ScriptManager />
<script type="text/javascript">
			var method='<%=request.getParameter("method")%>';
			var peopleId='<%=request.getParameter("peopleId")%>';
			var organId='<%=request.getParameter("organId")%>';
		</script>
<script type="text/javascript" src="fisServicesPeopleEdit.js"></script>
<script type="text/javascript" src="../funeral/PublicTimeControl.js"></script>
</head>
<body>
<model:datasets>
	<!-- 人员信息DS -->
	<model:dataset id="peopleInfoDS"
		cmd="com.inspur.cams.fis.base.cmd.FisServicesPeopleInfoQueryCmd">
		<model:record
			fromBean="com.inspur.cams.fis.base.data.FisServicesPeopleInfo"></model:record>
	</model:dataset>
	<!-- 服务机构信息 -->
	<model:dataset id="fisServicesOrganManageDs"
		cmd="com.inspur.cams.fis.base.cmd.FisServicesOrganManageQueryCmd"
		global="true" pageSize="-1" sortField="unitId">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisServicesOrganManage">
			<model:field name="value" mapping="unitId" type="string"/>
			<model:field name="text" mapping="unitName" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 岗位信息DS -->
	<model:dataset id="dutyInfoDS"
		cmd="com.inspur.cams.fis.base.cmd.FisServicesDutyInfoQueryCmd">
		<model:record
			fromBean="com.inspur.cams.fis.base.data.FisServicesDutyInfo"></model:record>
	</model:dataset>
	<!-- 岗位信息窗口DS --> 
	<model:dataset id="dutyInfoWinDS"
		cmd="com.inspur.cams.fis.base.cmd.FisServicesDutyInfoQueryCmd">
		<model:record
			fromBean="com.inspur.cams.fis.base.data.FisServicesDutyInfo"></model:record>
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
	<!-- 民族代码-->
	<model:dataset id="DmMzDataSet" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 编制性质 -->
	<model:dataset id="fisPeopleTypeDS" enumName="FIS.PEOPLE.TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 行政级别 -->
	<model:dataset id="fisProfessionDS" enumName="FIS.PROFESSION"
		autoLoad="true" global="true"></model:dataset>
	<!-- 职务 -->
	<model:dataset id="fisPostionDS" enumName="FIS.POSITION"
		autoLoad="true" global="true"></model:dataset>
	<!-- 工种 -->
	<model:dataset id="fisWorkTypeDS" enumName="FIS.WORK.TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 性别 -->
	<model:dataset id="fisSex" enumName="COMM.SEX" autoLoad="true"
		global="true"></model:dataset>
	<!-- 文化程度 -->
	<model:dataset id="fisEducation" enumName="FIS.EDUCATION"
		autoLoad="true" global="true"></model:dataset>
	<!-- 是否 -->
	<model:dataset id="fisYesOrNo" enumName="COMM.YESORNO" autoLoad="true"
		global="true"></model:dataset>
	<!-- 专业技术等级 -->
	<model:dataset id="fisProfessionLevelDS"
		enumName="FIS.PROFESSION.LEVEL" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" autoHeight="true" autoScroll="true">
	<next:Panel name="form" width="100%" border="0">
		<next:TopBar>
			<next:ToolBarItem symbol="服务机构人员信息"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="save" text="全部保存" handler="save" />
			<next:ToolBarItem iconCls="undo" text="返回" handler="back" />
		</next:TopBar>
		<next:Html>
			<form id="editForm" method="post" dataset="peopleInfoDS"
				onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel">人员编号</td>
					<td class="FieldInput"><label type="text" name="人员编号"
						field="peopleId" /></td>
					<td class="FieldLabel">所属单位</td>
					<td class="FieldInput"><select name="createOrgan" field="createOrgan"
						style="width: 140px">
						<option dataset="fisServicesOrganManageDs"></option>
					</select></td>
				</tr>
				<tr>
					<td class="FieldLabel">姓名</td>
					<td class="FieldInput"><input type="text" name="name"
						field="name" style="width: 140px" /></td>
					<td class="FieldLabel">性别</td>
					<td class="FieldInput"><select name="sex" field="sex"
						style="width: 140px">
						<option dataset="fisSex"></option>
					</select></td>
				</tr>
				<tr>
					<td class="FieldLabel">编制性质</td>
					<td class="FieldInput"><select name="peopleType"
						field="peopleType" style="width: 140px">
						<option dataset="fisPeopleTypeDS"></option>
					</select></td>
					<td class="FieldLabel">身份证件号</td>
					<td class="FieldInput"><input type="text" name="idCard"
						field="idCard" style="width: 140px" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">政治面貌</td>
					<td class="FieldInput"><select name="political"
						field="political" style="width: 140px">
						<option dataset="sorgPoliticsDS"></option>
					</select></td>
					<td class="FieldLabel">文化程度</td>
					<td class="FieldInput"><select name="education"
						field="education" style="width: 140px">
						<option dataset="fisEducation"></option>
					</select></td>
				</tr>
				<tr>
					<td class="FieldLabel">出生日期</td>
					<td class="FieldInput"><input type="text" name="出生日期"
						id="birthday" field="birthday"
						onpropertychange="changeDateStyle(this)" style="width: 140px"
						format="Y-m-d" maxlength="10" onblur="check(this)" /><img
						src="../../../../skins/images/default/rl.gif" align="middle"
						onclick="getDay(this);"></td>
					<td class="FieldLabel">民族</td>
					<td class="FieldInput"><select name="民族" field="folk"
						style="width: 140px">
						<option dataset="DmMzDataSet"></option>
					</select></td>
				</tr>
				<tr>
					<td class="FieldLabel">行政级别</td>
					<td class="FieldInput"><select name="profession"
						field="profession" style="width: 140px">
						<option dataset="fisProfessionDS"></option>
					</select></td>
					<td class="FieldLabel">职务</td>
					<td class="FieldInput"><input type="text" name="position"
						field="position" style="width: 140px" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">是否法人代表</td>
					<td class="FieldInput"><select name="IF_LEGAL" field="ifLegal"
						style="width: 140px">
						<option dataset="fisYesOrNo"></option>
					</select></td>
					<td class="FieldLabel">联系电话</td>
					<td class="FieldInput"><input type="text" name="phone"
						field="phone" style="width: 140px" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">工作单位</td>
					<td class="FieldInput"><input type="text" name="workName"
						field="workName" style="width: 140px" /></td>
					<td class="FieldLabel">从事本职业时间</td>
					<td class="FieldInput"><input type="text" name="workDate"
						field="workDate" onclick="LoushangDatetime(this)" format="Y-m-d"
						style="width: 140px" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">是否离岗</td>
					<td class="FieldInput"><select name="ifCancel"
						field="ifCancel" style="width: 140px">
						<option dataset="fisYesOrNo"></option>
					</select></td>
					<td class="FieldLabel">接受民政部门培训情况</td>
					<td class="FieldInput"><input type="text" name="trainCase"
						field="trainCase" style="width: 140px" /></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>

	<next:GridPanel id="editGridPanel" name="fiscarinfoGrid" width="100%"
		height="100%" stripeRows="true" dataset="dutyInfoDS">
		<next:TopBar>
			<next:ToolBarItem symbol="服务机构人员岗位信息"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="岗位添加" iconCls="add" handler="insertWin" />
			<next:ToolBarItem text='修改' iconCls="edit" handler="updateWin" />
			<next:ToolBarItem text='删除' iconCls="remove" handler="deteleWin" />
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>

			<next:Column header="工种" field="workType" dataset="fisWorkTypeDS"
				align="center">
				<next:TextField allowBlank="false" />
			</next:Column>

			<next:Column header="上岗证书编号" field="certNo" width="100"
				align="center">
				<next:TextField allowBlank="false" />
			</next:Column>

			<next:Column header="专业技术等级" field="professionLevel" width="100"
				dataset="fisProfessionLevelDS" align="center">
				<next:TextField allowBlank="false" />
			</next:Column>

			<next:Column header="备注" field="note" width="200">
				<next:TextField allowBlank="false" />
			</next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="dutyInfoDS" />
		</next:BottomBar>
	</next:GridPanel>
</next:Panel>
</body>
</html>

<next:Window id="detail" title="服务机构人员岗位信息" width="750" height="200"
	collapsible="true" closeAction="hide" resizable="false" pageX="40"
	pageY="50">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveWin" />
		<next:ToolBarItem iconCls="remove" text="关闭" handler="closeWin" />
	</next:TopBar>
	<next:Html>
		<form id="dutyForm" method="post" onsubmit="return false"
			class="L5form" dataset="dutyInfoWinDS">
		<fieldset><legend>服务机构人员岗位信息</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel" width="18%">工种</td>
				<td class="FieldInput" width="33%"><select name="workType"
					field="workType" style="width: 135px">
					<option dataset="fisWorkTypeDS"></option>
				</select></td>
				<td class="FieldLabel" width="18%">上岗证书编号</td>
				<td class="FieldInput" width="33%"><input type="text"
					name="certNo" field="certNo" style="width: 135px" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" width="16%">专业技术等级</td>
				<td class="FieldInput" colspan="3"><select
					name="professionLevel" field="professionLevel" style="width: 135px">
					<option dataset="fisProfessionLevelDS"></option>
				</select></td>
			</tr>
			<tr>
				</td>
				<td class="FieldLabel">备注:</td>
				<td class="FieldInput" colspan="5"><textArea name="note"
					field="note" cols="10" rows="2" style="width: 90%"></textArea></td>
			</tr>
		</table>
		</fieldset>
		</form>
	</next:Html>
</next:Window>