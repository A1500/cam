var sorgCodeNum = "";
var cnNameNum = "";
var organCodeNum = "";
function init(){
	L5.getCmp("tab").setActiveTab("0");
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.newRecord();
	var somDeputyPeopleDataSet = L5.DatasetMgr.lookup("somDeputyPeopleDataSet");
	somDeputyPeopleDataSet.newRecord();
	L5.getCmp("grid_2").on("rowclick",function(g,rowIndex,e){
		var sm = g.getSelectionModel();
		var record = sm.getSelected();
		var winMemberDataSet = L5.DatasetMgr.lookup("winMemberDataSet");
		winMemberDataSet.setParameter("PEOPLE_ID@=",record.get("peopleId"));
		winMemberDataSet.load();
	});
}	
function saveAll(){
//---------------------------------基金会基本信息校验-----------------------------------------------
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	var validate = somOrganDataSet.isValidate(true);
	if(validate != true){
		L5.Msg.alert("提示","校验未通过："+validate);
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//登记证号
	if(sorgCodeNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的登记证号已存在");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//基金会名称
	if(cnNameNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的基金会名称已存在");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	
	//组织机构代码
	if(isOrganCode($("organCode")) != true){
		L5.Msg.alert("提示","校验未通过："+"组织机构代码不正确");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}

	if(organCodeNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的组织机构代码已存在");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//基金会类型
	if(_$("sorgKind") == "2"){
		if(_$("actArea").trim() == ""){
			L5.Msg.alert("提示","校验未通过："+"募捐地域不能为空");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}
	//募捐地域
	if(_$("actArea").length > 50){
		L5.Msg.alert("提示","校验未通过："+"募捐地域长度不能超过50个字符");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//基金会邮编
	if(_isPostCode(_$("sorgPost")) != true){
		L5.Msg.alert("提示","校验未通过："+"基金会邮编格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//基金会电话号码
	var sorgPhones = _$("sorgPhone").split(";");
	for(i=0;i<sorgPhones.length;i++){
		if(isTel(sorgPhones[i]) != true){
			L5.Msg.alert("提示","校验未通过："+"基金会电话中第"+(i+1)+"格式不正确");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}
	//基金会传真
	if(isFTel(_$("sorgFax")) !=true && _$("sorgFax") != ""){
		L5.Msg.alert("提示","校验未通过："+"基金会传真格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//基金会网址
	if(IsURL(_$("sorgWeb")) !=true && _$("sorgWeb") != ""){
		L5.Msg.alert("提示","校验未通过："+"基金会网址格式不正确");
		L5.getCmp("tab").setActiveTab("0");
		return;
	}
	//原始基金数额
	var regMon = checkMoneyFix(_$("regMon"),2);
	if(regMon == "整数"){
		if(_$("regMon").length >8){
			L5.Msg.alert("提示","校验未通过："+"原始基金数额格式不正确,整数最长不超过8位");
			L5.getCmp("tab").setActiveTab("0");
			return;
		}
	}
	if(regMon == false){
		L5.Msg.alert("提示","校验未通过："+"原始基金数额格式不正确,小数点后应保留两位");
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
//---------------------------------基金会法定代表人信息校验-----------------------------------------------	
	var somDeputyPeopleDataSet = L5.DatasetMgr.lookup("somDeputyPeopleDataSet");
	var validatePeople = somDeputyPeopleDataSet.isValidate(true);
	if(validatePeople != true){
		L5.Msg.alert("提示","校验未通过："+validatePeople);
		L5.getCmp("tab").setActiveTab("1");
		return;
	}
	//证件号码
	if(_$("cardType") == "01" && checkIDCard($("idCard")) != true){
		L5.Msg.alert("提示","校验未通过："+"证件号码不合法");
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
	//批准文号或批准机关
	if(_$("ifPartyLeader_add") == "1"){
		if(_$("promiseCode_add").trim() == "" && _$("promiseOrgan_add").trim() == ""){
			L5.Msg.alert("提示","校验未通过："+"批准文号或批准机关不能为空");
			L5.getCmp("tab").setActiveTab("1");
			return;
		}
	}
	//批准文号
	if(_$("promiseCode_add").length > 100){
		L5.Msg.alert("提示","校验未通过："+"批准文号长度不能超过100个字符");
		L5.getCmp("tab").setActiveTab("1");
		return;
	}
	//批准机关
	if(_$("promiseOrgan_add").length > 100){
		L5.Msg.alert("提示","校验未通过："+"批准机关长度不能超过100个字符");
		L5.getCmp("tab").setActiveTab("1");
		return;
	}
//--------------------------------------------------------------------------------
//提取基本信息
	var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomFundCmd");
	var somOrganDataSet = L5.DatasetMgr.lookup("somOrganDataSet");
	var organRecord = somOrganDataSet.getCurrent();
	organRecord.set("leasePeriod",_$("leasePeriod"));
	organRecord.set("actArea",_$("actArea"));
	organRecord.set("sorgId",sorgId);
	var organBean = organRecord.toBean("com.inspur.cams.sorg.base.data.SomOrgan");
	
//提取法定代表人
	var somPeopleList = new L5.List();
	var somDeputyPeopleDataSet = L5.DatasetMgr.lookup("somDeputyPeopleDataSet");
	var record = somDeputyPeopleDataSet.getCurrent();
	record.set("idCard",_$("idCard"));
	record.set("sorgDuties","00001");
	record.set("promiseCode",_$("promiseCode_add"));
	record.set("promiseOrgan",_$("promiseOrgan_add"));
	var deputyPeopleBean = record.toBean("com.inspur.cams.sorg.base.data.SomPeople");
	somPeopleList.add(deputyPeopleBean);
	
//提交保存
	command.setParameter("organBean",organBean);
	command.setParameter("somPeopleList",somPeopleList);
	command.setParameter("sorgType","J");
	command.execute("saveMain");
	if(!command.error){
		var url="jsp/cams/sorg/manage/fund/somFundList.jsp";
		var text="基金会主体列表"
		L5.forward(url,text);
	}else{
		alert(command.error);
	}
}
function back(){
	var url = "jsp/cams/sorg/manage/fund/somFundList.jsp";
	var text = "基金会主体列表";
	L5.forward(url,text);
}
//校验登记证号是否重复
function sorgCodeUK(){
	if(_$("sorgCode").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomFundCmd");
		command.setParameter("sorgCode",_$("sorgCode"));
		command.execute("sorgCodeUK");
		sorgCodeNum = command.getReturn("sorgCodeNum");
		if(sorgCodeNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的登记证号已存在");
			return;
		}
	}
}
//校验社会组织名称是否重复
function cnNameUK(){
	if(_$("cnName").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomFundCmd");
		command.setParameter("cnName",_$("cnName"));
		command.execute("cnNameUK");
		cnNameNum = command.getReturn("cnNameNum");
		if(cnNameNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的基金会名称已存在");
			return;
		}
	}
}
//校验社会组织机构代码是否重复
function organCodeUK(){
	if(_$("organCode").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomFundCmd");
		command.setParameter("organCode",_$("organCode"));
		command.execute("organCodeUK");
		organCodeNum = command.getReturn("organCodeNum");
		if(organCodeNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的组织机构代码已存在");
			return;
		}
	}
}
function validateCardType(){
	if(_$("cardType") == "01"){
		if(checkIDCard($("idCard")) != true){
			L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
			return;
		}
	}
}
function validateIdcard(){
	if(_$("idCard") == ""){
		return;
	}
	if(_$("cardType") == ""){
		L5.Msg.alert("提示","校验未通过："+'请选择"证件类型"');
		return;
	}
	if(_$("idCard").length > 18){
		L5.Msg.alert("提示","校验未通过："+'"证件号码"长度不能超过18个字符');
		return;
	}
	if(_$("cardType") == "01"){
		if(checkIDCard($("idCard")) == true){
			var idCardValue = _$("idCard");
			var cardTypeValue = _$("cardType");
			var winPeopleDataSet = L5.DatasetMgr.lookup("winPeopleDataSet");
			winPeopleDataSet.setParameter("CARD_TYPE@=",cardTypeValue);
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
					rd.set("cardType",cardTypeValue);
					rd.set("idCard",idCardValue);
					//回填性别
					rd.set("sex",getSexByCode(idCardValue));
					//回填出生年月	
					rd.set("birthday",getBirthByCode(idCardValue));
					//回填年龄
					$("age").innerHTML = getAgeByCode(idCardValue);
					
					valid_ifPartyLeader_add();
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
			L5.Msg.alert("提示","校验未通过："+"证件号码不合法");
			return;
		}
	}else{
		var cardTypeValue = _$("cardType");
		var idCardValue = _$("idCard").toUpperCase();
		var winPeopleDataSet = L5.DatasetMgr.lookup("winPeopleDataSet");
		winPeopleDataSet.setParameter("CARD_TYPE",cardTypeValue);
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
				rd.set("cardType",cardTypeValue);
				rd.set("idCard",idCardValue);
				valid_ifPartyLeader_add();
			}
		});
	}
}
function addItem(){
	var idCardValue = _$("idCard");
	var cardTypeValue = _$("cardType");
	var somDeputyPeopleDataSet = L5.DatasetMgr.lookup("somDeputyPeopleDataSet");
	somDeputyPeopleDataSet.removeAll();
	somDeputyPeopleDataSet.newRecord();
	var record = somDeputyPeopleDataSet.getCurrent();
	record.set("idCard",idCardValue);
	record.set("cardType",cardTypeValue);
	if(cardTypeValue == '01'){
		//回填性别
		record.set("sex",getSexByCode(idCardValue));
		//回填出生年月	
		record.set("birthday",getBirthByCode(idCardValue));
		//回填年龄
		$("age").innerHTML = getAgeByCode(idCardValue);
	}
	valid_ifPartyLeader_add();
	var win = L5.getCmp("win_peopleValidate");
	win.setVisible(false);
}
function editItem(){
	var grid = L5.getCmp("grid_2");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return ;
	}
	if(record.get("isLegal")=="1"){
		L5.Msg.alert("提示","此人已在其他基金会或社会团体担任法定代表人，不能选用!");
		return ;
	}
	if(record.get("isRevoke")=="1"){
		L5.Msg.alert("提示","此人已被撤销，不能选用!");
		return ;
	}
	var peopleId = record.get("peopleId");
	var somDeputyPeopleDataSet = L5.DatasetMgr.lookup("somDeputyPeopleDataSet");
	somDeputyPeopleDataSet.setParameter("PEOPLE_ID@=",peopleId);
	somDeputyPeopleDataSet.load();
	somDeputyPeopleDataSet.on("load",function(ds){
		valid_ifPartyLeader_add();
		//回填年龄
		if(_$("cardType") == "01"){
			var idCard = _$("idCard");
			$("age").innerHTML = getAgeByCode(idCard);
		}else{
			$("age").innerHTML = getAgeByBirthday(ds.get("birthday"));
		}
	});
	var win = L5.getCmp("win_peopleValidate");
	win.setVisible(false);
}

function closeItem(){
	var win = L5.getCmp("win_peopleValidate");
	win.setVisible(false);
}

function valid_ifPartyLeader_add(){
	if(_$("ifPartyLeader_add") == "1"){
		$("promiseCode_add").style.display = "block";
		$("promiseOrgan_add").style.display = "block";
	}else{
		$("promiseCode_add").value = "";
		$("promiseOrgan_add").value = "";
		$("promiseCode_add").style.display = "none";
		$("promiseOrgan_add").style.display = "none";
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
function changSorgKind(){
	if(_$("sorgKind") == "2"){
		$("actArea").style.display = "block";
	}else{
		$("actArea").value = "";
		$("actArea").style.display = "none";
	}
}
function showAge(){
	$("age").innerHTML = getAgeByBirthday(_$("birthday"));
}
