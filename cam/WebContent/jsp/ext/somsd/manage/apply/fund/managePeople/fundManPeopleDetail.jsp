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
<head>
<title>基金会负责人备案</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fundManPeopleDetail.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgComm.js")%>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
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
<script type="text/javascript">
	var applyType='224';
	var fileCodeL="J064";//理事
	var fileCodeS="";//监事
	var peopleType = "";//人员类型及状态（监事、理事）
	var currentId='';//dutyId
	// 增加负责人
	function add(){
		somDutyDataSet.removeAll();
		currentId = '<%=IdHelp.getUUID32()%>';
		somDutyDataSet.newRecord({"dutyId":currentId,"ifServe":"1","ifPartyLeader":"0","sorgType":"J","ifLegal":"0","regStatus":"1","sorgDuties":sorgDuties});
		somDutyDataSet.set("startDate",_$("startDate"));
		var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
		somResumeInsertDataSet.filterBy(function(record, id){
		});
		if(peopleType=="L"){
			somPeopleElectronicDataSet_load(fileCodeL,currentId);
		}
		if(peopleType=="S"){
			somPeopleElectronicDataSet.removeAll();
		}
		L5.getCmp("peopleWin").show();
		initPhoto("1");//初始化照片
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
			<model:field name="cnName" type="string" rule="require|length{100}" />
		</model:record>
	</model:dataset>
	<model:dataset id="somSessionDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd"   global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession">
			<model:field name="tenure" type="string" rule="integer|length{2}" />
			<model:field name="sessionName" type="string" rule="length{100}"/>
		</model:record>
	</model:dataset>
	<!-- 监事备案 -->
	<model:dataset id="aspForJianShi"
		cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"
		method="queryPeople" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty">
			<model:field name="idCard" type="string" rule="length{18}" />
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="aliasName" type="string" rule="length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
			<model:field name="sorgDuties" type="string" rule="require" />
			<model:field name="adds" type="string" rule="length{100}" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{50}" />
			<model:field name="resume" type="string" rule="length{1000}" />
			<model:field name="workOpinion" type="string" rule="length{200}" />
			<model:field name="sorgOpinion" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
	<!-- 理事备案 -->
	<model:dataset id="aspForLiShi"
		cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd"
		method="queryPeople" global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty">
			<model:field name="idCard" type="string" rule="length{18}" />
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="aliasName" type="string" rule="length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
			<model:field name="sorgDuties" type="string" rule="require" />
			<model:field name="adds" type="string" rule="length{100}" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{50}" />
			<model:field name="resume" type="string" rule="length{1000}" />
			<model:field name="workOpinion" type="string" rule="length{200}" />
			<model:field name="sorgOpinion" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
	<!-- 负责人 -->
	<model:dataset id="CurrentDataset"
		cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty">
			<model:field name="name" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<%--所有符合身份证号的人员列表--%>
	<model:dataset id="winPeopleDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomPeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople"></model:record>
	</model:dataset>
	<%--所有符合身份证号的人员列表--%>
	<model:dataset id="winDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
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
	<%--人员电子档案--%>
	<model:dataset id="somPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--人员电子档案上传窗口--%>
	<model:dataset id="winPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleElectronic">
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
	<%--人员简历 --%>
	<model:dataset id="somResumeInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand" sortField="startDate" sortDirection="DESC" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume">
			<model:field name="workOrgan" type="string" rule="length{200}" />
			<model:field name="duty" type="string" rule="length{100}" />
		</model:record>
	</model:dataset>	
	<%--法定代表人人员简历 --%>
	<model:dataset id="somResumeLegalDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>	
	<!-- 处理单位 -->
	<model:dataset id="pubOrganDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='PUB_ORGAN'></model:param>
			<model:param name="value" value='ORGAN_ID'></model:param>
			<model:param name="text" value='ORGAN_NAME'></model:param>
		</model:params>
	</model:dataset>	
	<model:dataset id="certTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CERT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
		<!-- 社会组织种类 -->
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_FUND_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
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
	<!-- 社会组织职务 -->
	<model:dataset id="sorgDutiesSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 专兼职 -->
	<model:dataset id="ifFulltimeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="folkSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="ifServeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DUTY_IF_SERVE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 证件类型 -->
	<model:dataset id="cardTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CARD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="sexSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织职务 -->
	<model:dataset id="sorgDutiesDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 任职状态 -->
	<model:dataset id="regStatusDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_REG_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>	
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 负责人录入窗口 -->
	<model:dataset id="somDutyDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty">
			<model:field name="idCard" type="string" rule="require|length{18}" />
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="aliasName" type="string" rule="length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
			<model:field name="ifPartyLeader" type="string" rule="require" />
			<model:field name="startDate" type="string" rule="require" />
			<model:field name="sorgDuties" type="string" rule="require" />
			<model:field name="adds" type="string" rule="length{100}" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="postCode" type="string" rule="length{6}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{50}" />
			<model:field name="resume" type="string" rule="length{1000}" />
			<model:field name="workOpinion" type="string" rule="length{200}" />
			<model:field name="sorgOpinion" type="string" rule="length{200}" />
			<model:field name="promiseOrgan" type="string" rule="length{100}" />
			<model:field name="promiseCode" type="string" rule="length{100}" />
			<model:field name="otherDuties" type="string" rule="length{500}" />
			<model:field name="note" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
</model:datasets>

<next:Panel width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel id="tabSomOrgan" width="100%" height="100%">
		<next:Tabs>
			<next:Panel title="基金会理事,监事备案表" width="100%" height="100%"
				autoScroll="true">
				<next:Panel>
					<next:Html>
						<fieldset style="overflow: visible;"><legend>基金会信息</legend>
						<form id="form2" dataset="somSessionDataSet"
							onsubmit="return false" class="L5form"><input
							type="hidden" field="sessionId" />
						<table width="100%">
							<tr>
								<td class="FieldLabel">登记证号：</td>
								<td class="FieldInput"><label type="text"
									id="sorgCode"  name='"登记证号"' style="width: 90%" maxlength="20"/><span style="color:red">*</span> </td>
								<td class="FieldLabel">基金会名称：</td>
								<td class="FieldInput" colspan="3"><label type="text"
									id="cnName"  name='"基金会名称"' style="width: 90%" maxlength="50"/><span style="color:red">*</span></td>
								
							</tr>
							<tr>
								<td class="FieldLabel">届次名称：</td>
								<td class="FieldInput" colspan="3"><label type="text"
									id="sessionName" field="sessionName" name='"届次名称"'
									style="width: 90%" /></td>
								<td class="FieldLabel">本届任期（年）：</td>
								<td class="FieldInput"><label type="text" id="tenure"
									field="tenure" name='"本届任期（年）"' 
									style="width: 90%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">本届开始日期：</td>
								<td class="FieldInput" style="width: 17%"><label
									type="text" id="startDate" field="startDate" name='"本届开始日期"'
									 readonly="readonly"
									style="width: 90%" /></td>
								<td class="FieldLabel" style="width: 17%">章程规定换届日期：</td>
								<td class="FieldInput" style="width: 15%"><label
									type="text" id="endDate" field="endDate" name='"章程规定换届日期"'
									 readonly="readonly"
									style="width: 90%" /></td>
								<td class="FieldLabel" style="width: 17%"></td>
								<td class="FieldInput" style="width: 17%"></td>
							</tr>
						</table>
						</form>
						</fieldset>
					</next:Html>
				</next:Panel>
				<next:EditGridPanel id="peopleGrid" dataset="aspForLiShi" width="100%" stripeRows="true" height="300" hasSum="true" title="理事备案表">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="detail" text="查看" handler="detailL"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="担任职务" field="sorgDuties" width="15%"
							editable="false" summaryType="count">
							<next:ExtendConfig>
								summaryRenderer : countRender
							</next:ExtendConfig>
							<next:ComboBox dataset="sorgDutiesSelect" />
						</next:Column>
						<next:Column header="身份证号" field="idCard" width="15%" editable="false"><next:TextField/></next:Column>
						<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexSelect"/></next:Column>
						<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="任职状态" field="regStatus" width="10%" editable="false"><next:TextField/><next:ComboBox dataset="regStatusDataSet"/></next:Column>
						<next:Column header="任职开始日期" field="startDate" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="任职结束日期" field="endDate" width="10%" editable="false"><next:TextField/></next:Column>
					
					</next:Columns>
				</next:EditGridPanel>
				<next:EditGridPanel id="peopleGrid1" dataset="aspForJianShi" width="100%" stripeRows="true" hasSum="true" height="250" title="监事备案表">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="detail" text="查看" handler="detailS"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="担任职务" field="sorgDuties" width="15%"
							editable="false" summaryType="count">
							<next:ExtendConfig>
								summaryRenderer : countRenderS
							</next:ExtendConfig>
							<next:ComboBox dataset="sorgDutiesSelect" />
						</next:Column>
					<next:Column header="身份证号" field="idCard" width="15%" editable="false"><next:TextField/></next:Column>
						<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexSelect"/></next:Column>
						<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="任职状态" field="regStatus" width="10%" editable="false"><next:TextField/><next:ComboBox dataset="regStatusDataSet"/></next:Column>
						<next:Column header="任职开始日期" field="startDate" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="任职结束日期" field="endDate" width="10%" editable="false"><next:TextField/></next:Column>
					
					</next:Columns>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="基金会负责人备案表" width="100%" height="100%" >
				<next:EditGridPanel id="peopleGrid2" dataset="CurrentDataset" width="100%" stripeRows="true" hasSum="true" height="100%"
					title="基金会负责人候选人基本情况">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="担任职务" field="sorgDuties" width="15%"
							editable="false" summaryType="count">
							<next:ExtendConfig>
								summaryRenderer : countRenderF
							</next:ExtendConfig>
							<next:ComboBox dataset="sorgDutiesSelect" />
						</next:Column>
						<next:Column header="身份证号" field="idCard" width="15%" editable="false"><next:TextField/></next:Column>
						<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexSelect"/></next:Column>
						<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="任职状态" field="regStatus" width="10%" editable="false"><next:TextField/><next:ComboBox dataset="regStatusDataSet"/></next:Column>
						<next:Column header="任职开始日期" field="startDate" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="任职结束日期" field="endDate" width="10%" editable="false"><next:TextField/></next:Column>
					
					</next:Columns>
				</next:EditGridPanel>
			</next:Panel>
			<next:EditGridPanel id="uploadGrid" title="法律要件" width="100%"
				stripeRows="true" height="100%" dataset="somElectronicDataSet">
				<next:TopBar>
					<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn />
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="档案目录名" field="catalogCode" width="38%"
						editable="false" dataset="cataLogCodeSelect">
						<next:TextField />
					</next:Column>
					<next:Column header="附件名称" field="fileName" width="30%"
						editable="false">
						<next:TextField />
					</next:Column>
					<next:Column header="附件描述" field="fileMess" width="20%"
						editable="false">
						<next:TextField />
					</next:Column>
					<next:Column header="下载附件" field="" width="10%" editable="false"
						renderer="clickDownloadHref">
						<next:TextField />
					</next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somElectronicDataSet" />
				</next:BottomBar>
			</next:EditGridPanel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>

<!-- 负责人录入窗口 -->
<next:Window id="peopleWin" title="人员备案表" resizable="false" width="800" height="430" closeAction="hide" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="人员备案表"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel id="tabSomOrgan">
		<next:Tabs>
			<next:Panel id="panel_win" title="基本信息" autoScroll="true" width="770" height="85%">
				<next:Html>
					<form title="负责人信息" id="addForm" method="post" dataset="somDutyDataSet" onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width:15%">身份证号码：</td>
								<td class="FieldInput" style="width:21%"><label type="text" id="idCardID" field="idCard" name='"身份证号码"'  style="width:90%"/><span style="color:red">*</span></td>
								<td class="FieldLabel" style="width:14%">姓名：</td>
								<td class="FieldInput" style="width:17%"><label type="text" field="name" name='"姓名"' style="width:90%"/><span style="color:red">*</span></td>
								<td class="FieldLabel" style="width:14%" rowspan="4">照片:</td>
								<td class="FieldInput" style="width:19%" nowrap colspan="1" rowspan="4">
								<div id="photoDiv1">
									<img id="img1" name="RELATIONER_PHOTOC_IMG1" width=82.5 height=110 src="<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg" 
									align="top" ondblclick="editPhoto(11,'photoId1','RELATIONER_PHOTOC_IMG1');"
									onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg'" alt="暂无图片" />
									<input type="hidden" id="photoId1" name="photoId1"/>
								</div>	
								</td>
							</tr>
							<tr>
								<td class="FieldLabel">曾用名：</td>
								<td class="FieldInput"><label type="text" field="aliasName" name='"曾用名"' style="width:90%"/></td>
								<td class="FieldLabel">年龄：</td>
								<td class="FieldInput"><label id="age" name='年龄'/></td>
							</tr>
							<tr>
								<td class="FieldLabel">性别：</td>
								<td class="FieldInput">
									<label field="sex" name='"性别"' dataset="sexSelect" style="width:90%">
									</label>
								</td>
								<td class="FieldLabel">出生年月：</td>
								<td class="FieldInput"><input disabled="true" type="text" id="birthday" field="birthday" name='"出生年月"' style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">政治面貌：</td>
								<td class="FieldInput">
									<label field="politics" name='"政治面貌"' dataset="politicsSelect" style="width:90%">
									</label>
								</td>
								<td class="FieldLabel">民族：</td>
								<td class="FieldInput">
									<label field="folk" dataset="folkSelect" name='"民族"' style="width:90%">
									</label>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel">国籍：</td>
								<td class="FieldInput">
									<label type="text" id="nationDispaly" name="countryNameDispaly"  title="国籍"  />
									<div id="countryDiv" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >  
        								<ul></ul> 
   									</div>
   									<input type="hidden" id="nation" name="nation" field="nation" title="国籍"/>
								</td>
								<td class="FieldLabel">家庭住址：</td>
								<td class="FieldInput"><label type="text" field="adds" name='"家庭住址"' style="width:90%"/></td>
								<td class="FieldLabel">户口所在地：</td>
								<td class="FieldInput"><label type="text" field="populace" name='"户口所在地"' style="width:90%"/></td>
						
							</tr>
							<tr>
								<td class="FieldLabel">邮编：</td>
								<td class="FieldInput"><label type="text" id="postCode" field="postCode" name='邮编' style="width:90%"/></td>
								<td class="FieldLabel">电话：</td>
								<td class="FieldInput"><label type="text" id="phone" field="phone" name='"电话"' style="width:90%"/></td>
								<td class="FieldLabel">专/兼职：</td>
								<td class="FieldInput">
									<label field="ifFulltime" dataset="ifFulltimeSelect" name='"专/兼职"' style="width:90%">
									</label>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel">工作单位：</td>
								<td class="FieldInput" colspan="3"><label type="text" field="workName" name='"工作单位"' style="width:90%"/></td>
								<td class="FieldLabel">工作单位职务：</td>
								<td class="FieldInput"><label type="text" field="workDuties" name='"单位职务"' style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">基金会职务：</td>
								<td class="FieldInput">
									<label field="sorgDuties" dataset="sorgDutiesDataSet" name='"基金会职务"' style="width:90%">
									</label><span style="color:red">*</span>
								</td>
								<td class="FieldLabel">任职开始日期：</td>
								<td class="FieldInput"><label type="text" field="startDate" name='"任职开始日期"' style="width:90%"/><span style="color:red">*</span></td>
								<td class="FieldLabel">任职结束日期：</td>
								<td class="FieldInput"></td>
							</tr>
							<tr>
								<td class="FieldLabel">是否党政机关领导干部：</td>
								<td class="FieldInput">
									<label field="ifPartyLeader" dataset="comm_yesorno" id="ifPartyLeader_add" name='"是否党政机关领导干部"' onchange="valid_ifPartyLeader_add();" style="width:90%">
									</label><span style="color:red">*</span>
								</td>
								<td class="FieldLabel">批准机关：</td>
								<td class="FieldInput"><input type="text" disabled="disabled" id="promiseOrgan_add"field='promiseOrgan' style="width:90%;display:none"/></td>
								<td class="FieldLabel">批准文号：</td>
								<td class="FieldInput"><label type="text" id="promiseCode_add"field='promiseCode' style="width:90%;display:none"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">其他社会职务：</td>
								<td class="FieldInput" colspan="5"><textarea disabled="disabled" rows="3" field="otherDuties" name='"其他社会职务"' style="width:97.7%"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel">本人所在单位人事部门审查意见：</td>
								<td class="FieldInput" colspan="5"><textarea  disabled="disabled" rows="2" name='"所在单位人事部门审查意见"' field="workOpinion" style="width:97.7%"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel">审查工作单位：</td>
								<td class="FieldInput" colspan="3"><label type="text" field="workName" name='"工作单位"' style="width:90%"/></td>
								<td class="FieldLabel">审查日期：</td>
								<td class="FieldInput"><label type="text" field="workCheckDate"  style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">备注：</td>
								<td class="FieldInput" colspan="5"><textarea rows="2" name='"备注"' field="note" style="width:97.7%"></textarea></td>
							</tr>
						</table>
					</form>			
				</next:Html>
			</next:Panel>
			<next:EditGridPanel id="somResumeGrid" dataset="somResumeInsertDataSet" stripeRows="true" title="本人简历" width="770" height="85%" autoScroll="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
					<next:Column header="开始年月" field="startDate" width="10%" editable="false" ><next:TextField/></next:Column>
					<next:Column header="结束年月" field="endDate" width="10%" editable="false" ><next:TextField/></next:Column>
					<next:Column header="在何地区何单位" field="workOrgan" width="25%" editable="false"><next:TextField/></next:Column>
					<next:Column header="任（兼）何职" field="duty" width="20%" editable="false"><next:TextField/></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somResumeInsertDataSet" />
				</next:BottomBar>
			</next:EditGridPanel>
			<next:EditGridPanel id="uploadPeopleGrid" title="法律要件" stripeRows="true" dataset="somPeopleElectronicDataSet" width="770" height="85%" autoScroll="true">
				<next:TopBar>
					<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn />
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="档案目录名" field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect">
						<next:TextField />
					</next:Column>
					<next:Column header="附件名称" field="fileName" width="30%" editable="false">
						<next:TextField />
					</next:Column>
					<next:Column header="附件描述" field="fileMess" width="20%" editable="false">
						<next:TextField />
					</next:Column>
					<next:Column header="下载附件" field="" width="10%" editable="false" renderer="clickDownloadPeopleHref">
						<next:TextField />
					</next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somPeopleElectronicDataSet" />
				</next:BottomBar>
			</next:EditGridPanel>
		</next:Tabs>
	</next:TabPanel>	
	<next:Buttons>
		<next:ToolButton text="关闭" handler="closeWin"></next:ToolButton>
	</next:Buttons>
</next:Window>
<jsp:include page="../../../../../../cams/sorg/comm/upload/uploadWindow.jsp" flush="true"/>
<jsp:include page="../../../country/countrySelectWindow.jsp" flush="true"/> 
</body>
</html>