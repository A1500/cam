var mainPhotoTable="COM_PHOTO";
var defaultSrc = rootPath+"jsp/cams/sorg/comm/signet/default.jpg";
//同步照片
function synPhoto(photoId,num){
	if(num==null){
		num="";
	}
	if(photoId){
		var src = rootPath+"download?table="+mainPhotoTable+"_"+photoId.substring(0,6)+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+photoId+"'";
		resetPhoto(src,num,true);
	}else{
		resetPhoto(defaultSrc,num,true);
	}
}
//同步照片（照片不能修改）
function synPhotoDetail(photoId,num){
	if(num==null){
		num="";
	}
	$("photoDiv"+num).innerHTML="";
	if(photoId){
		var src = rootPath+"download?table="+mainPhotoTable+"_"+photoId.substring(0,6)+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+photoId+"'";
		resetPhoto(src,num,false);
	}else{
		resetPhoto(defaultSrc,num,false);
	}
}
//初始化照片
function initPhoto(num){
	if(num==null){
		num="";
	}
	resetPhoto(defaultSrc,num,true);
}
//初始化照片（照片不能修改）
function initPhotoDetail(num){
	if(num==null){
		num="";
	}
	resetPhoto(defaultSrc,num,false);
}
//重置照片
function resetPhoto(src,num,editable){
	if(editable==true){
		$("photoDiv"+num).innerHTML="";
		$("photoDiv"+num).innerHTML="<img id=\"img"+num+"\" name=\"RELATIONER_PHOTOC_IMG"+num+"\" width=82.5 height=110 src="+src+" align=\"top\" ondblclick=\"editPhoto(1"+num+",\'photoId"+num+"\',\'RELATIONER_PHOTOC_IMG"+num+"\');\"	onerror=\"javascript:this.src=\'"+defaultSrc+"\'\" alt=\"暂无图片\" /><input type=\"hidden\" id=\"photoId"+num+"\" name=\"photoId"+num+"\"/>";
	}else if(editable==false){
		$("photoDiv"+num).innerHTML="";
		$("photoDiv"+num).innerHTML="<img id=\"img"+num+"\" name=\"RELATIONER_PHOTOC_IMG"+num+"\" width=82.5 height=110 src="+src+" align=\"top\" onerror=\"javascript:this.src=\'"+defaultSrc+"\'\" alt=\"暂无图片\" /><input type=\"hidden\" id=\"photoId"+num+"\" name=\"photoId"+num+"\"/>";
	}
}
//保存照片到数据库并返回photoId
//photoValue：照片64码
function savePhoto(photoText,sorgType){
	if(photoText!="" && sorgType!=""){
		var url = "";
		if(sorgType=="J"){
			url="com.inspur.cams.sorg.apply.fund.cmd.FundBuildCmd";
		}
		if(sorgType=="S"){
			url="com.inspur.cams.sorg.apply.group.cmd.GroupBuildCmd";
		}
		var command = new L5.Command(url);
		command.setParameter("photoText",photoText);
		command.execute("savePhoto");
		if (!command.error) {
			return command.getReturn("photoId");
		}else{
			L5.Msg.alert('提示',"保存照片错误！"+command.error);
		}
	}
	return null;
}
//删除原照片并保存新照片到数据库 返回photoId
function updatePhoto(photoId,photoText,sorgType){
	if(photoText!="" && sorgType!=""){
		var url = "";
		if(sorgType=="J"){
			url="com.inspur.cams.sorg.apply.fund.cmd.FundBuildCmd";
		}
		if(sorgType=="S"){
			url="com.inspur.cams.sorg.apply.group.cmd.GroupBuildCmd";
		}
		var command = new L5.Command(url);
		command.setParameter("photoId",photoId);
		command.setParameter("photoText",photoText);
		command.execute("updatePhoto");
		if (!command.error) {
			return command.getReturn("photoId");
		}else{
			L5.Msg.alert('提示',"更新照片错误！"+command.error);
		}
	}
	return null;
}
