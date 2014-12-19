function init(){
	var samCheckDetailDataSet=L5.DatasetMgr.lookup("samCheckDetailDataSet");
	samCheckDetailDataSet.load();
	var samGeroDataSet=L5.DatasetMgr.lookup("samGeroDataSet");
	//samGeroDataSet.setParameter("filterSql","AREA_LEVEL_ID like '"+getOrganArea()+"%'");
	samGeroDataSet.load();
}
function query(){
	var samCheckDetailDataSet=L5.DatasetMgr.lookup("samCheckDetailDataSet");
	samCheckDetailDataSet.setParameter("gerocomiumId",document.getElementById("gerocomiumNameQuery").value);
	samCheckDetailDataSet.setParameter("checkDate",document.getElementById("checkDateQuery").value);
	samCheckDetailDataSet.setParameter("personName",document.getElementById("personNameQuery").value);
	samCheckDetailDataSet.setParameter("idCard",document.getElementById("idCardQuery").value);
	samCheckDetailDataSet.setParameter("inRoom",document.getElementById("inRoomQuery").value);
	samCheckDetailDataSet.setParameter("inBed",document.getElementById("inBedQuery").value);
	samCheckDetailDataSet.load();
}