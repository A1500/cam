var ifValid = "";
function init(){
	L5.getCmp("tab").setActiveTab("0");
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganDataSet.load();
	if(sorgStatus == "22"){
		ifValid = "2";
	}else if(sorgStatus == "52"){
		ifValid = "4";
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
}
function back(){
	var url = "jsp/cams/sorg/manage/group/somGroupList.jsp";
	var text = "社团主体列表";
	L5.forward(url,text);
}
function examine(){
	var grid = L5.getCmp("grid");
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