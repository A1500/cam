function init() {
	if (batchDetailId != "" && batchDetailId != null) {
		hisDs.setParameter("BATCH_DETAIL_ID", batchDetailId);
		hisDs.setParameter("sort", "updateTime");
		hisDs.setParameter("dir", "desc");
		hisDs.load();
	}
}
// 渲染流程状态
// 0:未填报,1:未上报,2:已上报,3:已提交,5:复核上报,6:复核提交,9:已审批
// 2:上报需求,3:提交档案,5:审批驳回/复核后上报需求,6:复核后提交档案,9:审批同意
function receiveStatusRenderer(value, cellmeta, record, rowindex, colindex,
		dataset) {
	if (value == "2") {
		return "上报需求";
	} else if (value == "3") {
		return "提交档案";
	} else if (value == "5") {
		if (record.get("checkDate") != "")
			return "<font color=red>审批驳回</font>";
		else
			return "复核后上报需求";
	} else if (value == "6") {
		return "复核后提交档案";
	} else if (value == "9") {
		return "<font color=green>审批同意</font>";
	}
	return value;
}