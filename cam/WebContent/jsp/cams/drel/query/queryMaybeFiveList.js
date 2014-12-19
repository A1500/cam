function init() {
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
	//document.getElementById("sAge").value='60';
	document.getElementById('ifDisability').value='1';
	document.getElementById('ifSupported').value='0';
	document.getElementById('marriageCode').value='10';
	//alert(new Date().getFullYear()-60+'-'+(new Date()+'').substring(5));
}

function query(){
	var baseinfoPeopleDS=L5.DatasetMgr.lookup("baseinfoPeopleDS");
	baseinfoPeopleDS.baseParams["excelType"]="2";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	var domicileCode=document.getElementById("domicileCode").value;
	if(domicileCode){
		baseinfoPeopleDS.setParameter("domicileCode",domicileCode);
	}else{
		baseinfoPeopleDS.setParameter("domicileCode",organArea);
	}
	
	baseinfoPeopleDS.setParameter("marriageCode",document.getElementById("marriageCode").value);
	baseinfoPeopleDS.setParameter("ifDisability",document.getElementById("ifDisability").value);
	baseinfoPeopleDS.setParameter("ifSupported",document.getElementById("ifSupported").value);
	//var sAge=document.getElementById("sAge").value;
	var sAge=60;
	if(sAge){
		baseinfoPeopleDS.setParameter("sAge",(new Date().getFullYear()-sAge)+'-'+(new Date()+'').substring(5));
	}
	baseinfoPeopleDS.load();
	baseinfoPeopleDS.on("load", function(){
		var qrToolbar = L5.getCmp("qrToolbar");
    	if(baseinfoPeopleDS.getCount()>0) 
			qrToolbar.setText("疑似五保对象查询信息(" + baseinfoPeopleDS.getTotalCount() + "条)");
		else
			qrToolbar.setText("疑似五保对象查询信息");
    });
	noReclick(baseinfoPeopleDS,"queryId");
}
//明细
function detailHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:detail(\''+record.get("PEOPLE_ID")+'\',\''+record.get("APPLY_ID")+'\',\''+record.get("ASSISTANCE_TYPE")+'\')">'+value+'</a>';
}

function detail(peopleId,applyId,assistanceType){
	getPeopleInfo(peopleId,applyId,assistanceType);
}

//导出Excel
function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("baseinfoPeopleDS");	
	if(dataset.getCount()<=0){
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}	
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
	var filename="疑似五保对象查询";
	var class_path = "com.inspur.cams.drel.funds.release.cmd.SamReleaseCSVCommand";
	var gridObj = L5.getCmp("infoQueryGrid");
	L5.grid2excel(dataset, gridObj, filename, class_path);

}
//重置
function resetQuery() {
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
	document.getElementById("sAge").value="";
	document.getElementById("eAge").value="";
	document.getElementById('ifDisability').value='';
	document.getElementById('ifSupported').value='';
	document.getElementById('marriageCode').value='';
}

//获得当前日期 2011-05
function getCurYM(){
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10){month="0"+month;}
	return year+"-"+month;
}

// 弹出本地的行政区划
function func_ForDomicileSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
	}
}