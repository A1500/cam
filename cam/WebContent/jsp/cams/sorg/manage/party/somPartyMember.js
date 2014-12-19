/**
*
*/
function init(){
	var organDataSet=L5.DatasetMgr.lookup("organDataSet");
 	organDataSet.setParameter("SOM_ORGAN.SORG_ID@=",sorgId);
	organDataSet.load();
	organDataSet.on("load",queryOrganName);
	var somPartyMemberDS=L5.DatasetMgr.lookup("somPartyMemberDS");
	somPartyMemberDS.setParameter("SOM_PARTY_MEMBER.SORG_ID@=",sorgId);
	somPartyMemberDS.setParameter("SOM_PARTY_MEMBER.MEMBER_ID@=",memberId);	
	somPartyMemberDS.load();
	somPartyMemberDS.on("load",somPartyMemberDSLoad);

	var somPartyPraiseInsertDataSet=L5.DatasetMgr.lookup("somPartyPraiseInsertDataSet");
	somPartyPraiseInsertDataSet.setParameter('MEMBER_ID',memberId);
	somPartyPraiseInsertDataSet.setParameter('PRAISE_TYPE','M');//党建：P，党员：M
	somPartyPraiseInsertDataSet.load();
	
 	var dangyuan=$("dangyuanDiv");
 	var yubei=$("yubeiDiv");
 	var fazhan=$("fazhanDiv");
 	var jijifenzi=$("jijifenziDiv");
 	var shenqingren=$("shenqingrenDiv");
 	if(peopleType==5){
 		dangyuan.style.display="none";
 		yubei.style.display="none"; 
 		fazhan.style.display="none";
 		jijifenzi.style.display="none"; 
 		shenqingren.style.display="block";
 	}else if(peopleType==4){
 		dangyuan.style.display="none";
 		yubei.style.display="none"; 
 		fazhan.style.display="none";
 		jijifenzi.style.display="block"; 
 		shenqingren.style.display="none";
 	}else if(peopleType==3){
 		dangyuan.style.display="none";
 		yubei.style.display="none"; 
 		fazhan.style.display="block";
 		jijifenzi.style.display="none"; 
 		shenqingren.style.display="none";
 	}else if(peopleType==2){
 		dangyuan.style.display="none";
 		yubei.style.display="block"; 
 		fazhan.style.display="none";
 		jijifenzi.style.display="none"; 
 		shenqingren.style.display="none";
 	}else{	
 		dangyuan.style.display="block";
 		yubei.style.display="none"; 
 		fazhan.style.display="none";
 		jijifenzi.style.display="none"; 
 		shenqingren.style.display="none";
 	}
}
function somPartyMemberDSLoad(ds){
	//判断是否显示转入信息
	if(ds.get("inType") != ""){
		$("fullSystemInDiv").style.display="block";
	}
	//判断是否显示转出信息
	if(ds.get("outType") != ""){
		$("fullSystemOutDiv").style.display="block";
	}
}
function queryOrganName(organDataSet){
	if(organDataSet.getCount()==0){
		L5.Msg.alert("提示","此社会组织已经不存在了！");
		return;
	}else{
		var record=organDataSet.getCurrent();
//		$("sorgCode").innerText=record.get("sorgCode");
		$("sorgName").innerHTML=record.get("cnName");
		$("sorgType").value=record.get("sorgType");		
	}

}

/**
*返回党员列表
*/
function returnList(){
	var data=new L5.Map();
	var url="jsp/cams/sorg/manage/party/somPartyMemberList.jsp";
	data.put("searchSorgName",encodeURIComponent(encodeURIComponent(searchSorgName)));
	data.put("searchSorgCode",encodeURIComponent(encodeURIComponent(searchSorgCode)));
	data.put("searchSorgType",searchSorgType);
	data.put("sorgId",sorgId);
	L5.forward(url,'',data);
}
