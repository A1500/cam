
function init(){
	var reportDataSet=L5.DatasetMgr.lookup("reportDataSet");
	var infoDataSet=L5.DatasetMgr.lookup("infoDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	if(method=="insert"){
		infoDataSet.newRecord();
		reportDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N","communityNum":"1"});
		reportWorkDataSet.setParameter("organCode", organCode);
		reportWorkDataSet.load();
	}else{
		$("reportDate").disabled=true;
		document.getElementById("backInsert").style.display = "none";
		reportDataSet.setParameter("RECORD_ID@=",recordId);
		reportDataSet.load();
		infoDataSet.setParameter("RECORD_ID@=",recordId);
		infoDataSet.load();
		reportWorkDataSet.load();
	}
}
function forInsert(){
	var reportDataSet=L5.DatasetMgr.lookup("reportDataSet");
	reportDataSet.removeAll();
	reportDataSet.setParameter("ORGAN_CODE@=", organCode);
	reportDataSet.setParameter("sort","CREATE_TIME");	
	reportDataSet.setParameter("dir","desc");
	reportDataSet.load();
	reportDataSet.on("load",function(){
		if (reportDataSet.getCount()>0){
			var infoDataSet=L5.DatasetMgr.lookup("infoDataSet");
			reportDataSet.set("reportType","N");
			infoDataSet.setParameter("RECORD_ID@=",reportDataSet.getAt(0).get("recordId"));
			infoDataSet.load();
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				reportDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N","communityNum":"1"});
			});
		}
	});
	
}
function save(){
	if(document.getElementById("reportDate").value==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
	if(document.getElementById("ifCollect").value==""){
		L5.Msg.alert("提示","是否集中居住不能为空！");
		return;
	}
	if(document.getElementById("planArea").value==""){
		L5.Msg.alert("提示","规划集中居住区面积不能为空！");
		return;
	}
	if(document.getElementById("alreadyArea").value==""){
		L5.Msg.alert("提示","已建成集中居住区面积不能为空！");
		return;
	}
	if(document.getElementById("populateNum").value==""){
		L5.Msg.alert("提示","计划入住户数不能为空！");
		return;
	}
	if(document.getElementById("alreadyPopulateNum").value==""){
		L5.Msg.alert("提示","已入住户数不能为空！");
		return;
	}
	if(document.getElementById("peopleNum").value==""){
		L5.Msg.alert("提示","计划入住人数不能为空！");
		return;
	}
	if(document.getElementById("alreadyPeopleNum").value==""){
		L5.Msg.alert("提示","已入住人数不能为空！");
		return;
	}
	if(document.getElementById("investFinanceMon").value==""){
		L5.Msg.alert("提示","财政投入不能为空！");
		return;
	}
	if(document.getElementById("investDeveloperMon").value==""){
		L5.Msg.alert("提示","开发商不能为空！");
		return;
	}
	if(document.getElementById("investBankMon").value==""){
		L5.Msg.alert("提示","银行贷款不能为空！");
		return;
	}
	if(document.getElementById("investResiderMon").value==""){
		L5.Msg.alert("提示","居民垫付不能为空！");
		return;
	}
	if(document.getElementById("investOtherMon").value==""){
		L5.Msg.alert("提示","其他不能为空！");
		return;
	}
	if(document.getElementById("serviceArea").value==""){
		L5.Msg.alert("提示","服务中心建筑面积不能为空！");
		return;
	}
	if(document.getElementById("serviceIfCollect").value==""){
		L5.Msg.alert("提示","服务中心是否在中心村不能为空！");
		return;
	}
	if(document.getElementById("serviceFinanceMon").value==""){
		L5.Msg.alert("提示","服务中心建设资金来源财政投入不能为空！");
		return;
	}
	if(document.getElementById("serviceSelfMon").value==""){
		L5.Msg.alert("提示","服务中心建设资金来源自筹不能为空！");
		return;
	}
	if(document.getElementById("serviceEndowMon").value==""){
		L5.Msg.alert("提示","服务中心建设资金来源社会捐赠不能为空！");
		return;
	}
	if(document.getElementById("serviceOtherMon").value==""){
		L5.Msg.alert("提示","服务中心建设资金来源其他不能为空！");
		return;
	}
	var reportDataSet=L5.DatasetMgr.lookup("reportDataSet");
	var infoDataSet=L5.DatasetMgr.lookup("infoDataSet");
	var isValidate = infoDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var record=infoDataSet.getCurrent();
	if(record.get("ifCollect")=='1'){
		reportDataSet.set("collectNum",1);
	}else{
		reportDataSet.set("collectNum",0);
	}
	reportDataSet.set("planArea",record.get("planArea"));
	reportDataSet.set("alreadyArea",record.get("alreadyArea"));
	reportDataSet.set("populateNum",record.get("populateNum"));
	reportDataSet.set("peopleNum",record.get("peopleNum"));
	reportDataSet.set("alreadyPopulateNum",record.get("alreadyPopulateNum"));
	reportDataSet.set("alreadyPeopleNum",record.get("alreadyPeopleNum"));
	reportDataSet.set("investMon",record.get("investMon"));
	reportDataSet.set("investFinanceMon",record.get("investFinanceMon"));
	reportDataSet.set("investDeveloperMon",record.get("investDeveloperMon"));
	reportDataSet.set("investBankMon",record.get("investBankMon"));
	reportDataSet.set("investResiderMon",record.get("investResiderMon"));
	reportDataSet.set("investOtherMon",record.get("investOtherMon"));
	reportDataSet.set("serviceArea",record.get("serviceArea"));
	reportDataSet.set("serviceMon",record.get("serviceMon"));
	if(record.get("serviceIfCollect")=='1'){
		reportDataSet.set("serviceCollectNum",1);
	}else{
		reportDataSet.set("serviceCollectNum",0);
	}
	reportDataSet.set("serviceFinanceMon",record.get("serviceFinanceMon"));
	reportDataSet.set("serviceSelfMon",record.get("serviceSelfMon"));
	reportDataSet.set("serviceEndowMon",record.get("serviceEndowMon"));
	reportDataSet.set("serviceOtherMon",record.get("serviceOtherMon"));
	isValidate = reportDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var reportRrecod = reportDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcConstructReportCmd");
	command.setParameter("record",record);
	command.setParameter("reportRrecod",reportRrecod);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			var url = "jsp/ext/cdc/manage/construct/vcdcConstructInfoList.jsp"; 
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
			var url = "jsp/ext/cdc/manage/construct/vcdcConstructInfoList.jsp"; 
			L5.forward(url,'',null);
		}
	});
}
function reRender(val){
	if(val==''){
		return "0 万元";
	}
	return val+" 万元";
}

