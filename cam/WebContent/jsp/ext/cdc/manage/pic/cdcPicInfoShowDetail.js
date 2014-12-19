function init(){
	var src = rootPath+"download?table=COM_PHOTO_"+photoId.substring(0,6)+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+photoId+"'";
	var inHTML = '';
	$("photoDiv").innerHTML="&nbsp;<img id=\"img\" name=\"RELATIONER_PHOTOC_IMG\" src="+src+" align=\"top\" ondblclick=\"wPhoto('"+photoId+"','"+note+"');\""+
	"	onerror=\"javascript:this.src=\'"+rootPath+"/jsp/cams/marry/image/default.jpg\'\" alt=\""+note.substring(0,12)+"\" />&nbsp;&nbsp;"+
		"<input type=\"hidden\" id=\"photo\" name=\"photo\"/>"+
		"<br/><font size=2 >所属单位:</font>&nbsp;&nbsp;&nbsp;<font size=2 >"+organNameThis+"</font>"+
		"<br/><font size=2 >图片描述:</font>&nbsp;&nbsp;&nbsp;<font size=2 >"+note+"</font>"+
		"<br/><font size=2 >上传时间:</font>&nbsp;&nbsp;&nbsp;<font size=2 >"+createTime+"</font>";
}

function del(){
	if(organNameThis != organName){
		L5.Msg.alert("提示","删除失败,不是本级图片！");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除吗?', function(state) {
		if(state == 'yes'){
			var command = new L5.Command("com.inspur.cams.cdc.base.cmd.CdcPicInfoCmd");
			command.setParameter("delId",id);
			command.execute("delete");
			if(!command.error){
				L5.Msg.alert("提示","删除成功！");
				window.close();
			}else{
				L5.Msg.alert("提示","删除失败！");
				return false;
			}
		}else{
			return false;
		}
	});
}

function returnBack(){
	history.go(-1);
}