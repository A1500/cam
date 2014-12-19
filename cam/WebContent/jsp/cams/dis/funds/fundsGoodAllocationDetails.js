var tDate = L5.server.getSysDate();
var year = tDate.getYear()+"";

var condition = ""; // 组合虚拟列主键
var useMetes = new L5.Map(); // 可使用物资类型列表
var isAlreadySum = false;	//是否已经汇总数据
// 汇总可用物资至Map中
function meteSums(recTemp) {
	var prop = useMetes.get(recTemp.get("meterialType"));
	if (prop == undefined) {
		prop = new L5.Map();
		var pos = dmDisMaterialTypeDs.find("code", recTemp.get("meterialType"),
				0);
		prop.put("text", dmDisMaterialTypeDs.getAt(pos).get("name"));
		prop.put("unit", recTemp.get("meterialUnit"));
		prop.put("nums", 0.0);
	}
	prop.put("nums", parseFloat(prop.get("nums"))
					+ parseFloat(recTemp.get("meterialNumPay")));
	useMetes.put(recTemp.get("meterialType"), prop);
}
// 组合可用物资类型字符串
function groupMeteString() {
	condition = "";
	for (var pKey in useMetes.map) {
		condition += pKey + "~";
	}
}
// 初始化列
var startColumn = 2;	//虚拟列开始位置
var condition = "";		//组合虚拟列主键
function initColumn() {
	if (useMetes.size() > 0) {
		var allocationAllGrid = L5.getCmp("allocationAllGrid");
		var colModel = allocationAllGrid.getColumnModel();
		var colModelConfig = colModel.config;

		for (var i = startColumn; i < startColumn + useMetes.size(); i++) {
			allocationAllGrid.getColumnModel().setHidden(i, false);
			allocationAllGrid.getColumnModel().setEditable(i, false);
		}
		
		var i = 0;
		for (var pItem in useMetes.map) {
			var mapTemp = useMetes.get(pItem);
			var co = colModelConfig[startColumn + i];
			co.field = "'" + pItem + "'";
			co.header = "<b>" + mapTemp.get("text") + "(" + mapTemp.get("unit")
					+ ")</b>";
			co.id = pItem;
			co.align = "right";
			i++;
		}
		allocationAllGrid.reconfigure(disDetailSourceConvertDs, colModel);
//		allocationAllGrid.refreshBody();
//		allocationAllGrid.render();
		
		disDetailSourceConvertDs.setParameter("organCode", organCode);
		disDetailSourceConvertDs.setParameter("organType", organType);
		disDetailSourceConvertDs.setParameter("batchId", batchId);
		disDetailSourceConvertDs.setParameter("condition", condition);
		disDetailSourceConvertDs.load(true);
		L5.Msg.hide();
	}
}
// 禁用物资明细维护
function disableUseGrid() {
	var useGrid = L5.getCmp("useGrid");
	useGrid.getColumnModel().setHidden(1, true);
	useGrid.getColumnModel().setEditable(5, false);
	useGrid.getColumnModel().setEditable(6, false);
	useGrid.getColumnModel().setEditable(7, false);
}

