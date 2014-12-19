<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<%@page import="org.loushang.workflow.api.WfQuery" %>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.lang.StringBuffer"%>
<%@page import="com.inspur.cams.sorg.apply.group.cmd.GroupChangeCmd"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.sorg.util.SomDutyDuties"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
<!-- 民办非企业单位主体变更流程页面 -->
<head>
	<next:ScriptManager></next:ScriptManager>
	<script type="text/javascript" src="<%=SkinUtils.getJS(request, "changeCheck.js")%>"></script>
	<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
	<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js") %>'></script>
	<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js") %>'></script>
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
		String procDefUniqueId=(String)request.getParameter("procDefUniqueId");
		String actDefUniqueId=(String)request.getParameter("actDefUniqueId");
		//然调用接口
		List<Map> list = new WfQuery().getActButtons(actDefUniqueId);
		List<Map> list1=new WfQuery().getActFields(actDefUniqueId);
		//遍历list，如果该页面上某个域是需要隐藏的，则设置该域为不显示
		//如果域是只读的则显示为只读
		//如果是非空的，则在点击按钮时进行校验 ，若为空弹出提示框
		String fieldId,fieldName,isHidden,isReadOnly,isNotNull;
		//boolean isHidden,isReadOnly,isNotNull;
		String processId=(String)request.getParameter("processId");
		if(processId==null){
			processId=new GroupChangeCmd().getProcessId(assignmentId);
		}
		String actname=(String)request.getParameter("actname");
		String legalDuties=SomDutyDuties.SOM_LEGAL_PEOPLE;
	%>
	var processId = '<%= processId%>';
	var procDefUniqueId = '<%= (String)request.getParameter("procDefUniqueId")%>';
	var assignmentId="<%=assignmentId%>";
	var somApplyType="102";
	var applyType = "118";
	var fileCodeF="M044";
	var legalDutyId='<%=IdHelp.getUUID32()%>';
	var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
	var actDefUniqueId ="<%=actDefUniqueId%>";
	var actname='<%=actname%>';
	var legalDuties='<%=legalDuties%>';//法定代表人职务代码
</script>
<script type="text/javascript">

