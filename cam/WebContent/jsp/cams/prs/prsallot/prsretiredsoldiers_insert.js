var orgName;
var orgFullName; // 行政区划全称
var ifQuery = false; // 是否已查询当前行政区划名称

/*
 * 从数据库dic_city中查询organName
 */
function queryOrganName() {
	if (!ifQuery) {
		if (orgCode != null && orgCode != "") {
			var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			command.setParameter("ID", orgCode);
			command.execute("findOrganName");
			var fullName = command.getReturn("organName");
			if (fullName != null && fullName != "") {
				orgFullName = fullName;
			}
			ifQuery = true;
		}
	}
}

function init() {
	var OrgNameDataset = L5.DatasetMgr.lookup("OrgNameDataset");
	OrgNameDataset.setParameter("filterSql", "id='" + orgCode + "'");
	OrgNameDataset.load();
	OrgNameDataset.on("load", function() {
				orgName = OrgNameDataset.get("text");
			});

	var retiredSoldierDataset = L5.DatasetMgr.lookup("retiredSoldierDataset");
	retiredSoldierDataset.newRecord();
	var recordSoldier = retiredSoldierDataset.getCurrent();
	recordSoldier.set("retiredSoldierType", type);
	recordSoldier.set("sex", "1");
	recordSoldier.set("naton", "01");
	recordSoldier.set("placemenRenson", "1");
	recordSoldier.set("transFile", "档案");
	recordSoldier.set("uploadFlag", "0");
	recordSoldier.set("disabilityFlag", "0");
	recordSoldier.set("trainingflag", "0");
	recordSoldier.set("emplacementflag", "0");
	recordSoldier.set("allotFlag", '0');
	recordSoldier.set("directsergeant", '1');
	recordSoldier.set("filesReceiveTime", getCurDate());
	var prssoldiersArmyDataset = L5.DatasetMgr.lookup("prssoldiersArmyDataset");
	prssoldiersArmyDataset.newRecord();
	var prsawardsmeritoriousDataset = L5.DatasetMgr
			.lookup("prsawardsmeritoriousDataset");
//	prsawardsmeritoriousDataset.newRecord();
	var awardGrid = L5.getCmp('awardGridPanel');
	awardGrid.stopEditing();
	document.getElementById("flag").value = '1';

	if (orgCode.substring(4) != "00000000" && orgCode.substring(6) == "000000") { // 县级用户
		queryOrganName(); // 获得行政区划全称
		document.getElementById("domicileName").disabled = true;
		document.getElementById("domicileCode").value = orgCode;
		document.getElementById("domicileName").value = orgFullName;
		var retiredSoldierDataset = L5.DatasetMgr
				.lookup("retiredSoldierDataset");
		var recordSoldier = retiredSoldierDataset.getCurrent();
		recordSoldier.set("wherePlacemen", orgCode);
		recordSoldier.set("domicileName", orgFullName);
	}
}

