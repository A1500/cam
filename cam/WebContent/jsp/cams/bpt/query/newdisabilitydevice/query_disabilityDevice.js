function init() {
L5.Ajax.timeout=300000;
	ds.setParameter("xzqu", xzqu);
	ds.setParameter("qxlb", devType);
	if (cxsjq != null) {
		ds.setParameter("cxsjq", cxsjq);
	}
	if (cxsjz != null) {
		ds.setParameter("cxsjz", cxsjz);
	}
	ds.load();
	ds.on("load", showDiv);
	L5.QuickTips.init();
};

function showDiv() {
	document.getElementById("reDiv").style.display = "";
}

function test(value) {
	/*var data = new L5.Map();
	if (cxsjq != null) {
		data.put("cxsjq", cxsjq);
	}
	if (cxsjq != null) {
		data.put("cxsjz", cxsjz);
	}
	var xzqu = value.nextSibling.innerHTML;
	data.put("xzqu", xzqu);
	var url = "jsp/cams/bpt/query/statistics/query_YouFuTongJi.jsp";
	L5.forward(url, null, data);*/
	var xzqu = value.nextSibling.innerHTML;
	var parm="?xzqu="+xzqu+"&devType="+devType;
	if (cxsjq != null) {
		parm+="&cxsjq="+cxsjq;
	}
	if (cxsjz != null) {
		parm+="&cxsjz="+cxsjz;
	}
	var url = L5.webPath+"/jsp/cams/bpt/query/newdisabilitydevice/query_disabilityDevice.jsp"+parm;
	window.open(url);
}
function back() {
	history.go(-1);
}


function method(){//整个表格拷贝到EXCEL中 
	var tabs =document.getElementsByTagName("table");
	   var oXL = new ActiveXObject("Excel.Application"); 
	    //创建AX对象excel 
	var oWB = oXL.Workbooks.Add(); 
	   //获取workbook对象 
	         var oSheet = oWB.ActiveSheet; 
	         //oSheet.Cells(1,1).Value="heelo"; 
	         oSheet.Columns.ColumnWidth = 20; 
	     //激活当前sheet 
		 var p=1;
		 doLinkAll(false);
		 for(var i=0;i<tabs.length;i++){
			var sel = document.body.createTextRange(); 
			sel.moveToElementText(tabs[i]); 
			if(tabs[i].style.display!=''){
				continue;
			}
			//把表格中的内容移到TextRange中 
			sel.select(); 
			//全选TextRange中内容 
			sel.execCommand("Copy"); 
			
			/*if(i!=2){
				p=p+tabs[i-1].rows.length;
				oSheet.Range("A"+p).Select();
			}*/
			 //复制TextRange中内容 
			 
			// oSheet.Cells(0,13).Select();
		    oSheet.Paste(); 
			//粘贴到活动的EXCEL中     
			sel.collapse(true);
			sel.select();
		 }
		 doLinkAll(true);
	     oXL.Visible = true; 
	     //设置excel可见属性 
	}

function doLinkAll(action){ 
	var arr=document.getElementsByTagName("A") 
	for(var i=0;i <arr.length;i++){ 
		if (action){ //重新设置链接 
			if (arr[i].rel) 
				arr[i].setAttribute("href",arr[i].rel) 
		}else{ //取消所有链接 
			arr[i].setAttribute("rel",arr[i].href) 
			arr[i].removeAttribute("href") 
		} 
	} 
} 
 //打印预览调用方法
function printBill(){
	var printDataset=L5.DatasetMgr.lookup("ds");
	var url = L5.webPath+'/jsp/cams/bpt/query/print/disdevice.fr3'; 
	var reportName="全省革命伤残军人假肢用品配备情况";
	
	doReportPrint(reportName,currentUserName,organName,printDataset ,url);
}

function redirectQuery(obj,assDevicesType,configuration) {
	var  urlPage="query_disabilityDeviceList.jsp";
	var timeType="2";
	
	if(cxsjq != "") {
		timeType="1";
	} 
	var domicode = obj.parentNode.cells[0].firstChild.lastChild.innerHTML;
	var url = urlPage+"?autoQuery=true"+
	"&assDevicesType=" + assDevicesType + 
	"&timeType=" + timeType + "&cxsjz="+cxsjz+
	"&xzqh="+domicode+"&configuration="+configuration;
	if(timeType == "1") {
		url += "&cxsjq=" + cxsjq;
	}
	window.open(url);
}