var sorgId='';
var sorgKind='';
var cnName='';//民办非企业单位名称
var sorgDuties='';//民办非企业单位职务
var taskCode='';
var changeNUM='';
var catalogName='';//档案目录名
var forCheck= new Array();//检验变更事项用的数组
var sorgOrganRecord='';//社会组织record
var changeItemNUM='';
var legalName="";
function init(){
	var tab=L5.getCmp("tab");
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("0");

	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	somApplyDataSet.setParameter("PROCESS_ID@=",processId);
	somApplyDataSet.load();//社会组织
	somApplyDataSet.on('load',funAdd);
	var opinionSelect=L5.DatasetMgr.lookup("opinionSelect");
	opinionSelect.filterBy(function(record, id){
		if("0,1".indexOf(record.get('value'))>-1){
			return record;
		}
	});
}
function funAdd(somApplyDataSet){
	sorgId=somApplyDataSet.get('sorgId');
	taskCode=somApplyDataSet.get('taskCode');
	cnName=somApplyDataSet.get('sorgName');
	sorgKind=somApplyDataSet.get('sorgKind');
	document.getElementById('cnName').innerHTML=cnName;
	document.getElementById('changeDate').innerHTML=somApplyDataSet.get('appDate');
	//document.getElementById("process").value=somApplyDataSet.get('process');
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on('load',findSorg);

	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.setParameter("TASK_CODE@=",taskCode);
	somChangeList.load();//变更
	somChangeList.on('load',forShow);

	var somFlowAddDataset=L5.DatasetMgr.lookup("somFlowAddDataset");
	somFlowAddDataset.setParameter("TASK_CODE@=",taskCode);
	somFlowAddDataset.load();

	var somLegalPeopleDataSet=L5.DatasetMgr.lookup("somLegalPeopleDataSet");
	somLegalPeopleDataSet.setParameter("TASK_CODE",taskCode);
	somLegalPeopleDataSet.setParameter("SORG_DUTIES","00012");
	somLegalPeopleDataSet.load();//法定代表人
	somLegalPeopleDataSet.on('load',function(ds){
		if(ds.getCount()==1){
			legalDutyId=ds.get("dutyId");
			//加载法定代表人法律要件
			somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
			somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
			somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
			somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
			somLegalPeopleElectronicDataSet.setParameter("applyType","121");
			somLegalPeopleElectronicDataSet.load();
			//加载人员简历
			var somLegalPeopleResumeDataSet = L5.DatasetMgr.lookup("somLegalPeopleResumeDataSet");
			somLegalPeopleResumeDataSet.setParameter("DUTY_ID",ds.get("dutyId"));
			somLegalPeopleResumeDataSet.load();
		}
	});

	//电子档案上传窗口关闭事件
	uploadListCloseEvent();
	var win=L5.getCmp("uploadLegalPeopleList");
	if(win!=null){
		win.on("hide",function(el){
			somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
			somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
			somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
			somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
			somLegalPeopleElectronicDataSet.setParameter("applyType","121");
			somLegalPeopleElectronicDataSet.load();
			somElectronicDataSet_load();
		});
	}
	//法定代表人窗口关闭事件
	L5.getCmp("legalPeopleWindow").on("beforehide",function(){
		if(_$("photoId")){
			somLegalPeopleDataSet.set("photoText",_$("photoId"));
			somLegalPeopleDataSet.set("photoPath","1");
		}
	});
}
function findSorg(somOrganDataset){
	sorgOrganRecord= somOrganDataset.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.apply.ungov.cmd.UngovChangeCmd");
	command.setParameter("sorgId", sorgId);
	command.execute("getLegalPeopleNameByTaskCode");
	legalName=command.getReturn("legalPeopleName");
}
function forShow(somChangeList){
	var records=somChangeList.getAllRecords();
	for(var i=0;i<records.length;i++){
		var changeItem=records[i].get('changeItem');
		if(changeItem==0){
			applyType=applyType+",119";
			forCheck[forCheck.length]='0';
		}else if(changeItem==1){
			applyType=applyType+",120";
			forCheck[forCheck.length]='1';
		}else if(changeItem==2){
			applyType=applyType+",121";
			forCheck[forCheck.length]='2';
		}else if(changeItem==3){
			applyType=applyType+",122";
			forCheck[forCheck.length]='3';
		}else if(changeItem==4){
			applyType=applyType+",123";
			forCheck[forCheck.length]='4';
		}else if(changeItem==5){
			applyType=applyType+",124";
			forCheck[forCheck.length]='5';
		}else if(changeItem==7){
			applyType=applyType+",125";
			forCheck[forCheck.length]='7';
		}
	}
	somElectronicDataSet_load();//加载法律要件
}
//保存
function saveOpinion(){
	//变更项目的dataset
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	var Changes = somChangeList.getAllRecords();
	if(Changes.length == 0){
		L5.Msg.alert("提示","您至少选择一种变更！");return;
	}
	var somFlowAddDataset=L5.DatasetMgr.lookup("somFlowAddDataset");
	var newRecord=somFlowAddDataset.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.apply.ungov.cmd.UngovChangeCmd");
	command.setParameter("Changes", Changes);
	for(var i=0;i<forCheck.length;i++){
		if(forCheck[i]==2 && somLegalPeopleDataSet.getCount()!=0){
			command.setParameter("somLegalPeople", somLegalPeopleDataSet.getCurrent());
			var somLegalPeopleResumeDataSet = L5.DatasetMgr.lookup("somLegalPeopleResumeDataSet");
			command.setParameter("legalResumeRecords",somLegalPeopleResumeDataSet.getAllRecords());
		}
	}
	newRecord.set("taskCode",taskCode);
	command.setParameter("opinion", newRecord);
	command.setParameter("cnName", cnName);
	command.setParameter("sorgId", sorgId);
	command.setParameter("sorgType","M");
	command.setParameter("taskCode", taskCode);
	command.setParameter("sorgKind",sorgKind);
	command.setParameter("legalDutyId",legalDutyId);
	command.setParameter("sorgDuties","M");//使后台查不到此职务
	command.setParameter("applyType", somApplyType);
	//command.setParameter("process", document.getElementById("process").value);

	command.execute("saveOpinion");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功!",function(){
			window.history.go(-1);
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//发送下一步
function sendNext(){
	//变更项目的dataset
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	var Changes = somChangeList.getAllRecords();
	if(Changes.length == 0){
		L5.Msg.alert("提示","您至少选择一种变更！");return;
	}
	var somFlowAddDataset=L5.DatasetMgr.lookup("somFlowAddDataset");
	var newRecord=somFlowAddDataset.getCurrent();
	var somFlowIsValidate = somFlowAddDataset.isValidate();
	if(somFlowIsValidate != true){
		L5.Msg.alert("提示",somFlowIsValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.sorg.apply.ungov.cmd.UngovChangeCmd");
	command.setParameter("Changes", Changes);
	for(var i=0;i<forCheck.length;i++){
		if(forCheck[i]==2 && somLegalPeopleDataSet.getCount()!=0){
			command.setParameter("somLegalPeople", somLegalPeopleDataSet.getCurrent());
			var somLegalPeopleResumeDataSet = L5.DatasetMgr.lookup("somLegalPeopleResumeDataSet");
			command.setParameter("legalResumeRecords",somLegalPeopleResumeDataSet.getAllRecords());
		}
	}
	newRecord.set("taskCode",taskCode);
	command.setParameter("opinion", newRecord);
	//command.setParameter("process", document.getElementById("process").value);
	command.setParameter("actDefUniqueId",actDefUniqueId);
	command.setParameter("cnName", cnName);
	command.setParameter("sorgId", sorgId);
	command.setParameter("sorgType","M");
	command.setParameter("sorgKind",sorgKind);
	command.setParameter("taskCode", taskCode);
	command.setParameter("legalDutyId",legalDutyId);
	command.setParameter("sorgDuties","M");//使后台查不到此职务
	command.setParameter("applyType", somApplyType);
	command.execute("sendForChange");
	if (!command.error) {
		L5.Msg.alert("提示","成功提交至下一环节!",function(){
			window.history.go(-1);
		});
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}

//点击增加变更按钮
function forAdd(){
	if(sorgId==''){
		L5.Msg.alert("提示","请先输入登记证号选择民办非企业单位！");return;
	}
	var win=L5.getCmp('AddChange');
	win.show();
}
//点击删除变更按钮，删除一条变更
function forDelete(){
	var grid = L5.getCmp('changeEdit');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				L5.Msg.alert("提示","删除成功!",function(){
					var somChangeList = L5.DatasetMgr.lookup("somChangeList");
					for(var i=0;i<forCheck.length;i++){
						if(records[0].get('changeItem')==forCheck[i]){
							if(records[0].get('changeItem')==2){
								somLegalPeopleDataSet.removeAll();
								var somLegalPeopleResumeDataSet=L5.DatasetMgr.lookup("somLegalPeopleResumeDataSet");
								somLegalPeopleResumeDataSet.removeAll();
							}
							hideDeletedCatalog(forCheck[i]);
							forCheck[i]='delete';
						}
					}
					somChangeList.remove(records[0]);
				});
			}
			else{
				return;
			}
		});

	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//点击按钮，查看法定代表人登记表
function detailLegalPeople(){
	var win=L5.getCmp("detailLegalPeopleWindow");
	win.show();
	document.getElementById("detailAge").innerHTML=getAgeByCode(somLegalPeopleDataSet.get('idCard'));
	L5.getCmp("detailLegalPeopleTab").setActiveTab("0");//不加照片会错误显示
	if(!somLegalPeopleDataSet.get("photoPath")){
		synPhotoDetail(somLegalPeopleDataSet.get("photoId"),"1");
	}else{
		initPhotoDetail("1");
		initUpload($("filePath1"), 1,"RELATIONER_PHOTOC_IMG1");
	}

}
//选择完变更项目后点击确定
function forChangeItem(num){
	if(num == ""){
		L5.Msg.alert("提示","请选择变更事项!");return;
	}
	if(!forCheckRepeat(num)){
		return;
	}
	var win=L5.getCmp('AddChange');
	win.hide();
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	somChangeDataset.newRecord();

	if(num=='0'){
		var win=L5.getCmp('AddChange'+num);
		win.show();
		document.getElementById('nameBefore').innerHTML=sorgOrganRecord.get('cnName');
	}else if(num=='1'){
		var win=L5.getCmp('AddChange'+num);
		win.show();
		document.getElementById('houseSourceBefore').value=sorgOrganRecord.get("resideSource");
		document.getElementById('houseNameBefore').innerHTML=sorgOrganRecord.get("residence");
		document.getElementById('houseBorgBefore').innerHTML=sorgOrganRecord.get("housingOrgan");
		document.getElementById('houseAreaBefore').innerHTML=sorgOrganRecord.get("housingArea");
		document.getElementById('houseDateBefore').innerHTML=sorgOrganRecord.get("leasePeriod");
	}else if(num=='2'){
		var win=L5.getCmp('AddChange'+num);
		win.show();

		document.getElementById('leaPeopleNameBefore').innerHTML=sorgOrganRecord.get('legalPeople');
	}else if(num=='3'){
		var win=L5.getCmp('AddChange'+num);
		win.show();
		document.getElementById('businessNameBefore').innerHTML=sorgOrganRecord.get("business");
	}else if(num=='4'){
		var win=L5.getCmp('AddChange'+num);
		win.show();
		document.getElementById('moneyBefore').innerHTML=sorgOrganRecord.get("regMon");
		document.getElementById('moneySourceBefore').innerHTML=sorgOrganRecord.get("moneySource");
	}else if(num=='5'){
		var win=L5.getCmp('AddChange'+num);
		win.show();
		document.getElementById('borgNameBefore').value=sorgOrganRecord.get("borgName");
	}else if(num=='7'){
		var win=L5.getCmp('AddChange'+num);
		win.show();
		document.getElementById('monPeopleChangeBefore').value=sorgOrganRecord.get("fundingPeople");
	}
	changeItemNUM=num;
}
//住所变更保存
function forHouseMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	var houseSourceAfter=document.getElementById('houseSourceAfter').value;
	var houseNameAfter=document.getElementById('houseNameAfter').value;
	var houseBorgAfter=document.getElementById('houseBorgAfter').value;
	var houseAreaAfter=document.getElementById('houseAreaAfter').value;
	var houseDateAfter=document.getElementById('houseDateAfter').value;

	if(!houseChangeCheck()){
		return;
	}
	var changeAfter=houseSourceAfter+';'+houseDateAfter+';'+houseBorgAfter+';'+houseAreaAfter+';'+houseNameAfter;
	var houseSourceBefore=document.getElementById('houseSourceBefore').value;
	var houseNameBefore=document.getElementById('houseNameBefore').innerHTML;
	var houseBorgBefore=document.getElementById('houseBorgBefore').innerHTML;
	var houseAreaBefore=document.getElementById('houseAreaBefore').innerHTML;
	var houseDateBefore=document.getElementById('houseDateBefore').innerHTML;
	var changeBefore=houseSourceBefore+';'+houseDateBefore+';'+houseBorgBefore+';'+houseAreaBefore+';'+houseNameBefore;
	record.set('changeBefore',changeBefore);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','1');
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='1';
	closeChangeWin();
	applyType=applyType+",120";
	somElectronicDataSet_load();
}
//资金变更保存
function forMoneyMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	//var moneyPeopleBefore=document.getElementById('moneyPeopleBefore').innerHTML;
	//var moneyborgBefore=document.getElementById('moneyborgBefore').innerHTML;
	var moneySourceBefore=document.getElementById('moneySourceBefore').innerHTML;
	var moneyBefore=document.getElementById('moneyBefore').innerHTML;

	var changeBefore=moneySourceBefore+';'+moneyBefore;

	//var moneyPeopleAfter=document.getElementById('moneyPeopleAfter').value;
	//var moneyborgAfter=document.getElementById('moneyborgAfter').value;
	var moneySourceAfter=document.getElementById('moneySourceAfter').value;
	var moneyAfter=document.getElementById('moneyAfter').value;

	var changeAfter=moneySourceAfter+';'+moneyAfter;
	if(!moneyChangeCheck()){
		return;
	}
	record.set('changeBefore',changeBefore);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','4');
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='4';
	closeChangeWin();
	applyType=applyType+",123";
	somElectronicDataSet_load();
}
//名称变更保存
function forNameMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();

	var nameBefore=document.getElementById('nameBefore').innerHTML;
	var nameAfter=document.getElementById('nameAfter').value;
	if(nameAfter==''){
		L5.Msg.alert("提示","名称不能为空，未变更填写变更前内容！");return;
	}
	if(!nameChangeCheck()){
		return;
	}
	//检查新的民办非企业单位名称是否已经存在
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
	command.setParameter("cnName",document.getElementById('nameAfter').value);
	command.execute('cnNameUK');
	var num=command.getReturn('cnNameNum');
	if(num!=0){
		L5.Msg.alert("提示","名称已经存在!");return;
	}
	var changeBefore=nameBefore;
	var changeAfter=nameAfter;

	record.set('changeBefore',changeBefore);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','0');
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='0';
	closeChangeWin();
	applyType=applyType+",119";
	somElectronicDataSet_load();
}
//法定代表人变更保存
function forLeaPeopleMove(){
	//修改逻辑，因为法定代表人改为可以修改，查看明细里边的法定代表人其实是修改的，此处如果列表中选中的是法定代表人的的，说明是对法定代表人修改的，先删除原有的那条，然后插入
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	var grid = L5.getCmp('changeEdit');
	var sm = grid.getSelectionModel();
	var recordSelect = sm.getSelected();
	if(recordSelect!=null && recordSelect.get("changeItem") == "2"){
		somChangeList.remove(recordSelect);
	}
	//修改逻辑，因为法定代表人改为可以修改，查看明细里边的法定代表人其实是修改的，此处如果列表中选中的是法定代表人的的，说明是对法定代表人修改的，先删除原有的那条，然后插入
	//完成
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	var changeAfter=document.getElementById('leaPeopleNameAfter').value;
	if(changeAfter==''){
		L5.Msg.alert("提示","法定代表人姓名不能为空！");return;
	}
	if(!leaPeopleChangeCheck()){
		return;
	}
	record.set('changeBefore',document.getElementById('leaPeopleNameBefore').innerHTML);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','2');
	record.set('changeReason',document.getElementById('leaPeopleReason').value);
	record.set('changeDesc',document.getElementById('leaPeopleDesc').value);
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='2';
	closeChangeWin();
	applyType=applyType+",121";
	somElectronicDataSet_load();
}
//业务范围变更保存
function forBusinessMove(){

	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	var changeBefore=document.getElementById('businessNameBefore').innerHTML;
	var changeAfter=record.get('changeAfter');
	if(changeAfter==''){
		L5.Msg.alert("提示","业务范围不能为空！");return;
	}
	if(!businessChangeCheck()){
		return;
	}
	record.set('changeBefore',changeBefore);
	record.set('changeItem','3');
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='3';
	closeChangeWin();
	applyType=applyType+",122";
	somElectronicDataSet_load();

}
//主管单位变更保存
function forBorgMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	var borgNameAfter=document.getElementById('borgNameAfter').value;
	if(borgNameAfter==''){
		L5.Msg.alert("提示","业务主管单位不能为空！");return;
	}
	if(!borgChangeCheck()){
		return;
	}
	record.set('changeBefore',document.getElementById('borgNameBefore').value);
	record.set('changeItem','5');
	record.set('changeAfter',borgNameAfter);
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='5';
	closeChangeWin();
	applyType=applyType+",124";
	somElectronicDataSet_load();
}
//出资人变更保存
function forMonPeopleMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();

	var monPeopleChangeBefore=document.getElementById('monPeopleChangeBefore').value;
	var monPeopleChangeAfter=document.getElementById('monPeopleChangeAfter').value;

	if(monPeopleChangeAfter==''){
		L5.Msg.alert("提示","出资人不能为空，未变更填写变更前内容！");return;
	}
	if(!monPeopleChangeCheck()){
		return;
	}
	record.set('changeBefore',monPeopleChangeBefore);
	record.set('changeAfter',monPeopleChangeAfter);
	record.set('changeItem','7');
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	somChangeList.commitChanges();
	forCheck[forCheck.length]='7';
	closeChangeWin();
	applyType=applyType+",125";
	somElectronicDataSet_load();
}
//检查是否重复变更
function forCheckRepeat(number){
	for(var i=0;i<forCheck.length;i++){
		if(forCheck[i]==number){
			L5.Msg.alert("提示","该变更事项已经存在!");return false;
		}
	}
	return true;
}
//关闭变更窗口
function closeChangeWin(){
	var win=L5.getCmp('AddChange'+changeItemNUM);
	win.hide();
}
//关闭变更窗口
function closeChangeWinD(){
	var win=L5.getCmp('detail'+changeItemNUM);
	win.hide();
}

