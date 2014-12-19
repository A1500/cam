function init() {	
	//ds.baseParams["DISASTER_ID@="]=idField;
	ds.load();
	L5.QuickTips.init(); 
}

 function back()
 {	 	var url='jsp/sdmz/disasterInfo/disasterinfo_list.jsp';
		var text = '灾情信息';
		L5.forward(url,text);	 
 }