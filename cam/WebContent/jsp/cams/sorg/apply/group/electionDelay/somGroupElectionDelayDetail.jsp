<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.StrUtil"%>
<%@page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@page import="com.inspur.cams.sorg.apply.group.cmd.GroupChangeCmd"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<title>社会团体延期换届选举报批</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somGroupElectionDelayDetail.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgOnline.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<%
	String assignmentId=(String)request.getParameter("assignmentId");
	String taskCode = request.getParameter("taskCode");
	String method=request.getParameter("method");
	String processId=(String)request.getParameter("processId");
	if(processId==null || "".equals(processId)){
		processId = new GroupChangeCmd().getProcessId(assignmentId);
		method="end";
	}
%>
<script type="text/javascript">
	var processId='<%=processId%>';
	var actDefUniqueId='<%=request.getParameter("actDefUniqueId")%>';
	var assignmentId='<%=request.getParameter("assignmentId")%>';
	var method='<%=method%>';
	var sorgId='<%=request.getParameter("sorgId")%>';
	var applyType="032";
	var taskCode = '<%=taskCode%>';//生成业务编号	
	var act ='<%=request.getParameter("act")%>';			
</script>
</head>
<body>
<model:datasets>
	<!-- 更改业务状态所用dataset -->
	<model:dataset id="updateStatusDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineQueryCommand"  global="true" >
		<model:record fromBean="com.inspur.cams.sorg.online.base.data.SomApplyOnline"></model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<model:dataset id="somElectionDataSet" cmd="com.inspur.cams.sorg.history.election.cmd.SomElectionQueryCmd" method="queryElection" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElection"/>
	</model:dataset>
	<!-- 业务 -->
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<model:field name="curOpinionId" type="string" rule="require" />
			<model:field name="curOpinion" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>	
	<%--定义字典表--%>
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>		
	<model:dataset id="sorgDutiesDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
			<model:param name="filterSql" value="CODE IN (00004,00007,00008,00009)"></model:param>
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
	<!-- 政治面貌 -->
	<model:dataset id="politicsSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>	
	<%--历史意见表--%>
	<model:dataset id="somFlowDataset"
		cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd"
		sortField="COMMIT_TIME" pageSize="20" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<model:dataset id="pubOrganDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="PUB_ORGAN"></model:param>
			<model:param name="value" value="ORGAN_ID"></model:param>
			<model:param name="text" value="ORGAN_NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>	
	<model:dataset id="hisOpinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>

