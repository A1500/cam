//核对结果---非城市低保对象
var NOT_MININUM_CITY='11';
//核对结果---非农村低保对象
var NOT_MININUM='12';
//核对结果---非低收入家庭
var NOT_LOWINCOME='13';
function init(){
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
	initLoad();
	
	L5.QuickTips.init();
}
function initLoad(){
	samSureyWfDataset.setParameter("CUR_ACTIVITY","ACT_GATHER");
	samSureyWfDataset.setParameter("CUR_STATUS","DONE");
	samSureyWfDataset.setParameter("CUR_ACTIVITY_ORGAN_TYPE",organType);
	samSureyWfDataset.setParameter("CUR_ACTIVITY_AREA",organArea);
	
	samSureyWfDataset.setParameter("queryFlag","checked");
	samSureyWfDataset.load();
}
function query(){
	samSureyWfDataset.setParameter("CUR_ACTIVITY","ACT_GATHER");
	samSureyWfDataset.setParameter("CUR_STATUS","DONE");
	samSureyWfDataset.setParameter("CUR_ACTIVITY_ORGAN_TYPE",organType);
	samSureyWfDataset.setParameter("CUR_ACTIVITY_AREA",organArea);
	
	samSureyWfDataset.setParameter("queryFlag","checked");
	
	var name = getParam("name");
	var idCard = getParam("idCard");
	var sureyDateQ = getParam("sureyDateQ");
	var sureyDateZ = getParam("sureyDateZ");
	var result = getParam("resultQuery");
	var applyDateQ = getParam("applyDateQ");
	var applyDateZ = getParam("applyDateZ");
	var assistanceType = getParam("assistanceTypeQuery");	
	
	samSureyWfDataset.setParameter("name", name);
	samSureyWfDataset.setParameter("idCard", idCard);
	samSureyWfDataset.setParameter("sureyDateQ", sureyDateQ);
	samSureyWfDataset.setParameter("sureyDateZ", sureyDateZ);
	samSureyWfDataset.setParameter("result", result);
	samSureyWfDataset.setParameter("applyDateQ", applyDateQ);
	samSureyWfDataset.setParameter("applyDateZ", applyDateZ);
	samSureyWfDataset.setParameter("assistanceType", assistanceType);	
	samSureyWfDataset.load();
}
var peopleId = "";

function editObject(){
	var gridPanel=L5.getCmp('gridPanel');
	var selected = gridPanel.getSelectionModel().getSelections();
	if(selected.length != 1){
		L5.Msg.alert("提示","请选择一条记录进行处理!");
		return false;
	}
	var select = selected[0];
	var assistanceType=select.get('ASSISTANCE_TYPE');
	if(assistanceType=="01"||assistanceType=="02"){	
		var win = L5.getCmp("miniWin");
		win.show();
		winSureyWfDataset.removeAll();
		var record = winSureyWfDataset.newRecord();
		record.set("flowId",select.get("FLOW_ID"));
		record.set("surveyId",select.get("SURVEY_ID"));
		record.set("idCard",select.get("ID_CARD"));
		record.set("name",select.get("NAME"));
		record.set("domicileCode",select.get("DOMICILE_CODE"));
		record.set("apanageCode",select.get("APANAGE_CODE"));
		$("mini_applyOrganName").innerText = organName;
		record.set("assistanceType", select.get("ASSISTANCE_TYPE"));
		$("mini_resultSelect").value = select.get("RESULT");
		$("surveyOrganName").innerText= select.get("SURVEY_ORGAN_NAME");
		if(_$("mini_resultSelect")==NOT_MININUM_CITY||_$("mini_resultSelect")==NOT_MININUM||_$("mini_resultSelect")=="04"){
			$("mini_signOrgnTr").style.display = "none";
		}else{
			$("mini_signOrgnTr").style.display = "block";
			$("label_signOrgan").innerText="低保证发证机关：";
			$("label_signDate").innerText="低保证发证时间：";
			$("mini_signOrgan").innerText = select.get("SIGN_ORGAN");
			$("mini_signDate").innerText = select.get("SIGN_DATE");
		}
		peopleId = select.get("PEOPLE_ID");
	}else if(assistanceType=="03"){
		var win = L5.getCmp("miniWin");
		win.show();	
		winSureyWfDataset.removeAll();
		var record = winSureyWfDataset.newRecord();
		record.set("flowId",select.get("FLOW_ID"));
		record.set("surveyId",select.get("SURVEY_ID"));
		record.set("idCard",select.get("ID_CARD"));
		record.set("name",select.get("NAME"));
		record.set("domicileCode",select.get("DOMICILE_CODE"));
		record.set("apanageCode",select.get("APANAGE_CODE"));
		$("mini_applyOrganName").innerText = organName;
		record.set("assistanceType", select.get("ASSISTANCE_TYPE"));
		$("mini_resultSelect").value = select.get("RESULT");
		$("surveyOrganName").innerText= select.get("SURVEY_ORGAN_NAME");
		if(_$("mini_resultSelect")==NOT_LOWINCOME||_$("mini_resultSelect")=="04"){
			$("mini_signOrgnTr").style.display = "none";
		}else{
			$("mini_signOrgnTr").style.display = "block";
			$("label_signOrgan").innerText="低收入认定单位：";
			$("label_signDate").innerText="低收入认定时间：";
			$("mini_signOrgan").innerText = select.get("SIGN_ORGAN");
			$("mini_signDate").innerText = select.get("SIGN_DATE");
		}
		peopleId = select.get("PEOPLE_ID");		
	}
}

function mini_clickClose(){
	var win = L5.getCmp("miniWin");
	win.setVisible(false);
}
function low_clickClose(){
	var win = L5.getCmp("lowWin");
	win.setVisible(false);
}
function getParam(ElementId) {
    var value = document.getElementById(ElementId).value;
    if (value == "") value = undefined;
    return value;
}

//核对结果导出Excel 
function exportExcel() {
	var pageSize = samSureyWfDataset.pageInfo.pageSize;
	var pageIndex = samSureyWfDataset.pageInfo.pageIndex;
	var startCursor = samSureyWfDataset.pageInfo.startCursor;
	var total = samSureyWfDataset.getTotalCount();
	samSureyWfDataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	samSureyWfDataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	samSureyWfDataset.baseParams["limitExcel"]=total;  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为total，
													//默认为导出当前页pageSize。
	L5.dataset2excel(samSureyWfDataset,"/jsp/ext/esurey/manage/assistance/exportExcel.jsp");
	samSureyWfDataset.baseParams["excelType"]="reset"; //重置导出类型
}
