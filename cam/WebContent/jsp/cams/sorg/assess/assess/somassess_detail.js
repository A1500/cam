function init() {	
	//ds.baseParams["TASK_CODE@="]=idField;
	ds.load();
	L5.QuickTips.init(); 
}

 function back()
 {	 	var url='jsp/cams/sorg/assess/assess/somassess/somassess_list.jsp';
		var text = 'SOM_ASSESS';
		L5.forward(url,text);	 
 }