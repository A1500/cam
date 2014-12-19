function init(){
	//var typeDS=L5.DatasetMgr.lookup("typeDS");
	//JcmCompanyProfileDataSet.setParameter("organCode",organCode);
	//typeDS.load(true);
	queryCompany();
}
//重置
function resetClick() {
	document.getElementById("companyName").value = '';
	document.getElementById("companyNature").value = '';
	document.getElementById("companyPeopleName").value = '';
	document.getElementById("companyNo").value = '';
	document.getElementById("companyBorgName").value = '';
}
function queryCompany(){
	var jcmCompanyProfileDataSet=L5.DatasetMgr.lookup("jcmCompanyProfileDataSet");
	var companyName = document.getElementById("companyName").value;
	var companyNature = document.getElementById("companyNature").value;
	var companyPeopleName = document.getElementById("companyPeopleName").value;
	var companyNo = document.getElementById("companyNo").value;
	var companyBorgName = document.getElementById("companyBorgName").value;
	
	jcmCompanyProfileDataSet.setParameter("companyName",'%'+companyName+'%');
	jcmCompanyProfileDataSet.setParameter("companyNature",companyNature);
	jcmCompanyProfileDataSet.setParameter("companyPeopleName",companyPeopleName);
	jcmCompanyProfileDataSet.setParameter("companyNo",companyNo);
	jcmCompanyProfileDataSet.setParameter("companyBorgName",companyBorgName);
	jcmCompanyProfileDataSet.load();
}
function insert(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/cams/jcm/companyManage/jcmCompanyProfileEdit.jsp";
	L5.forward(url,'',data);
}
function DetailsRendener(value, cellmeta, record, rowindex, colindex,dataset) {
	return '<a href="javascript:showDetails(\'' + record.data["COMPANY_ID"]
			+ '\')">' + value + '</a>';
}
function showDetails(companyId) {
	var url;
	url = L5.webPath+'/jsp/cams/jcm/companyManage/jcmCompanyProfileDetail.jsp?companyId='+companyId;
	window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:1024px;dialogHeight:768px;resizable:1");
}

