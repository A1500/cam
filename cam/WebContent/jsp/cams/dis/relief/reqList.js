function init() {
	if(organType=="13") {
		document.getElementById("reqFrame").src = "reqListOfCounty.jsp";
	}else {
		document.getElementById("reqFrame").src = "../statistics/reliefRequestSumsList.jsp";
	}
};
