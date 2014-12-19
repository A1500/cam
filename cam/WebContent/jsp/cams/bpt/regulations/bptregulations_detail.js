function init() {	
	ds.setParameter("REGULATIONS_ID", id);
	ds.on("load",setContent);
	ds.load();
	L5.QuickTips.init(); 
	KE.create("content");
	//附件信息
	var command=new L5.Command("com.inspur.cams.bpt.regulations.cmd.BptRegulationsAttachmentCmd");
	command.setParameter("queryId",id);
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
		viewFileName="<a href="+L5.webPath+"/download?table=BPT_REGULATIONS_ATTACHMENT&column=ATTACHMENT&filename=FILE_NAME&pk=ATTACHMENT_ID&ATTACHMENT_ID='"+attIds+"'><font size=2>"+temp[0]+'</font></a>';
	}
	//如果包含多哥附件
	else{
		var temp=fileNames.split(',');
		var attIdArray=attIds.split(',');
		for(var i=0,j=1;i<temp.length;i++){
			var tempsplit=temp[i].split("~");
			var attId=attIdArray[i];
			viewFileName+=(j++)+": &nbsp;<a href="+L5.webPath+"/download?table=BPT_REGULATIONS_ATTACHMENT&column=ATTACHMENT&filename=FILE_NAME&pk=ATTACHMENT_ID&ATTACHMENT_ID='"+attId+"'><font size=2>"+tempsplit[0]+"</font></a><br/>";
		}
	}
	document.getElementById("fileName").innerHTML=viewFileName;
}
function setContent(){
	var content =ds.get("content");
	KE.insertHtml("content",content); 
}
 function back()
 {	 	var url='jsp/cams/bpt/regulations/bptregulations_list.jsp';
		var text = '政策法规列表';
		L5.forward(url,text);	 
 }