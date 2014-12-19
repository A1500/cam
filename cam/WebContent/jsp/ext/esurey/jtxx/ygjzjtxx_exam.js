function init() {
	var YgjzCyxxCjxxDataSet=L5.DatasetMgr.lookup("YgjzCyxxCjxxDataSet");
	var assistanceTypeDS = L5.DatasetMgr.lookup("assistanceTypeDS");
	if(YgjzCyxxCjxxDataSet.getCount()==0){
		YgjzCyxxCjxxDataSet.newRecord();
	}
	//救助加载
	assistanceTypeDS.setParameter("FAMILY_ID@=",idField);
	assistanceTypeDS.load();
	assistanceTypeDS.on("load",queryAssistance);			
	//L5.QuickTips.init();
	var grid=L5.getCmp('YgjzJtxxCyxxGridPanel');
	grid.on("rowdblclick",griddbclick);
	YgjzJtxxCyxxDataSet.load();
}
function saveClick(){
	var YgjzJtxxDataSet = L5.DatasetMgr.lookup("YgjzJtxxDataSet");
	var YgjzJtxxRecord=YgjzJtxxDataSet.getCurrent();
	var isValidate = YgjzJtxxDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	var command = new L5.Command("org.sdmz.ygjzjtxx.cmd.YgjzJtxxCommand");
	command.setParameter("YgjzJtxxRecord", YgjzJtxxRecord);
	command.execute("save");
	if (!command.error) {
	
		YgjzJtxxDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
		var url='jsp/ext/esurey/ygjzjtxx/ygjzjtxx_list.jsp';
		var text="用户表";
		L5.forward(url,text);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
 function Evt_butreturn_onclick(){ 
	 var url='jsp/ext/esurey/ygjzjtxx/ygjzjtxx_list.jsp';
	 var text = '家庭信息';
	 L5.forward(url,text);
 }
 
 

var isRender=false;
function griddbclick(grid,index,e){
	YgjzCyxxCjxxDataSet.baseParams["PEOPLE_ID@="] = YgjzJtxxCyxxDataSet.get("peopleId");
	YgjzCyxxCjxxDataSet.load();		
	var win=L5.getCmp('cyxxEdit');
	win.show();
	if(!isRender){
		isRender=true;
		var formed = new L5.databind.Form(document.getElementById("test1"));
		formed.setValue(YgjzJtxxCyxxDataSet);	
		
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
		}else if(assistanceType=="02"){
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
		}else if(assistanceType=="03"){
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

		}else if(assistanceType=="25"){
			$("CityStu").checked=true;
		}else if(assistanceType=="05"){
			$("giveMi").checked=true;
		}else if(assistanceType=="06"){
			$("handicapped").checked=true;
		}else if(assistanceType=="07"){
			$("pmother").checked=true;
		}else if(assistanceType=="08"){
			$("kstudent").checked=true;
		}else if(assistanceType=="09"){
			$("threeNothing").checked=true;
		}else if(assistanceType=="10"){
			$("temployee").checked=true;
		}else if(assistanceType=="11"){
			$("elsehelp").checked=true;
		}else if(assistanceType=="12"){
			$("other").value="12";
		}else if(assistanceType=="13"){
			$("other").value="13";
		}else if(assistanceType=="14"){
			$("other").value="14";
		}else if(assistanceType=="15"){
			$("other").value="15";
		}else if(assistanceType=="16"){
			$("other").value="16";
		}else if(assistanceType=="17"){
			$("other").value="17";
		}else if(assistanceType=="18"){
			$("other").value="18";
		}else if(assistanceType=="19"){
			$("other").value="19";
		}else if(assistanceType=="20"){
			$("other").value="20";
		}else if(assistanceType=="21"){
			$("other").value="21";
		}else if(assistanceType=="22"){
			$("other").value="22";
		}else if(assistanceType=="23"){
			$("other").value="23";
		}else if(assistanceType=="24"){
			$("other").value="24";
		}else if(assistanceType=="26"){
			$("other").value="26";
		}else if(assistanceType=="27"){
			$("other").value="27";
		}else if(assistanceType=="28"){
			$("other").value="28";
		}else if(assistanceType=="29"){
			$("other").value="29";
		}else if(assistanceType=="30"){
			$("other").value="30";
		}else if(assistanceType=="31"){
			$("other").value="31";
		}else if(assistanceType=="32"){
			$("other").value="32";
		}else if(assistanceType=="33"){
			$("other").value="33";
		}else if(assistanceType=="34"){
			$("other").value="34";
		}else if(assistanceType=="35"){
			$("other").value="35";
		}
	}
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
//低保家庭应届大学本科新生
function setCityStu(src){
	if(src.checked){
		src.value = '25';
	}else{
		src.value = '';
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
//城市“三无”对象
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
function setElsehelp(src){
	if(src.checked){
		src.value = '11';
	}else{
		src.value = '';
	}
}

