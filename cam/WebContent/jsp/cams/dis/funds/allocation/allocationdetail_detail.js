function init() {	
	//ds.baseParams["ID@="]=idField;
	ds.load();
	L5.QuickTips.init(); 
}

 function back()
 {	 	var url='jsp/disfundsallocationdetail/disfundsallocationdetail_list.jsp';
		var text = 'DIS_FUNDS_ALLOCATION_DETAIL';
		L5.forward(url,text);	 
 }