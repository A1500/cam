var ifQuery = false;
function init(){
	if(organLevel=='SQ'){
		document.getElementById("xzqh1").style.display = "none";
		document.getElementById("xzqh2").style.display = "none";
		document.getElementById("xzqh4").style.display = "none";
		document.getElementById("Selfquery").style.display = "none";
	}else if(organLevel=='JD' ){
		document.getElementById("xzqh1").style.display = "";
		document.getElementById("xzqh2").style.display = "none";
		var OrgCodeDataset = L5.DatasetMgr.lookup("OrgCodeDataset");
		OrgCodeDataset.setParameter("filterSql","organ_id = '"+organCode+"'");
		OrgCodeDataset.load();
		document.getElementById("xzqh4").style.display = "";
	}else {
		document.getElementById("xzqh1").style.display = "";
		document.getElementById("xzqh2").style.display = "";
		document.getElementById("xzqh4").style.display = "none";
	}
	var cdcPicInfoDataSet=L5.DatasetMgr.lookup("cdcPicInfoDataSet");
	cdcPicInfoDataSet.setParameter("ORGAN_CODE",organCode);
	cdcPicInfoDataSet.load();
	cdcPicInfoDataSet.on("load",function(){
		var records = cdcPicInfoDataSet.getAllRecords();
		var divShow = "<table border=\"1\"><tr>";
		for(var i=0;i<records.length;i++){
			divShow += loadPhotoAll(records[i].get("ID"),records[i].get("CONTENT"),records[i].get("NOTE"),records[i].get("ORGAN_NAME"),
			records[i].get("CREATE_TIME"));
			if((i +1)%10 == 0){
				divShow += "</tr></table><table><tr>";
			}
		}
		$("photoDiv").innerHTML = divShow+"</tr></table>";
		});
}
function upload(){
	var url="jsp/ext/cdc/manage/pic/cdcPicInfoUpload.jsp";
	L5.forward(url,'','');
}
function querySelf(){
	var cdcPicInfoDataSet=L5.DatasetMgr.lookup("cdcPicInfoDataSet");
	cdcPicInfoDataSet.setParameter("createTime",_$("createTime"));
	cdcPicInfoDataSet.setParameter("ORGAN_CODE",organCode);
	cdcPicInfoDataSet.load();
}
//查询
function query(){
	var organC ;
	if(organLevel=="11"){
		organC =organCode.substring(0,2); 
	}else if(organLevel=="12" ){
		organC =organCode.substring(0,4); 
	}else if(organLevel=="13"){
		organC =organCode.substring(0,6); 
	}else if(organLevel=="JD"){
		organC =organCode.substring(0,9)
	}else{
		organC =organCode;
	}
	if(organLevel=='JD' ){
		var SQdomicileCode = document.getElementById("SQdomicileCode").value;
		if(SQdomicileCode!=""){organC =SQdomicileCode;}
	}else if(organLevel!='SQ' ){
		var domicileCode = document.getElementById("domicileCode").value;
		var leve = document.getElementById("leve").value;
		if(domicileCode!=""){
			if(leve =="3"){
				if(domicileCode.substring(4)=="00999000"){
					organC =domicileCode.substring(0,4); 
				}else if(domicileCode.substring(6)=="999000"){
					organC =domicileCode.substring(0,6); 
				}else{
					organC =domicileCode.substring(0,9);
				}
			}else if(leve =="4" ) {
				organC =domicileCode;
			}
		}
	}
	var cdcPicInfoDataSet=L5.DatasetMgr.lookup("cdcPicInfoDataSet");
	cdcPicInfoDataSet.setParameter("createTime",_$("createTime"));
	cdcPicInfoDataSet.setParameter("organCode",organC);
	cdcPicInfoDataSet.load();
}

//加载照片
function loadPhotoAll(id,photoId,note,organName,createTime){
	var src = rootPath+"download?table=COM_PHOTO_"+photoId.substring(0,6)+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+photoId+"'";
	var inHTML = '';
	return inHTML="<td width=85.5 align=\"center\">&nbsp;&nbsp;<img id=\"img\" name=\"RELATIONER_PHOTOC_IMG\" width=85.5 height=108 src="+src+" align=\"top\" ondblclick=\"wPhoto('"+photoId+"','"+note+"','"+organName+"','"+createTime+"','"+id+"');\""+
	"	onerror=\"javascript:this.src=\'"+rootPath+"/jsp/cams/marry/image/default.jpg\'\" alt=\""+note.substring(0,12)+"\" />&nbsp;&nbsp;"+
		"<input type=\"hidden\" id=\"photo\" name=\"photo\"/><br /><font size=2 >"+organName+"</font></td> ";

}

function wPhoto(photoId,note,organName,createTime,id){
	 window.showModalDialog("cdcPicInfoShowDetail.jsp?photoId="+photoId+"&note="
	 +encodeURIComponent(encodeURIComponent(note))+"&organName="
	 +encodeURIComponent(encodeURIComponent(organName))+"&createTime="+createTime+"&id="+id,window,"scroll:yes;dialogWidth:900px;dialogHeight:600px;status:no;resizable:1");
	var cdcPicInfoDataSet=L5.DatasetMgr.lookup("cdcPicInfoDataSet");
	cdcPicInfoDataSet.setParameter("createTime",_$("createTime"));
	cdcPicInfoDataSet.setParameter("organCode",organCode);
	cdcPicInfoDataSet.load();
}

//重置
function reset(){
	document.getElementById('reportDate').value = '';
}

function func_ForDomicileSelect() {

	queryOrganName();
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileName").value = list[4];
		document.getElementById("leve").value = list[2];
		document.getElementById("domicileCode").value = list[0];
	}
}
function queryOrganName() {
	if(!ifQuery) {
		if(organCode != null && organCode != "") {
			var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			command.setParameter("ID",organCode);
			command.execute("findOrganName");
			var fullName = command.getReturn("organName");
			if(fullName != null && fullName != "") {
				organName = fullName;
			}
			ifQuery = true;
		}
	}	
}