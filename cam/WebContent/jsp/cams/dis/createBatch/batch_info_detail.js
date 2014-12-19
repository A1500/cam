function init() {
	var batchds= L5.DatasetMgr.lookup("batchds");
	batchds.setParameter("BATCH_ID",batchId);
	batchds.load();
	var batchDetailds= L5.DatasetMgr.lookup("batchDetailds");
	batchDetailds.setParameter("BATCH_ID",batchId);
	batchDetailds.load();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}




