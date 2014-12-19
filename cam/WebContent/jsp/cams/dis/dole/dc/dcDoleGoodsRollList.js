var _doleType = "2";// 拨付类型标识为资金
var tDate = L5.server.getSysDate();
function init() {
	L5.Msg.wait("正在加载数据，请等待...", "加载数据");
	initDetail();
	infoDs.on('load', function() {
		setTimeout(defSelected, 1500);
	});
	if (doleId != "" && doleId != null && doleId != 'null') {
		// 如果存在流水ID，则获取此流水信息
		doleDs.setParameter("DOLE_ID", doleId);
		doleDs.load(true);
	} else {
		doleId = uu32;
		batchds.on('load', function() {
					doleDs.newRecord({
								"doleId" : doleId,
								"batchId" : batchId,
								"batchDetailId" : batchDetailId,
								"fillOrganCode" : organCode,
								"fillOrganName" : organName,
								"fillTime" : formatDateToString(tDate),
								"doleType" : _doleType,
								"amount" : 0,
								"meterial" : 0,
								"allocationType" : batchds.getAt(0)
										.get("allocationType"),
								"grantType" : batchds.getAt(0).get("grantType")
							});

				});
		batchds.setParameter("BATCH_ID", batchId);
		batchds.load(true);
	}

	doleMeteTypeDs.on('load', function() {
				initColumn();
			});
	doleMeteTypeDs.setParameter("organCode", organCode);
	doleMeteTypeDs.setParameter("doleId", doleId);
	doleMeteTypeDs.load();
}
// 复制
function clone(myObj) {
	if (typeof(myObj) != 'object')
		return myObj;
	if (myObj == null)
		return myObj;

	var myNewObj = new Object();
	for (var i in myObj)
		myNewObj[i] = clone(myObj[i]);
	return myNewObj;
}
// 初始化列
var startColumn = 7;	//虚拟列开始位置
var condition = "";		//组合虚拟列主键
function initColumn() {
	if (doleMeteTypeDs.getCount() > 0) {
		var dcGrid = L5.getCmp("dcGrid");
		var colModel = dcGrid.getColumnModel();
		var colModelConfig = colModel.config;

		for (var i = startColumn; i < startColumn + doleMeteTypeDs.getCount(); i++) {
			dcGrid.getColumnModel().setHidden(i, false);
		}

		for (var i = 0; i < doleMeteTypeDs.getCount(); i++) {
			var rec = doleMeteTypeDs.getAt(i);
			var fieldName = rec.get("TEXT");
			var coField = rec.get("CODE");

			var co = colModelConfig[startColumn + i];
			co.field = "'" + coField + "'";
			co.header = "<b>" + fieldName + "</b>";
			co.id = coField;
			co.align = "right";
			condition += coField + "~";
		}
		dcGrid.reconfigure(infoDs, colModel);
//		dcGrid.refreshBody();
//		dcGrid.render();
		
		infoDs.setParameter("batchDetailId", batchDetailId);
		infoDs.setParameter("doleId", doleId);
		infoDs.setParameter("doleType", _doleType);
		infoDs.setParameter("condition", condition);
		infoDs.load();
	}
}

