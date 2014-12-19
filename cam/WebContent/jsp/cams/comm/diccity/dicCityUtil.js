queryOrganName(); //查询当前登录所属organName

/*
*从数据库dic_city中查询organName
*/
function queryOrganName() {
		if(organCode != null && organCode != "") {
			var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			command.setParameter("ID",organCode);
			command.execute("findOrganName");
			var fullName = command.getReturn("organName");
			if(fullName != null && fullName != "") {
				organName = fullName;
			}
		}
}


/**
 * 选择属地行政区划窗口
 */
function func_ForDomicileSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		BaseinfoPeopleDataSet.getCurrent().set("domicileCode", list[0]);
		BaseinfoPeopleDataSet.getCurrent().set("domicileName", list[4]);
		BaseinfoPeopleDataSet.getCurrent().set("apanageCode", list[0]);
		BaseinfoPeopleDataSet.getCurrent().set("apanageName", list[4]);
	}
}

/**
 * 选择住址行政区划窗口
 */
function func_ForApanageSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		BaseinfoPeopleDataSet.getCurrent().set("apanageCode", list[0]);
		BaseinfoPeopleDataSet.getCurrent().set("apanageName", list[4]);
	}
}