function init() {
    var YgjzJtxxCyxxDataSet = L5.DatasetMgr.lookup("YgjzJtxxCyxxDataSet");
    var YgjzJtxxDataSet = L5.DatasetMgr.lookup("YgjzJtxxDataSet");
    var assistanceTypeDS = L5.DatasetMgr.lookup("assistanceTypeDS");
    var DmXzqhDataSetStreet = L5.DatasetMgr.lookup("DmXzqhDataSetStreet");
    if(photoId!=""){itemLoad();}
    DmXzqhDataSetStreet.setParameter("filterSql", "xzqhjb='3' and substr(xzqhdm,1,6)=370112");
    DmXzqhDataSetStreet.load();

    L5.QuickTips.init();
    if (method == null || method == "") {
        L5.Msg.alert('提示', "未知的页面命令!");
        back();
    }  else if (method == "EXAM") {
        YgjzJtxxDataSet.baseParams["FAMILY_ID@="] = idField;
        YgjzJtxxDataSet.load();
        //自然灾害加载
        SamFamilyCalamityDataSet.baseParams["FAMILY_ID@="] = idField;
        SamFamilyCalamityDataSet.load();
        //救助加载
		assistanceTypeDS.setParameter("FAMILY_ID@=",idField);
		assistanceTypeDS.load();
		assistanceTypeDS.on("load",queryAssistance);

    }
        YgjzJtxxCyxxDataSet.baseParams["FAMILY_ID@="] = idField;
        YgjzJtxxCyxxDataSet.load();

  }
  //---------------------------显示照片-----------
function itemLoad(){
	var paths = document.location.pathname.split("/");
	L5.fly('photoImg').dom.src = paths[0] + '/' + paths[1]+ "/download?table=com_photo_"+photoId.substring(0,6)+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+ photoId + "'";
}
  //根据选择的街道过滤村居
function setXzqhVillage() {
    var DmXzqhDataSetVillage = L5.DatasetMgr.lookup("DmXzqhDataSetVillage");
    var street=document.getElementById("town").value;
    if (street.length > 9) {
        DmXzqhDataSetVillage.setParameter("filterSql", "xzqhjb='4' and substr(xzqhdm,1,9)= '" + street.substring(0, 9) + "'");
        DmXzqhDataSetVillage.load();
    }
}
function queryAssistance(assistanceTypeDS){
	var records=assistanceTypeDS.getAllRecords();
	var n=records.length;
	if(records.length==0){return}
	for(i=0;i<n;i++){
		var assistanceType=records[i].get("assistanceType");
		if(assistanceType=="01"){
			$("cityMi").checked=true;
			$("isDetail").style.display="block";
			$("isCity").style.display="block";
			$("cardNo").innerHTML=records[i].get("cardNo");
			$("signOrgName").innerHTML=records[i].get("signOrgName");
			$("signDate").innerHTML=records[i].get("signDate");
			$("cardValidateBegin").innerHTML=records[i].get("cardValidateBegin");
			$("cardValidateEnd").innerHTML=records[i].get("cardValidateEnd");
			$("assistanceBegin").innerHTML=records[i].get("assistanceBegin");
			$("bank").value=records[i].get("bank");
			$("accountName").innerHTML=records[i].get("accountName");
			$("accountCode").innerHTML=records[i].get("accountCode");
			$("assistanceMon").innerHTML=records[i].get("assistanceMon");
			$("assistanceClassMon").innerHTML=records[i].get("assistanceClassMon");
		}
		if(assistanceType=="02"){
			$("countryMi").checked=true;
			$("isDetail").style.display="block";
			$("isCountry").style.display="block";
			$("cardNo").innerHTML=records[i].get("cardNo");
			$("signOrgName").innerHTML=records[i].get("signOrgName");
			$("signDate").innerHTML=records[i].get("signDate");
			$("cardValidateBegin").innerHTML=records[i].get("cardValidateBegin");
			$("cardValidateEnd").innerHTML=records[i].get("cardValidateEnd");
			$("assistanceBegin").innerHTML=records[i].get("assistanceBegin");
			$("bank").value=records[i].get("bank");
			$("accountName").innerHTML=records[i].get("accountName");
			$("accountCode").innerHTML=records[i].get("accountCode");
			$("nassistanceMon").innerHTML=records[i].get("assistanceMon");
			$("nassistanceClassMon").innerHTML=records[i].get("assistanceClassMon");
		}
		if(assistanceType=="03"){
			$("fiveMi").checked=true;
			$("isDetail").style.display="block";
			$("isFive").style.display="block";
			$("cardNo").innerHTML=records[i].get("cardNo");
			$("signOrgName").innerHTML=records[i].get("signOrgName");
			$("signDate").innerHTML=records[i].get("signDate");
			$("cardValidateBegin").innerHTML=records[i].get("cardValidateBegin");
			$("cardValidateEnd").innerHTML=records[i].get("cardValidateEnd");
			$("assistanceBegin").innerHTML=records[i].get("assistanceBegin");
			$("bank").value=records[i].get("bank");
			$("accountName").innerHTML=records[i].get("accountName");
			$("accountCode").innerHTML=records[i].get("accountCode");
			$("supportWay").value=records[i].get("supportWay");
			$("cassistanceMon").innerHTML=records[i].get("assistanceMon");

		}
		if(assistanceType=="05"){
			$("giveMi").checked=true;
		}
		if(assistanceType=="06"){
			$("handicapped").checked=true;
		}
		if(assistanceType=="07"){
			$("pmother").checked=true;
		}
		if(assistanceType=="08"){
			$("kstudent").checked=true;
		}
		if(assistanceType=="09"){
			$("threeNothing").checked=true;
		}
		if(assistanceType=="10"){
			$("temployee").checked=true;
		}
		if(assistanceType=="11"){
			$("other").checked=true;
		}
	}
}
function selectStructure(){
	var DmFwjgDataSet = L5.DatasetMgr.lookup("DmFwjgDataSet");
	var zfzklxdm=document.getElementById("houseStatus").value;
	if(zfzklxdm==""){
		document.getElementById("fwzk").innerHTML="房屋结构：";
	}
	if(zfzklxdm=="1"){
		document.getElementById("fwzk").innerHTML="房屋结构：";
		DmFwjgDataSet.setParameter("filterSql", "fwjgdm between 1 and 5");
		DmFwjgDataSet.load();
	}
	if(zfzklxdm=="2"){
		document.getElementById("fwzk").innerHTML="危险程度：";
		DmFwjgDataSet.setParameter("filterSql", "fwjgdm='6' or fwjgdm='7'");
		DmFwjgDataSet.load();

	}
	if(zfzklxdm=="3"){
		document.getElementById("fwzk").innerHTML="居住状况：";
		DmFwjgDataSet.setParameter("filterSql", "fwjgdm='8' or fwjgdm='9'");
		DmFwjgDataSet.load();
	}

}

