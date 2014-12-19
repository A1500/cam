<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.comm.util.*,org.loushang.next.skin.SkinUtils,com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<html>
<head>
<title>基金会异地设立分支/代表机构的审查受理页面</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somFundbranchAPCheckInsert.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript">
var taskCode = '<%=StrUtil.n2b(SomIdHelp.getFundTaskCode())%>';//生成业务编号
var applyType = "210";
var sorgId =  '<%=StrUtil.n2b(SomIdHelp.getFundSorgId())%>';
var rootPath="<%=SkinUtils.getRootUrl(request)%>";
var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
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
			<model:field name="legalPeople" type="string" rule="require|length{60}" />
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
			<model:field name="curOpinionId" type="string" rule="require"/>
		    <model:field name="curOpinion" type="string" rule="length{200}"/>
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
		<next:ToolBarItem symbol="基金会异地设立分支/代表机构的审查受理"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="print" text="打印受理通知书" handler="printAccept"></next:ToolBarItem>
		<next:ToolBarItem iconCls="print" text="打印不予受理通知书" handler="printNoAccept"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveAll"></next:ToolBarItem>
		<next:ToolBarItem iconCls="select" text="提交" handler="saveAndSend"></next:ToolBarItem>
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
								<td class="FieldInput" colspan="5"><input type="text"  id="mainSorgCode"field='mainSorgCode' name='"主体登记证号"' onkeyup="value=value.replace(/[^\-\\w\.\/]/ig,'').toUpperCase()"  onblur="validateSorgCode()" style="width:98%"/><label style="color:red">*</label></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>基金会名称：</label></td>
								<td class="FieldInput" colspan="5"><label id="name" field="mainSorgName" ></label></td>
							</tr>
							<tr>	
								<td class="FieldLabel" style="width:17%">登记日期：</td>
								<td class="FieldInput" style="width:17%"><label id="regDate" ></label></td>
								<td class="FieldLabel" style="width:17%">法定代表人：</td>
								<td class="FieldInput" style="width:17%"><label id="legalPeople" field="legalPeople" ></label></td>
								<td class="FieldLabel"></td>
								<td class="FieldInput"></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>基金会住所：</label></td>
								<td class="FieldInput" colspan="5"><label id="residence"></label></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>拟设立的分支/代表机构名称：</label></td>
								<td class="FieldInput" colspan="5"><input type="text" id="cnName" name='"机构名称"' field="cnName" onblur="fillOrganInfo(this.value)" style="width:98%"/><label style="color:red">*</label></td>
							</tr>
							<tr>
								<td class="FieldLabel">拟设立的分支/代表机构业务主管单位：</td>
								<td class="FieldInput"   colspan="3">
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
									</select><label style="color:red">*</label>
								</td>
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
			<next:Panel title="处理意见" width="100%" >
					<next:Html>
						<fieldset style="width:100%">
					<form method="post" onsubmit="return false" class="L5form" dataset="somApplyDataSet">
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:13%"><label>处理意见：</label></td>
									<td class="FieldInput" colspan="5">
									<select field="curOpinionId" name='"处理意见"' style="width:150px" default="0">
										<option dataset="opinionSelect"></option>
									</select><span style="color:red">*</span>
									</td>
									
								</tr>
								<tr>
									<td class="FieldLabel"><label>处理补充意见：</label></td>
									<td class="FieldInput" colspan="5">
										<textarea rows="10" name='"处理补充意见"' field="curOpinion" style="width:98%"></textarea>
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