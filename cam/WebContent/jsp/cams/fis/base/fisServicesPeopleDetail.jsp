<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>服务机构人员信息</title>
<next:ScriptManager />
<script type="text/javascript">
			var peopleId='<%=request.getParameter("peopleId")%>';
		</script>
<script type="text/javascript" src="fisServicesPeopleDetail.js"></script>
<script type="text/javascript" src="../funeral/PublicTimeControl.js"></script>
</head>
<body>
<model:datasets>
	<!-- 人员信息DS -->
	<model:dataset id="peopleInfoDS" cmd="com.inspur.cams.fis.base.cmd.FisServicesPeopleInfoQueryCmd">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisServicesPeopleInfo"></model:record>
	</model:dataset>
	<!-- 岗位信息DS -->
	<model:dataset id="dutyInfoDS" cmd="com.inspur.cams.fis.base.cmd.FisServicesDutyInfoQueryCmd">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisServicesDutyInfo"></model:record>
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
			<next:ToolBarItem symbol="人员信息"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="undo" text="返回" handler="back" hidden="true"/>
		</next:TopBar>
		<next:Html>
			<form id="editForm" method="post" dataset="peopleInfoDS"
				onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel">人员编号</td>
					<td class="FieldInput"><label type="text" name="人员编号" field="peopleId" /></td>
					<td class="FieldLabel">员工编号</td>
					<td class="FieldInput"><label type="text" id="peopleCode"
						name="员工编号" field="peopleCode" maxlength="50" /> <font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel">姓名</td>
					<td class="FieldInput"><label type="text" name="name"
						field="name" style="width: 140px" /></td>
					<td class="FieldLabel">性别</td>
					<td class="FieldInput"><label name="sex" field="sex"  dataset="fisSex"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel">编制性质</td>
					<td class="FieldInput"><label name="peopleType"
						field="peopleType" dataset="fisPeopleTypeDS"></label></td>
					<td class="FieldLabel">身份证件号</td>
					<td class="FieldInput"><label type="text" name="idCard"
						field="idCard" style="width: 140px" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">政治面貌</td>
					<td class="FieldInput"><label name="political"
						field="political" dataset="sorgPoliticsDS"></label></td>
					<td class="FieldLabel">文化程度</td>
					<td class="FieldInput"><label name="education"
						field="education"  dataset="fisEducation"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel">出生日期</td>
					<td class="FieldInput"><label type="text" name="出生日期"
						id="birthday" field="birthday"></td>
					<td class="FieldLabel">民族</td>
					<td class="FieldInput"><label name="民族" field="folk" dataset="DmMzDataSet"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel">行政级别</td>
					<td class="FieldInput"><label name="profession"
						field="profession" dataset="fisProfessionDS"></label></td>
					<td class="FieldLabel">职务</td>
					<td class="FieldInput"><label name="position"
						field="position" dataset="fisPostionDS"></label>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel">是否法人代表</td>
					<td class="FieldInput"><label name="ifLegal"
						field="ifLegal" dataset="fisYesOrNo"></label>
					</td>
					<td class="FieldLabel">联系电话</td>
					<td class="FieldInput"><label type="text" name="phone"
						field="phone" style="width: 140px" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">工作单位</td>
					<td class="FieldInput"><label type="text" name="workName"
						field="workName" style="width: 140px" /></td>
					<td class="FieldLabel">从业日期</td>
					<td class="FieldInput"><label type="text" name="workDate"
						field="workDate" onclick="LoushangDatetime(this)" format="Y-m-d"
						style="width: 140px" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">是否离岗</td>
					<td class="FieldInput" ><label name="ifCancel"
						field="ifCancel" dataset="fisYesOrNo"></label>
					</td>
					<td class="FieldLabel">接受民政部门培训情况</td>
					<td class="FieldInput"><label type="text" name="trainCase"
						field="trainCase" style="width: 140px" /></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:GridPanel id="editGridPanel" name="fiscarinfoGrid" width="100%" height="100%" stripeRows="true" dataset="dutyInfoDS">
	<next:TopBar>
		<next:ToolBarItem symbol="人员岗位信息"></next:ToolBarItem>
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