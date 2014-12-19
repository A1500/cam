function init() {
		var RegularIdentificationDataset = L5.DatasetMgr.lookup("RegularIdentificationDataset");
		RegularIdentificationDataset.setParameter("PEOPLE_ID",peopleId);
		RegularIdentificationDataset.setParameter("OBJECT_TYPE",objectType);
		RegularIdentificationDataset.load();
		RegularIdentificationDataset.on("load",function(){
			var count = RegularIdentificationDataset.getCount();
			if(count==0){
				RegularIdentificationDataset.newRecord();
			}
		});
		L5.QuickTips.init(); 
};


