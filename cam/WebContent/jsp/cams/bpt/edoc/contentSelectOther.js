function init(){
	var CatalogueArchivesDataset = L5.DatasetMgr.lookup("CatalogueArchivesDataset");
	CatalogueArchivesDataset.setParameter("peopleId",peopleId);
	CatalogueArchivesDataset.setParameter("serviceType",serviceType);
	CatalogueArchivesDataset.setParameter("organCode",organCode);
	CatalogueArchivesDataset.load();
	CatalogueArchivesDataset.on("load",function vbptElectronicLoad(){
		var ElectronicDataset = L5.DatasetMgr.lookup("ElectronicDataset");
		ElectronicDataset.setParameter("PEOPLE_ID",peopleId);
		ElectronicDataset.setParameter("SERVICE_TYPE",serviceType);
		ElectronicDataset.setParameter("ORGAN_ID", organCode);
		ElectronicDataset.setParameter("APPLY_ID", applyId);
		ElectronicDataset.load();
		ElectronicDataset.on("load",function checkSelected(){
			electronicRecords = ElectronicDataset.getAllRecords();
			var catalogueArchivesRecords = CatalogueArchivesDataset.getAllRecords();
			var selectedCAs = [];
			for(var i=0;i<electronicRecords.length;i++){
				for(var j=0;j<catalogueArchivesRecords.length;j++){
					if(electronicRecords[i].get("fileType")==catalogueArchivesRecords[j].get("catalogCode")){
						//selectCA.selectRow(j);
						selectedCAs.push(catalogueArchivesRecords[j]);
						break;
					}
				}
			}
			var CatalogueArchivesSelect =  L5.getCmp("CatalogueArchivesSelect");
			var selectCA = CatalogueArchivesSelect.getSelectionModel();
			selectCA.selectRecords(selectedCAs);
		});
	});
}

//返回的值
function  confirmValue(){
	var CatalogueArchivesSelect=L5.getCmp('CatalogueArchivesSelect');
	var selected=CatalogueArchivesSelect.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请至少选择一个档案目录!");
		return false;
	}
	
			var electronicRecords = ElectronicDataset.getAllRecords()
			for(var i=0;i<selected.length;i++){
				for(var j=0;j<electronicRecords.length;j++){
					if(selected[i]!='' && electronicRecords[j]!=undefined ){
						if(selected[i].get("catalogCode")==electronicRecords[j].get("fileType")){
							selected.remove(selected[i]);
							i=i-1;
							electronicRecords.remove(electronicRecords[j]);
							j=j-1;
							break;
						}
					}
				}
			}
			
			var command = new L5.Command("com.inspur.cams.bpt.bptelectronicfile.cmd.BptUploadfileCommand");
			command.setParameter("peopleId", peopleId);
			command.setParameter("applyId", applyId);
			command.setParameter("selected", selected);
			command.setParameter("organCode", organCode);
			command.setParameter("vbptElectronicRecords", electronicRecords);
			command.execute("personCatalogMaintain");
			if (command.error) {
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
			window.close();
}

function closew(){
	window.returnValue="";
	window.close();
}
