var isInsert=false;
var orgName ;
function init(){
 	var partyDs=L5.DatasetMgr.lookup("partyDs");
	var peopleDs=L5.DatasetMgr.lookup("peopleDs");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	var OrgNameDataset=L5.DatasetMgr.lookup("OrgNameDataset");
	OrgNameDataset.on("load",function() {
		orgName= OrgNameDataset.get("text");
		partyDs.newRecord({"organCode":organ_Code,"organName":orgName,"parentCode":parentCode,
			"reportType":"N","recordId":recordId,"reportDate":reportTime,"communityNum":1});
			isInsert=true;
	});
	
	reportWorkDataSet.load();
	partyDs.on("load",function(){
		var nominate = partyDs.getCurrent();
		if(nominate==null){
			OrgNameDataset.setParameter("filterSql","USER_ID='"+organ_Code+"'");
			OrgNameDataset.load();
		}else{
			isInsert=false;
		}
	});
	partyDs.setParameter("RECORD_ID@=",recordId);
	partyDs.load();
	peopleDs.setParameter("RECORD_ID@=",recordId);
	peopleDs.setParameter("TYPE@=","D");
	peopleDs.load();
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
	var partyDs=L5.DatasetMgr.lookup("partyDs");
	var peopleDs=L5.DatasetMgr.lookup("peopleDs");
	var rec=partyDs.getCurrent();
	if(rec.get("partyNum")==""&&rec.get("partyNum")!=0){
		L5.Msg.alert("提示","本村中共党员人数不能为空!");
		return false;
	}
	if(rec.get("femaleNum")==""&&rec.get("femaleNum")!=0){
		L5.Msg.alert("提示","其中妇女党员人数不能为空!");
		return false;
	}
	if(rec.get("femaleNum")>rec.get("partyNum")){
		L5.Msg.alert("提示","妇女党员人数不能比党员人数多!");
		return false;
	}
	if(rec.get("folkNum")==""&&rec.get("folkNum")!=0){
		L5.Msg.alert("提示","其中少数民族党员人数不能为空!");
		return false;
	}
	if(rec.get("folkNum")>rec.get("partyNum")){
		L5.Msg.alert("提示","少数民族党员人数不能比党员人数多!");
		return false;
	}
	if(peopleDs.getCount()<1){
		L5.Msg.alert("提示","党组织成员个人情况不能为空!");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcElectionPartyCmd");
	command.setParameter("record",rec);
	command.setParameter("list",peopleDs.getAllRecords());
	if(isInsert){
		command.execute("insert");
	}else{
		command.execute("update");
	}
	if (!command.error){ 
		L5.Msg.alert("提示","保存成功！",function(){
			isInsert=false;
		});
		return true;
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
var isAdd=false;
function insert(){
	L5.getCmp("hxWin").show();
	var peopleDs=L5.DatasetMgr.lookup("peopleDs");
	peopleDs.newRecord({"type":"D"});
	isAdd=true;
}
function update(){
	L5.getCmp("hxWin").show();
	isAdd=false;
}
function del(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var peopleDs=L5.DatasetMgr.lookup("peopleDs");
	peopleDs.remove(records[0]);
}
function confirm(){
	var peopleDs=L5.DatasetMgr.lookup("peopleDs");
	var rec=peopleDs.getCurrent();
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
	if(rec.get("duty")==""){
		L5.Msg.alert("提示","是兼任村委会职务不能为空!");
		return;
	}
	if(rec.get("peopleSource")==""){
		L5.Msg.alert("提示","党组织成员来源不能为空!");
		return;
	}
	L5.getCmp("hxWin").hide();
}
function closeWin(){
	if(isAdd){
		var peopleDs=L5.DatasetMgr.lookup("peopleDs");
		peopleDs.remove(peopleDs.getCurrent());
	}
	L5.getCmp("hxWin").hide();
}
function firstChange(o){
	if(o.value=='1'){
		var peopleDs=L5.DatasetMgr.lookup("peopleDs");
		peopleDs.set('ifReduty','0');
	}
}
function redutyChange(o){
	if(o.value=='1'){
		var peopleDs=L5.DatasetMgr.lookup("peopleDs");
		peopleDs.set('ifFirst','0');
	}
}