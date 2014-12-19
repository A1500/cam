var year = "";
var action = ""; // 操作标志，A=新增，E=修改
var ifSelf = false; //是否本级投入
var ifTop = false; //是否部级下拨
var date = L5.server.getSysDate();

function init() {
	if(organType=="11") {
		fundsType="1"; //省民政厅
	}else if(organType=="12") {
		fundsType="2"; //市民政局
	}else if(organType=="13") {
		fundsType="3"; //区县民政局
	}else if(organType=="14") {
		fundsType="4"; //镇/街道办事处
	}
	year = date.getYear() + "";
	document.getElementById("cx_disYear_con").value = year;
	queryCon();
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
				if(delId=="deleteSelfId"){//本级投入
					querySelf();
				}else if(delId=="deleteUpbtnId"){//上级下拨
					queryAllocation();
				}else{//社会捐赠
					queryCon();
				}
				return false;
			}else{
				L5.Msg.alert("提示","删除失败！"+command.error);
				return false;
			}
		}
	});
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
		queryCon();
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
	if(ifSelf)
		document.getElementById("trBudgetDe").style.display="";
	else
		document.getElementById("trBudgetDe").style.display="none";
		
	if(ifTop)
		document.getElementById("trAlloNumDe").style.display="";
	else
		document.getElementById("trAlloNumDe").style.display="none";
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


// 社会捐赠-查询
function queryCon() {
	var contributeDs = L5.DatasetMgr.lookup("contributeDs");
	contributeDs.setParameter("SOURCE_TYPE", "2");
	contributeDs.setParameter("RECEIVE_ORGAN_CODE", organCode);
	//查询条件
	contributeDs.setParameter("DIS_YEAR",document.getElementById("cx_disYear_con").value);//年度
	contributeDs.setParameter("UP_ALLOCATION_PURPOSE@like",document.getElementById("cx_upAllocationPurpose_con").value);//资金用途
	
	contributeDs.load();
}
// 社会捐赠-新增
function addContribute() {
	var singleSourceDs = L5.DatasetMgr.lookup("singleSourceDs");
	singleSourceDs.removeAll();
	
	sourceType = "2";
	action = "A";
	ifSelf = false;
	ifTop = false;
	showWin("社会捐赠-增加");

	var tDate = L5.server.getSysDate();
	var singleSourceDs = L5.DatasetMgr.lookup("singleSourceDs");
	singleSourceDs.newRecord({
				"disYear" : year,
				"upAllocationType" : "1",
				"allocationTime" : formatDateToString(tDate),
				"sourceType" : sourceType,
				"amount" : 0.00,
				"fundsType" : fundsType,
				"inUse" : "0"
			});
}
// 社会捐赠-修改
function editContribute() {
	var contributeGridPanel = L5.getCmp('contributeGridPanel');
	var selected = contributeGridPanel.getSelectionModel().getSelections();
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
	
	sourceType = "2";
	action = "E";
	ifSelf = false;
	ifTop = false;
	showWin("社会捐赠-修改");
}
//社会捐赠-明细
function detailContribute(){
	var contributeGridPanel = L5.getCmp('contributeGridPanel');
	var selected = contributeGridPanel.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}

	var singleSourceDs = L5.DatasetMgr.lookup("singleSourceDs");
	singleSourceDs.setParameter("SOURCE_ID", selected[0].get('sourceId'));
	singleSourceDs.load();

	sourceType = "2";
	action = "E";
	ifSelf = false;
	ifTop = false;
	showDetailWin("社会捐赠-明细");
}
//追踪
function followContribute(){
	var contributeGridPanel = L5.getCmp('contributeGridPanel');
	var selected = contributeGridPanel.getSelectionModel().getSelections();
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