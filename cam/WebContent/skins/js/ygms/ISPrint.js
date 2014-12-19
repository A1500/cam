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

function getPrintDataByRecord(reportName,record){
	var xmlStr="<?xml version='1.0' encoding='GBK' standalone='no'?>";
	xmlStr+="<Report ReportName='"+reportName+"' Creater='省厅系统管理员' CreateOrgan='山东省公安厅' ReportNo='' ReportType=''>";
	xmlStr +="<Info>";
	L5.each(record.fields.items,function(item,index){
		xmlStr+="<"+item.name+">"+record.get(item.name)+"</"+item.name+">";
	    
	});
	xmlStr +="</Info>";
	xmlStr +="</Report>";
	return xmlStr;
}
//打印
function printReport(printData,RfrUrl){
	if(($('ISReport')==null)||($('ISReport')==undefined)){
		msg = "无法完成您指定的操作！\n\n" +
			  "    可能原因：没有安装组件，请参见相关说明解决！！\n" +
			  "    如果确认组件已经安装，请咨询系统管理人员解决！\n";
		alert(msg);
		return false;
	}
	$('ISReport').PrintValue= printData;
	$('ISReport').IfPreview = 1;		//设置打印是否预览。
	$('ISReport').RfrUrl = RfrUrl;
	var printFlag = $('ISReport').PrintComReport();  //调用打印。
	if(printFlag != 0){  //打印失败。
		alert("打印失败!" + $('ISReport').ErrorInfor);	//显示失败原因。
		return false;
	}else{
		return true;
	}
}