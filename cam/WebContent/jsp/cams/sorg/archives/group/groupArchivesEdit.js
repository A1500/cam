function init(){
	var somOrganDataset=L5.DatasetMgr.lookup("somOrganDataset");
	somOrganDataset.setParameter("SORG_ID",sorgId);
	somOrganDataset.load();
	var somElectronicDataSet=L5.DatasetMgr.lookup("somElectronicDataSet");
	somElectronicDataSet.setParameter("sorgId",sorgId);
	somElectronicDataSet.load();
	var win=L5.getCmp("uploadList");
	if(win!=null){
		win.on("hide",function(el){
			somElectronicDataSet.setParameter("sorgId",sorgId);
			somElectronicDataSet.load();
		});	
	}	
	var win=L5.getCmp("uploadList2");
	if(win!=null){
		win.on("hide",function(el){
			somElectronicDataSet.setParameter("sorgId",sorgId);
			somElectronicDataSet.load();
		});	
	}	
	var uploadListGrid2 = L5.getCmp("uploadListGrid2");
	uploadListGrid2.on("rowclick",function(){
		var selected= uploadListGrid2.getSelectionModel().getSelections();
		if(selected.length==1){
			var dutyId = selected[0].get("dutyId");
			var downloadDataSet=L5.DatasetMgr.lookup("downloadDataSet");
			downloadDataSet.setParameter("dutyId",dutyId);
			downloadDataSet.load();
		}
	});
}

//点击上传附件按钮
function clickUploadFile(){
	uploadForArchive();
}
//返回按钮
function goBack(){
	var url = 'jsp/cams/sorg/archives/group/groupArchivesList.jsp';
	url = encodeURI(encodeURI(url));
	var text = '归档列表查询';
	L5.forward(url, text);
}

