function init(){
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	samGerocomiumInfoDataSet.setParameter("GEROCOMIUM_ID@=",gerocomiumId);
	samGerocomiumInfoDataSet.load();
}
function query(){
	var samGerocomiumInfoDataSet=L5.DatasetMgr.lookup("samGerocomiumInfoDataSet");
	var gerocomiumName=document.getElementById("gerocomiumName").value;
	var establishDate=document.getElementById("establishDate").value;
	var legelPeople=document.getElementById("legelPeople").value;
	samGerocomiumInfoDataSet.setParameter("GEROCOMIUM_ID@=",gerocomiumId);
	samGerocomiumInfoDataSet.setParameter("GEROCOMIUM_NAME@=",gerocomiumName);
	samGerocomiumInfoDataSet.setParameter("ESTABLISH_DATE@=",establishDate);
	samGerocomiumInfoDataSet.setParameter("LEGEL_PEOPLE@=",legelPeople);
	samGerocomiumInfoDataSet.load();
}