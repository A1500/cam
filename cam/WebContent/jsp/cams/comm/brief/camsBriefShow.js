function init(){
	var tbqsDataSet=L5.DatasetMgr.lookup("tbqsDataSet");
	tbqsDataSet.setParameter("sort", "WORK_ID DESC");
	tbqsDataSet.load();
}
function meger() {
	document.getElementById("reportTitle").innerHTML = reportSeasonText+"民政主要数据简报";
	var startRow = 2;
	var megerCell = 0;
	var megerRow;
	var index = 0;
	var megObject;
	var megerValue = "";
	var table = document.getElementById("resultsBody");
	var row = table.rows;
	if(row>0){
		megerValue = row[startRow].cells[megerCell].childNodes[0].childNodes[0].innerHTML;
		megerRow = startRow;
		megObject	= row[startRow].cells[megerCell];
		for(var i=startRow+1;i<row.length;i++) {
				var cell = table.rows[i].cells;
				if(cell[megerCell].childNodes[0].childNodes[0].innerHTML == megerValue) {
						index++;
				} else {
					if(index >0) {
						megObject.rowSpan=index+1;
						for(var j=1;j<=index;j++) {
							table.rows[j+megerRow].cells[megerCell].style.display="none";
						}
					}
					megerValue = cell[megerCell].childNodes[0].childNodes[0].innerHTML;
					megObject	= row[i].cells[megerCell];
					megerRow = i;
					index=0;
				}
				
				if(i == row.length-1) {
					if(index >0) {
						megObject.rowSpan=index+1;
						for(var j=1;j<=index;j++) {
							table.rows[j+megerRow].cells[megerCell].style.display="none";
						}
					}
				}
		}
	}
	
}

function forExcel(){
	var ds = L5.DatasetMgr.lookup("camsBriefCountDataSet");
	L5.dataset2excel(ds, "/jsp/cams/comm/brief/camsBriefShowExcel.jsp?reportSeasonText="+reportSeasonText);
}

function func_ForDomicileSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=-2&level=1&organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("organCode").value = list[0];
		document.getElementById("organName").value = list[1];
	}
}
var reportSeasonText="";
function query(){
	var reportSeason=document.getElementById("reportSeason").value;//填报期数
	var obj=document.getElementById("reportSeason");
	reportSeasonText=obj.options[obj.selectedIndex].text;
	if(reportSeason==""){
		L5.Msg.alert("提示","请选择填报期数！");
		return;
	}
	var organCode=document.getElementById("organCode").value;//填报地区
	if(organCode==""){
		L5.Msg.alert("提示","请选择填报地区！");
		return;
	}
	var camsBriefCountDataSet = L5.DatasetMgr.lookup("camsBriefCountDataSet");
	camsBriefCountDataSet.setParameter("REPORT_SEASON",reportSeason);
	camsBriefCountDataSet.setParameter("ORGAN_AREA",organCode);
	camsBriefCountDataSet.setParameter("sort","SHOW_SERIAL_NUM");
	camsBriefCountDataSet.setParameter("dir","asc");
	camsBriefCountDataSet.on("load",function(){
		meger();
		document.getElementById("reDiv").style.display = "";
		var tab1 = document.getElementById("sourceTable");
		for(var j=2;j<=camsBriefCountDataSet.getCount()+1;j++){
			var record = camsBriefCountDataSet.getAt(j-2);
			if( record.get("ifBold") == "1"){
				tab1.rows[j].cells[0].getElementsByTagName("label")[0].style.fontWeight="bold";
			}
			if( record.get("indentLevel") == "1"){
				tab1.rows[j].cells[0].getElementsByTagName("label")[0].innerHTML="&nbsp;&nbsp;&nbsp;&nbsp;"+record.get("showName");
			}else if( record.get("indentLevel") == "2"){
				tab1.rows[j].cells[0].getElementsByTagName("label")[0].innerHTML="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+record.get("showName");
			}else if( record.get("indentLevel") == "3"){
				tab1.rows[j].cells[0].getElementsByTagName("label")[0].innerHTML="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+record.get("showName");
			}else if( record.get("indentLevel") == "4"){
				tab1.rows[j].cells[0].getElementsByTagName("label")[0].innerHTML="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+record.get("showName");
			}else{
				tab1.rows[j].cells[0].getElementsByTagName("label")[0].innerHTML=record.get("showName");
			}
		}
	});
	camsBriefCountDataSet.load();
}