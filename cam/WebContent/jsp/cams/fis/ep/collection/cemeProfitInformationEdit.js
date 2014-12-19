function init() {
	if (method == "INSERT") {
		ds.newRecord({
					"prop" : "2"
				});
	} else if (method == "UPDATE") {
		document.getElementById("cemeId").disabled = "disabled";

		ds.baseParams["CEME_ID@="] = idField;
		ds.load();
		itemDs.baseParams["CEME_ID@="] = idField;
		itemDs.load();
		govAppDs.baseParams["CEME_ID@="] = idField;
		govAppDs.load();
		landcardDs.baseParams["CEME_ID@="] = idField;
		landcardDs.load();
	} else {
		ds.newRecord({
					"prop" : "2"
				});
		document.getElementById("return").style.display = "none";
	}
	L5.QuickTips.init();
}

var itemStatus = -1;
// 增加公墓审批事项
function addAppItem() {
	var win = L5.getCmp("itemWin");
	win.show();
	var command = new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
	command.setParameter("IdHelp", "Id32");
	command.execute();
	var newId = command.getReturn("id");
	itemDs.newRecord({
				"itemId" : newId
			});

	for (var i = 0; i < itemTypeDs.getCount(); i++) {
		govAppDs.newRecord({
					"itemId" : newId,
					"deptId" : itemTypeDs.getAt(i).get("value")
				});
	}

	// 过滤出本事项相关数据
	govAppDs.filterBy(function(record, id) {
				if (newId == record.get('itemId')) {
					return record;
				}
			});
	landcardDs.filterBy(function(record, id) {
				if (newId == record.get('itemId')) {
					return record;
				}
			});

	itemStatus = 1;
}

// 修改公墓审批事项
function updateAppItem() {
	var itemGridPanel = L5.getCmp('itemGridPanel');
	var selected = itemGridPanel.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录修改!");
		return false;
	}

	var win = L5.getCmp("itemWin");
	win.show();

	// 过滤出本事项相关数据
	var newId = itemDs.getCurrent().get("itemId");
	govAppDs.filterBy(function(record, id) {
				if (newId == record.get('itemId')) {
					return record;
				}
			});
	landcardDs.filterBy(function(record, id) {
				if (newId == record.get('itemId')) {
					return record;
				}
			});

	itemStatus = 3;
}

// 删除公墓审批事项
function removeAppItem() {
	var itemGridPanel = L5.getCmp('itemGridPanel');
	var selected = itemGridPanel.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录删除!");
		return false;
	}
	if (itemDs.getCurrent())
		itemDs.remove(itemDs.getCurrent());
}
// 审批事项编辑确定
function itemCommit() {
	clearNullNumGovApp();

	var itemDic = document.getElementById('itemDic').value;
	var itemTime = document.getElementById('itemTime').value;
	if (itemDic == "") {
		L5.Msg.alert("提示", "事项不能为空！");
		return;
	}
	if (itemTime == "") {
		L5.Msg.alert("提示", "批准时间不能为空！");
		return;
	}
	itemClose();
}
// 审批事项编辑取消
function itemCancle() {
	if (itemStatus == 1) {
		clearAssignIdLandGov(itemDs.getCurrent().get("itemId"))
		itemDs.remove(itemDs.getAt(itemDs.getCount() - 1));
	} else if (itemStatus == 3) {
		clearNullNumGovApp();
	}

	itemClose();
}

// 删除指定itemI的土地证和批准文号信息
function clearAssignIdLandGov(_id) {
	govAppDs.moveFirst();
	while (govAppDs.getCurrent() && !govAppDs.isLast()) {
		if (_id == govAppDs.getCurrent().get("itemId"))
			govAppDs.remove(govAppDs.getCurrent());
		else
			govAppDs.moveNext();
	}

	if (govAppDs.getCurrent() && govAppDs.isLast()
			&& _id == govAppDs.getCurrent().get("itemId"))
		govAppDs.remove(govAppDs.getCurrent());

	landcardDs.moveFirst();
	while (landcardDs.getCurrent() && !landcardDs.isLast()) {
		if (_id == landcardDs.getCurrent().get("itemId"))
			landcardDs.remove(landcardDs.getCurrent());
		else
			landcardDs.moveNext();
	}

	if (landcardDs.getCurrent() && landcardDs.isLast()
			&& _id == landcardDs.getCurrent().get("itemId"))
		landcardDs.remove(landcardDs.getCurrent());
}

