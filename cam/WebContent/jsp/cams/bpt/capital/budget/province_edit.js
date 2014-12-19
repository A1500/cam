function init() {
	if (method == null || method == "") {
		L5.Msg.alert('提示', "未知的页面命令!");
	} else if (method == "INSERT") {
		var ds = L5.DatasetMgr.lookup("ds");
		ds.newRecord();
	} else if (method == "UPDATE") {
		var ds = L5.DatasetMgr.lookup("ds");
		document.getElementById("YEAR").disabled = true;
		ds.setParameter("inputId", inputId);
		ds.setParameter("inputId1", inputId1);
		ds.load();
		ds.on("load",function(){
			var centralTotal;
			var provinceTotal;
			var records = ds.getAllRecords();
			centralTotal = Math.ceil((parseFloat((records[0].get("COMPENSATION_SUBSIDY")=='')?'0.00':records[0].get("COMPENSATION_SUBSIDY"))+
							  parseFloat((records[0].get("INSTITUTION_SUBSIDY")=='')?'0.00':records[0].get("INSTITUTION_SUBSIDY"))+
							  parseFloat((records[0].get("MEDICAL_SUBSIDY")=='')?'0.00':records[0].get("MEDICAL_SUBSIDY"))+
							  parseFloat((records[0].get("HOUSE_SUBSIDY")=='')?'0.00':records[0].get("HOUSE_SUBSIDY")))*100)/100;
			records[0].set("CENTRAL_TOTAL",centralTotal);					  
			provinceTotal = parseFloat((records[0].get("COMPENSATION_SUBSIDY1")=='')?'0.00':records[0].get("COMPENSATION_SUBSIDY1"))+
							  parseFloat((records[0].get("INSTITUTION_SUBSIDY1")=='')?'0.00':records[0].get("INSTITUTION_SUBSIDY1"))+
							  parseFloat((records[0].get("MEDICAL_SUBSIDY1")=='')?'0.00':records[0].get("MEDICAL_SUBSIDY1"))+
							  parseFloat((records[0].get("HOUSE_SUBSIDY1")=='')?'0.00':records[0].get("HOUSE_SUBSIDY1"));
			records[0].set("PROVINCE_TOTAL",provinceTotal);	
			var total = centralTotal+provinceTotal;
			records[0].set("TOTAL",total);
		});
	} else {
		L5.Msg.alert('提示', "未知的页面命令!");
	}
	
	L5.QuickTips.init();
}

//校验是否是浮点型数字
function checkIfFload(element){
	if(element.value==''){
		return;
	}else{
		if(!isFloat(element.value)){
		L5.Msg.alert('提示','所填内容必须是数字');
		ds.getCurrent().set(element.id,"");
		document.getElementById(element.id).value = "";
		return false;
		}
	}
}

//计算总金额
function computeSumMon(){
	//中央金额
	var COMPENSATION_SUBSIDY = _$("COMPENSATION_SUBSIDY")==''?"0.00":_$("COMPENSATION_SUBSIDY");
	var INSTITUTION_SUBSIDY = _$("INSTITUTION_SUBSIDY")==''?"0.00":_$("INSTITUTION_SUBSIDY");
	var MEDICAL_SUBSIDY = _$("MEDICAL_SUBSIDY")==''?"0.00":_$("MEDICAL_SUBSIDY");
	var HOUSE_SUBSIDY = _$("HOUSE_SUBSIDY")==''?"0.00":_$("HOUSE_SUBSIDY");
	var centralTotal = Math.ceil(parseFloat(COMPENSATION_SUBSIDY)+parseFloat(INSTITUTION_SUBSIDY)+parseFloat(MEDICAL_SUBSIDY)+parseFloat(HOUSE_SUBSIDY));
	ds.getCurrent().set("CENTRAL_TOTAL",centralTotal);
	//省金额
	var COMPENSATION_SUBSIDY1 = _$("COMPENSATION_SUBSIDY1")==''?"0.00":_$("COMPENSATION_SUBSIDY1");
	var INSTITUTION_SUBSIDY1 = _$("INSTITUTION_SUBSIDY1")==''?"0.00":_$("INSTITUTION_SUBSIDY1");
	var MEDICAL_SUBSIDY1 = _$("MEDICAL_SUBSIDY1")==''?"0.00":_$("MEDICAL_SUBSIDY1");
	var HOUSE_SUBSIDY1 = _$("HOUSE_SUBSIDY1")==''?"0.00":_$("HOUSE_SUBSIDY1");
	var provinceTotal = Math.ceil(parseFloat(COMPENSATION_SUBSIDY1)+parseFloat(INSTITUTION_SUBSIDY1)+parseFloat(MEDICAL_SUBSIDY1)+parseFloat(HOUSE_SUBSIDY1));
	ds.getCurrent().set("PROVINCE_TOTAL",provinceTotal);
	
	var total = Math.ceil((parseFloat(centralTotal)+parseFloat(provinceTotal))*100)/100;
	//计算总额
	ds.getCurrent().set("TOTAL",total);
}

//查询是否有重复年度
function checkYear(element){
	if (method == "UPDATE"){
		return;
	}
	var year = element.value;
	if(year==''){
		return;
	}else{
		var command = new L5.Command("com.inspur.cams.bpt.capital.cmd.BPTCapitalBudgetCmd");
		command.setParameter("year",year);
		command.setParameter("organCode",'370000000000');
		command.execute("checkYearExist");
		var flag = command.getReturn("flag");
		if(flag=='1'){
			L5.Msg.alert("提示","此年度已有数据！");
			document.getElementById("YEAR").value="";
			return false;
		}
	}
}

function save(){
	var ds = L5.DatasetMgr.lookup("ds");
	var record= ds.getCurrent();
	var command = new L5.Command("com.inspur.cams.bpt.capital.cmd.BPTCapitalBudgetCmd");
	command.setParameter("record",record);
	if(method == "INSERT"){
		command.execute("addProvinceBudget");
	}else if(method == "UPDATE"){
		command.execute("updateProvinceBudget");
	}
	window.close();
}

function fun_close(){
	window.close();
}

