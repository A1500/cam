var sorgCodeNum = "";
var cnNameNum = "";
var organCodeNum = "";
var sorgCodeInit = "";
var cnNameInit = "";
var organCodeInit = "";
var peopleIdInit = "";
function init(){
	L5.getCmp("tab").setActiveTab("0");
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on("load",function(ds){
		sorgCodeInit = ds.get("sorgCode");
		cnNameInit = ds.get("cnName");
		organCodeInit = ds.get("organCode");
		$("leasePeriod").value = ds.get("leasePeriod");
	});
	var somDeputyPeopleDataSet = L5.DatasetMgr.lookup("somDeputyPeopleDataSet");
	somDeputyPeopleDataSet.setParameter("SORG_ID@=",sorgId);
	somDeputyPeopleDataSet.setParameter("PEOPLE_TYPE@=", "L");
	somDeputyPeopleDataSet.setParameter("IF_VALID@=", "2");
	somDeputyPeopleDataSet.load();
	somDeputyPeopleDataSet.on("load",function(ds){
		peopleIdInit = ds.get("peopleId");
		$("promiseCode_update").value = ds.get("promiseCode");
		$("promiseOrgan_update").value = ds.get("promiseOrgan");
		valid_ifPartyLeader_update();
		var idCard = _$("idCard");
		//回填年龄
		$("age").innerHTML = getAgeByCode(idCard);
	});
	L5.getCmp("grid_2").on("rowclick",function(g,rowIndex,e){
		var sm = g.getSelectionModel();
		var record = sm.getSelected();
		var winMemberDataSet = L5.DatasetMgr.lookup("winMemberDataSet");
		winMemberDataSet.setParameter("PEOPLE_ID@=",record.get("peopleId"));
		winMemberDataSet.load();
	});
}

