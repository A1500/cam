/**
*
*/
function init(){
	var somPartyDS=L5.DatasetMgr.lookup("somPartyDS");
	somPartyDS.setParameter("SOM_PARTY.PARTY_ID@=",partyId);	
	somPartyDS.load();
	somPartyDS.on("load",queryMess);
}
function queryMess(somPartyDS){
	 var record=somPartyDS.getCurrent();
	var groupType=record.get("groupType");
	if(groupType==3){
		$("groupDescTr2").style.display="block";
	}
	var nobuildReason=record.get("nobuildReason");
	if(nobuildReason==3){
		$("instructorTr").style.display="block";
		$("instructorTr2").style.display="block";
	}	
	var organDataSet=L5.DatasetMgr.lookup("organDataSet");
	sorgId=somPartyDS.get('sorgId');
	organDataSet.setParameter("SORG_ID",somPartyDS.get('sorgId'));
	organDataSet.load();
	organDataSet.on('load',function(){
		$('sorgAdds').innerHTML=organDataSet.get('sorgAdds');
		$('sorgPhone').innerHTML=organDataSet.get('sorgPhone');
		$('practiceNum').innerHTML=organDataSet.get('practiceNum');
		$('borgName').value=organDataSet.get('borgName');
	});	
	somElectronicDataSet_load();	
}
/**
*返回党员列表
*/
function returnList(){
	var data=new L5.Map();
	var url="jsp/cams/sorg/manage/party/somPartyList.jsp";
	data.put("searchSorgName",encodeURIComponent(encodeURIComponent(searchSorgName)));
	data.put("searchSorgCode",encodeURIComponent(encodeURIComponent(searchSorgCode)));
	data.put("searchSorgType",encodeURIComponent(encodeURIComponent(searchSorgType)));
	data.put("partyId",partyId);
	L5.forward(url,'',data);
}
