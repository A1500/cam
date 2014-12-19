var photoId='';
function init(){
/**	var peoplePanel=L5.getCmp("peoplePanel");
	peoplePanel.collapse();
	peoplePanel.on('beforeexpand',loadPanel1);//打开人员panel时候加载数据
**/	
	loadFamilyDs();//加载家庭	
}
//加载家庭信息
function loadFamilyDs(){
    familyDataSet.setParameter("FAMILY_ID",familyId);
    familyDataSet.on("load",loadPanel1);
    familyDataSet.load();
}
//加载家庭成员基本信息
function loadPanel1(){
	peopleListDataSet.setParameter("FAMILY_ID",familyId);
    peopleListDataSet.on("load",loadAssistanceDs);
	peopleListDataSet.load();
}
//加载多选救助类型信息
function loadAssistanceDs(ds){
	ds.un("load",loadAssistanceDs);
	photoId=familyDataSet.get("photoId");
	showPhotoAbleEdit(photoId);//加载照片
   	AssistanceDataset.setParameter("FAMILY_ID",familyId);
    AssistanceDataset.on("load",loadHouseListDs);
	AssistanceDataset.load();
}
function loadHouseListDs(ds){
	houseListDataset.setParameter("FAMILY_ID",familyId);
	houseListDataset.load();
	houseListDataset.on('load',loadestateListDataset);
}
function loadestateListDataset(ds){
	ds.un("load",loadestateListDataset);
	estateListDataset.setParameter("FAMILY_ID",familyId);
	estateListDataset.load();
	estateListDataset.on('load',loadesupportListDataset);
}
function loadesupportListDataset(ds){
	ds.un("load",loadesupportListDataset);
	supportListDataset.setParameter("FAMILY_ID",familyId);
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
//查看人员详细信息
function peopleDetail(){
	var grid = L5.getCmp('peoplePanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var width = 1000;
	    var height = 600;
		var url="../application/city/apply/samBasePeopleDetail.jsp?familyId="+familyId+"&peopleId="+records[0].get('peopleId');
		window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
