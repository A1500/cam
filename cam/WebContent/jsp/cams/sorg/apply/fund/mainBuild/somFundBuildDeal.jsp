<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.comm.util.*,org.loushang.next.skin.SkinUtils"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.loushang.workflow.api.WfQuery" %>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="com.inspur.cams.sorg.apply.fund.cmd.FundBuildCmd"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<html>
<head>
<title>基金会流程</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js") %>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgOnline.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">
<%
	String primaryKey=request.getParameter("primaryKey");
    if(primaryKey==null){
    	primaryKey="";
    }
	String assignmentId=(String)request.getParameter("assignmentId");
	String procDefUniqueId=(String)request.getParameter("procDefUniqueId");
	String actDefUniqueId=(String)request.getParameter("actDefUniqueId");
	String act=(String)request.getParameter("act");
	String method=(String)request.getParameter("method");
	//然调用接口
	//List<Map> list = new WfQuery().getActButtons(actDefUniqueId);
	Map<String, String> m1=new HashMap<String, String>();
		//m1.put("buttonName","保存");
		//m1.put("buttonFunName","saveApply()");
		//m1.put("buttonIMG","add");
	Map<String, String> m2=new HashMap<String, String>();
		m2.put("buttonName","提交");
		m2.put("buttonFunName","send()");
		m2.put("buttonIMG","select");
	Map<String, String> m=new HashMap<String, String>();
		m.put("buttonName","返回");
		m.put("buttonFunName","goBack()");
		m.put("buttonIMG","return");
	List<Map> list=new ArrayList<Map>();
	//list.add(m1);
	list.add(m2);
	list.add(m);
	if(method.equals("yiban")){
		Map<String,String> mm=new HashMap<String,String>();
		mm.put("buttonName","返回");
		mm.put("buttonFunName","goBack()");
		mm.put("buttonIMG","return");
		List<Map> newList=new ArrayList<Map>();
		newList.add(mm);
		list=newList;
	}

	String processId=(String)request.getParameter("processId");
	if(processId == null){
		processId = new FundBuildCmd().getProcessId(assignmentId);
	}
%>
	var processId = '<%=processId%>';
	var procDefUniqueId = '<%=(String)request.getParameter("procDefUniqueId")%>';
	var assignmentId="<%=assignmentId%>";
	var currentUserName = '<%=GetBspInfo.getBspInfo().getUserName()%>';
	var actDefUniqueId ="<%=actDefUniqueId%>";
	var method = '<%=(String)request.getParameter("method")%>';
	var taskCode='';
	var sorgId = "";
	var act='<%=act%>';
	var somApplyType = "201";
	var applyType = "219,220";
