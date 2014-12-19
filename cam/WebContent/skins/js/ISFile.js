// 完成组件初始化
function initISFile(){
	var sFileTool = '\
	<div style="display:none">\
		<OBJECT\
		  classid="clsid:EB98B3B8-2382-47AD-A70A-79082DD22C36"\
		  codebase="'+L5.webPath+'/jsp/dll/LocalFileToolProj.cab#version=1,0,2,0"\
		  width=90\
		  height=90\
		  align=center\
		  hspace=0\
		  vspace=0\
		  id="ISFile"\
		>\
		</OBJECT>\
	</div>\
	';
	document.write(sFileTool);
}
initISFile();

//获取文件大小
function getFileSize(filePath){
	if(($('ISFile')==null)||($('ISFile')==undefined)){
		msg = "无法完成您指定的操作！\n\n" +
			  "    可能原因：没有安装组件，请参见相关说明解决！！\n" +
			  "    如果确认组件已经安装，请咨询系统管理人员解决！\n";
		alert(msg);
		return false;
	}
	return $('ISFile').getFileSize(filePath);	
}

function isExceedMaxSize(filePath,maxSize){
	var fileSize = getFileSize(filePath)
	if(-1==fileSize){
		alert("文件不存在，请重新选择文件！");
		return false;
	}
	if(-2==fileSize){
		alert("获取文件大小失败！");
		return false;
	}
	if(fileSize>maxSize){
    return true;
	}
	return false;	
}
