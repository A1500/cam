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
	
	batchTitleDs.on("load", function(){
		if (batchTitleDs.getCount() > 0) {
			var qrSumToolbar = L5.getCmp("qrSumToolbar");
			qrSumToolbar.setText(batchTitleDs.getAt(0).get("createOrgan")+" 下属单位分析汇总");
		}
	});
	batchTitleDs.setParameter("BATCH_ID", batchId);
	batchTitleDs.load();

	query();
	
	if(ifApprove=="T") {
		document.getElementById("btnReport").style.display = 'none';
	}
}
function query(){
	batchDetailds.setParameter("batchId", batchId);
	batchDetailds.setParameter("batchDetailId", batchDetailId);
	batchDetailds.setParameter("workflowStatus", '2,3,5,6,9,E');
	batchDetailds.load();
	
	batchDetailSumsds.setParameter("batchId", batchId);
	batchDetailSumsds.setParameter("batchDetailId", batchDetailId);
	batchDetailSumsds.setParameter("workflowStatus", '2,3,5,6,9,E');
	batchDetailSumsds.load();
}
function back() {
	window.close();
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
		document.getElementById("acceptAreaCode").value = list[0];
		document.getElementById("acceptAreaName").value = list[4];
		infoDs.set("acceptAreaCode", list[0]);
		infoDs.set("acceptAreaName", list[4]);
	}
}
//审核上报
function auditReport() {
	L5.Msg.wait("正在校验，请等待...", "校验数据");
	var ifNoReport = false; //是否存在未上报乡镇标志,默认无
	var reportIds = [];	//需上报明细批次的编码
	for (var i = 0; i < batchDetailSumsds.getCount(); i++) {
		if (batchDetailSumsds.getAt(i).get("IF_REPORT") == "0") {
			if (batchDetailSumsds.getAt(i).get("FILL_STATE") != "0"
					&& batchDetailSumsds.getAt(i).get("FILL_STATE") != "1") {
				ifNoReport = true;
				reportIds.push(batchDetailSumsds.getAt(i).get("BATCH_DETAIL_ID"));
			}
		}
	}
	if(!ifNoReport) {
		L5.Msg.alert('提示', "无未上报数据，不需要审核上报!");
		return false;
	}
	
	L5.Msg.confirm("提示", "是否审核上报？", function(isOk) {
		if (isOk == 'yes') {
			var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefBatchDetailCmd");
			command.setParameter("reportIds", reportIds);
			command.execute("auditReport");
			if (!command.error) {
				L5.Msg.alert('提示', '审核上报成功！', function() {
							query();
						});
			} else {
				L5.Msg.alert('提示', '审核上报出现错误！' + command.error);
			}
		}
	});
}
// 渲染填报状态
// 0:未填报,1:未上报,2:已上报,3:已提交,5:复核上报,6:复核提交,9:已审批
var pos = -1;
function fillStateRenderer(value, cellmeta, record, rowindex, colindex, dataset) {
	pos = fillstateDs.find("value", value, 0);
	if (record.get("IF_REPORT") == "0"||record.get("IF_REPORT")==null)
		return fillstateDs.getAt(pos).get("text") + "（<font color=red>否</font>）";
	else
		return fillstateDs.getAt(pos).get("text") + "（是）";
}
//导出Excel
function forExcel(){
	var dataset=L5.DatasetMgr.lookup("batchDetailSumsds");
	if(dataset.getCount()<=0){
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}	
	L5.dataset2excel(dataset, "/jsp/cams/dis/relief/sw/swApproveSumListExcel.jsp");
}