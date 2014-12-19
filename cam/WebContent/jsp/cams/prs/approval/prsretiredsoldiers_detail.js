function init() {	
	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	retiredSoldierDataset.baseParams["SOLDIERS_ID@="]=idField;
	retiredSoldierDataset.load();
	var prssoldiersArmyDataset=L5.DatasetMgr.lookup("prssoldiersArmyDataset");
	prssoldiersArmyDataset.baseParams["SOLDIERS_ID@="]=idField;
	prssoldiersArmyDataset.load();
	var prsawardsmeritoriousDataset=L5.DatasetMgr.lookup("prsawardsmeritoriousDataset");
	prsawardsmeritoriousDataset.baseParams["SOLDIERS_ID@="]=idField;
	prsawardsmeritoriousDataset.load();
	
}
function back()
 {	
 	history.go(-1);
 }
 
 
