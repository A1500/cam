//人员状态
var ryztDs = new L5.model.SimpleDataset({id:"ryztDs",
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
	ryztDs.loadData([['0','新增'],
		['1','有效'],
		['9','停用']],false);
		
	var ywlbDs = L5.DatasetMgr.lookup("ywlbDs");
	ywlbDs.setParameter("PID@=", "760");
	ywlbDs.load();
	
	var ryxzDs = L5.DatasetMgr.lookup("ryxzDs");
	ryxzDs.setParameter("PID@=", "860");
	ryxzDs.load();
	
	var djjgDs = L5.DatasetMgr.lookup("djjgDs");
	djjgDs.setParameter("DEPT_CODE@rlike@String", "37");
	djjgDs.load();

	// 添加表格行双击事件
	var editGridPanel = L5.getCmp('editGridPanel');
	editGridPanel.on("rowdblclick", queryDetails);

	// 联动初始化
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
	var cardNo = getParam("cardNo");
	var kind = getParam("kind");
	var validFlag = getParam("validFlag");
	
	var deptCode_C = L5.get("deptCode");
	var deptCodeSub_C = L5.get("deptCodeSub");
	var deptCodeSubSub_C = L5.get("deptCodeSubSub");
	var deptCode = deptCode_C.getValue();
	var deptCodeSub = deptCodeSub_C.getValue();
	var deptCodeSubSub = deptCodeSubSub_C.getValue();
	
	//判断是否存在查询条件
	var i = 0;
	if(name!="" && name!=undefined)	i++;
	if(cardNo!="" && cardNo!=undefined)	i++;
	if(kind!="" && kind!=undefined)	i++;
	if(validFlag!="" && validFlag!=undefined)	i++;
	if(deptCode!="" && deptCode!=undefined)	i++;
	
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
	
	if(cardNo!="" && cardNo!=undefined) {
		if(!validateSFZ.test(cardNo)) {
			alert("证件号码格式错误！");
			return false;
		}
	}
	
	ds.baseParams["NAME@=@String"]= undefined;
	ds.baseParams["CARD_NO@=@String"]= undefined;
	ds.baseParams["KIND@=@String"]= undefined;
	ds.baseParams["VALID_FLAG@=@String"]= undefined;
	ds.baseParams["DEPT_ID@rlike@String"]= undefined;
	
	ds.baseParams["NAME@=@String"]= name;
	ds.baseParams["CARD_NO@=@String"]= cardNo;
	ds.baseParams["KIND@=@String"]= kind;
	ds.baseParams["VALID_FLAG@=@String"]= validFlag;
	
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
		ds.baseParams["DEPT_ID@rlike@String"]= deptCodeG;
	}
	
	_dateTemp = (new Date()).valueOf();
	ds.load();
}

//追加重置命令，隐藏登记机关的二三级
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
	//showModelessDialog window
	window.open(
					"marry_person_details.jsp?method=DETAILS&dataBean=" + id,
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
	L5.dataset2excel(ds, "/jsp/cams/marry/exportMarryPersonExcel.jsp");
}

// 渲染登记机关
function djjgRenderer(value, cellmeta, record, rowindex, colindex, dataset, a,
		b) {
	var tempDs = L5.DatasetMgr.lookup("djjgDs");
	var a = tempDs.getTotalCount();

	for (var i = 0; i < tempDs.getTotalCount(); i++) {
		var rec = tempDs.getAt(i);
		if (rec.get("deptCode") == value)
			return rec.get("text");
	}

	return "";
}

// 渲染人员性质
function ryxzRenderer(value, cellmeta, record, rowindex, colindex, dataset, a,
		b) {
	var tempDs = L5.DatasetMgr.lookup("ryxzDs");
	var a = tempDs.getTotalCount();

	for (var i = 0; i < tempDs.getTotalCount(); i++) {
		var rec = tempDs.getAt(i);
		if (rec.get("value") == value)
			return rec.get("text");
	}

	return "";
}

// 渲染人员状态
function ryztRenderer(value, cellmeta, record, rowindex, colindex, dataset, a,
		b) {
	var a = ryztDs.getTotalCount();

	for (var i = 0; i < ryztDs.getTotalCount(); i++) {
		var rec = ryztDs.getAt(i);
		if (rec.get("value") == value)
			return rec.get("text");
	}

	return "";
}

// 渲染在线状态
function zxztRenderer(value, cellmeta, record, rowindex, colindex, dataset, a,
		b) {
	if(value == 9)
		return "<IMG style='VERTICAL-ALIGN: middle' alt='停用' src='image/huang.gif' width=16 height=16>";
	else
		return "<IMG style='VERTICAL-ALIGN: middle' alt='在线' src='image/lv.gif' width=16 height=16>";
}


