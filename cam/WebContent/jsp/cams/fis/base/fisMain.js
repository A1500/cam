var userInfo;
function init() {
	userInfo = initArea();
	var fisImportDS = L5.DatasetMgr.lookup("fisImportDS");
	
	if(userId.length == 10 && userId.substring(0,2)=='37' && userId.substring(6,8)=='99') {
		fisImportDS.setParameter("fId", 'BZ'+userId.substring(0,6)+'-'+userId.substring(8,10));
	}else{
		var manaId = userInfo.cantCode;
		if (manaId.substring(2) == "0000000000") {
			fisImportDS.setParameter("organCode", manaId.substring(0, 2));
		} else if (manaId.substring(4) == "00000000") {
			fisImportDS.setParameter("organCode", manaId.substring(0, 4));
		} else {
			fisImportDS.setParameter("organCode", manaId.substring(0, 6));
		}
	}
	fisImportDS.load();
	
	
	var fisCemeImportDS = L5.DatasetMgr.lookup("fisCemeImportDS");
	if(userId.length == 10 && userId.substring(0,2)=='37' && userId.substring(6,8)=='99') {
		fisCemeImportDS.setParameter("fId", 'GZ'+userId.substring(0,6)+'-'+userId.substring(8,10));
	}else{
		var manaId = userInfo.cantCode;
		if (manaId.substring(2) == "0000000000") {
			fisCemeImportDS.setParameter("organCode", manaId.substring(0, 2));
		} else if (manaId.substring(4) == "00000000") {
			fisCemeImportDS.setParameter("organCode", manaId.substring(0, 4));
		} else {
			fisCemeImportDS.setParameter("organCode", manaId.substring(0, 6));
		}
	}
	fisCemeImportDS.load();
}

// 渲染明细
function detailHref(value, cellmeta, record, rowindex, colindex, dataset) {
//	if(record.get("DAY_DIFF") == '')
//		return '<a href="javascript:detail(\'' + record.get("UNIT_ID") + '\')">'
//			+ value + '</a>';
//	else if(record.get("DAY_DIFF") < '3')
//		return '<a href="javascript:detail(\'' + record.get("UNIT_ID") + '\')">'
//			+ value + '</a>';
//	else
		return '<a href="javascript:detail(\'' + record.get("UNIT_ID") + '\')">'
			+ value + '</a>';
}
//
// 明细
function detail(unitId) {
	var url = "funeralOrganImportDetail.jsp?method=detail&unitId=" + unitId;
	window.showModalDialog(url, window,
					"scroll:yes;status:no;dialogWidth:1024px;dialogHeight:768px;resizable:1");
}

// 渲染亮灯类型
function ldlxRenderer(value, cellmeta, record, rowindex, colindex, dataset, a,
		b) {
	if(record.get("DAY_DIFF") != null && parseInt(record.get("DAY_DIFF")+"") <= 1) {
		return "<IMG style='VERTICAL-ALIGN: middle' alt='正常上报' src='../images/lv.gif' width=16 height=16/>";
	} else if(record.get("DAY_DIFF") != null && parseInt(record.get("DAY_DIFF")+"") <= 3) {
		return "<IMG style='VERTICAL-ALIGN: middle' alt='超过2天未上报' src='../images/huang.gif' width=16 height=16/>";
	}else {
		return "<IMG style='VERTICAL-ALIGN: middle' alt='超过3天未上报' src='../images/hong.gif' width=16 height=16/>";
	}
	return '';
}

function testRenderer(value, cellmeta, record, rowindex, colindex, dataset, a,
		b) {
	return '';	
}
