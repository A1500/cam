function init(){
	$('cnName').innerHTML=cnName;
	$('sorgCode').innerHTML=sorgCode;
	if(method=="insert"){
		var somAccountDataSet=L5.DatasetMgr.lookup("somAccountDataSet");
		somAccountDataSet.newRecord({"sorgId":sorgId,"sorgType":"M","taskCode":taskCode});
	}else{
		var somAccountDataSet=L5.DatasetMgr.lookup("somAccountDataSet");
		somAccountDataSet.setParameter("ID@=",id);
		somAccountDataSet.load();
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
	var somAccountDataSet=L5.DatasetMgr.lookup("somAccountDataSet");
	var valid=somAccountDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var somAccountRecord=somAccountDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.sorg.base.cmd.SomAccountCmd");
	command.setParameter("somAccountRecord",somAccountRecord);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
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
	var url="jsp/cams/sorg/manage/ungov/ungovAccount.jsp";
	L5.forward(url,'',data);	
}
function returnBackHistory(){
	window.history.go(-1);	
}