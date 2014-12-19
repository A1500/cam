
function init(){
	var objectValueDataset = L5.DatasetMgr.lookup("objectValueDataset");
	//var command = new L5.Command("org.loushang.bsp.permit.pap.user.cmd.UserQueryCommand");
	//objectValueDataset.setParameter("dataTypeRecord", dataType);
	 objectValueDataset.setParameter("dataType", dataType);
	  //command.setParameter("dataTypeRecord",dataType);
	  //command.execute("getObjectValue");
    objectValueDataset.load();
	}
function confirmValue(){
	var record = L5.DatasetMgr.lookup("objectValueDataset").getCurrent();
	var ret = record.get("selCol") + ";" + record.get("dispCol");
	window.returnValue = ret;
	window.close();
}

function closeDig(){
	window.returnValue="";
	window.close();
}