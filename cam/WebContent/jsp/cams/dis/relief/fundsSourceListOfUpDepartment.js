var year = "";
var action = ""; // 操作标志，A=新增，E=修改
var ifSelf = false; //是否本级投入
var ifTop = false; //是否上级下拨
var zhiguanNum=0;//另拨付直管县金额

function init() {
	var date = L5.server.getSysDate();
	year = date.getYear() + "";
	document.getElementById("cx_disYear_up").value = year;
	
	if(organType=="11") {
		fundsType="1"; //省民政厅
	}else if(organType=="12") {
		fundsType="2"; //市民政局
	}else if(organType=="13") {
		fundsType="3"; //区县民政局
	}else if(organType=="14") {
		fundsType="4"; //镇/街道办事处
	}
	
	queryAllocation();
}
//检查资金是否被使用
function queryIfUse(_sourceId) {
	var checkCmd = new L5.Command("com.inspur.cams.dis.base.cmd.DisFundsSourceCmd");
	checkCmd.setParameter('sourceId',_sourceId);
	checkCmd.execute('queryIfUse');
	var msg = checkCmd.getReturn("msg");
	if(msg!=null) {
		L5.Msg.alert('提示', msg);
		return true;
	}
	return false;
}
// 上级下拨-查询
function queryAllocation() {
	
	var allocationDs = L5.DatasetMgr.lookup("allocationDs");
	allocationDs.setParameter("SOURCE_TYPE", "0");
	allocationDs.setParameter("IN_USE@!=@String", "9");
	allocationDs.setParameter("RECEIVE_ORGAN_CODE", organCode);
	//查询条件
	allocationDs.setParameter("DIS_YEAR",document.getElementById("cx_disYear_up").value);//年度
	allocationDs.setParameter("UP_ALLOCATION_NUM",document.getElementById("cx_upAllocationNum_up").value);//上级拨款文号(仅上级有)
	allocationDs.setParameter("UP_ALLOCATION_PURPOSE@like",document.getElementById("cx_upAllocationPurpose_up").value);//资金用途
	allocationDs.load(true);
	var lowerAllocationDs = L5.DatasetMgr.lookup("lowerAllocationDs");
	lowerAllocationDs.setParameter("SOURCE_TYPE", "0");
	lowerAllocationDs.setParameter("IN_USE@!=@String", "9");
	lowerAllocationDs.setParameter("AMOUNT@>", "0");
	lowerAllocationDs.setParameter("FILL_ORGAN_CODE", "370000000000");
	lowerAllocationDs.setParameter("RECEIVE_ORGAN_CODE@!=@String", organCode);
	lowerAllocationDs.setParameter("RECEIVE_ORGAN_CODE@rlike@String", organCode.substring(0,4));
	
	lowerAllocationDs.setParameter("DIS_YEAR",document.getElementById("cx_disYear_up").value);//年度
	lowerAllocationDs.setParameter("UP_ALLOCATION_NUM",document.getElementById("cx_upAllocationNum_up").value);//上级拨款文号(仅上级有)
	lowerAllocationDs.setParameter("UP_ALLOCATION_PURPOSE@like",document.getElementById("cx_upAllocationPurpose_up").value);//资金用途
	lowerAllocationDs.load(true);
}
// 上级下拨-新增
function addUp() {
	var singleSourceDs = L5.DatasetMgr.lookup("singleSourceDs");
	singleSourceDs.removeAll();
	
	sourceType = "0";
	action = "A";
	ifSelf = false;
	ifTop = true;
	showWin("上级下拨-增加");

	var tDate = L5.server.getSysDate();
	var singleSourceDs = L5.DatasetMgr.lookup("singleSourceDs");
	singleSourceDs.newRecord({
				"disYear" : year,
				"upAllocationType" : "0",
				"allocationTime" : formatDateToString(tDate),
				"sourceType" : sourceType,
				"amount" : 0.00,
				"fundsType" : "0",
				"inUse" : "0"
			});
}
// 上级下拨-修改
function editUp() {
	var allocationGridPanel = L5.getCmp('allocationGridPanel');
	var selected = allocationGridPanel.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录修改!");
		return false;
	}
	//检查资金是否被使用
	if(queryIfUse(selected[0].get("sourceId"))) {
		return false;
	}

	var singleSourceDs = L5.DatasetMgr.lookup("singleSourceDs");
	singleSourceDs.setParameter("SOURCE_ID", selected[0].get('sourceId'));
	singleSourceDs.load();

	sourceType = "0";
	action = "E";
	ifSelf = false;
	ifTop = true;
	showWin("上级下拨-修改");
}
//上级，本级，社会公用删除
function deleteComm(item){
	var panel;
	var selected;
	var delId = item.getId();
	if(delId=="deleteSelfId"){
		panel = L5.getCmp('selfGridPanel');
	}else if(delId=="deleteUpbtnId"){
		panel = L5.getCmp('allocationGridPanel');
	}else{
		panel = L5.getCmp('contributeGridPanel');
	}
	
	selected = panel.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录删除!");
		return false;
	}
	//检查资金是否被使用
	if(queryIfUse(selected[0].get("sourceId"))) {
		return false;
	}
	L5.MessageBox.confirm("提示", "确定要删除选中的记录吗？",function(sta){
		if(sta=="yes"){
			var sourceId = selected[0].get("sourceId");
			var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisFundsSourceCmd");
			command.setParameter("sourceId",sourceId);
			command.execute("delete");
			if(!command.error){
				L5.Msg.alert("提示","删除成功！");
				queryAllocation();
				return false;
			}else{
				L5.Msg.alert("提示","删除失败！"+command.error);
				return false;
			}
		}
	});
}
//上级下拨-明细
function detailUp() {
	var allocationGridPanel = L5.getCmp('allocationGridPanel');
	var selected = allocationGridPanel.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}

	var singleSourceDs = L5.DatasetMgr.lookup("singleSourceDs");
	singleSourceDs.setParameter("SOURCE_ID", selected[0].get('sourceId'));
	singleSourceDs.load();

	sourceType = "0";
	action = "E";
	ifSelf = false;
	ifTop = true;
	showDetailWin("上级下拨-明细");
}
//下拨于直管县-明细
function detailLower() {
	var lowerGridPanel = L5.getCmp('lowerGridPanel');
	var selected = lowerGridPanel.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}

	var singleSourceDs = L5.DatasetMgr.lookup("singleSourceDs");
	singleSourceDs.setParameter("SOURCE_ID", selected[0].get('sourceId'));
	singleSourceDs.load();

	sourceType = "0";
	action = "E";
	ifSelf = false;
	ifTop = true;
	showDetailWin("上级下拨-明细");
}
// 确定保存
function confirmSave() {
	var singleSourceDs = L5.DatasetMgr.lookup("singleSourceDs");
	// 校验
	var valid = singleSourceDs.isValidate();
	if (valid != true) {
		L5.Msg.alert('提示', valid);
		return false;
	}
	if(ifTop) {
		//上级下拨需校验拨款文号
		if(singleSourceDs.getCurrent().get("upAllocationNum")=="") {
			L5.Msg.alert('提示', "拨款文号不能为空！");
			return false;
		}
	}
	if(ifSelf) {
		//本级投入需校验预算类型
		if(singleSourceDs.getCurrent().get("budgetType")=="") {
			L5.Msg.alert('提示', "预算类型不能为空！");
			return false;
		}
	}
	if(singleSourceDs.getCurrent().get("upAllocationPurpose") == "") {
		L5.Msg.alert('提示', "资金用途不能为空！");
		return false;
	}
	if(singleSourceDs.getCurrent().get("amount") <= 0.0) {
		L5.Msg.alert('提示', "拨款金额必须大于零！");
		return false;
	}
	//检查资金是否被使用
	if(action == "E" && queryIfUse(singleSourceDs.getCurrent().get("sourceId"))) {
		return false;
	}
	

	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisFundsSourceCmd");
	if(sourceType=="0") 
		command.setParameter("isUp", "T");
	else
		command.setParameter("isUp", "F");
	command.setParameter("sourceType", sourceType);
	command.setParameter("source", singleSourceDs.getCurrent());

	if (action == "A") {
		command.execute("insert");
	} else if (action == "E") {
		command.execute("update");
	}
	if (!command.error) {
		L5.Msg.alert('提示', "保存成功");
		hideWin();
		queryAllocation();
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}
// 取消保存
function cancelSave() {
	hideWin();
}
// 显示window
function showWin(_title) {
	var sourceWin = L5.getCmp("sourceWin");
	sourceWin.setTitle(_title);
	sourceWin.show();
	if(ifSelf)
		document.getElementById("trBudget").style.display="";
	else
		document.getElementById("trBudget").style.display="none";
		
	if(ifTop)
		document.getElementById("trAlloNum").style.display="";
	else
		document.getElementById("trAlloNum").style.display="none";
}
// 隐藏window
function hideWin() {
	var sourceWin = L5.getCmp("sourceWin");
	if(sourceWin && sourceWin.isVisible()) {
		sourceWin.hide();
	}
	var singleSourceDs = L5.DatasetMgr.lookup("singleSourceDs");
	singleSourceDs.rejectChanges();
}
// 显示明细window
function showDetailWin(_title) {
	var sourceDetailWin = L5.getCmp("sourceDetailWin");
	sourceDetailWin.setTitle(_title);
	sourceDetailWin.show();
}
//关闭明细window
function hideDetailWin() {
	var sourceDetailWin = L5.getCmp("sourceDetailWin");
	if(sourceDetailWin && sourceDetailWin.isVisible()) {
		sourceDetailWin.hide();
	}
	var singleSourceDs = L5.DatasetMgr.lookup("singleSourceDs");
	singleSourceDs.rejectChanges();
}
//追踪-市
function followUp(){
	var allocationGridPanel = L5.getCmp('allocationGridPanel');
	var selected = allocationGridPanel.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	var url = 'fundsAllocationFollowSingle.jsp?sourceId='+selected[0].get("sourceId");
	var width = 850;
    var height = 700;
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
}
//追踪-直管县
function followLower(){
	var lowerGridPanel = L5.getCmp('lowerGridPanel');
	var selected = lowerGridPanel.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}
	var url = 'fundsAllocationFollowSingle.jsp?sourceId='+selected[0].get("sourceId");
	var width = 850;
    var height = 700;
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
}
// 渲染资金用途
function upAllocationPurposeRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	var str = " ";
	for (var i = 0; i < disAllocationPurposeDs.getCount(); i++) {
		if (value.indexOf(disAllocationPurposeDs.getAt(i).get("value")) != -1) {
			str += disAllocationPurposeDs.getAt(i).get("text") + ",";
		}
	}
	return str.substring(0, str.length - 1);
}
// 渲染金额支出
function amountPayRenderer(value, cellmeta, record, rowindex, colindex,
		dataset) {
	var pay = record.get("amount") - record.get("amountBalance");
	record.set("amountPay", pay);
	return formatMoneyForDis(pay);
}
// 渲染金额结余
function amountBalanceRenderer(value, cellmeta, record, rowindex, colindex,
		dataset) {
	if(record.get("inUse")=="0")
		return "---";
	else
		return formatMoneyForDis(value);
}
//渲染备注
function noteRenderer(value, cellmeta, record, rowindex, colindex,
		dataset) {
	if(record.get("ifCarry")=="1")
		return "【已结转】"+value;
	return value;
}

function formatDateToString(date) {
	return date.getYear()
			+ "-"
			+ ((date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
					+ (date.getMonth() + 1)) + "-"
			+ (date.getDate() > 9 ? date.getDate() : "0" + date.getDate());
}
//渲染直管县
function initTown(value, cellmeta, record, rowindex, colindex,dataset) {
	var lowerAllocationDs=L5.DatasetMgr.lookup("lowerAllocationDs");
	var idx;
	for(var i=0;i<lowerAllocationDs.getCount();i++){
		idx = lowerAllocationDs.query("upAllocationNum",record.get("upAllocationNum"));
		zhiguanNum+=idx.items[i].get("amount");
	}
	return formatMoneyForDis(zhiguanNum);
}