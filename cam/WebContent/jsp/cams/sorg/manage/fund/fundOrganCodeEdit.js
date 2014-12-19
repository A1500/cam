function init(){
	$('cnName').innerHTML=cnName;
	$('sorgCode').innerHTML=sorgCode;
	if(method=="insert"){
		var somOrganCodeDataSet=L5.DatasetMgr.lookup("somOrganCodeDataSet");
		somOrganCodeDataSet.newRecord({"sorgId":sorgId,"sorgType":"J","taskCode":taskCode});
	}else{
		var somOrganCodeDataSet=L5.DatasetMgr.lookup("somOrganCodeDataSet");
		somOrganCodeDataSet.setParameter("ID@=",id);
		somOrganCodeDataSet.load();
	}
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
	var sorgId=_$("sorgId");
	if(""==sorgId){
		L5.Msg.alert("提示","此基金会已经不存在，不可以备案！");
		return false;
	}
	var somOrganCodeDataSet=L5.DatasetMgr.lookup("somOrganCodeDataSet");
	var validate=somOrganCodeDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	var command=new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCodeCmd");
	var somOrganCodeRecord=somOrganCodeDataSet.getCurrent();
	command.setParameter("somOrganCodeRecord",somOrganCodeRecord);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			returnBack();		
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function returnBack(){
	var data=new L5.Map();
	data.put("sorgId",sorgId);
	data.put("cnName",encodeURIComponent(encodeURIComponent(cnName)));
	data.put("sorgCode",sorgCode);	
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(searchCnName)));
	data.put("searchSorgCode",searchSorgCode);	
	var url="jsp/cams/sorg/manage/fund/fundOrganCode.jsp";
	L5.forward(url,'',data);	
}

//点击上传附件按钮
function clickUploadFile(){
	uploadFile();
}