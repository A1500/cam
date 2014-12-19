var action = ""; // 操作标志，A=新增，E=修改
var year="2013";
function init(){
	document.getElementById("requiredOrganCode").value = organCode;
	document.getElementById("requiredOrganName").value = organName;
	disFundsYearBudgetDs.setParameter("FILL_ORGAN_CODE",document.getElementById("requiredOrganCode").value);
	disFundsYearBudgetDs.load();
	var _d = L5.server.getSysDate();
	year = _d.getYear()+"";
	
	
}
//查询
function query(){
	disFundsYearBudgetDs.setParameter("FILL_ORGAN_CODE",document.getElementById("requiredOrganCode").value);
	disFundsYearBudgetDs.setParameter("DIS_YEAR",document.getElementById("cx_disYear").value);
	disFundsYearBudgetDs.setParameter("BUDGET_TYPE", document.getElementById("cx_budgetType").value);
	disFundsYearBudgetDs.load();
}

function resetQuery() {
	document.getElementById("requiredOrganCode").value = organCode;
	document.getElementById("requiredOrganName").value = organName;
	document.getElementById("cx_disYear").value="";
	document.getElementById("cx_budgetType").value="";
}

//新增
function insert(){
	var cmd = new L5.Command("com.inspur.cams.comm.util.IdHelpCmd")
	cmd.setParameter("IdHelp", "Id32");
	cmd.execute();
	var id = cmd.getReturn("id");
		
	action = "A";
	disFundsYearBudgetDs.newRecord({
				"id" : id,
				"disYear" : year,
				"fillOrganCode" : organCode
			});
	var budgetWin = L5.getCmp("budgetWin");
	budgetWin.show();
}

//修改
function update(){
	var budgetGrid = L5.getCmp('budgetGrid');
	var selected = budgetGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录修改!");
		return false;
	}
	
	action = "E";
	var budgetWin = L5.getCmp("budgetWin");
	budgetWin.show();
}

function cancel() {
	if(action == "A" || action == "E") {
		disFundsYearBudgetDs.rejectChanges();
	}
	var budgetWin = L5.getCmp("budgetWin");
	budgetWin.hide();
}
//保存
function save() {
	var record = disFundsYearBudgetDs.getCurrent();
	var disYear = record.get("disYear");
	if(disYear==""){
		L5.Msg.alert("提示","年度不能为空！");
		return false;
	}
	if(!/^\d{4}$/.test(disYear)){
		L5.Msg.alert("提示","年度为四位数字！");
		return false;
	}
	var budgetType = record.get("budgetType");
	if(budgetType==""){
		L5.Msg.alert("提示","预算类型不能为空！");
		return false;
	}
	var budgetMoney = record.get("budgetMoney");
	if(budgetMoney==""){
		L5.Msg.alert("提示","预算金额不能为空！");
		return false;
	}
	if(!/^\d*\.{0,1}\d*$/.test(budgetMoney)){
		L5.Msg.alert("提示","预算金额必须为数字！");
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisFundsYearBudgetCmd");
	command.setParameter("record", record);
	command.execute("queryDisYear");
	var hasDisYear = command.getReturn("hasDisYear");
	if(hasDisYear=="true"){
		if(record.get("budgetType")=="01"){
			L5.Msg.alert("提示","年度预算已存在，不能再次新增！");
			return false;
		}
	}else if(hasDisYear=="false"){
		if(record.get("budgetType")=="02"){
			L5.Msg.alert("提示","！");
			L5.MessageBox.confirm("提示", "不存在"+disYear+"年的“年度预算”，是否继续增加“追加预算”？",function(sta){
				if(sta=="yes"){
					//继续执行
				}else if(sta=="no"){
					return false;
				}
			});
		}
	}
		
	if(action == "A") { //新增
		command.execute("insert");
	}else if(action == "E") { //修改
		command.execute("update");
	}
	if (!command.error) {
		disFundsYearBudgetDs.commitChanges();
//		disFundsYearBudgetDs.load();
		query();
		L5.Msg.alert("提示","保存成功！");
		var budgetWin = L5.getCmp("budgetWin");
		budgetWin.hide();
	}else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}

function del(){
	var budgetGrid = L5.getCmp('budgetGrid');
	var selected = budgetGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录删除!");
		return false;
	}
	
	L5.MessageBox.confirm("提示", "是否确认删除此条记录？",function(sta){
		if(sta=="yes"){
			var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisFundsYearBudgetCmd");
			command.setParameter("id",selected[0].get("id"));
			command.execute("delete");
			if (!command.error){
				L5.Msg.alert("提示","删除成功！");
				disFundsYearBudgetDs.commitChanges();
				query();
			}else{
				L5.Msg.alert("提示","删除出错！"+command.error);
			}
		}
	});
}

function forOrganSelect() {
	var revalue = window.showModalDialog(
			"../assistance/dic_city/dicCity.jsp?organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName))+"&level=2&radioMaxlevel=0", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("requiredOrganName").value=list[4];
		document.getElementById("requiredOrganCode").value=list[0];
	}
}