function init(){
	var mrmPhotoInfoDataSet=L5.DatasetMgr.lookup("mrmPhotoInfoDataSet");
	mrmPhotoInfoDataSet.newRecord({"organCode":deptCode,"organName":deptName});
}
function upload(){
	var mrmPhotoInfoDataSet=L5.DatasetMgr.lookup("mrmPhotoInfoDataSet");
	var record=mrmPhotoInfoDataSet.getCurrent();
	if(document.getElementById('photo').value==""){
		L5.Msg.alert("提示","请选择上传的图片！");
		return;
	}
	
	record.set("photoTemp",document.getElementById('photo').value);
	record.set("createTime",dateNow);
	var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmPhotoInfoCommand");
	command.setParameter("record",record);
	command.execute("insert");
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			window.close();
		});
	}else{
		L5.Msg.alert("提示","保存出错！"+command.error);
	}
}

function returnBack(){
	window.close();
}
