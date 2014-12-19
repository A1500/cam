function init() {	
	ds.baseParams["FUNCTION_ID@="]=idField;
	ds.load();
	L5.QuickTips.init(); 
}

 function back()
 {	 	var url='jsp/cams/marry/dept/area/mrmregisarea_list.jsp';
		var text = '登记机关功能区面积表';
		L5.forward(url,text);	 
 }