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
	assistanceTypeDS.filterBy(function(record, id){
		if("01".indexOf(record.get('value'))>-1 || "02".indexOf(record.get('value'))>-1 || "03".indexOf(record.get('value'))>-1){
			return record;
		}
	});	
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
	ds.setParameter("APPLY_ORGAN_TYPE",organType);
	ds.setParameter("APPLY_ORGAN_AREA",organArea);	
	ds.setParameter("applyDateQ", applyDateQ);
	ds.setParameter("applyDateZ", applyDateZ);    
	ds.setParameter("assistanceType", assistanceType);	 	   
    ds.load();
}
function showDiv() {
	var length = ds.getCount();
	if(length==0) {
		ds.newRecord({"name":"无信息","Row1":0,"Row2":0,"Row3":0,"Row4":0,"Row5":0,"Row6":0,"Row7":0,"Row8":0,"Row9":0,"Row10":0,"Row11":0,"Row12":0});
	}
	document.getElementById("reDiv").style.display="";
}
function showWinRow(obj,assistanceType,isFinish){
	if(obj.value=="0"){
		return;
	}
	var applyDateQ = getParam("applyDateQ");
	var applyDateZ = getParam("applyDateZ");
	var assistanceTypeQuery = getParam("assistanceTypeQuery");
	var SURVEY_ORGAN_TYPE=obj.parentElement.childNodes[0].value;
	var SURVEY_ORGAN_AREA=obj.parentElement.childNodes[2].value;
	samSureyWfDataset.setParameter("APPLY_ORGAN_TYPE",organType);
	samSureyWfDataset.setParameter("APPLY_ORGAN_AREA",organArea);
	samSureyWfDataset.setParameter("SURVEY_ORGAN_TYPE",SURVEY_ORGAN_TYPE);
	samSureyWfDataset.setParameter("SURVEY_ORGAN_AREA",SURVEY_ORGAN_AREA);
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