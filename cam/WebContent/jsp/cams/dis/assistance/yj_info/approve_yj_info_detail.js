function init() {	
	infoDs.baseParams["INFO_ID@="]=infoId;
	infoDs.load();
	L5.QuickTips.init(); 
}

 function back()
 {	 	
	 	/*var url='jsp/cams/dis/assistance/gd_info/gd_info_list.jsp';
		var text = 'DIS_RELIEF_INFO';
		L5.forward(url,text);*/
	 history.go(-1);
 }