function init() {
	L5.Msg.wait("正在加载数据，请等待...", "加载数据");

	disDetailBatchSourceDs.on('load', function() {
				if (method == "detail") {
					// 计算和值
					if (!isAlreadySum) {
						useMetes = new L5.Map();	// 初始化Map
						for (var i = 0; i < disDetailBatchSourceDs.getCount(); i++) {
							meteSums(disDetailBatchSourceDs.getAt(i)); // 汇总可用物资至Map中
						}
						groupMeteString(); // 组合可用物资类型字符串
					}
					initColumn(); //初始化列
				}
			});

	if (method == "detail") {
		disDetailBatchDs.setParameter("BATCH_ID", batchId);
		disDetailBatchDs.load(true);
		disDetailSourceDs.setParameter("BATCH_ID", batchId);
		disDetailSourceDs.load(true);
		
		// 加载已使用物资
		disDetailBatchSourceDs.setParameter("allocationStatus", "1");
		disDetailBatchSourceDs.setParameter("batchId", batchId);
		disDetailBatchSourceDs.setParameter("receiveOrganCode", organCode);
		disDetailBatchSourceDs.load(true);

		var disAccessoriesDs = L5.DatasetMgr.lookup("disAccessoriesDs");
		disAccessoriesDs.setParameter("ITEM_ID", batchId);
		disAccessoriesDs.load();
	}
}
// 返回
function onCancel() {
	window.returnValue = "T";
	window.close();
}
// 编辑基本信息
function onEditBase() {
	var sourceUpWin = L5.getCmp("sourceUpWin");
	sourceUpWin.show();
	disableUseGrid();
	document.getElementById("btnCancel").style.display = '';
	document.getElementById("btnReturn").style.display = 'none';
}
// 取消保存基本信息
function cancelSaveBase() {
	var sourceUpWin = L5.getCmp("sourceUpWin");
	sourceUpWin.hide();
	disDetailBatchDs.rejectChanges();
}
// 附件管理
function onStuffer() {
	var stufferWin = L5.getCmp("stufferWin");
	stufferWin.show();
}
// 关闭附件
function onCloseStuffer() {
	var stufferWin = L5.getCmp("stufferWin");
	stufferWin.hide();
}
// 增加上传附件
function addUploadFile() {
	var win = L5.getCmp("uploadWin");
	win.show();
}
// 上传附件
function click_upload() {
	var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisAccessoriesCmd");
	command.setParameter("itemId", batchId);
	command.setParameter("note", document.getElementById("fileMess").value);
	command.setForm("form_content");
	command.execute("uploadSave");
	// 包含有大字段的异常判断
	command.afterExecute = function() {
		if (!command.error) {
			L5.Msg.alert("提示", "上传附件成功!", function() {
				var win = L5.getCmp("uploadWin");
				document.forms["form_content"].reset();
				win.hide();
				var disAccessoriesDs = L5.DatasetMgr.lookup("disAccessoriesDs");
				disAccessoriesDs.setParameter("ITEM_ID", batchId);
				disAccessoriesDs.load();
			});
		} else {
			L5.Msg.alert("提示", ('' + command.error).replace("出现系统异常", ""), {});
		}
	}
}
// 渲染删除附件
function delUploadFile(value, cellmeta, record, rowindex, colindex, dataset) {
	return '<a href="javascript:clickDelete(\''
			+ disAccessoriesDs.indexOf(record) + '\')">' + '删除' + '</a>';
}
// 删除附件
function clickDelete(index) {
	var record = disAccessoriesDs.getAt(index);
	L5.MessageBox.confirm('', '你确定要删除吗？', function(sure) {
		if (sure == "yes") {
			var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisAccessoriesCmd");
			command.setParameter("accessoriesId", record.get("accessoriesId"));
			command.execute("delete");
			if (!command.error) {
				disAccessoriesDs.reload();
				L5.Msg.alert('提示', '删除成功！');
			} else {
				L5.Msg.alert("错误", command.error);
			}
		} else
			return;
	});
}
// 渲染下载
function downloadUploadFile(value, cellmeta, record, rowindex, colindex,
		dataset) {
	return '<a href="javascript:clickDownload(\''
			+ disAccessoriesDs.indexOf(record) + '\')">' + value + '</a>';
}
// 点击下载
function clickDownload(index) {
	var record = disAccessoriesDs.getAt(index);
	var accessoriesId = record.get("accessoriesId");
	var url = L5.webPath
			+ "/download?table=DIS_ACCESSORIES&column=ACCESSORIES&filename=ACCESSORIES_NAME&pk=ACCESSORIES_ID&ACCESSORIES_ID='"
			+ accessoriesId + "'";
	window.open(url);
}

// 渲染物资类型
function meterialTypeRenderer(value, cellmeta, record, rowindex, colindex,
		dataset) {
	var pos = dmDisMaterialTypeDs.find("code", value, 0);
	if (pos != -1) {
		var rec = dmDisMaterialTypeDs.getAt(pos);
		record.set("meterialUnit", rec.get("unit"));
		return rec.get("name");
	}
	return "";
}
// 渲染实际使用物资数量
function meterialNumPayRenderer(value, cellmeta, record, rowindex, colindex,
		dataset) {
	if (method == "insert") { //仅新增时可维护
		if (value >= parseFloat(record.get("meterialNumBalanceTotal"))) {
			record.set("meterialAccountPay", record
							.get("meterialAccountBalanceTotal"));
		} else if (value <= 0.0) {
			record.set("meterialAccountPay", 0.0);
		} else {
			var pay = parseFloat(record.get("meterialAccountBalanceTotal"))
					/ parseFloat(record.get("meterialNumBalanceTotal"))
					* parseFloat(record.get("meterialNumPay"));
			pay = Math.floor(pay * 10000) / 10000;
			if (pay >= parseFloat(record.get("meterialNumBalanceTotal"))) {
				record.set("meterialAccountPay", record
								.get("meterialAccountBalanceTotal"));
				record.set("meterialNumPay", record.get("meterialNumBalanceTotal"));
				return formatMoneyForDis(parseFloat(record
						.get("meterialNumBalanceTotal")));
			} else {
				record.set("meterialAccountPay", pay);
			}
		}
	}
	return formatMoneyForDis(value);
}