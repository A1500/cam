function init() {
L5.Ajax.timeout=3000000;
	var time = new Date();
	var times = time.format("Y");
	var timeq = times+"-01-01";
	var timez = times+"-12-31";
	document.getElementById("timeType").value ='2';
	document.getElementById("cxsj_qs").value=timeq;
	document.getElementById("cxsj_zs").value=timez;
	document.getElementById("cxsj_z").value=timez;
	ds.setParameter("xzqu", organCode);
	ds.on('load', showDiv);
	L5.QuickTips.init();
};
function set(){
	var time = new Date();
	var  times = time.format("Y");
	var timeq = times+"-01-01"
	document.getElementById("cxsj_qs").value=timeq;
	document.getElementById("cxsj_zs").value=time;
	document.getElementById("cxsj_z").value=time;
	document.getElementById("timeType").value ='2';
	document.getElementById("times").style.display = "none";
	document.getElementById("time").style.display = "";
}

function showDiv() {
	document.getElementById("reDiv").style.display = "";
}
function setReportTitle() {
	var reportTitleSpan = document.getElementById("reportTitle");
	var year1 = document.getElementById("cxsj_q").value.split("-")[0];
	var year2 = document.getElementById("cxsj_z").value.split("-")[0];
	if (year1 ==year2) {
		reportTitleSpan.innerHTML = getChnNumber(year1) + "年全省革命伤残军人假肢用品配备情况表";
	}else{
		reportTitleSpan.innerHTML =getChnNumber(year1)+"--"+getChnNumber(year2)+ "全省革命伤残军人假肢用品配备情况表";
	}
}

function getChnNumber(code) {
	if (code == undefined || code == "")
		return;
	var codeArr = code.split("");
	var reStr = "";
	for (var i = 0; i < codeArr.length; i++) {
		switch (codeArr[i]) {
			case '0' :
				reStr += "零";
				break;
			case '1' :
				reStr += "一";
				break;
			case '2' :
				reStr += "二";
				break;
			case '3' :
				reStr += "三";
				break;
			case '4' :
				reStr += "四";
				break;
			case '5' :
				reStr += "五";
				break;
			case '6' :
				reStr += "六";
				break;
			case '7' :
				reStr += "七";
				break;
			case '8' :
				reStr += "八";
				break;
			case '9' :
				reStr += "九";
				break;
			default :
				reStr += codeArr[i];
		}
	}
	return reStr;
}

function showTime() {
	var type = document.getElementById("timeType").value;
	if(type == '1'){
		document.getElementById("times").style.display ="";
		document.getElementById("time").style.display ="none";
	}else{
		document.getElementById("times").style.display ="none";
		document.getElementById("time").style.display ="";
	}
}

function query() {
	var type = document.getElementById("timeType").value;
	var devType = document.getElementById("devType").value;
	timeType = type;
	var cxsj_q;
	var cxsj_z;
	if(type=='1'){
		cxsj_q = _$("cxsj_qs");
		cxsj_z = _$("cxsj_zs")
		if (cxsj_q == '') {
			L5.Msg.alert('提示', '查询起始时间不能为空！');
			return false;
		}
		if(cxsj_q!=''&&!validateDateFormat(cxsj_q)){
			L5.Msg.alert("提示","查询起始时间格式不正确！");
			return false;
		}
		if (cxsj_z == '') {
			L5.Msg.alert('提示', '查询结束时间不能为空！');
			return false;
		}
		if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
			L5.Msg.alert("提示","查询结束时间格式不正确！");
			return false;
		}
	}else{
		cxsj_q ="";
		cxsj_z = _$("cxsj_z")
		if (cxsj_z == '') {
			L5.Msg.alert('提示', '审批截止时间不能为空！');
			return false;
		}
		if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
			L5.Msg.alert("提示","审批截止时间格式不正确！");
			return false;
		}
		
	}
	ds.setParameter("cxsjq", cxsj_q);
	ds.setParameter("cxsjz",cxsj_z);
	ds.setParameter("xzqu", organCode);
	ds.setParameter("qxlb", devType);
	ds.load();
	noReclick(ds,"queryButton"); 
}

