var NDate = L5.server.getSysDate();
function init() {
	var disDetailBatchSourceDs = L5.DatasetMgr.lookup("disDetailBatchSourceDs");
	var disReliefDoleMeteDetailDs = L5.DatasetMgr.lookup("disReliefDoleMeteDetailDs");
		infoDs.on('load', function() {
			if(infoDs.getCount()>0) {
				hideYh(infoDs.getAt(0).get("allocationType"));
			}
		});
		infoDs.setParameter("INFO_ID", infoId);
		infoDs.load();
		disDetailBatchSourceDs.setParameter("allocationStatus", "0");
	disDetailBatchSourceDs.setParameter("receiveOrganCode", organCode);
	disDetailBatchSourceDs.load(true);
	for(var i=0;i<disDetailBatchSourceDs.getCount();i++){
		disReliefDoleMeteDetailDs.setParameter("INFO_ID", infoId);
	 	disReliefDoleMeteDetailDs.setParameter("METERIAL_TYPE", disDetailBatchSourceDs.getAt(i).get("meterialType"));
	 	disReliefDoleMeteDetailDs.load(true);
	 	if (disReliefDoleMeteDetailDs.getCount() > 0) {
		disDetailBatchSourceDs.getAt(i).set("meterialNumPay",disReliefDoleMeteDetailDs.getAt(0).get("meterialNum"));
	 	}
	}
	var doleDetailDs = L5.DatasetMgr.lookup("doleDetailDs");
	doleDetailDs.newRecord({
					"detailId" : uu32,
					"doleId" : uu321,
					"infoId" : infoId,
					"doleType" : "2"
				});
}
function back() {
	window.close();
}
// 隐藏银行信息
function hideYh(at) {
	if (at == "0") {
		document.getElementById("yhTr").style.display = 'none';
		document.getElementById("yhTr2").style.display = 'none';
	}
}
// 渲染物资类型
function meterialTypeRenderer(value, cellmeta, record, rowindex, colindex,
		dataset) {
	var pos = dmDisMaterialTypeDs.find("code", value, 0);
	if (pos != -1) {
		var rec = dmDisMaterialTypeDs.getAt(pos);
		record.set("meterialUnit", rec.get("unit"));
		return rec.get("name");
	}
	return "";
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
function save(){
	var disDetailBatchSourceDs = L5.DatasetMgr.lookup("disDetailBatchSourceDs");
	disDetailBatchSourceRec=disDetailBatchSourceDs.getAllRecords();
	for(var i=0;i<disDetailBatchSourceRec.length;i++){
		if(disDetailBatchSourceRec[i].get('meterialNumPay')==""||disDetailBatchSourceRec[i].get('meterialNumPay')==null){
			L5.Msg.alert("提示","实际使用数量不能为空！");
			return false;
		}
	}
	var doleDetailDs = L5.DatasetMgr.lookup("doleDetailDs");
	doleDetailRec=doleDetailDs.getCurrent();
	L5.MessageBox.confirm('确定', '确定要保存该记录吗?', function(state) {
		if (state == "yes") {
		var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefInfoCmd"); 
		command.setParameter("records1", disDetailBatchSourceRec);
		command.setParameter("record2", doleDetailRec);
		command.setParameter("batchId", batchId);
		command.setParameter("batchDetailId", batchDetailId);
		command.execute("saveDoleGoods");
		if (!command.error) {
			L5.Msg.alert('提示', "保存成功！", function(){
				init();
			});
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		} else {
				return false;
			}
		});
}