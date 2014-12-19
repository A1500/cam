function init(){
	var problemDealDS=L5.DatasetMgr.lookup("problemDealDS");
	var problemDealHistoryDS=L5.DatasetMgr.lookup("problemDealHistoryDS");

	problemDealDS.setParameter("PROBLEM_ID",problemId);
	
	problemDealDS.load();
	problemDealHistoryDS.on("load",queryHistory);
	//附件信息
	var command=new L5.Command("com.inspur.cams.prs.prsattachment.cmd.PrsAttachmentCmd");
	command.setParameter("queryId",problemId);
	command.execute("queryAttachment");
	var fileNames=command.getReturn("fileName");
	var attIds=command.getReturn("attId");
	if(fileNames=="NoFile"){
		return;
	}
	var viewFileName="";
	//如果只包含一个附件
	if(fileNames.indexOf(",")<0){
		var temp=fileNames.split('~');
		viewFileName="<a href="+L5.webPath+"/download?table=PRS_ATTACHMENT&column=ATTACHMENT&filename=FILE_NAME&pk=ATTACHMENT_ID&ATTACHMENT_ID='"+attIds+"'>"+temp[0]+'</a>';
	}
	//如果包含多哥附件
	else{
		var temp=fileNames.split(',');
		var attIdArray=attIds.split(',');
		for(var i=0,j=1;i<temp.length;i++){
			var tempsplit=temp[i].split("~");
			var attId=attIdArray[i];
			viewFileName+=(j++)+": &nbsp;<a href="+L5.webPath+"/download?table=PRS_ATTACHMENT&column=ATTACHMENT&filename=FILE_NAME&pk=ATTACHMENT_ID&ATTACHMENT_ID='"+attId+"'>"+tempsplit[0]+"</a><br/>";
		}
	}
	document.getElementById("fileName").innerHTML=viewFileName;
}

//返回
function return_problem(){
	if(method=="list"){
		var url="jsp/cams/prs/prsProblemDeal/prsProblemDealList.jsp";
		L5.forward(url);
	}else if(method=="history"){
		var url="jsp/cams/prs/prsProblemDeal/prsProblemDealHistory.jsp";
		L5.forward(url);
	}
}
//查看历史记录
var win;
function detail_history(){
	var problemDealHistoryDS=L5.DatasetMgr.lookup("problemDealHistoryDS");
	
	problemDealHistoryDS.setParameter("PROBLEM_ID",problemId);
	problemDealHistoryDS.load();
	
}
function queryHistory(problemDealHistoryDS){
	var num=problemDealHistoryDS.getCount();
	if(num==0){
		L5.Msg.alert("提示","此问题没有历史记录！");
		return;
	}else{
		if(win==undefined){
			win=L5.getCmp("history_help");
		}
		win.x=50;
		win.y=50;
		win.show(this);
	}
}

function close_help(){
	var win=L5.getCmp("history_help");
	win.hide();
}