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
		//回填年龄
		if(ds.get("cardType") == "01"){
			$("age").innerHTML = getAgeByCode(ds.get("idCard"));
		}else{
			$("age").innerHTML = getAgeByBirthday(ds.get("birthday"));
		}
	});
	var somPresidePeopleDataSet = L5.DatasetMgr.lookup("somPresidePeopleDataSet");
	somPresidePeopleDataSet.setParameter("SORG_ID@=",sorgId);
	somPresidePeopleDataSet.setParameter("PEOPLE_TYPE@=","C");
	somPresidePeopleDataSet.setParameter("IF_VALID@=", ifValid);
	somPresidePeopleDataSet.load();
}

function back(){
	var url = "jsp/cams/sorg/manage/fund/somFundList.jsp";
	var text = "基金会列表";
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
	winPresidePeopleDataSet.setParameter("PEOPLE_TYPE@=", record.get("peopleType"));
	winPresidePeopleDataSet.setParameter("IF_VALID@=", ifValid);
	winPresidePeopleDataSet.load();
	var win = L5.getCmp("win");
	win.show();
}
function closeWin(){
	var win = L5.getCmp("win");
	win.setVisible(false);
}