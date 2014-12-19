var num1;
var num2;
var charges=[];
function init() {
	if (batchDetailId != "" && batchDetailId != null) {
		infoDs.setParameter("BATCH_DETAIL_ID", batchDetailId);
		infoDs.load();
		infoDs.on('load', function() {
			if(infoDs.getCount()>0) {
				
				for(var i=0;i<infoDs.getCount();i++){
					infoDs.getAt(i).set("account",charges[i]);
				}
			}
		});
	}
}
window.onbeforeunload=function(){ 
         var parent=window.dialogArguments;
          var reliefDoleds=parent.reliefDoleds;
          reliefDoleds.reload();
}
function query() {
	infoDs.setParameter("BATCH_DETAIL_ID", batchDetailId);
	//infoDs.setParameter("NAME@rlike", getParam("qName"));
	infoDs.setParameter("ACCEPT_AREA_CODE", getParam("qAcceptAreaCode"));
	infoDs.load();
}
//保存
function save() {
	var records=infoDs.getAllRecords();
	for(var i=0;i<records.length;i++){
		if(records[i].get('account')==""||records[i].get('account')==null){
			L5.Msg.alert("提示","实际发放金额不能为空！");
			return false;
		}
		charges[i]=records[i].get("account");
	}
	if(num1<num2){
		L5.Msg.alert("提示","实际发放金额不能大于抚慰金数额!");
		return;
	}
	L5.MessageBox.confirm('确定', '确定要保存该记录吗?', function(state) {
	if (state == "yes") {
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefInfoCmd"); 
	command.setParameter("records", infoDs.getAllRecords());// 业务信息
	command.setParameter("inConfirm", "0");//是否确认
	command.execute("saveReDole");
	if (!command.error) {
		L5.Msg.alert('提示', "保存成功！", function(){
			query();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	} else {
			return false;
		}
	});
}
//确认
function confirm() {
	var records=infoDs.getAllRecords();
	for(var i=0;i<records.length;i++){
		if(records[i].get('account')==""||records[i].get('account')==null){
			L5.Msg.alert("提示","实际发放金额不能为空！");
			return false;
		}
		charges[i]=records[i].get("account");
	}
	if(num1<num2){
		L5.Msg.alert("提示","实际发放金额不能大于抚慰金数额!");
		return;
	}
	L5.MessageBox.confirm('确定', '确定要确认上报该记录吗?', function(state) {
	if (state == "yes") {
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefInfoCmd"); 
	command.setParameter("records", infoDs.getAllRecords());// 业务信息
	command.setParameter("inConfirm", "1");//是否确认
	command.execute("saveReDole");
	if (!command.error) {
		L5.Msg.alert('提示', "确认成功！", function(){
			query();
		});
	}else{
		L5.Msg.alert('提示',"确认时出现错误！"+command.error);
	}
	} else {
			return false;
		}
	});
}
// 选择住址行政区划窗口
function forOrganSelect() {
	var revalue = window.showModalDialog(L5.webPath
					+ "/jsp/cams/dis/comm/dicCity.jsp?organCode=" + organCode
					+ "&organName=" + escape(encodeURIComponent(organName))
					+ "&radioType=radiobox&level=4", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("qAcceptAreaCode").value = list[0];
		document.getElementById("qAcceptAreaName").value = list[4];
	}
}
function forExcel(){
	
}
function countNum1(value){
	num1=value;
	return value;
}
function countNum2(value){
	num2=value;
	return value;
}