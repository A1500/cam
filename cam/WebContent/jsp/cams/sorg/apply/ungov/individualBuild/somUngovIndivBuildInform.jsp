<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<html>
<head>
<title></title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
	var processId='<%=request.getParameter("processId")%>';
	var actDefUniqueId='<%=request.getParameter("actDefUniqueId")%>';
	var assignmentId='<%=request.getParameter("assignmentId")%>';	
	var act='<%=request.getParameter("act")%>';	
	var method='<%=request.getParameter("method")%>';	
	var rootPath='<%=SkinUtils.getRootUrl(request)%>';
	var currentUserName = '<%=GetBspInfo.getBspInfo().getUserName()%>';	
</script>
<script type="text/javascript" src="somUngovIndivBuildInform.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"bpm/bpm.js")%>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js") %>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<%--基金会基本信息--%>
	<model:dataset id="somOrganDataSet"	cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<%--业务意见--%>
	<model:dataset id="somApplyDataSet"	cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<%--业务意见信息验证--%>
			<model:field name="curOpinionId" type="string" rule="require" />
			<model:field name="curOpinion" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
	<%--历史意见 --%>
	<model:dataset id="somFlowDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" global="true" sortField="COMMIT_TIME" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<%--历史意见表--%>
	<model:dataset id="somFlowQuery" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>	
	<!-- 处理单位 -->
	<model:dataset id="pubOrganDataSet"	cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='PUB_ORGAN'></model:param>
			<model:param name="value" value='ORGAN_ID'></model:param>
			<model:param name="text" value='ORGAN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_UNGOV_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 住所来源 -->
	<model:dataset id="resideSourceSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RESIDE_SOURCE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 住所来源 -->
	<model:dataset id="sorgNameSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_ORGAN'></model:param>
			<model:param name="value" value='SORG_ID'></model:param>
			<model:param name="text" value='CN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 所属行事业 -->
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 业务主管单位 -->
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="民办非企业成立登记"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<%
			if("daiban".equals(request.getParameter("method"))){
		%>		
		<next:ToolBarItem iconCls="select" text="提交" handler="send"></next:ToolBarItem>
		<%		
			}
		%>			
		<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab">
		<next:Tabs>
			<next:Panel title="登记申请表" width="100%">
				<next:Panel width="100%" height="100%" id="tab1" autoScroll="true">
					<next:Html>
						<fieldset>
						<form method="post" onsubmit="return false" class="L5form" dataset="somOrganDataSet">											
							<table width="100%">
								<tr>
									<td class="FieldLabel"style="width:17%">民办非企业中文名称：</td>
									<td class="FieldInput" style="width:51%"colspan="3"><label  field="cnName" style="width:96%"/></td>
									<td class="FieldLabel" style="width:17%">电话：</td>
									<td class="FieldInput" style="width:17%"><label  field="sorgPhone" style="width:90%"/></td>
								</tr>
								<tr>	
									<td class="FieldLabel" style="width:17%">住所来源：</td>
									<td class="FieldInput" style="width:17%"><label  field="resideSource" dataset="resideSourceSelect"/></td>
									<td class="FieldLabel" style="width:17%">住所：</td>
									<td class="FieldInput" colspan="3"><label  field="residence"/></td>
								</tr>	
								<tr>
									<td class="FieldLabel" style="width:17%">邮编：</td>
									<td class="FieldInput" style="width:17%"><label  field="sorgPost" style="width:90%"/></td>
									<td class="FieldLabel" style="width:17%">民办非企业类型：</td>
									<td class="FieldInput"><label  field="sorgKind" dataset="sorgKindSelect"/></td>
									<td class="FieldLabel" style="width:17%">所属行（事）业：</td>
									<td class="FieldInput"><label  field="busScope" dataset="busScopeSelect"/></td>						
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">从业人员数：</td>
									<td class="FieldInput"><label  field="engagedNum" style="width:90%"/></td>
									<td class="FieldLabel" style="width:17%">其中执业人员数：</td>
									<td class="FieldInput"><label  field="practiceNum" style="width:90%"/></td>
									<td class="FieldLabel"></td>
									<td class="FieldInput"></td>		
								</tr>
								<tr>	
									<td class="FieldLabel">宗旨：</td>
									<td class="FieldInput" colspan="5"><textarea rows="5" name='民办非企业宗旨' field="purpose" style="width:98%"style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly="readonly"></textarea></td>
								</tr>
								<tr>	
									<td class="FieldLabel">业务范围：</td>
									<td class="FieldInput" colspan="5"><textarea rows="5" name='业务范围' field="business" style="width:98%" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;"readonly="readonly"></textarea></td>
								</tr>
								<tr>	
									<td class="FieldLabel">基本设备、设施：</td>
									<td class="FieldInput" colspan="5"><textarea rows="5" name='基本设备、设施' field="facilities" style="width:98%" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;"readonly="readonly"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel">开办资金数额：</td>
									<td class="FieldInput"><label  field="regMon"/>万元</td>
									<td class="FieldLabel">验资单位：</td>
									<td class="FieldInput" colspan="3"><label  field="checkCapitalOrgan"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">开办资金来源：</td>
									<td class="FieldInput" colspan="5"><label  field="moneySource"/></td>
								</tr>
								<tr>	
									<td class="FieldLabel">住所产权单位：</td>
									<td class="FieldInput" colspan="3"><label  field="housingOrgan"/></td>
									<td class="FieldLabel">用房面积：</td>
									<td class="FieldInput"><label  field="housingArea"/>平方米</td>
								</tr>
								<tr id="leasePeriod" style="display:none">
									<td class="FieldLabel">租（借）期限：</td>
									<td class="FieldInput" colspan="5"><label  field="leasePeriod"/></td>
								</tr>
								<tr>	
									<td class="FieldLabel">民办非企业通信地址：</td>
									<td class="FieldInput"><label  field="sorgAdds"/></td>
									<td class="FieldLabel">民办非企业电子邮箱：</td>
									<td class="FieldInput"><label  field="sorgEmail"/></td>
									<td class="FieldLabel" style="width:15%">民办非企业传真：</td>
									<td class="FieldInput" style="width:17%"><label  field="sorgFax"/></td>
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
						<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form">
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:17%">承办人意见：</td>
									<td class="FieldInput" style="width:17%">
										<label field="acceptOpinionId" name='"承办人意见"' style="width:90%" dataset="hisOpinionDataSet" default="0" />
									</td>
									<td class="FieldLabel" style="width:17%">承办人：</td>
									<td class="FieldInput" style="width:17%"><label type="text" field="acceptPeopleName" name='承办人'  style="width:90%" />
									</td>
									<td class="FieldLabel" style="width:17%">承办时间：</td>
									<td class="FieldInput" style="width:17%"><label type="text" name='承办时间' field="acceptTime" style="width:90%" />
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">承办补充意见：</td>
									<td class="FieldInput" colspan="5"><textarea rows="3" name='承办补充意见' field="acceptOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">现场勘查意见：</td>
									<td class="FieldInput" style="width:17%">
										<label type="text"  field="prospectOpinionId" name='"现场勘查意见"' style="width:90%" dataset="hisOpinionDataSet"  />
									</td>
									<td class="FieldLabel" style="width:17%">现场勘查承办人：</td>
									<td class="FieldInput" style="width:17%"><label type="text" field="prospectPeopleName" name='现场勘查承办人'  style="width:90%" /></td>
									<td class="FieldLabel" style="width:17%">现场勘查日期：</td>
									<td class="FieldInput" style="width:17%"><label type="text" name='现场勘查日期' field="prospectDate" style="width:90%" /></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">现场勘查双方参加人员：</td>
									<td class="FieldInput" colspan="5">
										<label type="text"  field="prospectAttendPeople" name='"现场勘查双方参加人员"' style="width:90%"/>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">现场勘查地点：</td>
									<td class="FieldInput" colspan="5"><label type="text" field="prospectPlace" name='现场勘查地点'  style="width:90%" /></td>
								</tr>
								<tr>
									<td class="FieldLabel">现场勘查补充意见：</td>
									<td class="FieldInput" colspan="5"><textarea rows="3" name='现场勘查补充意见' field="prospectOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">初审意见：</td>
									<td class="FieldInput" style="width:17%">
										<label field="examinOpinionId" name='"初审意见"' style="width:90%" dataset="hisOpinionDataSet" />
									</td>
									<td class="FieldLabel" style="width:17%">初审负责人：</td>
									<td class="FieldInput" style="width:17%"><label type="text" field="examinPeopleName" name='初审负责人'  style="width:90%" />
									</td>
									<td class="FieldLabel" style="width:17%">初审时间：</td>
									<td class="FieldInput" style="width:17%"><label type="text" name='初审时间' field="examinTime" style="width:90%" />
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">初审补充意见：</td>
									<td class="FieldInput" colspan="5"><textarea rows="3" name='初审补充意见' field="examinOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">审核意见：</td>
									<td class="FieldInput" style="width:17%">
										<label field="checkOpinionId" name='"审核意见"' style="width:90%" dataset="hisOpinionDataSet" />
									</td>
									<td class="FieldLabel" style="width:17%">审核人：</td>
									<td class="FieldInput" style="width:17%"><label type="text" field="checkPeopleName" name='审核人' style="width:90%" />
									</td>
									<td class="FieldLabel" style="width:17%">审核时间：</td>
									<td class="FieldInput" style="width:17%"><label type="text" name='审核时间' field="checkTime" style="width:90%" />
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">审核补充意见：</td>
									<td class="FieldInput" colspan="5"><textarea rows="3" name='审核补充意见' field="checkOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">批准意见：</td>
									<td class="FieldInput" style="width:17%">
										<label field="auditOpinionId" name='"批准意见"' style="width:90%" dataset="hisOpinionDataSet" />
									</td>
									<td class="FieldLabel" style="width:17%">批准人：</td>
									<td class="FieldInput" style="width:17%"><label type="text" field="auditPeopleName" name='批准人' style="width:90%" />
									</td>
									<td class="FieldLabel" style="width:17%">批准时间：</td>
									<td class="FieldInput" style="width:17%"><label type="text" name='批准时间' field="auditTime" style="width:90%" />
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">批准补充意见：</td>
									<td class="FieldInput" colspan="5"><textarea rows="3" name='批准补充意见' field="auditOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
									</td>
								</tr>
							</table>
						</form>
						</fieldset>
					</next:Html>
				</next:Panel>
			</next:Panel>
			<next:Panel title="流程历史意见">
				<next:EditGridPanel id="somFlowGrid" dataset="somFlowDataSet" width="100%" stripeRows="true" height="100%">
					<next:Columns>
						<next:RowNumberColumn />
						<next:Column header="处理环节" field="activity" width="13%" editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="处理单位" field="organId" width="13%" editable="false">
							<next:ComboBox dataset="pubOrganDataSet" />
						</next:Column>
						<next:Column header="处理部门" field="deptId" width="13%" editable="false">
							<next:ComboBox dataset="pubOrganDataSet" />
						</next:Column>
						<next:Column header="处理人" field="actorId" width="10%"	editable="false">
							<next:ComboBox dataset="pubOrganDataSet" />
						</next:Column>
						<next:Column header="处理时间" field="commitTime" width="18%" editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="意见" field="opinionId" width="10%"	editable="false">
							<next:ComboBox dataset="hisOpinionDataSet" />
						</next:Column>
						<next:Column header="补充意见" field="opinion" width="40%" editable="false">
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
						<fieldset style="width: 100%">
					<form method="post" onsubmit="return false" class="L5form" dataset="somApplyDataSet">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width: 13%"><label>处理意见：</label></td>
								<td class="FieldInput" colspan="5">
									<select id="curOpinionId" field="curOpinionId" name='"处理意见"' style="width: 150px" default="0">
										<option dataset="opinionSelect"></option>
									</select><span style="color: red">*</span>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>处理补充意见：</label></td>
								<td class="FieldInput" colspan="5"><textarea rows="10"
									name='"处理补充意见"' field="curOpinion" style="width: 98%"></textarea>
								</td>
							</tr>
						</table>
						</fieldset>
					</form>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>

</body>
</html>