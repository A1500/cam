function init(){
	var BptPeopleDisabilityDataSet= L5.DatasetMgr.lookup("BptPeopleDisabilityDataSet");
	BptPeopleDisabilityDataSet.setParameter("PEOPLE_ID",peopleId);
	BptPeopleDisabilityDataSet.load();
	
	L5.QuickTips.init();
	
}
function KoreaWar(k){

	if(k.value==3){
		document.getElementById("k1").style.display='';
		document.getElementById("k2").style.display='';
	}else{
		document.getElementById("k1").style.display='none';
		document.getElementById("k2").style.display='none';
	}
}