function save() {
	var retiredSoldierDataset = L5.DatasetMgr.lookup("retiredSoldierDataset");
	var recordSoldier = retiredSoldierDataset.getCurrent();
		/*
	var specialtySelect = document.getElementById("specialtySelect").value;
	if(specialtySelect=="0"){
		var spec = document.getElementById("specialtyInput").value;
		recordSoldier.set("specialty",spec)
	}else{
		recordSoldier.set("specialty",specialtySelect)
	}*/
	var flag = document.getElementById("flag").value;
	if (flag == '2') {
		L5.MessageBox.confirm('确定', '确定要将选中的记录退档吗?', function(state) {
			if (state == "yes") {
				recordSoldier.set("flag", '2');
			} else {
				recordSoldier.set("flag", '1');
			}
			var prssoldiersArmyDataset = L5.DatasetMgr
					.lookup("prssoldiersArmyDataset");
			var recordArmy = prssoldiersArmyDataset.getCurrent();

			retiredSoldierDataset.set("soldiersId", soldierID);
			prssoldiersArmyDataset.set("armyId", armyId);
			prssoldiersArmyDataset.set("soldiersId", soldierID);

			var prsawardsmeritoriousDataset = L5.DatasetMgr
					.lookup("prsawardsmeritoriousDataset");

			var isValidate = retiredSoldierDataset.isValidate(true);
			if (isValidate !== true) {
				L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
				return false;
			}

			isValidate = prssoldiersArmyDataset.isValidate(true);
			if (isValidate !== true) {
				L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
				return false;
			}
			var isValidate = prsawardsmeritoriousDataset.isValidate();
			if (isValidate != true) {
				L5.Msg.alert('提示', "校验未通过,不能保存!" + isValidate);
				return false;
			}
			var idCard = document.getElementById("idcardNo");
			if(!checkIDCard(idCard)){
			    L5.Msg.alert("提示", "身份证格式不正确!");
			    return false;
			}
			var birthday = document.getElementById("birthday").value;
			if(!checkBirthday(birthday)&&(birthday!="")){
			    L5.Msg.alert("提示", "出生日期格式或者内容不正确，出生日期不能大于当前时间!");
			    return false;
			}
			//身份证号码
			var idCardValue = document.getElementById("idcardNo").value;
			if(idCardValue != "" && birthday != "") {
				var birthdayValue;
				if (15 == idCardValue.length) { // 15位身份证号码
					birthdayValue = idCardValue.substring(6,8);
					if (parseInt(birthdayValue) < 10) {
						birthdayValue = '20' + birthdayValue;
					} else {
						birthdayValue = '19' + birthdayValue;
					}
					
				}
				if (18 == idCardValue.length) { // 18位身份证号码
					birthdayValue = idCardValue.substring(6,14);
				}
				var bday = birthday.replace(/-/g,"");
				if(bday != birthdayValue) {
					 L5.Msg.alert("提示", "出生日期和身份证号出生日期不符!");
					 return false;
				}
			}
			var enlistTime = document.getElementById("enlistTime").value;
			if(!checkBirthday(enlistTime)&&(enlistTime!="")){
			    L5.Msg.alert("提示", "入伍时间格式或者内容不正确，入伍时间不能大于当前时间!");
			    return false;
			}
			//入伍时间不能早于出生日期
			if(birthday != "" && enlistTime != "") {
				if(birthday > enlistTime) {
					L5.Msg.alert("提示", "入伍时间不能早于出生日期!");
				    return false;
				}
			}
			var retiredTime = document.getElementById("retiredTime").value;
			if(!checkBirthday(retiredTime)&&(retiredTime!="")){
			    L5.Msg.alert("提示", "退役时间格式或者内容不正确，退役时间不能大于当前时间!");
			    return false;
			}
			//退役时间不能早于入伍时间
			if(retiredTime != "" && enlistTime != "") {
				if(retiredTime < enlistTime) {
					L5.Msg.alert("提示", "退役时间不能早于入伍时间!");
				    return false;
				}
			}
			var filesReceiveTime = document.getElementById("filesReceiveTime").value;
			if(!checkBirthday(filesReceiveTime)&&(filesReceiveTime!="")){
			    L5.Msg.alert("提示", "接收档案时间格式或者内容不正确!");
			    return false;
			}
			//判断联系方式格式
			var tel = document.getElementById("tel").value;
			if(tel != "") {
				var tel_validate = validateTel(tel);
				if(!tel_validate) {
					L5.Msg.alert("提示", "请输入正确的联系方式!");
				    return false;
				}
			}
			//验证姓名
			var name = document.getElementById("name").value;
			if(name != "") {
				if(!validateName(name)) {
					L5.Msg.alert("提示", "请输入正确的姓名!");
				    return false;
				}
			}
			var awardRecords = prsawardsmeritoriousDataset
					.getAllChangedRecords();
			recordSoldier.set("allotFlag","0")
			var command = new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersCommand");
			command.setParameter("recordSoldier", recordSoldier);
			command.setParameter("recordArmy", recordArmy);
			command.setParameter("records", awardRecords);
			command.execute("saveBaseInfo");

			if (!command.error) {
				history.go(-1);
			} else {
				L5.Msg.alert("错误", "保存失败");
			}
		});
	} else {
		recordSoldier.set("flag", '1');
		var prssoldiersArmyDataset = L5.DatasetMgr
				.lookup("prssoldiersArmyDataset");
		var recordArmy = prssoldiersArmyDataset.getCurrent();

		retiredSoldierDataset.set("soldiersId", soldierID);
		prssoldiersArmyDataset.set("armyId", armyId);
		prssoldiersArmyDataset.set("soldiersId", soldierID);

		var prsawardsmeritoriousDataset = L5.DatasetMgr
				.lookup("prsawardsmeritoriousDataset");

		var isValidate = retiredSoldierDataset.isValidate(true);
		if (isValidate !== true) {
			L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
			return false;
		}

		isValidate = prssoldiersArmyDataset.isValidate(true);
		if (isValidate !== true) {
			L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
			return false;
		}
		var isValidate = prsawardsmeritoriousDataset.isValidate();
		if (isValidate != true) {
			L5.Msg.alert('提示', "校验未通过,不能保存!" + isValidate);
			return false;
		}
		var idCard = document.getElementById("idcardNo");
		if(!checkIDCard(idCard)){
		    L5.Msg.alert("提示", "身份证格式不正确!");
		    return false;
		}
		var birthday = document.getElementById("birthday").value;
		if(!checkBirthday(birthday)&&(birthday!="")){
		    L5.Msg.alert("提示", "出生日期格式或者内容不正确，出生日期不能大于当前时间!");
		    return false;
		}
		//身份证号码
		var idCardValue = document.getElementById("idcardNo").value;
		if(idCardValue != "" && birthday != "") {
			var birthdayValue;
			if (15 == idCardValue.length) { // 15位身份证号码
				birthdayValue = idCardValue.substring(6,8);
				if (parseInt(birthdayValue) < 10) {
					birthdayValue = '20' + birthdayValue;
				} else {
					birthdayValue = '19' + birthdayValue;
				}
				
			}
			if (18 == idCardValue.length) { // 18位身份证号码
				birthdayValue = idCardValue.substring(6,14);
			}
			var bday = birthday.replace(/-/g,"");
			if(bday != birthdayValue) {
				 L5.Msg.alert("提示", "出生日期和身份证号出生日期不符!");
				 return false;
			}
		}
		var enlistTime = document.getElementById("enlistTime").value;
		if(!checkBirthday(enlistTime)&&(enlistTime!="")){
		    L5.Msg.alert("提示", "入伍时间格式或者内容不正确，入伍时间不能大于当前时间!");
		    return false;
		}
		
		//入伍时间不能早于出生日期
		if(birthday != "" && enlistTime != "") {
			if(birthday > enlistTime) {
				L5.Msg.alert("提示", "入伍时间不能早于出生日期!");
			    return false;
			}
		}
		var retiredTime = document.getElementById("retiredTime").value;
		if(!checkBirthday(retiredTime)&&(retiredTime!="")){
		    L5.Msg.alert("提示", "退役时间格式或者内容不正确，退役时间不能大于当前时间!");
		    return false;
		}
		//退役时间不能早于入伍时间
		if(retiredTime != "" && enlistTime != "") {
			if(retiredTime < enlistTime) {
				L5.Msg.alert("提示", "退役时间不能早于入伍时间!");
			    return false;
			}
		}
		var filesReceiveTime = document.getElementById("filesReceiveTime").value;
		if(!checkBirthday(filesReceiveTime)&&(filesReceiveTime!="")){
		    L5.Msg.alert("提示", "接收档案时间格式或者内容不正确!");
		    return false;
		}
		//判断联系方式格式
		var tel = document.getElementById("tel").value;
		if(tel != "") {
			var tel_validate = validateTel(tel);
			if(!tel_validate) {
				L5.Msg.alert("提示", "请输入正确的联系方式!");
			    return false;
			}
		}
		//验证姓名
		var name = document.getElementById("name").value;
		if(name != "") {
			if(!validateName(name)) {
				L5.Msg.alert("提示", "请输入正确的姓名!");
			    return false;
			}
		}
		var awardRecords = prsawardsmeritoriousDataset.getAllChangedRecords();
		var command = new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersCommand");
		command.setParameter("recordSoldier", recordSoldier);
		command.setParameter("recordArmy", recordArmy);
		command.setParameter("records", awardRecords);
		command.execute("saveBaseInfo");

		if (!command.error) {
			L5.Msg.alert("提示", "保存成功!", function() {
				var data = new L5.Map();
				data.put("method", "UPDATE");
				data.put("idField", soldierID);
				data.put("type", recordSoldier.get("retiredSoldierType"));
				var url = 'jsp/cams/prs/prsretiredsoldiers/prsretiredsoldiers_detail.jsp';
				var text = '退役士兵修改';
				L5.forward(url, text, data);
			});
		} else {
			L5.Msg.alert("错误", "保存失败!");
		}
	}

}
function del() {
	var editGrid = L5.getCmp('awardGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert('提示', "请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?', function(state) {
				if (state == "yes") {
					for (var i = 0; i < selected.length; i++) {
						prsawardsmeritoriousDataset.remove(selected[i]);
					}
					prsawardsmeritoriousDataset.commitChanges();
				}
			});
}
function reset() {
	prsawardsmeritoriousDataset.rejectChanges();
}