// 当标识为明细页面，进行初始化
function initDetail() {
	if (ifDetail == "T") {
		document.getElementById("fillPeopleName").disabled = "disabled";
		document.getElementById("fillTime").disabled = "disabled";
		document.getElementById("note").disabled = "disabled";
		document.getElementById("timeImg").style.display = 'none';

		document.getElementById("btnSave").style.display = 'none';
		document.getElementById("btnConfirm").style.display = 'none';
		
		var dcGrid = L5.getCmp("dcGrid");
		for (var i = startColumn; i < startColumn + doleMeteTypeDs.getCount(); i++) {
			dcGrid.getColumnModel().setEditable(i, false);
		}
	}
}
//保存后列表选择效果
function defSelected() {
	var winGrid = L5.getCmp("dcGrid");
	for (var i = 0; i < infoDs.getCount(); i++) {
		for (var j = 0; j < doleMeteTypeDs.getCount(); j++) {
			var rec = doleMeteTypeDs.getAt(j);
			var coField = rec.get("CODE");
			var nums = infoDs.getAt(i).get("'" + coField + "'");
			if (!isNaN(parseFloat(nums))) {
				winGrid.getSelectionModel().selectRow(i, true);
				break;
			}
		}
	}
	L5.Msg.hide();
}
//保存前验证
function validateForSave() {
	L5.Msg.wait("正在保存数据，请等待...", "保存数据");
	//校验
	var valid = doleDs.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',valid);
		return false;
	}	
	
	var dcGrid = L5.getCmp("dcGrid");
	var selected = dcGrid.getSelectionModel().getSelections();
	if (selected.length <= 0) {
		L5.Msg.alert('提示', "请选中需要发放的记录!");
		return false;
	}
	if(doleMeteTypeDs.getCount()<=0) {
		L5.Msg.alert('提示', "无物资类型，不能发放!");
		return false;
	}
	var ifValue = false; // 是否本条记录至少有1个值
	for (var i = 0; i < selected.length; i++) {
		ifValue = false;
		for (var j = 0; j < doleMeteTypeDs.getCount(); j++) {
			var rec = doleMeteTypeDs.getAt(j);
			var fieldName = rec.get("TEXT");
			var coField = rec.get("CODE");
			var nums = selected[i].get("'" + coField + "'");
			if (!isNaN(parseFloat(nums))) {
				if (parseFloat(nums) <= 0.0) {
					L5.Msg.alert('提示', "选中发放记录的" + fieldName + "列值必须大于零!");
					return false;
				}
				if (!checkCusFloat(nums)) {
					L5.Msg.alert('提示', "选中发放记录的" + fieldName
									+ "列值必须大于零(仅支持到小数点后1位)!");
					return false;
				}
				ifValue = true;
			}
		}
		if (!ifValue) {
			L5.Msg.alert('提示', "选中发放记录第" + (i + 1) + "行的所有列值均为空，请录入!");
			return false;
		}
	}
	return true;
}
//保存
function save() {
	if(!validateForSave())
		return false;
		
	var dcGrid = L5.getCmp("dcGrid");
	var selected = dcGrid.getSelectionModel().getSelections();
	L5.MessageBox.confirm('确定', '确定要保存选中记录吗?', function(state) {
		if (state == "yes") {
			var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefInfoCmd");
			doleDs.getCurrent().set("inConfirm", "0");
			command.setParameter("doleRec", doleDs.getCurrent());// 发放流水
			command.setParameter("infoRecs", selected); // 选择发放的档案信息
			command.setParameter("columnRecs", doleMeteTypeDs.getAllRecords()); // 选择发放的档案信息
			command.execute("saveDoleGoods");
			if (!command.error) {
				L5.Msg.alert('提示', "保存成功！", function() {
							L5.Msg.wait("正在加载数据，请等待...", "加载数据");
							doleDs.setParameter("DOLE_ID", doleId);
							doleDs.load();
							
							infoDs.setParameter("batchDetailId", batchDetailId);
							infoDs.setParameter("doleId", doleId);
							infoDs.setParameter("doleType", _doleType);
							infoDs.setParameter("condition", condition);
							infoDs.load();
						});
			} else {
				L5.Msg.alert('提示', "保存时出现错误！" + command.error);
			}
		} else {
			return false;
		}
	});
}
//确认
var metes = new L5.Map();
function inConfirm() {
	if(!validateForSave())
		return false;
	
	var dcGrid = L5.getCmp("dcGrid");
	var selected = dcGrid.getSelectionModel().getSelections();
	//汇总每种物资和值存入Map中
	metes = new L5.Map();
	var sums = 0.0;
	for (var i = 0; i < doleMeteTypeDs.getCount(); i++) {
		var rec = doleMeteTypeDs.getAt(i);
		var coField = rec.get("CODE");
		sums = 0.0;
		for (var j = 0; j < selected.length; j++) {
			var nums = selected[j].get("'" + coField + "'");
			if (!isNaN(parseFloat(nums))) {
				sums += parseFloat(nums);
			}
		}
		if (sums > 0.0) {
			var prop = new L5.Map();
			prop.put("text", rec.get("NAME"));
			prop.put("unit", rec.get("DOLE_UNIT"));
			prop.put("nums", sums);
			metes.put(coField, prop);
		}
	}

	// 显示物资面板
	var goodsWin = L5.getCmp("goodsWin");
	goodsWin.show();
	
	var doleGoods = "";
	for (var p in metes.map) {
		doleGoods += metes.get(p).get("text") + ":&nbsp;<b>"
				+ formatMoneyForDis(metes.get(p).get("nums")) + "</b>&nbsp;"
				+ metes.get(p).get("unit") + "<br>";
	}
	document.getElementById("doleGoods").innerHTML = doleGoods;
	document.getElementById("doleNums").innerHTML = selected.length + "条";
	
	disDetailBatchSourceDs.setParameter("allocationStatus", "0");
	disDetailBatchSourceDs.setParameter("receiveOrganCode", organCode);
	disDetailBatchSourceDs.load();
	L5.Msg.hide();
}
// 取消
function onCancel() {
	var goodsWin = L5.getCmp("goodsWin");
	goodsWin.hide();
}
//确认发放
function onSaveConfirm() {
	L5.Msg.wait("正在保存数据，请等待...", "保存数据");
	var useGrid = L5.getCmp("useGrid");
	var selected = useGrid.getSelectionModel().getSelections();
	if (selected.length <= 0) {
		L5.Msg.alert('提示', "请选中需要划拨的记录!");
		return false;
	}
	//验证选中明细的实际使用值是否大于零，汇总各物资总和
	var useMetes = new L5.Map();
	for(var i=0;i<selected.length;i++) {
		if (!isNaN(parseFloat(selected[i].get("meterialNumPay")))) {
			if (parseFloat(selected[i].get("meterialNumPay")) <= 0.0) {
				L5.Msg.alert('提示', "选中划拨记录的实际使用数量必须大于零!");
				return false;
			}
			if (parseFloat(selected[i].get("meterialNumPay")) > parseFloat(selected[i].get("meterialNumBalanceTotal"))) {
				L5.Msg.alert('提示', "选中划拨记录的实际使用数量大于结余!");
				return false;
			}
			var meterialNumPay = useMetes.get(selected[i].get("meterialType"));
			if(meterialNumPay == undefined) {
				meterialNumPay = parseFloat(selected[i].get("meterialNumPay"));
			}else {
				meterialNumPay += parseFloat(selected[i].get("meterialNumPay"));
			}
			useMetes.put(selected[i].get("meterialType"), meterialNumPay);
		}
	}
	//比较需求与发放的物资总和
	for(var items in metes.map) {
		var reqV = formatMoneyForDis(parseFloat(metes.get(items).get("nums")));
		var useObj = formatMoneyForDis(useMetes.get(items));
		if (useObj == undefined) {
			L5.Msg.alert('提示', "选中划拨记录中无" + metes.get(items).get("text") + "!");
			return false;
		}
		var useV = parseFloat(useObj);
		if (useV > reqV) {
			L5.Msg.alert('提示', "选中划拨记录中" + metes.get(items).get("text") + "多"
							+ (useV - reqV) + metes.get(items).get("unit") + "!");
			return false;
		} else if (useV < reqV) {
			L5.Msg.alert('提示', "选中划拨记录中" + metes.get(items).get("text") + "少"
							+ (reqV - useV) + metes.get(items).get("unit") + "!");
			return false;
		}
	}
	
	var dcGrid = L5.getCmp("dcGrid");
	var infoSelected = dcGrid.getSelectionModel().getSelections();
	L5.MessageBox.confirm('确定', '是否确认物资发放?确认后不可修改！', function(state) {
		if (state == "yes") {
			L5.Msg.alert('提示', "OK!");
			var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefInfoCmd");
			doleDs.getCurrent().set("inConfirm","1");
			command.setParameter("doleRec", doleDs.getCurrent());// 发放流水
			command.setParameter("infoRecs", infoSelected); // 选择发放的档案信息
			command.setParameter("columnRecs", doleMeteTypeDs.getAllRecords()); // 选择发放的档案信息
			command.setParameter("goodRecs", selected);// 使用物资信息
			command.execute("saveDoleGoods");
			if (!command.error) {
				L5.Msg.alert('提示', "确认成功！", function() {
					ifDetail = "T";
					initDetail();
					onCancel();
				});
			} else {
				L5.Msg.alert('提示', "确认时出现错误！" + command.error);
			}
		} else {
			return false;
		}
	});
}


