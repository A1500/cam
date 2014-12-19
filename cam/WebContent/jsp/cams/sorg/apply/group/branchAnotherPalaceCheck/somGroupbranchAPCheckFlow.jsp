<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.loushang.workflow.api.WfQuery" %>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="com.inspur.cams.sorg.apply.group.cmd.GroupBranchAPCheckCmd"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>社会团体异地设立分支/代表机构的审查</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js") %>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
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
		processId = new GroupBranchAPCheckCmd().getProcessId(assignmentId);
	}
%>
	var processId = '<%=processId%>';
	var procDefUniqueId = '<%=(String)request.getParameter("procDefUniqueId")%>';
	var assignmentId="<%=assignmentId%>";
	var currentUserName = '<%=GetBspInfo.getBspInfo().getUserName()%>';
	var actDefUniqueId ="<%=actDefUniqueId%>";
	var taskCode='';
	var sorgId = "";
	var actname='<%=actname%>';
	var flag = <%=flag%>;
	var applyType = "011";
</script>
<script type="text/javascript">
//初始化
function init(){
	L5.getCmp("tab").setActiveTab("0");
	L5.getCmp("tab").setActiveTab("1");
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("0");
	//流程意见
	somApplyDataSet.setParameter("PROCESS_ID@=",processId);
	somApplyDataSet.load();
	somApplyDataSet.on('load',loadInfo);
	
	//过滤tab页
	if(flag == true){
		L5.getCmp("tab").remove(3);
	}
}
//加载页面
function loadInfo(){
	sorgId=somApplyDataSet.get("sorgId");
	taskCode=somApplyDataSet.get("taskCode");
	somApplyDataSet.set("curOpinionId", "1");
	if(actname=='inform'){//是通知受理人
		var somFlowQuery=L5.DatasetMgr.lookup("somFlowQuery");
		somFlowQuery.setParameter("TASK_CODE@=",taskCode);
		somFlowQuery.setParameter("ACTIVITY@=","批准");
		somFlowQuery.setParameter("OPINION_ID@=","1");
		somFlowQuery.load();
		somFlowQuery.on('load',function (ds){
			if(ds.getCount()==0){
				somApplyDataSet.getCurrent().set("curOpinionId","0");
				//过滤流程意见
				opinionSelect.filterBy(function(record, id){
					if("0".indexOf(record.get('value'))>-1){
						return record;
					}
				});
				//document.getElementById("curOpinionId").disabled="disabled";
			}else if(ds.getCount()==1){
				somApplyDataSet.getCurrent().set("curOpinionId","1");
				//过滤流程意见
				opinionSelect.filterBy(function(record, id){
					if("1".indexOf(record.get('value'))>-1){
						return record;
					}
				});
				//document.getElementById("curOpinionId").disabled="disabled";
			}
		});
	}		
	somFlowListDataSet.setParameter("TASK_CODE@=", taskCode);
	somFlowListDataSet.setParameter("SORG_ID@=", sorgId);
	somFlowListDataSet.setParameter("APPLY_TYPE@=", applyType);
	somFlowListDataSet.load();
	
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on('load',loadMainInfo);
	if(actname=="inform"){
		somOrganDataSet.on("load",function(ds){
			$("mainSorgId").value = ds.get("mainSorgId");
		});
	}
	somElectronicDataSet.setParameter("taskCode", taskCode);
	somElectronicDataSet.setParameter("sorgId", sorgId);
	somElectronicDataSet.setParameter("applyType", applyType);
	somElectronicDataSet.load();
}
//分支加载时候取到主体登记证号，加载主体
function loadMainInfo(ds){
 	ds.un("load",loadMainInfo);
 	if(ds.getCount() > 0 ){
 		somMainOrganDataSet.setParameter("SORG_TYPE@=","S");
		somMainOrganDataSet.setParameter("SORG_CODE@=",ds.get('mainSorgCode'));
		somMainOrganDataSet.load();
		somMainOrganDataSet.on('load',fillMainInfo);
 	}
}
//主体加载之后维护住所和登记日期
function fillMainInfo(ds){
	ds.un("load",fillMainInfo);
	document.getElementById('residence').innerHTML=ds.get("residence");
	document.getElementById('regDate').innerHTML=ds.get("regDate");
}
//保存
function saveApply(){
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	if(somApplyDataSetIsValidate != true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tab").setActiveTab("2");
		return false;
	}
	var somApplyRecord=somApplyDataSet.getCurrent();
	//业务意见
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupBranchAPCheckCmd");
	command.setParameter("somApplyRecord",somApplyRecord);
	//保存
	command.execute("updateApply");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			goBack();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//保存并提交
function send(){
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	if(somApplyDataSetIsValidate != true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tab").setActiveTab("2");
		return false;
	}
	var somApplyRecord = somApplyDataSet.getCurrent();
	//业务意见
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupBranchAPCheckCmd");
	command.setParameter("somApplyRecord",somApplyRecord);
	//保存并提交
	command.execute("send");
	if (!command.error) {
		if(actname=='inform' ){
			L5.Msg.alert("提示","成功结束流程!",function(){
				goBack();
			});
		}else{
			L5.Msg.alert("提示","成功提交至下一环节!",function(){
				goBack();
			});
		}
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
//打印受理通知
function printAccept(){
	var url=rootPath+"jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=S";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&printPeople="+currentUserName;	
	window.open(url);
}
//打印不予受理通知
function printNoAccept(){
	var url=rootPath+"jsp/cams/sorg/comm/print/noAcceptForPrint.jsp?sorgType=S";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&printPeople="+currentUserName;	
	window.open(url);
}
//返回
function goBack(){
	history.go(-1);
}
//打印同意设立的函
function print(){
	var mainSorgId=_$("mainSorgId");
	var url=L5.webPath+"/jsp/cams/sorg/comm/print/fundBranchAPCheckAgreeForPrint.jsp?sorgId="+sorgId+"&mainSorgId="+mainSorgId;
	window.open(url);	
}
function getActDefName(){
	if(act=='examin'){
		return "初审";
	}else if(act=='check'){
		return "审核";
	}else if(act=='audit'){
		return "批准";
	}else if(act=='inform'){
		return "通知申请人";
	}
}
</script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<model:dataset id="somMainOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryMain">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<%--查询业务流程意见表--%>
	<model:dataset id="flowDataSet">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>	
	<%--基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryBranch">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--流程处理--%>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<model:field name="curOpinionId" type="string" rule="require"/>
		    <model:field name="curOpinion" type="string" rule="length{500}"/>		
		</model:record>
	</model:dataset>
	<%--流程历史意见--%>
	<model:dataset id="somFlowListDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" global="true" sortField="COMMIT_TIME">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<model:dataset id="somFlowQuery" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
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
			<model:param name="dic" value='DIC_FUND_BRANCH_KIND'></model:param>
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
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>

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
				if("print()".equals(buttonFunName)){
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
			<next:Panel title="设立申请书" width="100%" >
				<next:Panel width="100%" height="100%" autoScroll="true">
						<next:Html>
						<fieldset>
						<legend>设立申请书</legend>
							<form method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
							<table width="100%">
							<tr>
								<td class="FieldLabel">社会团体登记证号：</td>
								<td class="FieldInput"><label  field="mainSorgCode"/></td>
								<td class="FieldLabel">社会团体名称：</td>
								<td class="FieldInput" colspan="3"><label id="name"  field="name"/></td>
							</tr>
							<tr>	
								<td class="FieldLabel">住所：</td>
								<td class="FieldInput" colspan="3"><label  id="residence"/></td>
								<td class="FieldLabel" style="width:17%">法定代表人：</td>
								<td class="FieldInput" style="width:17%"><label  field="legalPeople" dataset="resideSourceSelect"/></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%">登记日期：</td>
								<td class="FieldInput" style="width:17%"><label  id="regDate"/></td>
								<td class="FieldLabel">业务主管单位：</td>
								<td class="FieldInput"><label  field="borgName" dataset="businessOrganSelect"/></td>
								<td class="FieldLabel" style="width:17%"><label>分支机构类型：</label></td>
								<td class="FieldInput" style="width:17%"><label  field="sorgKind" dataset="sorgKindSelect"/>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel">拟设立的分支/代表机构名称：</td>
								<td class="FieldInput" colspan="5"><label id="cnName" field="cnName" /></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>拟设立的分支/代表机构办公场所：</label></td>
								<td class="FieldInput" colspan="5"><label  field="residence" /></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%">拟设立的分支/代表机构负责人：</td>
								<td class="FieldInput" style="width:17%"><label  field="branchCharger" /></td>
								<td class="FieldLabel" style="width:17%"><label>拟设立的分支/代表机构电话：</label></td>
								<td class="FieldInput" style="width:17%"><label  field="sorgPhone" /></td>
								<td class="FieldLabel" style="width:17%"><label>拟设立的分支/代表机构邮编：</label></td>
								<td class="FieldInput" style="width:17%"><label  field="sorgPost" /></td>
							</tr>
							<div id="mainSorgId" title="隐藏：主体ID" style="display:none"></div>
						</table>
							</form>
					</fieldset>
					<fieldset>
					<legend>历史处理意见</legend>
					<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:17%">初审意见：</td>
							<td class="FieldInput" style="width:17%">
								<label field="examinOpinionId" name='"初审意见"' style="width:90%" dataset="hisOpinionDataSet" default="0" />
							</td>
							<td class="FieldLabel" style="width:17%">初审承办人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="examinPeopleName" name='初审承办人'  style="width:90%" />
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
								<label field="checkOpinionId" name='"审核意见"' style="width:90%" dataset="hisOpinionDataSet" default="0" />
							</td>
							<td class="FieldLabel" style="width:17%">审核承办人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="checkPeopleName" name='审核承办人' style="width:90%" />
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
							<td class="FieldLabel" style="width:17%">审批意见：</td>
							<td class="FieldInput" style="width:17%">
								<label field="auditOpinionId" name='"审批意见"' style="width:90%" dataset="hisOpinionDataSet" default="0" />
							</td>
							<td class="FieldLabel" style="width:17%">审批承办人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="auditPeopleName" name='审批承办人' style="width:90%" />
							</td>
							<td class="FieldLabel" style="width:17%">审批时间：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='审批时间' field="auditTime" style="width:90%" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">审批补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" name='审批补充意见' field="auditOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
							</td>
						</tr>
					</table>
					</form>
					</fieldset>
						</next:Html>
					</next:Panel>
				</next:Panel>
				<next:Panel title="法律要件">
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
<next:Window id="downloadWin" title="附件列表" closeAction="hide" height="400" width="740"modal="true">
	<next:EditGridPanel id="downloadGrid" width="727" stripeRows="true" height="369" dataset="downloadDataSet" >
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="winClosedownload"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="电子档案ID" field="electronicId" editable="false" hidden="true"><next:TextField /></next:Column>
			<next:Column header="档案目录名"  field="catalogCode" width="280" editable="false" dataset="cataLogCodeSelect" ><next:TextField /></next:Column>
			<next:Column header="附件名称" field="fileName" width="190" editable="false" renderer="winDownloadHref"><next:TextField /></next:Column>
			<next:Column header="附件描述" field="fileMess" width="190" editable="false"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="downloadDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>	
</body>
</html>