var familyId='';
var familyArchiveId='';
var photoId='';
function init(){
    familyTreatmentDataSet.setParameter("TREATMENT_ID",treatmentId);
    familyTreatmentDataSet.on("load",loadFamilyDs);//加载家庭	
    familyTreatmentDataSet.load();
}
//加载家庭信息
function loadFamilyDs(ds){
	ds.un("load",loadFamilyDs);
	familyId=ds.get("familyId");
	$('beginDate').innerHTML=ds.get('beginDate');
	$('cardNo').innerHTML=ds.get('cardNo');
	$('assistanceMode').innerHTML=getDicText(assistanceModeDataset,ds.get('assistanceMode'));
	$('assistanceMoney').innerHTML=ds.get('assistanceMoney');
	$('assistanceClassMoney').innerHTML=ds.get('assistanceClassMoney');
    familyDataSet.setParameter("APPLY_ID",applyId);
    familyDataSet.on("load",loadBank);
    familyDataSet.load();
}
function loadBank(ds){
	if(ds.getCount()>0){
		familyArchiveId=ds.get("familyArchiveId");
	}
	ds.un("load",loadBank);
	bankAccountDS.setParameter("FAMILY_ID",familyId);
    bankAccountDS.on("load",loadPeopleListDs);
    bankAccountDS.load();
}
//加载家庭成员基本信息
function loadPeopleListDs(ds){
	if(ds.getCount() == 0 ){
		bankAccountDS.newRecord();
	}
	ds.un("load",loadPeopleListDs);
	peopleListDataSet.setParameter("APPLY_ID",applyId);
    peopleListDataSet.on("load",loadSupportedPeopleDs);
	peopleListDataSet.load();
}
function loadSupportedPeopleDs(ds){
	ds.un("load",loadSupportedPeopleDs);
	photoId=familyDataSet.get("photoId");
	showPhotoAbleEdit(photoId);//加载照片
	
	var supportedPeopleDataSet = L5.DatasetMgr.lookup("supportedPeopleDataSet");
    supportedPeopleDataSet.setParameter("filterSql", "FAMILY_ARCHIVE_ID='" + familyArchiveId + "'");
    supportedPeopleDataSet.load();
    supportedPeopleDataSet.on("load",loadHouseListDs);
}
function loadHouseListDs(ds){
	ds.un("load",loadHouseListDs);    
	houseListDataset.setParameter("FAMILY_ARCHIVE_ID",familyArchiveId);
	houseListDataset.load();
	houseListDataset.on('load',loadestateListDataset);
}
function loadestateListDataset(ds){
	ds.un("load",loadestateListDataset);
	estateListDataset.setParameter("FAMILY_ARCHIVE_ID",familyArchiveId);
	estateListDataset.load();
	estateListDataset.on('load',loadesupportListDataset);
}
function loadesupportListDataset(ds){
	ds.un("load",loadesupportListDataset);
	supportListDataset.setParameter("FAMILY_ARCHIVE_ID",familyArchiveId);
	supportListDataset.load();
}
//关闭
function returnBack(){
	window.close();
}
function showPhotoAbleEdit(photoId){
	if(photoId){
		var src = rootPath+"download?table="+"COM_PHOTO"+"_"+photoId.substring(0,6)+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+photoId+"'";
		document.getElementById('img').src=src
	}else{
	}
}
//明细
function getName(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href=# onclick="peopleDetail(\''+record.get("PEOPLE_ID")+'\')">'+value+'</a>';
}
//查看特定人员的明细
function peopleDetail(peopleId){
	var width = 1000;
    var height = 600;
	var url="../comm/samCityResidentsPeopleDetail.jsp?peopleId="+peopleId+'&applyId='+applyId;
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
//字典表解析
function getDicText(dicDataSet,value){
	for (var i=0;i<dicDataSet.getTotalCount();i++){
		var record = dicDataSet.getAt(i);
		if(dicDataSet.getAt(i).get('value')==value){
			return record.get('text');
		}
	}
	return "";
}	
//赡扶抚养义务人员
function getSupportName(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:detailSupport(\''+record.get("supportId")+'\')">'+value+'</a>';
}
//查看赡扶抚养义务人员
function detailSupport(supportId){
	var width = 850;
    var height = 187;
	var url="../comm/supportDetail.jsp?familyId="+familyId+"&supportId="+supportId+"&assistanceType=01";
	window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}	