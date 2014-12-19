function init(){
	var jcmPeopleInfoDataSet=L5.DatasetMgr.lookup("jcmPeopleInfoDataSet");
	jcmPeopleInfoDataSet.load();
}
function query(){
	var infoDs=L5.DatasetMgr.lookup("jcmPeopleInfoDataSet");
	infoDs.setParameter("PEOPLE_NAME@LIKE",getParam("qName"));
	infoDs.setParameter("PEOPLE_SEX",getParam("qSex"));
	infoDs.setParameter("PEOPLE_CARD",getParam("qIdCard"));
	infoDs.setParameter("PEOPLE_NATION",getParam("qNation"));
	infoDs.setParameter("PEOPLE_BIRTHDAY",getParam("qBirthday"));
	infoDs.setParameter("PEOPLE_POLITICS",getParam("qPolitical"));
	infoDs.setParameter("PEOPLE_EDU",getParam("qEdu"));
	infoDs.setParameter("PEOPLE_ADRESS@LIKE",getParam("qAdd"));
	infoDs.load();
}
function getParam(tag){
	return document.getElementById(tag).value;
}
function insert(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/cams/jcm/peopleManage/jcmPeopleInfoEdit.jsp";
	L5.forward(url,'',data);
}

//导出Excel
function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("jcmPeopleInfoDataSet");
	L5.dataset2excel(dataset,"/jsp/cams/jcm/peopleManage/peopleInfoExcel.jsp?userName="+organName);
}

function DetailsRendener(value, cellmeta, record, rowindex, colindex,dataset) {
	return '<a href="javascript:showDetails(\'' + record.data["peopleId"]
			+ '\')">' + value + '</a>';
}
function showDetails(peopleId) {
	var url;
	url = L5.webPath+'/jsp/cams/jcm/peopleManage/jcmPeopleInfoDetail.jsp?peopleId='+peopleId;
	window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:1024px;dialogHeight:768px;resizable:1");
}