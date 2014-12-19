function init(){
	var ds1 = L5.DatasetMgr.lookup("ds1");
	if(primaryKey!='null'){
		ds1.setParameter("primaryKey",primaryKey);
		ds1.load();
	}
	ds1.on("load",function(){
		document.getElementById("reDiv").style.display = "";
		var timesq = cxsjq.split("-");
		var timesz = cxsjz.split("-");
		document.getElementById("statisticsTime").innerText = timesq[0]+"年"+timesq[1]+"月"+timesq[2]+"日至"+timesz[0]+"年"+timesz[1]+"月"+timesz[2]+"日";
		if(ds1.getCount()>0){
			document.getElementById("PROC_DEF_NAME").innerHTML = ds1.get("PROC_DEF_NAME");
			document.getElementById("PROC_CREATE_TIME").innerHTML = ds1.get("PROC_CREATE_TIME");
			document.getElementById("PROC_END_TIME").innerHTML = ds1.get("PROC_END_TIME");
			document.getElementById("ACTIVE_ACT_DEF_NAMES").innerHTML = ds1.get("ACTIVE_ACT_DEF_NAMES");
			var activeActDefNames = ds1.get("ACTIVE_ACT_DEF_NAMES");
			if(activeActDefNames=='null'){
				document.getElementById("ifFinish").innerHTML="是";	
				document.getElementById("activeActDefNames").style.display="none";
			}else{
				document.getElementById("ifFinish").innerHTML="否";	
				document.getElementById("procEndTime").style.display="none";
			}
			
		}
	});
	L5.QuickTips.init();
}
function back() {
	var data = new L5.Map();
	data.put("cxsjq",cxsjq);
	data.put("cxsjz",cxsjz);
	data.put("applyType",applyType);
	data.put("organId",organId);
	var url = "jsp/cams/sorg/query/workflowQuery/workflowQuerySecondLevel.jsp";
	L5.forward(url, null, data);
}
function backFirst(){
	var data = new L5.Map();
	data.put("cxsjq",cxsjq);
	data.put("cxsjz",cxsjz);
	var url = "jsp/cams/sorg/query/workflowQuery/workflowQuery.jsp";
	L5.forward(url, null, data);
}
function forExcel(){
	var ds1 = L5.DatasetMgr.lookup("ds1");
	var statisticsTime = document.getElementById("statisticsTime").innerText;
	L5.dataset2excel(ds1, "/jsp/cams/sorg/query/workflowQuery/exportYbTaskQueryThirdExcel.jsp?statisticsTime="+statisticsTime);
	
}