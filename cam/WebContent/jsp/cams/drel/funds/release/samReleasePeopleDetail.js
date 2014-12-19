function init() {
	var PeopleDetailListDs = L5.DatasetMgr.lookup("PeopleDetailListDs");
	PeopleDetailListDs.setParameter("name", name);
	PeopleDetailListDs.setParameter("idCard", idCard);
	PeopleDetailListDs.setParameter("qReleaseDate",qReleaseDate);
	PeopleDetailListDs.setParameter("domicileCode", domicileCode);
	PeopleDetailListDs.setParameter("assistanceType", assistanceType);
	PeopleDetailListDs.load();
};
function viewCloseWin(){
	window.close();
}
//导出家庭成员信息
function exportPeopleDetail(){
	var dataset = L5.DatasetMgr.lookup("PeopleDetailListDs");
	if (dataset.getCount() < 1) {
		L5.Msg.alert("提示", "没有要导出的信息！");
		return;
	}
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]="1"; //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor; //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();//导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	L5.dataset2excel(dataset,
			"/jsp/cams/drel/funds/release/samReleasePeopleDetailExcel.jsp?assistanceType="+assistanceType);
}
