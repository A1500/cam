<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils,com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.sorg.util.ApplyType"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>基金会异地设立分支/代表机构的审查受理页面</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fundbranchHistoryAPCheck.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">
var taskCode = '<%=StrUtil.n2b(SomIdHelp.getFundTaskCode())%>';//生成业务编号
var applyType='<%=ApplyType.SOM_FUND_BRANCH_ANOTHER_PLACE_CHECK%>';
var rootPath="<%=SkinUtils.getRootUrl(request)%>";
var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
var method='<%=request.getParameter("method")%>';
	<%
		String sorgId=request.getParameter("sorgId");
		if(sorgId==null){
			sorgId="";
		}
		String taskCode=request.getParameter("taskCode");
		if(taskCode==null){
			taskCode="";
		}
	%>
	var sorgId='<%=sorgId%>';
	if(sorgId == ''){
		sorgId = '<%=StrUtil.n2b(SomIdHelp.getFundSorgId())%>';
	}
	var taskCode='<%=taskCode%>';
	if(taskCode == ''){
		taskCode = '<%=StrUtil.n2b(SomIdHelp.getFundTaskCode())%>';//生成业务编号
	}
</script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<model:dataset id="somMainOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryMain">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<%--社团基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryBranch">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<%--基金会基本信息验证 --%>
			<model:field name="mainSorgCode" type="string" rule="require|length{20}" />			
			<model:field name="mainSorgName" type="string" rule="require|length{100}" />
			<model:field name="cnName" type="string" rule="require|length{100}" />
			<model:field name="residence" type="string" rule="require|length{100}" />
			<model:field name="legalPeople" type="string" rule="require|length{60}" />
			<model:field name="regDate" type="string" rule="require" />
			<model:field name="borgName" type="string" rule="length{100}" />
			<model:field name="branchCharger" type="string" rule="require|length{100}" />
			<model:field name="sorgPhone" type="string" rule="length{30}" />
			<model:field name="sorgPost" type="string" rule="length{6}" />
			<model:field name="sorgKind" type="string" rule="require" />
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
	<%--业务意见--%>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<%--业务意见信息验证--%>
			<model:field name="appPeople" type="string" rule="length{72}" />
			<model:field name="appPhone" type="string" rule="length{30}" />
			<model:field name="acceptPeopleName" type="string" rule="length{100}" />
			<model:field name="acceptOpinion" type="string" rule="length{500}" />
			<model:field name="examinPeopleName" type="string" rule="length{30}" />
			<model:field name="examinOpinion" type="string" rule="length{30}" />
			<model:field name="checkPeopleName" type="string" rule="length{30}" />
			<model:field name="checkOpinion" type="string" rule="length{30}" />
			<model:field name="auditPeopleName" type="string" rule="length{30}" />
			<model:field name="auditOpinion" type="string" rule="length{30}" />
		</model:record>
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
	<!-- 社会组织种类 -->
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_FUND_BRANCH_KIND'></model:param>
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
	<!-- 业务主管单位 -->
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
</model:datasets>	
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="基金会异地设立分支/代表机构的审查"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveAll"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab">
		<next:Tabs>
			<next:Panel title="设立申请书" width="100%" >
				<next:Panel width="100%" height="100%" autoScroll="true">
					<next:Html>
						<form method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel"><label>基金会登记证号：</label></td>
								<td class="FieldInput" colspan="5"><input type="text"  id="mainSorgCode" field='mainSorgCode'name='"主体登记证号"' onkeyup="value=value.replace(/[^\-\\w\.\/]/ig,'').toUpperCase()" onblur="validateSorgCode()" style="width:98%"/><label style="color:red">*</label></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>基金会名称：</label></td>
								<td class="FieldInput" colspan="5"><input id="name" field="mainSorgName" name='"基金会名称"'style="width:98%"/><label style="color:red">*</label></td>
							</tr>
							<tr>	
								<td class="FieldLabel" style="width:17%">登记日期：</td>
								<td class="FieldInput" style="width:17%"><input type="text" name='登记日期' field="regDate" onClick="WdatePicker()" style="width:90%"/><span style="color:red">*</span></td>
								<td class="FieldLabel" style="width:17%">法定代表人：</td>
								<td class="FieldInput" style="width:17%"><input id="legalPeople" field="legalPeople"name='"法定代表人"' style="width:90%"/><label style="color:red">*</label></td>
								<td class="FieldLabel"></td>
								<td class="FieldInput"></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>基金会住所：</label></td>
								<td class="FieldInput" colspan="5"><input type="text" name='"基金会住所"' field="residence" style="width:98%"/><label style="color:red">*</label></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>拟设立的分支/代表机构名称：</label></td>
								<td class="FieldInput" colspan="5"><input type="text" id="cnName" name='"机构名称"' field="cnName" onblur="cnNameUK()" style="width:98%"/><label style="color:red">*</label></td>
							</tr>
							<tr>
								<td class="FieldLabel">拟设立的分支/代表机构业务主管单位：</td>
								<td class="FieldInput" colspan="3">
								<input type="text" id="borgNameDispaly" name="borgNameDispaly"  title="拟设立的分支/代表机构业务主管单位"  onkeyup="findDiv(this,'borgName','popup','','businessOrganAuto','BORG_NAME@like','borgCode','borgName','35')" onblur="clearDiv()" onchange="clearBorg(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showBorgWin()"/>
								<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >  
        							<ul></ul> 
   								</div>
   								<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
								<span style="color:red">*</span></td>
								
								<td class="FieldLabel" style="width:17%">拟设立的分支/代表机构负责人：</td>
								<td class="FieldInput" style="width:17%"><input type="text" name='拟设立的分支/代表机构负责人' field="branchCharger" style="width:90%"/><label style="color:red">*</label></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:15%"><label>拟设立的分支/代表机构电话：</label></td>
								<td class="FieldInput" style="width:17%"><input type="text" id="sorgPhone" name='"机构电话"' field="sorgPhone" style="width:90%"/><label style="color:red">*</label></td>
								<td class="FieldLabel" style="width:15%"><label>拟设立的分支/代表机构邮编：</label></td>
								<td class="FieldInput" style="width:17%"><input type="text" id="sorgPost" name='"机构邮编"' field="sorgPost" style="width:90%"/><label style="color:red">*</label></td>
								<td class="FieldLabel" style="width:15%"><label>拟设立的分支/代表机构类型：</label></td>
								<td class="FieldInput" style="width:17%">
									<select name='"机构类型"' field="sorgKind" style="width:90%">
										<option dataset="sorgKindSelect"></option>
									</select><label style="color:red">*</label></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>拟设立的分支/代表机构业务范围：</label></td>
								<td class="FieldInput" colspan="5"><textarea rows="10" name='"业务范围"' field="business" style="width:98%"/></textarea><label style="color:red">*</label></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>设立理由：</label></td>
								<td class="FieldInput" colspan="5"><textarea rows="5" name='"设立理由"' field="appReason" style="width:98%"></textarea><label style="color:red">*</label></td>
							</tr>
							<div id="mainSorgId" title="隐藏：主体ID" style="display:none"></div>
						</table>
						</form>
					</next:Html>
				</next:Panel>
			</next:Panel>
			<next:Panel title="法律要件" >
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
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
			</next:Panel>
			<next:Panel title="处理意见" width="100%">
				<next:Html>
					<fieldset>
					<form method="post" dataset="somApplyDataSet"
						onsubmit="return false" class="L5form">
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width: 15%">承办人意见：</td>
							<td class="FieldInput" style="width: 15%"><select
								field="acceptOpinionId" name='"承办人意见"'>
								<option dataset="opinionSelect" />
							</select></td>
							<td class="FieldLabel" style="width: 15%">承办人：</td>
							<td class="FieldInput" style="width: 15%"><input type="text"
								field="acceptPeopleName" name='承办人' style="width: 90%" /></td>
							<td class="FieldLabel" style="width: 15%">承办时间：</td>
							<td class="FieldInput" style="width: 25%"><input type="text"
								name='承办时间' field="acceptTime"onClick="WdatePicker()" /></td>
						</tr>
						<tr>
							<td class="FieldLabel">承办补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3"
								name='承办补充意见' field="acceptOpinion" style="width: 90%"></textarea>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">初审意见：</td>
							<td class="FieldInput"><select field="examinOpinionId"
								name='"初审意见"'>
								<option dataset="opinionSelect" />
							</select></td>
							<td class="FieldLabel">初审负责人：</td>
							<td class="FieldInput"><input type="text"
								field="examinPeopleName" name='初审负责人' style="width: 90%" /></td>
							<td class="FieldLabel">初审时间：</td>
							<td class="FieldInput"><input type="text" name='初审时间'
								field="examinTime" onClick="WdatePicker()"  />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">初审补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3"
								name='初审补充意见' field="examinOpinion" style="width: 90%"></textarea>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">审核意见：</td>
							<td class="FieldInput"><select field="checkOpinionId"
								name='"审核意见"'>
								<option dataset="opinionSelect" />
							</select></td>
							<td class="FieldLabel">审核人：</td>
							<td class="FieldInput"><input type="text"
								field="checkPeopleName" name='审核人' style="width: 90%" /></td>
							<td class="FieldLabel">审核时间：</td>
							<td class="FieldInput"><input type="text" name='审核时间'
								field="checkTime"onClick="WdatePicker()"  />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">审核补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3"
								name='审核补充意见' field="checkOpinion" style="width: 90%"></textarea>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">批准意见：</td>
							<td class="FieldInput"><select field="auditOpinionId"
								name='"批准意见"'>
								<option dataset="opinionSelect" />
							</select></td>
							<td class="FieldLabel">批准人：</td>
							<td class="FieldInput"><input type="text"
								field="auditPeopleName" name='批准人' style="width: 90%" /></td>
							<td class="FieldLabel">批准时间：</td>
							<td class="FieldInput"><input type="text" name='批准时间'
								field="auditTime"onClick="WdatePicker()" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">批准补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3"
								name='批准补充意见' field="auditOpinion" style="width: 90%"></textarea>
							</td>
						</tr>
					</table>
					</form>
					</fieldset>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<jsp:include page="../../../comm/upload/uploadWindow.jsp" flush="true"/>
<jsp:include page="../../../comm/borg/borgSelectWindow.jsp" flush="true"/> 
</body>
</html>