function init() {
		L5.QuickTips.init(); 
}
var fa=true;//防止二次提交
function click_upload(){
	if(!fa){
		alert("正在导入Excel,请稍后!");
		return ;
	}
	fa=false;
	var msg="load";
	var file = document.getElementById("excel").value;
	if(file==null&&file==""){
		alert("请选择导入的Excel");
		fa=true;
		return;
	}
		
	var s=file.lastIndexOf(".");
	var filename=file.substring(s+1).toUpperCase();
	if(filename!="XLS"){
		alert("请选择正确的Excel");
		fa=true;
		return;
	}
	document.getElementById("msg").innerHTML="正在导入,请稍后...";
	var command=new L5.Command("com.inspur.cams.bpt.excelToTable.ExcelToTableCommand");
	command.setForm("form_content");
	command.setParameter("enumsPath",enumsPath);
	command.setParameter("xmlPath",xmlPath);
	command.setParameter("organCode",user);
	command.execute("execute");
	
	//包含有大字段的异常判断
	command.afterExecute=function(){
		if(!command.error){
			var msg =command.getReturn("msg");
			window.returnValue=msg;
			window.close();
		}
		else{
	        L5.Msg.alert("提示","出现系统异常，"+command.error);
        }
	}
	
}

/*function excelToTable(xmlPath,enumsPath){
	
	var familyId = selected[0].get('FAMILY_ID');
	var peopleId = selected[0].get('PEOPLE_ID');
	var applyId = selected[0].get('APPLY_ID');
	var url=L5.webPath+"/jsp/cams/bpt/flow/war/bptwar_edit.jsp?peopleId=" + peopleId + '&familyId=' + familyId+ '&applyId=' + applyId ;
	var width = screen.width-100;
   	var height = screen.height-140;
   	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if (win==null) {
		return;
	} 
	return win;
}*/



