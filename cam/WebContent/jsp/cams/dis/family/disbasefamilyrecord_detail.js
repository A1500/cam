function init() {	
	//ds.baseParams["RECORD_ID@="]=idField;
	ds.load();
	L5.QuickTips.init(); 
}

 function back()
 {	 	var url='jsp/cams/dis/family/disbasefamilyrecord_list.jsp';
		var text = 'DIS_BASE_FAMILY_RECORD';
		L5.forward(url,text);	 
 }