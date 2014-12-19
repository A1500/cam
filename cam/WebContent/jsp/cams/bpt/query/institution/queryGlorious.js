function init() {
	ds.setParameter("xzqh",organCode);
	ds.on("load", showDiv);
	if(cxsj!='null'){
		document.getElementById("cxsj").value  = cxsj;
		ds.setParameter("cxsj", cxsj);
		ds.load();
	}
}

function query() {	
	cxsj = document.getElementById("cxsj").value;
	if(cxsj==""){
		L5.Msg.alert("提示","查询年份不能为空！");
		return false;
	}
	//校验年份格式
	if(!( _isNum(cxsj) && cxsj.length==4 )){
		L5.Msg.alert("提示", "请输入正确的年份！");
		return;
	}
	ds.setParameter("cxsj",cxsj);
	ds.setParameter("xzqh",organCode);
	ds.load();
	noReclick(ds,"queryButton");
}
function showDiv() {
	document.getElementById("reDiv").style.display = "";
}

function test(value) {
	var cxsj = document.getElementById("cxsj").value;
	if(cxsj==null||cxsj==""){
		L5.Msg.alert("提示","查询年份不能为空！");
		return false;
	}
	var data = new L5.Map();
	data.put("cxsj",cxsj);
	var xzqh = value.nextSibling.innerHTML;
	data.put("xzqh", xzqh);
	data.put("pageflag","1");
	var url = "jsp/cams/bpt/query/institution/queryglorious_detail.jsp";
	L5.forward(url, null, data);
}
 //打印预览调用方法
function printBill(){
	var printDataset=L5.DatasetMgr.lookup("ds");
	var url = L5.webPath+'/jsp/cams/bpt/query/print/queryGlorious1.fr3'; 
	var reportName="光荣院发展情况统计表";
	
	doReportPrint(reportName,currentUserName,organName,printDataset ,url);
}
function querydetail(obj, type,value) {
	//var width = screen.width-100;
    //var height = screen.height-140;
	var url = "";
	var organCode = obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
	var cxsj = document.getElementById("cxsj").value;// 查询时间
	if(cxsj==null||cxsj==""){
		L5.Msg.alert("提示","查询年份不能为空！");
		return false;
	}
	 
	var	url = L5.webPath+"/jsp/cams/bpt/query/institution/gloriousQuery.jsp?autoQuery=true&query_organCode="+organCode+"&cxsj="+cxsj 
	if(type=='buildState'){
		url+=("&buildState="+value);
	}else if(type =='buildingapproach'){
		url+=("&buildingapproach="+value);
	}else if(type =='approval'){
		url+=("&approval="+value);
	}else if(type =='prepareNum'){
		url+=("&prepareNum="+value);
	}else if(type =='bedNum'){
		url+=("&bedNum="+value);
	}else if(type=='totalFunds'){
		url+=("&totalFunds="+value);
	}else if(type =='countyfunds'){
		url+=("&countyfunds="+value);
	}else if(type =='cityfunds'){
		url+=("&cityfunds="+value);
	}else if(type =='aboveCityfunds'){
		url+=("&aboveCityfunds="+value);
	}else if(type =='specialassistance'){
		url+=("&specialassistance="+value);
	}else if(type =='otherNum'){
		url+=("&otherNum="+value);
	}else if(type =='careRotation'){
		url+=("&careRotation="+value);
	}else if(type =='gloryroom'){
		url+=("&gloryroom="+value);
	}else if(type =='carePeople'){
		url+=("&carePeople="+value);
	}	
	//window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	window.open(url);
}