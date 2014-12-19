 
function init() {
    var dsNext = L5.DatasetMgr.lookup("dsNext");
    dsNext.setParameter("xzqu", xzqu);
	if (cxsjq != null&&cxsjz != null) { 
		dsNext.setParameter("cxsjq", cxsjq);
		dsNext.setParameter("cxsjz", cxsjz);
		dsNext.load();
	}
	dsNext.on("load",setStatisticsTime);
	L5.QuickTips.init();
	
};

function setStatisticsTime(){
	var cxsjqs = cxsjq.split("-");
	if(cxsjq==cxsjz){
		document.getElementById("statisticsTime").innerText = cxsjqs[0]+"年"+cxsjqs[1]+"月"+cxsjqs[2]+"日";
	}else{
		var cxsjzs = cxsjz.split("-");
		document.getElementById("statisticsTime").innerText =cxsjqs[0]+"年"+cxsjqs[1]+"月"+cxsjqs[2]+"日至"+cxsjzs[0]+"年"+cxsjzs[1]+"月"+cxsjzs[2]+"日";;
	}
} 
function queryNextLevel(value){
	var xzqh = value.nextSibling.innerHTML;
	if(xzqh==xzqu){
		return;
	}
	var data = new L5.Map();
	data.put("cxsjq",cxsjq);
	data.put("cxsjz",cxsjz);
	data.put("xzqu", xzqh);
    var url = "jsp/cams/marry/query/marry/marryPeopleTypeDay/marryPeopleTypeNextLevel.jsp";
	L5.forward(url, null, data);
}
function back() {
	if(pageflag=='1'){
		var data = new L5.Map();
		data.put("cxsjq",cxsjq);
		data.put("cxsjz",cxsjz);
		var url = "jsp/cams/marry/query/marry/marryPeopleTypeDay/marryPeopleTypeQuery.jsp";
		L5.forward(url, null, data);
	}else{
		history.go(-1);
	}
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
	L5.dataset2excel(dsNext, "/jsp/cams/marry/query/marry/marryPeopleTypeDay/exportPeopleTypeExcel.jsp?statisticsTime="+statisticsTime);
}