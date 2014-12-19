<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page
	import="com.inspur.cams.comm.util.*,org.loushang.next.skin.SkinUtils,com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<html>
<head>
<title>登记发证录入页面</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
	var rootPath='<%=SkinUtils.getRootUrl(request)%>';
	var processId='<%=request.getParameter("processId")%>';
	var actDefUniqueId='<%=request.getParameter("actDefUniqueId")%>';
	var assignmentId='<%=request.getParameter("assignmentId")%>';	
	var method='<%=request.getParameter("method")%>';			
</script>
<script type="text/javascript" src="somFundBuildInform.js"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams/somPhoto.js") %>'></script>
<script type="text/javascript"
	src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<%--基金会基本信息--%>
	<model:dataset id="somOrganDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true"
		method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<%--业务意见--%>
	<model:dataset id="somApplyDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<%--业务意见信息验证--%>
			<model:field name="curOpinionId" type="string" rule="require" />
			<model:field name="curOpinion" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
	<%--历史意见 --%>
	<model:dataset id="somFlowDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" global="true"
		sortField="COMMIT_TIME" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<model:dataset id="somFlowQuery" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<!-- 处理单位 -->
	<model:dataset id="pubOrganDataSet"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='PUB_ORGAN'></model:param>
			<model:param name="value" value='ORGAN_ID'></model:param>
			<model:param name="text" value='ORGAN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="sorgKindSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_FUND_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 住所来源 -->
	<model:dataset id="resideSourceSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RESIDE_SOURCE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 住所来源 -->
	<model:dataset id="sorgNameSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_ORGAN'></model:param>
			<model:param name="value" value='SORG_ID'></model:param>
			<model:param name="text" value='CN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 所属行事业 -->
	<model:dataset id="busScopeSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 业务主管单位 -->
	<model:dataset id="businessOrganSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="基金会成立登记"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<%
			if ("daiban".equals(request.getParameter("method"))) {
		%>
		<next:ToolBarItem iconCls="select" text="提交" handler="submit"></next:ToolBarItem>
		<%
			}
		%>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnClick"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab">
		<next:Tabs>
			<next:Panel title="基金会法人基本信息" width="100%">
				<next:Panel width="100%" height="100%" id="tab1" autoScroll="true">
					<next:Html>
						<fieldset><legend>基金会法人基本信息</legend>
						<form method="post" onsubmit="return false" class="L5form"
							dataset="somOrganDataSet">
						<table width="100%">
							<tr>
								<td class="FieldLabel">基金会中文名称：</td>
								<td class="FieldInput" colspan="3"><label field="cnName"></label></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">基金会英文名称：</td>
								<td class="FieldInput" style="width: 17%"><label field="enName"/></td>
								<td class="FieldLabel" style="width: 17%">基金会英文名称缩写：</td>
								<td class="FieldInput" style="width: 17%"><label field="abName"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">登记证号：</td>
								<td class="FieldInput"><label field="sorgCode"/></td>
								<td class="FieldLabel">组织机构代码：</td>
								<td class="FieldInput"><label field="organCode"/></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">登记时间：</td>
								<td class="FieldInput" style="width: 17%"><label field="regDate"/></td>
								<td class="FieldLabel">基金会类型：</td>
								<td class="FieldInput"><label field="sorgKind" dataset="sorgKindSelect"/><</td>
							</tr>
							<tr>
								<td class="FieldLabel">法定代表人：</td>
								<td class="FieldInput"><label field="legalPeople" /></td>
								<td class="FieldLabel">原始基金：</td>
								<td class="FieldInput"><label field="regMon"/>万元</td>
							</tr>
							<tr>
								<td class="FieldLabel">理事数：</td>
								<td class="FieldInput"><label field="councilNum" /></td>
								<td class="FieldLabel">监事数：</td>
								<td class="FieldInput"><label field="standCouncilNum" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">业务主管单位：</td>
								<td class="FieldInput" colspan="3"><label field="borgName" dataset="businessOrganSelect"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">住所：</td>
								<td class="FieldInput"><label field="residence"/></td>
								<td class="FieldLabel" style="width: 17%">邮编：</td>
								<td class="FieldInput" style="width: 17%"><label field="postCode"/><</td>
							</tr>
						</table>
						</form>
						</fieldset>
						<fieldset><legend>联系人信息</legend>
						<form method="post" onsubmit="return false" class="L5form"
							style="border-width: 0px" dataset="somApplyDataSet">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width: 17%">联系人：</td>
								<td class="FieldInput" style="width: 17%"><label field="appPeople"/></td>
								<td class="FieldLabel" style="width: 17%">联系人电话：</td>
								<td class="FieldInput" style="width: 17%"><label field="appPhone"/></td>
							</tr>
						</table>
						</form>
						</fieldset>
						<fieldset><legend>历史处理意见</legend>
						<form method="post" dataset="somApplyDataSet"
							onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width: 17%">承办人意见：</td>
								<td class="FieldInput" style="width: 17%"><label
									field="acceptOpinionId" name='"承办人意见"' style="width: 90%"
									dataset="hisOpinionDataSet" default="0" /></td>
								<td class="FieldLabel" style="width: 17%">承办人：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" field="acceptPeopleName" name='承办人'
									style="width: 90%" /></td>
								<td class="FieldLabel" style="width: 17%">承办时间：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" name='承办时间' field="acceptTime" style="width: 90%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">承办补充意见：</td>
								<td class="FieldInput" colspan="5"><textarea rows="3"
									name='承办补充意见' field="acceptOpinion"
									style="width: 98%; background-color: #F5FAFA; border: 0;overflow:auto;"
									readonly></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">现场勘查意见：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" field="prospectOpinionId" name='"现场勘查意见"'
									style="width: 90%" dataset="hisOpinionDataSet" /></td>
								<td class="FieldLabel" style="width: 17%">现场勘查承办人：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" field="prospectPeopleName" name='现场勘查承办人'
									style="width: 90%" /></td>
								<td class="FieldLabel" style="width: 17%">现场勘查日期：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" name='现场勘查日期' field="prospectDate"
									style="width: 90%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">现场勘查双方参加人员：</td>
								<td class="FieldInput" colspan="5"><label type="text"
									field="prospectAttendPeople" name='"现场勘查双方参加人员"'
									style="width: 90%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">现场勘查地点：</td>
								<td class="FieldInput" colspan="5"><label type="text"
									field="prospectPlace" name='现场勘查地点' style="width: 90%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">现场勘查补充意见：</td>
								<td class="FieldInput" colspan="5"><textarea rows="3"
									name='现场勘查补充意见' field="prospectOpinion"
									style="width: 98%; background-color: #F5FAFA; border: 0;overflow:auto;"
									readonly></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">初审意见：</td>
								<td class="FieldInput" style="width: 17%"><label
									field="examinOpinionId" name='"初审意见"' style="width: 90%"
									dataset="hisOpinionDataSet" /></td>
								<td class="FieldLabel" style="width: 17%">初审负责人：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" field="examinPeopleName" name='初审负责人'
									style="width: 90%" /></td>
								<td class="FieldLabel" style="width: 17%">初审时间：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" name='初审时间' field="examinTime" style="width: 90%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">初审补充意见：</td>
								<td class="FieldInput" colspan="5"><textarea rows="3"
									name='初审补充意见' field="examinOpinion"
									style="width: 98%; background-color: #F5FAFA; border: 0;overflow:auto;"
									readonly></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">审核意见：</td>
								<td class="FieldInput" style="width: 17%"><label
									field="checkOpinionId" name='"审核意见"' style="width: 90%"
									dataset="hisOpinionDataSet" /></td>
								<td class="FieldLabel" style="width: 17%">审核人：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" field="checkPeopleName" name='审核人'
									style="width: 90%" /></td>
								<td class="FieldLabel" style="width: 17%">审核时间：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" name='审核时间' field="checkTime" style="width: 90%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">审核补充意见：</td>
								<td class="FieldInput" colspan="5"><textarea rows="3"
									name='审核补充意见' field="checkOpinion"
									style="width: 98%; background-color: #F5FAFA; border: 0;overflow:auto;"
									readonly></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">批准意见：</td>
								<td class="FieldInput" style="width: 17%"><label
									field="auditOpinionId" name='"批准意见"' style="width: 90%"
									dataset="hisOpinionDataSet" /></td>
								<td class="FieldLabel" style="width: 17%">批准人：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" field="auditPeopleName" name='批准人'
									style="width: 90%" /></td>
								<td class="FieldLabel" style="width: 17%">批准时间：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" name='批准时间' field="auditTime" style="width: 90%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">批准补充意见：</td>
								<td class="FieldInput" colspan="5"><textarea rows="3"
									name='批准补充意见' field="auditOpinion"
									style="width: 98%; background-color: #F5FAFA; border: 0;overflow:auto;"
									readonly></textarea></td>
							</tr>
						</table>
						</form>
						</fieldset>
					</next:Html>
				</next:Panel>
			</next:Panel>
			<next:Panel title="流程历史意见">
				<next:EditGridPanel id="somFlowGrid" dataset="somFlowDataSet"
					width="100%" stripeRows="true" height="100%">
					<next:Columns>
						<next:RowNumberColumn />
						<next:Column header="处理环节" field="activity" width="13%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="处理单位" field="organId" width="13%"
							editable="false">
							<next:ComboBox dataset="pubOrganDataSet" />
						</next:Column>
						<next:Column header="处理部门" field="deptId" width="13%"
							editable="false">
							<next:ComboBox dataset="pubOrganDataSet" />
						</next:Column>
						<next:Column header="处理人" field="actorId" width="10%"
							editable="false">
							<next:ComboBox dataset="pubOrganDataSet" />
						</next:Column>
						<next:Column header="处理时间" field="commitTime" width="18%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="意见" field="opinionId" width="10%"
							editable="false">
							<next:ComboBox dataset="hisOpinionDataSet" />
						</next:Column>
						<next:Column header="补充意见" field="opinion" width="40%"
							editable="false">
							<next:TextField />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somFlowDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>

			<next:Panel title="处理意见" width="100%" id="ipinionPanel">
				<next:Html>
					<form method="post" onsubmit="return false" class="L5form"
						dataset="somApplyDataSet">
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width: 13%"><label>处理意见：</label></td>
							<td class="FieldInput" colspan="5"><select
								id='curOpinionId'field="curOpinionId" name='"处理意见"' style="width: 150px"
								default="0">
								<option dataset="opinionSelect"></option>
							</select><span style="color: red">*</span></td>

						</tr>
						<tr>
							<td class="FieldLabel"><label>处理补充意见：</label></td>
							<td class="FieldInput" colspan="5"><textarea rows="10"
								name='"处理补充意见"' field="curOpinion" style="width: 98%"></textarea>
							</td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>



</body>
</html>