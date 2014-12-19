function init(){
	var superviseDataSet=L5.DatasetMgr.lookup("superviseDataSet");
	var superviseInfoDataSet=L5.DatasetMgr.lookup("superviseInfoDataSet");
	var reviewDs=L5.DatasetMgr.lookup("reviewDs");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	if(method=="insert"){
		superviseInfoDataSet.newRecord();
		superviseDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N"});
		reportWorkDataSet.setParameter("organCode", organCode);
		reportWorkDataSet.load();
	}else{
		$("reportDate").disabled=true;
		superviseDataSet.setParameter("RECORD_ID@=",recordId);
		superviseDataSet.load();
		superviseInfoDataSet.setParameter("RECORD_ID@=",recordId);
		superviseInfoDataSet.load();
		reviewDs.setParameter("RECORD_ID@=",recordId);
		reviewDs.load();
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
				superviseDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N"});
			});
		}
	});
}
function save(){
	if(_$("reportDate")==""){
		L5.Msg.alert("提示", "填报日期不能为空！");
		return false;
	}
	if(_$("ifPublish")==""){
		L5.Msg.alert("提示","是否经村委会提出公开方案不能为空！");
		return false;
	}
	if(_$("ifAudit")==""){
		L5.Msg.alert("提示","是否经村务监督委员会审查、补充、完善不能为空！");
		return false;
	}
	if(_$("ifDiscuss")==""){
		L5.Msg.alert("提示","是否经村党组织和村委会联席会议讨论确定不能为空！");
		return false;
	}
	if(_$("partCyc")==""){
		L5.Msg.alert("提示","党务公开不能为空！");
		return false;
	}
	if(_$("govCyc")==""){
		L5.Msg.alert("提示","政务公开不能为空！");
		return false;
	}
	if(_$("affairCyc")==""){
		L5.Msg.alert("提示","事务公开不能为空！");
		return false;
	}
	if(_$("financeCyc")==""){
		L5.Msg.alert("提示","财务公开不能为空！");
		return false;
	}
	if(_$("formPlacard")==""){
		L5.Msg.alert("提示","公开方式-公开栏不能为空！");
		return false;
	}
	if(_$("formWeb")==""){
		L5.Msg.alert("提示","公开方式-网络不能为空！");
		return false;
	}
	if(_$("formMeeting")==""){
		L5.Msg.alert("提示","公开方式-民主听证会不能为空！");
		return false;
	}
	if(_$("formPaper")==""){
		L5.Msg.alert("提示","公开方式-明白纸不能为空！");
		return false;
	}
	if(_$("formOther")==""){
		L5.Msg.alert("提示","公开方式-其他不能为空！");
		return false;
	}
	var reviewDs=L5.DatasetMgr.lookup("reviewDs");
	if(reviewDs.getCount()<1){
		L5.Msg.alert("提示","民主评议不能为空！");
		return false;
	}
	var superviseDataSet=L5.DatasetMgr.lookup("superviseDataSet");	//上报信息
	var superviseInfoDataSet=L5.DatasetMgr.lookup("superviseInfoDataSet"); //明细
	var record=superviseInfoDataSet.getCurrent();
	
	//给上报数据赋值
	superviseDataSet.set("reportDate",document.getElementById("reportDate").value);
	if(record.get("ifPublish")=='0'){
		superviseDataSet.set("publishNum","0");
		superviseDataSet.set("noPublishNum","1");
	}else{
		superviseDataSet.set("publishNum","1");
		superviseDataSet.set("noPublishNum","0");
	}
	if(record.get("ifAudit")=='0'){
		superviseDataSet.set("auditNum","0");
		superviseDataSet.set("noAuditNum","1");
	}else{
		superviseDataSet.set("auditNum","1");
		superviseDataSet.set("noAuditNum","0");
	}
	if(record.get("ifDiscuss")=='0'){
		superviseDataSet.set("discussNum","0");
		superviseDataSet.set("noDiscussNum","1");
	}else{
		superviseDataSet.set("discussNum","1");
		superviseDataSet.set("noDiscussNum","0");
	}
	if(record.get("partCyc")=='1'){
		superviseDataSet.set("partYear","1");
		superviseDataSet.set("partSeason","0");
		superviseDataSet.set("partMonth","0");
		superviseDataSet.set("partImm","0");
	}else if(record.get("partCyc")=='2'){
		superviseDataSet.set("partYear","0");
		superviseDataSet.set("partSeason","1");
		superviseDataSet.set("partMonth","0");
		superviseDataSet.set("partImm","0");
	}else if(record.get("partCyc")=='3'){
		superviseDataSet.set("partYear","0");
		superviseDataSet.set("partSeason","0");
		superviseDataSet.set("partMonth","1");
		superviseDataSet.set("partImm","0");
	}else if(record.get("partCyc")=='4'){
		superviseDataSet.set("partYear","0");
		superviseDataSet.set("partSeason","0");
		superviseDataSet.set("partMonth","0");
		superviseDataSet.set("partImm","1");
	}
	if(record.get("govCyc")=='1'){
		superviseDataSet.set("govYear","1");
		superviseDataSet.set("govSeason","0");
		superviseDataSet.set("govMonth","0");
		superviseDataSet.set("govImm","0");
	}else if(record.get("govCyc")=='2'){
		superviseDataSet.set("govYear","0");
		superviseDataSet.set("govSeason","1");
		superviseDataSet.set("govMonth","0");
		superviseDataSet.set("govImm","0");
	}else if(record.get("govCyc")=='3'){
		superviseDataSet.set("govYear","0");
		superviseDataSet.set("govSeason","0");
		superviseDataSet.set("govMonth","1");
		superviseDataSet.set("govImm","0");
	}else if(record.get("govCyc")=='4'){
		superviseDataSet.set("govYear","0");
		superviseDataSet.set("govSeason","0");
		superviseDataSet.set("govMonth","0");
		superviseDataSet.set("govImm","1");
	}
	if(record.get("affairCyc")=='1'){
		superviseDataSet.set("affairYear","1");
		superviseDataSet.set("affairSeason","0");
		superviseDataSet.set("affairMonth","0");
		superviseDataSet.set("affairImm","0");
	}else if(record.get("affairCyc")=='2'){
		superviseDataSet.set("affairYear","0");
		superviseDataSet.set("affairSeason","1");
		superviseDataSet.set("affairMonth","0");
		superviseDataSet.set("affairImm","0");
	}else if(record.get("affairCyc")=='3'){
		superviseDataSet.set("affairYear","0");
		superviseDataSet.set("affairSeason","0");
		superviseDataSet.set("affairMonth","1");
		superviseDataSet.set("affairImm","0");
	}else if(record.get("affairCyc")=='4'){
		superviseDataSet.set("affairYear","0");
		superviseDataSet.set("affairSeason","0");
		superviseDataSet.set("affairMonth","0");
		superviseDataSet.set("affairImm","1");
	}
	if(record.get("financeCyc")=='1'){
		superviseDataSet.set("financeYear","1");
		superviseDataSet.set("financeSeason","0");
		superviseDataSet.set("financeMonth","0");
		superviseDataSet.set("financeImm","0");
	}else if(record.get("financeCyc")=='2'){
		superviseDataSet.set("financeYear","0");
		superviseDataSet.set("financeSeason","1");
		superviseDataSet.set("financeMonth","0");
		superviseDataSet.set("financeImm","0");
	}else if(record.get("financeCyc")=='3'){
		superviseDataSet.set("financeYear","0");
		superviseDataSet.set("financeSeason","0");
		superviseDataSet.set("financeMonth","1");
		superviseDataSet.set("financeImm","0");
	}else if(record.get("financeCyc")=='4'){
		superviseDataSet.set("financeYear","0");
		superviseDataSet.set("financeSeason","0");
		superviseDataSet.set("financeMonth","0");
		superviseDataSet.set("financeImm","1");
	}
	if(record.get("formPlacard")=='0'){
		superviseDataSet.set("placardNum","0");
	}else{
		superviseDataSet.set("placardNum","1");
	}
	if(record.get("formWeb")=='0'){
		superviseDataSet.set("webNum","0");
	}else{
		superviseDataSet.set("webNum","1");
	}
	if(record.get("formMeeting")=='0'){
		superviseDataSet.set("meetingNum","0");
	}else{
		superviseDataSet.set("meetingNum","1");
	}
	if(record.get("formPaper")=='0'){
		superviseDataSet.set("paperNum","0");
	}else{
		superviseDataSet.set("paperNum","1");
	}
	if(record.get("formOther")=='0'){
		superviseDataSet.set("otherNum","0");
	}else{
		superviseDataSet.set("otherNum","1");
	}
	var mbNum=0;
	var mbExcellentNum=0;
	var mbCompetentNum=0;
	var mbUncompetentNum=0;
	var emNum=0;
	var emExcellentNum=0;
	var emCompetentNum=0;
	var emUncompetentNum=0;
	for(i=0;i<reviewDs.getCount();i++){
		var reviewRec=reviewDs.getAt(i);
		if(reviewRec.get("peopleType")=='1'){
			mbNum++;
			if(reviewRec.get("result")=='1'){
				mbExcellentNum++;
			}else if(reviewRec.get("result")=='2'){
				mbCompetentNum++;
			}else if(reviewRec.get("result")=='3'){
				mbUncompetentNum++;
			}
		}
		if(reviewRec.get("peopleType")=='2'){
			emNum++;
			if(reviewRec.get("result")=='1'){
				emExcellentNum++;
			}else if(reviewRec.get("result")=='2'){
				emCompetentNum++;
			}else if(reviewRec.get("result")=='3'){
				emUncompetentNum++;
			}
		}
	}
	superviseDataSet.set("mbNum",mbNum);
	superviseDataSet.set("mbExcellentNum",mbExcellentNum);
	superviseDataSet.set("mbCompetentNum",mbCompetentNum);
	superviseDataSet.set("mbUncompetentNum",mbUncompetentNum);
	superviseDataSet.set("emNum",emNum);
	superviseDataSet.set("emExcellentNum",emExcellentNum);
	superviseDataSet.set("emCompetentNum",emCompetentNum);
	superviseDataSet.set("emUncompetentNum",emUncompetentNum);
	
	var reportRec=superviseDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcSuperviseReportCmd");
	command.setParameter("record",reportRec);
	command.setParameter("record2",record);
	command.setParameter("list",reviewDs.getAllChangedRecords());
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			var url="jsp/ext/cdc/manage/supervise/vcdcSuperviseInfoList.jsp";
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
				var url="jsp/ext/cdc/manage/supervise/vcdcSuperviseInfoList.jsp";
	L5.forward(url,'',null);
		}
	});
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
var isAdd=false;
function insert(){
	L5.getCmp("cmWin").show();
	var reviewDs=L5.DatasetMgr.lookup("reviewDs");
	reviewDs.newRecord();
	isAdd=true;
}
function update(){
	L5.getCmp("cmWin").show();
	isAdd=false;
}
function del(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var reviewDs=L5.DatasetMgr.lookup("reviewDs");
	reviewDs.remove(records[0]);
}
function confirm(){
	if(_$("peopleType")==""){
		alert("被评议人员类型不能为空！");
		return;
	}
	if(_$("name")==""){
		alert("被评议人员姓名不能为空！");
		return;
	}
	if(_$("reviewDate")==""){
		alert("民主评议时间不能为空！");
		return;
	}
	if(_$("manner")==""){
		alert("评议方式不能为空！");
		return;
	}
	if(_$("meetingShouldNum")==""){
		alert("应到人数不能为空！");
		return;
	}
	if(_$("meetingRealNum")==""){
		alert("实到人数不能为空！");
		return;
	}
	if(_$("excellentNum")==""){
		alert("优秀票数不能为空！");
		return;
	}
	if(_$("competentNum")==""){
		alert("称职票数不能为空！");
		return;
	}
	if(_$("uncompetentNum")==""){
		alert("不称职票数不能为空！");
		return;
	}
	if(_$("result")==""){
		alert("评议结果不能为空！");
		return;
	}
	L5.getCmp("cmWin").hide();
}
function getReviewResult(){
	var reviewDs=L5.DatasetMgr.lookup("reviewDs");
	var rec=reviewDs.getCurrent();
	if(rec.get("excellentNum")==""||rec.get("competentNum")==""||rec.get("uncompetentNum")){
		rec.set("result","");
		return;
	}
	var e=parseInt(rec.get("excellentNum"));
	var c=parseInt(rec.get("competentNum"));
	var u=parseInt(rec.get("uncompetentNum"));
	if(e>=c&&e>=u){
		alert(1);
		rec.set("result","1");
	}
	if(c>=e&&c>=u){
		alert(2);
		rec.set("result","2");
	}
	if(u>=e&&u>=c){
		alert(3);
		rec.set("result","3");
	}
}
function closeWin(){
	if(isAdd){
		var reviewDs=L5.DatasetMgr.lookup("reviewDs");
		reviewDs.remove(reviewDs.getCurrent());
	}
	L5.getCmp("cmWin").hide();
}