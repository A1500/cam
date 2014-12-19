function init(){
	var decisionDataSet=L5.DatasetMgr.lookup("decisionDataSet");
	var infoDataSet=L5.DatasetMgr.lookup("infoDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	infoDataSet.on("load",function(){
		getData();
	});
	if(method=="insert"){
		decisionDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N"});
		reportWorkDataSet.setParameter("organCode", organCode);
		reportWorkDataSet.load();
	}else{
		$("reportDate").disabled=true;
		reportWorkDataSet.load();
		infoDataSet.setParameter("RECORD_ID@=",recordId);
		infoDataSet.load();
		decisionDataSet.setParameter("RECORD_ID@=",recordId);
		decisionDataSet.load(true);
		getPer();
	}
}
function forInsert(){
	var decisionInfoDataSet=L5.DatasetMgr.lookup("decisionInfoDataSet");
	decisionDataSet.removeAll();
	decisionDataSet.setParameter("ORGAN_CODE@=", organCode);
	decisionDataSet.setParameter("sort","CREATE_TIME");	
	decisionDataSet.setParameter("dir","desc");
	decisionDataSet.load();
	decisionDataSet.on("load",function(){
		if (decisionDataSet.getCount()>0){
		
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				decisionDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N"});
			});
		}
	});
}
function getData(){
	var decisionDataSet=L5.DatasetMgr.lookup("decisionDataSet");
	var record=decisionDataSet.getCurrent();
	var dataDs=L5.DatasetMgr.lookup("infoDataSet");
	var mNum=0;
	var mShouldNum=0;
	var mRealNum=0;
	var mAgreeNum=0;
	var mUnagreeNum=0;
	var mGiveupNum=0;
	var sNum=0;
	var sShouldNum=0;
	var sRealNum=0;
	var sFemaleNum=0;
	var sAgreeNum=0;
	var sUnagreeNum=0;
	var sGiveupNum=0;
	var rNum=0;
	var rShouldNum=0;
	var rRealNum=0;
	var rAgreeNum=0;
	var rUnagreeNum=0;
	var rGiveupNum=0;
	for(i=0;i<dataDs.getCount();i++){
		var rec=dataDs.getAt(i);
		if(rec.get("meetingType")=='1'){
			mNum++;
			mShouldNum+=rec.get("shouldNum");
			mRealNum+=rec.get("realNum");
			mAgreeNum+=rec.get("agreeNum");
			mUnagreeNum+=rec.get("unagreeNum");
			mGiveupNum+=rec.get("giveupNum");
		}else if(rec.get("meetingType")=='2'){
			sNum++;
			sShouldNum+=rec.get("shouldNum");
			sRealNum+=rec.get("realNum");
			sFemaleNum+=rec.get("femaleNum");
			sAgreeNum+=rec.get("agreeNum");
			sUnagreeNum+=rec.get("unagreeNum");
			sGiveupNum+=rec.get("giveupNum");
		}else if(rec.get("meetingType")=='3'){
			rNum++;
			rShouldNum+=rec.get("shouldNum");
			rRealNum+=rec.get("realNum");
			rAgreeNum+=rec.get("agreeNum");
			rUnagreeNum+=rec.get("unagreeNum");
			rGiveupNum+=rec.get("giveupNum");
		}
	}
	record.set('meetingNum',mNum);
	record.set('meetingShouldNum',mShouldNum);
	record.set('meetingRealNum',mRealNum);
	record.set('meetingAgreeNum',mAgreeNum);
	record.set('meetingUnagreeNum',mUnagreeNum);
	record.set('meetingGiveupNum',mGiveupNum);
	record.set('sovietNum',sNum);
	record.set('sovietShouldNum',sShouldNum);
	record.set('sovietRealNum',sRealNum);
	record.set('sovietFemaleNum',sFemaleNum);
	record.set('sovietAgreeNum',sAgreeNum);
	record.set('sovietUnagreeNum',sUnagreeNum);
	record.set('sovietGiveupNum',sGiveupNum);
	record.set('refNum',rNum);
	record.set('refShouldNum',rShouldNum);
	record.set('refRealNum',rRealNum);
	record.set('refAgreeNum',rAgreeNum);
	record.set('refUnagreeNum',rUnagreeNum);
	record.set('refGiveupNum',rGiveupNum);
	getPer();
}
function getPer(){
	var decisionDataSet=L5.DatasetMgr.lookup("decisionDataSet");
	var rec=decisionDataSet.getCurrent();
	if(rec.get("meetingShouldNum")=="0"){
		rec.set("meetingRealPer", "--");
	}else{
		rec.set("meetingRealPer", Math.round((rec.get("meetingRealNum")/rec.get("meetingShouldNum"))*10000)/100);
	}
	if(rec.get("meetingRealNum")=="0"){
		rec.set("meetingAgreePer", "--");
		rec.set("meetingUnagreePer", "--");
		rec.set("meetingGiveupPer", "--");
	}else{
		rec.set("meetingAgreePer", Math.round((rec.get("meetingAgreeNum")/rec.get("meetingRealNum"))*10000)/100);
		rec.set("meetingUnagreePer", Math.round((rec.get("meetingUnagreeNum")/rec.get("meetingRealNum"))*10000)/100);
		rec.set("meetingGiveupPer", Math.round((rec.get("meetingGiveupNum")/rec.get("meetingRealNum"))*10000)/100);
	}
	if(rec.get("sovietShouldNum")=="0"){
		rec.set("sovietRealPer", "--");
	}else{
		rec.set("sovietRealPer", Math.round((rec.get("sovietRealNum")/rec.get("sovietShouldNum"))*10000)/100);
	}
	if(rec.get("sovietRealNum")=="0"){
		rec.set("sovietAgreePer", "--");
		rec.set("sovietUnagreePer", "--");
		rec.set("sovietGiveupPer", "--");
		rec.set("sovietFemalePer", "--");
	}else{
		rec.set("sovietAgreePer",Math.round((rec.get("sovietAgreeNum")/rec.get("sovietRealNum"))*10000)/100);
		rec.set("sovietUnagreePer",Math.round((rec.get("sovietUnagreeNum")/rec.get("sovietRealNum"))*10000)/100);
		rec.set("sovietGiveupPer",Math.round((rec.get("sovietGiveupNum")/rec.get("sovietRealNum"))*10000)/100);
		rec.set("sovietFemalePer",Math.round((rec.get("sovietFemaleNum")/rec.get("sovietRealNum"))*10000)/100);
	}
	if(rec.get("refShouldNum")=="0"){
		rec.set("refRealPer", "--");
	}else{
		rec.set("refRealPer",Math.round((rec.get("refRealNum")/rec.get("refShouldNum"))*10000)/100);
	}
	if(rec.get("refRealNum")=="0"){
		rec.set("refAgreePer", "--");
		rec.set("refUnagreePer", "--");
		rec.set("refGiveupPer", "--");
	}else{
		rec.set("refAgreePer",Math.round((rec.get("refAgreeNum")/rec.get("refRealNum"))*10000)/100);
		rec.set("refUnagreePer",Math.round((rec.get("refUnagreeNum")/rec.get("refRealNum"))*10000)/100);
		rec.set("refGiveupPer",Math.round((rec.get("refGiveupNum")/rec.get("refRealNum"))*10000)/100);
	}
}
function save(){
	var decisionDataSet=L5.DatasetMgr.lookup("decisionDataSet");
	var record=decisionDataSet.getCurrent();
	if(record.get("reportDate")==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
	var infoDataSet=L5.DatasetMgr.lookup("infoDataSet");
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcDecisionReportCmd");
	command.setParameter("record",record);
	command.setParameter("cdcDecisionInfoRecord",infoDataSet.getAllRecords());
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			var url="jsp/ext/cdc/manage/decision/vcdcDecisionInfoList.jsp";
			L5.forward(url,'',null);
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function forcheck(item){
var offOtherMon=item.value;
if (offOtherMon > "") 
{ 
   var reg=/^\d+$/; 
   if ( (offOtherMon.match(reg)== null)) 
    { 
    L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
	    item.focus();
	    }); 
    item.value="";
   
    return ; 
    }
}
}
function returnBack(){
	L5.MessageBox.confirm("提示", "是否保存数据？",function(sta){
		if(sta=="yes"){
			save();
		}else{
			var url="jsp/ext/cdc/manage/decision/vcdcDecisionInfoList.jsp";
			L5.forward(url,'',null);
		}
	});
}
function cRender(val){
	if(val!=""){
		return val+" 次";
	}
}
function rRender(val){
	if(val!=""){
		return val+" 人";
	}
}
function hRender(val){
	if(val!=""){
		return val+" 户";
	}
}
function bRender(val){
	if(val!=""){
		return val+" %";
	}
}var isInsert=false;
function insertCm(){
	L5.getCmp("cmWin").show();
	var infoDataSet=L5.DatasetMgr.lookup("infoDataSet");
	infoDataSet.newRecord({"organCode":organCode,"meetingType":"1"});
	isInsert=true;
}
function insertCmdb(){
	L5.getCmp("cmdbWin").show();
	var infoDataSet=L5.DatasetMgr.lookup("infoDataSet");
	infoDataSet.newRecord({"organCode":organCode,"meetingType":"2"});
	isInsert=true;
}
function insertCwgj(){
	L5.getCmp("cwgjWin").show();
	var infoDataSet=L5.DatasetMgr.lookup("infoDataSet");
	infoDataSet.newRecord({"organCode":organCode,"meetingType":"3"});
	isInsert=true;
}
function closeCmWin(){
	if(isInsert){
		var infoDataSet=L5.DatasetMgr.lookup("infoDataSet");
		infoDataSet.remove(infoDataSet.getCurrent());
		L5.getCmp("cmWin").hide();
	}else{
		confirm();
	}
}
function closeCmdbWin(){
	if(isInsert){
		var infoDataSet=L5.DatasetMgr.lookup("infoDataSet");
		infoDataSet.remove(infoDataSet.getCurrent());
		L5.getCmp("cmdbWin").hide();
	}else{
		confirm();
	}
}
function closeCwgjWin(){
	if(isInsert){
		var infoDataSet=L5.DatasetMgr.lookup("infoDataSet");
		infoDataSet.remove(infoDataSet.getCurrent());
		L5.getCmp("cwgjWin").hide();
	}else{
		confirm();
	}
}
function confirm(){
	var infoDataSet=L5.DatasetMgr.lookup("infoDataSet");
	var record=infoDataSet.getCurrent();
	if(record.get("meetingType")=='1'){
		
		if(record.get("meetingContent")==''){
			L5.Msg.alert("提示","会议内容不能为空！");
			return false;
		}
		if(record.get("shouldNum")==''&&record.get("shouldNum")!=0){
			L5.Msg.alert("提示","应到村民（户代表）人数不能为空！");
			return false;
		}
		if(record.get("realNum")==''&&record.get("realNum")!=0){
			L5.Msg.alert("提示","实到村民（户代表）人数不能为空！");
			return false;
		}
		if(record.get("agreeNum")==''&&record.get("agreeNum")!=0){
			L5.Msg.alert("提示","同意人数不能为空！");
			return false;
		}
		if(record.get("unagreeNum")==''&&record.get("unagreeNum")!=0){
			L5.Msg.alert("提示","不同意人数不能为空！");
			return false;
		}
		if(record.get("giveupNum")==''&&record.get("giveupNum")!=0){
			L5.Msg.alert("提示","弃权人数不能为空！");
			return false;
		}
		if(record.get("realNum")<(record.get("agreeNum")+record.get("unagreeNum")+record.get("giveupNum"))){
			L5.Msg.alert("提示","实到村民（户代表）人数不能小于同意人数、不同意人数、弃权人数总和！");
			return false;
		}
	}
	if(record.get("meetingType")=='2'){
		if(record.get("meetingContent")==''){
			L5.Msg.alert("提示","会议内容不能为空！");
			return false;
		}
		if(record.get("shouldNum")==''&&record.get("shouldNum")!=0){
			L5.Msg.alert("提示","应到村民代表组成人员人数不能为空！");
			return false;
		}
		if(record.get("realNum")==''&&record.get("realNum")!=0){
			L5.Msg.alert("提示","实到村民代表组成人员人数不能为空！");
			return false;
		}
		if(record.get("femaleNum")==''&&record.get("femaleNum")!=0){
			L5.Msg.alert("提示","妇女参加人数不能为空！");
			return false;
		}
		if(record.get("realNum")<record.get("femaleNum")){
			L5.Msg.alert("提示","妇女参加人数不能大于实到人数！");
			return false;
		}
		if(record.get("agreeNum")==''&&record.get("agreeNum")!=0){
			alert(record.get("agreeNum"));
			L5.Msg.alert("提示","同意人数不能为空！");
			return false;
		}
		if(record.get("unagreeNum")==''&&record.get("unagreeNum")!=0){
			L5.Msg.alert("提示","不同意人数不能为空！");
			return false;
		}
		if(record.get("giveupNum")==''&&record.get("giveupNum")!=0){
			L5.Msg.alert("提示","弃权人数不能为空！");
			return false;
		}
		if(record.get("realNum")<(record.get("agreeNum")+record.get("unagreeNum")+record.get("giveupNum"))){
			L5.Msg.alert("提示","实到村民代表组成人员人数不能小于同意人数、不同意人数、弃权人数总和！");
			return false;
		}
	}
	if(record.get("meetingType")=='3'){
		if(record.get("meetingContent")==''){
			L5.Msg.alert("提示","公决的内容不能为空！");
			return false;
		}
		if(record.get("meetingDate")==''){
			L5.Msg.alert("提示","时间不能为空！");
			return false;
		}
		if(record.get("shouldNum")==''&&record.get("shouldNum")!=0){
			L5.Msg.alert("提示","实际户数不能为空！");
			return false;
		}
		if(record.get("realNum")==''&&record.get("realNum")!=0){
			L5.Msg.alert("提示","参加表决的户数不能为空！");
			return false;
		}
		if(record.get("agreeNum")==''&&record.get("agreeNum")!=0){
			L5.Msg.alert("提示","同意户数不能为空！");
			return false;
		}
		if(record.get("unagreeNum")==''&&record.get("unagreeNum")!=0){
			L5.Msg.alert("提示","不同意户数不能为空！");
			return false;
		}
		if(record.get("giveupNum")==''&&record.get("giveupNum")!=0){
			L5.Msg.alert("提示","弃权户数不能为空！");
			return false;
		}
		if(record.get("realNum")<(record.get("agreeNum")+record.get("unagreeNum")+record.get("giveupNum"))){
			L5.Msg.alert("提示","参加表决的户数不能小于同意户数、不同意户数、弃权户数总和！");
			return false;
		}
	}
	getData();
	if(record.get("meetingType")=='1'){
		L5.getCmp("cmWin").hide();
	}
	if(record.get("meetingType")=='2'){
		L5.getCmp("cmdbWin").hide();
	}
	if(record.get("meetingType")=='3'){
		L5.getCmp("cwgjWin").hide();
	}
}
function update(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("meetingType")=="1"){
		L5.getCmp("cmWin").show();
		isInsert=false;
	}
	if(records[0].get("meetingType")=="2"){
		L5.getCmp("cmdbWin").show();
		isInsert=false;
	}
	if(records[0].get("meetingType")=="3"){
		L5.getCmp("cwgjWin").show();
		isInsert=false;
	}
}
function del(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var infoDataSet=L5.DatasetMgr.lookup("infoDataSet");
	infoDataSet.remove(records[0]);
	getData();
}