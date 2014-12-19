function init() {	
	//ds.baseParams["ID@="]=idField;
	ds.load();
	L5.QuickTips.init(); 
}

 function back()
 {	 	var url='jsp/disfundssource/disfundssource_list.jsp';
		var text = 'DIS_FUNDS_SOURCE';
		L5.forward(url,text);	 
 }