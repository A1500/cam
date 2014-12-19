function init() {	
	//ds.baseParams["FDY_ID@="]=idField;
	ds.load();
	L5.QuickTips.init(); 
}

 function back()
 {	 /*	var url='jsp/cams/marry/mrmfdy_list.jsp';
		var text = 'MRM_FDY';
		L5.forward(url,text);	 */
		window.close();
 }