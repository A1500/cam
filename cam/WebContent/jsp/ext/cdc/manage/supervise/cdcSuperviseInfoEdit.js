function init(){
	var superviseDataSet=L5.DatasetMgr.lookup("superviseDataSet");
	var superviseInfoDataSet=L5.DatasetMgr.lookup("superviseInfoDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	if(method=="insert"){
		document.getElementById("backInsert").style.display = "block";
		superviseInfoDataSet.newRecord({"organCode":organCode,"recordId":recordId});
		superviseDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"C"});
		reportWorkDataSet.setParameter("organCode", organCode);
		reportWorkDataSet.load();
	}else{
		document.getElementById("backInsert").style.display = "none";
		$("reportDate").disabled=true;
		superviseDataSet.setParameter("RECORD_ID@=",recordId);
		superviseDataSet.load();
		superviseInfoDataSet.setParameter("RECORD_ID@=",recordId);
		superviseInfoDataSet.load();
		reportWorkDataSet.load();
	}
}
function forInsert(){
	var superviseDataSet=L5.DatasetMgr.lookup("superviseDataSet");
	superviseDataSet.removeAll();
	superviseDataSet.setParameter("ORGAN_CODE@=", organCode);
	superviseDataSet.setParameter("sort","CREATE_TIME");	
	superviseDataSet.setParameter("dir","desc");
	superviseDataSet.load();
	superviseDataSet.on("load",function(){
		if (superviseDataSet.getCount()>0){
			var superviseInfoDataSet=L5.DatasetMgr.lookup("superviseInfoDataSet");
			superviseInfoDataSet.setParameter("RECORD_ID@=",superviseDataSet.getAt(0).get("recordId"));
			superviseInfoDataSet.load();
			superviseInfoDataSet.on("load",function(){
				superviseInfoDataSet.each(function(record,index){
					record.set("superviseId","");
				});
			});
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				superviseDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"C"});
			});
		}
	});
	
}
function save(){
	var reportDate = document.getElementById("reportDate").value;
	if(reportDate == ""){
		L5.Msg.alert("提示", "校验未通过,不能保存! 填报日期不能为空！");
		return false;
	}
	var ifPublish = document.getElementById("ifPublish").value;
	if(ifPublish == ""){
		L5.Msg.alert("提示", "校验未通过,不能保存! 居务是否公开不能为空！");
		return false;
	}
	var ifAudit = document.getElementById("ifAudit").value;
	if(ifAudit == ""){
		L5.Msg.alert("提示", "校验未通过,不能保存! 政务是否公开不能为空！");
		return false;
	}
	var ifPublishFinance = document.getElementById("ifPublishFinance").value;
	if(ifPublishFinance == ""){
		L5.Msg.alert("提示", "校验未通过,不能保存! 财务是否公开不能为空！");
		return false;
	}
	var formPlacard = document.getElementById("formPlacard").value;
	if(formPlacard == ""){
		L5.Msg.alert("提示", "校验未通过,不能保存! 是否有公开栏不能为空！");
		return false;
	}
	var formMeeting = document.getElementById("formMeeting").value;
	if(formMeeting == ""){
		L5.Msg.alert("提示", "校验未通过,不能保存! 是否有触摸屏不能为空！");
		return false;
	}
	var formWeb = document.getElementById("formWeb").value;
	if(formWeb == ""){
		L5.Msg.alert("提示", "校验未通过,不能保存! 是否有计算机网络不能为空！");
		return false;
	}
	var formPaper = document.getElementById("formPaper").value;
	if(formPaper == ""){
		L5.Msg.alert("提示", "校验未通过,不能保存! 是否有明白纸不能为空！");
		return false;
	}
	var formOther = document.getElementById("formOther").value;
	if(formOther == ""){
		L5.Msg.alert("提示", "校验未通过,不能保存! 其他不能为空！");
		return false;
	}
	var discussMemberNum = document.getElementById("discussMemberNum").value;
	if(discussMemberNum == ""){
		L5.Msg.alert("提示", "校验未通过,不能保存! 居委会成员接受评议次数不能为空！");
		return false;
	}
	var discussEmployNum = document.getElementById("discussEmployNum").value;
	if(discussEmployNum == ""){
		L5.Msg.alert("提示", "校验未通过,不能保存! 居委会聘用人员受评人数不能为空！");
		return false;
	}
	var notCompetentNum = document.getElementById("notCompetentNum").value;
	if(notCompetentNum == ""){
		L5.Msg.alert("提示", "校验未通过,不能保存! 连续两次被评议为不称职人数不能为空！");
		return false;
	}
	var memberNum = document.getElementById("memberNum").value;
	if(memberNum == ""){
		L5.Msg.alert("提示", "校验未通过,不能保存! 居务监督委员会人数不能为空！");
		return false;
	}
	var meetingPeopleNum = document.getElementById("meetingPeopleNum").value;
	if(meetingPeopleNum == ""){
		L5.Msg.alert("提示", "校验未通过,不能保存! 居务监督委员会经居民会议推选产生人数不能为空！");
		return false;
	}
	var sovietPeopleNum = document.getElementById("sovietPeopleNum").value;
	if(sovietPeopleNum == ""){
		L5.Msg.alert("提示", "校验未通过,不能保存! 居务监督委员会经居民会代表会议产生人数不能为空！");
		return false;
	}
	var superviseDataSet=L5.DatasetMgr.lookup("superviseDataSet");
	var superviseInfoDataSet=L5.DatasetMgr.lookup("superviseInfoDataSet");
	var record2=superviseInfoDataSet.getCurrent();
	var record=superviseDataSet.getCurrent();
	
	if(Number(record.get("meetingPeopleNum"))>Number(record.get("financeCyc"))){
		L5.Msg.alert("提示","居务监督委员会经居民会议推选产生人数应小于等于居务监督委员会人数！");
		return false;
	}
	if(Number(record.get("sovietPeopleNum"))>Number(record.get("financeCyc"))){
		L5.Msg.alert("提示","居务监督委员会经居民会代表会议产生人数应小于等于居务监督委员会人数！");
		return false;
	}
	var isValidate = superviseInfoDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	//给上报数据赋值
	//居务公开
	if(record2.get("ifPublish")=='0'){
		record.set("publishNum","0");
	}else{
		record.set("publishNum","1");
	}
	//政务公开
	if(record2.get("ifAudit")=='0'){
		record.set("auditNum","0");
	}else{
		record.set("auditNum","1");
	}
	//财务公开
	if(record2.get("ifDiscuss")=='0'){
		record.set("discussNum","0");
	}else{
		record.set("discussNum","1");
	}
	//公开栏
	if(record2.get("formPlacard")=='0'){
		record.set("placardNum","0");
	}else{
		record.set("placardNum","1");
	}
	//触摸板
	if(record2.get("formMeeting")=='0'){
		record.set("meetingNum","0");
	}else{
		record.set("meetingNum","1");
	}
	//计算机网络
	if(record2.get("formWeb")=='0'){
		record.set("webNum","0");
	}else{
		record.set("webNum","1");
	}
	//明白纸
	if(record2.get("formPaper")=='0'){
		record.set("paperNum","0");
	}else{
		record.set("paperNum","1");
	}
	//其他
	if(record2.get("formOther")=='0'){
		record.set("otherNum","0");
	}else{
		record.set("otherNum","1");
	}
	record.set("partYear",record2.get("partCyc"));//【城市：居委会成员接受评议次数】
	record.set("govYear",record2.get("govCyc"));//【城市：居委会聘用人员受评人数】
	record.set("affairYear",record2.get("affairCyc"));//【城市：连续两次被评议为不称职人数】
	record.set("financeYear",record2.get("financeCyc"));//【城市：居务监督委员会人数】
	record.set("financeMonth",record2.get("meetingPeopleNum"));//【城市：居务监督委员会经居民会议推选产生人数】
	record.set("financeImm",record2.get("sovietPeopleNum"));//【城市：居务监督委员会经居民会代表会议产生人数】
	record.set("reportDate",document.getElementById("reportDate").value);
	isValidate = superviseDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcSuperviseReportCmd");
	command.setParameter("record",record);
	command.setParameter("record2",record2);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			var url="jsp/ext/cdc/manage/supervise/cdcSuperviseInfoList.jsp";
	L5.forward(url,'',null);
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function returnBack(){
	L5.MessageBox.confirm("提示", "是否保存数据？",function(sta){
		if(sta=="yes"){
			save();
		}else{
			var url="jsp/ext/cdc/manage/supervise/cdcSuperviseInfoList.jsp";
	L5.forward(url,'',null);
		}
	});
}
function isNull(id,content){
	var item = document.getElementById(id).value;
	if(item ==""){
		L5.Msg.alert("提示", "校验未通过,不能保存!" +content+"不能为空！");
		return false;
	}
}
//判断是否是整数
function forcheck(item){
	var offOtherMon=item.value;
	if (offOtherMon > ""){ 
	   var reg=/[^\d]/g;
	   if ((offOtherMon.match(reg)!= null)){ 
	    L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
	    item.focus();
	    }); 
	    item.value="";
	    return ; 
	 	}
	}
}