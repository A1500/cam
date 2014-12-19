var year = "";
var date = L5.server.getSysDate();
function init() {
	year = date.getYear() + "";
	var frame = document.getElementById("frameUp");
    var url="fundsSourceListOfUp.jsp";
	
	if(organType=="11") {
		fundsType="1"; //省民政厅
	}else if(organType=="12") {
		fundsType="2"; //市民政局
		url="fundsSourceListOfUpDepartment.jsp";
	}else if(organType=="13") {
		fundsType="3"; //区县民政局
	}else if(organType=="14") {
		fundsType="4"; //镇/街道办事处
	}
	frame.setAttribute("src", url);
}