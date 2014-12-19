function init(){
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganDataSet.load();
	var somLiqpeopleDataSet = L5.DatasetMgr.lookup("somLiqpeopleDataSet");
	somLiqpeopleDataSet.setParameter("SORG_ID@=",sorgId);
	somLiqpeopleDataSet.load();
}
function saveAll(){
//---------------------------------基本信息校验-----------------------------------------------
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	var validate = somOrganDataSet.isValidate(true);
	if(validate != true){
		L5.Msg.alert("提示","校验未通过："+validate);
		return;
	}
	if(L5.DatasetMgr.lookup("somLiqpeopleDataSet").getCount() < 1){
		L5.Msg.alert("提示","校验未通过："+"还未增加清算组织人员");
		L5.getCmp("tab").setActiveTab("1");
		return;
	}
//--------------------------------------------------------------------------------
	//提取基本信息
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomFundCmd");
	var organBean = somOrganDataSet.getCurrent().toBean("com.inspur.cams.sorg.base.data.SomOrgan");
	
	//提取清算组织人员信息
	var somLiqpeopleList = new L5.List();
	var somLiqpeopleDataSet = L5.DatasetMgr.lookup("somLiqpeopleDataSet");
	var records = somLiqpeopleDataSet.getAllChangedRecords();
	for(var i=0;i<records.length;i++){
		somLiqpeopleList.add(records[i].toBean("com.inspur.cams.sorg.base.data.SomLiqpeople"));
	}
	//提交保存
	command.setParameter("organBean",organBean);
	command.setParameter("somLiqpeopleList",somLiqpeopleList);
	command.execute("saveCancel");
	if(!command.error){
		var url="jsp/cams/sorg/manage/fund/somFundList.jsp";
		var text="基金会列表"
		L5.forward(url,text);
	}else{
		alert(command.error);
	}
}
function back(){
	var url = "jsp/cams/sorg/manage/fund/somFundList.jsp";
	var text = "基金会列表";
	L5.forward(url,text);
}
function addItem(){
	var grid = L5.getCmp("grid_1");
	grid.stopEditing();
	var winLiqpeopleDataSet = L5.DatasetMgr.lookup("winLiqpeopleDataSet");
	winLiqpeopleDataSet.removeAll();
	winLiqpeopleDataSet.newRecord();
	var win = L5.getCmp("win_1");
	win.show();
}
function delItem(){
	var grid = L5.getCmp("grid_1");
	var somLiqpeopleDataSet = L5.DatasetMgr.lookup("somLiqpeopleDataSet");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选中一行后删除!");
		return;
	}
	somLiqpeopleDataSet.remove(record);
}
function undoItem(){
	var somLiqpeopleDataSet = L5.DatasetMgr.lookup("somLiqpeopleDataSet");
	somLiqpeopleDataSet.rejectChanges();
}
function saveWin_1(){
//---------------------------------清算人员信息校验-----------------------------------------------
	var winLiqpeopleDataSet = L5.DatasetMgr.lookup("winLiqpeopleDataSet");
	var validate = winLiqpeopleDataSet.isValidate(true);
	if(validate != true){
		L5.Msg.alert("提示","校验未通过："+validate);
		return;
	}	
//---------------------------------------------------------------------------------------------
	var somLiqpeopleDataSet = L5.DatasetMgr.lookup("somLiqpeopleDataSet");
	var currentRecord = winLiqpeopleDataSet.getCurrent();
	somLiqpeopleDataSet.insert(somLiqpeopleDataSet.getCount(),currentRecord);
	var win = L5.getCmp("win_1");
	win.setVisible(false);
}
function closeWin_1(){
	var win = L5.getCmp("win_1");
	win.setVisible(false);
}