</script>
<script type="text/javascript">
var fetchPeople='';//领证人
var fetchDate='';//领证日期
var fetchPhone='';//领证人联系电话
var PrintDate='';//发证日期
var beginDate='';//有效期限起
var endDate='';//有效期限止
var issueReasonDesc='';//发证原因描述
var legalRecord="";
var legalDuties="00012";
//初始化
function init(){
	L5.getCmp("tab").setActiveTab("6");
	L5.getCmp("tab").setActiveTab("5");
	L5.getCmp("tab").setActiveTab("4");
	L5.getCmp("tab").setActiveTab("3");
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("1");
	L5.getCmp("tab").setActiveTab("0");
	//流程意见
	somApplyDataSet.setParameter("PROCESS_ID@=",processId);
	somApplyDataSet.load();
	somApplyDataSet.on('load',loadInfo);
	if(method=='yiban'){
		var tab=L5.getCmp("tab");
		var ipinionPanel=L5.getCmp("ipinionPanel");
		tab.remove(ipinionPanel);
	}
	//过滤意见枚举，去掉补齐补正
	if(act == 'examin' || act == 'check' || act == 'audit' ){
	}else{
		opinionSelect.filterBy(function(record, id){
			if("1".indexOf(record.get('value')) > -1  || "0".indexOf(record.get('value')) > -1){
				return record;
			}
		});
	}
	//过滤流程意见
	if(act=='print' || act=='issue'){
		opinionSelect.filterBy(function(record, id){
			if("1".indexOf(record.get('value'))>-1){
				return record;
			}
		});
	}
	if(act=='issue'){
		applyType="219,220,221";
		//电子档案上传窗口关闭事件
		var win=L5.getCmp("uploadList");
		win.on("hide",function(el){
			somElectronicDataSet_load();
		});
	}
}
//加载社会组织
function loadInfo(ds){
	ds.un("load",loadInfo);
	somApplyDataSet.set("curActivity", getActDefName());
	somApplyDataSet.set("curOpinionId", "1");
	//现场勘查
	if(act=='watch' && method!='yiban'){
		$("watchInfo1").style.display="block";
		$("watchInfo2").style.display="block";
		$("prospectAttendPeople").value=somApplyDataSet.get("prospectAttendPeople");
		$("prospectPlace").value=somApplyDataSet.get("prospectPlace");
		$("prospectDate").value=somApplyDataSet.get("prospectDate");
		somApplyDataSet.set("prospectAttendPeople","");
		somApplyDataSet.set("prospectPlace","");
		somApplyDataSet.set("prospectDate","");
	}
	sorgId = somApplyDataSet.get('sorgId');
	taskCode = somApplyDataSet.get('taskCode');
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on("load",loadaspChief);
	//过滤流程意见
	if(act=='print'){
		opinionSelect.filterBy(function(record, id){
			if(count == 1){
				if("1".indexOf(record.get('value'))>-1){
					return record;
				}
			}else{
				if("0".indexOf(record.get('value'))>-1){
					return record;
				}
			}
		});
	}
}
//加载拟任法定代表人
function loadaspChief(ds){
	ds.un("load",loadaspChief);
	if(typeof businessOrganSelectDic !="undefined"){
		var borgName = somOrganDataSet.get('borgName');
		var records = businessOrganSelectDic.query("value",borgName);
		if(records.length>0){
			var borgCode = records.items[0].get("text");
			document.getElementById("borgName").value = borgName;
			document.getElementById("borgNameDispaly").value = borgCode;
		}
	}
	aspChiefDataset.setParameter("SORG_ID@=", sorgId);
	aspChiefDataset.setParameter("SORG_DUTIES", "00012");
	aspChiefDataset.load();
	aspChiefDataset.on('load',loadsomHeldPeople);
}
//加载发起人
function loadsomHeldPeople(ds){
	ds.un("load",loadsomHeldPeople);
	somHeldPeopleDataSet.setParameter("TASK_CODE@=", taskCode);
	somHeldPeopleDataSet.load();
	somHeldPeopleDataSet.on('load',loadsomHeldOrgan);
}
//加载发起单位
function loadsomHeldOrgan(ds){
	ds.un("load",loadsomHeldOrgan);
	somHeldOrganDataSet.setParameter("TASK_CODE@=", taskCode);
	somHeldOrganDataSet.load();
	somHeldOrganDataSet.on('load',loadsomSession);
}
//加载届次
function loadsomSession(ds){
	ds.un("load",loadsomSession);
	somSessionDataSet.setParameter("TASK_CODE", taskCode);
	somSessionDataSet.load();
	somSessionDataSet.on('load',loadaspForLiShi);
}
//加载理事
function loadaspForLiShi(ds){
	ds.un("load",loadaspForLiShi);
	if(somSessionDataSet.getCount() == 0){
		somSessionDataSet.newRecord();
	}
	aspForLiShi.setParameter("TASK_CODE", taskCode);
	aspForLiShi.setParameter("SORG_DUTIES@in", "00001,00003,00004,00005,00013");
	aspForLiShi.load();
	aspForLiShi.on('load',loadaspForJianShi);
}
//加载监事
function loadaspForJianShi(ds){
	ds.un("load",loadaspForJianShi);
	aspForJianShi.setParameter("TASK_CODE", taskCode);
	aspForJianShi.setParameter("SORG_DUTIES", "00006");
	aspForJianShi.load();
	aspForJianShi.on('load',loadResume);
}
//加载简历
function loadResume(ds){
	ds.un("load",loadResume);
	somResumeInsertDataSet.setParameter("TASK_CODE", taskCode);
	somResumeInsertDataSet.load();
	somResumeInsertDataSet.on('load',loadFlow);
}
//加载意见
function loadFlow(ds){
	ds.un("load",loadFlow);
	somFlowDataSet.setParameter("TASK_CODE@=", taskCode);
	somFlowDataSet.load();
	somFlowDataSet.on('load',loadElectronic);
}
//加载文件
function loadElectronic(ds){
	ds.un("load",loadElectronic);
	somElectronicDataSet_load();
}

//点击增加上传附件按钮
function clickUploadFile(){
	uploadFile();
}

