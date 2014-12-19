//机构状态
var jgztDs = new L5.model.SimpleDataset({id:"jgztDs",
	fields: ['value','text']});
	
// 获取组件值
function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}

//初始化判断权限的显示
function initPer() {
	if(regionCode != null && regionCode != '' && regionCode != 'null' && regionCode != undefined) {
		if(regionCode.length == 2) {
			//省级
			var regionCodeSub = L5.get("regionCodeSub");
			regionCodeSub.setVisible(true);
			var regionCodeSubSub = L5.get("regionCodeSubSub");
			regionCodeSubSub.setVisible(false);
			
			var xzqhDs_Base = L5.DatasetMgr.lookup("xzqhDs_Base");
			xzqhDs_Base.setParameter("CODE@=", regionCode + "0000");
			xzqhDs_Base.on("load", function onXzqhDs_BaseLoadT(){
				var dcss = document.getElementById("regionCode");
				dcss.selectedIndex = 1;
				dcss.disabled = true;
				
				//加载下属地市权限
				var rec = xzqhDs_Base.getAt(0);
				var xzqhDs_Sub = L5.DatasetMgr.lookup("xzqhDs_Sub");
				xzqhDs_Sub.setParameter("PID@=", rec.get("id"));
				xzqhDs_Sub.load();
			});
			xzqhDs_Base.load();
		}else if(regionCode.length == 4) {
			//市级		
			var regionCodeSub = L5.get("regionCodeSub");
			regionCodeSub.setVisible(true);	
			var regionCodeSubSub = L5.get("regionCodeSubSub");
			regionCodeSubSub.setVisible(true);
			
			//加载当前登录人的省市权限
			var xzqhDs_Base = L5.DatasetMgr.lookup("xzqhDs_Base");
			xzqhDs_Base.setParameter("CODE@=", regionCode.substr(0,2) + "0000");
			xzqhDs_Base.on("load", function onXzqhDs_BaseLoadT(){
				var dcss = document.getElementById("regionCode");
				dcss.selectedIndex = 1;
				dcss.disabled = true;
			});
			xzqhDs_Base.load();
			var xzqhDs_Sub = L5.DatasetMgr.lookup("xzqhDs_Sub");
			xzqhDs_Sub.setParameter("CODE@=", regionCode + "00");
			xzqhDs_Sub.on("load", function onXzqhDs_SubLoadT(){
				var dcss = document.getElementById("regionCodeSub");
				dcss.selectedIndex = 1;
				dcss.disabled = true;

				//加载下属县区权限
				var rec = xzqhDs_Sub.getAt(0);
				var xzqhDs_Sub_Sub = L5.DatasetMgr.lookup("xzqhDs_Sub_Sub");
				xzqhDs_Sub_Sub.setParameter("PID@=", rec.get("id"));
				xzqhDs_Sub_Sub.load();
			});
			xzqhDs_Sub.load();
		}else if(regionCode.length == 6) {
			//区县级
			var regionCodeSub = L5.get("regionCodeSub");
			regionCodeSub.setVisible(true);
			var regionCodeSubSub = L5.get("regionCodeSubSub");
			regionCodeSubSub.setVisible(true);
			
			//加载当前登录用户的省市县权限
			var xzqhDs_Base = L5.DatasetMgr.lookup("xzqhDs_Base");
			xzqhDs_Base.setParameter("CODE@=", regionCode.substr(0,2) + "0000");
			xzqhDs_Base.on("load", function onXzqhDs_BaseLoadT(){
				var dcss = document.getElementById("regionCode");
				dcss.selectedIndex = 1;
				dcss.disabled = true;
			});
			xzqhDs_Base.load();
			var xzqhDs_Sub = L5.DatasetMgr.lookup("xzqhDs_Sub");
			xzqhDs_Sub.setParameter("CODE@=", regionCode.substr(0,4) + "00");
			xzqhDs_Sub.on("load", function onXzqhDs_SubLoadT(){
				var dcss = document.getElementById("regionCodeSub");
				dcss.selectedIndex = 1;
				dcss.disabled = true;
			});
			xzqhDs_Sub.load();
			var xzqhDs_Sub_Sub = L5.DatasetMgr.lookup("xzqhDs_Sub_Sub");
			xzqhDs_Sub_Sub.setParameter("CODE@=", regionCode);
			xzqhDs_Sub_Sub.on("load", function onXzqhDs_Sub_SubLoadT(){
				var dcss = document.getElementById("regionCodeSubSub");
				dcss.selectedIndex = 1;
				dcss.disabled = true;
			});
			xzqhDs_Sub_Sub.load();
		}
	}else {
		//如果不存在regionCode，则加载全部
		var xzqhDs_Base = L5.DatasetMgr.lookup("xzqhDs_Base");
		xzqhDs_Base.setParameter("PID@=", "1");
		xzqhDs_Base.load();
		
		var regionCodeSub = L5.get("regionCodeSub");
		regionCodeSub.setVisible(false);
		var regionCodeSubSub = L5.get("regionCodeSubSub");
		regionCodeSubSub.setVisible(false);
	}
}


