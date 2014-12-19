
function init(){
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organCode;
}

//导出Excel
function exportExcel(){
	document.getElementById("exportExcel").disabled=true;
	var dataset=L5.DatasetMgr.lookup("ds");
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]='1';  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();
	var filename="农村低保台账统计";
	var class_path = "com.inspur.cams.drel.funds.release.cmd.SamReleaseExcelCommand";
	var gridObj = L5.getCmp("grid");
	L5.grid2excel(dataset, gridObj, filename, class_path);
	
}
function query(){
	var domicileCode=document.getElementById("domicileCode").value
	if(domicileCode){
		ds.setParameter("domicileCode",domicileCode);//370104002001槐荫区
	}else{
		ds.setParameter("domicileCode",organCode);
	}
	ds.setParameter("assistanceType","02");
	ds.load();
}


// 弹出本地的行政区划
function func_ForDomicileSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
	}
}
//行政区划代码截取.
function getAreaCodeLikePrefix(organCode){
	if(organCode.substring(2,12)=="0000000000"){//省370000000000
		return organCode.substring(0,2);
	} else if (organCode.substring(4,12)=="00000000"){//市370100000000
		return organCode.substring(0,4);
	} else if (organCode.substring(6,12)=="000000"){//县370104000000
		return  organCode.substring(0,6);
	} else if (organCode.substring(9,12)=="000"){//乡370104003000
		return  organCode.substring(0,9);
	}
}