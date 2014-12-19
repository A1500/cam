var year = nowYear;
var isInit = false;
var alloGrage="1"; //拨付按钮类型（市级专用）：1为上级，2为本级
function init() {
	L5.Msg.wait("正在加载数据，请等待...", "加载数据");
	var disFundsBatchDs = L5.DatasetMgr.lookup("disFundsBatchDs");	
	disFundsBatchDs.events['load'] = true; 
	disFundsBatchDs.on('load',function(){
		if(disFundsBatchDs.getCount()>0) {
			initGrid(disFundsBatchDs.getAt(0).get("upAllocationType")); //初始化表格
		}
	});
	var disFundsSourceDs = L5.DatasetMgr.lookup("disFundsSourceDs");
	var disFundsBatchSourceDs = L5.DatasetMgr.lookup("disFundsBatchSourceDs");
	disFundsBatchSourceDs.events['load'] = true; 
	disFundsBatchSourceDs.on('load',function(){
		var upA = 0.0;
		var selfA = 0.0;
		var conA = 0.0;
		for(var i=0;i<disFundsBatchSourceDs.getCount();i++) {
			var rec = disFundsBatchSourceDs.getAt(i);
			if(rec.get("amountPay")>0.0) {
				if(rec.get("sourceType")=="0") {
					upA += parseFloat(rec.get("amountPay"));
				}else if(rec.get("sourceType")=="1") {
					selfA += parseFloat(rec.get("amountPay"));
				}else if(rec.get("sourceType")=="2") {
					conA += parseFloat(rec.get("amountPay"));
				}
			}
		}
		document.getElementById("amountUp").innerHTML = upA;
		document.getElementById("amountSelf").innerHTML = selfA;
		document.getElementById("amountCon").innerHTML = conA;
		
		disFundsBatchSourceDs.filterBy(function(record, id) {
							if (record.get("amountPay") > 0.0) {
								return record;
							}
						});
	});
	
	disFundsBatchDs.setParameter("BATCH_ID", batchId);
	disFundsBatchDs.load();
	disFundsSourceDs.setParameter("BATCH_ID", batchId);
	disFundsSourceDs.load();
	var disFundsBatchSourceDs = L5.DatasetMgr.lookup("disFundsBatchSourceDs");
	disFundsBatchSourceDs.setParameter("receiveOrganCode", organCode);
	disFundsBatchSourceDs.setParameter("batchId", batchId);
	disFundsBatchSourceDs.setParameter("inUse", "1");
	disFundsBatchSourceDs.load();
	var disAccessoriesDs = L5.DatasetMgr.lookup("disAccessoriesDs");
	disAccessoriesDs.setParameter("ITEM_ID", batchId);
	disAccessoriesDs.load();
		
	if (organType != "11" && organType != "12" && organType != "13" && organType != "14") {
		L5.Msg.alert("提示", "未知等级，不能进入此页面！", function() {
					onCancel();
				});
	}
	L5.Msg.hide();
}
//返回
function onCancel() {
	window.close();
}
//初始化表格
function initGrid(upAllocationType) {
	var allocationAllGrid = L5.getCmp("allocationAllGrid");
	if (upAllocationType == "0") {
		// 财政资金
		allocationAllGrid.getColumnModel().setHidden(9, true);
		if (organType == "11") {
			// 省
		} else if (organType == "12") {
			// 市
			allocationAllGrid.getColumnModel().setHidden(7, false);
		} else if (organType == "13") {
			// 县区市
			allocationAllGrid.getColumnModel().setHidden(5, true);
			allocationAllGrid.getColumnModel().setHidden(6, true);
			allocationAllGrid.getColumnModel().setHidden(7, false);
			allocationAllGrid.getColumnModel().setHidden(8, false);
		}
	} else if (upAllocationType == "1") {
		// 捐赠资金
		allocationAllGrid.getColumnModel().setHidden(5, true);
		allocationAllGrid.getColumnModel().setHidden(6, true);
		allocationAllGrid.getColumnModel().setHidden(7, true);
		allocationAllGrid.getColumnModel().setHidden(8, true);
		allocationAllGrid.getColumnModel().setHidden(9, false);
	}
}
//查看明细
function onDetails(){
	var sourceUpWin = L5.getCmp("sourceUpWin");
	sourceUpWin.show();
}
//关闭明细
function onCloseDetails() {
	var sourceUpWin = L5.getCmp("sourceUpWin");
	sourceUpWin.hide();
}

//附件管理
function onStuffer(){
	var stufferWin = L5.getCmp("stufferWin");
	stufferWin.show();
}
//关闭附件
function onCloseStuffer(){
	var stufferWin = L5.getCmp("stufferWin");
	stufferWin.hide();
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
//渲染源资金总额
function amountTotalRenderer(value, cellmeta, record,
		rowindex, colindex,
		dataset) {
	//var totals = record.get("amountCentral")+record.get("amountDepartment")+record.get("amountCity")+record.get("amountCounty");
	var totals = 0.0;
	if(!isNaN(parseFloat(record.get("amountCentral"))))
		totals += parseFloat(record.get("amountCentral"));
	if(!isNaN(parseFloat(record.get("amountDepartment"))))
		totals += parseFloat(record.get("amountDepartment"));
	if(!isNaN(parseFloat(record.get("amountCity"))))
		totals += parseFloat(record.get("amountCity"));
	if(!isNaN(parseFloat(record.get("amountCounty"))))
		totals += parseFloat(record.get("amountCounty"));
	record.set("amount", totals);	
	return formatMoneyForDis(value);
}
//渲染备注
function noteRenderer(value, cellmeta, record, rowindex, colindex,
		dataset) {
	if(record.get("ifCarry")=="1")
		return "【已结转】"+value;
	return value;
}
