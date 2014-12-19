function init(){
	if(fromPage=="apply"){
		document.getElementById("undoButtonId").style.display='none';
	}
	//家庭信息
	var esureyFamilyDS=L5.DatasetMgr.lookup("esureyFamilyDS");
	esureyFamilyDS.baseParams['FAMILY_ID@=']=familyId;	
	esureyFamilyDS.load();
	//家庭成员信息
	var esureyPeopleDS=L5.DatasetMgr.lookup("esureyPeopleDS");
	esureyPeopleDS.baseParams['FAMILY_ID@=']=familyId;
	esureyPeopleDS.load();
	//赡养人员
	var esureyPeopleDS2=L5.DatasetMgr.lookup("esureyPeopleDS2");
	esureyPeopleDS2.setParameter('familyId',familyId);
	esureyPeopleDS2.load();
	//加载核对汇总信息
	var SamEsureyFamilySumDS=L5.DatasetMgr.lookup("SamEsureyFamilySumDS");
	//SamEsureyFamilySumDS.purgeListeners();
	SamEsureyFamilySumDS.setParameter("family_Id",familyId);
	SamEsureyFamilySumDS.on('load',backSum);
	SamEsureyFamilySumDS.load();
}
function backSum(SamEsureyFamilySumDS){
		if(SamEsureyFamilySumDS.getCount()>0){
			var record=SamEsureyFamilySumDS.getCurrent();
			document.getElementById("extfamilyWorth").innerHTML=record.get("familyWorth");
			document.getElementById("extyearIncome").innerHTML=record.get("yearIncome");
			document.getElementById("extyearAverageIncome").innerHTML=record.get("yearAverageIncome");
			document.getElementById("extmonthIncome").innerHTML=record.get("monthIncome");
			document.getElementById("extmonthAverageIncome").innerHTML=record.get("monthAverageIncome");
			document.getElementById("extyearSupportMon").innerHTML=record.get("yearSupportMon");
			document.getElementById("extmonthSupportMon").innerHTML=record.get("monthSupportMonon");
			document.getElementById("creditRating").value=record.get("creditRating");
		}
	}
//返回
function return_list(){
	var url="jsp/cams/drel/esurey/internal/esureyInfoQueryList.jsp";
	L5.forward(url);
}
//成员
function detail_people(){
	var panel=L5.getCmp("jtcyGridPanel");
	var cell=panel.getSelectionModel().getSelections();
	if(cell.length<1){
		L5.Msg.alert("提示","请选择一条要查看的记录！");
		return;
	}
	var peopleId=cell[0].get("peopleId");
	var isSup="0";
	var data=new L5.Map();
	data.put("familyId",familyId);
	data.put("peopleId",peopleId);
	data.put("isSup",isSup);
	var text="";
	var url="jsp/cams/drel/esurey/internal/esureyInfoQueryPeople.jsp";
	L5.forward(url,text,data);
}
//赡养人员
function detail_supPeople(){
	var panel=L5.getCmp("jtcysfGridPanel");
	var cell=panel.getSelectionModel().getSelections();
	if(cell.length<1){
		L5.Msg.alert("提示","请选择一条要查看的记录！");
		return;
	}
	var peopleId=cell[0].get("PEOPLE_ID");
	var isSup=cell[0].get("IS_SUPPORT");
	var data=new L5.Map();
	data.put("familyId",familyId);
	data.put("peopleId",peopleId);
	data.put("isSup",isSup);
	var text="";
	var url="jsp/cams/drel/esurey/internal/esureyInfoQueryPeople.jsp";
	L5.forward(url,text,data);
}