function init() {
	var ds = L5.DatasetMgr.lookup("ds");
	if (method == "detail") {
		ds.setParameter("UNIT_ID@=", unitId);
		ds.load();
		fisResourceTypeDS.setParameter("CREATE_ORGAN@=", unitId);
		fisResourceTypeDS.on('load', function() {
					var fisEquipmentInfoDS = L5.DatasetMgr.lookup("fisEquipmentInfoDS");
					fisEquipmentInfoDS.setParameter("CREATE_ORGAN@=", unitId);
					fisEquipmentInfoDS.setParameter("STATUS@<>", '3');
					fisEquipmentInfoDS.load();
					
					var fisFacilitiesInfoDS = L5.DatasetMgr.lookup("fisFacilitiesInfoDS");
					fisFacilitiesInfoDS.setParameter("CREATE_ORGAN@=", unitId);
					fisFacilitiesInfoDS.setParameter("STATUS@<>", '3');
					fisFacilitiesInfoDS.load();
				});
		fisResourceTypeDS.load();

		var FisFuneralOrganBuildareaDs = L5.DatasetMgr.lookup("FisFuneralOrganBuildareaDs");
		FisFuneralOrganBuildareaDs.setParameter("CREATE_ORGAN@=", unitId);
		FisFuneralOrganBuildareaDs.on('load', function() {
					if (FisFuneralOrganBuildareaDs.getCount() <= 0) {
						for (var i = 0; i < buildAreaDataSet.getCount(); i++) {
							FisFuneralOrganBuildareaDs.newRecord({
										"areaId" : buildAreaDataSet.getAt(i)
												.get("value"),
										"areaNum" : 0.0
									});
						}
					}
				});
		FisFuneralOrganBuildareaDs.load();
	}
	
	L5.QuickTips.init();
}

function goBack() {
	history.go(-1);
}

// 设备名称渲染
function equipmentDetailHref(value, cellmeta, record, rowindex, colindex,
		dataset) {
	return '<a href="javascript:equDetail(\'' + record.get("equipmentId")
			+ '\')">' + value + '</a>';
}

function equDetail(equipmentId) {
	var fisEquipmentInfoEditDS = L5.DatasetMgr.lookup("fisEquipmentInfoEditDS");
	fisEquipmentInfoEditDS.setParameter("EQUIPMENT_ID", equipmentId);
	fisEquipmentInfoEditDS.setParameter("CREATE_ORGAN", unitId);
	fisEquipmentInfoEditDS.load();
	var equWin = L5.getCmp("equipmentWindowDetail");
	equWin.show();
}

function closeEquDetail() {
	var equWin = L5.getCmp("equipmentWindowDetail");
	equWin.hide();
}

function facilitiesDetailHref(value, cellmeta, record, rowindex, colindex,
		dataset) {
	return '<a href="javascript:facDetail(\'' + record.get("facilitiesId")
			+ '\')">' + value + '</a>';
}

function facDetail(facilitiesId) {
	var fisFacilitiesInfoEditDS = L5.DatasetMgr.lookup("fisFacilitiesInfoEditDS");
	fisFacilitiesInfoEditDS.setParameter("FACILITIES_ID", facilitiesId);
	fisFacilitiesInfoEditDS.setParameter("CREATE_ORGAN", unitId);
	fisFacilitiesInfoEditDS.load();
	var facWin = L5.getCmp("facilitiesWindowDetail");
	facWin.show();
}

function closeFacDetail() {
	var facWin = L5.getCmp("facilitiesWindowDetail");
	facWin.hide();
}

// 数字格式化
function getMoneyFormat(value) {
	return formatNum(value);
}
