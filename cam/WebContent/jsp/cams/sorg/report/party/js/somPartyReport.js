function tableToExcel(tname) {
	  if(confirm('是否要导出到excel?')!=0)
	  { 
		   window.clipboardData.setData("Text",document.all(tname).outerHTML);
		   try
		   {
		    ExApp = new ActiveXObject("Excel.Application")
		    var ExWBk = ExApp.workbooks.add()
		    var ExWSh = ExWBk.worksheets(1)
		    ExApp.DisplayAlerts = false
		    ExApp.visible = true
		   }  
		   catch(e)
		   {
		    alert("导出没有成功！1.您的电脑没有安装Microsoft Excel软件!2.请设置Internet选项自定义级别，对没有标记安全级别的  ActiveX控件进行提示。")
		    return false
		   } 
		    ExWBk.worksheets(1).Paste;
	 }else
     { 
       return;
	 }
  	}
  	
 function nullToZero(str){
 	if(str == ""){
 		str = "0";
 	}
 	return str;
 }