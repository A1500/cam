function init(){
	var pubPostReplyDataSet=L5.DatasetMgr.lookup("pubPostReplyDataSet");
		pubPostReplyDataSet.setParameter("POST_ID@=",postId);
		pubPostReplyDataSet.setParameter("sort","REPLY_NUM");
		pubPostReplyDataSet.setParameter("dir","asc");
		pubPostReplyDataSet.load();
		document.getElementById("subject").innerHTML=subject;
		var replyDS=L5.DatasetMgr.lookup("replyDS");
	 	replyDS.newRecord({"replyOrgancode":replyOrgancode,
		   			   "replyOrganname":replyOrganname});
		//附件信息
	var command=new L5.Command("com.inspur.cams.comm.bbs.cmd.PubPostAttachmentCmd");
	command.setParameter("postId",postId);
	command.execute("queryAttach");
	var fileNames=command.getReturn("filename");
	var attIds=command.getReturn("AttId");
	var viewFileName="";
	//如果只包含一个附件
	if(fileNames.indexOf(",")<0){
		var temp=fileNames.split('~');
		viewFileName="<a href="+L5.webPath+"/download?table=PUB_POST_ATTACHMENT&column=ATTACH_CONTENT&filename=ATTACH_NAME&pk=ATTACH_ID&ATTACH_ID='"+attIds+"'>"+temp[0]+'</a>';
	}
	//如果包含多哥附件
	else{
		var temp=fileNames.split(',');
		var attIdArray=attIds.split(',');
		for(var i=0,j=1;i<temp.length;i++){
			var tempsplit=temp[i].split("~");
			var attId=attIdArray[i];
			viewFileName+=(j++)+": &nbsp;<a href="+L5.webPath+"/download?table=PUB_POST_ATTACHMENT&column=ATTACH_CONTENT&filename=ATTACH_NAME&pk=ATTACH_ID&ATTACH_ID='"+attId+"'>"+tempsplit[0]+"</a><br/>";
		}
	}
	document.getElementById("fileName").innerHTML="附件： "+viewFileName;
}

function toReply(){
	var pubPostReplyDataSet=L5.DatasetMgr.lookup("pubPostReplyDataSet");
	var num=pubPostReplyDataSet.getCount()+1;
	var replyDS=L5.DatasetMgr.lookup("replyDS");
	var replyContent=document.getElementById("replyContent").value;//回复内容
	if(replyContent==""){
		L5.Msg.alert("提示","请输入回复内容！");
		return;
	}
	var record=replyDS.getCurrent();
	var command=new L5.Command("com.inspur.cams.comm.bbs.cmd.PubPostReplyCmd");
	record.set("replyNum",num);
	record.set("postId",postId);
	command.setParameter("record",record);
	command.execute("insert");
	if (!command.error){
		L5.Msg.alert("提示","回复成功！",function(){
			init();
		});
	}else{
		L5.Msg.alert("提示","回复出错！"+command.error);
	}
}
function returnBack(){
//	var data = new L5.Map();
//    var url = 'jsp/cams/comm/bbs/pubPostList.jsp';
//    var text = '论坛列表';
//    L5.forward(url, text, data);
	window.close();
}
function formatNum(value){
	return value+"#";
	
}
