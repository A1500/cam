function init() {
	var prssoldiersArmyDataset=L5.DatasetMgr.lookup("prssoldiersArmyDataset");
	prssoldiersArmyDataset.setParameter("SOLDIERS_ID",idField);
	prssoldiersArmyDataset.load();
	L5.QuickTips.init(); 
}
 function back()
 {	
 	history.go(-1);
 }