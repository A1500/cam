function init() {
	if(ifFill!="T") {
		document.getElementById("btnAdd").style.display = 'none';
		document.getElementById("btnEdit").style.display = 'none';
		document.getElementById("btnDelete").style.display = 'none';
		document.getElementById("btnImport").style.display = 'none';
	}
	if (batchDetailId != "" && batchDetailId != null) {
		infoDs.setParameter("BATCH_DETAIL_ID", batchDetailId);
		infoDs.setParameter("sort","accept_Area_Name,name,fill_Time,info_Id");	
		infoDs.setParameter("dir","desc");
		infoDs.load();
	}
}
function query() {
	infoDs.setParameter("BATCH_DETAIL_ID", batchDetailId);
	infoDs.setParameter("NAME@rlike", getParam("qName"));
	infoDs.setParameter("ACCEPT_AREA_CODE", getParam("qAcceptAreaCode"));
	infoDs.load();
}
//进入追加页面
function add() {
	var url = 'cjEdit.jsp?method=insert&batchId=' + batchId + '&batchDetailId='
			+ batchDetailId;
	var width = 900;
	var height = 580;
	var win = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:0");
	if (true || win) {
		infoDs.reload();
	}
}
//修改档案信息
function edit() {
	var editGrid = L5.getCmp('cjGrid');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录修改!");
		return false;
	}
	var url = 'cjEdit.jsp?method=update&batchId=' + batchId + '&batchDetailId='
			+ batchDetailId+'&infoId='+selected[0].get('infoId');
	var width = 900;
	var height = 580;
	var win = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:0");
	if (win == true) {
		infoDs.reload();
	}
}
//删除档案信息
function deleteInfo() {
	var editGrid = L5.getCmp('cjGrid');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length == 0) {
		L5.Msg.alert('提示', "请选择一条记录删除!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?', function(state) {
		if (state == "yes") {
			var command = new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefBatchDetailCmd");
			command.setParameter("infoRecs", selected);
			command.setParameter("batchDetailId", batchDetailId);
			command.execute("deleteInfo");
			if (!command.error) {
				L5.Msg.alert('提示', "删除成功！", function(){
					query();
				});
			} else {
				L5.Msg.alert('提示', "删除时出现错误！" + command.error);
			}
		} else {
			return false;
		}
	});
}
//进入明细页面
function detail() {
	var editGrid = L5.getCmp('cjGrid');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录查看明细!");
		return false;
	}
	var url = 'cjDetail.jsp?method=detail&batchId=' + batchId + '&batchDetailId='
			+ batchDetailId+'&infoId='+selected[0].get('infoId');
	var width = 900;
	var height = 580;
	var win = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:0");
}
//进入汇总页面
function sums() {
	batchDetailds.setParameter("batchId", batchId);
	batchDetailds.setParameter("batchDetailId", batchDetailId);
//	batchDetailds.setParameter("workflowStatus", '3,6');
	batchDetailds.load();
	
	var win = L5.getCmp("sumWin");
	win.show();
}
function closeWin(){
	var win = L5.getCmp("sumWin");
	win.hide();
}
// 选择住址行政区划窗口
function forOrganSelect() {
	var revalue = window.showModalDialog(L5.webPath
					+ "/jsp/cams/dis/comm/dicCity.jsp?organCode=" + organCode
					+ "&organName=" + escape(encodeURIComponent(organName))
					+ "&radioType=radiobox&level=4", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("qAcceptAreaCode").value = list[0];
		document.getElementById("qAcceptAreaName").value = list[4];
	}
}
// 打印人员信息按钮
function printPeople() {
}
//导出Excel
function forExcel(){
	var dataset=L5.DatasetMgr.lookup("infoDs");
	if(dataset.getCount()<=0){
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}	
	L5.dataset2excel(dataset, "/jsp/cams/dis/relief/cj/cjListExcel.jsp");
}
//导入Excel
function forImport(){
	L5.Msg.alert('提示', "正在研发!");
	return false;
}