function init(){
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter("ORGAN_ID@=",userId);
	ds.load();
}

//导出Excel
function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("ds");
	L5.dataset2excel(dataset,"/jsp/ext/cdc/users/accountExcel.jsp?userName="+userName);
}

function query(){
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter("ORGAN_ID@=",userId);
	ds.setParameter("USER_ID@LIKE",document.getElementById("query_Code").value+"%");
	ds.setParameter("USER_NAME@LIKE",document.getElementById("query_name").value+"%");
	ds.load();
}

function confirm(){}
function cancel(){
	window.close();
}



