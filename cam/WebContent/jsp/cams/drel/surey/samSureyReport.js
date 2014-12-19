//单位类型--民政局--'A1'
var SAM_ORGAN_TYPE='A1';
//核对类型---农村低保
var MININUM='02';
//核对类型---城市低保
var MININUM_CITY='01';
//核对类型--低收入
var LOW_INCOME='03';
//核对结果---非农村低保对象
//市级民政
var BE_CITY='beCity';
//区县民政
var BE_DISTRICT='beDistrict';

function init() {
	domicileDataset.setParameter("filterSql"," id like '"+organArea.substring(0,4)+"%000000'");
	domicileDataset.load();
	domicileDataset.on("load",function(ds){
		ds.filterBy(function(record, id){
			if(!("370100000000".indexOf(record.get('value'))>-1)){
				return record;
			}
		});
	});
	var assistanceTypeDS=L5.DatasetMgr.lookup("assistanceTypeDS");
	assistanceTypeDS.setParameter("filterSql","CODE in ('"+MININUM_CITY+"','"+MININUM+"','"+LOW_INCOME+"')");
	assistanceTypeDS.load();
	ds.on("load",showDiv)
    L5.QuickTips.init();
};

function getParam(ElementId) {
    var value = document.getElementById(ElementId).value;
    if (value == "") value = undefined;
    return value;
}
function query() {
	var applyDateQ = getParam("applyDateQ");
	var applyDateZ = getParam("applyDateZ");
	if(applyDateQ==undefined && applyDateZ==undefined) {
		L5.Msg.alert("提示","请选择申请日期！");
		return;
	}
	var assistanceType = getParam("assistanceTypeQuery");
	var CITY_DISTRICT="";
	if(userGrade()==BE_CITY){
		CITY_DISTRICT="beCity";
	}else if(userGrade()==BE_DISTRICT){
		CITY_DISTRICT="beDistrict";
	}	
	ds.setParameter("SURVEY_ORGAN_TYPE",SAM_ORGAN_TYPE);
	ds.setParameter("SURVEY_ORGAN_AREA",organArea);	
	ds.setParameter("applyDateQ", applyDateQ);
	ds.setParameter("applyDateZ", applyDateZ);  	    
	ds.setParameter("assistanceType", assistanceType);	 
	ds.setParameter("CITY_DISTRICT", CITY_DISTRICT);
    ds.load();
}
function showDiv() {
	var length = ds.getCount();
	setReportTitle();
	if(length==0) {
		ds.newRecord({"name":"无信息","Row1":0,"Row2":0,"Row3":0,"Row4":0,"Row5":0,"Row6":0,"Row7":0,"Row8":0,"Row9":0,"Row10":0,"Row11":0,"Row12":0});
	}
	document.getElementById("reDiv").style.display="";
}
function setReportTitle() {
	if(userGrade()==BE_CITY){
		document.getElementById("checkOrgan").innerHTML="核对单位";
	}else if(userGrade()==BE_DISTRICT){
		document.getElementById("checkOrgan").innerHTML="发起核对单位";
	}
}
function showWinRow(obj,assistanceType,isFinish){
	if(obj.value=="0"){
		return;
	}
	var applyDateQ = getParam("applyDateQ");
	var applyDateZ = getParam("applyDateZ");
	var assistanceTypeQuery = getParam("assistanceTypeQuery");
	var APPLY_ORGAN_TYPE="";
	var APPLY_ORGAN_AREA="";
	var SURVEY_ORGAN_AREA="";
	if(userGrade()==BE_CITY){
		SURVEY_ORGAN_AREA=obj.previousSibling.previousSibling.value;
		samSureyWfDataset.setParameter("APPLY_ORGAN_AREA",SURVEY_ORGAN_AREA);
		samSureyWfDataset.setParameter("SURVEY_ORGAN_TYPE",SAM_ORGAN_TYPE);
		samSureyWfDataset.setParameter("SURVEY_ORGAN_AREA",SURVEY_ORGAN_AREA);
	}else if(userGrade()==BE_DISTRICT){
		APPLY_ORGAN_TYPE=obj.previousSibling.previousSibling.previousSibling.previousSibling.value;
		APPLY_ORGAN_AREA=obj.previousSibling.previousSibling.value;
		samSureyWfDataset.setParameter("APPLY_ORGAN_TYPE",APPLY_ORGAN_TYPE);
		samSureyWfDataset.setParameter("APPLY_ORGAN_AREA",APPLY_ORGAN_AREA);
		samSureyWfDataset.setParameter("SURVEY_ORGAN_TYPE",SAM_ORGAN_TYPE);
		samSureyWfDataset.setParameter("SURVEY_ORGAN_AREA",organArea);
	}
	samSureyWfDataset.setParameter("IS_FINISH",isFinish);
	samSureyWfDataset.setParameter("applyDateQ", applyDateQ);
	samSureyWfDataset.setParameter("applyDateZ", applyDateZ);  
	samSureyWfDataset.setParameter("assistanceType", assistanceType);
	samSureyWfDataset.setParameter("assistanceTypeQuery", assistanceTypeQuery);		
	samSureyWfDataset.load();
	var win = L5.getCmp("win");
	win.show();
}
function winClose(){
	var win = L5.getCmp("win");
	win.setVisible(false);
}
function getParam(ElementId) {
    var value = document.getElementById(ElementId).value;
    if (value == "") value = undefined;
    return value;
}
//判断用户等级
function userGrade(){
	if(organArea.substring(4,12)=="00000000"){
		return BE_CITY;
	}else if(organArea.substring(6,12)=='000000'){
		return BE_DISTRICT;
	}else{
		L5.Msg.alert('提示','此用户没有访问权限！');
		return;
	}
}