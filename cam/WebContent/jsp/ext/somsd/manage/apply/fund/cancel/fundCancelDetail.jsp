<%@ page language="java" contentType="text/html; charset=utf-8"pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<%@page import="com.inspur.cams.sorg.util.SomDutyDuties"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="com.inspur.cams.sorg.online.apply.util.SomIdHelpOnline"%>
<%@ page import="com.inspur.cams.comm.extuser.data.ComExtUser"%>
<%@ page import="com.inspur.cams.sorg.online.extuser.util.SomExtBspInfo"%>
<html>
<%
	ComExtUser comExtUser = (ComExtUser)SomExtBspInfo.getUserInfo(request).getComExtUser();
	String username = comExtUser.getUserName();
	String organArea = comExtUser.getAreaCode();//获取外部单位行政区划12位
	String userId = comExtUser.getUserId();
%>
<html>
<head>
<title>基金会注销登记录入</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fundCancelDetail.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"camsCheck.js") %>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">
	<%
		String taskCode=request.getParameter("taskCode");
		if(taskCode==null){
			taskCode="";
		}
		String sorgId=request.getParameter("sorgId");
		if(sorgId==null){
			sorgId="";
		}
	%>
	var taskCode="<%=taskCode%>";
	var method='<%=request.getParameter("method")%>';
	var sorgId='<%=sorgId%>';
	var morgArea='<%=organArea%>';
	var userId='<%=userId%>';
	
	if(taskCode == ''){
			taskCode = '<%=SomIdHelpOnline.getFundTaskCode(organArea)%>';//生成业务编号
		}
	if(sorgId == ''){
		sorgId = '<%=SomIdHelpOnline.getFundSorgId(organArea)%>';//生成业务编号
	}
	
</script>
</head>
<body>

