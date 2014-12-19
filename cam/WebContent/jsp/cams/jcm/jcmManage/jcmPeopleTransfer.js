function init(){
	//var typeDS=L5.DatasetMgr.lookup("typeDS");
	//JcmCompanyProfileDataSet.setParameter("organCode",organCode);
	//typeDS.load(true);
	queryCompany();
}
//选择被调人员信息回填
function selectPeople() {
L5.Msg.alert("hh");
	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/jcm/query/jcmPeopleInfoList.jsp?radioType=0&rootId="
							+ orgCode, "",
					"dialogHeight:768px;dialogWidth:512px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("qUnit").value = list[0];
		document.getElementById("qUnitName").value = list[1];
	}
	
}