var taskCode="";
var printWinNum="";
function init(){
	somPenaltyApplyDataSet.setParameter("ID", processId);
	somPenaltyApplyDataSet.on("load", loadInfo);
	somPenaltyApplyDataSet.load();	
	if(method=="yiban"){
		if(act=="p_reg"||act=="p_regCheck"||act=="p_regAudit"){
			L5.getCmp("tab").remove(2);
		}else if(act=="p_forbid"||act=="p_forbidCheck"||act=="p_forbidAudit"){
			L5.getCmp("tab").remove(3);
		}else if(act=="p_final"||act=="p_finalCheck"||act=="p_finalAudit"){
			L5.getCmp("tab").remove(6);
		}
	}else if(method=="end"){
		L5.getCmp("tab").remove(6);
	}
	//电子档案上传窗口关闭事件
	if(L5.getCmp("uploadList")){
		var win=L5.getCmp("uploadList");
		win.on("hide",function(el){
			somElectronicDataSet_load();
		});	
	}	
	L5.QuickTips.init();
}
function loadInfo(){
	taskCode = somPenaltyApplyDataSet.get("taskCode");
	somPenaltyApplyDataSet.set("curOpinionId","1");
	somPenaltyDataSet.setParameter("TASK_CODE", taskCode);
	somPenaltyDataSet.on("load",function(){
		if(act=="p_accept"&&method=="yiban"){
			loadCaseSource();
		}
	});
	somPenaltyDataSet.load();
	if(L5.getCmp("uploadList")){
		somElectronicDataSet_load();
	}
	if(act=="p_final"||act=="p_finalCheck"||act=="p_finalAudit"||method=='end'){
		somRestrictPeopleDetailDS.setParameter("TASK_CODE", taskCode);
		somRestrictPeopleDetailDS.load();
	}
}
function save(){
	var somPenaltyDataSetIsValidate = somPenaltyDataSet.isValidate();
	if(somPenaltyDataSetIsValidate != true){
		L5.Msg.alert('提示',somPenaltyDataSetIsValidate);
		return false;
	}
	var somPenaltyApplyDataSetIsValidate = somPenaltyApplyDataSet.isValidate();
	if(somPenaltyApplyDataSetIsValidate != true){
		L5.Msg.alert('提示',somPenaltyApplyDataSetIsValidate);
		return false;
	}		
	var somPenaltyRd=somPenaltyDataSet.getCurrent();
	var somPenaltyApplyRd=somPenaltyApplyDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.penalty.forbid.cmd.SomPenaltyForbidCmd");
	command.setParameter("somPenaltyRd",somPenaltyRd);
	command.setParameter("somPenaltyApplyRd",somPenaltyApplyRd);
	if(act=="p_final"){	
		/*var somRestrictPeopleDetailDSIsValidate = somRestrictPeopleDetailDS.isValidate();
		if(somRestrictPeopleDetailDSIsValidate != true){
			L5.Msg.alert('提示',somRestrictPeopleDetailDSIsValidate);
			return false;
		}
		var somRestrictPeopleDetailRds=somRestrictPeopleDetailDS.getAllRecords();
		for(var i=0;i<somRestrictPeopleDetailRds.length;i++){
			var name=somRestrictPeopleDetailRds[i].get("name");
			var idCard=somRestrictPeopleDetailRds[i].get("idCard");
			if(name==''){
				L5.Msg.alert("提示","校验未通过："+"第"+(i+1)+"行姓名列不能为空");
				L5.getCmp("tab").setActiveTab("5");
				return;
			}
			if(idCard==''){
				L5.Msg.alert("提示","校验未通过："+"第"+(i+1)+"行身份证号列不能为空");
				L5.getCmp("tab").setActiveTab("5");
				return;
			}
			if(idCard!="" && validIDCard(idCard)!=true){
				L5.Msg.alert("提示","校验未通过："+"第"+(i+1)+"行身份证号列格式不正确");
				L5.getCmp("tab").setActiveTab("5");
				return;
			}
		}*/
		command.setParameter("somRestrictPeopleDetailRds",somRestrictPeopleDetailDS.getAllChangedRecords());	
	}
	command.execute("save");
	if(!command.error){	
		L5.Msg.alert("提示","保存成功！",function(){
			goBack();
		});
	}else{
		L5.Msg.alert("错误","保存时出现错误！"+command.error);	
	}
}
function submit(){
	var somPenaltyDataSetIsValidate = somPenaltyDataSet.isValidate();
	if(somPenaltyDataSetIsValidate != true){
		L5.Msg.alert('提示',somPenaltyDataSetIsValidate);
		return false;
	}
	var somPenaltyApplyDataSetIsValidate = somPenaltyApplyDataSet.isValidate();
	if(somPenaltyApplyDataSetIsValidate != true){
		L5.Msg.alert('提示',somPenaltyApplyDataSetIsValidate);
		return false;
	}		
	var somPenaltyRd=somPenaltyDataSet.getCurrent();
	var somPenaltyApplyRd=somPenaltyApplyDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.penalty.forbid.cmd.SomPenaltyForbidCmd");
	command.setParameter("somPenaltyRd",somPenaltyRd);
	command.setParameter("somPenaltyApplyRd",somPenaltyApplyRd);
	if(act=="p_final"){	
		/*var somRestrictPeopleDetailDSIsValidate = somRestrictPeopleDetailDS.isValidate();
		if(somRestrictPeopleDetailDSIsValidate != true){
			L5.Msg.alert('提示',somRestrictPeopleDetailDSIsValidate);
			return false;
		}
		var somRestrictPeopleDetailRds=somRestrictPeopleDetailDS.getAllRecords();
		for(var i=0;i<somRestrictPeopleDetailRds.length;i++){
			var name=somRestrictPeopleDetailRds[i].get("name");
			var idCard=somRestrictPeopleDetailRds[i].get("idCard");
			if(name==''){
				L5.Msg.alert("提示","校验未通过："+"第"+(i+1)+"行姓名列不能为空");
				L5.getCmp("tab").setActiveTab("5");
				return;
			}
			if(idCard==''){
				L5.Msg.alert("提示","校验未通过："+"第"+(i+1)+"行身份证号列不能为空");
				L5.getCmp("tab").setActiveTab("5");
				return;
			}
			if(idCard!="" && validIDCard(idCard)!=true){
				L5.Msg.alert("提示","校验未通过："+"第"+(i+1)+"行身份证号列格式不正确");
				L5.getCmp("tab").setActiveTab("5");
				return;
			}
		}*/
		command.setParameter("somRestrictPeopleDetailRds",somRestrictPeopleDetailDS.getAllChangedRecords());	
	}
	command.execute("submit");
	if(!command.error){	
		L5.Msg.alert("提示","成功提交至下一环节！",function(){
			goBack();
		});
	}else{
		L5.Msg.alert("错误","提交时出现错误！"+command.error);	
	}
}
function goBack(){
	history.go(-1);
}
//校验身份证号
function validIDCard(o){
	if(o=="") return true;
	if(o=="000000000000000000") return true;
	var val=o.toUpperCase();
	if(val.length==15){
		if(!is15IDCard(val)){
			return false;
		}
	}else if(val.length==18){
		if(!is18IDCard(val)){
			return false;
		}
	}else{
		return false;
	}
	return true;
}
function loadCaseSource(){
	if(_$("caseSource") == "1"){
		$("caseSourceCheck1").style.display = "block";
		$("caseSourceCheck2").style.display = "block";
		$("caseSourceReport1").style.display = "none";
		$("caseSourceReport2").style.display = "none";
		$("caseSourceReport3").style.display = "none";
		$("caseSourceMove1").style.display = "none";
		$("caseSourceMove2").style.display = "none";
		$("caseSourceMove3").style.display = "none";
	}else if(_$("caseSource") == "2"){
		$("caseSourceCheck1").style.display = "none";
		$("caseSourceCheck2").style.display = "none";
		$("caseSourceReport1").style.display = "block";
		$("caseSourceReport2").style.display = "block";
		$("caseSourceReport3").style.display = "block";
		$("caseSourceMove1").style.display = "none";
		$("caseSourceMove2").style.display = "none";
		$("caseSourceMove3").style.display = "none";
	}else if(_$("caseSource") == "3" || _$("caseSource") == "4"){
		$("caseSourceCheck1").style.display = "none";
		$("caseSourceCheck2").style.display = "none";
		$("caseSourceReport1").style.display = "none";
		$("caseSourceReport2").style.display = "none";
		$("caseSourceReport3").style.display = "none";
		$("caseSourceMove1").style.display = "block";
		$("caseSourceMove2").style.display = "block";
		$("caseSourceMove3").style.display = "block";
	}else{
		$("caseSourceCheck1").style.display = "none";
		$("caseSourceCheck2").style.display = "none";
		$("caseSourceReport1").style.display = "none";
		$("caseSourceReport2").style.display = "none";
		$("caseSourceReport3").style.display = "none";
		$("caseSourceMove1").style.display = "none";
		$("caseSourceMove2").style.display = "none";
		$("caseSourceMove3").style.display = "none";
	}
}
//点击增加上传附件按钮
function clickUploadFile(){
	uploadFile();
}