</model:datasets>
<next:Panel width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<%
			if ("daiban".equals(request.getParameter("method"))) {
		%>
			<next:ToolBarItem iconCls="select" text="提交" handler="submit"/>
		<%
			}
		%>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel id="tab" width="100%" height="100%" activeTab="3">	
		<next:Tabs>
			<next:Panel title="社会团体延期换届选举报批" width="100%" height="100%" autoScroll="true">	
					<next:Html>
						<form id="ElectionForm" method="post" dataset="somElectionDataSet" onsubmit="return false" class="L5form">
							<input type="hidden" id="sorgId" field="sorgId" value="社会团体ID">
							<fieldset>
							<legend>社会团体延期换届选举报批表</legend>
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:16%">登记证号：</td>
									<td class="FieldInput" style="width:30%"><label id="sorgCode"></label></td>
									<td class="FieldLabel" style="width:18%">社团名称：</td>
									<td class="FieldInput" style="width:36%"><label id="cnName"></label></td>
								</tr>
								<tr>
									<td class="FieldLabel">联系人：</td>
									<td class="FieldInput"><label  field="linkPeople"></label></td>
									<td class="FieldLabel">联系电话：</td>
									<td class="FieldInput"><label  field="linkPhone"></label></td>
								</tr>
								<tr>
									<td class="FieldLabel">上次换届时间：</td>
									<td class="FieldInput"><label  field="lastDate"></label></td>
									<td class="FieldLabel">应到届时间：</td>
									<td class="FieldInput"><label  field="nextDate"></label></td>
								</tr>
								<tr>
									<td class="FieldLabel">延期换届时间：</td>
									<td class="FieldInput"><label  field="delayDate"></label></td>
									<td class="FieldLabel"></td>
									<td class="FieldInput"></td>
								</tr>
								<tr>
									<td class="FieldLabel">延期换届事由：</td>
									<td class="FieldInput" colspan="3">
										<textarea field="delayReason" cols="65" rows="5" readonly="readonly" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;"></textarea>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">社团内部履行程序情况：</td>
									<td class="FieldInput" colspan="5"><textarea field="process" cols="65" rows="2" readonly="readonly" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;"></textarea></td>
								</tr>
							</table>
							</fieldset>
						</form>
						<form id="form2" method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form">
							<fieldset>
							<legend>审查意见</legend>
							<table width="100%">
								<tr>
									<td class="FieldLabel">业务主管单位审查意见：</td>
									<td class="FieldInput" colspan="3"><textarea field="borgOpinion" cols="65" rows="2" style="width:97%"style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly="readonly"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">业务主管单位：</td>
									<td class="FieldInput" style="width:51%"><label  field="borgName" dataset="businessOrganSelect"></label></td>
									<td class="FieldLabel" style="width:17%">业务主管单位审查日期：</td>
									<td class="FieldInput" style="width:17%"><label  field="borgCheckDate"></label></td>
								</tr>
							</table>
							</fieldset>
						<fieldset>
								<legend>历史处理意见</legend>
								<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
								<table width="100%">
									<tr>
										<td class="FieldLabel" style="width:17%">承办人意见：</td>
										<td class="FieldInput" style="width:17%">
											<label field="acceptOpinionId" name='"承办人意见"' style="width:90%" dataset="hisOpinionSelect" default="0" />
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
										<td class="FieldLabel" style="width:17%">初审意见：</td>
										<td class="FieldInput" style="width:17%">
											<label field="examinOpinionId" style="width:90%" dataset="hisOpinionSelect" default="0" />
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
										<td class="FieldInput" colspan="5"><textarea rows="3" field="examinOpinion" style="width:98%"style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly="readonly" ></textarea>
										</td>
									</tr>
									<tr>
										<td class="FieldLabel" style="width:17%">审核意见：</td>
										<td class="FieldInput" style="width:17%">
											<label field="checkOpinionId" name='"审核意见"' style="width:90%" dataset="hisOpinionSelect" default="0" />
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
										<td class="FieldInput" colspan="5"><textarea rows="3" name='审核补充意见' field="checkOpinion" style="width:98%"style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly="readonly"></textarea>
										</td>
									</tr>
									<tr>
										<td class="FieldLabel" style="width:17%">批准意见：</td>
										<td class="FieldInput" style="width:17%">
											<label field="auditOpinionId" name='"批准意见"' style="width:90%" dataset="hisOpinionSelect" default="0" />
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
										<td class="FieldInput" colspan="5"><textarea rows="3" name='批准补充意见' field="auditOpinion" style="width:98%"style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly="readonly"></textarea>
										</td>
									</tr>
								</table>
						</form>
							</fieldset>
					</next:Html>
				</next:Panel>
			<next:EditGridPanel id="uploadGrid" title="法律要件" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
				<next:TopBar>
					<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn />
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="档案目录名"  field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect" ><next:TextField /></next:Column>
					<next:Column header="附件名称"    field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
					<next:Column header="附件描述"    field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
					<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somElectronicDataSet" />
				</next:BottomBar>
			</next:EditGridPanel>	
			<next:Panel title="流程历史意见" id="historyPanel" >
				<next:EditGridPanel id="lishi" dataset="somFlowDataset" height="100%"  width="100%" autoScroll="true" stripeRows="true">
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="处理环节" field="activity" width="13%"
							editable="false">
							<next:TextField />
						</next:Column>						
						<next:Column header="处理单位" field="organId" dataset="pubOrganDataSet" width="13%" editable="false"></next:Column>
						<next:Column header="处理部门" field="deptId" dataset="pubOrganDataSet" width="13%" editable="false"></next:Column>
						<next:Column header="处理人" field="actorId" dataset="pubOrganDataSet" width="10%" editable="false"></next:Column>
						<next:Column header="处理时间" field="commitTime" 
							 width="18%" editable="false">
							<next:TextField/>
						</next:Column>
						<next:Column header="处理意见" field="opinionId" width="10%"
							editable="false" dataset="hisOpinionSelect">
							<next:TextField />
						</next:Column>
						<next:Column header="处理补充意见" field="opinion" width="40%"
							editable="false">
							<next:TextField />
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="处理意见" id="ipinionPanel" width="100%" height="100%" autoScroll="true" style="display:block;">
			<next:Html>
			<form method="post" onsubmit="return false" class="L5form" dataset="somApplyDataSet">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:13%"><label>处理意见：</label></td>
					<td class="FieldInput" colspan="5">
					<select id="curOpinionId" field="curOpinionId" name='处理意见' style="width:150px">
						<option dataset="opinionSelect"></option>
					</select><span style="color:red">*</span>
					</td>
					
				</tr>
				<tr>
					<td class="FieldLabel"><label>处理补充意见：</label></td>
					<td class="FieldInput" colspan="5">
						<textarea rows="10" name='处理补充意见' field="curOpinion" style="width:98%"></textarea>
					</td>
				</tr>
			</table>
			</form>
			</next:Html>
			</next:Panel>		
		</next:Tabs>
	</next:TabPanel>
</next:Panel>	
<jsp:include page="../../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>