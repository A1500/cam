function init(){
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter("ORGAN_ID@=",userId);
	ds.load();
	var cityDs=L5.DatasetMgr.lookup("cityDs");
	cityDs.setParameter("ups",organId);
	cityDs.load(true);
}
function query(){
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter("ORGAN_ID@=",userId);
	ds.setParameter("USER_NAME@LIKE","%"+getParam("query_name")+"%");
	ds.load();
}
function queryUser(){
	var cityDs=L5.DatasetMgr.lookup("cityDs");
	cityDs.setParameter("ups",organId);
	cityDs.setParameter("queryName","%"+getParam("queryVillage")+"%");
	cityDs.load();
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function insert(){
	var villageWin = L5.getCmp("villageWin");
	villageWin.show();
}
function addAgain(){
	var selectedGrid=L5.getCmp("selectedGrid");
	var records=selectedGrid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var ds=L5.DatasetMgr.lookup("ds");
	for(var i=0;i<records.length;i++) {
		ds.newRecord({"userName":records[i].get("NAME"),"userId":records[i].get("ID"),"organId":userId,"communityBelongs":userId,"organName":userName,"organType":"SQ","areaCode":records[i].get("ID"),"areaName":records[i].get("NAME"),"ifVillage":"1","communityType":"N"});
		//ds.add([records[i]]);
	}
}
function closeWin(){
	var villageWin = L5.getCmp("villageWin");
	villageWin.hide();
	var cityDs=L5.DatasetMgr.lookup("cityDs");
	cityDs.setParameter("ups",organId);
	cityDs.load();
}
function save (){
	var ds=L5.DatasetMgr.lookup("ds");
	var isValidate = ds.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var records = ds.getAllChangedRecords();
	var command=new L5.Command("com.inspur.cams.comm.extuser.cmd.ComExtUserCmd");
	command.setParameter("records",records);
	command.execute("saveUser");
	if (!command.error){
		L5.Msg.alert("提示","保存成功！");
		init();
	}else{
		L5.Msg.alert("提示","保存出错！"+command.error);
	}
}
function del(){
	var ds=L5.DatasetMgr.lookup("ds");
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var delIds = [];
	for(var i=0;i<records.length;i++){
		delIds[i] = records[i].get("userId");
	}
	L5.MessageBox.confirm("提示", "确定移除？",function(sta){
		if(sta=="yes"){
			var command = new L5.Command("com.inspur.cams.comm.extuser.cmd.ComExtUserCmd");
			command.setParameter("delIds", delIds);
			command.execute("deleteSelected");
			if (!command.error) {
				L5.Msg.alert('提示','删除成功');
				init();
			}else{
				L5.Msg.alert(command.error);
			}
		}else return;
	});
}