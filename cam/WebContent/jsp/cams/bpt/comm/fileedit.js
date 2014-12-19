
function fileEdit(electronicId,fileId)
{
	var width = 480;
	var height = 300;
	var url='fileupdate.jsp?electronicId='+electronicId+'&fileId='+fileId;
	//window.open(url);
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	//alert(win);
	
	window.location.reload();
	
}
function fileDelete(electronicId,fileId)
 {
 	
 	if(fileId==""||electronicId=="")
 	{
 		alert("没有要删除的文件！");
 		return false;
 	}
 
 	var command=new L5.Command("com.inspur.cams.bpt.bptelectronicfile.cmd.BptUploadfileCommand");
	//alert("1"+electronicId+fileId);
	command.setParameter("electronicId",electronicId);
	command.setParameter("fileId",fileId);
	//alert("2");
	command.execute("fileDelete");
	//alert("3");
	command.afterExecute=function(){
		if(!command.error){
			L5.Msg.alert("提示","删除文件出错!");
		}else{
			L5.Msg.alert("提示",(command.error+'').replace("出现系统异常",""),{});
		}
	}
	alert("删除文件成功!");
	
	window.location.reload();
 }