function getInvestMon(){
	var sum1  = document.getElementById("investFinanceMon").value;
	var sum2 = document.getElementById("investDeveloperMon").value;
	var sum3 = document.getElementById("investBankMon").value;
	var sum4 = document.getElementById("investResiderMon").value;
	var sum5 = document.getElementById("investOtherMon").value;
	var infoDataSet=L5.DatasetMgr.lookup("infoDataSet");
	var record=infoDataSet.getCurrent();
	record.set("investMon",(Number(sum1)+Number(sum2)+Number(sum3)+Number(sum4)+Number(sum5)));
}

function getServiceMon(){
	var sum1  = document.getElementById("serviceFinanceMon").value;
	var sum2 = document.getElementById("serviceSelfMon").value;
	var sum3 = document.getElementById("serviceEndowMon").value;
	var sum4 = document.getElementById("serviceOtherMon").value;
	var infoDataSet=L5.DatasetMgr.lookup("infoDataSet");
	var record=infoDataSet.getCurrent();
	record.set("serviceMon",(Number(sum1)+Number(sum2)+Number(sum3)+Number(sum4)));
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


//如是小数，保留到两位
function fordecimalcheck(item){
	var offOtherMon=item.value;
	if (offOtherMon > ""){ 
	   var reg=/^\d+(\.\d{0,2})?$/; 
	   if(!reg.test(offOtherMon)){
	   		L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
	   		item.focus();});
	   		item.value="";
	    	
	   		return;
	   }
	}
}

//如是小数，保留到两位
function forInvestCheck(item){
	var offOtherMon=item.value;
	if (offOtherMon > ""){ 
	   var reg=/^\d+(\.\d{0,2})?$/; 
	   if(!reg.test(offOtherMon)){
	   		L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
	   		item.focus();
	   		});
	   		item.value="";
	    	
	   		return;
	   }else{
	 		getInvestMon();
	 	}
	}
}

//如是小数，保留到两位
function forServiceCheck(item){
	var offOtherMon=item.value;
	if (offOtherMon > ""){ 
	   var reg=/^\d+(\.\d{0,2})?$/; 
	   if(!reg.test(offOtherMon)){
	   		L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
	   		item.focus();
	   		});
	   		item.value="";
	    	
	   		return;
	   }else{
	 		getServiceMon();
	 	}
	}
}