function test(value) {
	var data = new L5.Map();
var type = document.getElementById("timeType").value;
var devType = document.getElementById("devType").value;
	var cxsj_q;
	var cxsj_z;
	
	if(type=='1'){
		cxsj_q = _$("cxsj_qs");
		cxsj_z = _$("cxsj_zs")
		if (cxsj_q == '') {
			L5.Msg.alert('提示', '查询起始时间不能为空！');
			return false;
		}
		if(cxsj_q!=''&&!validateDateFormat(cxsj_q)){
			L5.Msg.alert("提示","查询起始时间格式不正确！");
			return false;
		}
		if (cxsj_z == '') {
			L5.Msg.alert('提示', '查询结束时间不能为空！');
			return false;
		}
		if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
			L5.Msg.alert("提示","查询结束时间格式不正确！");
			return false;
		}
	}else{
		cxsj_q ="";
		cxsj_z = _$("cxsj_z")
		if (cxsj_z == '') {
			L5.Msg.alert('提示', '审批截止时间不能为空！');
			return false;
		}
		if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
			L5.Msg.alert("提示","审批截止时间格式不正确！");
			return false;
		}
		
	}
	/*data.put("cxsjq",cxsj_q);
	data.put("cxsjz",cxsj_z);
	var xzqu = value.nextSibling.innerHTML;
	data.put("xzqu", xzqu);
	var url = "jsp/cams/bpt/query/statistics/query_YouFuTongJi.jsp";
	L5.forward(url, null, data);*/
	var xzqu = value.nextSibling.innerHTML;
	var parm="?xzqu="+xzqu+"&devType="+devType;
	if (cxsj_q != null) {
		parm+="&cxsjq="+cxsj_q;
	}
	if (cxsj_z != null) {
		parm+="&cxsjz="+cxsj_z;
	}
	
	var url = L5.webPath+"/jsp/cams/bpt/query/newdisabilitydevice/query_disabilityDevice.jsp"+parm;
	window.open(url);
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
	var startTimeId = "cxsj_qs"; //默认起始时间id
	var endTimeId = "cxsj_zs";//  默认终止时间id
	var endTime_z = "cxsj_z";//默认截止时间id
	var timeType="2"; //默认批准时间方式为截止时间
	var endTime="";
	var startTime="";
	//if(!queryPage) { // 非二级页面，截止时间或开始时间从页面id获取，若为二级页面，则时间为从前台传入
	timeType=document.getElementById("timeType").value;
		if(timeType == "1") {
			if(startTimeId != null && startTimeId != "") {
				startTime = document.getElementById(startTimeId).value;
			}
			if(endTimeId != null && endTimeId != "") {
				endTime = document.getElementById(endTimeId).value;
			}
		} else if(timeType == "2") {
			if(endTime_z != null && endTime_z != "") {
				endTime = document.getElementById(endTime_z).value;
			}
		}
	//}	
	var domicode = obj.parentNode.cells[0].firstChild.lastChild.innerText;
	var url = urlPage+"?autoQuery=true"+
	"&assDevicesType=" + assDevicesType + 
	"&timeType=" + timeType + "&cxsjz="+endTime+
	"&xzqh="+domicode+"&configuration="+configuration;
	if(timeType == "1") {
		url += "&cxsjq=" + startTime;
	}
	window.open(url);
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
		 for(var i=1;i<tabs.length;i++){
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
function loadpanel(o){
	var data = new L5.Map();
	data.put("devType",o.value);
	var url='jsp/cams/bpt/query/newdisabilitydevice/page_disabilityDevice.jsp';
	var text = '';
	L5.forward(url,text,data);
	
}