// 初始化
function init() {
	jgztDs.loadData([['0','新增'],
		['1','有效'],
		['9','停用']],false);
		
	var jglxDs = L5.DatasetMgr.lookup("jglxDs");
	jglxDs.setParameter("PID@=", "1100");
	jglxDs.load();
	
	var jgxzDs = L5.DatasetMgr.lookup("jgxzDs");
	jgxzDs.setParameter("PID@=", "840");
	jgxzDs.load();
	
	var xzqhDs = L5.DatasetMgr.lookup("xzqhDs");
	xzqhDs.load();
	
	// 添加表格行双击事件
	var editGridPanel = L5.getCmp('editGridPanel');
	editGridPanel.on("rowdblclick", queryDetails);
	
	// 联动初始化
	var regionCodeSub = L5.get("regionCodeSub");
	regionCodeSub.setVisible(false);
	var regionCodeSubSub = L5.get("regionCodeSubSub");
	regionCodeSubSub.setVisible(false);


	L5.get("regionCode").on('change', function onxzqhChange() {
		var regionCode = L5.get("regionCode");
		var selectedValue = regionCode.getValue();
		if (selectedValue) {
			var xzqhDs_Sub = L5.DatasetMgr.lookup("xzqhDs_Sub");
			xzqhDs_Sub.setParameter("PID@=", selectedValue);
			xzqhDs_Sub.on("load", function onxzqhDs_SubLoad() {
						var regionCodeSub = L5.get("regionCodeSub");
						if (xzqhDs_Sub.getTotalCount() > 0
								&& regionCodeSub.isVisible)
							regionCodeSub.setVisible(true);
					});
			xzqhDs_Sub.load();
		} else {
			var regionCodeSub = L5.get("regionCodeSub");
			regionCodeSub.setVisible(false);
		}

		var regionCodeSubSub = L5.get("regionCodeSubSub");
		regionCodeSubSub.setVisible(false);
	});

	L5.get("regionCodeSub").on('change', function onxzqhSubChange() {
		var regionCode = L5.get("regionCodeSub");
		var selectedValue = regionCode.getValue();
		if (selectedValue) {
			var xzqhDs_Sub_Sub = L5.DatasetMgr.lookup("xzqhDs_Sub_Sub");
			xzqhDs_Sub_Sub.setParameter("PID@=", selectedValue);
			xzqhDs_Sub_Sub.on("load", function onxzqhDs_Sub_SubLoad() {
						var regionCodeSubSub = L5.get("regionCodeSubSub");
						if (xzqhDs_Sub_Sub.getTotalCount() > 0)
							regionCodeSubSub.setVisible(true);
						else
							regionCodeSubSub.setVisible(false);
					});
			xzqhDs_Sub_Sub.load();
		} else {
			var regionCodeSubSub = L5.get("regionCodeSubSub");
			regionCodeSubSub.setVisible(false);
		}
	});
	
	var ds = L5.DatasetMgr.lookup("ds");
	ds.on("load", function onDsLoad() {
				if (ds.getTotalCount() == 0)
					L5.Msg.alert("提示", "无符合条件的结果！");
				else {
					var qrToolbar = L5.getCmp("qrToolbar");
					qrToolbar.setText("查询结果（" + ds.getTotalCount() + "条）: ");
				}
				var _dateTemp2 = (new Date()).valueOf();
				//alert((_dateTemp2 - _dateTemp) / 1000.0 + "秒");
			});
	
	document.getElementById("validFlag").selectedIndex = 2;
	initPer();
	
	L5.QuickTips.init();
};

