function init(){
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	samGerocomiumInfoDataSet.setParameter("IF_CURRENT@=","1");	
	samGerocomiumInfoDataSet.setParameter("AREA_LEVEL_ID@like",organCode+"%" );
	samGerocomiumInfoDataSet.setParameter("sort","YEAR","MANA_LEVEL","GEROCOMIUM_NAME");
	samGerocomiumInfoDataSet.load();
}
function query(){
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	var areaLevelId=document.getElementById("areaLevelId").value;
	var gerocomiumName=document.getElementById("gerocomiumName").value;
	
	var manaLevel=document.getElementById("manaLevel").value;
	var legelPeople=document.getElementById("legelPeople").value;
	var startMonth=document.getElementById("startMonth").value;
	var endMonth=document.getElementById("endMonth").value;
	var gerocomiumLevel=document.getElementById("gerocomiumLevel").value;
	var heatingWay=document.getElementById("heatingWay").value;
	var houseProperty=document.getElementById("houseProperty").value;
	var startArea=document.getElementById("startArea").value;
	var endArea=document.getElementById("endArea").value;
	var startAssets=document.getElementById("startAssets").value;
	var endAssets=document.getElementById("endAssets").value;
	var startStandard=document.getElementById("startStandard").value;
	var endStandard=document.getElementById("endStandard").value;
	var startFunds=document.getElementById("startFunds").value;
	var endFunds=document.getElementById("endFunds").value;
	var startIncome=document.getElementById("startIncome").value;
	var endIncome=document.getElementById("endIncome").value;
	samGerocomiumInfoDataSet.setParameter("IF_CURRENT@=","1");	
	samGerocomiumInfoDataSet.setParameter("AREA_LEVEL_ID@like",getAreaCodeLikePrefix(areaLevelId));
	samGerocomiumInfoDataSet.setParameter("GEROCOMIUM_NAME@=",gerocomiumName);
	samGerocomiumInfoDataSet.setParameter("ESTABLISH_DATE>",startMonth);
	samGerocomiumInfoDataSet.setParameter("ESTABLISH_DATE<",endMonth);
	samGerocomiumInfoDataSet.setParameter("MANA_LEVEL@=",manaLevel);
	samGerocomiumInfoDataSet.setParameter("LEGEL_PEOPLE@=",legelPeople);
	samGerocomiumInfoDataSet.setParameter("GEROCOMIUM_LEVEL@=",gerocomiumLevel);
	samGerocomiumInfoDataSet.setParameter("HEATING_WAY@=",heatingWay);
	samGerocomiumInfoDataSet.setParameter("HOUSE_PROPERTY@=",houseProperty);
	samGerocomiumInfoDataSet.setParameter("TOTAL_AREA>",startArea);
	samGerocomiumInfoDataSet.setParameter("TOTAL_AREA<",endArea);
	samGerocomiumInfoDataSet.setParameter("FIXED_ASSETS>",startAssets);
	samGerocomiumInfoDataSet.setParameter("FIXED_ASSETS<",endAssets);
	samGerocomiumInfoDataSet.setParameter("SUPPORT_STANDARD>",startStandard);
	samGerocomiumInfoDataSet.setParameter("SUPPORT_STANDARD<",endStandard);
	samGerocomiumInfoDataSet.setParameter("MANAGEMENT_FUNDS>",startFunds);
	samGerocomiumInfoDataSet.setParameter("MANAGEMENT_FUNDS<",endFunds);
	samGerocomiumInfoDataSet.setParameter("YEAR_SIDELINE_INCOME>",startIncome);
	samGerocomiumInfoDataSet.setParameter("YEAR_SIDELINE_INCOME<",endIncome);
	samGerocomiumInfoDataSet.setParameter("sort","YEAR","MANA_LEVEL","GEROCOMIUM_NAME");
//	samGerocomiumInfoDataSet.setParameter("AREA_LEVEL_ID@like",organCode+"%" );
	samGerocomiumInfoDataSet.load();
}
function detail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("gerocomiumId",records[0].get("gerocomiumId"));
	var url="jsp/cams/drel/samu/baseinfo/samGerocomiumInfoDetail_list.jsp";
	L5.forward(url,'',data);
}
function detailAll(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var gerocomiumId=records[0].get("gerocomiumId");
	var width = screen.width-200;
		    var height = screen.height/2-50;
	 var url="samGerocomiumInfoHisList.jsp?gerocomiumId="+gerocomiumId;
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
// 弹出本地的行政区划
function func_ForAreaSelect() {
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("areaLevelId").value = list[0];
		document.getElementById("areaLevel").value = list[1];
	}
}
// 弹出主管
function func_ForManaSelect() {
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("manaLevelId").value = list[0];
		document.getElementById("manaLevel").value = list[1];
	}
}
function getAreaCodeLikePrefix(areaLevel){
	if(areaLevel == '' ){
		areaLevel= organCode;
	}
	if(areaLevel.substring(2)=="0000000000"){
		return areaLevel.substring(0,2);
	}else if(areaLevel.substring(4)=="00000000"){
		return areaLevel.substring(0,4);
    }else if(areaLevel.substring(6)=="000000"){
		return areaLevel.substring(0,6);
    }else if(areaLevel.substring(9)=="000"){
  	  return areaLevel.substring(0,9);
    }else{
    	return areaLevel;
    }

}
//弹出敬老院
function func_ForGeroSelect(){
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/drel/samu/geroTree/geroTree.jsp?radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("gerocomiumId").value = list[0];
		document.getElementById("gerocomiumName").value = list[1];
	}
}