//家庭成员明细
var win;
function jtxxCyxxDetail() {
    var editGrid=L5.getCmp('YgjzJtxxCyxxEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条要查看的记录!");
		return false;
	}
	var peopleId =selected[0].get("peopleId");
	var YgjzJtxxCyxxDataSet2 = L5.DatasetMgr.lookup("YgjzJtxxCyxxDataSet2");
	YgjzJtxxCyxxDataSet2.baseParams["PEOPLE_ID@="] = peopleId;
    YgjzJtxxCyxxDataSet2.load();
    //残疾
    SamPeopleDisabilityDataSet.baseParams["PEOPLE_ID@="] = peopleId;
    SamPeopleDisabilityDataSet.load();
    //教育
    SamPeopleEduDataSet.baseParams["PEOPLE_ID@="] = peopleId;
    SamPeopleEduDataSet.load();
    //患病
    SamPeopleDiseaseDataSet.baseParams["PEOPLE_ID@="] = peopleId;
    SamPeopleDiseaseDataSet.load();
    //事故
    SamPeopleAccidentDataSet.baseParams["PEOPLE_ID@="] = peopleId;
    SamPeopleAccidentDataSet.load();

    var photoc=selected[0].get("photoId");

    if(win==undefined){
  	  win=L5.getCmp("people_win");
    }

	win.show(this);
	if(photoc!=""){
	var paths = document.location.pathname.split("/");
	L5.fly('photoPeople').dom.src = paths[0] + '/' + paths[1]+ "/download?table=com_photo_"+photoId.substring(0,6)+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+ photoc + "'";
	}

}

// 关闭窗口
function hide() {
	var win=L5.getCmp("people_win");
	win.hide(this);
}
//------------------------------------------------救助类型信息----------------------------------
//城市低保
function setCityMi(src){
	if(src.checked){
		src.value = '01';
		$("countryMi").checked=false;
		$("fiveMi").checked=false;
		$("isDetail").style.display="none";
		$("isCity").style.display="none";
		$("isCountry").style.display="none";
		$("isFive").style.display="none";

		$("isDetail").style.display="block";
		$("isCity").style.display="block";
	}else{
		src.value = '';
		$("isDetail").style.display="none";
		$("isCity").style.display="none";
	}
}

//农村低保
function setCountryMi(src){
	if(src.checked){
		src.value = '02';
		$("cityMi").checked=false;
		$("fiveMi").checked=false;
		$("isDetail").style.display="none";
		$("isCity").style.display="none";
		$("isCountry").style.display="none";
		$("isFive").style.display="none";

		$("isDetail").style.display="block";
		$("isCountry").style.display="block";
	}else{
		src.value = '';
		$("isDetail").style.display="none";
		$("isCountry").style.display="none";
	}
}
//农村五保
function setFiveMi(src){
	if(src.checked){
		src.value = '03';
		$("cityMi").checked=false;
		$("countryMi").checked=false;
		$("isDetail").style.display="none";
		$("isCity").style.display="none";
		$("isCountry").style.display="none";
		$("isFive").style.display="none";

		$("isDetail").style.display="block";
		$("isFive").style.display="block";
	}else{
		src.value = '';
		$("isDetail").style.display="none";
		$("isFive").style.display="none";
	}
}
//优抚
function setGiveMi(src){
	if(src.checked){
		src.value = '05';
	}else{
		src.value = '';
	}
}
//残疾人
function setHandicapped(src){
	if(src.checked){
		src.value = '06';
	}else{
		src.value = '';
	}
}
//单亲特困母亲
function setPmother(src){
	if(src.checked){
		src.value = '07';
	}else{
		src.value = '';
	}
}
//困难学生
function setKstudent(src){
	if(src.checked){
		src.value = '08';
	}else{
		src.value = '';
	}
}
//“三无”对象
function setThreeNothing(src){
	if(src.checked){
		src.value = '09';
	}else{
		src.value = '';
	}
}
//特困职工
function setTemployee(src){
	if(src.checked){
		src.value = '10';
	}else{
		src.value = '';
	}
}
//其他
function setOther(src){
	if(src.checked){
		src.value = '11';
	}else{
		src.value = '';
	}
}

