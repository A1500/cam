function init(){
	notifyDataset.load(true);
	disFundsTempDs.setParameter("receiveOrganCode", organCode);
	disFundsTempDs.setParameter("disYear", nowYear);
	disFundsTempDs.load();
	
	if(organType=="13") {
		document.getElementById("townTr").style.display='none';
		document.getElementById("countryTr").style.display = '';
		document.getElementById("countryReqTr").style.display = '';
		document.getElementById("doleFundsTr").style.display = '';
		document.getElementById("doleDetailTr").style.display = '';
		
		disReliefBatchDetailCommitDs.setParameter("REQUIRED_ORGAN_CODE@rlike",
				organCode.substring(0, 6));
		disReliefBatchDetailCommitDs.setParameter("YEAR", nowYear);
		disReliefBatchDetailCommitDs.setParameter("FILL_STATE@in", "3,6");
		disReliefBatchDetailCommitDs.on('load', function() {
			if (disReliefBatchDetailCommitDs.getCount() > 0) {
				document.getElementById("countryFill").innerHTML = "已有<a href=# onclick=openUrls('relief/approveList.jsp')>"
						+ disReliefBatchDetailCommitDs.getCount()
						+ "</a>个单位报送救助档案，请尽快审批！";
			}else {
				document.getElementById("countryTr").style.display = 'none';
			}
		});
		disReliefBatchDetailCommitDs.load(true);
		
		disReliefBatchDetailReqDs.setParameter("REQUIRED_ORGAN_CODE@rlike", organCode.substring(0, 6));
		disReliefBatchDetailReqDs.setParameter("YEAR", nowYear);
		disReliefBatchDetailReqDs.setParameter("IF_REPORT", "0");
		disReliefBatchDetailReqDs.setParameter("FILL_STATE@in", "2");
		disReliefBatchDetailReqDs.on('load', function() {
			if (disReliefBatchDetailReqDs.getCount() > 0) {
				document.getElementById("countryReqFill").innerHTML = "已有<a href=# onclick=openUrls('relief/approveList.jsp')>"
						+ disReliefBatchDetailReqDs.getCount()
						+ "</a>个单位上报需求，请尽快审核上报需求！";
			} else {
				document.getElementById("countryReqTr").style.display = 'none';
			}
		});
		disReliefBatchDetailReqDs.load();
	}else if(organType=="14") {
		document.getElementById("townTr").style.display='';
		document.getElementById("countryTr").style.display = 'none';
		document.getElementById("countryReqTr").style.display = 'none';
		document.getElementById("doleFundsTr").style.display = '';
		document.getElementById("doleDetailTr").style.display = '';
		
		disReliefBatchDetailDs.setParameter("REQUIRED_ORGAN_CODE", organCode);
		disReliefBatchDetailDs.setParameter("YEAR", nowYear);
		disReliefBatchDetailDs.setParameter("FILL_STATE", "0");
		disReliefBatchDetailDs.on('load', function() {
			if (disReliefBatchDetailDs.getCount() > 0) {
				document.getElementById("townFill").innerHTML = "已接到上级下发救助任务（<a href=# onclick=openUrls('relief/auditList.jsp')>"
						+ disReliefBatchDetailDs.getCount() + "</a>个），请尽快填报！";
			}else {
				document.getElementById("townTr").style.display='none';
			}
		});
		disReliefBatchDetailDs.load();
	}else {
		document.getElementById("townTr").style.display='none';
		document.getElementById("countryTr").style.display = 'none';
		document.getElementById("countryReqTr").style.display = 'none';
		document.getElementById("doleFundsTr").style.display = 'none';
		document.getElementById("doleDetailTr").style.display = 'none';
	}
	
	if(organType=="13" || organType=="14") {
		disReliefBatchDetailFundsDoleDs.setParameter("organType", organType);
		disReliefBatchDetailFundsDoleDs.setParameter("requiredOrganCode", organCode);
		disReliefBatchDetailFundsDoleDs.setParameter("doleType", "1");
		disReliefBatchDetailFundsDoleDs.on('load', function() {
			if (disReliefBatchDetailFundsDoleDs.getCount() > 0) {
				document.getElementById("doleFundsFill").innerHTML = "已有<a href=# onclick=openUrls('dole/fundsRollList.jsp')>"
						+ disReliefBatchDetailFundsDoleDs.getCount()
						+ "</a>个批次完成审批，请尽快进行资金发放！";
			} else {
				document.getElementById("doleFundsTr").style.display = 'none';
			}
		});
		disReliefBatchDetailFundsDoleDs.load();
		
		disReliefBatchDetailDetailDoleDs.setParameter("organType", organType);
		disReliefBatchDetailDetailDoleDs.setParameter("requiredOrganCode", organCode);
		disReliefBatchDetailDetailDoleDs.setParameter("doleType", "2");
		disReliefBatchDetailDetailDoleDs.on('load', function() {
			if (disReliefBatchDetailDetailDoleDs.getCount() > 0) {
				document.getElementById("doleDetailFill").innerHTML = "已有<a href=# onclick=openUrls('dole/goodsRollList.jsp')>"
						+ disReliefBatchDetailDetailDoleDs.getCount()
						+ "</a>个批次完成审批，请尽快进行物资发放！";
			} else {
				document.getElementById("doleDetailTr").style.display = 'none';
			}
		});
		disReliefBatchDetailDetailDoleDs.load();
	}
}
function click_send() {
	var _url = "../comm/inform/sendnotifylist.jsp";
	var width = screen.width;
	var height = screen.height;
	var returnValue = window.showModalDialog(_url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:0");
}
/**
 * 事件处理：查看明细
 */
function click_view(queryid) {
	var GridPanelOne = L5.getCmp('gridPanel');
	var selected = GridPanelOne.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录！");
		return false;
	}
	var queryid = selected[0].get('ID');
	_url = "../comm/inform/viewinform.jsp?queryid=" + queryid + "&page=receivepage";
	var width = screen.width;
	var height = screen.height;
	var returnValue = window.showModalDialog(_url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:0");
}

/**
 * 事件处理：点击删除按钮
 */
function click_delete() {

	var gridPanel = L5.getCmp('gridPanel');
	var selected = gridPanel.getSelectionModel().getSelections();
	if (selected.length == 0) {
		L5.Msg.alert('提示', "请选择一条或多条记录！");
		return false;
	}
	L5.MessageBox.confirm('提示', '确认执行删除操作吗?该操作不能恢复！', function(state) {
		if (state == "yes") {
			var notifyDataset = L5.DatasetMgr.lookup("notifyDataset");
			for ( var i = 0; i < selected.length; i++) {
				notifyDataset.remove(selected[i]);
			}
			// 构造Command对象,并将修改的record数组作为参数,并执行
			var command = new L5.Command("com.inspur.cams.comm.inform.InformCommand");
			command.setParameter("records", selected);
			command.execute("deleteInformPrivileges");
			// 如果执行没有错误,dataset接受所有修改,否则弹出错误信息：
			if (!command.error) {
				notifyDataset.commitChanges();
				L5.Msg.alert('提示', '所选通知已成功删除！');
			} else {
				L5.Msg.alert('提示', command.error);
			}
			notifyDataset.load();
		} else {
			return false;
		}
	});
}

/**
 * 事件处理：点击查询按钮
 */
var win;// 查询窗口对象
function click_query() {
	win = L5.getCmp("organize");
	win.setPosition(300,50);
	// 显示查询窗口,动画效果，从点击处弹出
	win.show();
}
/**
 * 显示格式化:提示信息格式化
 */
function cautionRender(state){
	if(state=="0"){
		var url = L5.webPath;
		return "<img src='"+ url +"/skins/images/new.gif'/>";
	}else{
		return "已阅";
	}
}
/**
 * 标题超链接
 */
function titleRender(value){
	return "<font color='blue'>"+value+"</blue>";
}
// 渲染接收单位
function receiveRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	var str = " ";
	for (var i = 0; i < receiveOrganDS.getCount(); i++) {
		if (value.indexOf(receiveOrganDS.getAt(i).get("value")) != -1) {
			str += receiveOrganDS.getAt(i).get("text") + ",";
		}
	}
	return str.substring(0, str.length - 1);
}
function query() {
	var notifyDataset = L5.DatasetMgr.lookup("notifyDataset");
	notifyDataset.setParameter("titlequery",document.getElementById("titlequery").value);
	notifyDataset.setParameter("sendmanIdquery",document.getElementById("sendmanIdquery").value);
	notifyDataset.load();
}
function undoit() {
	win = L5.getCmp("organize");
	win.hide();
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
		openUrls("funds/fundsSourceListOfUpDepartment.jsp");
	} else {
		openUrls("funds/fundsSourceListOfUp.jsp");
	}
}

// 渲染总资金
function amountBalanceRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	if (value > 0)
		return "<a href='#' onclick=openUrls('funds/fundsSourceList.jsp')>"
				+ formatMoneyForDis(value) + "</a>万元";
	else
		return formatMoneyForDis(value) + "万元";
}

// 渲染上级下拨-总金额
function sjAmountAllRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	var str = "";
	str+= "上级下拨资金尚有<a href='#' onclick='fundsUpUse()'>"+formatMoneyForDis(value)+"</a>万元，请及时下拨使用！";
	return str;
}

// 渲染本级投入-总金额
function bjAmountAllRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	var str = "";
	str+= "本级预算资金尚有<a href='#' onclick=openUrls('funds/fundsSourceListOfSelf.jsp')>"+formatMoneyForDis(value)+"</a>万元，请及时下拨使用！";
	return str;
}

// 渲染社会捐赠-总金额
function shAmountAllRenderer(value, cellmeta, record, rowindex,
		colindex, dataset) {
	var str = "";
	return "社会捐赠资金尚有<a href='#' onclick=openUrls('funds/fundsSourceListOfCon.jsp')>"+formatMoneyForDis(value)+"</a>万元，请及时下拨使用！";
	return str;
}