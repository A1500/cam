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
			var deptCodeSub = L5.get("deptCodeSub");
			deptCodeSub.setVisible(true);
			var deptCodeSubSub = L5.get("deptCodeSubSub");
			deptCodeSubSub.setVisible(false);
			
			var djjgDs_Base = L5.DatasetMgr.lookup("djjgDs_Base");
			djjgDs_Base.setParameter("REGION_CODE@=", regionCode + "0000");
			djjgDs_Base.on("load", function onDjjgDs_BaseLoadT(){
				var dcss = document.getElementById("deptCode");
				dcss.selectedIndex = 1;
				dcss.disabled = true;
				
				//加载下属地市权限
				var rec = djjgDs_Base.getAt(0);
				var djjgDs_Sub = L5.DatasetMgr.lookup("djjgDs_Sub");
				djjgDs_Sub.setParameter("PID@=", rec.get("id"));
				djjgDs_Sub.load();
			});
			djjgDs_Base.load();
		}else if(regionCode.length == 4) {
			//市级		
			var deptCodeSub = L5.get("deptCodeSub");
			deptCodeSub.setVisible(true);	
			var deptCodeSubSub = L5.get("deptCodeSubSub");
			deptCodeSubSub.setVisible(true);
			
			//加载当前登录人的省市权限
			var djjgDs_Base = L5.DatasetMgr.lookup("djjgDs_Base");
			djjgDs_Base.setParameter("REGION_CODE@=", regionCode.substr(0,2) + "0000");
			djjgDs_Base.on("load", function onDjjgDs_BaseLoadT(){
				var dcss = document.getElementById("deptCode");
				dcss.selectedIndex = 1;
				dcss.disabled = true;
			});
			djjgDs_Base.load();
			var djjgDs_Sub = L5.DatasetMgr.lookup("djjgDs_Sub");
			djjgDs_Sub.setParameter("REGION_CODE@=", regionCode + "00");
			djjgDs_Sub.on("load", function onDjjgDs_SubLoadT(){
				var dcss = document.getElementById("deptCodeSub");
				dcss.selectedIndex = 1;
				dcss.disabled = true;
			
				//加载下属县区权限
				var rec = djjgDs_Sub.getAt(0);
				var djjgDs_Sub_Sub = L5.DatasetMgr.lookup("djjgDs_Sub_Sub");
				djjgDs_Sub_Sub.setParameter("PID@=", rec.get("id"));
				djjgDs_Sub_Sub.load();
			});
			djjgDs_Sub.load();
		}else if(regionCode.length == 6) {
			//区县级
			var deptCodeSub = L5.get("deptCodeSub");
			deptCodeSub.setVisible(true);
			var deptCodeSubSub = L5.get("deptCodeSubSub");
			deptCodeSubSub.setVisible(true);
			
			//加载当前登录用户的省市县权限
			var djjgDs_Base = L5.DatasetMgr.lookup("djjgDs_Base");
			djjgDs_Base.setParameter("REGION_CODE@=", regionCode.substr(0,2) + "0000");
			djjgDs_Base.on("load", function onDjjgDs_BaseLoadT(){
				var dcss = document.getElementById("deptCode");
				dcss.selectedIndex = 1;
				dcss.disabled = true;
			});
			djjgDs_Base.load();
			var djjgDs_Sub = L5.DatasetMgr.lookup("djjgDs_Sub");
			djjgDs_Sub.setParameter("REGION_CODE@=", regionCode.substr(0,4) + "00");
			djjgDs_Sub.on("load", function onDjjgDs_SubLoadT(){
				var dcss = document.getElementById("deptCodeSub");
				dcss.selectedIndex = 1;
				dcss.disabled = true;
			});
			djjgDs_Sub.load();
			var djjgDs_Sub_Sub = L5.DatasetMgr.lookup("djjgDs_Sub_Sub");
			djjgDs_Sub_Sub.setParameter("REGION_CODE@=", regionCode);
			djjgDs_Sub_Sub.on("load", function onDjjgDs_Sub_SubLoadT(){
				var dcss = document.getElementById("deptCodeSubSub");
				dcss.selectedIndex = 1;
				dcss.disabled = true;
			});
			djjgDs_Sub_Sub.load();
		}
	}else {
		//如果不存在regionCode，则加载全部
		var djjgDs_Base = L5.DatasetMgr.lookup("djjgDs_Base");
		djjgDs_Base.setParameter("PID@=", "1");
		djjgDs_Base.load();
		
		var deptCodeSub = L5.get("deptCodeSub");
		deptCodeSub.setVisible(false);
		var deptCodeSubSub = L5.get("deptCodeSubSub");
		deptCodeSubSub.setVisible(false);
	}
}

