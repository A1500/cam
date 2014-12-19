function init(){
	var ds1 = L5.DatasetMgr.lookup("ds1");
	if(cxsjq!='null'&&cxsjz!='null'&&applyType!='null'){
		var timesq = cxsjq.split("-");
		var timesz = cxsjz.split("-");
		ds1.setParameter("qTime", timesq[0]+timesq[1]+timesq[2]);
		ds1.setParameter("zTime", timesz[0]+timesz[1]+timesz[2]);
		ds1.setParameter("organId",organId);
		ds1.setParameter("applyType",applyType);
		ds1.load();
	}
	ds1.on("load",function(){
		document.getElementById("reDiv").style.display = "";
		var timesq = cxsjq.split("-");
		var timesz = cxsjz.split("-");
		document.getElementById("statisticsTime").innerText = timesq[0]+"年"+timesq[1]+"月"+timesq[2]+"日至"+timesz[0]+"年"+timesz[1]+"月"+timesz[2]+"日";
	});
	L5.QuickTips.init();
}
function queryNextLevel(obj){
	var primaryKey = obj.nextSibling.innerHTML;
	var data = new L5.Map();
	data.put("cxsjq",cxsjq);
	data.put("cxsjz",cxsjz);
	data.put("primaryKey", primaryKey);
	data.put("applyType",applyType);
	data.put("organId",organId);
	data.put("username",encodeURIComponent(encodeURIComponent(username)));
	data.put("userId",userId);
	var url = "jsp/cams/sorg/query/workflowQuery/workflowQueryThirdLevel.jsp";
	L5.forward(url, null, data);
}
function showAllApplyInfo(obj){
	var sorgId = obj.nextSibling.innerHTML;
	var width = screen.width - 100;
	var height = screen.height - 140;
	var url = "../somHis/somHisQueryDetail.jsp?sorgId=" + sorgId+"&ifJump="+"1";
	var win = window.showModalDialog(url, window,
				"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
						+ height + "px;resizable:1");
}
function back() {
	var data = new L5.Map();
	data.put("cxsjq",cxsjq);
	data.put("cxsjz",cxsjz);
	var url = "jsp/cams/sorg/query/workflowQuery/workflowQuery.jsp";
	L5.forward(url, null, data);
}
function forExcel(){
	var ds1 = L5.DatasetMgr.lookup("ds1");
	var statisticsTime = document.getElementById("statisticsTime").innerText;
	L5.dataset2excel(ds1, "/jsp/cams/sorg/query/workflowQuery/exportYbTaskQuerySecondExcel.jsp?statisticsTime="+statisticsTime);
}