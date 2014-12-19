function init(){
	var panel = L5.getCmp("panel");
	panel.setTitle(organName+" 救灾资金状况");
	
	var disCurrentMoneyDs=L5.DatasetMgr.lookup("disCurrentMoneyDs");
	disCurrentMoneyDs.setParameter("ORGAN_CODE", organCode);
	disCurrentMoneyDs.on('load',function(){
		var disCurrentMoneyDs=L5.DatasetMgr.lookup("disCurrentMoneyDs");
		if(disCurrentMoneyDs.getCount()>0) {
			var disCurrentMoneyDetailDs=L5.DatasetMgr.lookup("disCurrentMoneyDetailDs");
			disCurrentMoneyDetailDs.setParameter("RECORD_ID", disCurrentMoneyDs.getAt(0).get("recordId"));
			disCurrentMoneyDetailDs.setParameter("METERIAL_NUM@>", 0);
			disCurrentMoneyDetailDs.load();
		}else {
			disCurrentMoneyDs.newRecord({"currentMoney":0.00,"currentMeterial":0.00});		
		}
	});
	disCurrentMoneyDs.load();
}