// 查询
function query() {
	//加载查询条件
	var name = getParam("name");
	var adminType = getParam("adminType");
	var type = getParam("type");
	var validFlag = getParam("validFlag");
	
	var regionCode_C = L5.get("regionCode");
	var regionCodeSub_C = L5.get("regionCodeSub");
	var regionCodeSubSub_C = L5.get("regionCodeSubSub");
	var regionCode = regionCode_C.getValue();
	var regionCodeSub = regionCodeSub_C.getValue();
	var regionCodeSubSub = regionCodeSubSub_C.getValue();
	
	//判断是否存在查询条件
	var i = 0;
	if(name!="" && name!=undefined)	i++;
	if(adminType!="" && adminType!=undefined)	i++;
	if(type!="" && type!=undefined)	i++;
	if(validFlag!="" && validFlag!=undefined)	i++;
	if(regionCode!="" && regionCode!=undefined)	i++;
	
	if(i == 0) {
		alert("必须选择输入一种查询条件！");
		return false;
	}
	
	//验证
	var validateBlankLine = /^\s+$/;	//验证空行
	var validateSFZ = /(^\d{15}$)|(^\d{17}([0-9]|X)$)/ //简易身份证号码验证
	if(name!="" && name!=undefined) {
		if(validateBlankLine.test(name)) {
			alert("姓名格式错误！");
			return false;
		}
	}
	
	ds.baseParams["NAME@=@String"]= undefined;
	ds.baseParams["ADMIN_TYPE@=@String"]= undefined;
	ds.baseParams["TYPE@=@String"]= undefined;
	ds.baseParams["VALID_FLAG@=@String"]= undefined;
	ds.baseParams["REGION_CODE@rlike@String"]= undefined;
	
	ds.baseParams["NAME@=@String"]= name;
	ds.baseParams["ADMIN_TYPE@=@String"]= adminType;
	ds.baseParams["TYPE@=@String"]= type;
	ds.baseParams["VALID_FLAG@=@String"]= validFlag;
	
	//判断行政区划
	var regionCodeG = undefined;
	var regionGrade = 1;
	
	if(regionCode_C.isVisible() && regionCode!="" && regionCode!=undefined) {
		regionCodeG = regionCode;
		regionGrade = 1;
	}
	if(regionCodeSub_C.isVisible() && regionCodeSub!="" && regionCodeSub!=undefined) {
		regionCodeG = regionCodeSub;
		regionGrade = 2;
	}
	if(regionCodeSubSub_C.isVisible() && regionCodeSubSub!="" && regionCodeSubSub!=undefined) {
		regionCodeG = regionCodeSubSub;
		regionGrade = 3;
	}
	
	if(regionCodeG != "" && regionCodeG != undefined) {
		if(regionGrade == 1) {
			var xzqhDs_Base = L5.DatasetMgr.lookup("xzqhDs_Base");
			var rec = xzqhDs_Base.getAt(xzqhDs_Base.find("id", regionCodeG));
			regionCodeG = rec.get("code");
			regionCodeG = regionCodeG.substr(0,2);
		}else if(regionGrade == 2) {
			var xzqhDs_Sub = L5.DatasetMgr.lookup("xzqhDs_Sub");
			var rec = xzqhDs_Sub.getAt(xzqhDs_Sub.find("id", regionCodeG));
			regionCodeG = rec.get("code");
			regionCodeG = regionCodeG.substr(0,4);
		}else if(regionGrade == 3){
			var xzqhDs_Sub_Sub = L5.DatasetMgr.lookup("xzqhDs_Sub_Sub");
			var rec = xzqhDs_Sub_Sub.getAt(xzqhDs_Sub_Sub.find("id", regionCodeG));
			regionCodeG = rec.get("code");
		}
		ds.baseParams["REGION_CODE@rlike@String"]= regionCodeG;
	}
		
	_dateTemp = (new Date()).valueOf();
	ds.load();
}

//追加重置命令，隐藏行政区划的二三级
function resetApply() {
	initPer();
	try{
		setTimeout(function test() {
			document.getElementById("validFlag").selectedIndex = 2;
		},100);
	}catch(e){}
}

// 查看企业明细信息
function queryDetails() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录查看!");
		return false;
	}
	
	var _w = window.screen.availWidth;
	var _h = window.screen.availHeight;
	if(_w > 1000)
		_w = 1000;

	var id = selected[0].get('id');	
	var deptCode = selected[0].get('deptCode');	
	//showModelessDialog window
	window.open(
					"marry_dept_details.jsp?method=DETAILS&dataBean=" + id + "&code=" + deptCode,
					"_blank",
					"scroll:yes;status:no;resizable:no;unadorned:yes;dialogTop:0px;dialogLeft:0px;dialogWidth:" + _w + "px;dialogHeight:" + _h + "px;");
}

//导出为Excel
function exportExcel() {
	var ds = L5.DatasetMgr.lookup("ds");
	if(ds.getCount() <= 0) {
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}
	L5.dataset2excel(ds, "/jsp/cams/marry/exportMarryDeptExcel.jsp");
}

// 渲染行政区划
function xzqhRenderer(value, cellmeta, record, rowindex, colindex, dataset, a,
		b) {
	var tempDs = L5.DatasetMgr.lookup("xzqhDs");
	var a = tempDs.getTotalCount();

	for (var i = 0; i < tempDs.getTotalCount(); i++) {
		var rec = tempDs.getAt(i);
		if (rec.get("code") == value)
			return rec.get("name");
	}

	return "";
}

// 渲染机构类型
function jglxRenderer(value, cellmeta, record, rowindex, colindex, dataset, a,
		b) {
	var tempDs = L5.DatasetMgr.lookup("jglxDs");
	var a = tempDs.getTotalCount();

	for (var i = 0; i < tempDs.getTotalCount(); i++) {
		var rec = tempDs.getAt(i);
		if (rec.get("value") == value)
			return rec.get("text");
	}

	return "";
}

// 渲染机构性质
function jgxzRenderer(value, cellmeta, record, rowindex, colindex, dataset, a,
		b) {
	var tempDs = L5.DatasetMgr.lookup("jgxzDs");
	var a = tempDs.getTotalCount();

	for (var i = 0; i < tempDs.getTotalCount(); i++) {
		var rec = tempDs.getAt(i);
		if (rec.get("value") == value)
			return rec.get("text");
	}

	return "";
}

// 渲染机构状态
function ryztRenderer(value, cellmeta, record, rowindex, colindex, dataset, a,
		b) {
	var a = jgztDs.getTotalCount();

	for (var i = 0; i < jgztDs.getTotalCount(); i++) {
		var rec = jgztDs.getAt(i);
		if (rec.get("value") == value)
			return rec.get("text");
	}

	return "";
}

