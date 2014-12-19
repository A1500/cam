function init() {
	document.getElementById("moduleCodePrexx").value = modulePrexx;
	
	var menuTypeDataSet = L5.DatasetMgr.lookup("menuTypeDataSet");
	menuTypeDataSet.load();
	
	var menuItemDataSet = L5.DatasetMgr.lookup("menuItemDataSet");
	menuItemDataSet.baseParams["MODULE_CODE@rlike@String"]= modulePrexx;
	menuItemDataSet.baseParams["MENU_ID@rlike@String"]= "00";
	menuItemDataSet.on('load',function () {
		document.getElementById("maxNumItem").innerText = menuItemDataSet.getCount();
	});
	menuItemDataSet.load();
	
	var menuStruDataSet = L5.DatasetMgr.lookup("menuStruDataSet");
	menuStruDataSet.baseParams["MENU_PATH@rlike@String"]= modulePrexx;
	menuStruDataSet.baseParams["MENU_STRU_ID@rlike@String"]= "00";
	menuStruDataSet.on('load',function () {
		document.getElementById("maxNumStru").innerText = menuStruDataSet.getCount();
	});
	menuStruDataSet.load();
}

function save() {
	if(!(document.getElementById("moduleCodePrexx").value)){
		L5.Msg.alert("提示","请输入主键前缀!");
		return;
	}
	
//	if(document.getElementById("maxNum").innerText=="0") {
//		L5.Msg.alert("提示","不需要校正!");
//		return;
//	}
//	alert(document.getElementById("menuConfig").value);
	var cmd = new L5.Command('com.inspur.cams.comm.menuconfig.cmd.CustomMenuCommand');
	cmd.setParameter('moduleCode',document.getElementById("moduleCodePrexx").value);
	cmd.setParameter('menuConfig',document.getElementById("menuConfig").value);
	cmd.execute('updatePk');
	if (!cmd.error) {
		L5.Msg.alert("提示","更新成功!");
	}else {
		L5.Msg.alert("提示","更新失败!"+cmd.error);
	}
}

