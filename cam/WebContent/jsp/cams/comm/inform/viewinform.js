
/**
 *  页面加载后自动运行，进行初始化事件等操作。
 */
function init(){
	var command=new L5.Command("com.inspur.cams.comm.inform.InformCommand");
	command.setParameter("id",queryid);
	command.setParameter("page",page);
	command.execute("getDetailByInformId");
	var sendman = command.getReturn("sendman");
	if(sendman=="undefined"){
		sendman= "";
	}
	organ.baseParams["ORGAN_CODE@="]=sendman;
	organ.load();
	organ.on("load",function(){
		if(organ.getCount()>0){
			var sendmanname = organ.getAt(0).get("text");
			document.getElementById("sendman").value = sendmanname;
		}
	})
	var informtype = command.getReturn("informtype");
	if(informtype=="undefined"){
		informtype= "";
	}
	type.load();
	type.on("load",function(){
		for(var i=0;i<type.getCount();i++){
			if(type.getAt(i).get("value")==informtype){
				document.getElementById("informtype").value = type.getAt(i).get("text");
				break;
			}
		}
	})
	document.getElementById("sendman").value=sendman;//发送单位
	document.getElementById("title").value=command.getReturn("title");//标题
	document.getElementById("content").innerHTML=command.getReturn("content");//内容
	document.getElementById("sendmanid").value=command.getReturn("sendmanid");//发送人
	document.getElementById("informtype").value=informtype;//通知类型
	document.getElementById("receiveman").value=command.getReturn("receiveman");
	var filenames=command.getReturn("filename");
	var AttIds=command.getReturn("AttId");
	var viewfilename="";
	//如果只包含一个附件
	if(filenames.indexOf(',')<0){
		var temp = filenames.split('~');
		viewfilename="<a href="+L5.webPath+"/download?table=APPROVALE_IN_INFORM_ATTACHMENT&column=filecontent&filename=filename&pk=AttId&AttId='"+AttIds+"'>"+temp[0]+'</a>';
	}
	//如果包含多个附件
	else{
		var temp = filenames.split(',');
		var AttIdArray=AttIds.split(',');
		for(var i=0,j=1;i<temp.length;i++){
			var tempsplit = temp[i].split('~');
			var AttId=AttIdArray[i];
			//下载
			viewfilename+=(j++)+"&nbsp;&nbsp;<a href="+L5.webPath
			  +"/download?table=APPROVALE_IN_INFORM_ATTACHMENT&column=filecontent&filename=filename&pk=AttId&AttId='"+AttId+"'>"+tempsplit[0]+"</a><br>";
		}
	}
	document.getElementById("filename").innerHTML=viewfilename;
}

/*
 * 点击【返回】
 */
function click_back(){
	if(page=="receivepage"){
		window.location="receivenotifylist.jsp";
	}else if(page=="sendpage"){
		window.location="sendnotifylist.jsp";
	}else{
		window.location="../../content.jsp";
	}
}
/*
 * 点击【打印】
 */
function click_print(){
	 L5.Msg.alert("提示：","正在建设中。。。!");

}

