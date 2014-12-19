function init() {
		var PetitionDataset = L5.DatasetMgr.lookup("PetitionDataset");
		PetitionDataset.setParameter("BPT_PETITION.PEOPLE_ID@=",peopleId);
		PetitionDataset.load();
		var count = PetitionDataset.getCount();
		if(count==0){
			PetitionDataset.newRecord();
		}
		L5.QuickTips.init(); 
}
//窗口下载附件
function downLoad(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var filename = record.get("edocumentsName");
	var id = record.get("petitionId");
       var url0=paths[0]+'/'+paths[1]+"/download?table=bpt_petition&column=e_documents&pk=petition_id&filename=e_documents_name&petition_id='"+id+"'";
	return '<a id="download"  href='+url0+'>'+filename+'</a>';
}
function objectTypeRender(value,cellmeta,record,rowindex,colindex,dataset){
	var dataType=record.data['objectType'];
	if(dataType=="01")
		return "残疾军人";
	else if(dataType=="02")
		return "伤残国家机关工作人员";
	else if(dataType=="03")
		return "伤残人民警察";
	else if(dataType=="04")
		return "伤残民兵民工";
	else if(dataType=="05")
		return "烈士家属";
	else if(dataType=="06")
		return "因公牺牲军人家属";
	else if(dataType=="07")
		return "病故军人家属";
	else if(dataType=="08")
		return "在乡退伍红军老战士";
	else if(dataType=="09")
		return "在乡西路军红军老战士";
	else if(dataType=="10")
		return "红军失散人员";
	else if(dataType=="11")
		return "在乡复员军人";
	else if(dataType=="12")
		return "带病回乡复员军人";
	else if(dataType=="13")
		return "参战";
	else if(dataType=="14")
		return "参试";
	else
		return "";
}