<model:datasets>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">			
		</model:record>
	</model:dataset>
	
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrganOnline" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="sorgCode" type="string" rule="require|length{20}" />
			<model:field name="sorgKind" type="string" rule="require" />
			<model:field name="organCode" type="string" rule="require|length{10}" />
			<model:field name="cnName" type="string" rule="require|length{100}" />
			<model:field name="legalPeople" type="string" rule="require|length{32}" />
			<model:field name="cancelDate" type="string" rule="require|length{10}"/>
			<model:field name="buildDate" type="string" rule="require|length{10}"/>
			<model:field name="residence" type="string" rule="require|length{100}"/>
			<model:field name="cancelReason" type="string" rule="require|length{500}"/>
			<model:field name="liqResult" type="string" rule="require|length{200}"/>
			<model:field name="sorgPhone" type="string" rule="length{20}"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somLiqpeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomLiqpeopleQueryCmd" global="true" sortField="IF_CHIEF" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomLiqpeople"></model:record>
	</model:dataset>
	<model:dataset id="winLiqpeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomLiqpeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomLiqpeople">
			<model:field name="name" type="string" rule="require|length{72}"/>
			<model:field name="liqDuties" type="string" rule="require|length{50}"/>
			<model:field name="ifChief" type="string" rule="require"/>
			<model:field name="workName" type="string" rule="length{100}"/>
			<model:field name="workDuties" type="string" rule="length{50}"/>			
		</model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryCatalog" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>	
	<model:dataset id="somOrganQueryDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryMain">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
		</model:record>
	</model:dataset>	
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="DIC_FUND_KIND"></model:param>
			<model:param name="value" value="CODE"></model:param>
			<model:param name="text" value="NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="SOM_CATALOG"></model:param>
			<model:param name="value" value="CATALOG_CODE"></model:param>
			<model:param name="text" value="CATALOG_NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ifChiefSelect" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:ViewPort>
	<next:Panel width="100%" height="100%">
		<next:TopBar>
			<next:ToolBarItem symbol="基金会注销登记"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
		</next:TopBar>
		<next:TabPanel id="tabSomOrgan" width="100%" height="100%">	
			<next:Tabs>
				<next:Panel id="panelSomOrgan" title="基金会注销登记申请表" width="100%" height="100%" autoScroll="true">
					<next:Html>
						<fieldset>
							<form id="cbForm" method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
								<table width="100%">
									<tr>
										<td class="FieldLabel" width="20%"><label>登记证号：</label></td>
										<td class="FieldInput" width="30%"><span lang=EN-US ><o:p><label id="sorgCode"  type="text" field="sorgCode" name='"登记证号"' maxlength="20"/></o:p></span><span style="color:red">*</span></td>
										<td class="FieldLabel" width="20%"><label>组织机构代码：</label></td>
										<td class="FieldInput" width="30%"><label field="organCode" name='"组织机构代码"' maxlength="10"/> <span style="color:red">*</span></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>基金会名称：</label></td>
										<td class="FieldInput"><label field="cnName" name='"基金会名称"'maxlength="100" /> <span style="color:red">*</span></td>
										<td class="FieldLabel"><label>成立日期：</label></td>
										<td class="FieldInput"><label field="buildDate" name='"成立日期"' /> <span style="color:red">*</span></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>基金会类型：</label></td>
										<td class="FieldInput">
											<label id="sorgKind" field="sorgKind" name='"基金会类型"' dataset="sorgKindSelect" >
											</label>							
										</td>
										<td class="FieldLabel"><label>注销日期：</label></td>
										<td class="FieldInput"><label id="cancelDate" name='"注销日期"' field="cancelDate" /></td>								
									</tr>
									<tr>							
										<td class="FieldLabel"><label>住所：</label></td>
										<td class="FieldInput"><label field="residence" name='"住所"' style="width:80%"maxlength="100"/> <span style="color:red">*</span> </td>
										<td class="FieldLabel"><label>基金会电话：</label></td>
										<td class="FieldInput"><label field="sorgPhone" name='"基金会电话"' maxlength="30"/></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>法定代表人：</label></td>
										<td class="FieldInput"><label field="legalPeople" name='"法定代表人"' maxlength="30"/> <span style="color:red">*</span></td>
										<td class="FieldLabel">业务主管单位：</td>
										<td class="FieldInput">
										<label type="text" id="borgNameDispaly" name="borgNameDispaly" style="width:60%"  title="业务主管单位" />
										<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >  
	        								<ul></ul> 
	   									</div>
	   									<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
										 <span style="color:red">*</span></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>注销原因：</label></td>
										<td class="FieldInput" colspan="3" ><textarea disabled="disabled" rows="3" id="cancelReason" name='"注销原因"' field="cancelReason" style="width:93%"></textarea><span style="color:red">*</span></td>
									</tr>
								</table>
							</form>	
						</fieldset>		
							<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
						<fieldset>	
							<legend>基金会履行内部程序</legend>					
								<table width="100%">
									<tr>														
										<td class="FieldLabel" style="width:20%"><label>基金会履行内部程序：</label></td>
										<td class="FieldInput" colspan="3" ><textarea disabled="disabled" rows="3" id="process" name='"基金会履行内部程序"' field="process" style="width:93%"></textarea><span style="color:red">*</span></td>
									</tr>	
								</table>
						</fieldset>		
							</form>	
							<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
						<fieldset>
							<legend>业务主管单位审查意见</legend>					
								<table width="100%">
									<tr>
										<td class="FieldLabel" style="width:20%">业务主管单位审查意见：</td>
										<td class="FieldInput" colspan="3"><textarea disabled="disabled" rows="3" id="borgOpinion" name="业务主管单位审查意见" field="borgOpinion" style="width:93%" ></textarea><span style="color:red">*</span></td>
									</tr>
								</table>
						</fieldset>
							</form>
							<form id="cbForm" method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
						<fieldset>
							<legend>清算结论</legend>
								<table width="100%">																					
									<tr>
										<td class="FieldLabel" style="width:20%"><label>清算结论（清算组织负责人签字）：</label></td>
										<td class="FieldInput" colspan="3" ><textarea disabled="disabled" rows="3" id="liqResult" name='"清算结论（清算组织负责人签字）"' field="liqResult" style="width:93%"></textarea><span style="color:red">*</span></td>
									</tr>
								</table>
						</fieldset>		
							</form>
					</next:Html>
				</next:Panel>
	
				<next:GridPanel id="gridLiqpeople" dataset="somLiqpeopleDataSet" title="清算组织人员" width="100%" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="清算组织主要组成人员列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="id" hidden="true" />
						<next:Column header="姓名" field="name" width="10%" />
						<next:Column header="在清算组织中职务" field="liqDuties" width="25%" />
						<next:Column header="清算组织负责人" field="ifChief" dataset="yesornoDataSet" width="15%" />
						<next:Column header="工作单位" field="workName" width="18%" />
						<next:Column header="职务（职称）" field="workDuties" width="18%" />		
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somLiqpeopleDataSet"/>
					</next:BottomBar>
				</next:GridPanel>

				<next:Panel title="法律要件" >
					<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
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
				</next:Panel>
			</next:Tabs>
		</next:TabPanel>
	</next:Panel>
</next:ViewPort>

<jsp:include page="../../../borg/borgSelectWindow.jsp" flush="true"/>  
</body>
</html>