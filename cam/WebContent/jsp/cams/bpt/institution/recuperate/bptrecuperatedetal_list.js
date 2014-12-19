function init() {
	var ds = L5.DatasetMgr.lookup("ds");
	ds.baseParams["BATCH_ID@="] = idField;
	ds.load();
	L5.QuickTips.init();
};

function back() {
	history.go(-1);
}

function add() {
	var url = 'basicInfoList.jsp?batchId=' + idField;
	var width = screen.width - 100;
	var height = screen.height - 140;
	var returnValue = window.showModalDialog(url, window,
			"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
	ds.reload();
}

function del() {

	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert('提示', "请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?', function(state) {
		if (state == "yes") {
			var delIds = [];
			for (var i = 0; i < selected.length; i++) {
				delIds[i] = selected[i].get("id");
			}
			var command = new L5.Command("com.inspur.cams.bpt.bptrecuperate.cmd.BptRecuperateCommand");
			command.setParameter("delIds", delIds);
			command.setParameter("batchId", idField)
			command.execute("deleteDetails");
			if (!command.error) {
				for (var i = 0; i < selected.length; i++) {
					ds.remove(selected[i]);
				}
				ds.commitChanges();
			} else {
				L5.Msg.alert('提示', "保存时出现错误！" + command.error);
			}
		} else {
			return false;
		}
	});

}

//查看人员基本信息
function peopleDetail(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:openDetail(\'' + record.data["peopleId"] + '\',\''+record.data["name"]+'\',\''+record.data["idCard"]+'\',\''+record.data["objectType"]+'\')">' + value + '</a>';
}

function openDetail(peopleId,username,idCard,objectType){
	var command = new L5.Command("com.inspur.cams.bpt.bptrecuperate.cmd.BptRecuperateCommand");
	command.setParameter("PEOPLE_ID", peopleId)
	command.execute("queryPeopleIdByFamilyId");
	var familyId = command.getReturn("familyId");
	var url = L5.webPath+"/jsp/cams/bpt/basicInfoView/basicInfoDetail.jsp?peopleId="+peopleId+"&familyId="+familyId+"&username="+name+"&idCard="+idCard+"&objectState=2&objectType="+objectType;
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if (win==null) {
		return;
	}
}

function save() {
	var records = ds.getAllChangedRecords();
	var command = new L5.Command("com.inspur.cams.bpt.bptrecuperate.cmd.BptRecuperateCommand");
	command.setParameter("records", records);
	command.execute("updateDetailPlace");
	if (!command.error) {
		ds.reload();
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}
