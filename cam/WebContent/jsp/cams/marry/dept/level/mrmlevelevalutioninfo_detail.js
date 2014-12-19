function init() {	
	//ds.baseParams["EVALU_ID@="]=idField;
	ds.load();
	L5.QuickTips.init(); 
}

 function back()
 {	 	var url='jsp/cams/marry/dept/level/mrmlevelevalutioninfo_list.jsp';
		var text = '等级评定信息表';
		L5.forward(url,text);	 
 }