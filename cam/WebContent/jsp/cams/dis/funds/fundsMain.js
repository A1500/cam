function init() {
	if (organType == "11") { //故意，暂时通用一个页面，根据客户需求修改
		document.getElementById("fundsMain").src="fundsMainDepartment.jsp";
	} else {
		document.getElementById("fundsMain").src="fundsMainOther.jsp";
	}
}
