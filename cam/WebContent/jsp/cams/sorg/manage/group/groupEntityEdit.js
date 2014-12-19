function init(){
	$('cnName').innerHTML=cnName;
	$('sorgCode').innerHTML=sorgCode;
	
	if(method=="insert"){
		var somEntityDataSet=L5.DatasetMgr.lookup("somEntityDataSet");
		somEntityDataSet.newRecord({"sorgId":sorgId,"sorgType":"S","taskCode":taskCode});
	}else{
		var somEntityDataSet=L5.DatasetMgr.lookup("somEntityDataSet");
		somEntityDataSet.setParameter("ID@=",id);
		somEntityDataSet.load();
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
//点击上传附件按钮
function clickUploadFile(){
	uploadFile();
}
function save(){
	var sorgId=_$("sorgId");
	if(""==sorgId){
		L5.Msg.alert("提示","此社会团体已经不存在，不可以备案！");
		return false;
	}
	var somEntityDataSet=L5.DatasetMgr.lookup("somEntityDataSet");
	var validate=somEntityDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}
	var somEntityRecord=somEntityDataSet.getCurrent();
	somEntityRecord.set('sorgType','S');
	var command=new L5.Command("com.inspur.cams.sorg.base.cmd.SomEntityCmd");
	command.setParameter("somEntityRecord",somEntityRecord);
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
	var url="jsp/cams/sorg/manage/group/groupEntity.jsp";
	L5.forward(url,'',data);	
}
function returnBackHistory(){
	window.history.go(-1);	
}