function insert() {
	var record = prsawardsmeritoriousDataset.getCurrent();
	if (record == null) {
		prsawardsmeritoriousDataset.newRecord();
		record = prsawardsmeritoriousDataset.getCurrent();
	} else {
		var times = record.get("awardsNumber");
		if (isNaN(times) || times == '') {
			L5.Msg.alert('提示', "获奖次数格式不正确,不能保存! ");

		} else {
			prsawardsmeritoriousDataset.newRecord();
			var Grid = L5.getCmp('awardGridPanel');
			Grid.stopEditing();
		}
	}

}
function getServicedTime() {
	var retiredSoldierDataset = L5.DatasetMgr.lookup("retiredSoldierDataset");
	var recordSoldier = retiredSoldierDataset.getCurrent();
	var timeStart = recordSoldier.get("enlistTime").split("-")[0];
	var timeEnd = recordSoldier.get("retiredTime").split("-")[0];
	var servicedtime = timeEnd - timeStart;
	if (servicedtime <= 0) {
		servicedtime = 1;
	}
	document.getElementById("servicedTime").value = servicedtime;
	return servicedtime;
}

function back() {
	history.go(-1);
}
function forHelp() {
	// var struId='<%=struId%>';

	/**queryOrganName(); // 获得行政区划全称
	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode="
							+ orgCode + "&organName=" + orgFullName, "",
					"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");*/
	var organName="山东省";
	var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode="+orgCode+"&organName="+encodeURIComponent(encodeURIComponent(organName)),"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[4];
		var retiredSoldierDataset = L5.DatasetMgr
				.lookup("retiredSoldierDataset");
		var recordSoldier = retiredSoldierDataset.getCurrent();
		if(list[0].substring(6)=="999000"){
      		recordSoldier.set("wherePlacemen", list[0].substring(0,6)+"000000");
      		recordSoldier.set("domicileName", list[4]);
    	}else{
      		recordSoldier.set("wherePlacemen", list[0]);
      		recordSoldier.set("domicileName", list[4]);
    	}
	}
}

