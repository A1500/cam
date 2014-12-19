function init() {
	ds.baseParams["KSAP_ID@="]=idField;
	ds.load();
	L5.QuickTips.init(); 
}


 function back()
 {	 	var url='jsp/cams/marry/person/mrmexamschedulebzy_list.jsp';
		var text = '登记员资格考试安排表';
		L5.forward(url,text);	 
 }