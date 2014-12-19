function init(){
	var cdcPicInfoDataSet=L5.DatasetMgr.lookup("cdcPicInfoDataSet");
	cdcPicInfoDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode});
	//图片显示
	var ip = new ImagePreview( $$('idFile'), $$('idImg'), {
		maxWidth: 200, maxHeight: 200
	});
	ip.img.src = ImagePreview.TRANSPARENT;
	ip.file.onchange = function(){ ip.preview(); };
}
function upload(){
	var cdcPicInfoDataSet=L5.DatasetMgr.lookup("cdcPicInfoDataSet");
	var record=cdcPicInfoDataSet.getCurrent();
	var filePath = document.getElementById('idFile').value;
	if(filePath==""){
		L5.Msg.alert("提示","请选择上传的图片！");
		return;
	}
	var lastIndex = filePath.lastIndexOf(".");
	var suffFileName = filePath.substring(lastIndex + 1);// 取得模板后缀名
	record.set("photoTemp",document.getElementById('idFile').value);
	record.set("createTime",dateNow);
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcPicInfoCmd");
	command.setParameter("record",record);
	command.setParameter("suffFileName",suffFileName);
	command.setForm("editForm");
	command.execute("insert");
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}

function returnBack(){
	history.go(-1);
}