function func_QueryIdCard() {
	var retiredSoldierDataset = L5.DatasetMgr.lookup("retiredSoldierDataset");
	var idCard = document.getElementById("idcardNo");
	var idCardValue = idCard.value;
	if (idCardValue == null || idCardValue == "") {
		return;
	}
	if (!checkIDCard(idCard)) {
		L5.Msg.alert("提示", "身份证格式不正确!");
		return false;
	}
	var birthdayValue;
	if (15 == idCardValue.length) { // 15位身份证号码
		birthdayValue = idCardValue.charAt(6) + idCardValue.charAt(7);
		if (parseInt(birthdayValue) < 10) {
			birthdayValue = '20' + birthdayValue;
		} else {
			birthdayValue = '19' + birthdayValue;
		}
		birthdayValue = birthdayValue + '-' + idCardValue.charAt(8)
				+ idCardValue.charAt(9) + '-' + idCardValue.charAt(10)
				+ idCardValue.charAt(11);
		retiredSoldierDataset.getCurrent().set("birthday", birthdayValue);
	}
	if (18 == idCardValue.length) { // 18位身份证号码
		birthdayValue = idCardValue.charAt(6) + idCardValue.charAt(7)
				+ idCardValue.charAt(8) + idCardValue.charAt(9) + '-'
				+ idCardValue.charAt(10) + idCardValue.charAt(11) + '-'
				+ idCardValue.charAt(12) + idCardValue.charAt(13);
		retiredSoldierDataset.getCurrent().set("birthday", birthdayValue);
	}
}

