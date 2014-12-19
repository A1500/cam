function init() {
	ds.setParameter("UPLOAD_UNIT", unitId);
	ds.load();
	if (unitId.substring(0, 1) == "B") {
		document.getElementById("iframe").src = "funeralOrganUserDetail.jsp?method="
				+ method + "&unitId=" + unitId;
	} else if (unitId.substring(0, 1) == "G"){
		if(prop==1){
			document.getElementById("iframe").src="cemePublicfitInfomationDetails.jsp?&unitId=" + unitId;
		}else{
			document.getElementById("iframe").src="cemeOrganUserDetail.jsp?&unitId=" + unitId;
		}
	}
	L5.QuickTips.init();
}

// 渲染上报方式
function sbfsRenderer(value, cellmeta, record, rowindex, colindex, dataset) {
	if(value=="0")
		return '在线';
	return '文件';
}

// 渲染查看
function ckRenderer(value, cellmeta, record, rowindex, colindex, dataset) {
	return '<a href="javascript:showDetails(\'' + record.data["recordId"]
			+ '\',\'' + record.data["ifFile"] + '\')">' + value + '</a>';
}

function showDetails(recordId, ifFile) {
	var url = L5.webPath+"/jsp/cams/fis/base/funeralOrganImportDetail_t.jsp?method=detail&recordId="+recordId+"&ifFile="+ifFile;
	window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:1024px;dialogHeight:768px;resizable:1");
}