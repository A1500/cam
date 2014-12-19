function init(){
}

/**
 * 定义根节点结构
 */ 
var rootdata = {
	boxId : '0',//唯一标志record,如果是前台配置生成record,需要指定id
	boxName:'我的邮箱',	
	parentId:'-1',
	boxType:'0',	
	recordType : 'mailRecord'
};

/**
 * 事件处理：获得 TreebaseParams的值
 */
function getMailParent(rec){
	return rec.get("boxId");
}


/**
* 事件处理：根据节点转向
*/
function selectNode(record){
var boxId=record.get("boxId");
var endflag = boxId.substring(boxId.length-2);
if(boxId!="00"&&boxId!="0"&&boxId!="other"&&endflag!="00"){
		var frame = document.getElementById("nodeFrame");
		var url;
		var endflag = boxId.substring(boxId.length-2);
		if(endflag=="01")   
			url = "all_inbox_list.jsp";	
		else if(endflag=="02")   
			url = "all_outbox_list.jsp";  
		else if(endflag=="03")   
			url = "all_sent_list.jsp";  
		else if(endflag=="04")   
			url = "all_trash_list.jsp";  		
	
		frame.setAttribute("src", url);
}
}
/**
* 事件处理：点击添加公司按钮
*/
function addStru(menuitem){
	var record = menuitem.parentMenu.record;
	var url = "../mail/box_edit.jsp";
	var text = "配置邮箱";	
	window.showModalDialog(url,text,"dialogHeight:700px;dialogWidth:700px;resizable:no;scroll:yes;");
}
function handler(record){
    if(record.get("boxId")=="other"){
    	return true;
    }
    return false;
}
