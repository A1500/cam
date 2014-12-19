<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>

<html>
<next:ScriptManager/>
<script language="javascript">
function createShortcut(){
    try{
        var fso = new ActiveXObject("Scripting.FileSystemObject");   
        var shell = new ActiveXObject("WScript.Shell"); 
        //获取桌面本地桌面地址
        var tagFolder = shell.SpecialFolders("Desktop") ;
        if(!fso.FolderExists(tagFolder )){
            fso.CreateFolder(tagFolder);
        }
        if(!fso.FileExists(tagFolder + "//金民工程.url")){ 
            //在指定的文件夹下创建名为baidu.lnk的快捷方式
            var link = shell.CreateShortcut(tagFolder + "//金民工程.url");   
            //快捷方式指向的链接
            link.TargetPath = L5.webPath+"/";
     
            link.Save();  
            
        } 
        document.getElementById("okMsgDiv").style.display="";
        document.getElementById("failMsgDiv").style.display="none";
    }catch(e) {
    	alert(e);
        document.getElementById("failMsgDiv").style.display="";
        document.getElementById("okMsgDiv").style.display="none";
    }
}
</script>
<head></head>
<body onload="createShortcut()">
	<div id="failMsgDiv" style="display:none">
	当前IE安全级别不允许操作！请参照系统操作手册调整IE浏览器安全级别后，<a href="javascript:createShortcut()">点击此处重试</a>
	</div>
	<div id="okMsgDiv" style="display:none">
       桌面快捷方式创建成功！
    </div>
</body>
</html>
