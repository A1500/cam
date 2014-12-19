function init(){
	query();
}
function query() {
	var disFundsBatchDs = L5.DatasetMgr.lookup("disFundsBatchDs");
	disFundsBatchDs.setParameter("SOURCE_TYPE", "0");
	disFundsBatchDs.setParameter("FILL_ORGAN_CODE", organCode);
	disFundsBatchDs.load();
	
	var disDetailBatchDs = L5.DatasetMgr.lookup("disDetailBatchDs");
	disDetailBatchDs.setParameter("SOURCE_TYPE", "0");
	disDetailBatchDs.setParameter("FILL_ORGAN_CODE", organCode);
	disDetailBatchDs.load();
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
//渲染是否确认
function inConfirmRenderer(value, cellmeta, record,
		rowindex, colindex, dataset) {
	if(value=="1")
		return "是";
	else if(value=="0")
		return "<font color=red>否</font>";
	
	return value;
}