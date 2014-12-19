function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		ds.newRecord();
	}
	else if (method=="UPDATE"){
		ds.baseParams["EVALU_ID@="]=idField;
		ds.load();
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	L5.QuickTips.init(); 
}

function save(){
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	//校验
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}	
    var records = ds.getAllChangedRecords();
	var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmLevelEvalutionInfoCommand"); 
	command.setParameter("records",records);
	command.execute("save");	
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
		back();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
 function back()
 {	 	var url='jsp/cams/marry/dept/level/mrmlevelevalutioninfo_list.jsp';
		var text = '等级评定信息表';
		L5.forward(url,text);	 
 }

/**
* 登记机关jsp调用
*/
function func_djjg(){
var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/marry/dept/mrmRadioTree.jsp?organCode=370100000000&organName=山东省","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
if(revalue!=""&&revalue!=undefined){
var list = revalue.split(";");
 ds.getCurrent().set("deptId",list[0]);
 ds.getCurrent().set("deptName",list[1]);
 //document.getElementById("deptId").value=list[0];
 
}
} 

function getTimes(item) {
	LoushangDate(item.previousSibling);
}

