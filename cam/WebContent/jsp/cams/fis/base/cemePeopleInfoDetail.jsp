<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>工作人员明细页面</title>
<next:ScriptManager />
<script type="text/javascript" src="cemePeopleInfoDetail.js"></script>
<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
		</script>

</head>
<body>
<model:datasets>
	<!-- 人员信息DS -->
	<model:dataset id="peopleInfoDS"
		cmd="com.inspur.cams.fis.base.cmd.FisPeopleInfoQueryCmd">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisPeopleInfo"></model:record>
	</model:dataset>
	<!-- 岗位信息DS -->
	<model:dataset id="dutyInfoDS"
		cmd="com.inspur.cams.fis.base.cmd.FisDutyInfoQueryCmd">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisDutyInfo"></model:record>
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
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="工作人员信息"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="back" hidden="true"/>
	</next:TopBar>
	<!--工作人员信息开始 -->
	<next:AnchorLayout>
		<next:Panel id="people_info" width="100%" autoHeight="true">
			<next:Html>
				<form id="editForm" method="post" dataset="peopleInfoDS"
					onsubmit="return false" class="L5form">
				<table width="100%">
					<tr>
						<td class="FieldLabel">人员编号</td>
						<td class="FieldInput"><label type="text" name="人员编号"
							field="peopleId" /></td>
						<td class="FieldLabel">员工编号</td>
						<td class="FieldInput"><label name="员工编号" field="peopleCode" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">姓名</td>
						<td class="FieldInput"><label type="text" name="name"
							field="name" style="width: 135px" /></td>
						<td class="FieldLabel">性别</td>
						<td class="FieldInput"><label name="sex" field="sex"
							style="width: 135px" dataset="fisSex" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">编制性质</td>
						<td class="FieldInput"><label name="peopleType"
							field="peopleType" style="width: 135px" dataset="fisPeopleTypeDS" /></td>
						<td class="FieldLabel">身份证件号</td>
						<td class="FieldInput"><label type="text" name="idCard"
							field="idCard" style="width: 135px" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">出生日期</td>
						<td class="FieldInput"><label name="出生日期" id="birthday"
							field="birthday" /></td>
						<td class="FieldLabel">民族</td>
						<td class="FieldInput"><label name="民族" field="folk"
							dataset="DmMzDataSet"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel">政治面貌</td>
						<td class="FieldInput"><label name="political"
							field="political" style="width: 150px" dataset="sorgPoliticsDS" /></td>
						<td class="FieldLabel">文化程度</td>
						<td class="FieldInput"><label name="education"
							field="education" style="width: 135px" dataset="fisEducation" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">行政级别</td>
						<td class="FieldInput"><label name="profession"
							field="profession" style="width: 135px" dataset="fisProfessionDS" /></td>
						<td class="FieldLabel">职务</td>
						<td class="FieldInput"><label name="position"
							field="position" style="width: 135px" dataset="fisPostionDS" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">是否法人代表</td>
						<td class="FieldInput"><label name="IF_LEGAL"
							field="ifLegal" style="width: 135px" dataset="fisYesOrNo" /></td>
						<td class="FieldLabel">联系电话</td>
						<td class="FieldInput"><label type="text" name="phone"
							field="phone" style="width: 135px" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">从事本职业时间</td>
						<td class="FieldInput"><label type="text" name="workDate"
							field="workDate" style="width: 135px" /></td>
						<td class="FieldLabel">是否离岗</td>
						<td class="FieldInput"><label name="ifCancel"
							field="ifCancel" style="width: 135px" id="test"
							dataset="fisYesOrNo" /></td>
					</tr>
					<tr id="cancelInfo" style="display: none">
						<td class="FieldLabel">离岗时间</td>
						<td class="FieldInput"><label type="text" name="cancelTime"
							field="cancelTime" style="width: 135px" /></td>
						<td class="FieldLabel">离岗原因</td>
						<td class="FieldInput"><label type="text" name="cancelReason"
							field="cancelReason" style="width: 135px" /></td>
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
		<!--工作人员信息结束 -->

		<!--岗位信息开始  -->
		<next:Panel width="100%" autoHeight="true">
			<next:GridPanel id="duty_info" dataset="dutyInfoDS" width="100%"
				height="100%" stripeRows="true" autoScroll="true">
				<next:TopBar>
					<next:ToolBarItem symbol="服务岗位信息"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn />
					<next:RadioBoxColumn></next:RadioBoxColumn>

					<next:Column id="workType" header="工种" field="workType" width="90"
						align="center" dataset="fisWorkTypeDS">
						<next:TextField allowBlank="false" />
					</next:Column>

					<next:Column id="professionLevel" header="专业技术等级"
						field="professionLevel" width="100" align="center"
						dataset="fisProfessionLevelDS">
						<next:TextField allowBlank="false" />
					</next:Column>

					<next:Column id="certNo" header="证书编号" field="certNo" width="100"
						align="center">
						<next:TextField allowBlank="false" />
					</next:Column>

					<next:Column id="note" header="备注" field="note" width="200"
						align="center">
						<next:TextField />
					</next:Column>
				</next:Columns>
			</next:GridPanel>
		</next:Panel>
	</next:AnchorLayout>
	<!--岗位信息结束  -->
</next:Panel>
</body>
</html>