function updateAll(){
	//---------------------------------民非基本信息校验-----------------------------------------------
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	var validate = somOrganDataSet.isValidate(true);
	if(validate != true){
		L5.Msg.alert("提示","校验未通过："+validate);
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//登记证号
	if(_$("sorgCode") != sorgCodeInit){
		if(sorgCodeNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的登记证号已存在");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}
	//民非名称/中文
	if(_$("cnName") != cnNameInit){
		if(cnNameNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的单位名称已存在");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}
	
	//组织机构代码
	if(isOrganCode($("organCode")) != true){
		L5.Msg.alert("提示","校验未通过："+"组织机构代码不正确");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}

	if(_$("organCode") != organCodeInit){
		if(organCodeNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的组织机构代码已存在");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}
	//民非邮编
	if(_isPostCode(_$("sorgPost")) != true){
		L5.Msg.alert("提示","校验未通过："+"单位邮编格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//民非电话号码
	var sorgPhones = _$("sorgPhone").split(";");
	for(i=0;i<sorgPhones.length;i++){
		if(isTel(sorgPhones[i]) != true){
			L5.Msg.alert("提示","校验未通过："+"单位电话中第"+(i+1)+"格式不正确");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}
	//民非传真
	if(isFTel(_$("sorgFax")) !=true && _$("sorgFax") != ""){
		L5.Msg.alert("提示","校验未通过："+"单位传真格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//民非网址
	if(IsURL(_$("sorgWeb")) !=true && _$("sorgWeb") != ""){
		L5.Msg.alert("提示","校验未通过："+"单位网址格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//资金数额
	var regMon = checkMoneyFix(_$("regMon"),2);
	if(regMon == "整数"){
		if(_$("regMon").length >8){
			L5.Msg.alert("提示","校验未通过："+"活动资金数额格式不正确,整数最长不超过8位");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}
	if(regMon == false){
		L5.Msg.alert("提示","校验未通过："+"活动资金数额格式不正确,小数点后应保留两位");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//用房面积
	var housingArea = checkMoneyFix(_$("housingArea"),2);
	if(housingArea == "整数"){
		if(_$("housingArea").length >8){
			L5.Msg.alert("提示","校验未通过："+"用房面积格式不正确,整数最长不超过8位");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}
	if(housingArea == false){
		L5.Msg.alert("提示","校验未通过："+"用房面积格式不正确,小数点后应保留两位");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//租（借）期限
	if(_$("resideSource") == "2"){
		if(_$("leasePeriod").trim() == ""){
			L5.Msg.alert("提示","校验未通过："+"租（借）期限不能为空");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}
//---------------------------------民非法定代表人信息校验-----------------------------------------------	
	var somDeputyPeopleDataSet = L5.DatasetMgr.lookup("somDeputyPeopleDataSet");
	var validatePeople = somDeputyPeopleDataSet.isValidate(true);
	if(validatePeople != true){
		L5.Msg.alert("提示","校验未通过："+validatePeople);
		L5.getCmp("tab").setActiveTab("1");
		return;
	}
	//身份证号
	if(checkIDCard($("idCard")) != true){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		L5.getCmp("tab").setActiveTab("1");
		return;
	}
	//本人电话
	var phones = _$("phone").split(";");
	for(i=0;i<phones.length;i++){
		if(isTel(phones[i]) != true){
			L5.Msg.alert("提示","校验未通过："+"本人电话中第"+(i+1)+"格式不正确");
			L5.getCmp("tab").setActiveTab("1");
			return;
		}
	}
	//家庭地址邮编
	if(_isPostCode(_$("postCode")) != true){
		L5.Msg.alert("提示","校验未通过："+"家庭地址邮编格式不正确");
		L5.getCmp("tab").setActiveTab("1");
		return;
	}
	//人事关系所在单位电话
	if(isTel(_$("workPhone")) != true){
		L5.Msg.alert("提示","校验未通过："+"人事关系所在单位电话格式不正确");
		L5.getCmp("tab").setActiveTab("1");
		return;
	}
	//批准文号或批准机关
	if(_$("ifPartyLeader_update") == "1"){
		if(_$("promiseCode_update").trim() == "" && _$("promiseOrgan_update").trim() == ""){
			L5.Msg.alert("提示","校验未通过："+"批准文号或批准机关不能为空");
			L5.getCmp("tab").setActiveTab("1");
			return;
		}
	}
	//批准文号
	if(_$("promiseCode_update").length > 100){
		L5.Msg.alert("提示","校验未通过："+"批准文号长度不能超过100个字符");
		L5.getCmp("tab").setActiveTab("1");
		return;
	}
	//批准机关
	if(_$("promiseOrgan_update").length > 100){
		L5.Msg.alert("提示","校验未通过："+"批准机关长度不能超过100个字符");
		L5.getCmp("tab").setActiveTab("1");
		return;
	}
//--------------------------------------------------------------------------------

//提取基本信息
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomUngovCmd");
	var organRecord = somOrganDataSet.getCurrent();
	organRecord.set("leasePeriod",_$("leasePeriod"));
	var organBean = organRecord.toBean("com.inspur.cams.sorg.base.data.SomOrgan");
//提取法定代表人
	var somPeopleList = new L5.List();
	var somDeputyPeopleDataSet = L5.DatasetMgr.lookup("somDeputyPeopleDataSet");
	var record = somDeputyPeopleDataSet.getCurrent();
	record.set("idCard",_$("idCard"));
	record.set("promiseCode",_$("promiseCode_update"));
	record.set("promiseOrgan",_$("promiseOrgan_update"));
	var deputyPeopleBean = record.toBean("com.inspur.cams.sorg.base.data.SomPeople");
	somPeopleList.add(deputyPeopleBean);
//提交保存
	command.setParameter("organBean",organBean);
	command.setParameter("somPeopleList",somPeopleList);
	command.execute("updateMain");
	if(!command.error){
		var url="jsp/cams/sorg/manage/ungov/somUngovList.jsp";
		var text="民非列表"
		L5.forward(url,text);
	}else{
		alert(command.error);
	}
}
//校验登记证号是否重复
function sorgCodeUK(){
	if(_$("sorgCode").trim() != ""){
		if(_$("sorgCode") != sorgCodeInit){
			var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomUngovCmd");
			command.setParameter("sorgCode",_$("sorgCode"));
			command.execute("sorgCodeUK");
			sorgCodeNum = command.getReturn("sorgCodeNum");
			if(sorgCodeNum != 0){
				L5.Msg.alert("提示","校验未通过："+"输入的登记证号已存在");
				return;
			}
		}
	}
}
//校验社会组织名称是否重复
function cnNameUK(){
	if(_$("cnName").trim() != ""){
		if(_$("cnName") != cnNameInit){
			var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomUngovCmd");
			command.setParameter("cnName",_$("cnName"));
			command.execute("cnNameUK");
			cnNameNum = command.getReturn("cnNameNum");
			if(cnNameNum != 0){
				L5.Msg.alert("提示","校验未通过："+"输入的单位名称已存在");
				return;
			}
		}
	}
}
//校验社会组织机构代码是否重复
function organCodeUK(){
	if(_$("organCode").trim() != ""){
		if(_$("organCode") != organCodeInit){
			var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomUngovCmd");
			command.setParameter("organCode",_$("organCode"));
			command.execute("organCodeUK");
			organCodeNum = command.getReturn("organCodeNum");
			if(organCodeNum != 0){
				L5.Msg.alert("提示","校验未通过："+"输入的组织机构代码已存在");
				return;
			}
		}
	}
}
function back(){
	var url = "jsp/cams/sorg/manage/ungov/somUngovList.jsp";
	var text = "民非列表";
	L5.forward(url,text);
}
function validateIdcard(){
	if(_$("idCard") != ""){
		if(checkIDCard($("idCard")) == true){
			var idCardValue = _$("idCard");
			var winPeopleDataSet = L5.DatasetMgr.lookup("winPeopleDataSet");
			winPeopleDataSet.setParameter("ID_CARD@=",idCardValue);
			winPeopleDataSet.load();
			winPeopleDataSet.on("load",function(ds){
				if(ds.getCount() != 0){
					var winMemberDataSet = L5.DatasetMgr.lookup("winMemberDataSet");
					winMemberDataSet.removeAll();
					var win = L5.getCmp("win_peopleValidate");
					win.show();
				}else{
					var somDeputyPeopleDataSet = L5.DatasetMgr.lookup("somDeputyPeopleDataSet");
					somDeputyPeopleDataSet.removeAll();
					var rd = somDeputyPeopleDataSet.newRecord();
					rd.set("idCard",idCardValue);
					//回填性别
					rd.set("sex",getSexByCode(idCardValue));
					//回填出生年月	
					rd.set("birthday",getBirthByCode(idCardValue));
					//回填年龄
					$("age").innerHTML = getAgeByCode(idCardValue);
					
					valid_ifPartyLeader_update();
				}
			});
			var somDeputyPeopleDataSet = L5.DatasetMgr.lookup("somDeputyPeopleDataSet");
			var record = somDeputyPeopleDataSet.getCurrent();
			//回填性别
			record.set("sex",getSexByCode(idCardValue));
			//回填出生年月	
			record.set("birthday",getBirthByCode(idCardValue));
			//回填年龄
			$("age").innerHTML = getAgeByCode(idCardValue);
		}else{
			L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
			return;
		}
	}
}
function add(){
	var idCardValue = _$("idCard");
	var somDeputyPeopleDataSet = L5.DatasetMgr.lookup("somDeputyPeopleDataSet");
	somDeputyPeopleDataSet.removeAll();
	somDeputyPeopleDataSet.newRecord();
	var record = somDeputyPeopleDataSet.getCurrent();
	record.set("idCard",idCardValue);
	var win = L5.getCmp("win_peopleValidate");
	win.setVisible(false);
	//回填性别
	record.set("sex",getSexByCode(idCardValue));
	//回填出生年月	
	record.set("birthday",getBirthByCode(idCardValue));
	//回填年龄
	$("age").innerHTML = getAgeByCode(idCardValue);
	
	valid_ifPartyLeader_update();
}
function fill(){
	var grid = L5.getCmp("grid_2");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var peopleId = record.get("peopleId");
	var somDeputyPeopleDataSet = L5.DatasetMgr.lookup("somDeputyPeopleDataSet");
	if(record.get("isLegal")=="1"){
		if(peopleIdInit!=record.get("peopleId")){
			L5.Msg.alert("提示","此人已在其他民办非企业单位担任法定代表人，不能选用!");
			return;
		}else{
			somDeputyPeopleDataSet.setParameter("SORG_ID@=",sorgId);
			somDeputyPeopleDataSet.setParameter("PEOPLE_TYPE@=","L");
			somDeputyPeopleDataSet.setParameter("IF_VALID@=","2");
		}
	}
	if(record.get("isRevoke")=="1"){
		L5.Msg.alert("提示","此人已被撤销，不能选用!");
		return ;
	}
	somDeputyPeopleDataSet.setParameter("PEOPLE_ID@=",peopleId);
	somDeputyPeopleDataSet.load();
	var win = L5.getCmp("win_peopleValidate");
	win.setVisible(false);
}
function close(){
	var win = L5.getCmp("win_peopleValidate");
	win.setVisible(false);
}

function valid_ifPartyLeader_update(){
	if(_$("ifPartyLeader_update") == "1"){
		$("promiseCode_update").style.display = "block";
		$("promiseOrgan_update").style.display = "block";
	}else{
		$("promiseCode_update").value = "";
		$("promiseOrgan_update").value = "";
		$("promiseCode_update").style.display = "none";
		$("promiseOrgan_update").style.display = "none";
	}
}
function changeResideSource(){
	if(_$("resideSource") == "2"){
		$("leasePeriod").style.display = "block";
	}else{
		$("leasePeriod").value = "";
		$("leasePeriod").style.display = "none";
	}
}
