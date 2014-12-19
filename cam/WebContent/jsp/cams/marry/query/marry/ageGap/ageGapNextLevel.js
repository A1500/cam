function init() {
	ds.setParameter("xzqu", xzqu);
	if (cxsjq != null&&cxsjz != null) {
		ds.setParameter("cxsjq", cxsjq);
		ds.setParameter("cxsjz", cxsjz);
		ds.load();
	}
	ds.on("load",meger);
	L5.QuickTips.init();
	
};
function queryNextLevel(value){
	var xzqh= value.nextSibling.innerHTML;
	if(xzqh==xzqu){
		return;
	}
	var data = new L5.Map();
	data.put("cxsjq",cxsjq);
	data.put("cxsjz",cxsjz);
	data.put("xzqu", xzqh);
	data.put("pageflag", "2");
	var url = "jsp/cams/marry/query/marry/ageGap/ageGapNextLevel.jsp";
	L5.forward(url, null, data);
}
function setStatisticsTime(){
	if(cxsjq==cxsjz){
		var times = cxsjq.split("-");
		document.getElementById("statisticsTime").innerText = times[0]+"年"+times[1]+"月1日至 "+times[0]+"年"+times[1]+"月"+lastDay(times[0],times[1])+"日";
	}else{
		var timesq = cxsjq.split("-");
		var timesz = cxsjz.split("-");
		document.getElementById("statisticsTime").innerText = timesq[0]+"年"+timesq[1]+"月1日 至 "+ timesz[0]+"年"+timesz[1]+"月"+lastDay(timesz[0],timesz[1])+"日";
	}
} 
function meger() {
	setStatisticsTime();
	document.getElementById("reDiv").style.display = "";
	var startRow = 2;
	var megerCell = 0;
	var megerRow;
	var index = 0;
	var megObject;
	var megerValue = "";
	var table = document.getElementById("resultsBody");
	var row = table.rows;
	
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

function back() {
	if(pageflag=='1'){
		var data = new L5.Map();
		data.put("cxsjq",cxsjq);
		data.put("cxsjz",cxsjz);
		var url = "jsp/cams/marry/query/marry/ageGap/queryageGap.jsp";
		L5.forward(url, null, data);
	}else{
		history.go(-1);
	}
}

function lastDay(year,month){
	var data = new Date(year,month,0);
	return(data.getDate());
}

function forExcel(){
	var statisticsTime = document.getElementById("statisticsTime").innerText;
	L5.dataset2excel(ds, "/jsp/cams/marry/query/marry/ageGap/exportageGapExcel.jsp?statisticsTime="+statisticsTime);
}