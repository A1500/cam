function init() {	
	ds.baseParams["KSXX_ID@="]=idField;
	ds.load();
	L5.QuickTips.init(); 
}

 function back()
 {	 	var url='jsp/cams/marry/person/mrmqualificationexam_list.jsp';
		var text = '登记员资格考试信息表';
		L5.forward(url,text);	 
 }