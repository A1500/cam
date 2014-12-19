function init() {
	var keptPersonDs=L5.DatasetMgr.lookup("pocketApplyDetailDs");
	pocketApplyDetailDs.setParameter("gerocomiumId",gerocomiumId);
	pocketApplyDetailDs.setParameter("pocketYm",pocketYm);
	pocketApplyDetailDs.load();	
}
function query(){
	var pocketApplyDetailDs = L5.DatasetMgr.lookup("pocketApplyDetailDs");
	pocketApplyDetailDs.setParameter("gerocomiumId",gerocomiumId);
	pocketApplyDetailDs.setParameter("pocketYm",pocketYm);	
	pocketApplyDetailDs.setParameter("personName",getParam("personNameQuery"));	
	pocketApplyDetailDs.setParameter("idCard",getParam("idCardQuery"));
	pocketApplyDetailDs.setParameter("inRoom",getParam("inRoomQuery"));
	pocketApplyDetailDs.setParameter("inBed",getParam("inBedQuery"));		
	pocketApplyDetailDs.load();
}
function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
function returnBack(){
	window.close();
}