var year = "";
var action = ""; // 操作标志，A=新增，E=修改
var tDate = L5.server.getSysDate();
function init() {
	var date = L5.server.getSysDate();
	year = date.getYear() + "";
	document.getElementById("cx_disYear_self").value = year;
	if(organType=="11") {
		fundsType="1"; //省民政厅
	}else if(organType=="12") {
		fundsType="2"; //市民政局
	}else if(organType=="13") {
		fundsType="3"; //区县民政局
	}else if(organType=="14") {
		fundsType="4"; //镇/街道办事处
	}
	querySelf();
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
				querySelf();
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
	//本级投入需校验预算类型
	if(singleSourceDs.getCurrent().get("budgetType")=="") {
		L5.Msg.alert('提示', "预算类型不能为空！");
		return false;
	}
	if(singleSourceDs.getCurrent().get("budgetType")=="02" 
		&& singleSourceDs.getCurrent().get("allocationTime") == "") {
		L5.Msg.alert('提示', "拨款日期不能为空！");
		return false;
	}
	if(singleSourceDs.getCurrent().get("amount") <= 0.0) {
		L5.Msg.alert('提示', "拨款金额必须大于零！");
		return false;
	}
	
	var chkCmd = new L5.Command("com.inspur.cams.dis.base.cmd.DisFundsSourceCmd");
	chkCmd.setParameter("record", singleSourceDs.getCurrent());
	chkCmd.execute("queryDisYear");
	var hasDisYear = chkCmd.getReturn("hasDisYear");
	if(hasDisYear=="true"){
		//如果此年度已有年度预算，不能添加
		if(singleSourceDs.getCurrent().get("budgetType")=="01"&&action == "A"){
			L5.Msg.alert("提示",singleSourceDs.getCurrent().get("disYear")+"年的年度预算已存在，不能再次新增！");
			return false;
		}else {
			saveSelf();
		}
	}else if(hasDisYear=="false"){
		if(singleSourceDs.getCurrent().get("budgetType")=="02"){
			L5.MessageBox.confirm("提示", "不存在"+singleSourceDs.getCurrent().get("disYear")+"年的“年度预算”，是否继续增加“追加预算”？",function(sta){
				if(sta=="yes"){
					//继续执行
					saveSelf();
				}else if(sta=="no"){
					return false;
				}
			});
		}else {
			saveSelf();
		}
	}else {
		L5.Msg.alert('提示', "错误");
		return false;
	}
}
function saveSelf() {
	var singleSourceDs = L5.DatasetMgr.lookup("singleSourceDs");
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
		querySelf();
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

// 本级投入-查询
function querySelf() {
	var selfDs = L5.DatasetMgr.lookup("selfDs");
	selfDs.setParameter("SOURCE_TYPE", "1");
	selfDs.setParameter("RECEIVE_ORGAN_CODE", organCode);
	//查询条件
	selfDs.setParameter("DIS_YEAR",document.getElementById("cx_disYear_self").value);//年度
	selfDs.setParameter("UP_ALLOCATION_PURPOSE@like",document.getElementById("cx_upAllocationPurpose_self").value);//资金用途
	
	selfDs.load();
}
// 本级投入-新增
function addSelf() {
	var singleSourceDs = L5.DatasetMgr.lookup("singleSourceDs");
	singleSourceDs.removeAll();
	
	sourceType = "1";
	action = "A";
	showWin("本级投入-增加");

	var singleSourceDs = L5.DatasetMgr.lookup("singleSourceDs");
	singleSourceDs.newRecord({
				"disYear" : year,
				"upAllocationType" : "0",
				"allocationTime" : "",
				"sourceType" : sourceType,
				"amount" : 0.00,
				"fundsType" : fundsType,
				"inUse" : "0"
			});
	document.getElementById("atTr").style.display="none";
}
//年度预算不需要拨款时间，追加预算需要拨款时间
function onChange(items) {
	var singleSourceDs = L5.DatasetMgr.lookup("singleSourceDs");
	if(items.value=="02") {
		document.getElementById("atTr").style.display="";
		singleSourceDs.set("allocationTime", formatDateToString(tDate));
	}else {
		document.getElementById("atTr").style.display="none";
		singleSourceDs.set("allocationTime", "");
	}
}
// 本级投入-修改
function editSelf() {
	var selfGridPanel = L5.getCmp('selfGridPanel');
	var selected = selfGridPanel.getSelectionModel().getSelections();
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
	
	sourceType = "1";
	action = "E";
	showWin("本级投入-修改");
}
//本级投入-明细
function detailSelf(){
	var selfGridPanel = L5.getCmp('selfGridPanel');
	var selected = selfGridPanel.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}

	var singleSourceDs = L5.DatasetMgr.lookup("singleSourceDs");
	singleSourceDs.setParameter("SOURCE_ID", selected[0].get('sourceId'));
	singleSourceDs.load();

	sourceType = "1";
	action = "E";
	showDetailWin("本级投入-明细");
}
//追踪
function followSelf(){
	var selfGridPanel = L5.getCmp('selfGridPanel');
	var selected = selfGridPanel.getSelectionModel().getSelections();
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