function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}

//小数点位数处理
function checkAssMon(domId){
	if(document.getElementById(domId).value){
		if(!isFloat(document.getElementById(domId).value)){
			document.getElementById(domId).value="";
			L5.Msg.alert("提示","请输入数字");
			return;
		}
		document.getElementById(domId).value=changeTwoDecimal(document.getElementById(domId).value);
	}
}
//校验数字
function checkNum(domId){
	if(document.getElementById(domId).value){
		if(!_isNum(document.getElementById(domId).value)){
			document.getElementById(domId).value="";
			L5.Msg.alert("提示","请输入数字");
			return;
		}
	}
}

//渲染物资类型
function meterialTypeRenderer(value, cellmeta, record, rowindex, colindex,
		dataset) {
	var pos = dmDisMaterialTypeDs.find("code", value, 0);
	if(pos != -1) {
		var rec = dmDisMaterialTypeDs.getAt(pos);
		record.set("meterialUnit", rec.get("unit"));
		return rec.get("name");
	}
	return "";
}
// 渲染资金用途
function upAllocationPurposeRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	var str = " ";
	for (var i = 0; i < disAllocationPurposeDs.getCount(); i++) {
		if (value.indexOf(disAllocationPurposeDs.getAt(i).get("value")) != -1) {
			str += disAllocationPurposeDs.getAt(i).get("text") + ",";
		}
	}
	return str.substring(0, str.length - 1);
}

//渲染源资金总额
 function amountTotalRenderer(value, cellmeta, record,
		rowindex, colindex,
		dataset) {
	return formatMoneyForDis(record.get("amountTotal")) + "(" + formatMoneyForDis(record.get("amount")) + "+"
			+ formatMoneyForDis(record.get("meterial")) + ")";
}


var pattern=/^\d\.\d$/;  
function isMoney(s) {
	if (!pattern.exec(s))
		return false;
	return true;
}  


