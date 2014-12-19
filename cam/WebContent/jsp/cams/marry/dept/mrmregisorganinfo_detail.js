function init() {	
	ds.baseParams["ORGAN_ID@="]=idField;
	ds.load();
	L5.QuickTips.init(); 
}

 function back()
 {	 	var url='jsp/cams/marry/dept/mrmregisorganinfo_list.jsp';
		var text = '登记机关信息表';
		L5.forward(url,text);	 
 }
 
 //返回
function returnClick(){	
	window.close();
}

function returnBack() {
	window.history.go(-1);
}