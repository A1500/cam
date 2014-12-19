var time = getYesterday();
function init() {
	ds.setParameter("xzqu", organCode);
	initQueryTime();
	ds.on('load', showDiv);
	if(cxsjq!='null'&&cxsjz!='null'){
		ds.setParameter("cxsjq", cxsjq);
		ds.setParameter("cxsjz", cxsjz);
		ds.load();
	}
	L5.QuickTips.init();
	
};
function getYesterday(){
	var date = new Date();
	date.setDate(date.getDate()-1);
    var y = date.getFullYear();
    var m = date.getMonth()+1;
    var d = date.getDate();
    return y+"-"+m+"-"+d;
}
function initQueryTime(){
	if(cxsjq!='null'&&cxsjz!='null'){
		document.getElementById("cxsjq").value=cxsjq;//查询开始时间
	    document.getElementById("cxsjz").value=cxsjz;//查询结束时间
	}else{
		document.getElementById("cxsjq").value=time;//查询开始时间
	    document.getElementById("cxsjz").value=time;//查询结束时间
	}
}
function initTime(){
	document.getElementById("cxsjq").value=time;//查询开始时间
	document.getElementById("cxsjz").value=time;//查询结束时间
}
function meger() {
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
		
function showDiv() {
	document.getElementById("reDiv").style.display = "";
	var cxsjq = document.getElementById("cxsjq").value;//查询开始时间
    var cxsjz = document.getElementById("cxsjz").value;//查询结束时间
	var cxsjqs = cxsjq.split("-");
	if(cxsjq==cxsjz){
		document.getElementById("statisticsTime").innerText = cxsjqs[0]+"年"+cxsjqs[1]+"月"+cxsjqs[2]+"日";
	}else{
		var cxsjzs = cxsjz.split("-");
		document.getElementById("statisticsTime").innerText =cxsjqs[0]+"年"+cxsjqs[1]+"月"+cxsjqs[2]+"日至"+cxsjzs[0]+"年"+cxsjzs[1]+"月"+cxsjzs[2]+"日";;
	}
}

function query() {
	var cxsjq = document.getElementById("cxsjq").value;//查询开始时间
    var cxsjz = document.getElementById("cxsjz").value;//查询结束时间
    if(cxsjq==""){
    	L5.Msg.alert("提示","请选择统计起始时间！");
		return;
    }
    if(cxsjz==""){
    	L5.Msg.alert("提示","请选择统计截止时间！");
		return;
    }
    var timeq = new Date(Number(cxsjq.split("-")[0]),Number(cxsjq.split("-")[1]),Number(cxsjq.split("-")[2]));
    var timez = new Date(Number(cxsjz.split("-")[0]),Number(cxsjz.split("-")[1]),Number(cxsjz.split("-")[2]));
    if(timeq>timez){
    	L5.Msg.alert("提示","统计截止不能小于统计起始时间，请重新选择！");
		return;
    }
	ds.setParameter("xzqu", organCode);
	ds.setParameter("cxsjq",cxsjq);
	ds.setParameter("cxsjz",cxsjz);
	ds.load();
}

function back() {
	history.go(-1);
}


function queryNextLevel(value){
	var xzqu = value.nextSibling.innerHTML;
	if(xzqu==organCode){
		return;
	}
	var data = new L5.Map();
	var cxsjq = document.getElementById("cxsjq").value;//查询开始时间
    var cxsjz = document.getElementById("cxsjz").value;//查询结束时间
     if(cxsjq==""){
    	L5.Msg.alert("提示","请选择统计起始时间！");
		return;
    }
    if(cxsjq==""){
    	L5.Msg.alert("提示","请选择统计截止时间！");
		return;
    }
	data.put("cxsjq",cxsjq);
	data.put("cxsjz",cxsjz);
	var xzqu = value.nextSibling.innerHTML;
	data.put("xzqu", xzqu);
	data.put("pageflag","1");
	var url = "jsp/cams/marry/query/marry/marryPeopleTypeDay/marryPeopleTypeNextLevel.jsp";
	L5.forward(url, null, data);
	
}

function CheckTxt(ObjNum)
 {   
 var regExp=/^(19|20)[0-9]{2}$/;
 var elementTxt=document.getElementById (ObjNum);
 	if(regExp.test (elementTxt.value ))
 	{
 	return true ;
 	}
	else
 	{
	  L5.Msg.alert("提示","请输入正确的年份!");
	  elementTxt.focus();
	  elementTxt.value="";
	  return false ;
 	}
 }
 
function forExcel(){
	var statisticsTime = document.getElementById("statisticsTime").innerText;
	L5.dataset2excel(ds, "/jsp/cams/marry/query/marry/marryPeopleTypeDay/exportPeopleTypeExcel.jsp?statisticsTime="+statisticsTime);
}