function func_ForDomicileSelect() {
	var retiredSoldierDataset = L5.DatasetMgr.lookup("retiredSoldierDataset");
	var recordSoldier = retiredSoldierDataset.getCurrent();
	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode=370000000000&organName=山东省",
					"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		recordSoldier.set("enlistPlace", list[0]);
		recordSoldier.set("enlistPlaceName", list[4]);
	}
}

function func_sergeantLevel() {
	var soldierType = document.getElementById("retiredSoldierType").value;
	if (soldierType == '0') {
		document.getElementById("sergeantLevel").disabled = true;
		document.getElementById("sergeantLevel").value = '';
	} else {
		document.getElementById("sergeantLevel").disabled = false;
	}
}
function changeLevel(){
	var ifmental = document.getElementById("mentalGrade").value;
	var injuringGrade = document.getElementById("injuringGrade");
	if(ifmental =="1" ){
		injuringGrade.options.length = 0;
		var varItem = new Option("请选择... ","");      
        injuringGrade.options.add(varItem); 
		var varItem = new Option("一级","1");      
        injuringGrade.options.add(varItem); 
       	var varItem = new Option("二级","2");      
        injuringGrade.options.add(varItem);  
        var varItem = new Option("三级","3");   
        injuringGrade.options.add(varItem);  
        var varItem = new Option("四级","4");      
        injuringGrade.options.add(varItem);  
        var varItem = new Option("五级","5");      
        injuringGrade.options.add(varItem);  
       	var varItem = new Option("六级","6");      
        injuringGrade.options.add(varItem);      
	}else if(ifmental =="0"){
		injuringGrade.options.length = 0;
		var varItem = new Option("请选择... ","");      
        injuringGrade.options.add(varItem);
		var varItem = new Option("一级","1");      
        injuringGrade.options.add(varItem); 
       	var varItem = new Option("二级","2");      
        injuringGrade.options.add(varItem);  
        var varItem = new Option("三级","3");   
        injuringGrade.options.add(varItem);  
        var varItem = new Option("四级","4"); 
        injuringGrade.options.add(varItem);      
	}
}
/**
 * 计算服役时间
 */
