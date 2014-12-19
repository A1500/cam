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
<html>
<!-- 社会团体分支/代表机构变更流程页面 -->
<head>
	<next:ScriptManager></next:ScriptManager>
	<script type="text/javascript" src="<%=SkinUtils.getJS(request, "changeCheck.js")%>"></script>
	<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js") %>'></script>
	<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js") %>'></script>
	<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
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
	var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
	var actDefUniqueId ="<%=actDefUniqueId%>";
	var actname='<%=actname%>';
	var legalDuties='<%=legalDuties%>';//负责人职务代码
	var somApplyType="006";
	var applyType="027";
	var fileCodeF="S064";
	var legalDutyId="";
</script>
<script type="text/javascript">
var sorgId='';
var sorgKind='';
var cnName='';//社会团体名称
var cnNameM='';
var sorgDuties='';//社会团体职务
var taskCode='';
var changeNUM='';
var sorgRecord='';
var catalogName='';//档案目录名
var forCheck= new Array();//检验变更事项用的数组
var somLegalPeople='';//法定代表人用record
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
	var opinionSelect=L5.DatasetMgr.lookup("opinionSelect1");
	opinionSelect.filterBy(function(record, id){
		if("0,1".indexOf(record.get('value'))>-1){
			return record;
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
			somLegalPeopleElectronicDataSet.setParameter("applyType","030");
			somLegalPeopleElectronicDataSet.load();
			somElectronicDataSet_load();
		});
	}
}
function funAdd(somApplyDataSet){
	sorgRecord= somApplyDataSet.getCurrent();
	sorgId=sorgRecord.get('sorgId');
	taskCode=sorgRecord.get('taskCode');
	cnName=sorgRecord.get('sorgName');
	sorgKind=sorgRecord.get('sorgKind');
	document.getElementById('cnName').innerHTML=cnName;
	document.getElementById('changeDate').innerHTML=sorgRecord.get('appDate');
	document.getElementById("process").value=sorgRecord.get('process');
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on('load',function(){
		sorgOrganRecord= somOrganDataSet.getCurrent();
		document.getElementById('sorgCodeLab').innerHTML=sorgOrganRecord.get('sorgCode');
		chargerDataSet.setParameter("SORG_ID",sorgId);
		chargerDataSet.setParameter("IF_SERVE","1");
		chargerDataSet.setParameter("REG_STATUS","1");
		chargerDataSet.load();
		chargerDataSet.on('load',function(){
			if(chargerDataSet.getCount() > 0){
				legalName=chargerDataSet.getCurrent().get('name');
				document.getElementById('charger').innerHTML=legalName;
			}
		});
		var mainSorgId =sorgOrganRecord.get('mainSorgId');
		var somOrganDataSet1 = L5.DatasetMgr.lookup("somOrganDataSet1");
		somOrganDataSet1.removeAll();
		somOrganDataSet1.setParameter("SORG_ID",mainSorgId);
		somOrganDataSet1.load();
		somOrganDataSet1.on('load',function(){
			if(somOrganDataSet1.getCount() > 0){
				var mainOrgan= somOrganDataSet1.getCurrent();
				cnNameM=mainOrgan.get('cnName');
				document.getElementById('cnNameM').innerHTML=cnNameM;
			}
		});
		var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupChangeCmd");
		command.setParameter("sorgId", sorgId);
		command.execute("getLegalPeopleNameByTaskCode");
		document.getElementById('legalPeople').innerHTML=command.getReturn("legalPeopleName");
	});

	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.setParameter("TASK_CODE@=",taskCode);
	somChangeList.load();//变更
	somChangeList.on('load',forShow);

	var somFlowAddDataset=L5.DatasetMgr.lookup("somFlowAddDataset");
	somFlowAddDataset.setParameter("TASK_CODE@=",taskCode);
	somFlowAddDataset.load();
}

