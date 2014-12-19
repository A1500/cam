function init(){
var domicileDatasetDomicile = L5.DatasetMgr.lookup("domicileCityDataset");
var problemDealDS=L5.DatasetMgr.lookup("problemDealDS");
problemDealDS.setParameter("PROBLEM_ID",problemId);
problemDealDS.load();
    domicileDatasetDomicile.setParameter("filterSql", "leve='1' and substr(id,1,2)= '" + organArea.substring(0, 2) + "'");
	domicileDatasetDomicile.load();

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
	//如果包含多个附件
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

	var problemDealDS=L5.DatasetMgr.lookup("problemDealDS");
	problemDealDS.setParameter("PROBLEM_ID",problemId);
	problemDealDS.load();
	problemDealDS.on("datachanged",func);
}
function func(problemDealDS) {
	problemDealDS.set("dealFlag","");
	_$("problemFrom").value=problemFrom;
	var timeTtamp = new Date();
	document.getElementById("dealTime").value=timeTtamp;
	document.getElementById("dealPerson").value=username;
	document.getElementById("dealPerson").disabled=true;
	document.getElementById("dealTime").disabled=true;
}

//保存
function save_problem(){
	var problemDealDS=L5.DatasetMgr.lookup("problemDealDS");	
	var problemRecord=problemDealDS.getCurrent();
	
	if(problemRecord.get("dealFlag")!=03){
		problemRecord.set("deal","");
	}		
	//取处理结果
	var dealFlagValue;
	var arr = document.getElementsByName("处理结果");
	for(var i=0; i<arr.length; i++) {
		if(arr[i].checked == true) {
			dealFlagValue = arr[i].value;
			break;
		}
	}
	if(dealFlagValue==""){
		L5.Msg.alert("提示","处理结果必须填写！");
		return;
	}
	problemRecord.set("dealPerson",username);
	var timeTtamp = new Date();
	problemRecord.set("dealTime",timeTtamp);
	if(problemRecord.get("problemTitle")==""){
		L5.Msg.alert("提示","问题标题不能为空！");
		return false;
	}
	if(problemRecord.get("problemNumbers")==""){
		L5.Msg.alert("提示","问题编号不能为空！");
		return false;
	}
	if(problemRecord.get("problemPerson")==""){
		L5.Msg.alert("提示","反映人名称不能为空！");
		return false;
	}
	if(problemRecord.get("problemCompany")==""){
		L5.Msg.alert("提示","反映人单位不能为空！");
		return false;
	}
	if(problemRecord.get("personNumber")==""){
		L5.Msg.alert("提示","反映人数不能为空！");
		return false;
	}
	if(problemRecord.get("problemDate")==""){
		L5.Msg.alert("提示","反映时间不能为空！");
		return false;
	}
	if(problemRecord.get("content")==""){
		L5.Msg.alert("提示","反映内容不能为空！");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.prs.prsproblemdeal.cmd.PrsProblemDealCmd");
	command.setParameter("record",problemRecord);
	if(dealFlagValue=="02"){
		if(_$("area")==""){
			L5.Msg.alert("提示","请选择要转发的单位！");
			return false;
		}
		command.setParameter("receiveOrgan",_$("area"));
		var area=$("area");
		command.setParameter("receiveOrganName",area[area.selectedIndex].text);
		command.setParameter("coutinue","coutinue");
	}
	//如果是上级转发的，现在办理完结
	if(dealFlagValue=="03"){
		command.setParameter("isEnd","endFlag");
	}
	command.execute("processProblemDeal");
	if(!command.error){
		L5.Msg.alert("提示","办理成功！",function(){
			L5.forward("jsp/cams/prs/prsProblemDeal/prsProblemDealList.jsp");
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//返回
function return_problem(){
	var url="jsp/cams/prs/prsProblemDeal/prsProblemDealList.jsp";
	L5.forward(url);
}
//办理
function send_problem1(){

	$("area").disabled=true;
	$("area").value="";
	$("area1").disabled=true;
	$("area1").value="";
	document.getElementById("deal").disabled=false;
	document.getElementById("dealPerson").disabled=true;
	document.getElementById("dealTime").disabled=true;
}
//转发
function send_problem(){

	document.getElementById("deal").disabled=true ;
	document.getElementById("deal").value="";
	document.getElementById("dealPerson").disabled=true;
	document.getElementById("dealTime").disabled=true;
	$("area").disabled=false;
	$("area1").disabled=false;
}
function setDomicile() {
    var domicileDatasetDomicile = L5.DatasetMgr.lookup("domicileDataset");
    var county=document.getElementById("area1").value;
    if (county.length > 9) {
        domicileDatasetDomicile.setParameter("filterSql", "leve='2' and substr(id,1,4)= '" + county.substring(0, 4) + "'");
        domicileDatasetDomicile.load();
    }
}
