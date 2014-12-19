var NDate = L5.server.getSysDate();
function init() {
	batchDetailTitleds.on("load", function(){
		if (batchDetailTitleds.getCount() > 0) {
			var qrToolbar = L5.getCmp("qrToolbar");
			qrToolbar.setText(batchDetailTitleds.getAt(0).get("requiredOrganName")+" 分析汇总");
		}
	});
	batchDetailTitleds.setParameter("BATCH_DETAIL_ID", batchDetailId);
	batchDetailTitleds.load();
	
	query();
}
function query(){
	batchDetailds.setParameter("batchId", batchId);
	batchDetailds.setParameter("batchDetailId", batchDetailId);
	batchDetailds.setParameter("workflowStatus", '2,3,5,6,9,E');
	batchDetailds.load();
}
function back() {
	window.close();
}
