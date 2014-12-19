function init() {
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

	batchDetailds.setParameter("requiredOrganCode", organCode);
	batchDetailds.setParameter("OR@FILL_STATE@=", '0,1,4,3,2');
	batchDetailds.load();

	batchDetailDoleds.setParameter("organCode", organCode);
	batchDetailDoleds.setParameter("OR@FILL_STATE@=", '3,5');
	batchDetailDoleds.load();
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
// 渲染是否确认
function inConfirmRenderer(value, cellmeta, record, rowindex, colindex, dataset) {
	if (value == "1")
		return "是";
	else if (value == "0")
		return "<font color=red>否</font>";

	return value;
}
// 渲染填报状态
// 0:未申请,1:正在申请,2:已审核,3:已审批,4:待复核,5:发放结束
var pos = -1;
function fillStateRenderer(value, cellmeta, record,
		rowindex, colindex, dataset) {
	pos = fillstateDs.find("value",value,0);
	if(value=="0")
		return "<font color=green>"+fillstateDs.getAt(pos).get("text")+"</font>";
	else if(value=="1")
		return "<font color=blue>"+fillstateDs.getAt(pos).get("text")+"</font>";
	else if(value=="4")
		return "<font color=red>"+fillstateDs.getAt(pos).get("text")+"</font>";
	return fillstateDs.getAt(pos).get("text");
}
//渲染填报状态
//0:未申请,1:正在申请,2:已审核,3:已审批,4:待复核,5:发放结束
function fillStateRenderer2(value, cellmeta, record,
		rowindex, colindex, dataset) {
	pos = fillstateDs.find("value",value,0);
	if(value=="3")
		return "<font color=red>"+fillstateDs.getAt(pos).get("text")+"</font>";
	return fillstateDs.getAt(pos).get("text");
}