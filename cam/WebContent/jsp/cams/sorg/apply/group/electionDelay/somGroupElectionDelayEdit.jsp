<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.StrUtil"%>
<%@page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<title>社会团体延期换届选举报批</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somGroupElectionDelayEdit.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgComm.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<%
	String taskCode = request.getParameter("taskCode");
	String method=request.getParameter("method");
	if("INSERT".equals(method)){
		taskCode = StrUtil.n2b(SomIdHelp.getGroupTaskCode());
	}
%>
<script type="text/javascript">
	var processId='<%=request.getParameter("processId")%>';
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
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<model:dataset id="somElectionDataSet" cmd="com.inspur.cams.sorg.history.election.cmd.SomElectionQueryCmd" method="queryElection" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElection">
			<model:field name="linkPeople" type="string" rule="length{72}" />
			<model:field name="linkPhone" type="string" rule="length{30}" />
			<model:field name="lastDate" type="string" rule="length{10}" />
			<model:field name="nextDate" type="string" rule="length{10}" />
			<model:field name="delayDate" type="string" rule="length{10}" />
			<model:field name="delayReason" type="string" rule="length{500}" />
			<model:field name="process" type="string" rule="length{500}" />
		</model:record>
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
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic">
			<model:field name="linkPeople" type="string" rule="length{72}" />
			<model:field name="linkPhone" type="string" rule="length{30}" />
			<model:field name="lastDate" type="string" rule="length{10}" />
			<model:field name="nextDate" type="string" rule="length{10}" />
			<model:field name="delayDate" type="string" rule="length{10}" />
			<model:field name="delayReason" type="string" rule="length{500}" />
			<model:field name="process" type="string" rule="length{500}" />
		</model:record>
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
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>	
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>

</model:datasets>
<next:Panel width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<%
			if( !"supply".equals(request.getParameter("act")) ){	%>	
				<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
			<%
				
			}
		%>	
		<next:ToolBarItem iconCls="select" text="提交" handler="submit"/>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel id="tab" width="100%" height="100%" activeTab="2">	
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
									<td class="FieldInput" style="width:30%"><input type="text" name="登记证号" id="sorgCode" maxlength="32" style="width:90%" onkeyup="value=value.replace(/[^\-\\w\.\/]/ig,'').toUpperCase()" onblur="fillSorgInfo();"><font color="red">*</font></td>
									<td class="FieldLabel" style="width:18%">社团名称：</td>
									<td class="FieldInput" style="width:36%"><label id="cnName"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">联系人：</td>
									<td class="FieldInput"><input type="text" name="联系人" field="linkPeople" maxlength="36" style="width:90%"></td>
									<td class="FieldLabel">联系电话：</td>
									<td class="FieldInput"><input type="text" name="联系电话" field="linkPhone" maxlength="30" style="width:90%"></td>
								</tr>
								<tr>
									<td class="FieldLabel">上次换届时间：</td>
									<td class="FieldInput"><input type="text" id="lastDate" name='上次换届时间' field="lastDate" onfocus="WdatePicker()" style="width:90%"/></td>
									<td class="FieldLabel">应到届时间：</td>
									<td class="FieldInput"><input type="text" id="nextDate" name='应到届时间' field="nextDate" onfocus="WdatePicker()" style="width:90%"/>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">延期换届时间：</td>
									<td class="FieldInput" colspan="3"><input type="text" id="delayDate" name='延期换届时间' field="delayDate" onfocus="WdatePicker()" style="width:90%"/><font color="red">*</font></td>
									<td class="FieldLabel"></td>
									<td class="FieldInput"></td>
								</tr>
								<tr>
									<td class="FieldLabel">延期换届事由：</td>
									<td class="FieldInput" colspan="3">
										<textarea field="delayReason" cols="65" rows="5" style="width:97%"></textarea>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">社团内部履行程序情况：</td>
									<td class="FieldInput" colspan="5"><textarea field="process" cols="65" rows="2" style="width:97%"></textarea></td>
								</tr>
								</table>
							</fieldset>
						</form>
						<fieldset>
						<legend>审查意见</legend>
						<form id="form2" method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form">
							<table width="100%">
								<tr>
									<td class="FieldLabel">业务主管单位：</td>
									<td class="FieldInput">
									<input type="text" id="borgNameDispaly" name="borgNameDispaly"  title="业务主管单位"  onkeyup="findDiv(this,'borgName','popup','','businessOrganAuto','BORG_NAME@like','borgCode','borgName','35')" onblur="clearDiv()" onchange="clearBorg(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showBorgWin()"/>
									<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >  
 	        							<ul></ul> 
     								</div>
     								<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
									<span style="color:red">*</span></td>
								
									<td class="FieldLabel" style="width:17%">业务主管单位审查日期：</td>
									<td class="FieldInput" style="width:17%"><input type="text" id="borgCheckDate" name='业务主管单位审查日期' field="borgCheckDate" onfocus="WdatePicker()" style="width:90%"/>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">业务主管单位审查意见：</td>
									<td class="FieldInput" colspan="3"><textarea field="borgOpinion" cols="65" rows="2" style="width:97%"></textarea></td>
								</tr>
							</table>
						</form>
						</fieldset>
					<%
						if( "supply".equals(request.getParameter("act")) ){	
					%>
					<fieldset>
					<legend>历史处理意见</legend>
					<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
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
							<td class="FieldLabel" style="width:17%">初审意见：</td>
							<td class="FieldInput" style="width:17%">
								<label type="text"  field="examinOpinionId" name='"初审意见"' style="width:90%" dataset="hisOpinionDataSet"  />
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
								<label type="text"  field="checkOpinionId" name='"审核意见"' style="width:90%" dataset="hisOpinionDataSet" />
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
								<label type="text"  field="auditOpinionId" name='"批准意见"' style="width:90%" dataset="hisOpinionDataSet"  />
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
					<%
						}
					%>
						</form>
					</next:Html>
				</next:Panel>
			<next:EditGridPanel id="uploadGrid" title="法律要件" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
				<next:TopBar>
					<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add" text="增加上传附件" handler="clickUploadFile"></next:ToolBarItem>
				</next:TopBar>		
				<next:Columns>
					<next:RowNumberColumn />
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="档案目录名"  field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect"><next:TextField /></next:Column>
					<next:Column header="附件名称"    field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
					<next:Column header="附件描述"    field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
					<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somElectronicDataSet" />
				</next:BottomBar>
			</next:EditGridPanel>	
			<next:Panel title="处理意见" id="ipinionPanel" width="100%" height="100%" autoScroll="true" style="display:block;">
			<next:Html>
			<form method="post" onsubmit="return false" class="L5form" dataset="somApplyDataSet">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:13%"><label>处理意见：</label></td>
					<td class="FieldInput" colspan="5">
					<select field="curOpinionId" name='处理意见' style="width:150px">
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
<jsp:include page="../../../comm/borg/borgSelectWindow.jsp" flush="true"/> 
</body>
</html>