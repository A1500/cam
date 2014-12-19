var taskCode="";
var printWinNum="";
function init(){
	var tab = L5.getCmp("tab");
	for(var i = tab.items.length-1;i>=0;i--){
		tab.setActiveTab(i);
	}
	
	somPenaltyApplyDataSet.setParameter("ID", processId);
	somPenaltyApplyDataSet.on("load", loadInfo);
	somPenaltyApplyDataSet.load();
	if(method=="yiban"){
		if(act=="p_reg"||act=="p_regCheck"||act=="p_regAudit"){
			L5.getCmp("tab").remove(2);
		}else if(act=="p_invEnd"||act=="p_invEndCheck"||act=="p_invEndAudit"){
			L5.getCmp("tab").remove(4);
		}else if(act=="p_penalty"||act=="p_penaltyCheck"||act=="p_penaltyAudit"){
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
	somPenaltyDataSet.on("load",function(ds){
		if(act=="p_accept"&&method=="yiban"){
			
		}else if(act=="p_reg"){
			if(ds.get("caseBrief")!=""){
				ds.set("caseDesc",ds.get("caseBrief"));
			}
		}else if(act=="p_inform"&&method=="daiban"){
			if(ds.get("informContent")==""){
				var invPunSuggestions=ds.get("invPunSuggestions");
				ds.set("informContent",invPunSuggestions);
			}
			//loadAvermentReason();
			//loadHearingApply();
		}else if(act=="p_penaltyInform"&&method=="daiban"){
			if(ds.get("penaltyInfact")==""){
				var invInfact=ds.get("invInfact");
				ds.set("penaltyInfact",invInfact);
			}
			if(ds.get("penaltyProof")==""){
				var invProve=ds.get("invProve");
				ds.set("penaltyProof",invProve);
			}
			if(ds.get("penaltyReason")==""){
				var invProof=ds.get("invProof");
				ds.set("penaltyReason",invProof);			
			}
			if(ds.get("penaltyResult")==""){
				var informContent=ds.get("informContent");
				ds.set("penaltyResult",informContent);
			}
		}
		if(act!="p_inform"&&act!="p_penalty"&&act!="p_penaltyCheck"&&act!="p_penaltyAudit"&&act!="p_penaltyInform"){
			loadCaseSource();
		}
	});
	somPenaltyDataSet.load();
	if(L5.getCmp("uploadList")){
		somElectronicDataSet_load();
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
	var command = new L5.Command("com.inspur.cams.sorg.penalty.penalty.cmd.SomPenaltyApplyCmd");
	command.setParameter("somPenaltyRd",somPenaltyRd);
	command.setParameter("somPenaltyApplyRd",somPenaltyApplyRd);	
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
	var command = new L5.Command("com.inspur.cams.sorg.penalty.penalty.cmd.SomPenaltyApplyCmd");
	command.setParameter("somPenaltyRd",somPenaltyRd);
	command.setParameter("somPenaltyApplyRd",somPenaltyApplyRd);	
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

function loadAvermentReason(){
	if(_$("ifAverment") == "1"){
		$("avermentReasonTr").style.display = "block";
	}else{
		$("avermentReasonTr").style.display = "none";
	}
}
function loadHearingApply(){
	if(_$("ifHearing") == "1"){
		$("hearingApplyTr").style.display = "block";
		$("hearingTr").style.display = "block";
	}else{
		$("hearingApplyTr").style.display = "none";
		$("hearingTr").style.display = "none";
	}
}
function loadHearingPartyChargerName(){
	if(_$("hearingPartyCharger")=="1"){
		$("hearingPartyChargerName").value=somPenaltyDataSet.get("partyCharger");
	}else if(_$("hearingPartyCharger")==""||_$("hearingPartyCharger")=="2"){
		$("hearingPartyChargerName").value="";
	}
}
//点击打印文书按钮
function forPrint(){
	var win=L5.getCmp('printWin');
	win.show();
}
//关闭打印文书窗口
function closePrint(){
	var win = L5.getCmp("printWin");
	win.setVisible(false);
}
//关闭窗口
function closePrintWin(){
	var win = L5.getCmp("printWin"+printWinNum);
	win.setVisible(false);
}
//选择完打印事项后点击确定
function forPrintItem(){
	var num=_$("printItem");
	if(num == ""){
		L5.Msg.alert("提示","请选择打印事项!");
		return;
	}	
	var win=L5.getCmp('printWin');
	win.hide();		
	if(num=='1'){
		var win=L5.getCmp('printWin1');
		win.show();
	}else if(num=='2'){
		printInform("beforeInformPublic");
	}else if(num=='3'){
		printBack("beforeInformBack");
	}else if(num=='4'){
		printInform("hearingInform");
	}else if(num=='5'){
		printInform("hearingInformPublic");
	}else if(num=='6'){
		printBack("hearingInformBack");
	}else if(num=='7'){	
		var win=L5.getCmp('printWin7');
		win.show();
	}
	else if(num=='110'){	
		var win=L5.getCmp('printWin110');
		win.show();
	}else if(num=='111'){		
		var win=L5.getCmp('printWin111');
		win.show();
	}else if(num=='112'){
		printPenaltyInform("noCheckTwo");
	}else if(num=='113'){
		var win=L5.getCmp('printWin113');
		win.show();
	}
	else if(num=='12'){
		printPenaltyInform("penaltyPublic");
	}else if(num=='13'){
		printBack("penaltyBack");
	}	
	printWinNum=num;
}
//打印行政处罚事先告知书窗口确定按钮
function forPrintBeforeInform(){
	var win=L5.getCmp('printWin1');
	win.hide();	
	printInform("beforeInform");
}
//打印行政处罚听证通知书窗口确定按钮
function forPrintHearingNotice(){	
	var win=L5.getCmp('printWin7');
	win.hide();	
	printHearingNotice();
}
//打印行政处罚决定书窗口确定按钮
function forPrintPenaltyInform(){
	var win=L5.getCmp('printWin110');
	win.hide();	
	printPenaltyInform("");
}
//打印行政处罚决定书(一年不年检)窗口确定按钮
function forPrintPenaltyInformNoCheck(){
	var win=L5.getCmp('printWin111');
	win.hide();	
	printPenaltyInform("noCheck");
}
//打印行政处罚决定书(超范围、经营活动及违规收费)窗口确定按钮
function forPrintPenaltyInformOverScope(){
	var win=L5.getCmp('printWin113');
	win.hide();	
	printPenaltyInform("overScope");
}
//行政处罚事先告知书
//《行政处罚事先告知书》送达公告
//行政处罚听证告知书
//《行政处罚听证告知书》送达公告
function printInform(op){
	var informNo=somPenaltyDataSet.get("informNo");
	if(op=="beforeInform"||op=="beforeInformPublic"){
		
	}else if(op=="hearingInform"||op=="hearingInformPublic"){
		
	}
	var somPenaltyDataSetIsValidate = somPenaltyDataSet.isValidate();
	if(somPenaltyDataSetIsValidate != true){
		L5.Msg.alert('提示',somPenaltyDataSetIsValidate);
		return false;
	}
	var somPenaltyRd=somPenaltyDataSet.getCurrent();
	var somPenaltyApplyRd=somPenaltyApplyDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.penalty.penalty.cmd.SomPenaltyApplyCmd");
	command.setParameter("somPenaltyRd",somPenaltyRd);
	command.setParameter("somPenaltyApplyRd",somPenaltyApplyRd);	
	command.execute("save");
	if(!command.error){	
		var informDayNum="";
		if(op=="beforeInform"){
			informDayNum=_$("informDayNum");
			if(informDayNum==""){
				L5.Msg.alert("提示","请填写责令改正天数!");
				return;
			}
		}
		var url=rootPath+"jsp/cams/sorg/comm/print/penalty/base/penaltyBaseInformForPrint.jsp?taskCode="+taskCode+"&informDayNum="+informDayNum+"&op="+op;
		window.open(url);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//《行政处罚事先告知书》送达回证
//《行政处罚听证告知书》送达回证
//《行政处罚决定书》送达回证
function printBack(op){
	var somPenaltyDataSetIsValidate = somPenaltyDataSet.isValidate();
	if(somPenaltyDataSetIsValidate != true){
		L5.Msg.alert('提示',somPenaltyDataSetIsValidate);
		return false;
	}
	var somPenaltyRd=somPenaltyDataSet.getCurrent();
	var somPenaltyApplyRd=somPenaltyApplyDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.penalty.penalty.cmd.SomPenaltyApplyCmd");
	command.setParameter("somPenaltyRd",somPenaltyRd);
	command.setParameter("somPenaltyApplyRd",somPenaltyApplyRd);	
	command.execute("save");
	if(!command.error){	
		var url=rootPath+"jsp/cams/sorg/comm/print/penalty/base/penaltyBaseBackForPrint.jsp?taskCode="+taskCode+"&op="+op;	
		window.open(url);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//行政处罚听证通知书
function printHearingNotice(){
	var hearingAddDetail=_$("hearingAddDetail");
	var hearingDelayEndDate=_$("hearingDelayEndDate");
	var hearingPresenterAvoidEndDate=_$("hearingPresenterAvoidEndDate");
	var somPenaltyDataSetIsValidate = somPenaltyDataSet.isValidate();
	if(somPenaltyDataSetIsValidate != true){
		L5.Msg.alert('提示',somPenaltyDataSetIsValidate);
		return false;
	}
	var somPenaltyRd=somPenaltyDataSet.getCurrent();
	var somPenaltyApplyRd=somPenaltyApplyDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.penalty.penalty.cmd.SomPenaltyApplyCmd");
	command.setParameter("somPenaltyRd",somPenaltyRd);
	command.setParameter("somPenaltyApplyRd",somPenaltyApplyRd);	
	command.execute("save");
	if(!command.error){	
		hearingAddDetail=encodeURIComponent(encodeURIComponent(hearingAddDetail));
		var url=rootPath+"jsp/cams/sorg/comm/print/penalty/base/penaltyBaseHearingNoticeForPrint.jsp?taskCode="+taskCode+"&hearingAddDetail="+hearingAddDetail+"&hearingDelayEndDate="+hearingDelayEndDate+"&hearingPresenterAvoidEndDate="+hearingPresenterAvoidEndDate;	
		window.open(url);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//行政处罚决定书
//《行政处罚决定书》送达公告
function printPenaltyInform(op){
	var sorgType=somPenaltyDataSet.get("sorgType");
	var penaltyDeregulation="";
	if(sorgType=="S"){
		penaltyDeregulation="《社会团体登记管理条例》";
	}else if(sorgType=="M"){
		penaltyDeregulation="《民办非企业单位登记管理暂行条例》";
	}else if(sorgType=="J"){
		penaltyDeregulation="《基金会管理条例》";
	}
	somPenaltyDataSet.set("penaltyDeregulation",penaltyDeregulation);
	var somPenaltyDataSetIsValidate = somPenaltyDataSet.isValidate();
	if(somPenaltyDataSetIsValidate != true){
		L5.Msg.alert('提示',somPenaltyDataSetIsValidate);
		return false;
	}
	var somPenaltyRd=somPenaltyDataSet.getCurrent();
	var somPenaltyApplyRd=somPenaltyApplyDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.penalty.penalty.cmd.SomPenaltyApplyCmd");
	command.setParameter("somPenaltyRd",somPenaltyRd);
	command.setParameter("somPenaltyApplyRd",somPenaltyApplyRd);	
	command.execute("save");
	if(!command.error){	
		var penaltyInformDayNum="";
		var beginDate="";
		var endDate="";
		if(op=="noCheck"){
			penaltyInformDayNum=_$("penaltyInformDayNum");
			if(penaltyInformDayNum==""){
				L5.Msg.alert("提示","请填写责令补办年检天数!");
				return;
			}
		}else if(op=="overScope"){			
			beginDate=_$("beginDate");
			endDate=_$("endDate");
			if(beginDate==""||endDate==""){
				L5.Msg.alert("提示","请填写违法行为起始日期!");
				return;
			}
		}
		var url=rootPath+"jsp/cams/sorg/comm/print/penalty/penalty/penaltyInformForPrint.jsp?taskCode="+taskCode+"&penaltyInformDayNum="+penaltyInformDayNum+"&beginDate="+beginDate+"&endDate="+endDate+"&op="+op;
		window.open(url);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}