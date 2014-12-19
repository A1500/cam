function  confirmValue(){
	var arr=new Array();
	window.returnValue= document.getElementById("path").value;
	window.close();
}
function closew(){
	window.returnValue="";
	window.close();

}

function browseFolder(path) {
    try {
        var Message = "\u8bf7\u9009\u62e9\u6587\u4ef6\u5939";  //选择框提示信息
        var Shell = new ActiveXObject("Shell.Application");
        var Folder = Shell.BrowseForFolder(0, Message, 64, 17);//起始目录为：我的电脑

        if (Folder != null) {
             Folder = Folder.items();  // 返回 FolderItems 对象
             Folder = Folder.item();  // 返回 Folderitem 对象
             Folder = Folder.Path;   // 返回路径
            if (Folder.charAt(Folder.length - 1) != "\\") {
                 Folder = Folder + "\\";
             }
             document.getElementById("path").value = Folder;
            return Folder;
         }
     }
    catch (e) {
         alert(e.message);
     }
}
