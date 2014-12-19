function init() {	
	//ds.baseParams["INFO_ID@="]=idField;
	ds.load();
	L5.QuickTips.init(); 
}

 function back()
 {	 	var url='jsp/cams/dis/assistance/dc_info/dc_info_list.jsp';
		var text = 'DIS_RELIEF_INFO';
		L5.forward(url,text);	 
 }