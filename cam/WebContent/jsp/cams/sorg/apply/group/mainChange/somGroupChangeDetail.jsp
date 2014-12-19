<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@page import="org.loushang.workflow.api.WfQuery"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.lang.StringBuffer"%>
<%@page import="com.inspur.cams.sorg.apply.group.cmd.GroupChangeCmd"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<!-- 社会团体主体变更流程页面 -->
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js") %>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgOnline.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script>
	<%
		String primaryKey=request.getParameter("primaryKey");
	    if(primaryKey==null)
	    	{
	    	primaryKey="";
	    	}
	%>
	<%
		String assignmentId=(String)request.getParameter("assignmentId");
		String actDefUniqueId=(String)request.getParameter("actDefUniqueId");
		//然调用接口
		List<Map> list = new WfQuery().getActButtons(actDefUniqueId);
		String processId=(String)request.getParameter("processId");
		if(processId==null){
			processId=new GroupChangeCmd().getProcessId(assignmentId);
		}
		String ifFinish=new GroupChangeCmd().getSomApplyByProcessId(processId);
		String method=(String)request.getParameter("method");
		if("1".equals(ifFinish) || "yiban".equals(method)){
			Map<String, String> m=new HashMap<String, String>();
			m.put("buttonName","返回");
			m.put("buttonFunName","goBack()");
			m.put("buttonIMG","return");
			List<Map> newList=new ArrayList<Map>();
			newList.add(m);
			list=newList;
		}
		String actname=(String)request.getParameter("actname");
	%>
	var processId = '<%= processId%>';
	var procDefUniqueId = '<%= (String)request.getParameter("procDefUniqueId")%>';
	var assignmentId="<%=assignmentId%>";
	var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
	var actDefUniqueId ="<%=actDefUniqueId%>";
	var actname='<%=actname%>';
	var mothod='<%=method%>';
</script>

