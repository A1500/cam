// 完成组件初始化
function initCrjIssuedReport(){
	var sFileUpload = '\
	<div style="display:none">\
		<OBJECT\
		  classid="clsid:5F3F8089-770F-4482-9139-53B8F577942E"\
		  codebase="'+L5.webPath+'/jsp/dll/CrjIssuedReport.cab#version=2,0,1,0"\
		  width=239\
		  height=90\
		  align=center\
		  hspace=0\
		  vspace=0\
		  id="ISReport"\
		>\
		</OBJECT>\
	</div>\
	';
	document.write(sFileUpload);
}
initCrjIssuedReport();

function getPrintDataByRecord(reportName,creater,createOrgan,record){
	var xmlStr="<?xml version='1.0' encoding='GBK' standalone='no'?>";
	xmlStr+="<Report ReportName='"+reportName+"' Creater='"+creater+"' CreateOrgan='"+createOrgan+"' ReportNo='' ReportType=''>";
	xmlStr +="<Info>";
	L5.each(record.fields.items,function(item,index){
		xmlStr+="<"+item.name+">"+record.get(item.name)+"</"+item.name+">";
	    
	});
	xmlStr +="</Info>";
	xmlStr +="</Report>";
	return xmlStr;
}
function getPrintDataByRecords(reportName,ReportNo,creater,createOrgan,records){
	var xmlStr="<?xml version='1.0' encoding='GBK' standalone='no'?>";
	xmlStr+="<Report ReportName='"+reportName+"' Creater='"+creater+"' CreateOrgan='"+createOrgan+"' ReportNo='"+ReportNo+"' ReportType=''>";
	for(i=0;i<records.length;i++){
		xmlStr +="<Info>";
		L5.each(records[i].fields.items,function(item,index){
			xmlStr+="<"+item.name+">"+records[i].get(item.name)+"</"+item.name+">";
		    
		});
		xmlStr +="</Info>";
	}
	xmlStr +="</Report>";
	return xmlStr;
}
//通过map获得打印数据源
function getPrintDataByMap(reportName,map){
	var xmlStr="<?xml version='1.0' encoding='GBK' standalone='no'?>";
	xmlStr+="<Report ReportName='申办材料补正通知书'>";
	xmlStr +="<Info>";
	for(var i in map.map){
		xmlStr+="<"+i+">"+map.map[i]+"</"+i+">";  
	}
	xmlStr +="</Info>";
	xmlStr +="</Report>";
	return xmlStr;
}
//打印
function printReport(printData,RfrUrl){
	if((document.getElementById('ISReport')==null)||(document.getElementById('ISReport')==undefined)){
		msg = "无法完成您指定的操作！\n\n" +
			  "    可能原因：没有安装组件，请参见相关说明解决！！\n" +
			  "    如果确认组件已经安装，请咨询系统管理人员解决！\n";
		return false;
	}
	document.getElementById('ISReport').PrintValue= printData;
	document.getElementById('ISReport').IfPreview = 1;		//设置打印是否预览。
	document.getElementById('ISReport').RfrUrl = RfrUrl;
	var printFlag = document.getElementById('ISReport').PrintComReport();  //调用打印。
	if(printFlag != 0){  //打印失败。
		alert("打印失败!" + document.getElementById('ISReport').ErrorInfor);	//显示失败原因。
		return false;
	}else{
		return true;
	}
}
//日期格式转院yyyy-mm-dd hh:mm:ss转换成yyyy年mm月-dd日
function dataFormatForChange(date){
	if(date.length > 10){
		date=date.slice(0,10);
	}
	return date.substring(0,date.indexOf("-"))+"年"+date.substring(date.indexOf("-")+1,date.lastIndexOf("-"))+"月"+date.substring(date.lastIndexOf("-")+1,date.length)+"日";
}