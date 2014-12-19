function init(){
	$('cnName').innerHTML=cnName;
	$('sorgCode').innerHTML=sorgCode;
	if(method=="insert"){
		var somOfficeDataSet=L5.DatasetMgr.lookup("somOfficeDataSet");
		somOfficeDataSet.newRecord({"sorgId":sorgId,"sorgType":"S","taskCode":taskCode});
	}else{
		var somOfficeDataSet=L5.DatasetMgr.lookup("somOfficeDataSet");
		somOfficeDataSet.setParameter("ID@=",id);
		somOfficeDataSet.load();
	}
	//电子档案
	somElectronicDataSet_load();
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	if(win!=null){
		win.on("hide",function(el){
			somElectronicDataSet_load();
		});
	}
}
function save(){
	var somOfficeDataSet=L5.DatasetMgr.lookup("somOfficeDataSet");
	var validate=somOfficeDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}

	//电话校验
	var isPhone=_$("phone");
	if(isPhone!=""){
	  	if(!isTel(isPhone)){
	  	L5.Msg.alert("提示","电话校验未通过！");
	  	return false;
	  	}
	}
	//邮编校验
	var isPostCode=_$("postCode");
	if(isPostCode!=""){
		if(!_isPostCode(isPostCode)){
		L5.Msg.alert("提示","邮编校验未通过！");
		return false;
		}
	}

	var somOfficeRecord=somOfficeDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.sorg.base.cmd.SomOfficeCmd");
	command.setParameter("somOfficeRecord",somOfficeRecord);
	if(method=="insert"){
		command.execute("insertOfficeAndApply");
	}else if(method=="update"){
		command.execute("update");
	}
	if(!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
//点击上传附件按钮
function clickUploadFile(){
	uploadFile();
}
function returnBack(){
	var data=new L5.Map();
	data.put("sorgId",sorgId);
	data.put("cnName",encodeURIComponent(encodeURIComponent(cnName)));
	data.put("sorgCode",sorgCode);
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(searchCnName)));
	data.put("searchSorgCode",searchSorgCode);
	var url="jsp/cams/sorg/manage/group/groupOffice.jsp";
	L5.forward(url,'',data);
}
function returnBackHistory(){
	window.history.go(-1);
}