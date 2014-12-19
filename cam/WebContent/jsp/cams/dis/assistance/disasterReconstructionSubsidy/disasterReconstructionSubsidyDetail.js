var html = "";
function init(){
	reliefDs.setParameter("INFO_ID",cx_infoId);
	familyDs.setParameter("RECORD_ID",cx_recordId);
	reliefDs.load();//初始化救助信息
	familyDs.load();//初始化家庭信息
	photoDs.setParameter("INFO_ID", cx_infoId);
	photoDs.on("load", function() {
		L5.getCmp("tabPanel").setActiveTab(2);
		loadImg();
	});
	photoDs.load();
};

function loadImg(){
	var count = photoDs.getCount();

	for(var i = 0; i < count; i++) {
		var record = photoDs.getAt(i);
		var imgHtml = "<img src ='"+L5.webPath + "/showPicServlet?pid="+record.get("photoId")+"' width='300' height='300' />";
		html += "<tr width='100%'>"
				+ "<td>"
				+	imgHtml
				+ "</td>"
				+"</tr>";
	}
	$("#photoTable").append(html);
}
