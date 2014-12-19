function init(){
	$('cnName').innerHTML=cnName;
	$('sorgCode').innerHTML=sorgCode;

	if(method=="insert"){
		var somFeeDataSet=L5.DatasetMgr.lookup("somFeeDataSet");
		somFeeDataSet.newRecord({"sorgId":sorgId ,"taskCode":taskCode});
		//电子档案上传窗口关闭事件
		var win=L5.getCmp("uploadList");
		win.on("hide",function(el){
		somElectronicDataSet_load();
	});
	}else if(method=="update"){
		var somFeeDataSet=L5.DatasetMgr.lookup("somFeeDataSet");
		somFeeDataSet.setParameter("FEE_ID@=",feeId);
		somFeeDataSet.load();
		//电子档案上传窗口关闭事件
		var win=L5.getCmp("uploadList");
		win.on("hide",function(el){
		somElectronicDataSet_load();
	});
	}else if(method=="detail"){
		var somFeeDataSet=L5.DatasetMgr.lookup("somFeeDataSet");
		somFeeDataSet.setParameter("FEE_ID@=",feeId);
		somFeeDataSet.load();
	}
	//电子档案
		somElectronicDataSet_load();
}
//点击上传附件按钮
function clickUploadFile(){
	uploadFile();
}
function save(){
	var somFeeDataSet=L5.DatasetMgr.lookup("somFeeDataSet");
	var validate=somFeeDataSet.isValidate(true);
	if(validate!=true){
		L5.Msg.alert("提示","校验未通过，"+validate);
		return;
	}

	//数字校验
	var shouldNum=_$("shouldNum");
	var realNum=_$("realNum");
	var passNum=_$("passNum");
	var nopassNum=_$("nopassNum");
	var givenupNum=_$("giveupNum");
	if(givenupNum!=""|nopassNum!=""|passNum!=""|realNum!=""){
	var num=parseInt(givenupNum)+parseInt(nopassNum)+parseInt(passNum);
	if(num!=realNum){
		L5.Msg.alert("提示","人数逻辑出错！");
		return false;
	}
	}

	var somFeeDataSet=L5.DatasetMgr.lookup("somFeeDataSet");
	var somFeeRecord=somFeeDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.sorg.base.cmd.SomFeeCmd");
	command.setParameter("somFeeRecord",somFeeRecord);
	if(method=="insert"){
		command.execute("insertFeeAddApply");
	}else if(method=="update"){
		command.execute("update");
	}
	if(!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","保存出现错误！");
	}
}
function returnBack(){
	var data=new L5.Map();
	data.put("sorgId",sorgId);
	data.put("cnName",encodeURIComponent(encodeURIComponent(cnName)));
	data.put("sorgCode",sorgCode);
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(searchCnName)));
	data.put("searchSorgCode",searchSorgCode);
	var url="jsp/cams/sorg/manage/group/groupFee.jsp";
	L5.forward(url,'',data);
}
function returnBackHistory(){
	window.history.go(-1);
}