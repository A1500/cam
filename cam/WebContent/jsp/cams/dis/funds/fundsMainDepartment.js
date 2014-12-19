function init() {
	disDetailBatchSourceDs.setParameter("receiveOrganCode", organCode);
	disDetailBatchSourceDs.load();
	
	disFundsTempDs.setParameter("receiveOrganCode", organCode);
	disFundsTempDs.setParameter("disYear", nowYear);
	disFundsTempDs.load();
}
// 打开指定的url
function openUrls(_url) {
	var width = screen.width;
	var height = screen.height;
	var returnValue = window.showModalDialog(_url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:0");
}
//上级下拨区别
function fundsUpUse() {
	if (organType == "12") {
		openUrls("fundsSourceListOfUpDepartment.jsp");
	} else {
		openUrls("fundsSourceListOfUp.jsp");
	}
}

// 渲染物资类型
function meterialTypeRenderer(value, cellmeta, record, rowindex, colindex,
		dataset) {
	var pos = dmDisMaterialTypeDs.find("code", value, 0);
	if (pos != -1) {
		var rec = dmDisMaterialTypeDs.getAt(pos);
		record.set("METERIAL_UNIT", rec.get("unit"));
		return rec.get("name");
	}
	return "";
}


/**
 ************************
 * 		资金总表渲染
 ************************
 */
// 渲染总资金
function amountBalanceRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "<a href='#' onclick=openUrls('fundsSourceList.jsp')>"
				+ formatMoneyForDis(value) + "</a>万元";
	else
		return formatMoneyForDis(value) + "万元";
}
// 渲染上级下拨-未确认记录数
function sjNumRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "<a href='#' onclick='fundsUpUse()'>"+value+"</a>笔记录，请尽快使用！";
	else
		return value + "笔记录";
}
// 渲染上级下拨-未确认总金额
function sjAmountRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "<a href='#' onclick='fundsUpUse()'>"+formatMoneyForDis(value)+"</a>万元";
	else
		return formatMoneyForDis(value) + "万元";
}
// 渲染上级下拨-记录数
function sjNumAllRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "<a href='#' onclick='fundsUpUse()'>"+value+"</a>笔记录";
	else
		return value + "笔记录";
}
// 渲染上级下拨-总金额
function sjAmountAllRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "<a href='#' onclick='fundsUpUse()'>"+formatMoneyForDis(value)+"</a>万元";
	else
		return formatMoneyForDis(value) + "万元";
}

// 渲染本级投入-未确认预算数
function bjNumRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "<a href='#' onclick=openUrls('fundsSourceListOfSelf.jsp')>"+value+"</a>笔预算，请尽快使用！";
	else
		return value + "笔预算";
}
// 渲染本级投入-未确认总金额
function bjAmountRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "<a href='#' onclick=openUrls('fundsSourceListOfSelf.jsp')>"+formatMoneyForDis(value)+"</a>万元";
	else
		return formatMoneyForDis(value) + "万元";
}
// 渲染本级投入-预算数
function bjNumAllRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "<a href='#' onclick=openUrls('fundsSourceListOfSelf.jsp')>"+value+"</a>笔预算";
	else
		return value + "笔预算";
}
// 渲染本级投入-总金额
function bjAmountAllRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "<a href='#' onclick=openUrls('fundsSourceListOfSelf.jsp')>"+formatMoneyForDis(value)+"</a>万元";
	else
		return formatMoneyForDis(value) + "万元";
}

// 渲染社会捐赠-未确认记录数
function shNumRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "<a href='#' onclick=openUrls('fundsSourceListOfCon.jsp')>"+value+"</a>笔记录，请尽快使用！";
	else
		return value + "笔记录";
}
// 渲染社会捐赠-未确认总金额
function shAmountRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "<a href='#' onclick=openUrls('fundsSourceListOfCon.jsp')>"+formatMoneyForDis(value)+"</a>万元";
	else
		return formatMoneyForDis(value) + "万元";
}
// 渲染社会捐赠-记录数
function shNumAllRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "<a href='#' onclick=openUrls('fundsSourceListOfCon.jsp')>"+value+"</a>笔记录";
	else
		return value + "笔记录";
}
// 渲染社会捐赠-总金额
function shAmountAllRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "<a href='#' onclick=openUrls('fundsSourceListOfCon.jsp')>"+formatMoneyForDis(value)+"</a>万元";
	else
		return formatMoneyForDis(value) + "万元";
}


// 资金拨付-记录数
function bfNumRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "<a href='#' onclick=openUrls('fundsAllocationList.jsp')>"+value+"</a>笔记录，请尽快确认！";
	else
		return value + "笔记录";
}

/**
 ************************
 * 		物资总表渲染
 ************************
 */