function forShow(somChangeList){
	//通过taskCode得到文件
	var records=somChangeList.getAllRecords();
	for(var i=0;i<records.length;i++){
		var changeItem=records[i].get('changeItem');
		if(changeItem==0){
			applyType=applyType+",028";
			forCheck[forCheck.length]='0';
		}else if(changeItem==1){
			applyType=applyType+",029";
			forCheck[forCheck.length]='1';
		}else if(changeItem==2){
			applyType=applyType+",030";
			forCheck[forCheck.length]='2';
			var chargerDataSet1=L5.DatasetMgr.lookup("chargerDataSet1");
			chargerDataSet1.setParameter("DUTY_ID",records[i].get('legalDutyId'));
			chargerDataSet1.load();
			chargerDataSet1.on("load",function(){
				var somResumeLegalDataSet= L5.DatasetMgr.lookup("somResumeLegalDataSet");
				somResumeLegalDataSet.setParameter("DUTY_ID",chargerDataSet1.getCurrent().get('dutyId'));
				somResumeLegalDataSet.load();
			});
		}else if(changeItem==3){
			applyType=applyType+",031";
			forCheck[forCheck.length]='3';
		}else if(changeItem==4){
			forCheck[forCheck.length]='4';
		}else if(changeItem==5){
			forCheck[forCheck.length]='5';
		}
	}
	somElectronicDataSet_load();//加载法律要件
}
//保存
function saveOpinion(){
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupBranchChangeCmd");
	var somFlowAddDataset=L5.DatasetMgr.lookup("somFlowAddDataset");
	var chargerDataSet1=L5.DatasetMgr.lookup("chargerDataSet1");
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	var somFlowIsValidate = somFlowAddDataset.isValidate();
	var newRecord=somFlowAddDataset.getCurrent();
	if(somFlowIsValidate != true){
		L5.Msg.alert("提示",somFlowIsValidate);
		return false;
	}
	command.setParameter("opinion", newRecord);//意见
	for(var i=0;i<forCheck.length;i++){
		if(forCheck[i]==2 && chargerDataSet1.getCount()!=0){
			command.setParameter("somLegalPeople", chargerDataSet1.getCurrent());//负责人
		}
	}
	command.setParameter("Changes", somChangeList.getAllRecords());//变更事项
	command.setParameter("process",document.getElementById("process").value);//内部履行程序
	command.setParameter("taskCode", taskCode);

	command.execute("saveOpinion");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功!",function(){
			window.history.go(-1);
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//提交
function sendNext(){
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupBranchChangeCmd");
	var somFlowAddDataset=L5.DatasetMgr.lookup("somFlowAddDataset");
	var chargerDataSet1=L5.DatasetMgr.lookup("chargerDataSet1");
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	var somFlowIsValidate = somFlowAddDataset.isValidate();
	var newRecord=somFlowAddDataset.getCurrent();
	if(somFlowIsValidate != true){
		L5.Msg.alert("提示",somFlowIsValidate);
		return false;
	}
	command.setParameter("opinion", newRecord);//意见
	if(forCheck[i]==2 && chargerDataSet1.getCount()!=0){
		command.setParameter("somLegalPeople", chargerDataSet1.getCurrent());//负责人
	}
	command.setParameter("Changes", somChangeList.getAllRecords());//变更事项
	command.setParameter("process",document.getElementById("process").value);//内部履行程序
	command.setParameter("taskCode", taskCode);

	command.setParameter("actDefUniqueId", actDefUniqueId);
	command.setParameter("processId", processId);
	command.setParameter("sorgId", sorgId);
	command.setParameter("assignmentId",assignmentId);
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

//关闭变更window
function closeChangeWin(){
	var win=L5.getCmp('AddChange'+changeNUM);
	win.hide();
}
//点击按钮负责人登记表
function addLegalPeople(){
	var chargerDataSet1=L5.DatasetMgr.lookup("chargerDataSet1");
	var num=chargerDataSet1.getCount();
	if(num == 0){
		L5.Msg.alert("提示","请先选择负责人！");
		return
	}
	var win=L5.getCmp("legalPeopleWindow");
	win.show();
	document.getElementById("labelAge").innerHTML=getAgeByCode(chargerDataSet1.getCurrent().get('idCard'));

	synPhotoDetail(chargerDataSet1.get("photoId"),null);

	var somResumeLegalDataSet= L5.DatasetMgr.lookup("somResumeLegalDataSet");
	somResumeLegalDataSet.setParameter("DUTY_ID",chargerDataSet1.getCurrent().get('dutyId'));
	somResumeLegalDataSet.load();

	legalDutyId=chargerDataSet1.getCurrent().get('dutyId');
	//加载法定代表人法律要件
	somLegalPeopleElectronicDataSet.setParameter("fileCodes",fileCodeF);
	somLegalPeopleElectronicDataSet.setParameter("dutyId",legalDutyId);
	somLegalPeopleElectronicDataSet.setParameter("sorgId",sorgId);
	somLegalPeopleElectronicDataSet.setParameter("taskCode",taskCode);
	somLegalPeopleElectronicDataSet.setParameter("applyType","030");
	somLegalPeopleElectronicDataSet.load();
}
function closePeopleWIn(){
	var win = L5.getCmp("legalPeopleWindow");
	win.hide();
}

//查看变更明细
function detailForChange(){
	var grid = L5.getCmp('changeEdit');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var id=records[0].get("id");
		var somChangeDetail=L5.DatasetMgr.lookup("somChangeDetail");
		//somChangeDetail.setParameter("ID@=",id);
		//somChangeDetail.load();
		//somChangeDetail.on('load',forChangeShow);
		somChangeDetail.removeAll();
		somChangeDetail.insert(0,records[0]);
		var changeItem=records[0].get('changeItem');
		var win=L5.getCmp('AddChange'+changeItem);
		win.show();
		if(changeItem=='0'){
			var changeBefore=records[0].get('changeBefore');
			var changeBefores=changeBefore.split(';');
			document.getElementById('nameBefore1').innerHTML=changeBefores[0];
			document.getElementById('sorgGroupKindBefore1').value=changeBefores[1];
			document.getElementById('sorgBusScopeBefore1').value=changeBefores[2];

			var changeAfter=records[0].get('changeAfter');
			var changeAfters=changeAfter.split(';');
			document.getElementById('nameAfter1').innerHTML=changeAfters[0];
			document.getElementById('sorgGroupKindAfter1').value=changeAfters[1];
			document.getElementById('sorgBusScopeAfter1').value=changeAfters[2];

		}else if(changeItem=='1'){
			var changeBefore=records[0].get('changeBefore');
			var changeBefores=changeBefore.split(';');
			document.getElementById('houseSourceBefore1').value=changeBefores[0];
			document.getElementById('houseNameBefore1').innerHTML=changeBefores[1];
			document.getElementById('houseBorgBefore1').innerHTML=changeBefores[2];
			document.getElementById('houseAreaBefore1').innerHTML=changeBefores[3];
			document.getElementById('houseDateBefore1').innerHTML=changeBefores[4];

			var changeAfter=records[0].get('changeAfter');
			var changeAfters=changeAfter.split(';');
			document.getElementById('houseSourceAfter1').value=changeAfters[0];
			document.getElementById('houseNameAfter1').innerHTML=changeAfters[1];
			document.getElementById('houseBorgAfter1').innerHTML=changeAfters[2];
			document.getElementById('houseAreaAfter1').innerHTML=changeAfters[3];
			document.getElementById('houseDateAfter1').innerHTML=changeAfters[4];
		}else if(changeItem=='2'){
			document.getElementById('leaPeopleNameBefore1').innerHTML=records[0].get('changeBefore');
		}else if(changeItem=='3'){

		}else if(changeItem=='4'){
			var changeBefore=records[0].get('changeBefore');
			var changeBefores=changeBefore.split(';');
			document.getElementById('moneyPeopleBefore1').innerHTML=changeBefores[0];
			document.getElementById('moneyborgBefore1').innerHTML=changeBefores[1];
			document.getElementById('moneySourceBefore1').innerHTML=changeBefores[2];
			document.getElementById('moneyBefore1').innerHTML=changeBefores[3];

			var changeAfter=records[0].get('changeAfter');
			var changeAfters=changeAfter.split(';');
			document.getElementById('moneyPeopleAfter1').innerHTML=changeAfters[0];
			document.getElementById('moneyborgAfter1').innerHTML=changeAfters[1];
			document.getElementById('moneySourceAfter1').innerHTML=changeAfters[2];
			document.getElementById('moneyAfter1').innerHTML=changeAfters[3];
		}else if(changeItem=='5'){
			document.getElementById('borgNameBefore1').value=records[0].get('changeBefore');
		}
		changeNUM=changeItem;
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//添加新的变更
function forAdd(){
	var win=L5.getCmp('AddChange');
	win.show();
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
		var win=L5.getCmp('AddChange1'+num);
		win.show();
		document.getElementById('nameBefore').innerHTML=sorgOrganRecord.get('cnName');
		document.getElementById('sorgGroupKindBefore').value=sorgOrganRecord.get('sorgKind');
		document.getElementById('sorgBusScopeBefore').value=sorgOrganRecord.get('busScope');
	}else if(num=='1'){
		var win=L5.getCmp('AddChange1'+num);
		win.show();
		document.getElementById('houseSourceBefore').value=sorgOrganRecord.get("resideSource");
		document.getElementById('houseNameBefore').innerHTML=sorgOrganRecord.get("residence");
		document.getElementById('houseBorgBefore').innerHTML=sorgOrganRecord.get("housingOrgan");
		document.getElementById('houseAreaBefore').innerHTML=sorgOrganRecord.get("housingArea");
		document.getElementById('houseDateBefore').innerHTML=sorgOrganRecord.get("leasePeriod");
	}else if(num=='2'){
		chargerDataSet1.setParameter("SORG_ID",sorgId);
		chargerDataSet1.setParameter("REG_STATUS","3");//批准中的，必须先备案才能进行负责人的变更
		chargerDataSet1.load();
		chargerDataSet1.on('load',function(){
			if(chargerDataSet1.getCount() > 0){
				legalDutyId = chargerDataSet1.get("dutyId");
				var win=L5.getCmp('AddChange1'+num);
				win.show();
				document.getElementById('leaPeopleNameAfter').value=chargerDataSet1.get('name');
				document.getElementById('leaPeopleNameBefore').innerHTML=legalName;
			}else{
				L5.Msg.alert("提示","请先进行负责人的备案！");return;
			}
		});
	}else if(num=='3'){
		var win=L5.getCmp('AddChange1'+num);
		win.show();
		document.getElementById('businessNameBefore').innerHTML=sorgOrganRecord.get("business");
	}else if(num=='4'){
		var win=L5.getCmp('AddChange1'+num);
		win.show();
		document.getElementById('moneyPeopleBefore').innerHTML=sorgOrganRecord.get("fundingPeople");
		document.getElementById('moneyborgBefore').innerHTML=sorgOrganRecord.get("checkCapitalOrgan");
		document.getElementById('moneySourceBefore').innerHTML=sorgOrganRecord.get("moneySource");
	}else if(num=='5'){
		var win=L5.getCmp('AddChange1'+num);
		win.show();
		document.getElementById('borgNameBefore').value=sorgOrganRecord.get("borgName");
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

	var changeAfter=houseSourceAfter+';'+houseNameAfter+';'+houseBorgAfter+';'+houseAreaAfter+';'+houseDateAfter;
	if(!houseChangeCheck()){
		return;
	}
	var houseSourceBefore=document.getElementById('houseSourceBefore').value;
	var houseNameBefore=document.getElementById('houseNameBefore').innerHTML;
	var houseBorgBefore=document.getElementById('houseBorgBefore').innerHTML;
	var houseAreaBefore=document.getElementById('houseAreaBefore').innerHTML;
	var houseDateBefore=document.getElementById('houseDateBefore').innerHTML;
	var changeBefore=houseSourceBefore+';'+houseNameBefore+';'+houseBorgBefore+';'+houseAreaBefore+';'+houseDateBefore;
	record.set('changeBefore',changeBefore);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','1');
	record.set('sorgId',sorgId);
	record.set('taskCode',taskCode);
	forCheck[forCheck.length]='1';
	closeChangeWin();
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	//somChangeList.reload();
	applyType=applyType+",029";
	somElectronicDataSet_load();

}
//资金变更保存
function forMoneyMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	var moneyPeopleBefore=document.getElementById('moneyPeopleBefore').innerHTML;
	var moneyborgBefore=document.getElementById('moneyborgBefore').innerHTML;
	var moneySourceBefore=document.getElementById('moneySourceBefore').innerHTML;
	var moneyBefore=document.getElementById('moneyBefore').innerHTML;

	var changeBefore=moneyPeopleBefore+';'+moneyborgBefore+';'+moneySourceBefore+';'+moneyBefore;

	var moneyPeopleAfter=document.getElementById('moneyPeopleAfter').value;
	var moneyborgAfter=document.getElementById('moneyborgAfter').value;
	var moneySourceAfter=document.getElementById('moneySourceAfter').value;
	var moneyAfter=document.getElementById('moneyAfter').value;

	var changeAfter=moneyPeopleAfter+';'+moneyborgAfter+';'+moneySourceAfter+';'+moneyAfter;
	if(!moneyChangeCheck()){
		return;
	}
	record.set('changeBefore',changeBefore);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','4');
	record.set('sorgId',sorgId);
	record.set('taskCode',taskCode);
	forCheck[forCheck.length]='4';
	closeChangeWin();
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
}
//名称变更保存
function forNameMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();

	var nameBefore=document.getElementById('nameBefore').innerHTML;
	var sorgGroupKindBefore=document.getElementById('sorgGroupKindBefore').value;
	var sorgBusScopeBefore=document.getElementById('sorgBusScopeBefore').value;
	var changeBefore=nameBefore+';'+sorgGroupKindBefore+';'+sorgBusScopeBefore;

	var nameAfter=document.getElementById('nameAfter').value;
	var sorgGroupKindAfter=document.getElementById('sorgGroupKindAfter').value;
	var sorgBusScopeAfter=document.getElementById('sorgBusScopeAfter').value;

	if(!nameChangeCheck()){
		return;
	}
	//检查新的社会团体名称是否已经存在
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
	command.setParameter("cnName",document.getElementById('nameAfter').value);
	command.execute('cnNameUK');
	var num=command.getReturn('cnNameNum');
	if(num!=0){
		L5.Msg.alert("提示","名称已经存在!");return;
	}
	var changeAfter=nameAfter+';'+sorgGroupKindAfter+';'+sorgBusScopeAfter;

	record.set('changeBefore',changeBefore);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','0');
	record.set('sorgId',sorgId);
	record.set('taskCode',taskCode);
	forCheck[forCheck.length]='0';
	closeChangeWin();
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	applyType=applyType+",028";
	somElectronicDataSet_load();
}
//负责人变更保存
function forLeaPeopleMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	var changeAfter=document.getElementById('leaPeopleNameAfter').value;
	if(changeAfter==''){
		L5.Msg.alert("提示","负责人姓名不能为空！");return;
	}
	if(!leaPeopleChangeCheck()){
		return;
	}
	record.set('changeBefore',document.getElementById('leaPeopleNameBefore').innerHTML);
	record.set('changeAfter',changeAfter);
	record.set('changeItem','2');
	record.set('legalDutyId',chargerDataSet1.get('dutyId'));
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	record.set('sorgId',sorgId);
	record.set('taskCode',taskCode);
	forCheck[forCheck.length]='2';
	closeChangeWin();
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	applyType=applyType+",030";
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
	record.set('sorgId',sorgId);
	record.set('taskCode',taskCode);
	forCheck[forCheck.length]='3';
	closeChangeWin();
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);
	applyType=applyType+",031";
	somElectronicDataSet_load();

}
//主管单位变更保存
function forBorgMove(){
	var somChangeDataset = L5.DatasetMgr.lookup("somChangeDataset");
	var record=somChangeDataset.getCurrent();
	var changeAfter=record.get('changeAfter');
	if(changeAfter==''){
		L5.Msg.alert("提示","业务主管单位不能为空！");return;
	}
	if(!borgChangeCheck()){
		return;
	}
	record.set('changeBefore',document.getElementById('borgNameBefore').value);
	record.set('changeItem','5');
	var somChangeList = L5.DatasetMgr.lookup("somChangeList");
	record.set('sorgId',sorgId);
	record.set('taskCode',taskCode);
	forCheck[forCheck.length]='5';
	closeChangeWin();
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.insert(somChangeList.getCount(),record);

}
//检查是否重复变更
function forCheckRepeat(number){
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	var records=somChangeList.getAllRecords();
	for(var i=0;i<records.length;i++){
		if(records[i].get('changeItem')==number){
			L5.Msg.alert("提示","该变更事项已经存在!");return false;
		}
	}
	return true;
}
//关闭变更窗口
function closeChangeWin(){
	var win=L5.getCmp('AddChange1'+changeItemNUM);
	win.hide();
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
//返回
function returnForLegalPeople(){
	var win=L5.getCmp("legalPeopleWin");
	win.hide();
}
//关闭负责人明细窗口
function closePeoplewin(){
	var win=L5.getCmp("peopleWin");
	win.hide();
}
//变更项删除，同步隐藏该变更项所需法律要件
//changeItem：变更项的值
function hideDeletedCatalog(changeItem){
	var ifNeedChangeCatalog = "0";
	//名称变更
	if(changeItem=="0"){
		applyType=applyType.replace(",028","");
		ifNeedChangeCatalog = "1";
	}
	//住所变更
	if(changeItem=="1"){
		applyType=applyType.replace(",029","");
		ifNeedChangeCatalog = "1";
	}
	//负责人变更
	if(changeItem=="2"){
		applyType=applyType.replace(",030","");
		ifNeedChangeCatalog = "1";
	}
	//业务范围变更
	if(changeItem=="3"){
		applyType=applyType.replace(",031","");
		ifNeedChangeCatalog = "1";
	}
	if(ifNeedChangeCatalog == "1"){
		somElectronicDataSet_load();
	}
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
	printRecord.put("APPLY_ITEM","社会团体分支（代表）机构变更");
	printRecord.put("ADD_ITEM",addItem);
	var curPeople='<%=BspUtil.getEmpOrgan().getOrganName()%>';
	printRecord.put("CUR_PEOPLE",curPeople);
	var curOrgan='<%=BspUtil.getOrganName()%>';
	printRecord.put("CUR_ORGAN",curOrgan);
	printReport(getPrintDataByMap(printTitle,printRecord),L5.webPath+'/jsp/cams/sorg/apply/group/mainChange/polish.fr3');

}

//打印不予受理通知书
function printNoAccept(){
	var url=rootPath+"/jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=J";
	url+="&taskCode="+taskCode+"&applyType="+somApplyType+"&printPeople="+currentUserName;
	window.open(url);
}
//打印受理通知书
function printAccept(){
	var url=rootPath+"/jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=J";
	url+="&taskCode="+taskCode+"&applyType="+somApplyType+"&printPeople="+currentUserName;
	window.open(url);
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
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<!-- 变更申请dataset -->
	<model:dataset id="somOrganDataSet1" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<!-- 负责人信息 -->
	<model:dataset id="somDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 分支负责人 -->
	<model:dataset id="chargerDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 分支负责人 -->
	<model:dataset id="chargerDataSet1" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%--负责人简历 --%>
	<model:dataset id="somResumeLegalDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<!-- 变更申请dataset -->
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply"></model:record>
	</model:dataset>
	<!-- 变更window的dataset -->
	<model:dataset id="somChangeList" cmd="com.inspur.cams.sorg.manage.cmd.SomChangeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomChange"></model:record>
	</model:dataset>
	<!-- 变更window的dataset -->
	<model:dataset id="somChangeDataset" cmd="com.inspur.cams.sorg.manage.cmd.SomChangeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomChange"></model:record>
	</model:dataset>
	<model:dataset id="somChangeDetail" cmd="com.inspur.cams.sorg.manage.cmd.SomChangeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomChange"></model:record>
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
	<model:dataset id="sorgGroupKind" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
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
	<!-- 所属行事业 -->
	<model:dataset id="sorgBusScope" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
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
	<model:dataset id="somChangeItem" enumName="SOM.BRANCH.CHANGE.ITEM"  autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect1" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel title="社会团体变更" width="100%" height="100%" >
	<next:TopBar>
	<next:ToolBarItem symbol="->" ></next:ToolBarItem>
			<%
				//从后台获取环节按钮权限，显示要显示按钮
				for(int i=0;i<list.size();i++){
					Map map=(Map)list.get(i);
					String buttonName=(String)map.get("buttonName");
					String buttonFunName=(String)map.get("buttonFunName");
					String buttonIMG=(String)map.get("buttonIMG");
					if("send()".equals(buttonFunName) || "sendForPrint()".equals(buttonFunName) || "sendNext()".equals(buttonFunName)){
						buttonIMG="select";
					}else if("saveOpinion()".equals(buttonFunName)){
						buttonIMG="save";
					}else if("choseIssuePeople()".equals(buttonFunName)){
						buttonIMG="select";
					}else if("goBack()".equals(buttonFunName)){
						buttonIMG="return";
					}else{
						buttonIMG="print";
					}
			%>
					<next:ToolBarItem iconCls="<%=buttonIMG%>" text="<%=buttonName %>" handler="<%=buttonFunName %>" />
			<%
				}
			%>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab" activeTab="1">
		<next:Tabs>
			<next:Panel title="社会团体分支（代表）机构变更登记申请表" width="100%" height="100%" autoScroll="true">
				<next:Panel>
					<next:Html>
					<fieldset><legend>变更信息</legend>
					<form method="post" onsubmit="return false" class="L5form">
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width: 10%;"><label>社会团体登记证号：</label></td>
							<td class="FieldInput" style="width: 10%;"><label id="sorgCodeLab"></label></td>
							<td class="FieldLabel" style="width: 10%;"><label>申请时间：</label></td>
							<td class="FieldInput" style="width: 10%;"><label  id="changeDate"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 10%;"><label>社会团体名称：</label></td>
							<td class="FieldInput" style="width: 10%;"><label id="cnNameM"></label></td>
							<td class="FieldLabel" style="width: 10%;"><label>法定代表人：</label></td>
							<td class="FieldInput" style="width: 10%;"><label id="legalPeople"></label></td>
						</tr>
						<tr>

							<td class="FieldLabel" style="width: 10%;"><label>分支/代表机构名称：</label></td>
							<td class="FieldInput" style="width: 10%;"><label id="cnName"></label></td>
							<td class="FieldLabel" style="width: 10%;"><label>负责人：</label></td>
							<td class="FieldInput" style="width: 10%;"><label id="charger"></label></td>
						</tr>
					</table>
					</form>
					</fieldset>
					</next:Html>
				</next:Panel>
				<next:EditGridPanel id="changeEdit" dataset="somChangeList" height="60%"  autoScroll="true">
					<next:TopBar>
						<next:ToolBarItem text='' id="displayItem"/>
						<next:ToolBarItem symbol="变更事项"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem text="增加变更" iconCls="add" handler="forAdd"></next:ToolBarItem>
						<next:ToolBarItem text="查看变更" iconCls="edit" handler="detailForChange"></next:ToolBarItem>
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
							 width="30%" editable="false">
							<next:TextField/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				<next:Html>
					<fieldset><legend>社团内部履行程序</legend>
					<form method="post" onsubmit="return false" class="L5form">
						<table width="100%">
						<tr>
							<td class="FieldInput"colspan="3"><textarea name="社团内部履行程序" id="process" cols="65" rows="4" style="width:95%"></textarea></td>
						</tr>
						</table>
					</form>
					</fieldset>
					<%
						if( "supply".equals(request.getParameter("actname")) ){
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
			<next:Panel title="法律要件">
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet" autoScroll="true">
					<next:GroupingView forceFit="true"></next:GroupingView>
					<next:TopBar>
						<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加上传附件" handler="uploadFile"></next:ToolBarItem>
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
			<next:Panel title="处理意见" id="ipinionPanel" width="100%" height="100%" autoScroll="true" style="display:block;">
				<next:Html>
				<form method="post" onsubmit="return false" class="L5form" dataset="somFlowAddDataset">
				<table width="100%">
					<tr>
						<tr>
							<td class="FieldLabel" style="width:13%"><label>处理意见：</label></td>
							<td class="FieldInput" colspan="5"><select field="curOpinionId" name='处理意见' style="width:150px"><option dataset="opinionSelect1"></option></select><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>处理补充意见：</label></td>
							<td class="FieldInput" colspan="5"><textarea rows="10" name='处理补充意见' field="curOpinion" style="width:98%"></textarea></td>
						</tr>
				</table>
				</form>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<!-- 社会团体名称变更 -->
<next:Window id="AddChange0" closeAction="hide" title="名称变更" width="600"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="名称变更"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
<next:Html>
	<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDetail">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>名称变更前：</label></td>
				<td class="FieldInput" colspan="3"><label id="nameBefore1" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width:25%"><label>社会团体类别变更前：</label></td>
				<td class="FieldInput"style="width:25%"><select  id="sorgGroupKindBefore1" style="color:blue" disabled="disabled"><option dataset="sorgGroupKind"></option></select></td>
				<td class="FieldLabel" style="width:25%"><label>所属行（事）业变更前：</label></td>
				<td class="FieldInput"style="width:25%"><select  id="sorgBusScopeBefore1" style="color:blue" disabled="disabled"><option  dataset="sorgBusScope"></option></select></td>
			</tr>
			<tr>
				<td class="FieldLabel"style="width:15%"><label  style="color:blue">名称变更为：</label></td>
				<td class="FieldInput"style="width:15%"colspan="3"><label  id="nameAfter1" style="color:blue"/></td>
			</tr>
			<span onmousemove="this.setCapture();"onmouseout="this.releaseCapture();">
			<tr>
				<td class="FieldLabel" style="width:15%"><label  style="color:blue">社会团体类别变更为：</label></td>
				<td class="FieldInput"style="width:15%"><select  id="sorgGroupKindAfter1" style="color:blue"><option dataset="sorgGroupKind"></option></select></td>
				<td class="FieldLabel" style="width:15%"><label  style="color:blue">所属行（事）业变更为：</label></td>
				<td class="FieldInput"style="width:15%"><select  id="sorgBusScopeAfter1" style="color:blue"><option  dataset="sorgBusScope"></option></select></td>
			</tr>
			</span>
			<tr>
				<td class="FieldLabel"><label  style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea cols="75" rows="4" style="width: 100%;color:blue" field="changeReason" readonly="readonly"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>

<!-- 法定代表人变更 -->
<next:Window id="AddChange2" closeAction="hide" title="负责人变更" width="600"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="负责人变更"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="查看负责人信息" iconCls="add" handler="addLegalPeople" ></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDetail">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>负责人姓名变更前：</label></td>
				<td class="FieldInput"style="width:25%"><label  id="leaPeopleNameBefore1" /></td>
				<td class="FieldLabel"style="width:25%"><label style="color:blue">负责人姓名变更为：</label></td>
				<td class="FieldInput"style="width:25%"><label field="changeAfter" style="color:blue"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea cols="75" rows="4" style="width: 100%;color:blue" readonly="readonly" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<!-- 住所变更 -->
<next:Window id="AddChange1" closeAction="hide" title="住所变更" width="500"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="住所变更"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDetail">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>住所来源变更前：</label></td>
				<td class="FieldInput"style="width:25%"><select  id="houseSourceBefore1" disabled="disabled"><option dataset="resideSourceSelect"></option></select></td>
				<td class="FieldLabel"  style="width:25%"><label>用房面积变更前：</label></td>
				<td class="FieldInput" style="width:25%"><label  id="houseAreaBefore1"  /></td>
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
				<td class="FieldInput"><label id="houseDateBefore1" /></td>
			</tr>
			<span onmousemove="this.setCapture();"onmouseout="this.releaseCapture();">
			<tr>
				<td class="FieldLabel"style="width:15%"><label style="color:blue">住所来源变更为：</label></td>
				<td class="FieldInput"style="width:15%"><select id="houseSourceAfter1"  style="color:blue"><option  dataset="resideSourceSelect"></option></select></td>
				<td class="FieldLabel"><label style="color:blue">用房面积变更为：</label></td>
				<td class="FieldInput"><label id="houseAreaAfter1"  style="color:blue"/></td>
			</tr>
			</span>
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
				<td class="FieldInput"><label id="houseDateAfter1"  style="color:blue"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea cols="75" rows="4" readonly="readonly" style="width: 100%;color:blue" field="changeReason" ></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<!-- 业务范围变更 -->
<next:Window id="AddChange3" closeAction="hide" title="业务范围变更" width="600"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="业务范围变更"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDetail">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>业务范围变更前：</label></td>
				<td class="FieldInput"style="width:75%"><textArea  field='changeBefore' disabled="disabled" cols="75" rows="4" style="width: 100%"></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel"style="width:15%"><label style="color:blue">业务范围变更为：</label></td>
				<td class="FieldInput"style="width:15%"><textArea  field="changeAfter" readonly="readonly" cols="75" rows="4" style="width: 100%;color:blue"></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea readonly="readonly" cols="75" rows="4" style="width: 100%;color:blue" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<!-- 变更注册资金 -->
<next:Window id="AddChange4" closeAction="hide" title="注册资金变更" width="500"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="注册资金变更"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDetail">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>增资出资人变更前：</label></td>
				<td class="FieldInput"style="width:25%"><label id="moneyPeopleBefore1"/></td>
				<td class="FieldLabel"style="width:25%"><label>资金数额变更前：</label></td>
				<td class="FieldInput"style="width:25%"><label id="moneyBefore1" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>验资单位变更前：</label></td>
				<td class="FieldInput" colspan="3"><label id="moneyborgBefore1" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>资金来源变更前：</label></td>
				<td class="FieldInput" colspan="3"><label id="moneySourceBefore1" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"style="width:15%"><label style="color:blue">增资出资人变更为：</label></td>
				<td class="FieldInput"style="width:15%"><label id="moneyPeopleAfter1" style="color:blue"/></td>
				<td class="FieldLabel"><label style="color:blue">资金数额变更为：</label></td>
				<td class="FieldInput"><label id="moneyAfter1" style="color:blue"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">验资单位变更为：</label></td>
				<td class="FieldInput" colspan="3"><label id="moneyborgAfter1" style="color:blue"/></td>
			</tr>

			<tr>
				<td class="FieldLabel"><label style="color:blue">资金来源变更为：</label></td>
				<td class="FieldInput" colspan="3"><label id="moneySourceAfter1" style="color:blue"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea cols="75" rows="4" readonly="readonly" style="width: 100%;color:blue" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>

<!-- 业务主管单位变更 -->
<next:Window id="AddChange5" closeAction="hide" title="业务主管单位变更" width="600"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="业务主管单位变更"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDetail">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>变更前业务主管单位：</label></td>
				<td class="FieldInput"style="width:25%"><select
					id="borgNameBefore1" disabled="disabled">
					<option dataset="businessOrganSelect"></option>
				</select></td>
				<td class="FieldLabel"style="width:25%"><label style="color:blue">变更为业务主管单位：</label></td>
				<td class="FieldInput"style="width:25%"><select
					field="changeAfter" style="color: blue" disabled="disabled">
					<option dataset="businessOrganSelect"></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea cols="75" readonly="readonly" rows="4" style="width: 100%;color:blue" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>

<!--添加变更  -->
<next:Window id="AddChange" closeAction="hide" title="添加变更" width="400"  autoScroll="true">
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
<!-- 社会团体名称变更 -->
<next:Window id="AddChange10" closeAction="hide" title="名称变更" width="600"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="名称变更"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forNameMove" ></next:ToolBarItem>
	</next:TopBar>
<next:Html>
	<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDataset">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>名称变更前：</label></td>
				<td class="FieldInput"style="width:75%" colspan="3"><label id="nameBefore"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width:15%"><label>社会团体类别变更前：</label></td>
				<td class="FieldInput"style="width:15%"><select  id="sorgGroupKindBefore" disabled="disabled"><option  dataset="sorgGroupKind"></option></select></td>
				<td class="FieldLabel" style="width:25%"><label>所属行（事）业变更前：</label></td>
				<td class="FieldInput"style="width:25%"><select  id="sorgBusScopeBefore" disabled="disabled"><option  dataset="sorgBusScope"></option></select></td>
			</tr>
			<tr>
				<td class="FieldLabel"style="width:15%"><label style="color:blue">名称变更为：</label></td>
				<td class="FieldInput"style="width:15%" colspan="3"><input id='nameAfter' type="text"  style="width:98%"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width:15%"><label style="color:blue">社会团体类别变更为：</label></td>
				<td class="FieldInput"style="width:15%"><select  id="sorgGroupKindAfter"><option  dataset="sorgGroupKind"></option></select></td>
				<td class="FieldLabel" style="width:15%"><label style="color:blue">所属行（事）业变更为：</label></td>
				<td class="FieldInput"style="width:15%"><select  id="sorgBusScopeAfter"><option  dataset="sorgBusScope"></option></select></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea id="nameReason" cols="75" rows="4" style="width: 100%" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>

<!-- 法定代表人变更 -->
<next:Window id="AddChange12" closeAction="hide" title="负责人变更" width="600"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="负责人变更"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="查看负责人信息" iconCls="add" handler="addLegalPeople" ></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forLeaPeopleMove" ></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDataset">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:15%"><label>负责人姓名变更前：</label></td>
				<td class="FieldInput"style="width:15%"><label  id="leaPeopleNameBefore" /></td>
				<td class="FieldLabel"style="width:15%" style="color:blue"><label>负责人姓名变更为：</label></td>
				<td class="FieldInput"style="width:15%"><input id='leaPeopleNameAfter' type="text" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea id="leaPeopleReason"cols="75" rows="4" style="width: 100%" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<!-- 住所变更 -->
<next:Window id="AddChange11" closeAction="hide" title="住所变更" width="500"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="住所变更"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forHouseMove" ></next:ToolBarItem>
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
				<td class="FieldInput"><input type="text" id="houseDateAfter" /></td>
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
<next:Window id="AddChange13" closeAction="hide" title="业务范围变更" width="600"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="业务范围变更"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forBusinessMove" ></next:ToolBarItem>
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
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea id="businessReason"cols="75" rows="4" style="width: 100%" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<!-- 变更注册资金 -->
<next:Window id="AddChange14" closeAction="hide" title="注册资金变更" width="500"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="注册资金变更"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forMoneyMove" ></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDataset">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>增资出资人变更前：</label></td>
				<td class="FieldInput"style="width:25%"><label id="moneyPeopleBefore"/></td>
				<td class="FieldLabel" style="width:25%"><label>资金数额变更前：</label></td>
				<td class="FieldInput" style="width:25%"><label id="moneyBefore" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>验资单位变更前：</label></td>
				<td class="FieldInput" colspan="3"><label id="moneyborgBefore" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>资金来源变更前：</label></td>
				<td class="FieldInput" colspan="3"><label id="moneySourceBefore" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"style="width:15%"><label style="color:blue">增资出资人变更为：</label></td>
				<td class="FieldInput"style="width:15%"><input id="moneyPeopleAfter"type="text" /></td>
				<td class="FieldLabel"><label style="color:blue">资金数额变更为：</label></td>
				<td class="FieldInput"><input id="moneyAfter" type="text" style="width:98%"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">验资单位变更为：</label></td>
				<td class="FieldInput" colspan="3"><input id="moneyborgAfter" type="text" style="width:98%"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">资金来源变更为：</label></td>
				<td class="FieldInput" colspan="3"><input id="moneySourceAfter" type="text" style="width:98%"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea id="moneyReason"cols="75" rows="4" style="width: 100%" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>

<!-- 业务主管单位变更 -->
<next:Window id="AddChange15" closeAction="hide" title="业务主管单位变更" width="600"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="业务主管单位变更"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forBorgMove" ></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDataset">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:15%"><label>变更前业务主管单位：</label></td>
				<td class="FieldInput"style="width:15%"><select
					id="borgNameBefore" disabled="disabled">
					<option dataset="businessOrganSelect"></option>
				</select></td>
				<td class="FieldLabel"style="width:15%"><label style="color:blue">变更为业务主管单位：</label></td>
				<td class="FieldInput"style="width:15%"><select
					field="changeAfter" id='borgNameAfter' style="color: blue">
					<option dataset="businessOrganSelect"></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea id="borgReason" cols="75" rows="4" style="width: 100%" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<next:Window id="legalPeopleWindow" closeAction="hide" title="负责人登记表" height="400" width="800" modal="true">
	<next:TabPanel  width="98%" height="84%">
		<next:Tabs>
			<next:Panel title="基本信息"  width="100%" height="100%" autoScroll="true">
				<next:Html>
					<form  method="post" dataset="chargerDataSet1" onsubmit="return false" class="L5form">
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
					<next:ToolBarItem iconCls="add" text="增加上传附件" handler="uploadLegalPeopleFile"></next:ToolBarItem>
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
		<next:ToolButton text="关闭"handler="closePeopleWIn"></next:ToolButton>
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