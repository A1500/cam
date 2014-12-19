function init() {
	var tree = L5.getCmp("dicCitytree");
}
/**
 * 定义根节点结构,从数据库中获得根节点
 */
var rootdata2 = function() {
	var command = new L5.Command("com.inspur.cams.fis.base.cmd.FisDicCityCommand");
	var rootRecord;
	if (rootId == 'null' || rootId == '' || rootId == undefined) {
		command.setParameter("rootId", "rootId");
	} else {
		command.setParameter("rootId", rootId);
	}
	command.execute("getRootForHelp");
	if (!command.error) {
		rootRecord = command.getReturn("rootRecord");
	} else {
		L5.Msg.alert("提示", command.error);
	}
	return {
		id : rootRecord.id,
		name : rootRecord.name,
		leve : rootRecord.leve,
		ups : rootRecord.ups,
		fullName : rootRecord.fullName,
		flag : rootRecord.flag,
		recordType : 'dicCityRecord'
	};
};
/**
 * var rootdata = { id:"rootId", name:"中国", leve:'-1', ups:'', fullName:'',
 * flag:'', recordType : 'dicCityRecord' };
 */
var rootdata = rootdata2();
/**
 * 事件处理：获得 TreebaseParams的值
 */
function getParent(rec) {
	var parentObjId = rec.get('id');
	var levelValue = rec.get("leve");
	if (levelValue == '1' || levelValue == '2') {
		return '1';
	} else {
		return parentObjId ? parentObjId : '1';
	}

}
/**
 * 事件处理：获得 TreebaseParams的值
 */
function getParentOrgan(rec) {
	var parentObjId = rec.get('id');
	return parentObjId ? parentObjId.substring(0, 6) : 'rootId';
}
// 根据类型值获取图标路径
function getIcon(rec) {
	var figpath = L5.webPath + "/skins/images";
	var leve = rec.get('leve');
	var value = parseInt(leve);
	switch (value) {
		case 1 : // 根结点
			file = figpath + "/l5/root.gif";
			break;
		case 2 : // 二级节点
			file = figpath + "/l5/bsp_department&corporation.gif";
			break;
		case 3 : // 三级节点
			file = figpath + "/l5/bsp_department&corporation.gif";
			break;
		default : // 四级节点
			file = figpath + "/l5/bsp_post.png";
	}
	return file;
}
// 殡仪馆信息
function getOrganManage(record) {
	var leve = record.get("leve");
	// 市级触发
	if (leve == '1' || leve == '2') {
		return true;
	}
	return false;
}
// 过滤单选按钮
function getRadioBox(record) {
	if (record.recordType == 'fisFuneralOrganRecord') {
		if (radioType == '0') {
			return 'radiobox';
		} else if (radioType == '1') {
			return 'checkbox';
		} else {
			return '';
		}
	} else {
		return '';
	}
}
// 确认
function confirmValue() {
	var tree = L5.getCmp("dicCitytree");
	var areaCode = tree.getChecked("UNIT_ID");
	var areaName = tree.getChecked("UNIT_NAME");
	if (areaCode != "" && areaName != "") {
		window.returnValue = areaCode + ";" + areaName;
		window.close();
	} else {
		L5.Msg.alert("提示", "请选择组织节点!");
		return false;
	}
}
// 关闭窗口
function closew() {
	window.returnValue = "";
	window.close();
}
// 清除
function clears() {
	window.returnValue = ";";
	window.close();
}