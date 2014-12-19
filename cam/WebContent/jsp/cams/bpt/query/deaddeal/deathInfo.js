function init(){
	var fisFuneralDeadInfoDS2 = L5.DatasetMgr.lookup("fisFuneralDeadInfoDS2");
	fisFuneralDeadInfoDS2.setParameter("deadId",deadId);
	fisFuneralDeadInfoDS2.load();
	var fisFuneralDeadInfoDS3 = L5.DatasetMgr.lookup("fisFuneralDeadInfoDS3");
	fisFuneralDeadInfoDS3.setParameter("deadId",' ');
	fisFuneralDeadInfoDS3.load();
}