//保存
function saveApply(){
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	if(somApplyDataSetIsValidate != true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tab").setActiveTab("2");
		return false;
	}
	//业务意见
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBuildCmd");
	var somApplyRecord = somApplyDataSet.getCurrent();
	if(act=="watch"){
		somApplyRecord.set("prospectAttendPeople",_$("prospectAttendPeople"));
		somApplyRecord.set("prospectPlace",_$("prospectPlace"));
		somApplyRecord.set("prospectDate",_$("prospectDate"));
	}
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
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	if(somApplyDataSetIsValidate != true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tab").setActiveTab("2");
		return false;
	}
	if(act=='issue'){
		if(fetchPeople=='' || fetchDate==''||fetchPhone==''){
			L5.Msg.alert("提示","请先填写领证信息！");
			return false;
		}
	}
	//业务意见
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBuildCmd");
	var somApplyRecord = somApplyDataSet.getCurrent();
	if(act=="watch"){
		somApplyRecord.set("prospectAttendPeople",_$("prospectAttendPeople"));
		somApplyRecord.set("prospectPlace",_$("prospectPlace"));
		somApplyRecord.set("prospectDate",_$("prospectDate"));
	}
	command.setParameter("fetchPeople", fetchPeople);
	command.setParameter("fetchDate", fetchDate);
	command.setParameter("fetchPhone", fetchPhone);
	command.setParameter("somApplyRecord",somApplyRecord);
	//保存并提交
	command.execute("send");
	if (!command.error) {
		L5.Msg.alert("提示","成功提交至下一环节!",function(){
			if(act == 'audit'){
				if(somApplyRecord.get("curOpinionId")=="1"){ //同意-批准通过-根据taskCode更改外网业务状态
					updateOnlineStatusPass(somApplyRecord.get("taskCode"));
				}
				if(somApplyRecord.get("curOpinionId")=="0"){ //不同意-批准不通过-根据taskCode更改外网业务状态
					updateOnlineStatusNoPass(somApplyRecord.get("taskCode"));
				}
			}
			goBack();
		});
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
//返回
function goBack(){
	history.go(-1);
}
//打印不予受理通知
function printNoAccept(){
	var url=L5.webPath+"/jsp/cams/sorg/comm/print/noAcceptForPrint.jsp";
	window.open(url);
}
//打印受理通知
function printAccept(){
	var url=L5.webPath+"/jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=J";
	window.open(url);
}
//弹出打印证书窗口
function printCert(){
	var win=L5.getCmp("forPrint");
	win.show();
}
//打印证书
function forCertType(){
	var certType=_$('certType');
	endDate=_$('endDate');
	beginDate=_$('beginDate');
	PrintDate=_$('PrintDate');
	issueReasonDesc=_$('issueReasonDesc');
	if(certType!='' && endDate!='' && beginDate!='' && PrintDate!=''){
		var url=L5.webPath+"/jsp/cams/sorg/comm/print/fundBuildForPrint.jsp?id="+sorgId+"&PrintDate="+PrintDate+"&beginDate="+beginDate+"&endDate="+endDate+"&certType="+certType;
		PostNewWin(url);
	}else{
		L5.Msg.alert('提示',"填入所需数据！");
		return;
	}
	if(certType == '0'){

	}else if(certType == '1'){

	}
}
function forCertTypeClose(){
	var win = L5.getCmp("forPrint");
	win.hide();
}
//打印证书环节提交
function sendForPrint(){
	if(endDate=='' || beginDate=='' || PrintDate==''){
		L5.Msg.alert("提示","请先打印证书!");
		return;
	}
	if(fetchPeople=='' || fetchDate=='' ||fetchPhone==''){
		L5.Msg.alert("提示","请先填写领证信息！");
		return false;
	}
	var somApplyDataSet = L5.DatasetMgr.lookup("somApplyDataSet");
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	var somApplyRecord = somApplyDataSet.getCurrent();
	if(somApplyDataSetIsValidate != true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBuildCmd");
	command.setParameter("certType", _$("certType"));
	command.setParameter("endDate", endDate);
	command.setParameter("beginDate", beginDate);
	command.setParameter("PrintDate", PrintDate);
	command.setParameter("issueReasonDesc", issueReasonDesc);
	command.setParameter("somApplyRecord", somApplyRecord);
	command.setParameter("fetchPeople", fetchPeople);
	command.setParameter("fetchDate", fetchDate);
	command.setParameter("fetchPhone", fetchPhone);
	command.execute("printForSend");
	if (!command.error) {
		L5.Msg.alert("提示","成功提交至下一环节!",function(){
			window.history.go(-1);
		});
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
//填写领证信息
function choseIssuePeople(){
	var win=L5.getCmp('forchoseIssuePeople');
	win.show();
}
//填写领证信息里面的确认按钮
function buttonForFetch(){
	fetchPeople=document.getElementById('fetchPeople').value;
	fetchDate=document.getElementById('fetchDate').value;
	fetchPhone=document.getElementById('fetchPhone').value;
	if(fetchPeople==''){
		L5.Msg.alert('提示',"领证人不能为空！");return;
	}else if(fetchDate==''){
		L5.Msg.alert('提示',"领证日期不能为空！");return;
	}else if(fetchPhone==''){
		L5.Msg.alert('提示',"领证人联系电话不能为空！");return;
	}
	var win=L5.getCmp('forchoseIssuePeople');
	win.hide();
}
function getActDefName(){
	if(act=='auditReport'){
		return "名称核准";
	}else if(act=='accept'){
		return "受理";
	}else if(act=='watch'){
		return "现场勘查";
	}else if(act=='examin'){
		return "初审";
	}else if(act=='check'){
		return "审核";
	}else if(act=='audit'){
		return "批准";
	}else if(act=='print'){
		return "打印证书";
	}else if(act=='inform'){
		return "通知申请人";
	}else if(act=='issue'){
		return "发证";
	}else if(act=='supply'){
		return "补齐补正";
	}
}
function updateL(){
	var grid=L5.getCmp("peopleGrid");
	currentPeople=grid.getSelectionModel().getSelected();
	if(!currentPeople){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	currentId=currentPeople.get('id');
	initDutyL();
	peopleInsertDataset.removeAll();
	var record=peopleInsertDataset.newRecord();
	peopleInsertDataset.remove(record);
	peopleInsertDataset.insert(0,currentPeople.copy());

	somResumeInsertDataSet.filterBy(function(record, id){
		if(record.get('dutyId') == currentPeople.get('id')){
			return record;
		}
	});

	L5.getCmp("peopleWin").show();
	peopleType='LU';
	ifLegalShow();
}
function ifLegalShow(){
	$("ifLegalLabel").style.display = "";
	$("ifLegalInput").style.display = "";
	$("ifFulltime").colSpan = "1";
}
function updateS(){
	var grid=L5.getCmp("peopleGrid1");
	currentPeople=grid.getSelectionModel().getSelected();
	if(!currentPeople){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	initDutyS();
	currentId=currentPeople.get('id');
	peopleInsertDataset.removeAll();
	var record=peopleInsertDataset.newRecord();
	peopleInsertDataset.remove(record);
	peopleInsertDataset.insert(0,currentPeople.copy());

	somResumeInsertDataSet.filterBy(function(record, id){
		if(record.get('dutyId') == currentPeople.get('id')){
			return record;
		}
	});

	L5.getCmp("peopleWin").show();
	peopleType='SU';
	ifLegalHide();
}

function ifLegalHide(){
	$("ifLegalLabel").style.display = "none";
	$("ifLegalInput").style.display = "none";
	$("ifFulltime").colSpan = "3";
}
function closeWin(){
	L5.getCmp("peopleWin").setVisible(false);
}

function countRender(value){
	var count = aspForLiShi.getTotalCount();
	if(count === undefined){
		count=0;
	}
	return "理事总人数: "+count+" 人";

}
function countRenderS(value){
	var count = aspForJianShi.getTotalCount();
	if(count === undefined){
		count=0;
	}
	return "监事总人数: "+count+" 人";

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
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<model:dataset id="somFlowDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" global="true" sortField="COMMIT_TIME" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<!-- 届次信息 -->
	<model:dataset id="somSessionDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession"></model:record>
	</model:dataset>
	<!-- 发起人 -->
	<model:dataset id="somHeldPeopleDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomHeldPeopleQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldPeople">
			<model:field name="ifChief" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 监事备案 -->
	<model:dataset id="aspForJianShi" cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief">
			<model:field name="name" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 理事备案 -->
	<model:dataset id="aspForLiShi" cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief">
			<model:field name="name" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 理事备案 -->
	<model:dataset id="peopleInsertDataset" cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief"></model:record>
	</model:dataset>
	<!-- 人员简历 -->
	<model:dataset id="somResumeInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<!-- 发起组织 -->
	<model:dataset id="somHeldOrganDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomHeldOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldOrgan"></model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog" isGroup="true" groupField="applyType" pageSize="50">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
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
	<%--流程处理--%>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<%--业务意见信息验证--%>
			<model:field name="curOpinionId" type="string" rule="require"/>
		    <model:field name="curOpinion" type="string" rule="length{200}"/>
		    <model:field name="prospectAttendPeople" type="string" rule="length{200}"/>
		    <model:field name="prospectPlace" type="string" rule="length{300}"/>
		</model:record>
	</model:dataset>
	<%--流程历史意见--%>
	<model:dataset id="somFlowListDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" global="true" sortField="COMMIT_TIME">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<model:dataset id="aspChiefDataset" cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief"></model:record>
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
			<model:param name="dic" value='DIC_FUND_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="politicsDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
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
	<model:dataset id="ifFulltimeDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="folkDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
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
	<!-- 证件类型 -->
	<model:dataset id="cardTypeDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CARD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="countrySelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="SORT_NO">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_COUNTRY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="workFlowOpinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
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
			<next:Panel title="基金会设立申请表" width="100%">
				<next:Panel width="100%" height="100%" id="tab1" autoScroll="true">
					<next:Html>
						<fieldset><legend>基金会设立申请表</legend>
						<form method="post" dataset="somOrganDataSet"
							onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width: 17%">名称：</td>
								<td class="FieldInput" colspan="3"><label field="cnName" /></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">住所：</td>
								<td class="FieldInput" colspan="3"><label field="residence" /></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">电话：</td>
								<td class="FieldInput" style="width: 17%"><label field="sorgPhone" /></td>
								<td class="FieldLabel" style="width: 17%">邮编：</td>
								<td class="FieldInput" style="width: 17%"><label field="sorgPost" /></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">原始基金币种：</td>
								<td class="FieldInput" style="width: 17%"><label field="currency" /></td>
								<td class="FieldLabel">类型：</td>
								<td class="FieldInput"><label field="sorgKind" dataset="sorgKindSelect"/></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">原始基金数额（大写数字）：</td>
								<td class="FieldInput" colspan="3"><textarea rows="3" field="regMon" name='"原始基金数额"' style="width:85%;background-color:#F5FAFA;border:0;overflow:auto;"readonly></textarea>万元</td>


							</tr>
							<tr>
								<td class="FieldLabel">宗旨：</td>
								<td class="FieldInput" colspan="3"><textarea rows="5"style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly
									name="宗旨" field="purpose"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel">业务范围：</td>
								<td class="FieldInput" colspan="3"><textarea rows="5"style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly
									name="业务范围" field="business"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel">申请理由：</td>
								<td class="FieldInput" colspan="3"><textarea rows="5"style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly
									name="申请理由" field="appReason"></textarea></td>
							</tr>
						</table>
						</form>
						</fieldset>

						<fieldset><legend>业务主管单位审查意见</legend>
						<form id="form2" method="post" dataset="somApplyDataSet"
							onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel">业务主管单位审查意见：</td>
								<td class="FieldInput" colspan="3"><textarea style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly
									field="borgOpinion" cols="65" rows="2" ></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">业务主管单位：</td>
								<td class="FieldInput" style="width: 17%"><label field="borgName" dataset="businessOrganSelect"/></td>
								<td class="FieldLabel" style="width: 17%">业务主管单位审查日期：</td>
								<td class="FieldInput" style="width: 17%"><label field="borgCheckDate" /></td>
							</tr>
						</table>
						</form>
						</fieldset>
						<fieldset>
					<legend>拟任法定代表人情况</legend>
						<form method="post" dataset="aspChiefDataset" onsubmit="return false" class="L5form" style="border-width:0px">
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:17%">姓名：</td>
							<td class="FieldInput" style="width:17%"><label field="name"/></td>
							<td class="FieldLabel" style="width:17%">性别：</td>
							<td class="FieldInput" style="width:17%"><label field="sex" dataset="sexSelect"/></td>
							<td class="FieldLabel" style="width:17%">出生年月：</td>
							<td class="FieldInput" style="width:17%"><label field="birthday"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" >工作单位：</td>
							<td class="FieldInput" colspan="3"><label field="workName"/></td>
							<td class="FieldLabel" style="width:17%" >工作单位职务：</td>
							<td class="FieldInput" style="width:17%"><label field="workDuties"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">联系电话：</td>
							<td class="FieldInput" colspan="3"><label field="phone"/></td>
							<td class="FieldLabel" style="width:17%">有无担任其他组织法人：</td>
							<td class="FieldInput" style="width:17%"><label field="otherDuties"/></td>
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
		<next:Panel title="发起人情况">
				<next:EditGridPanel id="heldPeopleGrid"
					dataset="somHeldPeopleDataSet" width="100%" stripeRows="true"
					height="100%">
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="id" width="15%" editable="false"
							hidden="true">
							<next:TextField />
						</next:Column>
						<next:Column header="身份证号" field="idCard" width="20%" editable="false"><next:TextField/></next:Column>
						<next:Column header="姓名" field="name" width="10%" editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:DateField format="Y-m"></next:DateField></next:Column>
						<next:Column header="工作单位" field="workName" width="25%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="工作单位职务" field="workDuties" width="15%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="联系电话" field="phone" width="20%"
							editable="false">
							<next:TextField />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somHeldPeopleDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="发起单位情况">
				<next:EditGridPanel id="heldOrganGrid" dataset="somHeldOrganDataSet"
					width="100%" stripeRows="true" height="100%">
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="id" width="15%" editable="false"
							hidden="true">
							<next:TextField />
						</next:Column>
						<next:Column header="发起单位名称" field="name" width="40%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="发起单位主要负责人" field="heldorganPeople"
							width="25%" editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="联系电话" field="phone" width="20%"
							editable="false">
							<next:TextField />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somHeldOrganDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
	<next:Panel title="基金会理事、监事备案申请表" autoScroll="true">
	<next:Panel>
	<next:Html>
	<fieldset>
		<legend>基金会信息</legend>
		<form onsubmit="return false" class="L5form" dataset="somSessionDataSet">
			<table width="100%">
				<tr>
					<td class="FieldLabel">届次名称：</td>
					<td class="FieldInput" colspan="3"><label field="sessionName" /></td>
					<td class="FieldLabel" style="width:17%">本届任期（年）：</td>
					<td class="FieldInput" style="width:17%"><label field="tenure" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:17%">本届开始日期：</td>
					<td class="FieldInput" style="width:17%"><label field="startDate" /></td>
					<td class="FieldLabel" style="width:17%">规定换届日期：</td>
					<td class="FieldInput" style="width:15%"><label field="endDate" /></td>
					<td class="FieldLabel" style="width:17%"></td>
					<td class="FieldInput" style="width:17%"></td>
				</tr>
			</table>
		</form>
		</fieldset>
	</next:Html>
</next:Panel>
<next:Panel height="300" >
<next:EditGridPanel id="peopleGrid" dataset="aspForLiShi"  stripeRows="true" height="99.9%" title="理事备案申请表" hasSum="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="查看" handler="updateL"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column header="证件类型" field="cardType" width="10%" editable="false" summaryType="count">
			<next:ExtendConfig>
				summaryRenderer : countRender
			</next:ExtendConfig>

		<next:ComboBox dataset="cardTypeDS"/></next:Column>
		<next:Column header="证件编号" field="idCard" width="20%" editable="false"><next:TextField/></next:Column>
		<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
		<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexSelect"/></next:Column>
		<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
		<next:Column header="拟任职务" field="sorgDuties" width="10%" editable="false"><next:ComboBox dataset="sorgDutiesSelect"/></next:Column>
		<next:Column header="是否是拟任法定代表人" field="ifLegal" width="15%" editable="false"><next:ComboBox dataset="yesornoDataSet"></next:ComboBox></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="aspForLiShi"/>
	</next:BottomBar>
</next:EditGridPanel>
</next:Panel>
<next:Panel height="250" >
<next:EditGridPanel id="peopleGrid1" dataset="aspForJianShi"  stripeRows="true" height="99.9%" title="监事备案申请表" hasSum="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="查看" handler="updateS"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column header="证件类型" field="cardType" width="10%" editable="false" summaryType="count">
			<next:ExtendConfig>
				summaryRenderer : countRenderS
			</next:ExtendConfig>
		<next:ComboBox dataset="cardTypeDS"/></next:Column>
		<next:Column header="证件编号" field="idCard" width="20%" editable="false"><next:TextField/></next:Column>
		<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
		<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexSelect"/></next:Column>
		<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
		<next:Column header="拟任职务" field="sorgDuties" width="10%" editable="false"><next:ComboBox dataset="sorgDutiesSelect"/></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="aspForJianShi"/>
	</next:BottomBar>
</next:EditGridPanel>
</next:Panel>
			</next:Panel>

			<next:Panel title="法律要件">
					<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
						<next:GroupingView forceFit="true"></next:GroupingView>
						<next:TopBar>
							<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<%if("issue".equals(act)){ %>
							<next:ToolBarItem iconCls="add" text="增加上传附件" handler="clickUploadFile"></next:ToolBarItem>
							<%} %>
						</next:TopBar>

						<next:Columns>
							<next:RowNumberColumn />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column header="档案目录名"  field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect" ><next:TextField /></next:Column>
							<next:Column header="附件名称"    field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
							<next:Column header="附件描述"    field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
							<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
							<next:Column header="业务类型"    field="applyType" hidden="true">
								<next:ExtendConfig>
									groupRenderer:grender,groupName:"法律要件目录"
								</next:ExtendConfig>
							</next:Column>
						</next:Columns>
						<next:BottomBar>
							<next:PagingToolBar dataset="somElectronicDataSet" />
						</next:BottomBar>
				    </next:EditGridPanel>
			</next:Panel>

			<next:Panel title="流程历史意见">
				<next:EditGridPanel id="somFlowGrid" dataset="somFlowDataSet" width="100%" stripeRows="true" height="100%">
					<next:Columns>
						<next:RowNumberColumn/>
						<next:Column header="处理环节" field="activity" width="13%" editable="false"><next:TextField/></next:Column>
						<next:Column header="处理单位" field="organId" width="13%" editable="false"><next:ComboBox dataset="pubOrganDataSet"/></next:Column>
						<next:Column header="处理部门" field="deptId" width="13%" editable="false"><next:ComboBox dataset="pubOrganDataSet"/></next:Column>
						<next:Column header="处理人"    field="actorId" width="10%" editable="false"><next:ComboBox dataset="pubOrganDataSet"/></next:Column>
						<next:Column header="处理时间" field="commitTime" width="18%" editable="false"><next:TextField/></next:Column>
						<next:Column header="意见"      field="opinionId" width="10%" editable="false"><next:ComboBox dataset="hisOpinionDataSet"/></next:Column>
						<next:Column header="补充意见" field="opinion" width="40%" editable="false"><next:TextField/></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somFlowDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>

			<next:Panel title="处理意见" id="ipinionPanel">
				<next:Html>
					<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form">
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:13%">处理意见：</td>
							<td class="FieldInput" colspan="5">
								<select field="curOpinionId" name='"处理意见"' style="width:150px" default="0">
									<option dataset="opinionSelect"></option>
								</select><span style="color:red">*</span>
							</td>
						</tr>
						<tr id="watchInfo1" style="display:none">
							<td class="FieldLabel" style="width:13%">现场勘查双方参加人员：</td>
							<td class="FieldInput" colspan="5"><input type="text"  id="prospectAttendPeople" name='"现场勘查双方参加人员"' style="width:98%"/></td>
						</tr>
						<tr id="watchInfo2" style="display:none">
							<td class="FieldLabel" style="width:13%">现场勘查地点：</td>
							<td class="FieldInput" colspan="3"><input type="text" id="prospectPlace" name='现场勘查地点'  style="width:90%" /></td>
							<td class="FieldLabel" style="width:13%">现场勘查日期：</td>
							<td class="FieldInput" style="width:17%"><input type="text" id="prospectDate" name='现场勘查日期' format="Y-m-d" onclick="WdatePicker()" style="width:90%" /></td>
						</tr>
						<tr>
							<td class="FieldLabel">处理补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="10" name='"处理补充意见"' field="curOpinion" style="width:98%"></textarea></td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>

<next:Window id="forchoseIssuePeople" closeAction="hide" title="填写领证信息" width="500"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="填写领证信息"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="detail" handler="buttonForFetch"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:15%"><label>领证人：</label></td>
					<td class="FieldInput"style="width:15%"><input type="text" id="fetchPeople"/></td>
					<td class="FieldLabel" style="width:15%"><label>领证日期：</label></td>
					<td class="FieldInput"style="width:15%"><input type="text" id="fetchDate"  style="width:100%" format="Y-m-d" onclick="WdatePicker();" ></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%"><label>领证人联系电话：</label></td>
					<td class="FieldInput"style="width:15%" colspan="3"><input type="text" id="fetchPhone"/></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<next:Window id="forPrint" closeAction="hide" title="打印证书" width="500"  autoScroll="true">
<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="打印证书"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="detail" handler="forCertType"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="forCertTypeClose"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:15%"><label>选择证书类型：</label></td>
					<td class="FieldInput"style="width:15%"><select id="certType" ><option dataset="certTypeSelect" ></option></select></td>
					<td class="FieldLabel" style="width:15%"><label>发证日期：</label></td>
					<td class="FieldInput"style="width:15%"><input type="text" id="PrintDate"  style="width:100%" format="Y-m-d" onclick="WdatePicker();" ></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%"><label>有效期限起：</label></td>
					<td class="FieldInput"style="width:15%"><input type="text" id="beginDate"  style="width:100%" format="Y-m-d" onclick="WdatePicker();" ></td>
					<td class="FieldLabel" style="width:15%"><label>有效期限止：</label></td>
					<td class="FieldInput"style="width:15%"><input type="text" id="endDate"  style="width:100%" format="Y-m-d" onclick="WdatePicker();" ></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%"><label>发证原因描述：</label></td>
					<td class="FieldInput"style="width:15%" rowspan="2" colspan="3"><textarea id="issueReasonDesc"  style="width:100%" ></textarea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<next:Window id="downloadWin" closeAction="hide" height="400" width="740" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="winClosedownload"></next:ToolBarItem>
	</next:TopBar>
	<next:EditGridPanel id="downloadGrid" width="725" stripeRows="true" height="360" dataset="downloadDataSet" >
		<next:Columns>
			<next:RowNumberColumn/>
			<next:Column header="电子档案ID" field="electronicId" editable="false" hidden="true"></next:Column>
			<next:Column header="档案目录名"  field="catalogCode" width="335" editable="false" dataset="cataLogCodeSelect" ><next:TextField /></next:Column>
			<next:Column header="附件名称" field="fileName" width="180" editable="false" renderer="winDownloadHref"></next:Column>
			<next:Column header="文件描述" field="fileMess" width="180" editable="false"></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="downloadDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
<!-- 人员备案申请表 -->
<next:Window id="peopleWin"title="人员备案表"resizable="false" width="800" height="400" modal="true" closeAction="hide" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="人员备案表"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
	<next:Panel id="peoplePanel">
		<next:Html>
			<form id="peopleFrom" method="post" dataset="peopleInsertDataset" onsubmit="return false" class="L5form">

				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width:15%">姓名：</td>
						<td class="FieldInput"  style="width:15%"><label  field="name"/></td>
						<td class="FieldLabel" style="width:15%">性别：</td>
						<td class="FieldInput" style="width:15%"><label  field="sex" dataset="sexSelect"/></td>
						<td class="FieldLabel" style="width:15%">出生年月：</td>
						<td class="FieldInput" style="width:15%"><label  field="birthday"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">政治面貌：</td>
						<td class="FieldInput"><label  field="politics" dataset="politicsDataSet"/></td>
						<td class="FieldLabel" style="width:15%">民族：</td>
						<td class="FieldInput" style="width:15%"><label  field="folk" dataset="folkDataSet"/></td>
						<td class="FieldLabel" style="width:15%">国籍：</td>
						<td class="FieldInput" style="width:15%"><label  field="citizenship" dataset="countrySelect"/></td>

					</tr>
					<tr>
						<td class="FieldLabel">证件类型：</td>
						<td class="FieldInput"><label  field="cardType" dataset="cardTypeDS"/></td>
						<td class="FieldLabel" style="width:15%">证件编号：</td>
						<td class="FieldInput" style="width:21%"colspan="3"><label  field="idCard"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">邮编：</td>
						<td class="FieldInput"><label  field="postCode"/></td>
						<td class="FieldLabel">家庭住址：</td>
						<td class="FieldInput"colspan="3"><label  field="populace"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">拟任职务：</td>
						<td class="FieldInput"><label  field="sorgDuties" dataset="sorgDutiesDataSet"/></td>
						<td class="FieldLabel" id="ifLegalLabel">是否是拟任法定代表人：</td>
						<td class="FieldInput" id="ifLegalInput"><label  field="ifLegal" dataset="comm_yesorno"/>
						</td>
						<td class="FieldLabel" id="ifFulltime">专职/兼职：</td>
						<td class="FieldInput"><label  field="ifFulltime" dataset="ifFulltimeDataSet"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">联系电话：</td>
						<td class="FieldInput"><label  field="phone"/></td>
						<td class="FieldLabel">其他社会职务：</td>
						<td class="FieldInput" colspan="3"><label  field="otherDuties"/></td>
					</tr>
				</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:EditGridPanel id="somResumeGrid" dataset="somResumeInsertDataSet" width="765" stripeRows="true" height="250" title="本人简历">
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="开始年月" field="startDate" width="10%" editable="false" ><next:DateField format="Y-m-d"></next:DateField></next:Column>
			<next:Column header="结束年月" field="endDate" width="10%" editable="false"><next:DateField format="Y-m-d"></next:DateField></next:Column>
			<next:Column header="在何地区何单位" field="workOrgan" width="45%" editable="false"><next:TextField/></next:Column>
			<next:Column header="任（兼）何职" field="duty" width="20%" editable="false"><next:TextField/></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="somResumeInsertDataSet"/>
		</next:BottomBar>
	</next:EditGridPanel>
	<next:Buttons>
		<next:ToolButton text="关闭" handler="closeWin"></next:ToolButton>
	</next:Buttons>
</next:Window>
<jsp:include page="../../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>