function init() {
	if (method == null || method == "") {
		L5.Msg.alert('提示', "未知的页面命令!");
	} else if (method == "INSERT") {
		var ds = L5.DatasetMgr.lookup("ds");
		ds.newRecord();
		ds.set("domicileCode",organCode);
		ds.set("regionLevel",level);
	} else if (method == "UPDATE") {
		var ds = L5.DatasetMgr.lookup("ds");
		document.getElementById("year").disabled = true;
		ds.setParameter("INPUT_ID", inputId);
		ds.load();
		ds.on("load",function(){
		var upperTotal = [];
		var currentTotal = [];
		var records = ds.getAllRecords();
		for(var i=0;i<ds.getCount();i++){
			upperTotal[i] = parseFloat((records[i].get("compensationSubsidyUp")=='')?'0.00':records[i].get("compensationSubsidyUp"))+
							  parseFloat((records[i].get("institutionSubsidyUp")=='')?'0.00':records[i].get("institutionSubsidyUp"))+
							  parseFloat((records[i].get("medicalSubsidyUp")=='')?'0.00':records[i].get("medicalSubsidyUp"))+
							  parseFloat((records[i].get("houseSubsidyUp")=='')?'0.00':records[i].get("houseSubsidyUp"));
			records[i].set("upperTotal",upperTotal[i]);					  
			currentTotal[i] = parseFloat((records[i].get("compensationSubsidy")=='')?'0.00':records[i].get("compensationSubsidy"))+
							  parseFloat((records[i].get("institutionSubsidy")=='')?'0.00':records[i].get("institutionSubsidy"))+
							  parseFloat((records[i].get("medicalSubsidy")=='')?'0.00':records[i].get("medicalSubsidy"))+
							  parseFloat((records[i].get("houseSubsidy")=='')?'0.00':records[i].get("houseSubsidy"));
			records[i].set("currentTotal",currentTotal[i]);		
			records[i].set("total",upperTotal[i]+currentTotal[i]);	
		}
	});
	} else {
		L5.Msg.alert('提示', "未知的页面命令!");
	}
	
	L5.QuickTips.init();
}

function save(){
	var ds = L5.DatasetMgr.lookup("ds");
	var record= ds.getCurrent();
	var command = new L5.Command("com.inspur.cams.bpt.capital.cmd.BPTCapitalBudgetCmd");
	command.setParameter("record",record);
	if(method == "INSERT"){
		command.execute("addCityBudget");
	}else if(method == "UPDATE"){
		command.execute("updateCityBudget");
	}
	
	window.close();
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
		command.setParameter("organCode",organCode);
		command.execute("checkYearExist");
		var flag = command.getReturn("flag");
		if(flag=='1'){
			L5.Msg.alert("提示","此年度已有数据！");
			document.getElementById("year").value="";
			return false;
		}
	}
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
	//上级金额
	var compensationSubsidyUp = _$("compensationSubsidyUp")==''?"0.00":_$("compensationSubsidyUp");
	var institutionSubsidyUp = _$("institutionSubsidyUp")==''?"0.00":_$("institutionSubsidyUp");
	var medicalSubsidyUp = _$("medicalSubsidyUp")==''?"0.00":_$("medicalSubsidyUp");
	var houseSubsidyUp = _$("houseSubsidyUp")==''?"0.00":_$("houseSubsidyUp");
	var upperTotal = Math.ceil(parseFloat(compensationSubsidyUp)+parseFloat(institutionSubsidyUp)+parseFloat(medicalSubsidyUp)+parseFloat(houseSubsidyUp));
	ds.getCurrent().set("upperTotal",upperTotal);
	//本级金额
	var compensationSubsidy = _$("compensationSubsidy")==''?"0.00":_$("compensationSubsidy");
	var institutionSubsidy = _$("institutionSubsidy")==''?"0.00":_$("institutionSubsidy");
	var medicalSubsidy = _$("medicalSubsidy")==''?"0.00":_$("medicalSubsidy");
	var houseSubsidy = _$("houseSubsidy")==''?"0.00":_$("houseSubsidy");
	var currentTotal = Math.ceil(parseFloat(compensationSubsidy)+parseFloat(institutionSubsidy)+parseFloat(medicalSubsidy)+parseFloat(houseSubsidy));
	ds.getCurrent().set("currentTotal",currentTotal);
	
	var total = Math.ceil((parseFloat(upperTotal)+parseFloat(currentTotal))*100)/100;
	//总额
	ds.getCurrent().set("total",total);
}

function fun_close(){
	window.close();
}

