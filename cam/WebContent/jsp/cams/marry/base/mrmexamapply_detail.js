function init() {	
	//ds.baseParams["KSBM_ID@="]=idField;
	ds.load();
	L5.QuickTips.init(); 
}

 function back()
 {	 	var url='jsp/cams/marry/base/mrmexamapply_list.jsp';
		var text = '资格考试报名';
		L5.forward(url,text);	 
 }