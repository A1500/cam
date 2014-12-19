var fileCode = "J046";
function init() {
	loadInfo();
}
function loadInfo(){
	$("mainSorgCode").disabled=true;
	somOrganDataSet.setParameter("SORG_ID", sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on('load',loadBorgName);
}
function loadBorgName(ds){
	ds.un("load",loadBorgName);
	$("mainSorgId").value = ds.get("mainSorgId");
		$("name").innerHTML = ds.get("name");
	
	if(typeof businessOrganSelectDic !="undefined"){
		var borgName = ds.get('borgName');
		var records = businessOrganSelectDic.query("value",borgName);
		if(records.length>0){
			var borgCode = records.items[0].get("text");
			document.getElementById("borgName").value = borgName;
			document.getElementById("borgNameDispaly").value = borgCode;
		}
	}
}
//保存
function save(){
	//社团名称/中文
	if(cnNameNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的分支/代表机构名称已存在");
		return;
	}
	//登记证号
	if(sorgCodeNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的分支/代表机构登记证号已存在");
		return;
	}
	var somOrganRecord=somOrganDataSet.getCurrent();
	somOrganRecord.set("mainSorgId",_$("mainSorgId"));
	somOrganRecord.set("mainSorgCode",_$("mainSorgCode"));
	somOrganRecord.set("cnName",_$("cnName"));
	//社团邮编
	if(_$("sorgPost")!=""){
		if(_isPostCode(_$("sorgPost")) != true){
			L5.Msg.alert("提示","校验未通过："+"机构邮编格式不正确");
			return;
		}
	}
	var somMainOrganDataSet = L5.DatasetMgr.lookup("somMainOrganDataSet");
	if(document.getElementById("borgName").value == ""){
		L5.Msg.alert("提示","请填写业务主管单位！");
		return;
	}
	//将修改后的业务主管单位维护进organ
	somOrganRecord.set('borgName',document.getElementById("borgName").value);
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
	command.setParameter("organRecord", somOrganRecord);
	command.execute("modifyOrganInfo");
	
	if(!command.error){
		L5.Msg.alert("提示","保存成功!",function(){
			loadInfo();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//返回
function goBack(){
	var data=new L5.Map();
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(_$("cnName"))));
	data.put("searchSorgCode",_$("branchSorgCode"));	
	url="jsp/cams/sorg/modify/fund/fundModifyBuildList.jsp";
	L5.forward(url,'',data);
}
var sorgCodeNum = "";
var cnNameNum = "";
//校验社会组织名称是否重复
function cnNameUK(){
	if(_$("cnName").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("cnName",_$("cnName"));
		command.setParameter("sorgId",sorgId);
		command.execute("cnNameUK");
		cnNameNum = command.getReturn("cnNameNum");
		if(cnNameNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的机构名称已存在");
			return;
		}
	}
}
function validateSorgCode(){
	$("name").innerHTML = "";
	$("mainSorgId").value = "";
	$("cnName").value = "";
	var mainSorgCode = _$("mainSorgCode");
	if(mainSorgCode.trim() == ""){
		return;
	}
	var somMainOrganDataSet = L5.DatasetMgr.lookup("somMainOrganDataSet");
	somMainOrganDataSet.setParameter("SORG_TYPE@=","J");
	somMainOrganDataSet.setParameter("SORG_CODE@=",mainSorgCode);
	somMainOrganDataSet.load();
	somMainOrganDataSet.on("load",function(ds){
		if(ds.getCount() == 0){
			L5.Msg.alert("提示","输入的基金会登记证号不存在!");
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
		$("mainSorgId").value = ds.get("sorgId");
		$("mainSorgCode").value = ds.get("sorgCode");
		$("cnName").value = ds.get("cnName");
	});
}
//校验登记证号是否重复
function sorgCodeUK(){
	if(_$("branchSorgCode").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("sorgCode",_$("branchSorgCode"));
		command.setParameter("sorgType","J");
		command.setParameter("sorgId",sorgId);
		command.execute("sorgCodeUK");
		sorgCodeNum = command.getReturn("sorgCodeNum");
		if(sorgCodeNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的分支/代表机构登记证号已存在");
			return;
		}
	}
}