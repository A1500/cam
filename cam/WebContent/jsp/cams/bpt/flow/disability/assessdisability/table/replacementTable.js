var docPath;
var method;
var queryData;
function init() { // 跳转打印页面
	var url="../../../../../comm/print/jspcommonprint.jsp?";
	
	var text='残疾军人换证呈报表';
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}

