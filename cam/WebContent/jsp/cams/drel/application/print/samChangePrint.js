function printChangeNotice(gridPanelId){
	var selected = L5.getCmp(gridPanelId).getSelectionModel().getSelections();
    if (selected.length < 1) {
        L5.Msg.alert("提示", "请选择记录！");
        return;
    }
    var applyIds = "";
    for(var i=0;i<selected.length;i++){
    	if(""==applyIds){
    		applyIds=selected[i].get("APPLY_ID");
    	} else {
    		applyIds=applyIds+","+selected[i].get("APPLY_ID");
    	}        	
    }
    noticePrintDs.setParameter("applyIds",applyIds);
    noticePrintDs.setParameter("assistanceType",assistanceType);
    noticePrintDs.setParameter("assistanceDate",currentDate);
    noticePrintDs.on("load",doPrintChangeNotice);
    noticePrintDs.load();
}
function doPrintChangeNotice(ds){
	var records = ds.getAllRecords();
    var RfrUrl = L5.webPath + '/jsp/cams/drel/application/print/changeNotice.fr3'
    if("03"==assistanceType){
		RfrUrl = L5.webPath + '/jsp/cams/drel/application/print/fiveChangeNotice.fr3'
		for(var i=0;i<records.length;i++){
			if(records[i].get("ORIGINA_WAY")=="03"){
				records[i].set("ORIGINA_WAY","集中供养");
			} else {
				records[i].set("ORIGINA_WAY","分散供养");
			}
			if(records[i].get("NEW_WAY")=="03"){
				records[i].set("NEW_WAY","集中供养");
			} else {
				records[i].set("NEW_WAY","分散供养");
			}
		}
	}
    printReport(getPrintDataByRecords(assistanceTypeName, getCurrentDate(), '',organName, records), RfrUrl);
}