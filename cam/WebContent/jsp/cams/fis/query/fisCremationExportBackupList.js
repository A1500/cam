function init(){
	var fisCremationExportBackupDataSet=L5.DatasetMgr.lookup("fisCremationExportBackupDataSet");
	if(orgCode!="370000000000"){
		fisCremationExportBackupDataSet.setParameter("EXPORT_ORGAN",orgCode);
	}
	fisCremationExportBackupDataSet.load();
}
function query(){
	var fisCremationExportBackupDataSet=L5.DatasetMgr.lookup("fisCremationExportBackupDataSet");
	
	fisCremationExportBackupDataSet.load();
}