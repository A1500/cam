function init() {
	ds.baseParams["PERSON_ID@="]=idField;
	ds.load();
	ds.on("load",function(personDs){
			loadPhoto(personDs.get("photo"));
			loadQm(personDs.get("qmName"));
		});

	L5.QuickTips.init(); 
}

 function back()
 {	 /*	var url='jsp/cams/marry/person/mrmbaseperson_list.jsp';
		var text = '人员基本信息表';
		L5.forward(url,text);	 */
		window.close();
 }

//加载照片
function loadPhoto(photoId){
	var src = rootPath+"download?table=COM_PHOTO_"+photoId.substring(0,6)+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+photoId+"'";
	$("photoDiv").innerHTML="";
	$("photoDiv").innerHTML="<img id=\"img\" name=\"RELATIONER_PHOTOC_IMG\" width=82.5 height=110 src="+src+" align=\"top\" ondblclick=\"editPhoto(1,\'photo\',\'RELATIONER_PHOTOC_IMG\');\"	onerror=\"javascript:this.src=\'"+rootPath+"/jsp/cams/marry/image/default.jpg\'\" alt=\"暂无图片\" /><input type=\"hidden\" id=\"photo\" name=\"photo\"/>";
}
//加载签名
function loadQm(photoId){
	var src = rootPath+"download?table=COM_PHOTO_"+photoId.substring(0,6)+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+photoId+"'";
	$("qmDiv").innerHTML="";
	$("qmDiv").innerHTML="<img id=\"img1\" name=\"RELATIONER_PHOTOC_IMG1\" width=144 height=44 src="+src+" align=\"top\" ondblclick=\"editPhoto(4,\'qmName\',\'RELATIONER_PHOTOC_IMG1\');\"	onerror=\"javascript:this.src=\'"+rootPath+"/jsp/cams/marry/image/qianming.jpg\'\" alt=\"暂无图片\" /><input type=\"hidden\" id=\"qmName\" name=\"qmName\"/>";
}

