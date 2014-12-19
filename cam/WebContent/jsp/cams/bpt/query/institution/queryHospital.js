function init() {
	//var time = new Date();
	//var  times = time.format("Y");
	//var timeq = times+"-01-01";
	//var timez = times+"-12-31";
	//document.getElementById("cxsj_q").value=timeq;
	//document.getElementById("cxsj_z").value=timez;
	ds.on("load",showDiv);
    L5.QuickTips.init();
};



function query() {
	var year = _$("year");
	if (year == '') {
		L5.Msg.alert('提示', '查询年份不能为空！');
		return false;
	}
	//校验年份格式
	if(!( _isNum(year) && year.length==4 )){
		L5.Msg.alert("提示", "请输入正确的年份！");
		return;
	}
    ds.setParameter("year",year);
    ds.load();
    ds.on("load",function() {
    	var obj = document.getElementById("tablePension");
    
    	var rowArray = obj.rows;
    	var index = -1;
    	var testDr = document.getElementById("trPension");
    	var rowCount = rowArray.length;
    	for(var i=0;i<rowCount;i++ ) {
    		if(rowArray[i] == testDr) {
    			index = i;
    			break;
    		}
    	}
    	
    	if(index != -1 && index != (rowCount-1)) {
	    	obj.moveRow(index,rowCount-1);
		}
		meger();
    });
    noReclick(ds,"queryButton");  
}

function meger() {
	var startRow = 4;
	var megerCell = 0;
	var megerRow;
	var index = 0;
	var megObject;
	var megerValue = "";
	var table = document.getElementById("tablePension");
	var row = table.rows;
	
	megerValue = row[startRow].cells[megerCell].childNodes[0].value;
	megerRow = startRow;
	megObject	= row[startRow].cells[megerCell];
	for(var i=startRow+1;i<row.length;i++) {
			var cell = table.rows[i].cells;
			if(cell[megerCell].childNodes[0].value == megerValue) {
					index++;
			} else {
				if(index >0) {
					megObject.rowSpan=index+1;
					for(var j=1;j<=index;j++) {
						table.rows[j+megerRow].cells[megerCell].style.display="none";
					}
				}
				megerValue = cell[megerCell].childNodes[0].value;
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
	//setReportTitle();
	var length =ds.getCount();
	if(length==0) {
		ds.newRecord({"organ_name":"无信息","disability_num":0,"disability_mon":0,"disability_avg_mon":0,"dependant_country_num":0,"dependant_country_mon":0,"dependant_country_avg_mon":0,"dependant_town_num":0,"dependant_town_mon":0,"dependant_town_avg_mon":0});
	}
	document.getElementById("reDiv").style.display="";
}
function setReportTitle() {
	var reportTitleSpan = document.getElementById("reportTitle");
	var year = document.getElementById("cxsj_q").value.split("-")[0];
	if(year==''){
		reportTitleSpan.innerHTML =  "定期抚恤金发放情况";
	}else{
		reportTitleSpan.innerHTML = "定期抚恤金发放情况";
	}

}
function getChnNumber(code) {
	if(code==undefined||code=="") return;
	var codeArr = code.split("");
	var reStr = "";
	for(var i=0;i<codeArr.length;i++) {
		switch(codeArr[i]) {
			case '0': reStr += "零"; break;
			case '1': reStr += "一"; break;
			case '2': reStr += "二"; break;
			case '3': reStr += "三"; break;
			case '4': reStr += "四"; break;
			case '5': reStr += "五"; break;
			case '6': reStr += "六"; break;
			case '7': reStr += "七"; break;
			case '8': reStr += "八"; break;
			case '9': reStr += "九"; break;
			default: reStr += codeArr[i];
		}
	}
	return reStr;
}

function getTime(time){
	var  times = time.split("-");
	time = times[0]+"."+times[1];
	return time;
}

  function test(value) {
  	var cxsj_q = _$("cxsj_q");
	var cxsj_z = _$("cxsj_z");
  	var data = new L5.Map();
  	if(cxsj_q!=''){
		data.put("cxsjq", cxsj_q);
	}
	if(cxsj_z!=''){
	   	data.put("cxsjz",cxsj_z);
	}
	var xzqu = value.nextSibling.innerHTML;
  	data.put("xzqu",xzqu);
  	var url = "/jsp/cams/bpt/query/QueryCapitalPension/QueryCapitalPension_detail.jsp";
  	L5.forward(url,null,data);
 }
 //打印预览调用方法
function printBill(){
	var printDataset=L5.DatasetMgr.lookup("ds");
	var url = L5.webPath+'/jsp/cams/bpt/query/print/queryHospital.fr3'; 
	var reportName="优抚医院发展情况工作统计表";
	
	doReportPrint(reportName,currentUserName,organName,printDataset ,url);
}
function toExcel(){
	var dsExcel = L5.DatasetMgr.lookup("ds");
	if(dsExcel.getCount()<1){
		alert("没有数据导出");
		return ;
	}	
	L5.dataset2excel(dsExcel,"/jsp/cams/bpt/query/excel_export/queryHospitalEexcel.jsp");
}