<script type="text/javascript">
var somApplyType='003';
var applyType='020';
var fileCodeF="S028";
var legalDutyId='';
var taskCode='';
var cnName='';
var sorgId='';
var organCode='';
var changeNUM='';
var sorgRecord='';
var PrintDate='';
var endDate='';
var beginDate='';
var issueReasonDesc='';
var catalogName='';//档案目录名
var fetchPeople='';//领证人
var fetchDate='';//领证日期
var fetchPhone='';//领证人联系电话
var end=false;
var business='';//打印用业务范围
function init(){
	L5.getCmp("tab").setActiveTab("3");
	L5.getCmp("tab").setActiveTab("0");
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	somApplyDataSet.setParameter("PROCESS_ID@=",processId);
	somApplyDataSet.load();//社会团体
	somApplyDataSet.on('load',funAdd);

	var opinionSelect=L5.DatasetMgr.lookup("opinionSelect");
	//过滤意见枚举，去掉补齐补正
	if(actname == 'examin' || actname == 'check' || actname == 'audit' ){
	}else{
		opinionSelect.filterBy(function(record, id){
			if("1".indexOf(record.get('value')) > -1  || "0".indexOf(record.get('value')) > -1){
				return record;
			}
		});
	}
	if(actname=='print' || actname=='issue'){
		opinionSelect.filterBy(function(record, id){
			if("1".indexOf(record.get('value'))>-1){
				return record;
			}
		});
	}
	if(mothod == "yiban" || mothod == "end"){
		var tab=L5.getCmp("tab");
		var ipinionPanel=L5.getCmp("ipinionPanel");
		tab.remove(ipinionPanel);
	}

}
function funAdd(somApplyDataSet){
	sorgRecord= somApplyDataSet.getCurrent();
	taskCode=sorgRecord.get('taskCode');

	cnName=sorgRecord.get('sorgName');
	sorgId=sorgRecord.get('sorgId');
	somOrganDataSet.setParameter("SORG_ID",sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on('load',function(){
		var somOrganRecord = somOrganDataSet.getCurrent();
		organCode = somOrganRecord.get('organCode');
	});
	document.getElementById('cnName').innerHTML=cnName;
	document.getElementById('changeDate').innerHTML=sorgRecord.get('appDate');

	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.setParameter("TASK_CODE@=",taskCode);
	somChangeList.load();//变更
	somChangeList.on('load',forShow);

	var somFlowDataset=L5.DatasetMgr.lookup("somFlowDataset");
	somFlowDataset.setParameter("TASK_CODE@=",taskCode);
	somFlowDataset.load();

	var somFlowAddDataset=L5.DatasetMgr.lookup("somFlowAddDataset");
	somFlowAddDataset.setParameter("TASK_CODE@=",taskCode);
	somFlowAddDataset.load();
	somFlowAddDataset.on('load',function (){
		somFlowAddDataset.getCurrent().set('curOpinionId',"1");
		if(actname=='inform'){//是通知受理人
			var somFlowQuery=L5.DatasetMgr.lookup("somFlowQuery");
			somFlowQuery.setParameter("TASK_CODE@=",taskCode);
			somFlowQuery.setParameter("ACTIVITY@=","批准");
			somFlowQuery.setParameter("OPINION_ID@=","1");
			somFlowQuery.load();
			somFlowQuery.on('load',function (ds){
				if(ds.getCount()==0){
					somFlowAddDataset.getCurrent().set("curOpinionId","0");
					document.getElementById("curOpinionId").disabled="disabled";
					end=true;
				}else if(ds.getCount()==1){
					somFlowAddDataset.getCurrent().set("curOpinionId","1");
					document.getElementById("curOpinionId").disabled="disabled";
				}
			});
		}

	});

	var legalPeopleDataSet=L5.DatasetMgr.lookup("legalPeopleDataSet");
	legalPeopleDataSet.setParameter("TASK_CODE",taskCode);
	legalPeopleDataSet.load();
	legalPeopleDataSet.on("load",function(ds){
		if(ds.getCount()==1){
			legalDutyId=ds.get("dutyId");
		}
	});
}
function forShow(somChangeList){
	var records=somChangeList.getAllRecords();
	for(var i=0;i<records.length;i++){
		var changeItem=records[i].get('changeItem');
		if(changeItem==0){
			applyType=applyType+",021";
		}else if(changeItem==1){
			applyType=applyType+",022";
		}else if(changeItem==2){
			applyType=applyType+",023";
			var somLegalPeopleDataSet=L5.DatasetMgr.lookup("somLegalPeopleDataSet");
			somLegalPeopleDataSet.setParameter("DUTY_ID",records[i].get('legalDutyId'));
			somLegalPeopleDataSet.load();//法定代表人
		}else if(changeItem==3){
			applyType=applyType+",024";
		}else if(changeItem==4){
			applyType=applyType+",025";
		}else if(changeItem==5){
			applyType=applyType+",026";
		}
	}
	somElectronicDataSet_load();//加载法律要件

}
//保存（页面无保存按钮）
function saveOpinion(){
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupChangeCmd");
	var somFlowAddDataset=L5.DatasetMgr.lookup("somFlowAddDataset");
	var somFlowIsValidate = somFlowAddDataset.isValidate();
	var newRecord=somFlowAddDataset.getCurrent();
	if(somFlowIsValidate != true){
		L5.Msg.alert("提示",somFlowIsValidate);
		return false;
	}
	command.setParameter("opinion", newRecord);
	command.execute("saveFlow");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功!",function(){});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//提交
function sendNext(){
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupChangeCmd");
	var somFlowAddDataset=L5.DatasetMgr.lookup("somFlowAddDataset");
	var somLegalPeopleDataSet=L5.DatasetMgr.lookup("somLegalPeopleDataSet");
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somApplyRecord=somApplyDataSet.getCurrent();

	var somFlowIsValidate = somFlowAddDataset.isValidate();
	var newRecord=somFlowAddDataset.getCurrent();
	if(somFlowIsValidate != true){
		L5.Msg.alert("提示",somFlowIsValidate);
		return false;
	}
	command.setParameter("fetchPeople", fetchPeople);
	command.setParameter("fetchDate", fetchDate);
	command.setParameter("fetchPhone", fetchPhone);
	command.setParameter("opinion", newRecord);//意见
	if(somLegalPeopleDataSet.getCount()!=0){
		command.setParameter("somLegalPeople", somLegalPeopleDataSet.getCurrent());//法定代表人
	}
	command.setParameter("Changes", somChangeList.getAllRecords());//变更事项
	command.setParameter("taskCode", taskCode);
	command.setParameter("legalDutyId", legalDutyId);
	command.setParameter("actDefUniqueId", actDefUniqueId);
	command.setParameter("processId", processId);
	command.setParameter("sorgId", sorgId);
	command.setParameter("assignmentId",assignmentId);
	command.setParameter("applyType", somApplyType);
	command.execute("sendForChange");
	if (!command.error) {
		if(actname=='issue' || end){//是发证环节流程结束
			L5.Msg.alert("提示","成功结束流程!",function(){
				window.history.go(-1);
			});
		}else{
			L5.Msg.alert("提示","成功提交至下一环节!",function(){
				if(actname == 'audit'){
					if(somApplyRecord.get("curOpinionId")=="1"){ //同意-批准通过-根据taskCode更改外网业务状态
						updateOnlineStatusPass(somApplyRecord.get("taskCode"));
					}
					if(somApplyRecord.get("curOpinionId")=="0"){ //不同意-批准不通过-根据taskCode更改外网业务状态
						updateOnlineStatusNoPass(somApplyRecord.get("taskCode"));
					}
				}
				window.history.go(-1);
			});
		}
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
function sendForPrint(){
	if(endDate=='' || beginDate=='' || PrintDate==''){
		L5.Msg.alert("提示","请先打印证书!");
		return;
	}
	if(actname=='print'){
		if(fetchPeople=='' || fetchDate==''||fetchPhone==''){
			L5.Msg.alert("提示","请先填写领证信息！");
			return false;
		}
	}
	var somFlowAddDataset=L5.DatasetMgr.lookup("somFlowAddDataset");
	var somFlowIsValidate = somFlowAddDataset.isValidate();
	var newRecord=somFlowAddDataset.getCurrent();
	if(somFlowIsValidate != true){
		L5.Msg.alert("提示",somFlowIsValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupChangeCmd");
	command.setParameter("sorgType", "S");
	command.setParameter("processId", processId);
	command.setParameter("sorgId", sorgId);
	command.setParameter("certType", document.getElementById('certType').value);
	command.setParameter("endDate", endDate);
	command.setParameter("beginDate", beginDate);
	command.setParameter("PrintDate", PrintDate);
	command.setParameter("issueReasonDesc", issueReasonDesc);
	command.setParameter("applyType", somApplyType);
	command.setParameter("opinion", newRecord);
	command.setParameter("organType", 'main');//主体还是分支
	command.setParameter("fetchPeople", fetchPeople);
	command.setParameter("fetchDate", fetchDate);
	command.setParameter("fetchPhone", fetchPhone);
	command.setParameter("business", business);
	command.execute("printForChange");
	if (!command.error) {
		L5.Msg.alert("提示","成功提交至下一环节!",function(){
			window.history.go(-1);
		});
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
//回退
function sendBack(){

}
//查看状态
function showStatus(){

}
//打印一次性补正材料通知书
function forPolishing(){

}
function send(){

}
//打印不予受理通知书
function printNOAccept(){

}
//打印受理通知书
function printAccept(){

}

function sendForPolishing(){

}
//打印变更证明
function printChangeSign(){

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
function closeForFetch(){
	var win=L5.getCmp('forchoseIssuePeople');
	win.hide();
}

//查看变更明细
function detailForChange(){
	var grid = L5.getCmp('changeEdit');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var id=records[0].get("id");
		var somChangeDataset=L5.DatasetMgr.lookup("somChangeDataset");
		somChangeDataset.setParameter("ID@=",id);
		somChangeDataset.load();
		somChangeDataset.on('load',forChangeShow);
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//选择性打开变更窗口
function forChangeShow(somChangeDataset){
	record= somChangeDataset.getCurrent();
	var changeItem=record.get('changeItem');
	var win=L5.getCmp('AddChange'+changeItem);
	win.show();
	if(changeItem=='0'){
		var changeBefore=record.get('changeBefore');
		var changeBefores=changeBefore.split(';');
		document.getElementById('nameBefore').innerHTML=changeBefores[0];
		document.getElementById('sorgGroupKindBefore').value=changeBefores[1];
		document.getElementById('sorgBusScopeBefore').value=changeBefores[2];

		var changeAfter=record.get('changeAfter');
		var changeAfters=changeAfter.split(';');
		document.getElementById('nameAfter').innerHTML=changeAfters[0];
		document.getElementById('sorgGroupKindAfter').value=changeAfters[1];
		document.getElementById('sorgBusScopeAfter').value=changeAfters[2];

	}else if(changeItem=='1'){
		var changeBefore=record.get('changeBefore');
		var changeBefores=changeBefore.split(';');
		document.getElementById('houseSourceBefore').value=changeBefores[0];
		document.getElementById('houseNameBefore').innerHTML=changeBefores[1];
		document.getElementById('houseBorgBefore').innerHTML=changeBefores[2];
		document.getElementById('houseAreaBefore').innerHTML=changeBefores[3];
		document.getElementById('houseDateBefore').innerHTML=changeBefores[4];

		var changeAfter=record.get('changeAfter');
		var changeAfters=changeAfter.split(';');
		document.getElementById('houseSourceAfter').value=changeAfters[0];
		document.getElementById('houseNameAfter').innerHTML=changeAfters[1];
		document.getElementById('houseBorgAfter').innerHTML=changeAfters[2];
		document.getElementById('houseAreaAfter').innerHTML=changeAfters[3];
		document.getElementById('houseDateAfter').innerHTML=changeAfters[4];
	}else if(changeItem=='2'){
		document.getElementById('leaPeopleNameBefore').innerHTML=record.get('changeBefore');
	}else if(changeItem=='3'){


	}else if(changeItem=='4'){
		var changeBefore=record.get('changeBefore');
		var changeBefores=changeBefore.split(';');
		document.getElementById('moneySourceBefore').innerHTML=changeBefores[0];
		document.getElementById('moneyBefore').innerHTML=changeBefores[1];

		var changeAfter=record.get('changeAfter');
		var changeAfters=changeAfter.split(';');
		document.getElementById('moneySourceAfter').innerHTML=changeAfters[0];
		document.getElementById('moneyAfter').innerHTML=changeAfters[1];
	}else if(changeItem=='5'){
		document.getElementById('borgNameBefore').value=record.get('changeBefore');
		document.getElementById('borgNameAfter').value=record.get('changeAfter');
	}
	changeNUM=changeItem;
}
//关闭变更window
function closeChangeWin(){
	var win=L5.getCmp('AddChange'+changeNUM);
	win.hide();
}
//点击查看法定代表人登记表
function detailLegalPeople(){
	var somLegalPeopleDataSet=L5.DatasetMgr.lookup("somLegalPeopleDataSet");
	var num=somLegalPeopleDataSet.getCount();
	if(num == 0){
		L5.Msg.alert("提示","数据错误！");
		return;
	}
	var somResumeLegalDataSet= L5.DatasetMgr.lookup("somResumeLegalDataSet");
	somResumeLegalDataSet.setParameter("DUTY_ID",somLegalPeopleDataSet.getCurrent().get('dutyId'));
	somResumeLegalDataSet.load();
	var win=L5.getCmp("legalPeopleWindow");
	win.show();
	document.getElementById("labelAge").innerHTML=getAgeByCode(somLegalPeopleDataSet.getCurrent().get('idCard'));

	//同步照片
	synPhotoDetail(somLegalPeopleDataSet.get("photoId"),null);//同步照片
	//加载法定代表人法律要件
	somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
	somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
	somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
	somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
	somLegalPeopleElectronicDataSet.setParameter("applyType","023");
	somLegalPeopleElectronicDataSet.load();
}
function closePeopleWIn(){
	var win = L5.getCmp("legalPeopleWindow");
	win.hide();
}

function returnForLegalPeople(){
	var win=L5.getCmp("legalPeopleWin");
	win.hide();
}

//打印证书功能
function printCert(){
	var somOrganDataSet= L5.DatasetMgr.lookup("somOrganDataSet");
	if(checkChangeItem("3")){
		business = somOrganDataSet.get("business");
	}else{
		business = somOrganDataSet.get("businessForPrint");
	}
	var win=L5.getCmp("forPrint");
	win.show();
	$("business").value = business;
}
//关闭打印证书窗口
function winCloseCert(){
	var win = L5.getCmp("forPrint");
	win.setVisible(false);
}

function forCertType(){
	var num=document.getElementById('certType').value;
	endDate=document.getElementById('endDate').value;
	beginDate=document.getElementById('beginDate').value;
	PrintDate=document.getElementById('PrintDate').value;
	issueReasonDesc=document.getElementById('issueReasonDesc').value;
	business = _$("business");
	if(business=='' ){
		L5.Msg.alert('提示',"请输入业务范围！");
		return;
	}
	if(byteLength(issueReasonDesc)>200){
		L5.Msg.alert("提示","发证原因描述长度不能超过200个字符(100个汉字)！");
		return false;
	}
	if(num!='' && endDate!='' && beginDate!='' && PrintDate!=''){
		if(endDate<beginDate){
			L5.Msg.alert('提示',"有效期限止不得早于有效期限起！");
			return;
		}
		var url=L5.webPath+"/jsp/cams/sorg/comm/print/groupBuildForPrint.jsp?id="+sorgId+"&PrintDate="+PrintDate+"&beginDate="+beginDate+"&endDate="+endDate+"&taskCode="+taskCode+"&certType="+num+"&organCode="+organCode+"&business="+encodeURIComponent(business);
		PostNewWin(url);
	}else{
		L5.Msg.alert('提示',"填入所需数据！");return;
	}
}
function goBack(){
	window.history.go(-1);
}
</script>
</head>
<body>
<model:datasets>
	<!-- 更改业务状态所用dataset -->
	<model:dataset id="updateStatusDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineQueryCommand"  global="true" >
		<model:record fromBean="com.inspur.cams.sorg.online.base.data.SomApplyOnline"></model:record>
	</model:dataset>
	<!-- 变更申请dataset -->
	<model:dataset id="somApplyDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply"></model:record>
	</model:dataset>
	<!-- 变更申请dataset -->
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<!-- 变更window的dataset -->
	<model:dataset id="somChangeList"
		cmd="com.inspur.cams.sorg.manage.cmd.SomChangeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomChange"></model:record>
	</model:dataset>
	<!-- 变更window的dataset -->
	<model:dataset id="somChangeDataset"
		cmd="com.inspur.cams.sorg.manage.cmd.SomChangeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomChange"></model:record>
	</model:dataset>
	<%--历史意见表--%>
	<model:dataset id="somFlowDataset"
		cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd"
		sortField="COMMIT_TIME" pageSize="20">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<!-- 变更意见 -->
	<model:dataset id="somFlowAddDataset"
		cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<model:field name="curOpinionId" type="string" rule="require" />
			<model:field name="curOpinion" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
	<%--历史意见表--%>
	<model:dataset id="somFlowQuery"
		cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<!-- 真正的法定代表人信息 -->
	<model:dataset id="legalPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 法定代表人信息 -->
	<model:dataset id="somLegalPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%--法定代表人人员简历 --%>
	<model:dataset id="somResumeLegalDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand" global="true" method="commExecute">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog" isGroup="true" groupField="applyType" pageSize="50">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--法定代表人员电子档案--%>
	<model:dataset id="somLegalPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleCatalog" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="sorgKindSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_GROUP_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="politicsSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 住所来源 -->
	<model:dataset id="resideSourceSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RESIDE_SOURCE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgNameSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_ORGAN'></model:param>
			<model:param name="value" value='SORG_ID'></model:param>
			<model:param name="text" value='CN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 所属行事业 -->
	<model:dataset id="busScopeSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织职务 -->
	<model:dataset id="sorgDutiesSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 专兼职 -->
	<model:dataset id="ifFulltimeSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="folkSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="ifServeSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DUTY_IF_SERVE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
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
	<!-- 证书类型 -->
	<model:dataset id="certTypeSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CERT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 会议类型 -->
	<model:dataset id="meetingType"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_MEETING_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="sexSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="pubOrganDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="PUB_ORGAN"></model:param>
			<model:param name="value" value="ORGAN_ID"></model:param>
			<model:param name="text" value="ORGAN_NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="somChangeItem" enumName="SOM.CHANGE.ITEM" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>

</model:datasets>
<next:Panel title="社会团体变更" width="100%" height="100%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<%
			//从后台获取环节按钮权限，显示要显示按钮
					for (int i = 0; i < list.size(); i++) {
						Map map = (Map) list.get(i);
						String buttonName = (String) map.get("buttonName");
						String buttonFunName = (String) map
								.get("buttonFunName");
						String buttonIMG = (String) map.get("buttonIMG");
						if ("send()".equals(buttonFunName)
								|| "sendForPrint()".equals(buttonFunName)
								|| "sendNext()".equals(buttonFunName)) {
							buttonIMG = "select";
						} else if ("saveOpinion()".equals(buttonFunName)) {
							buttonIMG = "save";
						} else if ("choseIssuePeople()".equals(buttonFunName)) {
							buttonIMG = "select";
						} else if ("goBack()".equals(buttonFunName)) {
							buttonIMG = "return";
						} else {
							buttonIMG = "print";
						}
		%>
		<next:ToolBarItem iconCls="<%=buttonIMG %>" text="<%=buttonName %>"
			handler="<%=buttonFunName %>" />
		<%
			}
		%>
	</next:TopBar>
	<next:TabPanel id="tab" activeTab="1" width="100%" height="100%" >
		<next:Tabs>
			<next:Panel title="社会团体变更登记申请表" width="100%" height="100%" autoScroll="true" >
				<next:Panel>
					<next:Html>
						<fieldset><legend>变更信息</legend>
						<form method="post" onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width: 10%;"><label>申请时间：</label></td>
								<td class="FieldInput" style="width: 10%;"><label
									id="changeDate" /></td>
								<td class="FieldLabel" style="width: 10%;"><label>社会团体名称：</label></td>
								<td class="FieldInput" style="width: 10%;"><label
									id="cnName"></label></td>
							</tr>
						</table>
						</form>
						</fieldset>
					</next:Html>
				</next:Panel>
				<next:EditGridPanel id="changeEdit" dataset="somChangeList" height="60%" autoScroll="true">
					<next:TopBar>
						<next:ToolBarItem text='' id="displayItem" />
						<next:ToolBarItem symbol="变更事项"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem text="查看变更" iconCls="detail"
							handler="detailForChange"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="变更事项" field="changeItem" width="19%"
							editable="false" dataset="somChangeItem">
							<next:TextField />
						</next:Column>
						<next:Column header="变更前" field="changeBefore" width="30%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="拟变更为" field="changeAfter" width="20%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="变更理由" field="changeReason" width="28%"
							editable="false">
							<next:TextField />
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				<next:Panel>
					<next:Html>
					<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
						<fieldset>
							<legend>社团内部履行程序</legend>
								<table width="100%">
									<tr>
										<td class="FieldInput"colspan="3"><textarea name="社团内部履行程序" field="process" readonly="readonly" cols="65" rows="4" style="width:95%"style="width:95%;background-color:#F5FAFA;border:0;overflow:auto;"></textarea></td>
									</tr>
								</table>
							<legend>历史处理意见</legend>
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
										<label field="examinOpinionId" style="width:90%" dataset="hisOpinionDataSet" default="0" />
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
										<label field="checkOpinionId" name='"审核意见"' style="width:90%" dataset="hisOpinionDataSet" default="0" />
									</td>
									<td class="FieldLabel" style="width:17%">审核人：</td>
									<td class="FieldInput" style="width:17%"><label type="text" field="checkPeopleName" name='审核承办人' style="width:90%" />
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
										<label field="auditOpinionId" name='"批准意见"' style="width:90%" dataset="hisOpinionDataSet" default="0" />
									</td>
									<td class="FieldLabel" style="width:17%">批准人：</td>
									<td class="FieldInput" style="width:17%"><label type="text" field="auditPeopleName" name='批准承办人' style="width:90%" />
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
						</fieldset>
					</form>
					</next:Html>
				</next:Panel>
			</next:Panel>
			<next:Panel title="法律要件" >
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet" autoScroll="true">
					<next:GroupingView forceFit="true"></next:GroupingView>
					<next:TopBar>
						<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
					</next:TopBar>

					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="档案目录名"  field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect"><next:TextField /></next:Column>
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
							editable="false" dataset="hisOpinionDataSet">
							<next:TextField />
						</next:Column>
						<next:Column header="处理补充意见" field="opinion" width="40%"
							editable="false">
							<next:TextField />
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
			</next:Panel>

			<next:Panel title="处理意见" id="ipinionPanel" width="100%" height="100%" autoScroll="true" style="display:block;" >
				<next:Html>
					<form method="post" onsubmit="return false" class="L5form"
						dataset="somFlowAddDataset">
					<table width="100%">
						<tr>
						<tr>
							<td class="FieldLabel" style="width: 13%"><label>处理意见：</label></td>
							<td class="FieldInput" colspan="5"><select
								field="curOpinionId" id="curOpinionId" name='处理意见'
								style="width: 150px">
								<option dataset="opinionSelect"></option>
							</select><span style="color: red">*</span></td>

						</tr>
						<tr>
							<td class="FieldLabel"><label>处理补充意见：</label></td>
							<td class="FieldInput" colspan="5"><textarea rows="10"
								name='处理补充意见' field="curOpinion" style="width: 98%"></textarea>
							</td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>

<next:Window id="legalPeopleWindow" closeAction="hide" title="法定代表人登记表" height="400" width="800" modal="true">
	<next:TabPanel  width="98%" height="84%">
		<next:Tabs>
			<next:Panel title="基本信息"  width="100%" height="100%" autoScroll="true">
				<next:Html>
					<form  method="post" dataset="somLegalPeopleDataSet" onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width:15%">身份证号码：</td>
								<td class="FieldInput" style="width:21%"><label id="labelIdCard" field="idCard"/></td>
								<td class="FieldLabel" style="width:14%">姓名：</td>
								<td class="FieldInput" style="width:17%"><label field="name"/></td>
								<td class="FieldLabel" style="width:14%" rowspan="4">照片:</td>
								<td class="FieldInput" style="width:19%" nowrap colspan="1" rowspan="4">
								<div id="photoDiv">
									<img id="img" name="RELATIONER_PHOTOC_IMG" width=82.5 height=110 src="<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg"
									align="top" ondblclick="editPhoto(1,'photoId','RELATIONER_PHOTOC_IMG');"
									onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg'" alt="暂无图片" />
									<input type="hidden" id="photoId" name="photoId"/>
								</div>
							</tr>
							<tr>
								<td class="FieldLabel">曾用名：</td>
								<td class="FieldInput"><label field="aliasName"/></td>
								<td class="FieldLabel">年龄：</td>
								<td class="FieldInput"><label id="labelAge" name='年龄'/></td>
							</tr>
							<tr>
								<td class="FieldLabel">性别：</td>
								<td class="FieldInput"><label field="sex" dataset="sexSelect"/></td>
								<td class="FieldLabel">出生年月：</td>
								<td class="FieldInput"><label field="birthday"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">政治面貌：</td>
								<td class="FieldInput"><label field="politics" dataset="politicsSelect"/></td>
								<td class="FieldLabel">民族：</td>
								<td class="FieldInput"><label field="folk" dataset="folkSelect"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">家庭住址：</td>
								<td class="FieldInput" colspan="3"><label field="adds"/></td>
								<td class="FieldLabel">户口所在地：</td>
								<td class="FieldInput"><label field="populace"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">邮编：</td>
								<td class="FieldInput"><label field="postCode"/></td>
								<td class="FieldLabel">电话：</td>
								<td class="FieldInput"><label field="phone"/></td>
								<td class="FieldLabel">专/兼职：</td>
								<td class="FieldInput"><label field="ifFulltime" dataset="ifFulltimeSelect" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">工作单位：</td>
								<td class="FieldInput" colspan="3"><label field="workName"/></td>
								<td class="FieldLabel">工作单位职务：</td>
								<td class="FieldInput"><label field="workDuties"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">社团职务：</td>
								<td class="FieldInput"><label field="sorgDuties" dataset="sorgDutiesSelect"/></td>
								<td class="FieldLabel">任职开始日期：</td>
								<td class="FieldInput"><label field="startDate"/></td>
								<td class="FieldLabel"><label>任职结束日期：</label></td>
								<td class="FieldInput"></td>
							</tr>
							<tr>
								<td class="FieldLabel">是否党政机关领导干部：</td>
								<td class="FieldInput"><label field="ifPartyLeader" dataset="comm_yesorno"/></td>
								<td class="FieldLabel">批准机关：</td>
								<td class="FieldInput"><label field="promiseOrgan"/></td>
								<td class="FieldLabel">批准文号：</td>
								<td class="FieldInput"><label field="promiseCode" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">本人所在单位人事部门审查意见：</td>
								<td class="FieldInput" colspan="5"><textarea rows="2" name='"所在单位人事部门审查意见"' readonly="readonly" field="workOpinion" style="width:97.7%"></textarea><span style="color:red">*</span></td>
							</tr>
							<tr>
								<td class="FieldLabel">审查工作单位：</td>
								<td class="FieldInput" colspan="3"><label  field="workName"/></td>
								<td class="FieldLabel">审查日期：</td>
								<td class="FieldInput"><label  field="workCheckDate"/></td>
							</tr>
							<tr>
									<td class="FieldLabel"><label>按照本社会团体章程会议产生通过情况：</label></td>
									<td class="FieldInput" colspan="5"><textarea   rows="2" name='"按照本社会团体章程会议产生通过情况"' field="sorgOpinion" style="width:97.7%"></textarea><span style="color:red">*</span></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>签署日期：</label></td>
									<td class="FieldInput" colspan="5"><input type="text"  field="sorgCheckDate" format="Y-m-d" onclick="WdatePicker()" style="width:22%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">备注：</td>
								<td class="FieldInput" colspan="5"><textarea rows="2" name='"备注"' readonly="readonly" field="note" style="width:97.7%"></textarea></td>
							</tr>
						</table>
					</form>
				</next:Html>
			</next:Panel>
			<next:EditGridPanel id="somResumeLegalGrid" dataset="somResumeLegalDataSet" stripeRows="true" title="本人简历" width="100%" height="100%" autoScroll="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn/>
					<next:Column header="内码" field="id" width="10%" editable="true" hidden="true"><next:TextField/></next:Column>
					<next:Column header="开始年月" field="startDate" width="10%" editable="false"><next:TextField/></next:Column>
					<next:Column header="结束年月" field="endDate" width="10%" editable="false"><next:TextField/></next:Column>
					<next:Column header="在何地区何单位" field="workOrgan" width="45%" editable="false"><next:TextField/></next:Column>
					<next:Column header="任（兼）何职" field="duty" width="20%" editable="false"><next:TextField/></next:Column>
				</next:Columns>
			</next:EditGridPanel>
			<next:EditGridPanel id="uploadLegalPeopleGrid" title="法律要件" stripeRows="true" dataset="somLegalPeopleElectronicDataSet" width="100%" height="100%" autoScroll="true">
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
					<next:Column header="下载附件" field="" width="10%" editable="false" renderer="clickDownloadLegalPeopleHref">
						<next:TextField />
					</next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somLegalPeopleElectronicDataSet" />
				</next:BottomBar>
			</next:EditGridPanel>
		</next:Tabs>
	</next:TabPanel>
	<next:Buttons>
		<next:ToolButton text="关闭" handler="closePeopleWIn"></next:ToolButton>
	</next:Buttons>
</next:Window>

<!-- 社会团体名称变更 -->
<next:Window id="AddChange0" modal="true" closeAction="hide"
	title="名称变更" width="600" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="名称变更"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"
			dataset="somChangeDataset">

		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 25%"><label>名称变更前：</label></td>
				<td class="FieldInput" colspan="3"><label id="nameBefore" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 25%"><label>社会团体类别变更前：</label></td>
				<td class="FieldInput" style="width: 25%"><select
					id="sorgGroupKindBefore" style="color: blue" disabled="disabled">
					<option dataset="sorgKindSelect"></option>
				</select></td>
				<td class="FieldLabel" style="width: 25%"><label>所属行（事）业变更前：</label></td>
				<td class="FieldInput" style="width: 25%"><select
					id="sorgBusScopeBefore" style="color: blue" disabled="disabled">
					<option dataset="busScopeSelect"></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%"><label
					style="color: blue">名称变更为：</label></td>
				<td class="FieldInput" style="width: 15%" colspan="3"><label
					id="nameAfter" style="color: blue" /></td>
			</tr>
			<span onmousemove="this.setCapture();" onmouseout="this.releaseCapture();">
			<tr>
				<td class="FieldLabel" style="width: 15%"><label
					style="color: blue">社会团体类别变更为：</label></td>
				<td class="FieldInput" style="width: 15%"><select
					id="sorgGroupKindAfter" style="color: blue">
					<option dataset="sorgKindSelect" style="color: blue"></option>
				</select></td>
				<td class="FieldLabel" style="width: 15%"><label
					style="color: blue">所属行（事）业变更为：</label></td>
				<td class="FieldInput" style="width: 15%"><select
					id="sorgBusScopeAfter" style="color: blue">
					<option dataset="busScopeSelect" style="color: blue"></option>
				</select></td>
			</tr>
			</span>
			<tr>
				<td class="FieldLabel"><label style="color: blue">变更程序：</label></td>
				<td class="FieldInput" colspan="5"><textArea cols="75" rows="4"
					style="width: 100%; color: blue" field='changeDesc'
					readonly="readonly"></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color: blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea cols="75" rows="4"
					style="width: 100%; color: blue" field="changeReason"
					readonly="readonly"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>

<!-- 法定代表人变更 -->
<next:Window id="AddChange2" modal="true" closeAction="hide"
	title="法定代表人变更" width="600" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="法定代表人变更"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="查看法定代表人登记表" iconCls="detail" handler="detailLegalPeople" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"
			dataset="somChangeDataset">

		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 25%"><label>法定代表人姓名变更前：</label></td>
				<td class="FieldInput" style="width: 25%"><label
					id="leaPeopleNameBefore" /></td>
				<td class="FieldLabel" style="width: 25%"><label
					style="color: blue">法定代表人姓名变更为：</label></td>
				<td class="FieldInput" style="width: 25%"><label
					field="changeAfter" style="color: blue" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color: blue">变更程序：</label></td>
				<td class="FieldInput" colspan="5"><textArea cols="75" rows="4"
					style="width: 100%; color: blue" readonly="readonly"
					field="changeDesc"></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color: blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea cols="75" rows="4"
					style="width: 100%; color: blue" readonly="readonly"
					field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<!-- 住所变更 -->
<next:Window id="AddChange1" modal="true" closeAction="hide"
	title="住所变更" width="500" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="住所变更"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"
			dataset="somChangeDataset">

		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 25%"><label>住所来源变更前：</label></td>
				<td class="FieldInput" style="width: 25%"><select
					id="houseSourceBefore" disabled="disabled">
					<option dataset="resideSourceSelect"></option>
				</select></td>
				<td class="FieldLabel" style="width: 25%"><label>用房面积变更前：</label></td>
				<td class="FieldInput" style="width: 25%"><label
					id="houseAreaBefore" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>住所名称变更前：</label></td>
				<td class="FieldInput" colspan="3"><label id="houseNameBefore" /></td>
			</tr>

			<tr>
				<td class="FieldLabel"><label>产权单位变更前：</label></td>
				<td class="FieldInput" colspan="3"><label id="houseBorgBefore" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>租借期限变更前：</label></td>
				<td class="FieldInput"><label id="houseDateBefore" /></td>
			</tr>
			<span onmousemove="this.setCapture();"
				onmouseout="this.releaseCapture();">
			<tr>
				<td class="FieldLabel" style="width: 15%"><label
					style="color: blue">住所来源变更为：</label></td>
				<td class="FieldInput" style="width: 15%"><select
					id="houseSourceAfter" style="color: blue">
					<option dataset="resideSourceSelect"></option>
				</select></td>
				<td class="FieldLabel"><label style="color: blue">用房面积变更为：</label></td>
				<td class="FieldInput"><label id="houseAreaAfter"
					style="color: blue" /></td>
			</tr>
			</span>
			<tr>
				<td class="FieldLabel"><label style="color: blue">住所名称变更为：</label></td>
				<td class="FieldInput" colspan="3"><label id="houseNameAfter"
					style="color: blue" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color: blue">产权单位变更为：</label></td>
				<td class="FieldInput" colspan="3"><label id="houseBorgAfter"
					style="color: blue" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color: blue">租借期限变更为：</label></td>
				<td class="FieldInput"><label id="houseDateAfter"
					style="color: blue" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color: blue">变更程序：</label></td>
				<td class="FieldInput" colspan="5"><textArea cols="75" rows="4"
					readonly="readonly" style="width: 100%; color: blue"
					field="changeDesc"></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color: blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea cols="75" rows="4"
					readonly="readonly" style="width: 100%; color: blue"
					field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<!-- 业务范围变更 -->
<next:Window id="AddChange3" modal="true" closeAction="hide"
	title="业务范围变更" width="600" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="业务范围变更"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"
			dataset="somChangeDataset">

		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 25%"><label>业务范围变更前：</label></td>
				<td class="FieldInput" style="width: 75%"><textArea
					field='changeBefore' disabled="disabled" cols="75" rows="4"
					style="width: 100%"></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%"><label
					style="color: blue">业务范围变更为：</label></td>
				<td class="FieldInput" style="width: 15%"><textArea
					field="changeAfter" readonly="readonly" cols="75" rows="4"
					style="width: 100%; color: blue"></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color: blue">变更程序：</label></td>
				<td class="FieldInput" colspan="5"><textArea
					readonly="readonly" cols="75" rows="4"
					style="width: 100%; color: blue" field="changeDesc"></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color: blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea
					readonly="readonly" cols="75" rows="4"
					style="width: 100%; color: blue" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<!-- 变更注册资金 -->
<next:Window id="AddChange4" modal="true" closeAction="hide"
	title="注册资金变更" width="500" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="注册资金变更"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"
			dataset="somChangeDataset">

		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 25%"><label>资金数额变更前：</label></td>
				<td class="FieldInput" style="width: 75%"><label
					id="moneyBefore" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>资金来源变更前：</label></td>
				<td class="FieldInput"><label
					id="moneySourceBefore" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color: blue">资金数额变更为：</label></td>
				<td class="FieldInput"><label id="moneyAfter"
					style="color: blue" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color: blue">资金来源变更为：</label></td>
				<td class="FieldInput"><label id="moneySourceAfter"
					style="color: blue" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color: blue">变更程序：</label></td>
				<td class="FieldInput" colspan="5"><textArea cols="75" rows="4"
					readonly="readonly" style="width: 100%; color: blue"
					field="changeDesc"></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color: blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea cols="75" rows="4"
					readonly="readonly" style="width: 100%; color: blue"
					field="changeReason"></textArea></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Window>

<!-- 业务主管单位变更 -->
<next:Window id="AddChange5" modal="true" closeAction="hide"
	title="业务主管单位变更" width="600" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="业务主管单位变更"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"
			dataset="somChangeDataset">
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 25%"><label>变更前业务主管单位：</label></td>
				<td class="FieldInput" style="width: 75%"><select
					id="borgNameBefore" disabled="disabled"style="width: 80%">
					<option dataset="businessOrganSelect"></option>
				</select></td>
			</tr>
				<span onmousemove="this.setCapture();"
				onmouseout="this.releaseCapture();">
			<tr>
				<td class="FieldLabel" style="width: 25%"><label
					style="color: blue">变更为业务主管单位：</label></td>
				<td class="FieldInput" style="width: 25%"><select
					id="borgNameAfter" style="color: blue;width:80%">
					<option dataset="businessOrganSelect"></option>
				</select></td>
			</tr>
			</span>
			<tr>
				<td class="FieldLabel"><label style="color: blue">变更程序：</label></td>
				<td class="FieldInput" colspan="5"><textArea cols="75"
					readonly="readonly" rows="4" style="width: 100%; color: blue"
					field="changeDesc"></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color: blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea cols="75"
					readonly="readonly" rows="4" style="width: 100%; color: blue"
					field="changeReason"></textArea></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Window>
<!--打印证书  -->
<next:Window id="forPrint" closeAction="hide" title="打印证书" width="500"
	autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="打印证书"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="detail" handler="forCertType"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="winCloseCert"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form">

		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 15%"><label>选择证书类型：</label></td>
				<td class="FieldInput" style="width: 15%"><select id="certType">
					<option dataset="certTypeSelect"></option>
				</select></td>
				<td class="FieldLabel" style="width: 15%"><label>发证日期：</label></td>
				<td class="FieldInput" style="width: 15%"><input type="text"
					id="PrintDate" style="width: 100%"
					format="Y-m-d" onclick="WdatePicker();"></td>

			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%"><label>有效期限起：</label></td>
				<td class="FieldInput" style="width: 15%"><input type="text"
					id="beginDate" style="width: 100%"
					format="Y-m-d" onclick="WdatePicker();"></td>
				<td class="FieldLabel" style="width: 15%"><label>有效期限止：</label></td>
				<td class="FieldInput" style="width: 15%"><input type="text"
					id="endDate" style="width: 100%" format="Y-m-d"
					onclick="WdatePicker();"></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width:15%"><label>业务范围：</label></td>
				<td class="FieldInput" style="width:15%" colspan="3"><textarea  rows="3" id="business"  style="width:100%" ></textarea></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width:15%"><label>发证原因描述：</label></td>
				<td class="FieldInput" style="width:15%" colspan="3"><textarea  rows="2" id="issueReasonDesc"  style="width:100%" ></textarea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>

<next:Window id="forchoseIssuePeople" closeAction="hide" title="填写领证信息"
	width="500" autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="填写领证信息"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="detail" handler="buttonForFetch"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeForFetch"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form">

		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 15%"><label>领证人：</label></td>
				<td class="FieldInput" style="width: 15%"><input type="text"
					id="fetchPeople" /></td>
				<td class="FieldLabel" style="width: 15%"><label>领证日期：</label></td>
				<td class="FieldInput" style="width: 15%"><input type="text"
					id="fetchDate" style="width: 100%"
					format="Y-m-d" onclick="WdatePicker();"></td>

			</tr>
			<tr>
				<td class="FieldLabel" style="width:15%"><label>领证人联系电话：</label></td>
				<td class="FieldInput"style="width:15%" colspan="3"><input type="text" id="fetchPhone"/></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<!-- 下载附件列表 -->
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