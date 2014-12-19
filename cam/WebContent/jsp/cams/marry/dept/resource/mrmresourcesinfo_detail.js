function init() {	
	ds.baseParams["RESOURCE_ID@="]=idField;
	ds.load();
	L5.QuickTips.init(); 
}

 function back()
 {	 	var url='jsp/cams/marry/dept/resource/mrmresourcesinfo_list.jsp';
		var text = '资源信息表';
		L5.forward(url,text);	 
 }