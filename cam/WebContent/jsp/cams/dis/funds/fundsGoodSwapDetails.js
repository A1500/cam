var year = nowYear;
var isInit = false;
var alloGrage="1"; //拨付按钮类型（市级专用）：1为上级，2为本级
function init() {
	L5.Msg.wait("正在加载数据，请等待...", "加载数据");
	var disDetailBatchDs = L5.DatasetMgr.lookup("disDetailBatchDs");
	var disDetailSourceDs = L5.DatasetMgr.lookup("disDetailSourceDs");
	var disDetailBatchSourceDs = L5.DatasetMgr.lookup("disDetailBatchSourceDs");
	var disDetailBatchFundsSourceDs = L5.DatasetMgr.lookup("disDetailBatchFundsSourceDs");
	disDetailBatchFundsSourceDs.events['load'] = true; 
	disDetailBatchFundsSourceDs.on('load',function(){
		var upA = 0.0;
		var selfA = 0.0;
		var conA = 0.0;
		for(var i=0;i<disDetailBatchFundsSourceDs.getCount();i++) {
			var rec = disDetailBatchFundsSourceDs.getAt(i);
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
		
		disDetailBatchFundsSourceDs.filterBy(function(record, id) {
							if (record.get("amountPay") > 0.0) {
								return record;
							}
						});
	});

	
	disDetailBatchDs.setParameter("BATCH_ID", batchId);
	disDetailBatchDs.load();
	disDetailSourceDs.setParameter("BATCH_ID", batchId);
	disDetailSourceDs.load();
	disDetailBatchSourceDs.setParameter("batchId", batchId);
	disDetailBatchSourceDs.load();
	var disDetailBatchFundsSourceDs = L5.DatasetMgr.lookup("disDetailBatchFundsSourceDs");
	disDetailBatchFundsSourceDs.setParameter("receiveOrganCode", organCode);
	disDetailBatchFundsSourceDs.setParameter("batchId", batchId);
	disDetailBatchFundsSourceDs.load();
	var disAccessoriesDs = L5.DatasetMgr.lookup("disAccessoriesDs");
	disAccessoriesDs.setParameter("ITEM_ID", batchId);
	disAccessoriesDs.load();

	L5.Msg.hide();
	
	if(organType!="11" && organType!="12" && organType!="13" && organType!="14") {
		L5.Msg.alert("提示", "未知等级，不能进入此页面！", function(){
			onCancel();
		});
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
//渲染备注
function noteRenderer(value, cellmeta, record, rowindex, colindex,
		dataset) {
	if(record.get("ifCarry")=="1")
		return "【已结转】"+value;
	return value;
}
//返回
function onCancel() {
	window.returnValue="T";
	window.close();
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