function serveTime(){
	var retiredSoldierDataset = L5.DatasetMgr.lookup("retiredSoldierDataset");
	var enlistTime = document.getElementById("enlistTime").value;
	var retiredTime = document.getElementById("retiredTime").value;
	if(retiredTime==""||enlistTime==""||!validateDateFormat(retiredTime)||!validateDateFormat(enlistTime)){
		retiredSoldierDataset.set("servicedTimeTrs",null);//清空服役年限
	}
	else{
		var a=enlistTime;
		var b=retiredTime;
		var datea=a.split("-");//将格式为yyyy-mm-dd的日期分开存于字符串
		var dateb=b.split("-");
		if(datea[1].substr(0,1)=="0"){//去掉月份中的0，例如09就转化为9
			datea[1]=datea[1].substr(1,1);
		}
		if(dateb[1].substr(0,1)=="0"){//去掉月份中的0，例如09就转化为9
			dateb[1]=dateb[1].substr(1,1);
		}
		var montha = parseInt(datea[0])*12+parseInt(datea[1]);//计算月数，用于下一步计算月数差
		var monthb = parseInt(dateb[0])*12+parseInt(dateb[1]);
		var monthAll = parseInt(monthb)-parseInt(montha);//计算月数差（年数*12转移到月数中）
		var year = parseInt(dateb[0])-parseInt(datea[0]);//计算年数差
		var month = 0;
		if(parseInt(datea[1])<=parseInt(dateb[1])){//计算月数差
			month =parseInt(dateb[1])-parseInt(datea[1]);
		}else{
			year = parseInt(year)-1;
			month = parseInt(dateb[1])+12-parseInt(datea[1]);
		}
		var servicedTime = monthAll;//传后台值
		var servicedTimeTrs = year+"年"+month+"个月";//传前台值
		document.getElementById("servicedTimeTrs").disabled = true;
		retiredSoldierDataset.set("servicedTime",servicedTime);//前台hidden
		retiredSoldierDataset.set("servicedTimeTrs",servicedTimeTrs);//填写计算好的服役时间
	}
}
/**
 * 时间格式yyyy-mm-dd验证
 * @param date
 * @returns {Boolean}
 */
function validateDateFormat(date) {
	if (!((/^\d{4}-\d{2}-\d{2}$/).test(date))) {
		return false;
	}
	var r = date.match(/\d{1,4}/g);
	if (r == null) {
		return false;
	};
	var d = new Date(r[0], r[1] - 1, r[2]);
	return (d.getFullYear() == r[0] && (d.getMonth() + 1) == r[1] && d
			.getDate() == r[2]);
}
/**
 * 判断联系电话
 */
function validateTel(tel) {
	var reg_1 = /^((((\d{3}[-]){0,1})|((\d{4}[-]){0,1})){0,1}\d{7,9})$/;
	var reg_2 = /^(13[0-9]|15[0-9]|18[0-9]|14[0-9])\d{8}$/;
	if(reg_1.test(tel.trim()) || reg_2.test(tel.trim())) {
	    return true;
	} else {
		return false;
	}
}
/**
 * 姓名验证
 */
function validateName(name) {
	var reg = /^[\u4e00-\u9fa5]*$/;
	if(reg.test(name.trim())) {
		return true;
	} else {
		return false;
	}
}
/**
 * 名字去空格
 */
function nameNew(){
	var retiredSoldierDataset = L5.DatasetMgr.lookup("retiredSoldierDataset");
	var name = document.getElementById("name").value;
	name = name.replace(/\s/ig,'');//去掉空格符，制表符，换行符等一系列空白符
	retiredSoldierDataset.set("name",name);
	document.getElementById("name").value = name;
}
/**
 * 弹窗编辑立功受奖信息
 */
function insertWin(){
	var prsawardsmeritoriousDataset = L5.DatasetMgr
	.lookup("prsawardsmeritoriousDataset");
	prsawardsmeritoriousDataset.newRecord();
	var win=L5.getCmp("awardWin");
	win.show(this);
}

/**
 * 继续添加按钮
 */
