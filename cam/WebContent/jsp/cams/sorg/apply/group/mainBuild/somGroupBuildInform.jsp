<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.loushang.workflow.api.WfQuery" %>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="com.inspur.cams.sorg.apply.group.cmd.GroupBuildCmd"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>社会团体流程</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js") %>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgOnline.js")%>'></script>
<script type="text/javascript">
<%
	String primaryKey=request.getParameter("primaryKey");
    if(primaryKey==null){
    	primaryKey="";
    }
	String assignmentId=(String)request.getParameter("assignmentId");
	String procDefUniqueId=(String)request.getParameter("procDefUniqueId");
	String actDefUniqueId=(String)request.getParameter("actDefUniqueId");
	String actname=(String)request.getParameter("actname");
	//然调用接口
	List<Map> list = new WfQuery().getActButtons(actDefUniqueId);
	String method = request.getParameter("method");
	Boolean flag = false;
	if("yiban".equals(method) || "jieshu".equals(method)){
		Map<String,String> map = new HashMap<String,String>();	
		map.put("buttonName","返回");
		map.put("buttonFunName","goBack()");
		List<Map> lists = new ArrayList<Map>();	
		lists.add(map);
		list = lists;
		flag = true;
	}
	List<Map> list1=new WfQuery().getActFields(actDefUniqueId); 
	//遍历list，如果该页面上某个域是需要隐藏的，则设置该域为不显示
	//如果域是只读的则显示为只读
	//如果是非空的，则在点击按钮时进行校验 ，若为空弹出提示框
	String fieldId,fieldName,isHidden,isReadOnly,isNotNull;
	//boolean isHidden,isReadOnly,isNotNull;
	String processId=(String)request.getParameter("processId");
	if(processId == null){
		processId = new GroupBuildCmd().getProcessId(assignmentId);
	}
%>
	var processId = '<%=processId%>';
	var procDefUniqueId = '<%=(String)request.getParameter("procDefUniqueId")%>';
	var assignmentId="<%=assignmentId%>";
	var currentUserName = '<%=GetBspInfo.getBspInfo().getUserName()%>';
	var actDefUniqueId ="<%=actDefUniqueId%>";
	var flag = <%=flag%>;
	var taskCode="";
	var sorgId="";
	var applyType="002";
	var end=false;
