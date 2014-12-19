<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils,com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>社会团体异地设立分支/代表机构的审查受理页面</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somGroupbranchAPCheckInsert.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgOnline.js")%>'></script>
<script type="text/javascript">
var taskCode = '<%=StrUtil.n2b(SomIdHelp.getGroupTaskCode())%>';//生成业务编号
var applyType = "011";
var sorgId =  '<%=StrUtil.n2b(SomIdHelp.getGroupSorgId())%>';
var rootPath="<%=SkinUtils.getRootUrl(request)%>";
var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
</script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<!-- 更改业务状态所用dataset -->
	<model:dataset id="updateStatusDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineQueryCommand"  global="true" >
		<model:record fromBean="com.inspur.cams.sorg.online.base.data.SomApplyOnline"></model:record>
	</model:dataset>
	<model:dataset id="somMainOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryMain">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<%--社团基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryBranch">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<%--社会团体基本信息验证 --%>
			<model:field name="mainSorgCode" type="string" rule="require|length{20}" />			
			<model:field name="mainSorgName" type="string" rule="require|length{100}" />
			<model:field name="cnName" type="string" rule="require|length{100}" />
			<model:field name="residence" type="string" rule="require|length{100}" />
			<model:field name="legalPeople" type="string" rule="require|length{60}" />
			<model:field name="borgName" type="string" rule="require|length{100}" />
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
		<next:ToolBarItem symbol="社会团体异地设立分支/代表机构的审查受理"></next:ToolBarItem>
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
								<td class="FieldLabel">社会团体登记证号：</td>
								<td class="FieldInput"><input type="text" id="mainSorgCode" field='mainSorgCode'name='社会团体登记证号' onkeyup="value=value.replace(/[^\-\\w\.\/]/ig,'').toUpperCase()" onblur="validateSorgCode()" style="width:90%"/><span style="color:red">*</span></td>
								<td class="FieldLabel">社会团体名称：</td>
								<td class="FieldInput" colspan="3"><label id="name" field="mainSorgName" ></label></td>
							</tr>
							<tr>	
								<td class="FieldLabel">住所：</td>
								<td class="FieldInput" colspan="3"><label id="residence" ></label></td>
								<td class="FieldLabel" style="width:17%">法定代表人：</td>
								<td class="FieldInput" style="width:17%"><label id="legalPeople" field="legalPeople" ></label></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%">登记日期：</td>
								<td class="FieldInput" style="width:17%"><label id="regDate"  field="regDate" ></label></td>
								<td class="FieldLabel">业务主管单位：</td>
								<td class="FieldInput"><label field="borgName" dataset="businessOrganSelect"></label></td>
								<td class="FieldLabel" style="width:17%"><label>分支机构类型：</label></td>
								<td class="FieldInput" style="width:17%">
									<select name='"分支机构类型"' field="sorgKind" style="width:90%">
										<option dataset="sorgKindSelect"></option>
									</select><label style="color:red">*</label>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>拟设立的分支/代表机构名称：</label></td>
								<td class="FieldInput" colspan="5"><input type="text" id="cnName" name='"拟设立的分支/代表机构名称"' field="cnName" onchange="fillOrganInfo(this.value)" style="width:98%"/><label style="color:red">*</label></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>拟设立的分支/代表机构办公场所：</label></td>
								<td class="FieldInput" colspan="5"><input type="text" name='"拟设立的分支/代表机构办公场所"' field="residence" style="width:98%"/><label style="color:red">*</label></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%">拟设立的分支/代表机构负责人：</td>
								<td class="FieldInput" style="width:17%"><input type="text" name='拟设立的分支/代表机构负责人' field="branchCharger" style="width:90%"/><label style="color:red">*</label></td>
								<td class="FieldLabel" style="width:15%"><label>拟设立的分支/代表机构电话：</label></td>
								<td class="FieldInput" style="width:17%"><input type="text" id="sorgPhone" name='"拟设立的分支/代表机构电话"' field="sorgPhone" style="width:90%"/></td>
								<td class="FieldLabel" style="width:15%"><label>拟设立的分支/代表机构邮编：</label></td>
								<td class="FieldInput" style="width:17%"><input type="text" id="sorgPost" name='"拟设立的分支/代表机构邮编"' field="sorgPost" style="width:90%"/></td>
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
<next:Window id="changeName" closeAction="hide" title="名称变更" height="160" width="450" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="确定" handler="confirmWin"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form_content2" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
			<tr>
				<td class="FieldLabel" style="width:20%">变更前名称：</td>
				<td class="FieldInput" style="width:80%"><input type="text" id="oldName"  style="width:95%" disabled="disabled" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width:20%">变更后名称：</td>
				<td class="FieldInput" style="width:80%"><input type="text" id="newName"  style="width:95%"/></td>
    		</tr>
    		
		</table>
		</form>
   </next:Html>
</next:Window>
<jsp:include page="../../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>