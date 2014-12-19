var sorgCodeNum = "";
var cnNameNum = "";
function init(){
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.newRecord();
}
function saveAll(){
	if($("name").innerHTML==""){
		L5.Msg.alert("提示","未指定主体社会组织!");
		return ;
	}
//---------------------------------社团基本信息校验-----------------------------------------------
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	var validate = somOrganDataSet.isValidate(true);
	if(validate != true){
		L5.Msg.alert("提示","校验未通过："+validate);
		return;
	}
	//登记证号
	if(sorgCodeNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的分支/代表机构登记证号已存在");
		return;
	}
	//社团名称/中文
	if(cnNameNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的分支/代表机构名称已存在");
		return;
	}
	//社团邮编
	if(_isPostCode(_$("sorgPost")) != true){
		L5.Msg.alert("提示","校验未通过："+"机构邮编格式不正确");
		return;
	}
	//社团电话号码
	var sorgPhones = _$("sorgPhone").split(";");
	for(i=0;i<sorgPhones.length;i++){
		if(isTel(sorgPhones[i]) != true){
			L5.Msg.alert("提示","校验未通过："+"机构电话中第"+(i+1)+"格式不正确");
			return;
		}
	}
//-----------------------------------------------------------------------------------------------	
	//提取基本信息
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomGroupCmd");
	var record = somOrganDataSet.getCurrent();
	record.set("mainSorgId",_$("mainSorgId"));
	record.set("legalPeople",$("legalPeople").innerHTML);
	record.set("sorgId",sorgId);
	var organBean = record.toBean("com.inspur.cams.sorg.base.data.SomOrgan");
	
	//提交保存
	command.setParameter("organBean",organBean);
	command.setParameter("sorgType","S");
	command.execute("saveBranch");
	if(!command.error){
		var url="jsp/cams/sorg/manage/group/somGroupBranchList.jsp";
		var text="社团分支/代表列表"
		L5.forward(url,text);
	}else{
		alert(command.error);
	}
}
//校验登记证号是否重复
function sorgCodeUK(){
	if(_$("sorgCode").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomGroupCmd");
		command.setParameter("sorgCode",_$("sorgCode"));
		command.execute("sorgCodeUK");
		sorgCodeNum = command.getReturn("sorgCodeNum");
		if(sorgCodeNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的分支/代表机构登记证号已存在");
			return;
		}
	}
}
//校验社会组织名称是否重复
function cnNameUK(){
	if(_$("cnName").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomGroupCmd");
		command.setParameter("cnName",_$("cnName"));
		command.execute("cnNameUK");
		cnNameNum = command.getReturn("cnNameNum");
		if(cnNameNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的分支/代表机构名称已存在");
			return;
		}
	}
}
function back(){
	var url = "jsp/cams/sorg/manage/group/somGroupBranchList.jsp";
	var text = "社团分支/代表列表";
	L5.forward(url,text);
}	
function validateSorgCode(){
	$("name").innerHTML = "";
	$("legalPeople").innerHTML = "";
	$("mainSorgId").value = "";
	$("cnName").value = "";
	var mainSorgCode = _$("mainSorgCode");
	if(mainSorgCode.trim() == ""){
		return;
	}
	var somMainOrganDataSet = L5.DatasetMgr.lookup("somMainOrganDataSet");
	somMainOrganDataSet.setParameter("SORG_TYPE@=","S");
	somMainOrganDataSet.setParameter("SORG_CODE@=",mainSorgCode);
	somMainOrganDataSet.load();
	somMainOrganDataSet.on("load",function(ds){
		if(ds.getCount() == 0){
			L5.Msg.alert("提示","输入的社团主体登记证号不存在!");
			return ;
		}
		if(ds.get("sorgStatus") == "32" || ds.get("sorgStatus") == "62"){
			L5.Msg.alert("提示",'“'+ds.get("cnName")+'”已被注销，请重新输入！');
			return;
		}
		if(ds.get("sorgStatus") == "52"){
			L5.Msg.alert("提示",'“'+ds.get("cnName")+'”已被撤销，请重新输入！'); 
			ds.newRecord();
			return;
		}
		$("name").innerHTML = ds.get("cnName");
		$("legalPeople").innerHTML = ds.get("legalPeople");
		$("mainSorgId").value = ds.get("sorgId");
		$("mainSorgCode").value = ds.get("sorgCode");
		$("cnName").value = ds.get("cnName");
	});
}