function awardSubmit(){
	var prsawardsmeritoriousDataset = L5.DatasetMgr.lookup("prsawardsmeritoriousDataset");
	var record = prsawardsmeritoriousDataset.getCurrent();
	if(record==null){
		
	}else{
		var awardsType = record.get("awardsType");
		if(awardsType==""||awardsType==null){
			L5.Msg.alert('提醒','立功受奖种类不能为空！');
			return false;
		}
		var awardsName = record.get("awardsName");
		if(awardsName==""||awardsName==null){
			L5.Msg.alert('提醒','立功受奖名称不能为空！');
			return false;
		}
		var awardsNumber = record.get("awardsNumber");
		if(awardsNumber==""||awardsNumber==null){
			L5.Msg.alert('提醒','立功受奖次数不能为空！');
			return false;
		}
		if(isNaN(awardsNumber)){
			L5.Msg.alert('提醒','立功受奖次数格式不正确！');
			return false;
		}
		var awardsTime = record.get("awardsTime");
		if(awardsTime!=""&&awardsTime!=null){
			if(isNaN(awardsTime)||awardsTime.length!=4){
				L5.Msg.alert('提醒','立功受奖年份格式不正确！');
				return false;
			} 
		}
	}
	prsawardsmeritoriousDataset.newRecord();
}

/**
 * 修改立功次数，当立功次数小于0时，改为默认值1
 */
function changeAwardsNumber(cell, col, record, row) {
	if(isNaN(cell)) {
		L5.Msg.alert('提醒','立功受奖次数格式不正确！');
		record.set("awardsNumber",1);
		return 1;
	}
	if(cell != undefined && cell != "") {
		var num = parseInt(cell);
		if(num < 1) {
			record.set("awardsNumber",1);
			return 1;
		} else {
			return cell;
		}
	} else if(cell == undefined) {
		return "";
	} else {
		return cell;
	}
}

/**
 * 关闭按钮
 */
function close(){

var prsawardsmeritoriousDataset=L5.DatasetMgr.lookup("prsawardsmeritoriousDataset");
		prsawardsmeritoriousDataset.remove(prsawardsmeritoriousDataset.getCurrent());

L5.getCmp("awardWin").setVisible(false);
//prsawardsmeritoriousDataset.setParameter("SOLDIERS_ID",idField);
 //prsawardsmeritoriousDataset.load();
}

/**
 * 关闭弹窗（确定按钮）
 */
function hide(){
	var prsawardsmeritoriousDataset = L5.DatasetMgr.lookup("prsawardsmeritoriousDataset");
	var record = prsawardsmeritoriousDataset.getCurrent();
	if(record==null){
		
	}else{
		var awardsType = record.get("awardsType");
		if(awardsType==""||awardsType==null){
			L5.Msg.alert('提醒','立功受奖种类不能为空！');
			return false;
		}
		var awardsName = record.get("awardsName");
		if(awardsName==""||awardsName==null){
			L5.Msg.alert('提醒','立功受奖名称不能为空！');
			return false;
		}
		var awardsNumber = record.get("awardsNumber");
		if(awardsNumber==""||awardsNumber==null){
			L5.Msg.alert('提醒','立功受奖次数不能为空！');
			return false;
		}
		if(isNaN(awardsNumber)){
			L5.Msg.alert('提醒','立功受奖次数格式不正确！');
			return false;
		}
		var awardsTime = record.get("awardsTime");
		if(awardsTime!=""&&awardsTime!=null){
			if(isNaN(awardsTime)||awardsTime.length!=4){
				L5.Msg.alert('提醒','立功受奖年份格式不正确！');
				return false;
			} 
		}
	}
	L5.getCmp("awardWin").setVisible(false);
}
/*
function specChanges(){
	var retiredSoldierDataset = L5.DatasetMgr.lookup("retiredSoldierDataset");
	var specialtySelect = document.getElementById("specialtySelect").value;
	if(specialtySelect=="0"){
		document.getElementById("specialtyInput").disabled = false;
	}else{
		document.getElementById("specialtyInput").disabled = true;
		document.getElementById("specialtyInput").value = "";
		retiredSoldierDataset.set("specialty",specialtySelect);
	}
}*/