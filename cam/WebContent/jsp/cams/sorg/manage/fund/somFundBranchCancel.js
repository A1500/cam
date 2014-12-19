function init(){
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganDataSet.load();
}
function saveAll(){
//---------------------------------分支/代表机构基本信息校验-----------------------------------------------
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	var validate = somOrganDataSet.isValidate(true);
	if(validate != true){
		L5.Msg.alert("提示","校验未通过："+validate);
		return;
	}
//-----------------------------------------------------------------------------------------------	
	//提取基本信息
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	var organBean = somOrganDataSet.getCurrent().toBean("com.inspur.cams.sorg.base.data.SomOrgan");
	var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomFundCmd");
	//提交保存
	command.setParameter("organBean",organBean);
	command.execute("saveBranchCancel");
	if(!command.error){
		var url="jsp/cams/sorg/manage/fund/somFundBranchList.jsp";
		var text="分支/代表列表"
		L5.forward(url,text);
	}else{
		alert(command.error);
	}
}
function back(){
	var url="jsp/cams/sorg/manage/fund/somFundBranchList.jsp";
	var text="分支/代表列表"
	L5.forward(url,text);
}
