function init(){
	var comMessageDataSet=L5.DatasetMgr.lookup("comMessageDataSet");
	comMessageDataSet.setParameter("sort","serialNum");
	comMessageDataSet.setParameter("dir","asc");
	comMessageDataSet.load();
}
function getParam(name){
	return document.getElementById(name).value;
}
function query(){
	var comMessageDataSet=L5.DatasetMgr.lookup("comMessageDataSet");
	comMessageDataSet.setParameter("MESSAGE_TITLE@LIKE",getParam("message_name"));
	comMessageDataSet.load();
}
function insert(){
	var ds=L5.DatasetMgr.lookup("messageDs");
	var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
	command.setParameter("IdHelp", "Id32");
	command.execute();
	var messageId=command.getReturn("id");
	ds.newRecord({"messageId":messageId,"messageTime":messageTime,"ifShow":"1"});
	L5.getCmp("messageWin").show();
}
var status = "";
function update(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var ds=L5.DatasetMgr.lookup("messageDs");
	ds.setParameter("MESSAGE_ID@=",records[0].get("messageId"));
	ds.load(true);
	status= "update";
	L5.getCmp("messageWin").show();
}
function del(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否删除该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.comm.message.cmd.ComMessageCmd");
			command.setParameter("messageId",records[0].get("messageId"));
			command.execute("delete");
			if (!command.error){
				var comMessageDataSet=L5.DatasetMgr.lookup("comMessageDataSet");
				comMessageDataSet.load();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}
function confirm(){
	if(document.getElementById("messageTitle").value==""){
		L5.Msg.alert("提示","消息标题不能为空");
		return;
	}
	if(document.getElementById("messageContents").value==""){
		L5.Msg.alert("提示","消息正文不能为空");
		return;
	}
	var serialNum = document.getElementById("serialNum").value;	
	if(!CheckTxt(serialNum,"顺序号")){
		return false;
	}
	var ds=L5.DatasetMgr.lookup("messageDs");
	
	var record = ds.getCurrent();
	var command=new L5.Command("com.inspur.cams.comm.message.cmd.ComMessageCmd");
	command.setParameter("record",record);
	if(status=="update"){
		command.execute("update");
	}else{
		command.execute("insert");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功");
		closeWin();
		init();
	}else{
		L5.Msg.alert("提示","保存出错！"+command.error);
	}
}
function CheckTxt(obj) {
	var regExp= /^(0|[1-9]\d*)$/;
 	var value = obj;
	if(!value.match(regExp)){ 
		alert("请输入正确的数字");
		return false;
   }else{
	   return true;
   }
 }
/********************************上传***********************************/
function uploadFile(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var win=L5.getCmp("uploadWin");
	win.show();
}
function click_upload(){
	if(_$("files")=="" || _$("files")==null){
		L5.Msg.alert('提示',"上传文件不能为空!");
		return false;
	}
	var uploadGrid=L5.getCmp('grid');
	var selected=uploadGrid.getSelectionModel().getSelections();
	var record=selected[0];
	var command=new L5.Command("com.inspur.cams.comm.message.cmd.ComMessageCmd");
	command.setParameter("uploadRd",record);
	command.setForm("form_content");
	command.execute("uploadSave");
	//包含有大字段的异常判断
	command.afterExecute=function(){
		if(!command.error){
			L5.Msg.alert("提示","上传附件成功!",function(){
			//上传成功关闭当前窗口
				var win=L5.getCmp("uploadWin");
				win.hide();
				init();
			});
		}
		else{
	        L5.Msg.alert("提示",(''+command.error).replace("出现系统异常",""),{});
        }
      }
}
//上传文件关闭窗口
function close_upload(){
	var win=L5.getCmp("uploadWin");
	win.hide();
}
/***********************************下载*************************************/
//链接下载附件功能
function clickDownloadHref(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var messageId = record.get("messageId");
	var attachDataSet=L5.DatasetMgr.lookup("attachDataSet");
	attachDataSet.setParameter("MESSAGE_ID",messageId);
	attachDataSet.load(true);
	if(attachDataSet.getCount()!=0){
		var ids = attachDataSet.getAt(0).get("attachmentId");
	}else{
		return "";
	}
	/*if(attachDataSet.getCount()==1){
		var url0=paths[0]+'/'+paths[1]+"/download?table=dic_city_change_batch_attach&column=attach_content&pk=attach_id&filename=attach_name&attach_id='"+ids+"'";
		return '<a id="download" target="_blank" href='+url0+'>'+'点击下载'+'</a>';
	}*/
	return '<a href="javascript:clickDownload(\'' + messageId + '\')">' + '点击下载' + '</a>';
	
}
	//打开下载多个附件窗口
function clickDownload(index){
    var paths = document.location.pathname.split("/");
	var downloadDataSet = L5.DatasetMgr.lookup("downloadDataSet");
	downloadDataSet.setParameter("MESSAGE_ID",index);
	downloadDataSet.load(true);
	var win = L5.getCmp("downloadWin");
	win.show();
}

//窗口下载附件
function winDownloadHref(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var id = record.get("attachmentId");
  	var url0=paths[0]+'/'+paths[1]+"/download?table=COM_MESSAGE_ATTACHMENT&column=file_content&pk=attachment_id&filename=file_name&attachment_id='"+id+"'";
	return '<a id="download" target="_blank" href='+url0+'>'+value+'</a>';
}
function closeDownload(){
	L5.getCmp("downloadWin").hide();
}
	//链接删除附件功能
function delUploadFile(value,cellmeta,record,rowindex,colindex,dataset){
	/*var ds=L5.DatasetMgr.lookup("comMessageDataSet");
	ds.setParameter("MESSAGE_ID@=",record.get("messageId"));
	ds.load(true);
	var records = ds.getCurrent();
	if(records.get("batchType")!="0" && records.get("batchType")!="3"){
		return "";
	}*/
	return '<a href="javascript:clickDelete(\'' + downloadDataSet.indexOf(record) + '\')">' + '点击删除' + '</a>';
}
//点击删除附件
function clickDelete(index){
	var attachDataSet=L5.DatasetMgr.lookup("attachDataSet");
	attachDataSet.load(true);
	var record= attachDataSet.getAt(index);
	L5.MessageBox.confirm('', '你确定要删除吗？',function(sure){
		if(sure=="yes"){
			var command=new L5.Command("com.inspur.cams.comm.message.cmd.ComMessageAttachmentCmd");
			command.setParameter("attachmentId",record.get("attachmentId"));
			command.execute("delete");
			if (!command.error) {
				L5.Msg.alert('提示','删除成功！');
				downloadDataSet.setParameter("MESSAGE_ID@=",record.get("messageId"));
				downloadDataSet.load();
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}
		else 
			return;
		}
	);	
}
function closeWin(){
	L5.getCmp("messageWin").hide();
}

function unshow() {
	var grid = L5.getCmp("grid");
	var records = grid.getSelectionModel().getSelections();
	if (records.length == 0) {
		L5.Msg.alert("提示", "请先选中一行!");
		return;
	}
	var ifShow = records[0].get("ifShow");
	if (ifShow != '1') {
		L5.Msg.alert("提示", "该消息未发布，无需取消！");
		return;
	}
	L5.MessageBox.confirm("提示", "确定取消发布该消息？", function(sta) {
		if (sta == "yes") {
			var command = new L5.Command("com.inspur.cams.comm.message.cmd.ComMessageCmd");
			records[0].set("ifShow", "0");
			command.setParameter("record", records[0]);
			command.execute("update");
			if (!command.error) {
				L5.Msg.alert("提示", "取消成功！", function() {
							init();
						});
			} else {
				L5.Msg.alert("提示", "取消出错！" + command.error);
			}
		}
	});
}

function toshow() {
	var grid = L5.getCmp("grid");
	var records = grid.getSelectionModel().getSelections();
	if (records.length == 0) {
		L5.Msg.alert("提示", "请先选中一行!");
		return;
	}
	var ifShow = records[0].get("ifShow");
	if (ifShow != '0') {
		L5.Msg.alert("提示", "该消息已发布，无需重复发布！");
		return;
	}
	L5.MessageBox.confirm("提示", "确定发布该消息？", function(sta) {
		if (sta == "yes") {
			var command = new L5.Command("com.inspur.cams.comm.message.cmd.ComMessageCmd");
			records[0].set("ifShow", "1");
			command.setParameter("record", records[0]);
			command.execute("update");
			if (!command.error) {
				L5.Msg.alert("提示", "发布成功！", function() {
							init();
						});
			} else {
				L5.Msg.alert("提示", "发布出错！" + command.error);
			}
		}
	});
}