// 渲染物资类型
function meterialTypeRenderer(value, cellmeta, record, rowindex, colindex,
		dataset) {
	var pos = dmDisMaterialTypeDs.find("code", value, 0);
	if (pos != -1) {
		var rec = dmDisMaterialTypeDs.getAt(pos);
		record.set("meterialUnit", rec.get("doleUnit"));
		record.set("meterialUnitprice", rec.get("relation")); //存储转换关系
		return rec.get("name");
	}
	return "";
}
// 渲染物资数量结余
function meterialNumBalanceRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	var newNum = 0.0;
	var newAccount = 0.0;
	try {
		newNum = FloatMul(parseFloat(record.get("meterialUnitprice")),parseFloat(record.get("meterialNumBalance")));
		newAccount = FloatMul(10000,parseFloat(record.get("meterialAccountBalance")));
	} catch (e) {
		newNum = 0.0;
		newAccount = 0.0;
	}
	if (record.get("meterialUnitprice")) {
		record.set("meterialNumBalanceTotal", newNum);
		record.set("meterialAccountBalanceTotal", newAccount);
		return newNum;
	}
	return value;
}
// 渲染实际使用物资数量
function meterialNumPayRenderer(value, cellmeta, record,
		rowindex, colindex,
		dataset) {
	if(value>=parseFloat(record.get("meterialNumBalanceTotal"))) {
		record.set("meterialAccountPay", record.get("meterialAccountBalanceTotal"));
	}else if(value<=0.0) {
		record.set("meterialAccountPay", 0.0);
	}else {
		var pay = parseFloat(record.get("meterialAccountBalanceTotal"))/parseFloat(record.get("meterialNumBalanceTotal"))*parseFloat(record.get("meterialNumPay"));
		pay = Math.floor(pay);
		if(pay>=parseFloat(record.get("meterialAccountBalanceTotal"))) {
			record.set("meterialAccountPay", record.get("meterialAccountBalanceTotal"));
			record.set("meterialNumPay", record.get("meterialNumBalanceTotal"));
			return parseFloat(record.get("meterialNumBalanceTotal"));
		}else {
			record.set("meterialAccountPay", pay);
		}
	}		
	return value;
}
// 导出Excel
function forExcel(){
	var dataset=L5.DatasetMgr.lookup("infoDs");
	var doleMeteTypeDs = L5.DatasetMgr.lookup("doleMeteTypeDs");
	var records = doleMeteTypeDs.getAllRecords();
	var str = "";
	for(var i = 0;i< doleMeteTypeDs.getCount()-1;i++){
		str += records[i].get("TEXT")+",";
	}
	
	str += records[doleMeteTypeDs.getCount()-1].get("TEXT");
	if(dataset.getCount()<=0){
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}	
	L5.dataset2excel(dataset, "/jsp/cams/dis/dole/dc/goodsExcel.jsp?str="+ str);
	
}