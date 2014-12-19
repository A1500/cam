function init() {
	var userDS = L5.DatasetMgr.lookup("userDataset");
	var contactAddrDS = L5.DatasetMgr.lookup("contactAddrDs");
	contactAddrDS.setParameter("OWNER_ID",contactId);
	contactAddrDS.load(true);
	userDS.setParameter("USER_ID",contactId);
	userDS.load(true);
}
function changeDisplay(deliveryMode) {
	var deliveryModeDs = L5.DatasetMgr.lookup("deliveryModeDs");
	var deliveryName = "";
	var records = deliveryModeDs.getAllRecords();
	for(var i = 0;i< records.length;i++)
	{
		var record = records[i];
		if(deliveryMode==record.get("deliveryMode"))
		{
			deliveryName = record.get("deliveryName");
			break;
		}
	}
	return deliveryName;
}