var ifValid = "";
function init(){
	L5.getCmp("tab").setActiveTab("0");
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganDataSet.load();
	if(sorgStatus == "32"){
		ifValid = "3";
	}else if(sorgStatus == "62"){
		ifValid = "5";
	}
	var somDeputyPeopleDataSet = L5.DatasetMgr.lookup("somDeputyPeopleDataSet");
	somDeputyPeopleDataSet.setParameter("SORG_ID@=",sorgId);
	somDeputyPeopleDataSet.setParameter("PEOPLE_TYPE@=", "L");
	somDeputyPeopleDataSet.setParameter("IF_VALID@=", ifValid);
	somDeputyPeopleDataSet.load();
	somDeputyPeopleDataSet.on("load",function(ds){
		var idCard = ds.get("idCard");
		//回填年龄
		$("age").innerHTML = getAgeByCode(idCard);
	});
	var somPresidePeopleDataSet = L5.DatasetMgr.lookup("somPresidePeopleDataSet");
	somPresidePeopleDataSet.setParameter("SORG_ID@=",sorgId);
	somPresidePeopleDataSet.setParameter("PEOPLE_TYPE@=", "C");
	somPresidePeopleDataSet.setParameter("IF_VALID@=", ifValid);
	somPresidePeopleDataSet.load();
	var somLiqpeopleDataSet = L5.DatasetMgr.lookup("somLiqpeopleDataSet");
	somLiqpeopleDataSet.setParameter("SORG_ID@=",sorgId);
	somLiqpeopleDataSet.load();
}
function back(){
	var url = "jsp/cams/sorg/manage/group/somGroupList.jsp";
	var text = "社团主体列表";
	L5.forward(url,text);
}
function examineWin(){
	var grid = L5.getCmp("propleGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var winPresidePeopleDataSet = L5.DatasetMgr.lookup("winPresidePeopleDataSet");
	winPresidePeopleDataSet.setParameter("SORG_ID@=",sorgId);
	winPresidePeopleDataSet.setParameter("PEOPLE_ID@=",record.get("peopleId"));
	winPresidePeopleDataSet.setParameter("PEOPLE_TYPE@=", "C");
	winPresidePeopleDataSet.setParameter("IF_VALID@=", ifValid);
	winPresidePeopleDataSet.load();
	var win = L5.getCmp("win");
	win.show();
}
function closeWin(){
	var win = L5.getCmp("win");
	win.setVisible(false);
}
function examine(){
	var grid = L5.getCmp("grid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var winLiqpeopleDataSet = L5.DatasetMgr.lookup("winLiqpeopleDataSet");
	winLiqpeopleDataSet.setParameter("SORG_ID@=",sorgId);
	winLiqpeopleDataSet.setParameter("ID@=",record.get("id"));
	winLiqpeopleDataSet.load();
	var win = L5.getCmp("win2");
	win.show();
}
function close(){
	var win = L5.getCmp("win2");
	win.setVisible(false);
}
