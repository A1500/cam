//点击导入银行帐号按钮
function accountImport(){
	var win = L5.getCmp("importExcelWin");
	win.show();
}

//点击导入Excel文件
function click_import(){
	var excelFile = document.getElementById("excelFile").value;
	if(!excelFile){
		L5.Msg.alert("提示","导入文件不能为空！");
		return;
	}else if(excelFile.lastIndexOf(".xls")==-1){
		L5.Msg.alert("提示","请导入Excel文件！");
		return;
	}
	var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamBankAccountCmd");
	command.setParameter("excelFile",excelFile);
	command.setForm("form_content");
	command.execute("importExcel");
	command.afterExecute=function(){
		if(!command.error){
			var erro = command.getReturn("erro");
			if(typeof(erro)=="undefined"){
				L5.Msg.alert("提示","导入成功!",function(){
					var win=L5.getCmp("importExcelWin");
					win.hide();
					query();
				});
			}else{
				L5.Msg.alert("提示",erro,{});
			}
		}else{
	        L5.Msg.alert("提示",(''+command.error).replace("出现系统异常",""),{});
        }
	}
}
//点击导入窗口关闭
function click_close(){
	var win = L5.getCmp("importExcelWin");
	win.hide();
}
function onLoad(){
    var url = L5.webPath + "/fileDownload?filePath=jsp/cams/drel/funds/bank/bankAccount.xls&fileName=bankAccount.xls&project=1";
    window.location = url;
}
//下载导出文件
function downLoadData(filePath) {
	if(!filePath){
		L5.Msg.alert("提示","未设定文件路径，请联系管理员！");
		return;
	}
	var fileName = filePath.substring(filePath.lastIndexOf('\\') + 1);
	var file = encodeURI(encodeURI(fileName));
	filePath=encodeURI(encodeURI(filePath));
	var url = L5.webPath + "/fileDownload?filePath=" + filePath + "&fileName="
			+ file;
	window.location.href = url;
}