// 初始化
function init() {
	var ywlbDs = L5.DatasetMgr.lookup("ywlbDs");
	ywlbDs.setParameter("PID@=", "760");
	ywlbDs.load();

	// 添加表格行双击事件
	var editGridPanel = L5.getCmp('editGridPanel');
	editGridPanel.on("rowdblclick", queryDetails);

	// 登记机构 联动初始化
	var deptCodeSub = L5.get("deptCodeSub");
	deptCodeSub.setVisible(false);
	var deptCodeSubSub = L5.get("deptCodeSubSub");
	deptCodeSubSub.setVisible(false);

	L5.get("deptCode").on('change', function onDjjgChange() {
		var deptCode = L5.get("deptCode");
		var selectedValue = deptCode.getValue();
		if (selectedValue) {
			var djjgDs_Sub = L5.DatasetMgr.lookup("djjgDs_Sub");
			djjgDs_Sub.setParameter("PID@=", selectedValue);
			//djjgDs_Sub.setParameter("DEPT_CODE@not like", "%0099");
			djjgDs_Sub.on("load", function onDjjgDs_SubLoad() {
						var deptCodeSub = L5.get("deptCodeSub");
						if (djjgDs_Sub.getTotalCount() > 0
								&& deptCodeSub.isVisible)
							deptCodeSub.setVisible(true);
					});
			djjgDs_Sub.load();
		} else {
			var deptCodeSub = L5.get("deptCodeSub");
			deptCodeSub.setVisible(false);
		}

		var deptCodeSubSub = L5.get("deptCodeSubSub");
		deptCodeSubSub.setVisible(false);
	});

	L5.get("deptCodeSub").on('change', function onDjjgSubChange() {
		var deptCode = L5.get("deptCodeSub");
		var selectedValue = deptCode.getValue();
		if (selectedValue) {
			var djjgDs_Sub_Sub = L5.DatasetMgr.lookup("djjgDs_Sub_Sub");
			djjgDs_Sub_Sub.setParameter("PID@=", selectedValue);
			//djjgDs_Sub_Sub.setParameter("DEPT_CODE@not like", "%0099");
			djjgDs_Sub_Sub.on("load", function onDjjgDs_Sub_SubLoad() {
						var deptCodeSubSub = L5.get("deptCodeSubSub");
						if (djjgDs_Sub_Sub.getTotalCount() > 0)
							deptCodeSubSub.setVisible(true);
						else
							deptCodeSubSub.setVisible(false);
					});
			djjgDs_Sub_Sub.load();
		} else {
			var deptCodeSubSub = L5.get("deptCodeSubSub");
			deptCodeSubSub.setVisible(false);
		}
	});
	
	// 男方行政区划联动初始化
	var regionCodeSub = L5.get("regionCodeSub");
	regionCodeSub.setVisible(false);
	var regionCodeSubSub = L5.get("regionCodeSubSub");
	regionCodeSubSub.setVisible(false);

	var xzqhDs_Base = L5.DatasetMgr.lookup("xzqhDs_Base");
	xzqhDs_Base.setParameter("PID@=", "1");
	xzqhDs_Base.load();

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
	
	// 女方行政区划 联动初始化
	var regionCodeSubW = L5.get("regionCodeSubW");
	regionCodeSubW.setVisible(false);
	var regionCodeSubSubW = L5.get("regionCodeSubSubW");
	regionCodeSubSubW.setVisible(false);

	var xzqhDs_BaseW = L5.DatasetMgr.lookup("xzqhDs_BaseW");
	xzqhDs_BaseW.setParameter("PID@=", "1");
	xzqhDs_BaseW.load();

	L5.get("regionCodeW").on('change', function onxzqhWChange() {
		var regionCodeW = L5.get("regionCodeW");
		var selectedValue = regionCodeW.getValue();
		if (selectedValue) {
			var xzqhDs_SubW = L5.DatasetMgr.lookup("xzqhDs_SubW");
			xzqhDs_SubW.setParameter("PID@=", selectedValue);
			xzqhDs_SubW.on("load", function onxzqhDs_SubWLoad() {
						var regionCodeSubW = L5.get("regionCodeSubW");
						if (xzqhDs_SubW.getTotalCount() > 0
								&& regionCodeSubW.isVisible)
							regionCodeSubW.setVisible(true);
					});
			xzqhDs_SubW.load();
		} else {
			var regionCodeSubW = L5.get("regionCodeSubW");
			regionCodeSubW.setVisible(false);
		}

		var regionCodeSubSubW = L5.get("regionCodeSubSubW");
		regionCodeSubSubW.setVisible(false);
	});

	L5.get("regionCodeSubW").on('change', function onxzqhSubWChange() {
		var regionCodeW = L5.get("regionCodeSubW");
		var selectedValue = regionCodeW.getValue();
		if (selectedValue) {
			var xzqhDs_Sub_SubW = L5.DatasetMgr.lookup("xzqhDs_Sub_SubW");
			xzqhDs_Sub_SubW.setParameter("PID@=", selectedValue);
			xzqhDs_Sub_SubW.on("load", function onxzqhDs_Sub_SubWLoad() {
						var regionCodeSubSubW = L5.get("regionCodeSubSubW");
						if (xzqhDs_Sub_SubW.getTotalCount() > 0)
							regionCodeSubSubW.setVisible(true);
						else
							regionCodeSubSubW.setVisible(false);
					});
			xzqhDs_Sub_SubW.load();
		} else {
			var regionCodeSubSubW = L5.get("regionCodeSubSubW");
			regionCodeSubSubW.setVisible(false);
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
	
	initPer();
	
//	var d = new Date(); 
//	document.getElementById("opDateTo").value = d.getYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate();
	L5.QuickTips.init();
};

// 查询
function query() {
	//加载查询条件
	var opType = getParam("opType");
	var opDate = getParam("opDate");
	var opDateTo = getParam("opDateTo");
	var nameMan = getParam("nameMan");
	var nameWoman = getParam("nameWoman");
	var certNumMan = getParam("certNumMan");
	var certNumWoman = getParam("certNumWoman");
	
	var deptCode_C = L5.get("deptCode");
	var deptCodeSub_C = L5.get("deptCodeSub");
	var deptCodeSubSub_C = L5.get("deptCodeSubSub");
	var deptCode = deptCode_C.getValue();
	var deptCodeSub = deptCodeSub_C.getValue();
	var deptCodeSubSub = deptCodeSubSub_C.getValue();
	
	var regionCode_C = L5.get("regionCode");
	var regionCodeSub_C = L5.get("regionCodeSub");
	var regionCodeSubSub_C = L5.get("regionCodeSubSub");
	var regionCode = regionCode_C.getValue();
	var regionCodeSub = regionCodeSub_C.getValue();
	var regionCodeSubSub = regionCodeSubSub_C.getValue();
	
	var regionCode_CW = L5.get("regionCodeW");
	var regionCodeSub_CW = L5.get("regionCodeSubW");
	var regionCodeSubSub_CW = L5.get("regionCodeSubSubW");
	var regionCodeW = regionCode_CW.getValue();
	var regionCodeSubW = regionCodeSub_CW.getValue();
	var regionCodeSubSubW = regionCodeSubSub_CW.getValue();
	
	//判断是否存在查询条件
	var i = 0;
	if(opType!="" && opType!=undefined)	i++;
	if((opDate!="" && opDate!=undefined) ||(opDateTo!="" && opDateTo!=undefined))	i++;
	if(nameMan!="" && nameMan!=undefined)	i++;
	if(nameWoman!="" && nameWoman!=undefined)	i++;
	if(certNumMan!="" && certNumMan!=undefined)	i++;
	if(certNumWoman!="" && certNumWoman!=undefined)	i++;
	if(deptCode!="" && deptCode!=undefined)	i++;
	if(regionCode!="" && regionCode!=undefined)	i++;
	if(regionCodeW!="" && regionCodeW!=undefined)	i++;
	
	if(i == 0) {
		alert("必须选择输入一种查询条件！");
		return false;
	}
	
	//验证
	var validateBlankLine = /^\s+$/;	//验证空行
	var validateSFZ = /(^\d{15}$)|(^\d{17}([0-9]|X)$)/ //简易身份证号码验证
	if(nameMan!="" && nameMan!=undefined) {
		if(validateBlankLine.test(nameMan)) {
			alert("男方姓名格式错误！");
			return false;
		}
	}	
	
	if(nameWoman!="" && nameWoman!=undefined) {
		if(validateBlankLine.test(nameWoman)) {
			alert("女方姓名格式错误！");
			return false;
		}
	}
	
	if(certNumMan!="" && certNumMan!=undefined) {
		if(!validateSFZ.test(certNumMan)) {
			alert("男方证件号码格式错误！");
			return false;
		}
	}
	
	if(certNumWoman!="" && certNumWoman!=undefined) {
		if(!validateSFZ.test(certNumWoman)) {
			alert("女方证件号码格式错误！");
			return false;
		}
	}
	
	if(!validateDate(document.getElementById("opDate"), "\"登记日期起\"日期格式不正确！")) {
		return false;
	}
	
	if(!validateDate(document.getElementById("opDateTo"), "\"登记日期止\"日期格式不正确！")) {
		return false;
	}
	
	ds.baseParams["OP_TYPE@=@String"]= undefined;
	ds.baseParams["NAME_MAN@=@String"]= undefined;
	ds.baseParams["NAME_WOMAN@=@String"]= undefined;
	ds.baseParams["CERT_NUM_MAN@=@String"]= undefined;
	ds.baseParams["CERT_NUM_WOMAN@=@String"]= undefined;
	ds.baseParams["DEPT_CODE@rlike@String"]= undefined;
	
	ds.baseParams["REG_SJ_MAN@=@String"]= undefined;
	ds.baseParams["REG_SJ_WOMAN@=@String"]= undefined;
	ds.baseParams["REG_DS_MAN@=@String"]= undefined;
	ds.baseParams["REG_DS_WOMAN@=@String"]= undefined;
	ds.baseParams["REG_QX_MAN@=@String"]= undefined;
	ds.baseParams["REG_QX_WOMAN@=@String"]= undefined;
		
	ds.baseParams["OP_TYPE@=@String"]= opType;
	ds.baseParams["NAME_MAN@=@String"]= nameMan;
	ds.baseParams["NAME_WOMAN@=@String"]= nameWoman;
	ds.baseParams["CERT_NUM_MAN@=@String"]= certNumMan;
	ds.baseParams["CERT_NUM_WOMAN@=@String"]= certNumWoman;
	
	//判断登记机关
	var deptCodeG = undefined;
	var deptGrade = 1;
	if(deptCode_C.isVisible() && deptCode!="" && deptCode!=undefined) {
		deptCodeG = deptCode;
		deptGrade = 1;
	}
	if(deptCodeSub_C.isVisible() && deptCodeSub!="" && deptCodeSub!=undefined) {
		deptCodeG = deptCodeSub;
		deptGrade = 2;
	}
	if(deptCodeSubSub_C.isVisible() && deptCodeSubSub!="" && deptCodeSubSub!=undefined) {
		deptCodeG = deptCodeSubSub;
		deptGrade = 3;
	}
	
	if(deptCodeG != "" && deptCodeG != undefined) {
		if(deptGrade == 1) {
			var djjgDs_Base = L5.DatasetMgr.lookup("djjgDs_Base");
			var rec = djjgDs_Base.getAt(djjgDs_Base.find("id", deptCodeG));
			deptCodeG = rec.get("deptCode");
			deptCodeG = deptCodeG.substr(0,2);
		}else if(deptGrade == 2) {
			var djjgDs_Sub = L5.DatasetMgr.lookup("djjgDs_Sub");
			var rec = djjgDs_Sub.getAt(djjgDs_Sub.find("id", deptCodeG));
			deptCodeG = rec.get("deptCode");
			deptCodeG = deptCodeG.substr(0,4);
		}else if(deptGrade == 3){
			var djjgDs_Sub_Sub = L5.DatasetMgr.lookup("djjgDs_Sub_Sub");
			var rec = djjgDs_Sub_Sub.getAt(djjgDs_Sub_Sub.find("id", deptCodeG));
			deptCodeG = rec.get("deptCode");
		}
		ds.baseParams["DEPT_CODE@rlike@String"]= deptCodeG;
	}
	
	//判断登记日期
	var opDateG = "";
	if(opDate && opDateTo) {
		if(opDate < opDateTo)
			opDateG = opDate + "~" + opDateTo;
		else
			opDateG = opDateTo + "~" + opDate;
	}else {
		var d = new Date();
		
		if(opDateTo) 
			opDateG = "1900-01-01~" + opDateTo;
		else if(opDate)
			opDateG = opDate + "~" + d.getYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate();
		else 
			opDateG = undefined;
	}
	ds.baseParams["OP_DATE@between@Date"]= opDateG;
	
	//判断男方行政区划
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
			ds.baseParams["REG_SJ_MAN@=@String"]= regionCodeG;
		}else if(regionGrade == 2) {
			var xzqhDs_Sub = L5.DatasetMgr.lookup("xzqhDs_Sub");
			var rec = xzqhDs_Sub.getAt(xzqhDs_Sub.find("id", regionCodeG));
			regionCodeG = rec.get("code");
			ds.baseParams["REG_DS_MAN@=@String"]= regionCodeG;
		}else if(regionGrade == 3){
			var xzqhDs_Sub_Sub = L5.DatasetMgr.lookup("xzqhDs_Sub_Sub");
			var rec = xzqhDs_Sub_Sub.getAt(xzqhDs_Sub_Sub.find("id", regionCodeG));
			regionCodeG = rec.get("code");
			ds.baseParams["REG_QX_MAN@=@String"]= regionCodeG;
		}
	}
	
	//判断女方行政区划
	var regionCodeGW = undefined;
	var regionGradeW = 1;
	
	if(regionCode_CW.isVisible() && regionCodeW!="" && regionCodeW!=undefined) {
		regionCodeGW = regionCodeW;
		regionGradeW = 1;
	}
	if(regionCodeSub_CW.isVisible() && regionCodeSubW!="" && regionCodeSubW!=undefined) {
		regionCodeGW = regionCodeSubW;
		regionGradeW = 2;
	}
	if(regionCodeSubSub_CW.isVisible() && regionCodeSubSubW!="" && regionCodeSubSubW!=undefined) {
		regionCodeGW = regionCodeSubSubW;
		regionGradeW = 3;
	}
	
	if(regionCodeGW != "" && regionCodeGW != undefined) {
		if(regionGradeW == 1) {
			var xzqhDs_BaseW = L5.DatasetMgr.lookup("xzqhDs_BaseW");
			var rec = xzqhDs_BaseW.getAt(xzqhDs_BaseW.find("id", regionCodeGW));
			regionCodeGW = rec.get("code");
			ds.baseParams["REG_SJ_WOMAN@=@String"]= regionCodeGW;
		}else if(regionGradeW == 2) {
			var xzqhDs_SubW = L5.DatasetMgr.lookup("xzqhDs_SubW");
			var rec = xzqhDs_SubW.getAt(xzqhDs_SubW.find("id", regionCodeGW));
			regionCodeGW = rec.get("code");
			ds.baseParams["REG_DS_WOMAN@=@String"]= regionCodeGW;
		}else if(regionGradeW == 3){
			var xzqhDs_Sub_SubW = L5.DatasetMgr.lookup("xzqhDs_Sub_SubW");
			var rec = xzqhDs_Sub_SubW.getAt(xzqhDs_Sub_SubW.find("id", regionCodeGW));
			regionCodeGW = rec.get("code");
			ds.baseParams["REG_QX_WOMAN@=@String"]= regionCodeGW;
		}
	}
	ds.baseParams["VALID_FLAG@="]="1";
	_dateTemp = (new Date()).valueOf();
	ds.load();
}

//追加重置命令，隐藏登记机关的二三级
function resetApply() {
	initPer();
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
	var certNumMan = selected[0].get('certNumMan');
	var certNumWoman = selected[0].get('certNumWoman');
	//showModelessDialog window
	window.open(
					"marry_details.jsp?method=DETAILS&dataBean=" + id + "&certNumMan=" + certNumMan + "&certNumWoman=" + certNumWoman,
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
	L5.dataset2excel(ds, "/jsp/cams/marry/exportMarryListExcel.jsp");
}

// 渲染业务类别
function ywlbRenderer(value, cellmeta, record, rowindex, colindex, dataset, a,
		b) {
	var tempDs = L5.DatasetMgr.lookup("ywlbDs");
	var a = tempDs.getTotalCount();

	for (var i = 0; i < tempDs.getTotalCount(); i++) {
		var rec = tempDs.getAt(i);
		if (rec.get("value") == value)
			return rec.get("text");
	}

	return "";
}

