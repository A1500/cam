function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		var record=ds.newRecord();
		var nowDate = new Date();
		document.getElementById("ndYear").value = nowDate.getYear();//年度默认当前年度
		record.set("ndYear",nowDate.getYear());
		document.getElementById("ksqs").value = 1;//期数默认为1期
		record.set("ksqs",1);
		record.set("ksSign",1);//1:颁证员
		record.set("ksYn","02");//默认关闭
	}
	else if (method=="UPDATE"){
		ds.baseParams["KSAP_ID@="]=idField;
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
	if(document.getElementById("ndYear").value == ''){
		L5.Msg.alert('提示',"年度不能为空!");
		return false;
	}	
	if(document.getElementById("ksqs").value == ''){
		L5.Msg.alert('提示',"考试期数不能为空!");
		return false;
	}
	if(document.getElementById("ksbeginTime").value == ''){
		L5.Msg.alert('提示',"考试时间不能为空!");
		return false;
	}
	//if(document.getElementById("ksendTime").value == ''){
	//	L5.Msg.alert('提示',"结束考试时间不能为空!");
	//	return false;
	//}
	//if(document.getElementById("ksbeginTime").value > document.getElementById("ksendTime").value){
	//	L5.Msg.alert("提示","结束考试时间必须大于等于开始考试时间");
	//	return false;
	//}
	var record = ds.getCurrent();
	var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmExamScheduleCommand"); 
	command.setParameter("record",record);
	
	if(record.get("ksapId") != ''){
		command.execute("update");
	}else{
		command.execute("insert");
	}	
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
		back();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function startEnd(){
	var ksbegin = document.getElementById("ksbeginTime").value;
	var ksend = document.getElementById("ksendTime").value;
	if(ksbegin > ksend){
		L5.Msg.alert("提示","结束考试时间必须大于等于开始考试时间");
		return false;
	}
}
 function back()
 {	 	var url='jsp/cams/marry/person/mrmexamschedulebzy_list.jsp';
		var text = '登记员资格考试安排表';
		L5.forward(url,text);	 
 }