</script>
<script type="text/javascript">
//初始化
function init(){
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("1");
	L5.getCmp("tab").setActiveTab("0");
	//流程意见
	somApplyDataSet.setParameter("PROCESS_ID@=",processId);
	somApplyDataSet.load();
	somApplyDataSet.on('load',loadInfo);
	//过滤tab页
	if(flag == true){
		L5.getCmp("tab").remove(2);
	}
}
//加载页面
function loadInfo(){
	sorgId=somApplyDataSet.getCurrent().get("sorgId");
	taskCode=somApplyDataSet.getCurrent().get("taskCode");	
	var somFlowQuery=L5.DatasetMgr.lookup("somFlowQuery");
	somFlowQuery.setParameter("TASK_CODE@=",taskCode);
	somFlowQuery.setParameter("ACTIVITY@=","批准");
	somFlowQuery.setParameter("OPINION_ID@=","1");
	somFlowQuery.load();
	somFlowQuery.on('load',function (ds){
		if(ds.getCount()==0){
			somApplyDataSet.getCurrent().set("curOpinionId","0");
			if(document.getElementById("curOpinionId")){
				document.getElementById("curOpinionId").disabled="disabled";
			}
			end=true;
		}else if(ds.getCount()==1){
			somApplyDataSet.getCurrent().set("curOpinionId","1");
			if(document.getElementById("curOpinionId")){
				document.getElementById("curOpinionId").disabled="disabled";
			}
		}
	});
	
	somFlowListDataSet.setParameter("TASK_CODE@=", taskCode);
	somFlowListDataSet.setParameter("SORG_ID@=", sorgId);
	somFlowListDataSet.setParameter("APPLY_TYPE@=", "002");
	somFlowListDataSet.load();
	
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	
	somElectronicDataSet_load();//同步法律要件
}
//保存并提交
function send(){
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	if(somApplyDataSetIsValidate != true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tab").setActiveTab("2");
		return false;
	}
	//业务意见
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupBuildCmd");
	var somApplyDataSetRd = somApplyDataSet.getCurrent();
	command.setParameter("somApplyDataSetRd",somApplyDataSetRd);
	//保存并提交
	command.execute("send");
	if (!command.error) {
		if( end){//是发证环节流程结束
			L5.Msg.alert("提示","成功结束流程!",function(){
				goBack();
			});
		}else{
			L5.Msg.alert("提示","成功提交至下一环节!",function(){
				if(actname == 'audit'){
					if(somApplyDataSetRd.get("curOpinionId")=="1"){ //同意-批准通过-根据taskCode更改外网业务状态
						updateOnlineStatusPass(somApplyDataSetRd.get("taskCode"));
					}
					if(somApplyDataSetRd.get("curOpinionId")=="0"){ //不同意-批准不通过-根据taskCode更改外网业务状态
						updateOnlineStatusNoPass(somApplyDataSetRd.get("taskCode"));
					}
				}
				goBack();
			});
		}
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
//返回
function goBack(){
	history.go(-1);
}
</script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<!-- 更改业务状态所用dataset -->
	<model:dataset id="updateStatusDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineQueryCommand"  global="true" >
		<model:record fromBean="com.inspur.cams.sorg.online.base.data.SomApplyOnline"></model:record>
	</model:dataset>
	<%--查询业务流程意见表--%>
	<model:dataset id="flowDataSet">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>	
	<%--基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryMain">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<!-- 届次信息 -->
	<model:dataset id="somSessionDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession"></model:record>
	</model:dataset>
	<!-- 法定代表人信息 -->
	<model:dataset id="LegalPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 负责人信息 -->
	<model:dataset id="somDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 负责人详情窗口 -->
	<model:dataset id="somDutyInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 章程核准信息 -->
	<model:dataset id="somRule"cmd="com.inspur.cams.sorg.base.cmd.SomRuleQueryCmd" global="true" method="queryRule">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomRule"></model:record>
	</model:dataset>
	<%--会费标准信息--%>
	<model:dataset id="somFee"  cmd="com.inspur.cams.sorg.base.cmd.SomFeeQueryCmd" global="true" method="queryFee">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFee"></model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
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
	<%--法定代表人员电子档案--%>
	<model:dataset id="somLegalPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleCatalog" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--流程处理--%>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<%--业务意见信息验证--%>
			<model:field name="curOpinionId" type="string" rule="require"/>
		    <model:field name="curOpinion" type="string" rule="length{200}"/>
		</model:record>
	</model:dataset>
	<%--流程历史意见--%>
	<model:dataset id="somFlowListDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" global="true" sortField="COMMIT_TIME">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<model:dataset id="somFlowQuery" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand" sortField="startDate" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>	
	<%--法定代表人人员简历 --%>
	<model:dataset id="somResumeLegalDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>	
	<%--人员简历 --%>
	<model:dataset id="somResumeInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
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
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_GROUP_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="politicsSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="resideSourceSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RESIDE_SOURCE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ifServeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DUTY_IF_SERVE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgDutiesSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ifFulltimeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="folkSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>

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
	<model:dataset id="cardTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CARD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="pubOrganDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='PUB_ORGAN'></model:param>
			<model:param name="value" value='ORGAN_ID'></model:param>
			<model:param name="text" value='ORGAN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 会议类型 -->
	<model:dataset id="meetingType" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_MEETING_TYPE'></model:param>
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
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="workFlowOpinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>	
</model:datasets>	
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<% 
			//从后台获取环节按钮权限，显示要显示按钮
			for(int i=0;i<list.size();i++){
				Map map=(Map)list.get(i);
				String buttonName=(String)map.get("buttonName");
				String buttonFunName=(String)map.get("buttonFunName");
				String buttonIcon = "";
				if("saveApply()".equals(buttonFunName)){
					buttonIcon = "save";
				}
				if("send()".equals(buttonFunName)){
					buttonIcon = "select";
				}
				if("sendForPrint()".equals(buttonFunName)){
					buttonIcon = "select";
				}
				if("printNoAccept()".equals(buttonFunName)){
					buttonIcon = "print";
				}
				if("printAccept()".equals(buttonFunName)){
					buttonIcon = "print";
				}
				if("printCert()".equals(buttonFunName)){
					buttonIcon = "print";
				}
				if("choseIssuePeople()".equals(buttonFunName)){
					buttonIcon = "select";
				}
				if("goBack()".equals(buttonFunName)){
					buttonIcon = "return";
				}
		%>			
				<next:ToolBarItem iconCls="<%=buttonIcon%>" text="<%=buttonName%>" handler="<%=buttonFunName%>" />
		<%	
			}
		%>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab">
		<next:Tabs>		
			<next:Panel title="登记申请书"width="100%" height="100%" autoScroll="true">
				<next:Html>
					<fieldset>
						<legend>登记申请书</legend>
						<form method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
							<table width="100%">
								<tr>
									<td class="FieldLabel">社会团体中文名称：</td>
									<td class="FieldInput" colspan="3"><label  field="cnName"/></td>
									<td class="FieldLabel">登记证号：</td>
									<td class="FieldInput"><label  field="sorgCode"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">社会团体英文名称：</td>
									<td class="FieldInput"  style="width:17%"><label  field="enName"/></td>
									<td class="FieldLabel" style="width:17%">社会团体英文名称缩写：</td>
									<td class="FieldInput" style="width:17%"><label  field="abName"/></td>
									<td class="FieldLabel" style="width:17%">登记日期：</td>
									<td class="FieldInput" style="width:17%"><label  field="regDate"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">社会团体类型：</td>
									<td class="FieldInput"><label  field="sorgKind" dataset="sorgKindSelect"/></td>
									<td class="FieldLabel">所属行（事）业：</td>
									<td class="FieldInput"><label  field="busScope" dataset="busScopeSelect"/></td>
									<td class="FieldLabel">成立日期：</td>
									<td class="FieldInput"><label  field="buildDate"/></td>
								</tr>
								<tr>	
									<td class="FieldLabel" style="width:17%">住所来源：</td>
									<td class="FieldInput" style="width:17%"><label  field="resideSource" dataset="resideSourceSelect"/></td>
									<td class="FieldLabel">住所：</td>
									<td class="FieldInput" colspan="3"><label  field="residence"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">社会团体邮编：</td>
									<td class="FieldInput" style="width:17%"><label  field="sorgPost"/></td>								
									<td class="FieldLabel">社会团体电话：</td>
									<td class="FieldInput"><label  field="sorgPhone"/></td>		
									<td class="FieldLabel">活动地域：</td>
									<td class="FieldInput"><label  field="actArea"/></td>						
								</tr>
								<tr>
									<td class="FieldLabel">业务主管单位：</td>
									<td class="FieldInput"><label  field="borgName" dataset="businessOrganSelect"/></td>
									<td class="FieldLabel">业务主管单位联系人：</td>
									<td class="FieldInput"><label  field="borgPeople"/></td>
									<td class="FieldLabel">业务主管单位电话：</td>
									<td class="FieldInput"><label  field="borgPhone"/></td>
								</tr>
								<tr>	
									<td class="FieldLabel">社会团体宗旨：</td>
									<td class="FieldInput" colspan="5"><textarea rows="5" name='社会团体宗旨' field="purpose" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;"  readonly="readonly"></textarea></td>
								</tr>
								<tr>	
									<td class="FieldLabel">业务范围：</td>
									<td class="FieldInput" colspan="5"><textarea rows="5" name='业务范围' field="business"  style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly="readonly"></textarea></td>
								</tr>
								<tr>	
									<td class="FieldLabel">单位会员数：</td>
									<td class="FieldInput"><label  field="unitsNum"/></td>
									<td class="FieldLabel">个人会员数：</td>
									<td class="FieldInput"><label  field="peopleNum"/></td>
									<td class="FieldLabel">理事数：</td>
									<td class="FieldInput"><label  field="councilNum"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">常务理事数：</td>
									<td class="FieldInput"><label  field="standCouncilNum"/></td>
									<td class="FieldLabel">活动资金数额：</td>
									<td class="FieldInput" colspan="3"><label  field="regMon"/>万元</td>
								</tr>
								<tr>
									<td class="FieldLabel">出资人：</td>
									<td class="FieldInput" colspan="5"><textarea name='出资人' field="fundingPeople" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly="readonly"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel">验资单位：</td>
									<td class="FieldInput" colspan="5"><label  field="checkCapitalOrgan"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">经费来源：</td>
									<td class="FieldInput" colspan="5"><label  field="moneySource"/></td>
								</tr>
								<tr>	
									<td class="FieldLabel">住所产权单位：</td>
									<td class="FieldInput" colspan="3"><label  field="housingOrgan"/></td>
									<td class="FieldLabel">用房面积：</td>
									<td class="FieldInput"><label  field="housingArea"/>平方米</td>
								</tr>
								<tr>
									<td class="FieldLabel">租（借）期限：</td>
									<td class="FieldInput" colspan="5"><label  field="leasePeriod"/></td>
								</tr>
								<tr>	
									<td class="FieldLabel">社会团体通信地址：</td>
									<td class="FieldInput"><label  field="sorgAdds"/></td>
									<td class="FieldLabel">社会团体电子邮箱：</td>
									<td class="FieldInput"><label  field="sorgEmail"/></td>
									<td class="FieldLabel" style="width:15%">社会团体传真：</td>
									<td class="FieldInput" style="width:17%"><label  field="sorgFax"/></td>
								</tr>
							</table>
						</form>
					</fieldset>
					<fieldset>
						<legend>历史处理意见</legend>
						<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:17%">承办人意见：</td>
									<td class="FieldInput" style="width:17%">
										<label field="acceptOpinionId" name='"承办人意见"' style="width:90%" dataset="hisOpinionDataSet"/>
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
									<td class="FieldLabel" style="width:17%">初审人：</td>
									<td class="FieldInput" style="width:17%"><label type="text" field="examinPeopleName" name='初审人'  style="width:90%" />
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
				</next:Html>
			</next:Panel>
			<next:Panel title="流程历史意见" width="100%" >
				<next:GridPanel id="flowGrid" width="100%" stripeRows="true" height="100%" dataset="somFlowListDataSet" >
					<next:Columns>
						<next:RowNumberColumn/>
						<next:Column id="activity" header="流程环节" field="activity" width="13%" editable="false"></next:Column>
						<next:Column id="organId" header="处理单位" field="organId" width="13%" editable="false" dataset="pubOrganDataSet"></next:Column>
						<next:Column id="deptId" header="处理部门" field="deptId" width="13%" editable="false" dataset="pubOrganDataSet"></next:Column>
						<next:Column id="actorId" header="处理人" field="actorId" width="10%" editable="false" dataset="pubOrganDataSet"></next:Column>
						<next:Column id="commitTime" header="处理时间" field="commitTime" width="18%" editable="false"></next:Column>
						<next:Column id="opinionId" header="处理意见" field="opinionId" width="10%" editable="false" dataset="workFlowOpinionSelect"></next:Column>
						<next:Column id="opinion" header="处理补充意见" field="opinion" width="40%" editable="false"></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somFlowListDataSet" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
			<next:Panel title="处理意见" width="100%" >
				<next:Html>
					<fieldset style="width:100%">
						<form method="post" onsubmit="return false" class="L5form" dataset="somApplyDataSet">
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:13%"><label>处理意见：</label></td>
									<td class="FieldInput" colspan="5">
									<select id='curOpinionId'field="curOpinionId" name='"处理意见"' style="width:150px" default="0">
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
</body>
</html>