function init(){
	//var typeDS=L5.DatasetMgr.lookup("typeDS");
	//JcmCompanyProfileDataSet.setParameter("organCode",organCode);
	//typeDS.load(true);
	queryCompany();
}

function resetClick() {
	document.getElementById("companyName").value = '';
	document.getElementById("companyNature").value = '';
	document.getElementById("organName").value = '';
	document.getElementById("companyType").value = '';
	document.getElementById("companyPostCode").value = '';
}
function queryCompany(){
	var jcmCompanyProfileDataSet=L5.DatasetMgr.lookup("jcmAllUnitQueryDataSet");
	var companyName = document.getElementById("companyName").value;
	var companyNature = document.getElementById("companyNature").value;
	var organName = document.getElementById("organName").value;
	var companyType = document.getElementById("companyType").value;
	var companyPostCode = document.getElementById("companyPostCode").value;
	
	jcmCompanyProfileDataSet.setParameter("companyName",'%'+companyName+'%');
	jcmCompanyProfileDataSet.setParameter("companyNature",companyNature);
	jcmCompanyProfileDataSet.setParameter("organName",organName);
	jcmCompanyProfileDataSet.setParameter("companyType",companyType);
	jcmCompanyProfileDataSet.setParameter("companyPostCode",companyPostCode);
	jcmCompanyProfileDataSet.load();
}