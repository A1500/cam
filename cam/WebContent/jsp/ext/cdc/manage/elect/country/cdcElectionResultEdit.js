var isInsert=false;
var orgName ;
function init(){
	var imageButton2 = document.getElementById("imageButton2");
	collapse(imageButton2);
	var imageButton1 = document.getElementById("imageButton1");
	collapse(imageButton1);
 	var resultDs=L5.DatasetMgr.lookup("resultDs");
	var peopleMDs=L5.DatasetMgr.lookup("peopleMDs");
	var peopleODs=L5.DatasetMgr.lookup("peopleODs");
	var peopleSDs=L5.DatasetMgr.lookup("peopleSDs");
	var peopleODs=L5.DatasetMgr.lookup("peopleODs");
	var peopleFDs=L5.DatasetMgr.lookup("peopleFDs");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	var OrgNameDataset=L5.DatasetMgr.lookup("OrgNameDataset");
	OrgNameDataset.on("load",function() {
		orgName  = OrgNameDataset.get("text");
		resultDs.newRecord({"organCode":organ_Code,"organName":orgName,"parentCode":parentCode,
			"reportType":"N","recordId":recordId,"reportDate":reportTime,"communityNum":1});
			isInsert=true;
	});
	
	reportWorkDataSet.load();
	resultDs.on("load",function(){
		var nominate = resultDs.getCurrent();
		if(nominate==null){
			OrgNameDataset.setParameter("filterSql","USER_ID='"+organ_Code+"'");
			OrgNameDataset.load();
		}else{
			getSovietManner();
			getPer();
			isInsert=false;
		}
	});
	
	resultDs.setParameter("RECORD_ID@=",recordId);
	resultDs.load();
	peopleMDs.setParameter("RECORD_ID@=",recordId);
	peopleMDs.setParameter("TYPE@=","M");
	peopleMDs.load();
	peopleODs.setParameter("RECORD_ID@=",recordId);
	peopleODs.setParameter("TYPE@=","O");
	peopleODs.load();
	peopleSDs.setParameter("RECORD_ID@=",recordId);
	peopleSDs.setParameter("TYPE@=","S");
	peopleSDs.load();
	peopleFDs.setParameter("RECORD_ID@=",recordId);
	peopleFDs.setParameter("TYPE@=","F");
	peopleFDs.load();
}
/*
window.onbeforeunload = function(){
		if(save()==false){
			return "保存出错,离开本页将不能保存数据";
		}
}
window.onunload = function(){
		window.onbeforeunload =function(){};
}*/
function save(){
	var resultDs=L5.DatasetMgr.lookup("resultDs");
	var peopleMDs=L5.DatasetMgr.lookup("peopleMDs");//村委会成员
	var peopleODs=L5.DatasetMgr.lookup("peopleODs");//另行选举
	var peopleSDs=L5.DatasetMgr.lookup("peopleSDs");//下属委员会
	var peopleFDs=L5.DatasetMgr.lookup("peopleFDs");//财会人员
	var rec=resultDs.getCurrent();
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcElectionResultCmd");
	command.setParameter("record",rec);
	command.setParameter("list",peopleMDs.getAllRecords());//村委会成员
	command.setParameter("list2",peopleODs.getAllRecords());//另行选举
	command.setParameter("list3",peopleSDs.getAllRecords());//下属委员会
	command.setParameter("list4",peopleFDs.getAllRecords());//财会人员
	if(isInsert){
		command.execute("insert");
	}else{
		command.execute("update");
	}
	if (!command.error){ 
		L5.Msg.alert("提示","保存成功！",function(){
			isInsert=false;
			peopleMDs.reload();
			peopleODs.reload();
			peopleSDs.reload();
			peopleFDs.reload();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
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

//村委会
var isMAdd=false;
function insertM(){
	L5.getCmp("mWin").show();
	var peopleMDs=L5.DatasetMgr.lookup("peopleMDs");
	peopleMDs.newRecord({"type":"M"});
	isMAdd=true;
}
function updateM(){
	L5.getCmp("mWin").show();
	isMAdd=false;
}
function delM(){
	var grid=L5.getCmp("gridM");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var peopleMDs=L5.DatasetMgr.lookup("peopleMDs");
	peopleMDs.remove(records[0]);
}
function confirmM(){
	var peopleMDs=L5.DatasetMgr.lookup("peopleMDs");
	var rec=peopleMDs.getCurrent();
	if(rec.get("name")==""){
		L5.Msg.alert("提示","姓名不能为空!");
		return;
	}
	if(rec.get("sex")==""){
		L5.Msg.alert("提示","性别不能为空!");
		return;
	}
	if(rec.get("age")==""){
		L5.Msg.alert("提示","年龄不能为空!");
		return;
	}
	if(rec.get("folk")==""){
		L5.Msg.alert("提示","民族不能为空!");
		return;
	}
	if(rec.get("political")==""){
		L5.Msg.alert("提示","政治面貌不能为空!");
		return;
	}
	if(rec.get("education")==""){
		L5.Msg.alert("提示","文化程度不能为空!");
		return;
	}
	if(rec.get("duty")==""){
		L5.Msg.alert("提示","当选职务不能为空!");
		return;
	}
	if(rec.get("dutyVoteNum")==""){
		L5.Msg.alert("提示","当选职务票数为空或为0,请修改!",function(){
			document.getElementById("mdutyVoteNum").focus();
		});
		return;
	}
	if(rec.get("voteNum")==""){
		L5.Msg.alert("提示","总票数为空或为0,请修改!",function(){
			document.getElementById("mvoteNum").focus();
		});
		return;
	}
	if(rec.get("ifFirst")==""){
		L5.Msg.alert("提示","是否初次当选不能为空!");
		return;
	}
	if(rec.get("ifReduty")==""){
		L5.Msg.alert("提示","是否连选连任不能为空!");
		return;
	}
	L5.getCmp("mWin").hide();
}
function closeWinM(){
	if(isMAdd){
		var peopleMDs=L5.DatasetMgr.lookup("peopleMDs");
		peopleMDs.remove(peopleMDs.getCurrent());
	}
	L5.getCmp("mWin").hide();
}
function firstChangeM(o){
	if(o.value=='1'){
		var peopleMDs=L5.DatasetMgr.lookup("peopleMDs");
		peopleMDs.set('ifReduty','0');
	}
}
function redutyChangeM(o){
	if(o.value=='1'){
		var peopleMDs=L5.DatasetMgr.lookup("peopleMDs");
		peopleMDs.set('ifFirst','0');
	}
}
//另行选举
var isOAdd=false;
function insertO(){
	L5.getCmp("oWin").show();
	var peopleODs=L5.DatasetMgr.lookup("peopleODs");
	peopleODs.newRecord({"type":"O"});
	isOAdd=true;
}
function updateO(){
	L5.getCmp("oWin").show();
	isOAdd=false;
}
function delO(){
	var grid=L5.getCmp("gridO");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var peopleODs=L5.DatasetMgr.lookup("peopleODs");
	peopleODs.remove(records[0]);
}
function confirmO(){
	var peopleODs=L5.DatasetMgr.lookup("peopleODs");
	var rec=peopleODs.getCurrent();
	if(rec.get("name")==""){
		L5.Msg.alert("提示","姓名不能为空!");
		return;
	}
	if(rec.get("sex")==""){
		L5.Msg.alert("提示","性别不能为空!");
		return;
	}
	if(rec.get("age")==""){
		L5.Msg.alert("提示","年龄不能为空!");
		return;
	}
	if(rec.get("folk")==""){
		L5.Msg.alert("提示","民族不能为空!");
		return;
	}
	if(rec.get("political")==""){
		L5.Msg.alert("提示","政治面貌不能为空!");
		return;
	}
	if(rec.get("education")==""){
		L5.Msg.alert("提示","文化程度不能为空!");
		return;
	}
	if(rec.get("duty")==""){
		L5.Msg.alert("提示","当选职务不能为空!");
		return;
	}
	if(rec.get("dutyVoteNum")==""){
		L5.Msg.alert("提示","当选职务票数为空或为0,请修改!",function(){
			document.getElementById("odutyVoteNum").focus();
		});
		return;
	}
	if(rec.get("voteNum")==""){
		L5.Msg.alert("提示","总票数为空或为0,请修改!",function(){
			document.getElementById("ovoteNum").focus();
		});
		return;
	}
	if(rec.get("ifFirst")==""){
		L5.Msg.alert("提示","是否初次当选不能为空!");
		return;
	}
	if(rec.get("ifReduty")==""){
		L5.Msg.alert("提示","是否连选连任不能为空!");
		return;
	}
	L5.getCmp("oWin").hide();
}
function closeWinO(){
	if(isOAdd){
		var peopleODs=L5.DatasetMgr.lookup("peopleODs");
		peopleODs.remove(peopleODs.getCurrent());
	}
	L5.getCmp("oWin").hide();
}
function firstChangeO(o){
	if(o.value=='1'){
		var peopleODs=L5.DatasetMgr.lookup("peopleODs");
		peopleODs.set('ifReduty','0');
	}
}
function redutyChangeO(o){
	if(o.value=='1'){
		var peopleODs=L5.DatasetMgr.lookup("peopleODs");
		peopleODs.set('ifFirst','0');
	}
}
//下属委员会
var isSAdd=false;
function insertS(){
	L5.getCmp("sWin").show();
	var peopleSDs=L5.DatasetMgr.lookup("peopleSDs");
	peopleSDs.newRecord({"type":"S"});
	isSAdd=true;
}
function updateS(){
	L5.getCmp("sWin").show();
	isSAdd=false;
}
function delS(){
	var grid=L5.getCmp("gridS");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var peopleSDs=L5.DatasetMgr.lookup("peopleSDs");
	peopleSDs.remove(records[0]);
}
function confirmS(){
	var peopleSDs=L5.DatasetMgr.lookup("peopleSDs");
	var rec=peopleSDs.getCurrent();
	if(rec.get("name")==""){
		L5.Msg.alert("提示","姓名不能为空!");
		return;
	}
	if(rec.get("sex")==""){
		L5.Msg.alert("提示","性别不能为空!");
		return;
	}
	if(rec.get("age")==""){
		L5.Msg.alert("提示","年龄不能为空!");
		return;
	}
	if(rec.get("folk")==""){
		L5.Msg.alert("提示","民族不能为空!");
		return;
	}
	if(rec.get("political")==""){
		L5.Msg.alert("提示","政治面貌不能为空!");
		return;
	}
	if(rec.get("education")==""){
		L5.Msg.alert("提示","文化程度不能为空!");
		return;
	}
	if(rec.get("ifFirst")==""){
		L5.Msg.alert("提示","是否初次当选不能为空!");
		return;
	}
	if(rec.get("ifReduty")==""){
		L5.Msg.alert("提示","是否连选连任不能为空!");
		return;
	}
	L5.getCmp("sWin").hide();
}
function closeWinS(){
	if(isSAdd){
		var peopleSDs=L5.DatasetMgr.lookup("peopleSDs");
		peopleSDs.remove(peopleSDs.getCurrent());
	}
	L5.getCmp("sWin").hide();
}
function firstChangeS(o){
	if(o.value=='1'){
		var peopleSDs=L5.DatasetMgr.lookup("peopleSDs");
		peopleSDs.set('ifReduty','0');
	}
}
function redutyChangeS(o){
	if(o.value=='1'){
		var peopleSDs=L5.DatasetMgr.lookup("peopleSDs");
		peopleSDs.set('ifFirst','0');
	}
}
//财务人员
var isFAdd=false;
function insertF(){
	L5.getCmp("fWin").show();
	var peopleFDs=L5.DatasetMgr.lookup("peopleFDs");
	peopleFDs.newRecord({"type":"F"});
	isFAdd=true;
}
function updateF(){
	L5.getCmp("fWin").show();
	isFAdd=false;
}
function delF(){
	var grid=L5.getCmp("gridF");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var peopleFDs=L5.DatasetMgr.lookup("peopleFDs");
	peopleFDs.remove(records[0]);
}
function confirmF(){
	var peopleFDs=L5.DatasetMgr.lookup("peopleFDs");
	var rec=peopleFDs.getCurrent();
	if(rec.get("name")==""){
		L5.Msg.alert("提示","姓名不能为空!");
		return;
	}
	if(rec.get("sex")==""){
		L5.Msg.alert("提示","性别不能为空!");
		return;
	}
	if(rec.get("age")==""){
		L5.Msg.alert("提示","年龄不能为空!");
		return;
	}
	if(rec.get("folk")==""){
		L5.Msg.alert("提示","民族不能为空!");
		return;
	}
	if(rec.get("political")==""){
		L5.Msg.alert("提示","政治面貌不能为空!");
		return;
	}
	if(rec.get("education")==""){
		L5.Msg.alert("提示","文化程度不能为空!");
		return;
	}
	if(rec.get("ifCert")==""){
		L5.Msg.alert("提示","是否有从业资格证书为空!");
		return;
	}
	L5.getCmp("fWin").hide();
}
function closeWinF(){
	if(isFAdd){
		var peopleFDs=L5.DatasetMgr.lookup("peopleFDs");
		peopleFDs.remove(peopleFDs.getCurrent());
	}
	L5.getCmp("fWin").hide();
}
function getSovietManner(){
	if(_$("sovietManner")=='1'){
		$("sovietManner1").style.display="";
	}else if(_$("sovietManner")=='2'){
		$("sovietManner1").style.display="none";
	}else{
		$("sovietManner1").style.display="none";
	}
}
function getPer(){
	var resultDs=L5.DatasetMgr.lookup("resultDs");
	var rec=resultDs.getCurrent();
	if(_$("sovietNum")=="0"||_$("sovietNum")==""){
		rec.set("sovietFemalePer", "--");
		rec.set("sovietPartyPer", "--");
		rec.set("sovietFolkPer", "--");
	}else{
		rec.set("sovietFemalePer", Math.round((_$("sovietFemaleNum")/_$("sovietNum"))*10000)/100);
		rec.set("sovietPartyPer", Math.round((_$("sovietPartyNum")/_$("sovietNum"))*10000)/100);
		rec.set("sovietFolkPer", Math.round((_$("sovietFolkNum")/_$("sovietNum"))*10000)/100);
	}
	if(_$("groupVoterNum")=="0"||_$("groupVoterNum")==""){
		rec.set("groupFemalePer", "--");
		rec.set("groupPartyPer", "--");
		rec.set("groupFolkPer", "--");
	}else{
		rec.set("groupFemalePer", Math.round((_$("groupFemaleNum")/_$("groupVoterNum"))*10000)/100);
		rec.set("groupPartyPer", Math.round((_$("groupPartyNum")/_$("groupVoterNum"))*10000)/100);
		rec.set("groupFolkPer", Math.round((_$("groupFolkNum")/_$("groupVoterNum"))*10000)/100);
	}
}
function pRender(val){
	if(val!=""){
		return val+" %";
	}
}