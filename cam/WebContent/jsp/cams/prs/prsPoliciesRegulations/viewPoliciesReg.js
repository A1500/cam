function init(){
	var policRegDS=L5.DatasetMgr.lookup("policRegDS");
	policRegDS.setParameter("policiesRegId",queryId);
	policRegDS.load();
	//附件信息
	var command=new L5.Command("com.inspur.cams.prs.prsattachment.cmd.PrsAttachmentCmd");
	command.setParameter("queryId",queryId);
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

/*
 * 点击【返回】
 */
function click_return(){
	if(page=="receive"){
		L5.forward("jsp/cams/prs/prsPoliciesRegulations/receivePoliciesRegList.jsp");
	}else if(page=="send"){
		L5.forward("jsp/cams/prs/prsPoliciesRegulations/sendPoliciesRegList.jsp");
	}
}


