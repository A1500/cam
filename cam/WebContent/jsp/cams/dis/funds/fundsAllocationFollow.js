var year = nowYear;
var isInit = false;
var alloGrage="1"; //拨付按钮类型（市级专用）：1为上级，2为本级
function init() {
	L5.Msg.wait("正在加载数据，请等待...", "加载数据");
	var disFundsBatchDs = L5.DatasetMgr.lookup("disFundsBatchDs");
	var disFundsSourceDs = L5.DatasetMgr.lookup("disFundsSourceDs");
	var disFundsBatchSourceDs = L5.DatasetMgr.lookup("disFundsBatchSourceDs");
	
	//判断资金拨付追踪
	disFundsSourceAlloDs.events['load'] = true; 
	disFundsSourceAlloDs.on('load',function(){
		if(disFundsSourceAlloDs.getCount()>1) {
			//打开window
			var FollowAlloWin = L5.getCmp("FollowAlloWin");
			FollowAlloWin.show();
		}else if(disFundsSourceAlloDs.getCount()==1) {
			//直接打开
			openFollowAlloDetail(disFundsSourceAlloDs.getAt(0).get("BATCH_ID"), disFundsSourceAlloDs.getAt(0).get("FILL_ORGAN_NAME"));
		}
	});
	//判断物资折款追踪
	disFundsSourceSwapDs.events['load'] = true; 
	disFundsSourceSwapDs.on('load',function(){
		if(disFundsSourceSwapDs.getCount()>1) {
			//打开window
			var FollowSwapWin = L5.getCmp("FollowSwapWin");
			FollowSwapWin.show();
		}else if(disFundsSourceSwapDs.getCount()==1) {
			//直接打开
			openFollowSwapDetail(disFundsSourceSwapDs.getAt(0).get("BATCH_ID"),disFundsSourceSwapDs.getAt(0).get("FILL_ORGAN_NAME"));
		}
	});
	
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
	});
	
	disFundsBatchDs.setParameter("BATCH_ID", batchId);
	disFundsBatchDs.load();
	disFundsSourceDs.setParameter("organCode", organCode);
	disFundsSourceDs.setParameter("batchId", batchId);
	disFundsSourceDs.load();
	var disFundsBatchSourceDs = L5.DatasetMgr.lookup("disFundsBatchSourceDs");
	disFundsBatchSourceDs.setParameter("receiveOrganCode", organCode);
	disFundsBatchSourceDs.setParameter("batchId", batchId);
	disFundsBatchSourceDs.setParameter("inUse", "1");
	disFundsBatchSourceDs.load();
	var disAccessoriesDs = L5.DatasetMgr.lookup("disAccessoriesDs");
	disAccessoriesDs.setParameter("ITEM_ID", batchId);
	disAccessoriesDs.load();
	
	var allocationAllGrid = L5.getCmp("allocationAllGrid");
	if(organType=="11") {
		//省
	}else if(organType=="12") {
		//市
		allocationAllGrid.getColumnModel().setHidden(7, false);
	}else if(organType=="13") {
		//县区市
		allocationAllGrid.getColumnModel().setHidden(5, true);
		allocationAllGrid.getColumnModel().setHidden(6, true);
		allocationAllGrid.getColumnModel().setHidden(7, false);
		allocationAllGrid.getColumnModel().setHidden(8, false);
	} else {
		L5.Msg.alert("提示", "未知等级，不能进入此页面！", function(){
			onCancel();
		});
	}
	
	L5.Msg.hide();
}
//返回
function onCancel() {
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
//查看明细
function onDetails(){
	var detailsWin = L5.getCmp("detailsWin");
	detailsWin.show();
}
//关闭明细
function onCloseDetails() {
	var detailsWin = L5.getCmp("detailsWin");
	detailsWin.hide();
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
//拨付渲染
function amountBfRenderer(value, cellmeta, record, rowindex, colindex, dataset) {
	if(value>0.0)
		return '<a href="javascript:bfQuery(\''
				+ disFundsSourceDs.indexOf(record) + '\')">' + formatMoneyForDis(value) + '</a>';
	return formatMoneyForDis(value);
}
//拨付查询
function bfQuery(index) {
	var record = disFundsSourceDs.getAt(index);
	if(record.get("AMOUNT_BF")>0.0) {
		disFundsSourceAlloDs.setParameter("organCode", record.get("ID"));
		disFundsSourceAlloDs.setParameter("batchId", record.get("BATCH_ID"));
		disFundsSourceAlloDs.setParameter("sourceId", record.get("SOURCE_ID"));
		disFundsSourceAlloDs.load();
	}
}
//关闭资金追踪多记录窗口
function onCloseFollowAlloWin(){
	var FollowAlloWin = L5.getCmp("FollowAlloWin");
	FollowAlloWin.hide();
}
//查看资金追踪明细
function onFollowAlloDetail(){
	var followAlloGrid = L5.getCmp("followAlloGrid");
	var selected = followAlloGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录进行查看!");
		return false;
	}
	openFollowAlloDetail(selected[0].get("BATCH_ID"), selected[0].get("NAME"));
}
//进入明细页面
function openFollowAlloDetail(bId, rName) {
	var rNameCode=escape(encodeURIComponent(rName));
	var url = 'fundsAllocationFollow.jsp?method=update&batchId='+bId+"&organNameTitleCode="+rNameCode;
	var width = screen.width-50;
    var height = screen.height-50;
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
}

//物资折款渲染
function amountWzRenderer(value,cellmeta,record,rowindex,colindex,dataset) {
	if(value>0.0)
		return '<a href="javascript:wzQuery(\''
				+ disFundsSourceDs.indexOf(record) + '\')">' + formatMoneyForDis(value) + '</a>';
	return formatMoneyForDis(value);
}
//物资折款查询
function wzQuery(index) {
	var record = disFundsSourceDs.getAt(index);
	if(record.get("AMOUNT_WZ")>0.0) {
		disFundsSourceSwapDs.setParameter("organCode", record.get("ID"));
		disFundsSourceSwapDs.setParameter("batchId", record.get("BATCH_ID"));
		disFundsSourceSwapDs.setParameter("sourceId", record.get("SOURCE_ID"));
		disFundsSourceSwapDs.load();
	}
}
//关闭物资折款追踪多记录窗口
function onCloseFollowSwapWin(){
	var FollowSwapWin = L5.getCmp("FollowSwapWin");
	FollowSwapWin.hide();
}
//查看物资折款追踪明细
function onFollowSwapDetail(){
	var followSwapGrid = L5.getCmp("followSwapGrid");
	var selected = followSwapGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录进行查看!");
		return false;
	}
	openFollowSwapDetail(selected[0].get("BATCH_ID"), selected[0].get("NAME"));
}
//进入物资折款明细页面
function openFollowSwapDetail(bId, rName) {
	var rNameCode=escape(encodeURIComponent(rName));
	var url = 'fundsGoodSwapDetails.jsp?batchId='+bId+"&organNameTitleCode="+rNameCode;
	var width = screen.width-50;
    var height = screen.height-50;
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
}