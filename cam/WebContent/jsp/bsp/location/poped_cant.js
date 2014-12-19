//选择行政区划
function chooseCant() {
	var record = cant_ds.getCurrent();
	if(record === undefined || record === null) {
		L5.MessageBox.alert(res.prompts,res.noselected);
		return;
	}
	window.returnValue = record.get('cantCode')+"="+record.get('cantName');
	window.close();
}
//取消选择的内容
function cancelChoose() {
	window.close();
}
//清除选择的内容
function clearChoosed() {
	window.returnValue = "=";
	window.close();
}