//查看变更
function forDetail(){
	var grid = L5.getCmp('changeEdit');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var record=records[0];
		var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
		somChangeDataset.removeAll();
		somChangeDataset.remove(somChangeDataset.newRecord());
		somChangeDataset.insert(0,record);
		var num=record.get('changeItem');
		changeItemNUM=num;
		if(num=='0'){
			var win=L5.getCmp('detail'+num);
			win.show();
			document.getElementById('nameBefore1').innerHTML=record.get('changeBefore');
			document.getElementById('nameAfter1').innerHTML=record.get('changeAfter');
			//document.getElementById('namechangeDesc').value=record.get('changeDesc');
			//document.getElementById('namechangeReason').value=record.get('changeReason');
		}else if(num=='1'){
			var win=L5.getCmp('detail'+num);
			win.show();
			var changeBefore=record.get('changeBefore');
			var changeBefores=changeBefore.split(';');
			document.getElementById('houseSourceBefore1').value=changeBefores[0];
			document.getElementById('houseNameBefore1').innerHTML=changeBefores[4];
			document.getElementById('houseBorgBefore1').innerHTML=changeBefores[2];
			document.getElementById('houseAreaBefore1').innerHTML=changeBefores[3];
			document.getElementById('houseDateBefore1').innerHTML=changeBefores[1];

			var changeAfter=record.get('changeAfter');
			var changeAfters=changeAfter.split(';');
			document.getElementById('houseSourceAfter1').value=changeAfters[0];
			document.getElementById('houseNameAfter1').innerHTML=changeAfters[4];
			document.getElementById('houseBorgAfter1').innerHTML=changeAfters[2];
			document.getElementById('houseAreaAfter1').innerHTML=changeAfters[3];
			document.getElementById('houseDateAfter1').innerHTML=changeAfters[1];
			//document.getElementById('housechangeDesc').value=record.get('changeDesc');
			//document.getElementById('housechangeReason').value=record.get('changeReason');
		}else if(num=='2'){
			var win=L5.getCmp('AddChange'+num);
			win.show();
			var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
			somChangeDataset.newRecord();
			document.getElementById('leaPeopleNameBefore').innerHTML=record.get('changeBefore');
			document.getElementById('leaPeopleNameAfter').value=record.get('changeAfter');
			document.getElementById('leaPeopleDesc').value=record.get('changeDesc');
			document.getElementById('leaPeopleReason').value=record.get('changeReason');
		}else if(num=='3'){
			var win=L5.getCmp('detail'+num);
			win.show();
			document.getElementById('areaChangeBefore').value=record.get('changeBefore');
			document.getElementById('areaChangeAfter').value=record.get('changeAfter');
			//document.getElementById('areaChangeDesc').value=record.get('changeDesc');
			//document.getElementById('areaChangeReason').value=record.get('changeReason');
		}else if(num=='4'){
			var win=L5.getCmp('detail'+num);
			win.show();
			var changeBefore=record.get('changeBefore');
			var changeBefores=changeBefore.split(';');
			//document.getElementById('moneyPeopleBefore1').innerHTML=changeBefores[0];
			document.getElementById('moneySourceBefore1').innerHTML=changeBefores[0];
			document.getElementById('moneyBefore1').innerHTML=changeBefores[1];

			var changeAfter=record.get('changeAfter');
			var changeAfters=changeAfter.split(';');
			//document.getElementById('moneyPeopleAfter1').innerHTML=changeAfters[0];
			document.getElementById('moneySourceAfter1').innerHTML=changeAfters[0];
			document.getElementById('moneyAfter1').innerHTML=changeAfters[1];

			//document.getElementById('moneychangeDesc').value=record.get('changeDesc');
			//document.getElementById('moneychangeReason').value=record.get('changeReason');
		}else if(num=='5'){
			var win=L5.getCmp('detail'+num);
			win.show();
			document.getElementById('borgNameBefore1').value=record.get('changeBefore');
			document.getElementById('borgNameAfter1').value=record.get('changeAfter');
			//document.getElementById('borgchangeDesc').value=record.get('changeDesc');
			//document.getElementById('borgchangeReason').value=record.get('changeReason');
		}else if(num=='7'){
			var win=L5.getCmp('detail'+num);
			win.show();
			document.getElementById('monPeopleChangeBefore1').value=record.get('changeBefore');
			document.getElementById('monPeopleChangeAfter1').value=record.get('changeAfter');
			//document.getElementById('monPeopleDesc1').value=record.get('changeDesc');
			//document.getElementById('monPeopleReason1').value=record.get('changeReason');
		}
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//点击上传附件按钮
function clickUploadFile(){
	if(sorgId == ""){
		L5.Msg.alert('提示','请先填写“登记证号！”');
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	uploadFile();
}
//变更项删除，同步隐藏该变更项所需法律要件
//changeItem：变更项的值
function hideDeletedCatalog(changeItem){
	var ifNeedChangeCatalog = "0";
	//名称变更
	if(changeItem=="0"){
		applyType=applyType.replace(",119","");
		ifNeedChangeCatalog = "1";
	}
	//住所变更
	if(changeItem=="1"){
		applyType=applyType.replace(",120","");
		ifNeedChangeCatalog = "1";
	}
	//法定代表人变更
	if(changeItem=="2"){
		applyType=applyType.replace(",121","");
		ifNeedChangeCatalog = "1";
	}
	//业务范围变更
	if(changeItem=="3"){
		applyType=applyType.replace(",122","");
		ifNeedChangeCatalog = "1";
	}
	//开办资金变更
	if(changeItem=="4"){
		applyType=applyType.replace(",123","");
		ifNeedChangeCatalog = "1";
	}
	//业务主管单位变更
	if(changeItem=="5"){
		applyType=applyType.replace(",124","");
		ifNeedChangeCatalog = "1";
	}
	//出资人变更
	if(changeItem=="7"){
		applyType=applyType.replace(",125","");
		ifNeedChangeCatalog = "1";
	}

	if(ifNeedChangeCatalog == "1"){
		somElectronicDataSet_load();
	}
}

//增加法定代表人
function add(){

	//加载法定代表人法律要件
	somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
	somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
	somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
	somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
	somLegalPeopleElectronicDataSet.setParameter("applyType","121");
	somLegalPeopleElectronicDataSet.load();

	var win=L5.getCmp("legalPeopleWindow");
	win.show();
	initPhotoDetail(null);//初始化照片
}
//法定代表人录入中输入身份证号进行查询
function checkPeopleInfo(){
	var idCard=document.getElementById("idCard").value;
	//身份证号
	if(checkIDCard(document.getElementById("idCard")) != true){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		initPhotoDetail(null);//初始化照片
		return;
	}
	// 根据证件号码索引人员
	var record=somLegalPeopleDataSet.getCurrent();
	var winPeopleDataSet = L5.DatasetMgr.lookup("winPeopleDataSet");
	winPeopleDataSet.setParameter("ID_CARD",_$('idCard'));
	winPeopleDataSet.load();
	winPeopleDataSet.on('load', function(){
		if(winPeopleDataSet.getCount()>0){
			L5.getCmp("win_peopleValidate").show();
		}else{
			record.set("peopleId","");	//未查到人员时peopleId置空
		}
	});
	initPhoto(null);//初始化照片
}
//任职信息中新增人员
function addItem(){
	var idCard=document.getElementById("idCard").value;
	var somLegalPeopleDataSet = L5.DatasetMgr.lookup("somLegalPeopleDataSet");
	somLegalPeopleDataSet.removeAll();
	var record = somLegalPeopleDataSet.newRecord();
	record.set("idCard",idCard);
	//回填性别
	record.set("sex",getSexByCode(idCard));
	//回填出生年月
	record.set("birthday",getBirthByCode(idCard));
	//回填年龄
	$("age").innerHTML = getAgeByCode(idCard);

	var win = L5.getCmp("win_peopleValidate");
	win.hide();
}
//任职信息中回填此人信息
function editItem(){
	var grid=L5.getCmp("gridPeople");
	var record=grid.getSelectionModel().getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var ifLimit=record.get("ifLimit");
	var restrictPeopleId=record.get("restrictPeopleId");
	if(ifLimit=='1'){
		L5.Msg.alert("提示","此人为受限人员，不能担任负责人！",function(){
			return;
		});
	}else if(ifLimit=='0'){
		var command = new L5.Command("com.inspur.cams.sorg.restrict.cmd.SomRestrictPeopleDetailCmd");
		command.setParameter("PEOPLE_ID",restrictPeopleId);
		command.execute("getNum");
		var num = command.getReturn("num");
		if(num>0){
			L5.MessageBox.confirm('确定', '此人有'+num+'条受限记录，确定其担任负责人？',function(sta){
				if(sta=="yes"){
					editItemInfo();
					return;
				}else{
					return;
				}
			});
		}
	}else{
		editItemInfo();
	}
}
function editItemInfo(){
	var grid = L5.getCmp("gridPeople");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	var peopleId = record.get("peopleId");
	var somLegalPeopleDataSet = L5.DatasetMgr.lookup("somLegalPeopleDataSet");
	somLegalPeopleDataSet.removeAll();
	var newRecord = somLegalPeopleDataSet.newRecord();

		/*var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomDutyCmd");
		command.setParameter("peopleId", record.get('peopleId'));
		command.setParameter("sorgType", record.get('sorgType'));
		command.execute("checkLegalPeopleRepeat");
		var flag=command.getReturn("flag");
		if(flag != "true"){
			L5.MessageBox.confirm('确定', record.get("name")+flag+" 是否继续选定？",function(sta){
				if(sta=="yes"){

				}
				else return;
			});
			return;
		}

		L5.MessageBox.confirm('确定', '选定[ '+record.get("name")+' ]为法定代表人？',function(sta){
			if(sta=="yes"){

			}
			else return;
		});	*/

	newRecord.set("peopleId",record.get("peopleId"));
	newRecord.set("idCard",record.get("idCard"));
	$("age").innerHTML = getAgeByCode(record.get("idCard"));
	newRecord.set("name",record.get("name"));
	newRecord.set("aliasName",record.get("aliasName"));
	newRecord.set("sex",record.get("sex"));
	newRecord.set("folk",record.get("folk"));
	newRecord.set("ifFulltime",record.get("ifFulltime"));
	newRecord.set("personUnit",record.get("personUnit"));
	newRecord.set("personUnitPhone",record.get("personUnitPhone"));
	newRecord.set("birthday",record.get("birthday"));
	newRecord.set("nation",record.get("nation"));
	newRecord.set("politics",record.get("politics"));
	newRecord.set("education",record.get("education"));
	newRecord.set("birthplace",record.get("birthplace"));
	newRecord.set("phone",record.get("phone"));
	newRecord.set("adds",record.get("adds"));
	newRecord.set("ifRetire",record.get("ifRetire"));
	newRecord.set("populace",record.get("populace"));
	newRecord.set("postCode",record.get("postCode"));
	newRecord.set("workDuties",record.get("workDuties"));
	newRecord.set("workPhone",record.get("workPhone"));
	newRecord.set("workName",record.get("workName"));
	newRecord.set("ifPartyLeader",record.get("ifPartyLeader"));
	newRecord.set("resume",record.get("resume"));
	newRecord.set("profession",record.get("profession"));
	newRecord.set("peoplePartyType",record.get("peoplePartyType"));
	newRecord.set("joinDate",record.get("joinDate"));
	newRecord.set("relation",record.get("relation"));
	newRecord.set("partyDuties",record.get("partyDuties"));
	newRecord.set("ifMoblie",record.get("ifMoblie"));
	newRecord.set("developDate",record.get("developDate"));
	newRecord.set("activistsDate",record.get("activistsDate"));
	newRecord.set("applicationDate",record.get("applicationDate"));
	newRecord.set("ifLegal",record.get("ifLegal"));
	newRecord.set("photoId",record.get("photoId"));

	synPhoto(newRecord.get("photoId"),null);//同步照片

	var win = L5.getCmp("win_peopleValidate");
	win.hide();
}
//关闭窗口
function closeItem(){
	var win = L5.getCmp("win_peopleValidate");
	win.hide();
}
//选择是否党政机关领导
function valid_ifPartyLeader_add(){
	if(document.getElementById('ifPartyLeader_add').value == '1'){
		document.getElementById('promiseOrgan_add').style.display="block";
		document.getElementById('promiseCode_add').style.display="block";
	}else{
		document.getElementById('promiseOrgan_add').style.display="none";
		document.getElementById('promiseCode_add').style.display="none";
		document.getElementById('promiseOrgan_add').value="";
		document.getElementById('promiseCode_add').value="";
	}
}
// 增加个人简历
function addResume(){
	var somLegalPeopleResumeDataSet=L5.DatasetMgr.lookup("somLegalPeopleResumeDataSet");
	somLegalPeopleResumeDataSet.newRecord();
}
// 删除个人简历
function delResume(){
	var somLegalPeopleResumeDataSet=L5.DatasetMgr.lookup("somLegalPeopleResumeDataSet");
	var record=somLegalPeopleResumeDataSet.getCurrent();
	if(record!=null){
		somLegalPeopleResumeDataSet.remove(record);
	}
}
//点击确定 保存一条负责人信息
function confirm(){
	confirmInfo();
}
function confirmInfo(){
	var somLegalPeopleDataSet = L5.DatasetMgr.lookup("somLegalPeopleDataSet");
	//校验
	var somLegalPeopleValidate = somLegalPeopleDataSet.isValidate();
	if(somLegalPeopleValidate != true){
		L5.Msg.alert("提示",somLegalPeopleValidate);
		return false;
	}

	var record=somLegalPeopleDataSet.getCurrent();
	//邮编
	var postCode=record.get("postCode");
	if(postCode!=""&&_isPostCode(postCode) != true){
		L5.Msg.alert("提示","校验未通过："+"邮编格式不正确");
		return;
	}
	record.set("ifServe","1");
	//record.set("promiseOrgan",document.getElementById('promiseOrgan_add').value);
	//record.set("promiseCode",document.getElementById('promiseCode_add').value);

	//处理个人简历
	var somLegalPeopleResumeDataSet = L5.DatasetMgr.lookup("somLegalPeopleResumeDataSet");
	for(var i=somLegalPeopleResumeDataSet.getCount()-1;i>=0;i--){
		var somResumeInsertRecord =somLegalPeopleResumeDataSet.getAt(i);
		somResumeInsertRecord.set("peopleId",record.get("peopleId"));
	}

	document.getElementById("leaPeopleNameAfter").value=record.get("name");

	var win=L5.getCmp("legalPeopleWindow");
	win.hide();
}
function closePeopleWIn(){
	var win = L5.getCmp("legalPeopleWindow");
	win.hide();
}
function closePeopleDetailWIn(){
	var win = L5.getCmp("detailLegalPeopleWindow");
	win.hide();
}
function renderDate(value) {
	if(value.length>8){
		L5.Msg.alert("提示","日期不要超过8位,请检查！");
		return value;
	}
	return value;
}
//回退
function goBack(){
	history.go(-1);
}
//查看状态
function showStatus(){

}
//打印一次性补正材料通知书
function forPolishing(){
	var win=L5.getCmp("polishWin");
	win.show();
}

//打印一次性补正材料通知书
function forAddItem(){
	var win=L5.getCmp("polishWin");
	win.hide();
	var addItem=document.getElementById("addItem").innerHTML;
	var printTitle="申办材料补正通知书";
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var record=somApplyDataSet.getCurrent();
	var printRecord = new L5.Map();
	var date=record.get('appDate');
	printRecord.put("ACCEPT_DATE",dataFormatForChange(date));
	printRecord.put("TASK_CODE",record.get('taskCode'));
	printRecord.put("APPLY_ITEM","民办非企业单位主体变更");
	printRecord.put("ADD_ITEM",addItem);
	var curPeople='<%=BspUtil.getEmpOrgan().getOrganName()%>';
	printRecord.put("CUR_PEOPLE",curPeople);
	var curOrgan='<%=BspUtil.getOrganName()%>';
	printRecord.put("CUR_ORGAN",curOrgan);
	printReport(getPrintDataByMap(printTitle,printRecord),L5.webPath+'/jsp/cams/sorg/apply/group/mainChange/polish.fr3');

}

//打印不予受理通知书
function printNoAccept(){
	var url=rootPath+"jsp/cams/sorg/comm/print/noAcceptForPrint.jsp?sorgType=M";
	url+="&taskCode="+taskCode+"&applyType="+somApplyType+"&printPeople="+currentUserName;
	window.open(url);
}
//打印受理通知书
function printAccept(){
	var url=rootPath+"jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=M";
	url+="&taskCode="+taskCode+"&applyType="+somApplyType+"&printPeople="+currentUserName;
	window.open(url);
}

function getName(value,cellmeta,record,rowindex,colindex,dataset){
	var ifLimit=record.get('ifLimit');
	var name=record.get('name');
	var restrictPeopleId=record.get('restrictPeopleId');
	if(ifLimit == '1' ){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:red">' + name + '</a>';
	}else if(ifLimit == '0'){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:blue">' + name + '</a>';
	}else{
		return name;
	}
}
function getBirthday(value,cellmeta,record,rowindex,colindex,dataset){
	var ifLimit=record.get('ifLimit');
	var birthday=record.get('birthday');
	var restrictPeopleId=record.get('restrictPeopleId');
	if(ifLimit == '1' ){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:red">' + birthday + '</a>';
	}else if(ifLimit == '0'){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:blue">' + birthday + '</a>';
	}else{
		return birthday;
	}
}
function getSex(value,cellmeta,record,rowindex,colindex,dataset){
	var ifLimit=record.get('ifLimit');
	var sex=record.get('sex');
	var restrictPeopleId=record.get('restrictPeopleId');
	if(ifLimit == '1' ){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:red">' + sex + '</a>';
	}else if(ifLimit == '0'){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:blue">' + sex + '</a>';
	}else{
		return sex;
	}
}
function getIfLimit(value,cellmeta,record,rowindex,colindex,dataset){
	var ifLimit=record.get('ifLimit');
	var restrictPeopleId=record.get('restrictPeopleId');
	if(ifLimit == '1' ){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:red">' + '是' + '</a>';
	}else if(ifLimit == '0'){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:blue">' + '否' + '</a>';
	}else{
		return "";
	}
}
function showRestrict(restrictPeopleId){
	var somRestrictPeopleDetailDataSet=L5.DatasetMgr.lookup("somRestrictPeopleDetailDataSet");
	somRestrictPeopleDetailDataSet.setParameter("PEOPLE_ID",restrictPeopleId);
	somRestrictPeopleDetailDataSet.load();
	var win = L5.getCmp("restrictWin");
	win.show();
}
function closeRestrictWin(){
	var win = L5.getCmp("restrictWin");
	win.hide();
}
function sendForPolishing(){

}
//打印变更证明
function printChangeSign(){

}
</script>
</head>
<body>
<model:datasets>
	<!-- 变更业务dataset -->
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply"></model:record>
	</model:dataset>
	<!-- 变更申请dataset -->
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryMain">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<!-- 变更列表的dataset -->
	<model:dataset id="somChangeList" cmd="com.inspur.cams.sorg.manage.cmd.SomChangeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomChange"></model:record>
	</model:dataset>
	<!-- 变更window的dataset -->
	<model:dataset id="somChangeDataset" cmd="com.inspur.cams.sorg.manage.cmd.SomChangeCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomChange"></model:record>
	</model:dataset>

	<!-- 法定代表人录入窗口 -->
	<model:dataset id="somLegalPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty">
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
			<model:field name="sorgDuties" type="string" rule="length{100}" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="personUnit" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{50}" />
			<model:field name="resume" type="string" rule="length{1000}" />
		</model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somLegalPeopleResumeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<%--所有符合身份证号的人员列表--%>
	<model:dataset id="winPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleQueryCmd" method="queryRestrict">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople"></model:record>
	</model:dataset>
	<%--所有符合身份证号的人员职务列表--%>
	<model:dataset id="winDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<model:dataset id="somRestrictPeopleDetailDataSet" cmd="com.inspur.cams.sorg.restrict.cmd.SomRestrictPeopleDetailQueryCmd" sortField="addTime">
		<model:record fromBean="com.inspur.cams.sorg.restrict.data.SomRestrictPeopleDetail"></model:record>
	</model:dataset>
	<!-- 变更意见 -->
	<model:dataset id="somFlowAddDataset" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<model:field name="curOpinionId" type="string" rule="require" />
			<model:field name="curOpinion" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog" isGroup="true" groupField="applyType" pageSize="50">
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
	<%--法定代表人员电子档案--%>
	<model:dataset id="somLegalPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleCatalog" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--法定代表人员电子档案上传窗口--%>
	<model:dataset id="winLegalPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_GROUP_KIND'></model:param>
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
	<model:dataset id="sorgCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_ORGAN'></model:param>
			<model:param name="value" value='SORG_CODE'></model:param>
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
	<!-- 文化程度 -->
	<model:dataset id="educationSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EDUCATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!--  -->
	<model:dataset id="ifServeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DUTY_IF_SERVE'></model:param>
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
	<!-- 证件类型 -->
	<model:dataset id="cardTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CARD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
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
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="somChangeItem" enumName="SOM.UNGOV_CHANGE.ITEM"  autoLoad="true" global="true"></model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="sourceTypeSelect" enumName="SOM.RESTRICT.SOURCE_TYPE" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel title="民办非企业单位变更" width="100%" height="100%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
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
						<next:ToolBarItem iconCls="<%=buttonIMG%>" text="<%=buttonName %>" handler="<%=buttonFunName %>" />
				<%
					}
				%>
	</next:TopBar>
	<next:TabPanel id="tab" activeTab="1" width="100%" height="100%">
		<next:Tabs>
			<next:Panel title="民办非企业单位变更登记申请表"  width="100%" height="100%" autoScroll="true">
				<next:Panel>
					<next:Html>
					<fieldset><legend>变更信息</legend>
					<form method="post" onsubmit="return false" class="L5form">
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width: 10%;"> <label>申请时间：</label></td>
							<td class="FieldInput" style="width: 10%;"><label id="changeDate"/></td>
							<td class="FieldLabel" style="width: 10%;"><label>民办非企业单位名称：</label></td>
							<td class="FieldInput" style="width: 10%;"><label id="cnName"></label></td>
						</tr>
					</table>
					</form>
					</fieldset>
					</next:Html>
				</next:Panel>
				<next:EditGridPanel id="changeEdit" dataset="somChangeList" height="60%" autoScroll="true" >
					<next:TopBar>
						<next:ToolBarItem text='' id="displayItem"/>
						<next:ToolBarItem symbol="变更事项"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem text="增加变更" iconCls="add" handler="forAdd"></next:ToolBarItem>
						<next:ToolBarItem text="查看变更" iconCls="edit" handler="forDetail"></next:ToolBarItem>
						<next:ToolBarItem text="删除变更" iconCls="remove" handler="forDelete"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="变更事项" field="changeItem"
							 width="19%" editable="false" dataset="somChangeItem">
							<next:TextField />
						</next:Column>
						<next:Column header="变更前" field="changeBefore"
							 width="30%"editable="false">
							<next:TextField/>
						</next:Column>
						<next:Column header="拟变更为" field="changeAfter"
							 width="20%" editable="false">
							<next:TextField/>
						</next:Column>
						<next:Column header="变更理由" field="changeReason"
							 width="28%" editable="false">
							<next:TextField/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				<next:Html>


					<%
																if ("supply".equals(request
																							.getParameter("actname"))) {
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
				</next:Html>
			</next:Panel>
			<next:Panel title="法律要件" >
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet" autoScroll="true">
					<next:GroupingView forceFit="true"></next:GroupingView>
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
						<next:Column header="下载附件" field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
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
			<next:Panel title="处理意见" id="ipinionPanel" width="100%" height="100%" autoScroll="true" style="display:block;">
				<next:Html>
					<form method="post" onsubmit="return false" class="L5form" dataset="somFlowAddDataset">
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
<!--添加变更  -->
<next:Window id="AddChange" closeAction="hide" title="添加变更" width="400"  autoScroll="true" modal="true">
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form">
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:15%"><label>变更事项：</label></td>
				<td class="FieldInput"style="width:15%"><select id="addChangeItem" ><option dataset="somChangeItem" ></option></select></td>
				<td class="FieldLabel"style="width:15%"><input type="button" value="确定" onclick="forChangeItem(addChangeItem.value)"/></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<!-- 社会组织名称变更 -->
<next:Window closable="false"id="AddChange0" closeAction="hide" title="名称变更" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forNameMove" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:25%"><label>名称变更前：</label></td>
					<td class="FieldInput"style="width:75%" ><label id="nameBefore"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">名称变更为：</label></td>
					<td class="FieldInput"><input id='nameAfter' type="text"  style="width:98%"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更程序：</label></td>
					<td class="FieldInput"><textArea id="nameDesc" cols="75" rows="4" style="width: 100%" field="changeDesc"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
					<td class="FieldInput"><textArea cols="75" id="nameReason" rows="4" style="width: 100%" field="changeReason"></textArea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>

<!-- 法定代表人变更 -->
<next:Window closable="false"id="AddChange2" closeAction="hide" title="法定代表人变更" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forLeaPeopleMove" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:15%"><label>法定代表人姓名变更前：</label></td>
					<td class="FieldInput"style="width:15%"><label  id="leaPeopleNameBefore" /></td>
					<td class="FieldLabel"style="width:15%" style="color:blue"><label>法定代表人姓名变更为：</label></td>
					<td class="FieldInput"style="width:15%"><input id='leaPeopleNameAfter' field="changeAfter" type="text" onclick="add()" readonly="readonly"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更程序：</label></td>
					<td class="FieldInput" colspan="5"><textArea id="leaPeopleDesc" cols="75" rows="4" style="width: 100%" field="changeDesc"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
					<td class="FieldInput" colspan="5"><textArea id="leaPeopleReason" cols="75" rows="4" style="width: 100%" field="changeReason"></textArea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 住所变更 -->
<next:Window closable="false"id="AddChange1" closeAction="hide" title="住所变更" width="500"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forHouseMove" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:25%"><label>住所来源变更前：</label></td>
					<td class="FieldInput"style="width:25%"><select  id="houseSourceBefore" disabled="disabled"><option  dataset="resideSourceSelect"></option></select></td>
					<td class="FieldLabel"><label>用房面积变更前：</label></td>
					<td class="FieldInput"><label  id="houseAreaBefore"  /></td>
					</tr>
				<tr>
					<td class="FieldLabel"><label>住所名称变更前：</label></td>
					<td class="FieldInput" colspan="3"><label id="houseNameBefore"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>产权单位变更前：</label></td>
					<td class="FieldInput" colspan="3"><label id="houseBorgBefore" /></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>租借期限变更前：</label></td>
					<td class="FieldInput" colspan="3"><label id="houseDateBefore" /></td>
				</tr>
				<tr>
					<td class="FieldLabel"style="width:15%"><label style="color:blue">住所来源变更为：</label></td>
					<td class="FieldInput"style="width:15%"><select id="houseSourceAfter" ><option dataset="resideSourceSelect"></option ></select></td>
					<td class="FieldLabel"><label style="color:blue">用房面积变更为：</label></td>
					<td class="FieldInput"><input type="text"  id="houseAreaAfter" /></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">住所名称变更为：</label></td>
					<td class="FieldInput" colspan="3"><input id="houseNameAfter" type="text" style="width:98%"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">产权单位变更为：</label></td>
					<td class="FieldInput" colspan="3"><input id="houseBorgAfter" type="text" style="width:98%"/></td>
				</tr>

				<tr>
					<td class="FieldLabel"><label style="color:blue">租借期限变更为：</label></td>
					<td class="FieldInput" colspan="3"><input type="text" id="houseDateAfter" /></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更程序：</label></td>
					<td class="FieldInput" colspan="5"><textArea id="houseDesc" cols="75" rows="4" style="width: 100%" field="changeDesc"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
					<td class="FieldInput" colspan="5"><textArea id="houseReason" cols="75" rows="4" style="width: 100%" field="changeReason"></textArea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 业务范围变更 -->
<next:Window closable="false"id="AddChange3" closeAction="hide" title="业务范围变更" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forBusinessMove" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:25%"><label>业务范围变更前：</label></td>
					<td class="FieldInput" style="width:75%"><textArea id="businessNameBefore" disabled="disabled" field="changeBefore" cols="75" rows="4" style="width: 100%" ></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"style="width:15%"><label style="color:blue">业务范围变更为：</label></td>
					<td class="FieldInput" style="width:15%"><textArea id="businessNameAfter" field="changeAfter" cols="75" rows="4" style="width: 100%" ></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更程序：</label></td>
					<td class="FieldInput" colspan="5"><textArea id="businessDesc" cols="75" rows="4" style="width: 100%" field="changeDesc"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
					<td class="FieldInput" colspan="5"><textArea id="businessReason" cols="75" rows="4" style="width: 100%" field="changeReason"></textArea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 变更开办资金 -->
<next:Window closable="false"id="AddChange4" closeAction="hide" title="开办资金变更" width="500"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forMoneyMove" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:30%"><label>开办资金数额变更前：</label></td>
					<td class="FieldInput" style="width:70%"><label id="moneyBefore"></label>万元</td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>资金来源变更前：</label></td>
					<td class="FieldInput"><label id="moneySourceBefore" /></td>
				</tr>
				<tr>
						<td class="FieldLabel"><label style="color:blue">开办资金数额变更为：</label></td>
					<td class="FieldInput"><input id="moneyAfter" type="text" style="width:80%"/>万元</td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">资金来源变更为：</label></td>
					<td class="FieldInput"><input id="moneySourceAfter" type="text" style="width:80%"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更程序：</label></td>
					<td class="FieldInput" colspan="5"><textArea id="moneyDesc" cols="75" rows="4" style="width: 100%" field="changeDesc"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
					<td class="FieldInput" colspan="5"><textArea id="moneyReason" cols="75" rows="4" style="width: 100%" field="changeReason"></textArea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 业务主管单位变更 -->
<next:Window closable="false"id="AddChange5" closeAction="hide" title="业务主管单位变更" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forBorgMove" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:25%"><label>变更前业务主管单位：</label></td>
					<td class="FieldInput"style="width:75%"><select
						id="borgNameBefore" disabled="disabled"style="width:80%">
						<option dataset="businessOrganSelect"></option>
					</select></td>
					</tr>
					<tr>
					<td class="FieldLabel"style="width:15%"><label style="color:blue">变更为业务主管单位：</label></td>
					<td class="FieldInput"style="width:15%"><select
						id='borgNameAfter' style="width:80%">
						<option dataset="businessOrganSelect"></option>
					</select></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更程序：</label></td>
					<td class="FieldInput" colspan="5"><textArea id="borgDesc" cols="75" rows="4" style="width: 100%" field="changeDesc"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
					<td class="FieldInput" colspan="5"><textArea id="borgReason" cols="75" rows="4" style="width: 100%" field="changeReason"></textArea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 社会团体名称变更 -->
<next:Window id="detail0" closeAction="hide" title="名称变更" modal="true" width="600"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:25%"><label>名称变更前：</label></td>
					<td class="FieldInput"style="width:75%"><label id="nameBefore1"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"style="width:25%"><label style="color:blue">名称变更为：</label></td>
					<td class="FieldInput"style="width:75%"><label id='nameAfter1' style="color:blue"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"style="width:25%"><label style="color:blue">变更程序：</label></td>
					<td class="FieldInput"style="width:75%"><textArea cols="75" rows="4" style="width: 100%;color:blue" field="changeDesc" readonly="readonly"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"style="width:25%"><label style="color:blue">变更理由：</label></td>
					<td class="FieldInput"style="width:75%"><textArea cols="75" rows="4" style="width: 100%;color:blue" field="changeReason" readonly="readonly"></textArea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 法定代表人变更 -->
<next:Window id="detail2" closeAction="hide" title="法定代表人变更" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="查看法定代表人登记表" iconCls="add" handler="detailLegalPeople" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:15%"><label>法定代表人姓名变更前：</label></td>
					<td class="FieldInput"style="width:15%"><label  id="leaPeopleNameBefore1" /></td>
					<td class="FieldLabel"style="width:15%" style="color:blue"><label>法定代表人姓名变更为：</label></td>
					<td class="FieldInput"style="width:15%"><label id='leaPeopleNameAfter1' style="color:blue"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更程序：</label></td>
					<td class="FieldInput" colspan="5"><textArea cols="75" rows="4" style="width: 100%;color:blue" readonly="readonly" field="changeDesc"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
					<td class="FieldInput" colspan="5"><textArea cols="75" rows="4" style="width: 100%;color:blue" readonly="readonly"  field="changeReason"></textArea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 住所变更 -->
<next:Window id="detail1" closeAction="hide" title="住所变更" width="500"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:25%"><label>住所来源变更前：</label></td>
					<td class="FieldInput"style="width:25%"><select  id="houseSourceBefore1" disabled="disabled"><option  dataset="resideSourceSelect"></option></select></td>
					<td class="FieldLabel"style="width:25%"><label>用房面积变更前：</label></td>
					<td class="FieldInput"style="width:25%"><label  id="houseAreaBefore1"  /></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>住所名称变更前：</label></td>
					<td class="FieldInput" colspan="3"><label id="houseNameBefore1"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>产权单位变更前：</label></td>
					<td class="FieldInput" colspan="3"><label id="houseBorgBefore1" /></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>租借期限变更前：</label></td>
					<td class="FieldInput" colspan="3"><label id="houseDateBefore1" /></td>
				</tr>
				<tr>
					<td class="FieldLabel"style="width:15%"><label style="color:blue">住所来源变更为：</label></td>
					<td class="FieldInput"style="width:15%"><select id="houseSourceAfter1" disabled="disabled" style="color:blue"><option dataset="resideSourceSelect"></option ></select></td>
					<td class="FieldLabel"><label style="color:blue">用房面积变更为：</label></td>
					<td class="FieldInput"><label   id="houseAreaAfter1"  style="color:blue"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">住所名称变更为：</label></td>
					<td class="FieldInput" colspan="3"><label id="houseNameAfter1"  style="color:blue"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">产权单位变更为：</label></td>
					<td class="FieldInput" colspan="3"><label id="houseBorgAfter1"  style="color:blue"/></td>
				</tr>

				<tr>
					<td class="FieldLabel"><label style="color:blue">租借期限变更为：</label></td>
					<td class="FieldInput" colspan="3"><label  style="color:blue" id="houseDateAfter1" /></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更程序：</label></td>
					<td class="FieldInput" colspan="5"><textArea cols="75" readonly="readonly" rows="4" style="width: 100%;color:blue" field="changeDesc"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
					<td class="FieldInput" colspan="5"><textArea cols="75" readonly="readonly" rows="4" style="width: 100%;color:blue"  field="changeReason"></textArea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 业务范围变更 -->
<next:Window id="detail3" closeAction="hide" title="业务范围变更" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:25%"><label>业务范围变更前：</label></td>
					<td class="FieldInput"style="width:75%"><textArea  id='areaChangeBefore' readonly="readonly" cols="75" rows="4" style="width: 100%"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"style="width:15%"><label style="color:blue">业务范围变更为：</label></td>
					<td class="FieldInput"style="width:15%"><textArea  id="areaChangeAfter" readonly="readonly" cols="75" rows="4" style="width: 100%;color:blue"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更程序：</label></td>
					<td class="FieldInput" colspan="5"><textArea readonly="readonly" cols="75" rows="4" style="width: 100%;color:blue" field="changeDesc"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
					<td class="FieldInput" colspan="5"><textArea readonly="readonly"  cols="75" rows="4" style="width: 100%;color:blue"  field="changeReason"></textArea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 变更开办资金 -->
<next:Window id="detail4" closeAction="hide" title="开办资金变更" width="500"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDataset" >
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:30%"><label>开办资金数额变更前：</label></td>
					<td class="FieldInput" style="width:70%"><label id="moneyBefore1"></label>万元</td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>资金来源变更前：</label></td>
					<td class="FieldInput" colspan="3"><label id="moneySourceBefore1" /></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">开办资金数额变更为：</label></td>
					<td class="FieldInput"><label id="moneyAfter1" style="color:blue"></label>万元</td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">资金来源变更为：</label></td>
					<td class="FieldInput" colspan="3"><label id="moneySourceAfter1"  style="color:blue"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更程序：</label></td>
					<td class="FieldInput" colspan="5"><textArea cols="75" readonly="readonly" rows="4" style="width: 100%;color:blue" field="changeDesc"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
					<td class="FieldInput" colspan="5"><textArea cols="75" readonly="readonly" rows="4" style="width: 100%;color:blue"  field="changeReason"></textArea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 业务主管单位变更 -->
<next:Window id="detail5" closeAction="hide" title="业务主管单位变更" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:25%"><label>变更前业务主管单位：</label></td>
					<td class="FieldInput"style="width:75%"><select
						id="borgNameBefore1" disabled="disabled" style="width:80%">
						<option dataset="businessOrganSelect"></option>
					</select></td>
				</tr>
				<tr>
					<td class="FieldLabel"style="width:15%"><label style="color:blue">变更为业务主管单位：</label></td>
					<td class="FieldInput"style="width:15%">
					<select field="changeAfter" id='borgNameAfter1'disabled="disabled" style="width:80%;color:blue">
						<option dataset="businessOrganSelect"></option>
					</select></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更程序：</label></td>
					<td class="FieldInput" colspan="5"><textArea cols="75" readonly="readonly" rows="4" style="width: 100%;color:blue" field="changeDesc"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
					<td class="FieldInput" colspan="5"><textArea cols="75" readonly="readonly" rows="4" style="width: 100%;color:blue"  field="changeReason"></textArea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 出资人变更 -->
<next:Window id="detail7" closeAction="hide" title="出资人变更" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:25%"><label>出资人变更前：</label></td>
					<td class="FieldInput"style="width:75%"><textArea id="monPeopleChangeBefore1"readonly="readonly" cols="75" rows="4" style="width: 100%"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"style="width:15%"><label style="color:blue">出资人变更为：</label></td>
					<td class="FieldInput"style="width:15%"><textArea  id='monPeopleChangeAfter1' readonly="readonly" cols="75" rows="4" style="width:100%;color:blue"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更程序：</label></td>
					<td class="FieldInput" colspan="5"><textArea field="changeDesc" readonly="readonly" cols="75" rows="4" style="width: 100%;color:blue"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
					<td class="FieldInput" colspan="5"><textArea   field="changeReason"readonly="readonly"  cols="75" rows="4" style="width: 100%;color:blue" ></textArea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 出资人变更 -->
<next:Window closable="false"id="AddChange7" closeAction="hide" title="出资人变更" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forMonPeopleMove" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:25%"><label>出资人变更前：</label></td>
					<td class="FieldInput" style="width:75%"><textArea id="monPeopleChangeBefore" disabled="disabled" field="changeBefore" cols="75" rows="4" style="width: 100%" ></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"style="width:15%"><label style="color:blue">出资人变更为：</label></td>
					<td class="FieldInput" style="width:15%"><textArea id='monPeopleChangeAfter'  field="changeAfter" cols="75" rows="4" style="width: 100%" ></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更程序：</label></td>
					<td class="FieldInput" colspan="5"><textArea  cols="75" id='monPeopleDesc' rows="4" style="width: 100%" field="changeDesc"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
					<td class="FieldInput" colspan="5"><textArea  cols="75" id='monPeopleReason' rows="4" style="width: 100%" field="changeReason"></textArea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 调取人员档案 -->
<next:Window id="win_peopleValidate" title="人员身份验证" resizable="false" width="500" height="403" modal="true" closable="false">
	<next:EditGridPanel id="gridPeople" width="486" stripeRows="true" height="170" dataset="winPeopleDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="人员列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="edit" text="回填信息" handler="editItem"></next:ToolBarItem>
				<next:ToolBarItem iconCls="delete" text="关闭窗口" handler="closeItem"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="姓名" field="name" width="100" sortable="true" editable="false"renderer="getName"><next:TextField/></next:Column>
			<next:Column header="出生年月" field="birthday" width="100" sortable="true" editable="false"renderer="getBirthday"><next:TextField/></next:Column>
			<next:Column header="性别" field="sex" width="100" sortable="true" editable="false" dataset="sexDataSet"renderer="getSex"><next:TextField/></next:Column>
			<next:Column header="是否受限人员" field="ifLimit" width="120" sortable="true" editable="false"  dataset="sexDataSet" renderer="getIfLimit"><next:TextField /></next:Column>
			<next:Column header="受限人员id" field="restrictPeopleId" width="142" sortable="true" editable="false"  hidden="true"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="winPeopleDataSet"/>
		</next:BottomBar>
	</next:EditGridPanel>
	<next:EditGridPanel id="gridDuty" width="486" stripeRows="true" height="202" dataset="winDutyDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="担任职务"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:Column header="组织名称" field="sorgId" width="165" sortable="false" editable="false" dataset="sorgNameSelect"><next:TextField/></next:Column>
			<next:Column header="职务" field="sorgDuties" width="120" sortable="false" editable="false" dataset="sorgDutiesSelect"><next:TextField/></next:Column>
			<next:Column header="任职状态" field="regStatus" width="80" sortable="false" editable="false" dataset="ifServeSelect"><next:TextField/></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="winDutyDataSet"/>
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
<next:Window id="restrictWin" title="受限人员详情" resizable="false"
	width="800" height="400" modal="true" closable="false">
	<next:EditGridPanel id="restrictGrid" width="787" stripeRows="true"
		height="370" dataset="somRestrictPeopleDetailDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="delete" text="关闭"
				handler="closeRestrictWin"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="添加原因" field="sourceType" width="150"
				sortable="false" editable="false" dataset="sourceTypeSelect">
				<next:TextField />
			</next:Column>
			<next:Column header="是否法定代表人" field="ifLegal" width="120"
				sortable="false" editable="false" dataset="comm_yesorno">
				<next:TextField />
			</next:Column>
			<next:Column header="社会组织名称" field="sorgCode" width="200"
				sortable="false" editable="false" dataset="sorgCodeSelect">
				<next:TextField />
			</next:Column>
			<next:Column header="登记证号" field="sorgCode" width="150"
				sortable="false" editable="false">
				<next:TextField />
			</next:Column>
			<next:Column header="添加单位" field="addOrganName" width="150"
				sortable="false" editable="false">
				<next:TextField />
			</next:Column>
			<next:Column header="添加人" field="addPersonName" width="150"
				sortable="false" editable="false">
				<next:TextField />
			</next:Column>
			<next:Column header="添加时间" field="addTime" width="150"
				sortable="false" editable="false">
				<next:TextField />
			</next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="somRestrictPeopleDetailDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>

<!-- 法定代表人录入窗口 -->
<next:Window id="legalPeopleWindow" closeAction="hide" title="法定代表人登记表" height="350" width="850" modal="true">
	<next:TabPanel  width="98%" height="84%">
		<next:Tabs>
			<next:Panel title="基本信息"  width="100%" height="100%" autoScroll="true">
				<next:Html>
					<form  method="post" dataset="somLegalPeopleDataSet" onsubmit="return false" class="L5form">
						<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:12%">姓名：</td>
									<td class="FieldInput" style="width:12%"> <input type="text"style="width:90%"  field="name" name="姓名"><span style="color:red">*</span></td>
									<td class="FieldLabel"style="width:12%">性别：</td>
									<td class="FieldInput"style="width:10%">
										<select field="sex" name='"性别"' style="width:90%">
											<option dataset="sexSelect"></option>
										</select></td>
									<td class="FieldLabel"style="width:10%">民族：</td>
									<td class="FieldInput"style="width:10%">
									<select field="folk" name='"民族"' style="width:90%">
											<option dataset="folkSelect"></option>
										</select>
									 </td>
									<td class="FieldInput" style="width:10%" nowrap colspan="1" rowspan="5">
									<div id="photoDiv" align="center">
										<img id="img" name="RELATIONER_PHOTOC_IMG" width=82.5 height=110 src="<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg"
										align="top" ondblclick="editPhoto(1,'photoId','RELATIONER_PHOTOC_IMG');"
										onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg'" alt="暂无图片" />
										<input type="hidden" id="photoId" name="photoId"/>
									</div>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">政治面貌：</td>
									<td class="FieldInput">
										<select field="politics" name='"政治面貌"' style="width:90%">
											<option dataset="politicsSelect"></option>
										</select>
									</td>
									<td class="FieldLabel">文化程度：</td>
									<td class="FieldInput" colspan="3"><select field="education" name='"文化程度"' style="width:90%">
											<option dataset="educationSelect"></option>
										</select>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">出生日期：</td>
									<td class="FieldInput">
										<input type="text" id="birthday" field="birthday"  name='"出生日期"' format="Y-m-d" onclick="WdatePicker()" style="width:90%"/>
									</td>
									<td class="FieldLabel" style="width:15%">身份证号码：</td>
									<td class="FieldInput" style="width:21%" colspan="3"><input type="text"  field="idCard" name="身份证号码" style="width:90%"></td>

								</tr>
								<tr>
									<td class="FieldLabel">职务：</td>
									<td class="FieldInput" ><input type="text" style="width:90%" field="sorgDuties" name="职务"></td>
									<td class="FieldLabel">技术职称：</td>
									<td class="FieldInput" colspan="3"><input type="text"style="width:90%"  field="profession" name="技术职称"> </td>
								</tr>
								<tr>
									<td class="FieldLabel">户口所在地：</td>
									<td class="FieldInput" colspan="5"><input type="text" style="width:90%" field="populace" name="户口所在地"> </td>
								</tr>
								<tr>
									<td class="FieldLabel">家庭住址：</td>
									<td class="FieldInput" colspan="2"><input type="text"style="width:90%"  field="adds" name="家庭住址"> </td>
									<td class="FieldLabel">邮编：</td>
									<td class="FieldInput"><input type="text" style="width:90%" field="postCode" name="邮编"> </td>
									<td class="FieldLabel">电话：</td>
									<td class="FieldInput"><input type="text"style="width:90%"  field="phone" name="电话">  </td>
								</tr>
								<tr>
									<td class="FieldLabel">人事关系所在单位：</td>
									<td class="FieldInput" colspan="4"><input type="text"style="width:90%"  field="personUnit" name="人事关系所在单位"> </td>
									<td class="FieldLabel">电话：</td>
									<td class="FieldInput"><input type="text" style="width:90%" field="personUnitPhone" name="人事关系所在单位电话"> </td>
								</tr>
							</table>
					</form>
				</next:Html>
			</next:Panel>
			<next:EditGridPanel id="somResumeLegalGrid" dataset="somLegalPeopleResumeDataSet" stripeRows="true" title="本人简历" width="100%" height="300" autoScroll="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add" text="增加" handler="addResume"></next:ToolBarItem>
					<next:ToolBarItem iconCls="delete" text="删除" handler="delResume"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn/>
					<next:Column header="内码" field="id" width="10%" editable="true" hidden="true"><next:TextField/></next:Column>
					<next:Column header="开始年月" field="startDate" width="10%" editable="true"><next:TextField/></next:Column>
					<next:Column header="结束年月" field="endDate" width="10%" editable="true"><next:TextField/></next:Column>
					<next:Column header="在何地区何单位" field="workOrgan" width="30%" editable="true"><next:TextField/></next:Column>
					<next:Column header="任（兼）何职" field="duty" width="20%" editable="true"><next:TextField/></next:Column>
				</next:Columns>
			</next:EditGridPanel>
			<next:EditGridPanel id="uploadLegalPeopleGrid" title="法律要件" stripeRows="true" dataset="somLegalPeopleElectronicDataSet" width="100%" height="100%" autoScroll="true">
				<next:TopBar>
					<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add" text="增加上传附件" handler="uploadLegalPeopleFile"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn />
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="档案目录名" field="catalogCode" width="25%" editable="false" dataset="cataLogCodeSelect">
						<next:TextField />
					</next:Column>
					<next:Column header="附件名称" field="fileName" width="15%" editable="false">
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
		<next:ToolButton text="确定" handler="confirm"></next:ToolButton>
		<next:ToolButton text="关闭" handler="closePeopleWIn"></next:ToolButton>
	</next:Buttons>
</next:Window>

<!-- 法定代表人明细窗口 -->
<next:Window id="detailLegalPeopleWindow" closeAction="hide" title="法定代表人登记表" height="350" width="800" modal="true">
	<next:TabPanel  width="98%" height="84%" id="detailLegalPeopleTab">
		<next:Tabs>
			<next:Panel title="基本信息"  width="100%" height="100%" autoScroll="true">
				<next:Html>
					<form  method="post" dataset="somLegalPeopleDataSet" onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width:12%">姓名：</td>
								<td class="FieldInput" style="width:12%"><label  field="name"></label></td>
								<td class="FieldLabel"style="width:12%">性别：</td>
								<td class="FieldInput"style="width:10%"><label  field="sex" dataset="sexSelect"></label>
									 </td>
								<td class="FieldLabel"style="width:10%">民族：</td>
								<td class="FieldInput"style="width:10%">
									<label  field="folk" dataset="folkSelect"></label>
								 </td>
								<td class="FieldInput" style="width:10%" nowrap colspan="1" rowspan="5">
								<div id="photoDiv" align="center">
									<img id="img" name="RELATIONER_PHOTOC_IMG" width=82.5 height=110 src="<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg"
									align="top" ondblclick="editPhoto(1,'photoId','RELATIONER_PHOTOC_IMG');"
									onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg'" alt="暂无图片" />
									<input type="hidden" id="photoId" name="photoId"/>
								</div>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel">政治面貌：</td>
								<td class="FieldInput">
									<label  field="politics" dataset="politicsSelect"></label>
								</td>
								<td class="FieldLabel">文化程度：</td>
								<td class="FieldInput" colspan="3">
									<label  field="education" dataset="educationSelect"></label>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel">出生日期：</td>
								<td class="FieldInput">
										<label  field="birthday" ></label>
								</td>
								<td class="FieldLabel" style="width:15%">身份证号码：</td>
								<td class="FieldInput" style="width:21%" colspan="3">
									<label  field="idCard" ></label>
								</td>

							</tr>
							<tr>
								<td class="FieldLabel">职务：</td>
								<td class="FieldInput" >
									<label  field="sorgDuties" ></label>
								</td>
								<td class="FieldLabel">技术职称：</td>
								<td class="FieldInput" colspan="3">
									<label  field="profession" ></label>
								 </td>
							</tr>
							<tr>
								<td class="FieldLabel">户口所在地：</td>
								<td class="FieldInput" colspan="5">
									<label  field="populace" ></label>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel">家庭住址：</td>
								<td class="FieldInput" colspan="2">
									<label  field="adds" ></label>
								 </td>
								<td class="FieldLabel">邮编：</td>
								<td class="FieldInput">
									<label  field="postCode" ></label>
								</td>
								<td class="FieldLabel">电话：</td>
								<td class="FieldInput">
									<label  field="phone" ></label>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel">人事关系所在单位：</td>
								<td class="FieldInput" colspan="4">
									<label  field="personUnit" ></label>
								</td>
								<td class="FieldLabel">电话：</td>
								<td class="FieldInput">
									<label  field="personUnitPhone" ></label>
								</td>
							</tr>
						</table>
					</form>
				</next:Html>
			</next:Panel>
			<next:EditGridPanel dataset="somLegalPeopleResumeDataSet" stripeRows="true" title="本人简历" width="100%" height="100%" autoScroll="true">
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
			<next:EditGridPanel title="法律要件" stripeRows="true" dataset="somLegalPeopleElectronicDataSet" width="100%" height="100%" autoScroll="true">
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
		<next:ToolButton text="关闭" handler="closePeopleDetailWIn"></next:ToolButton>
	</next:Buttons>
</next:Window>
<!-- 上传附件列表 -->
<next:Window id="uploadList" closeAction="hide"  title="附件上传列表" width="580" height="300" autoScroll="true"modal="true">
	<next:EditGridPanel id="uploadListGrid" width="566" stripeRows="true" height="269" dataset="winElectronicDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="upload" text="增加上传附件" handler="addUploadFile"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="closeUploadFile"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="档案目录名"  field="catalogCode" editable="false" hidden="true"><next:TextField /></next:Column>
			<next:Column header="附件名称" width="220" field="fileName" editable="false"><next:TextField /></next:Column>
			<next:Column header="附件描述" width="200" field="fileMess" editable="false"><next:TextField /></next:Column>
			<next:Column header="删除附件" field="" width="80" editable="false" renderer="delUploadFile"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="winElectronicDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
<!-- 上传附件窗口 -->
<next:Window id="uploadWin" closeAction="hide" title="上传附件" height="230" width="600" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="上传" handler="click_upload"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="close_upload"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form_content" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
			<tr>
				<td class="FieldLabel" style="width:20%">附件描述</td>
				<td class="FieldInput" colspan="5" style="width:80%"><textarea id="fileMess" rows="5" style="width:95%"></textarea></td>
			</tr>
			<tr>
				<td class="FieldLabel">附件上传：</td>
				<td class="FieldInput" colspan="5"><input class="file" type="file" id="files" name="files" style="width:95%;height:40"/></td>
    		</tr>
    		<tr>
    			<td class="FieldInput" colspan="6"><span style="color:red">上传文件最大不能超过10M</span></td>
    		</tr>
		</table>
		</form>
   </next:Html>
</next:Window>
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
<!-- 上传法定代表人员附件列表 -->
<next:Window id="uploadLegalPeopleList" closeAction="hide"  title="附件上传列表" width="580" height="300" autoScroll="true"modal="true">
	<next:EditGridPanel id="uploadLegalPeopleListGrid" width="566" stripeRows="true" height="269" dataset="winLegalPeopleElectronicDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="upload" text="增加上传附件" handler="addUploadLegalPeopleFile"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="closeUploadLegalPeopleFile"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="档案目录名"  field="catalogCode" editable="false" hidden="true"><next:TextField /></next:Column>
			<next:Column header="附件名称" width="220" field="fileName" editable="false"><next:TextField /></next:Column>
			<next:Column header="附件描述" width="200" field="fileMess" editable="false"><next:TextField /></next:Column>
			<next:Column header="删除附件" field="" width="80" editable="false" renderer="delLegalPeopleUploadFile"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="winLegalPeopleElectronicDataSet"/>
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
<!-- 上传法定代表人员附件窗口 -->
<next:Window id="uploadLegalPeopleWin" closeAction="hide" title="上传附件" height="230" width="600" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="上传" handler="click_uploadLegalPeople"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="close_uploadLegalPeople"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form_content_legalPeople" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
			<tr>
				<td class="FieldLabel" style="width:20%">附件描述</td>
				<td class="FieldInput" colspan="5" style="width:80%"><textarea id="legalPeopleFileMess" rows="5" style="width:95%"></textarea></td>
			</tr>
			<tr>
				<td class="FieldLabel">附件上传：</td>
				<td class="FieldInput" colspan="5"><input class="file" type="file" id="legalPeopleFiles" name="files" style="width:95%;height:40"/></td>
    		</tr>
    		<tr>
    			<td class="FieldInput" colspan="6"><span style="color:red">上传文件最大不能超过10M</span></td>
    		</tr>
		</table>
		</form>
	</next:Html>
</next:Window>
</body>
</html>