// 遍历批准文号（当前事项）,空文号删除
function clearNullNumGovApp() {
	govAppDs.moveFirst();
	while (govAppDs.getCurrent() && !govAppDs.isLast()) {
		if ("" == govAppDs.getCurrent().get("deptNum"))
			govAppDs.remove(govAppDs.getCurrent());
		else
			govAppDs.moveNext();
	}

	if (govAppDs.getCurrent() && govAppDs.isLast()
			&& "" == govAppDs.getCurrent().get("deptNum"))
		govAppDs.remove(govAppDs.getCurrent());
}

// 关闭审批事项win
function itemClose() {
	// 清除过滤器
	landcardDs.clearFilter();
	govAppDs.clearFilter();
	var win = L5.getCmp("itemWin");
	win.hide();
	itemStatus = -1;
}

// 增加土地证
function addLandcard() {
	var command = new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
	command.setParameter("IdHelp", "Id32");
	command.execute();
	var newId = command.getReturn("id");
	landcardDs.newRecord({
				"recordId" : newId
			});
}

// 增加土地证
function addLandcard2() {
	var command = new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
	command.setParameter("IdHelp", "Id32");
	command.execute();
	var newId = command.getReturn("id");
	landcardDs.newRecord({
				"recordId" : newId,
				"itemId" : itemDs.getCurrent().get("itemId")
			});
}

// 删除土地证
function delLandcard() {
	if (landcardDs.getCurrent())
		landcardDs.remove(landcardDs.getCurrent());
}

// 增加政府批准文号
function addGovApp() {
	var command = new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
	command.setParameter("IdHelp", "Id32");
	command.execute();
	var newId = command.getReturn("id");
	govAppDs.newRecord({
				"recordId" : newId,
				"isEnable" : "1"
			});
}

// 增加政府批准文号
function addGovApp2() {
	var command = new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
	command.setParameter("IdHelp", "Id32");
	command.execute();
	var newId = command.getReturn("id");
	govAppDs.newRecord({
				"recordId" : newId,
				"isEnable" : "1",
				"itemId" : itemDs.getCurrent().get("itemId")
			});
}

// 删除政府批准文号
function removeGovApp() {
	if (govAppDs.getCurrent())
		govAppDs.remove(govAppDs.getCurrent());
}

// 当选择审批事项时，自动添加简述
function onSelectItemChange() {
	var pos = document.getElementById("itemDic").value;
	if (pos != "") {
		itemDs.getCurrent().set("itemLabel", itemTypeDs.getAt(pos).get("text"));
	} else {
		itemDs.getCurrent().set("itemLabel", "");
	}
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
	if (!regex.test(cemeid)) {
		L5.Msg.alert('提示',
				'经营性公墓编号不符合标准!规则如\"GZ370101-XX\" (370100为主管单位行政区划编码，XX为顺序号)');
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
	// 审批事项-保存校验
	var itemDs = L5.DatasetMgr.lookup("itemDs");
	var valid = itemDs.isValidate(true);
	if (valid !== true) {
		L5.Msg.alert("提示", "校验未通过：" + valid);
		return false;
	}

	// 土地证-保存校验
	var landcardDs = L5.DatasetMgr.lookup("landcardDs");
	var valid = landcardDs.isValidate(true);
	if (valid !== true) {
		L5.Msg.alert("提示", "校验未通过：" + valid);
		return false;
	}

	// 政府批准文号-保存校验
	var govAppDs = L5.DatasetMgr.lookup("govAppDs");
	var valid = govAppDs.isValidate(true);
	if (valid !== true) {
		L5.Msg.alert("提示", "校验未通过：" + valid);
		return false;
	}

	var command = new L5.Command("com.inspur.cams.fis.ep.base.cmd.FisCemeCmd");
	command.setParameter("record", ds.getCurrent());
	if (method == "UPDATE") {
		command.setParameter("itemRecords", itemDs.getAllChangedRecords());
		command.setParameter("landcardRecords", landcardDs
						.getAllChangedRecords());
		command.setParameter("govAppRecords", govAppDs.getAllChangedRecords());
		command.execute("update");
	} else {
		command.setParameter("itemRecords", itemDs.getAllRecords());
		command.setParameter("landcardRecords", landcardDs.getAllRecords());
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
			itemDs.commitChanges();
			govAppDs.commitChanges();
			landcardDs.commitChanges();

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

// 渲染审批事项
function backValue(value, cellmeta, record, rowindex, colindex, dataset) {
	var itemDs = L5.DatasetMgr.lookup("itemDs");
	var idx = itemDs.find("itemId", value, 0);
	if (idx == -1) {
		return "";
	}
	return itemDs.getAt(idx).get("itemLabel") + "("
			+ itemDs.getAt(idx).get("itemTime") + ")";
}