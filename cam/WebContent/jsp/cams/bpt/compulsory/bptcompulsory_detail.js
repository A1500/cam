function init() {	
	ds.setParameter("id",Id);
	ds.load();
	L5.QuickTips.init(); 
}

 function back()
 {	 	var url='jsp/cams/bpt/compulsory/bptcompulsory_list.jsp';
		var text = 'BPT_COMPULSORY';
		L5.forward(url,text);	 
 }