//打印《取缔决定书》
function printForbidInform(){
	var url=rootPath+"jsp/cams/sorg/comm/print/penalty/forbid/penaltyForbidInformForPrint.jsp?taskCode="+taskCode;
	window.open(url);
}
//打印《<取缔决定书>送达回证》
function printForbidInformBack(){
	var url=rootPath+"jsp/cams/sorg/comm/print/penalty/base/penaltyBaseBackForPrint.jsp?taskCode="+taskCode+"&op=forbidInformBack";	
	window.open(url);
}
var restrictPeopleRecord=null;
// 增加
function addRestrictPeopleDetail(){
	restrictPeopleRecord=null;
	var winRestrictPeopleDetailDS = L5.DatasetMgr.lookup("winRestrictPeopleDetailDS");
	winRestrictPeopleDetailDS.removeAll();
	winRestrictPeopleDetailDS.newRecord();
	var win = L5.getCmp("restrictWin");
	win.show();
}
function updateRestrictPeopleDetail(){
	var grid = L5.getCmp("restrictPeopleGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	restrictPeopleRecord = record;
	var winRestrictPeopleDetailDS = L5.DatasetMgr.lookup("winRestrictPeopleDetailDS");
	winRestrictPeopleDetailDS.removeAll();
	var newRecord = winRestrictPeopleDetailDS.newRecord();
	var win = L5.getCmp("restrictWin");
	win.show();
	newRecord.set("name",record.get("name"));
	newRecord.set("idCard",record.get("idCard"));
	document.getElementById("idCard_restrict").disabled=true;
}
// 删除
function delRestrictPeopleDetail(){
	var record=somRestrictPeopleDetailDS.getCurrent();
	if(record!=null)
		somRestrictPeopleDetailDS.remove(record);
}
function forRestrictWin(){
	var winRestrictPeopleDetailDS = L5.DatasetMgr.lookup("winRestrictPeopleDetailDS");
	var name=_$("name_restrict");
	var idCard=_$("idCard_restrict");
	if(idCard==''){
		L5.Msg.alert("提示","校验未通过："+"身份证号不能为空");
		L5.getCmp("tab").setActiveTab("5");
		return;
	}
	if(name==''){
		L5.Msg.alert("提示","校验未通过："+"姓名不能为空");
		L5.getCmp("tab").setActiveTab("5");
		return;
	}
	if(restrictPeopleRecord == null){
		winRestrictPeopleDetailDS.set("name",name);
		winRestrictPeopleDetailDS.set("idCard",idCard);
		winRestrictPeopleDetailDS.set("ifValid","1");
		winRestrictPeopleDetailDS.set("taskCode",taskCode);
		winRestrictPeopleDetailDS.set("ifLegal","0");
		winRestrictPeopleDetailDS.set("sourceType","1");
		somRestrictPeopleDetailDS.insert(somRestrictPeopleDetailDS.getCount(),winRestrictPeopleDetailDS.getCurrent());
	}else{
		var record = winRestrictPeopleDetailDS.getCurrent();
		restrictPeopleRecord.set("name",record.get("name"));
		restrictPeopleRecord.set("idCard",record.get("idCard"));
	}
	var win = L5.getCmp("restrictWin");
	win.setVisible(false);
}
function closeRestrictWin(){
	var win = L5.getCmp("restrictWin");
	win.setVisible(false);
}
function validIdCard(){
	var idCard=$("idCard_restrict");
	if(idCard.value==""){
		return;
	}
	//身份证号
	if(checkIDCard(idCard) != true){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		return;
	}	
	var somPeopleDataSet = L5.DatasetMgr.lookup("somPeopleDataSet");
	somPeopleDataSet.setParameter("ID_CARD", idCard.value);
	somPeopleDataSet.load();
	somPeopleDataSet.on("load",function(ds){
		if(ds.getCount()>0){
			document.getElementById("name_restrict").value=ds.get("name");
		}
	});
}