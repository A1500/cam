function init(){
	var mrmPhotoInfoDataSet=L5.DatasetMgr.lookup("mrmPhotoInfoDataSet");
	mrmPhotoInfoDataSet.setParameter("organCode",deptCode);
	mrmPhotoInfoDataSet.load();
	mrmPhotoInfoDataSet.on("load",function(){
		var records = mrmPhotoInfoDataSet.getAllRecords();
		var divShow = "<table border=\"1\"><tr>";
		for(var i=0;i<records.length;i++){
			divShow += loadPhotoAll(records[i].get("ID"),records[i].get("CONTENT"),records[i].get("NOTE"),records[i].get("ORGAN_NAME"),
			records[i].get("CREATE_TIME"),records[i].get("ORGAN_CODE"));
			if(i == 9 || i == 19){
				divShow += "</tr></table><table><tr>";
			}
			
		}
		$("photoDiv").innerHTML = divShow+"</tr></table>";
		});
}
function upload(){
/*	var url="jsp/cams/marry/dept/photoInfo/mrmPhotoInfoUpload.jsp";
	L5.forward(url,'','');*/
	
	var url="mrmPhotoInfoUpload.jsp?deptCode="+deptCode+"&deptName="+encodeURIComponent(encodeURIComponent(deptName));
	var width = 800;
	var height = 400;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	var mrmPhotoInfoDataSet=L5.DatasetMgr.lookup("mrmPhotoInfoDataSet");
	mrmPhotoInfoDataSet.setParameter("createTime",_$("createTime"));
	mrmPhotoInfoDataSet.setParameter("organCode",deptCode);
	mrmPhotoInfoDataSet.load();
}

//查询
function query(){
	var mrmPhotoInfoDataSet=L5.DatasetMgr.lookup("mrmPhotoInfoDataSet");
	mrmPhotoInfoDataSet.setParameter("createTime",_$("createTime"));
	mrmPhotoInfoDataSet.setParameter("organCode",deptCode);
	mrmPhotoInfoDataSet.load();
}

//加载照片
function loadPhotoAll(id,photoId,note,organName,createTime,organCode){
	var src = rootPath+"download?table=COM_PHOTO_"+photoId.substring(0,6)+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+photoId+"'";
	var inHTML = '';
	return inHTML="<td width=105.5 align=\"center\"><img id=\"img\" name=\"RELATIONER_PHOTOC_IMG\" width=105 height=88 src="+src+" align=\"top\" ondblclick=\"wPhoto('"+photoId+
	"','"+note+"','"+organName+"','"+createTime+"','"+id+"','"+organCode+"');\""+
	"	onerror=\"javascript:this.src=\'"+rootPath+"/jsp/cams/marry/image/default.jpg\'\" alt=\""+note.substring(0,12)+"\" />"+
		"<input type=\"hidden\" id=\"photo\" name=\"photo\"/><br /><font size=2 >"+note+"</font></td> ";

}

function wPhoto(photoId,note,organName,createTime,id,organCode){
	 window.showModalDialog("mrmPhotoInfoShowDetail.jsp?&organCode="+organCode+"&photoId="+photoId+
	 "&note="+encodeURIComponent(encodeURIComponent(note))+"&organName="+
	 encodeURIComponent(encodeURIComponent(organName))+"&createTime="+createTime+"&id="+id,window,"scroll:yes;dialogWidth:900px;dialogHeight:600px;status:no;resizable:1");
	var mrmPhotoInfoDataSet=L5.DatasetMgr.lookup("mrmPhotoInfoDataSet");
	mrmPhotoInfoDataSet.setParameter("createTime",_$("createTime"));
	mrmPhotoInfoDataSet.setParameter("organCode",deptCode);
	mrmPhotoInfoDataSet.load();
}

//重置
function reset(){
	document.getElementById('reportDate').value = '';
}