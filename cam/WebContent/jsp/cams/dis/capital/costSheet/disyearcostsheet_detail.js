function init() {	
	//ds.baseParams["ID@="]=idField;
	ds.load();
	L5.QuickTips.init(); 
}

 function back()
 {	 	var url='jsp/cams/dis/capital/costSheet/costsheet_list.jsp';
		var text = 'DIS_YEAR_COST_SHEET';
		L5.forward(url,text);	 
 }