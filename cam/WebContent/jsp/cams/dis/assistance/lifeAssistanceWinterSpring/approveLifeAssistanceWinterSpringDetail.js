var html = "";
function init(){
	reliefDs.setParameter("INFO_ID",cx_infoId);
	familyDs.setParameter("RECORD_ID",cx_recordId);
	
	reliefDs.load();//初始化救助信息
	familyDs.load();//初始化家庭信息
	
};


