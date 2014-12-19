function init() {
	var AssistiveDevicesDataset = L5.DatasetMgr.lookup("AssistiveDevicesDataset");
	AssistiveDevicesDataset.setParameter("process_Id",processId);
	AssistiveDevicesDataset.load();
	L5.QuickTips.init(); 
}