/**
 * 初始化
 */
function init(){
	disFundsSourceDs.setParameter("SOURCE_ID",sourceId);
	disFundsSourceDs.on('load',function(){
		if(disFundsSourceDs.getCount()>0) {
			var rec = disFundsSourceDs.getAt(0);
			document.getElementById("amount").innerHTML = formatMoneyForDis(rec.get("amount"));
			document.getElementById("meterial").innerHTML = formatMoneyForDis(rec.get("meterial"));
			document.getElementById("amountTotal").innerHTML = formatMoneyForDis(rec.get("amountTotal"));
		}
	});
	disFundsSourceDs.load();
	disFundsSourceDetailDs.setParameter("SOURCE_ID",sourceId);
	disFundsSourceDetailDs.load();
};

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