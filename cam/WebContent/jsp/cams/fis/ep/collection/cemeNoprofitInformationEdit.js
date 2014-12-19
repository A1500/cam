function init() {
	if (method == "INSERT") {
		document.getElementById("manaLevelId").onchange = function() {
			createNoGyCode();
		};

		ds.newRecord({
					"prop" : "1"
				});
		var command = new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
		command.setParameter("IdHelp", "Id32");
		command.execute();
		var newId = command.getReturn("id");
		govAppDs.newRecord({
					"recordId" : newId,
					"deptId" : "县级民政部门批准建设"
				});
		command.execute();
		var newId2 = command.getReturn("id");
		govAppDs.newRecord({
					"recordId" : newId2,
					"deptId" : "县报市级民政部门备案"
				});
		// document.getElementById("totalAreaUnits").selectedIndex = 1;
	} else if (method == "UPDATE") {
		// document.getElementById("manaImg").style.display = "none";
		document.getElementById("cemeId").disabled = "disabled";

		ds.baseParams["CEME_ID@="] = idField;
		ds.load();
		govAppDs.baseParams["CEME_ID@="] = idField;
		govAppDs.load();
		// document.getElementById("cemeId").disabled="disabled";
		// document.getElementById("createID").style.display="none";
	} else {
		ds.newRecord({
					"prop" : "1"
				});
		document.getElementById("return").style.display = "none";
	}
	L5.QuickTips.init();
}


//计算建设资金合计
function getFundTotal(obj){
	if(!_isNum(obj.value)){
		L5.Msg.alert("提示","请输入数字！");
		obj.value=0;
		obj.focus();
	}
	var ds=L5.DatasetMgr.lookup("ds");
	var fundFinance=document.getElementById("fundFinance").value;
	var fundHigher=document.getElementById("fundHigher").value;
	var fundSelf=document.getElementById("fundSelf").value;
	var fundLottery=document.getElementById("fundLottery").value;
	var fundOther=document.getElementById("fundOther").value;
	if(!fundFinance){
		fundFinance=0;
		ds.set("fundFinance",0);
	}
	if(!fundHigher){
		fundHigher=0;
		ds.set("fundHigher",0);
	}
	if(!fundSelf){
		fundSelf=0;
		ds.set("fundSelf",0);
	}
	if(!fundLottery){
		fundLottery=0;
		ds.set("fundLottery",0);
	}
	if(!fundOther){
		fundOther=0;
		ds.set("fundOther",0);
	}
	if(ds.getCount()>0){
		ds.set("fundTotal",fundFinance*1+fundHigher*1+fundSelf*1+fundLottery*1+fundOther*1)
	}
	
}	
function save() {
	var cemeid = document.getElementById("cemeId").value;
	if (!regexG.test(cemeid)) {
		L5.Msg
				.alert('提示',
						'公益性公墓编号不符合标准!规则如\"GZ3701000000-XXX\"(GZ3701000000为主管单位行政区划编码，XXX为顺序号)');
		return false;
	}

	// 保存校验
	var ds = L5.DatasetMgr.lookup("ds");
	var valid = ds.isValidate(true);
	if (valid !== true) {
		L5.Msg.alert("提示", "校验未通过：" + valid);
		return false;
	}
	var record=ds.getCurrent();
   	if(!(record.get("greenArea")||record.get("greenRatio"))){
		L5.Msg.alert('提示','绿地面积、绿化覆盖率二者必填其一!');
		return false;
   	}
   	if(record.get("totalArea")&&record.get("greenArea")){
   	   	if(record.get("greenArea")/(record.get("totalArea")*666.66666666667)<0.4){
   			L5.Msg.alert('提示','绿地面积不能低于占地面积的40%');
   			return false;
   	   	}
   	}
   	if(record.get("greenRatio")&&(record.get("greenRatio")<75)){
		L5.Msg.alert('提示','绿化覆盖率不能低于75%!');
		return false;
   	}
	// 政府批准文号-保存校验
	var govAppDs = L5.DatasetMgr.lookup("govAppDs");
	var valid = govAppDs.isValidate(true);
	if (valid !== true) {
		L5.Msg.alert("提示", "校验未通过：" + valid);
		return false;
	}

	var record = ds.getCurrent();
	var command = new L5.Command("com.inspur.cams.fis.ep.base.cmd.FisCemeCmd");
	command.setParameter("record", record);
	if (method == "UPDATE") {
		command.setParameter("govAppRecords", govAppDs.getAllChangedRecords());
		command.execute("update");
	} else {
		command.setParameter("govAppRecords", govAppDs.getAllRecords());
		command.execute("insert");
	}
	if (!command.error) {
		L5.Msg.alert('提示', "保存成功!");
		back();
		if (method == "INSERT" || method == "UPDATE") {
			method = "UPDATE";
			var cemeId = getParam("cemeId");
			if (getParam("manaLevelId")) {
				// document.getElementById("manaImg").style.display='none';
				document.getElementById("cemeId").disabled = "disabled";
			}
			ds.commitChanges();
			govAppDs.commitChanges();
			ds.getAt(0).set("cemeId", cemeId);
		} else {
			init();
		}
	} else {
		if (command.error.toString().indexOf("ORA-00001:") > 0)
			L5.Msg.alert('提示', "公墓编号已被占用,请更换编号！");
		else
			L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}