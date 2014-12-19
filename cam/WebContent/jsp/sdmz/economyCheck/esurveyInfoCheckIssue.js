
//家庭信息
var declareFamilyInfoDataset = new L5.model.SimpleDataset({id:"declareFamilyInfoDataset",
	fields: ['jtid','hzxm','sfzh','jtrksl','jtxz','jzlx','hjxzqh']});
	
//成员信息
var declareFamilyMemberInfoDataset = new L5.model.SimpleDataset({id:"declareFamilyMemberInfoDataset",
	fields: ['jtid','hzxm','cyxm','hzgx', 'deptRlText', 'deptRl', 'deptFgText', 'deptFg', 'deptGsText', 'deptGs', 'deptGaText', 
	'deptGa', 'deptGshText', 'deptGsh', 'deptDsText', 'deptDs', 'deptGjjText', 'deptGjj', 'deptRmyhText', 'deptRmyh', 
	'deptZjText', 'deptZj', 'deptBjText', 'deptBj']});
	
//人力字典表
var dicRlDs = new L5.model.SimpleDataset({id:"dicRlDs",
	fields: ['value','text']});	
//房管字典表
var dicFgDs = new L5.model.SimpleDataset({id:"dicFgDs",
	fields: ['value','text']});	
//工商字典表
var dicGsDs = new L5.model.SimpleDataset({id:"dicGsDs",
	fields: ['value','text']});	
//公安字典表
var dicGaDs = new L5.model.SimpleDataset({id:"dicGaDs",
	fields: ['value','text']});	
//国税字典表
var dicGshDs = new L5.model.SimpleDataset({id:"dicGshDs",
	fields: ['value','text']});	
//地税字典表
var dicDsDs = new L5.model.SimpleDataset({id:"dicDsDs",
	fields: ['value','text']});	
//公积金字典表
var dicGjjDs = new L5.model.SimpleDataset({id:"dicGjjDs",
	fields: ['value','text']});	
//人民银行字典表
var dicRmyhDs = new L5.model.SimpleDataset({id:"dicRmyhDs",
	fields: ['value','text']});	
//证监字典表
var dicZjDs = new L5.model.SimpleDataset({id:"dicZjDs",
	fields: ['value','text']});	
//保监字典表
var dicBjDs = new L5.model.SimpleDataset({id:"dicBjDs",
	fields: ['value','text']});
	
function init() {
	loadData();
			
	var arr = jtids.split("|");
	var _familyData = [];
	var _memberData = [];
	
	for(var i = 0; i < arr.length; i++) {
		var strTemp = arr[i];
		if(strTemp == '00001') {
			_familyData.push(['00001','户主','370111196709011293', '2', '农村', '五保户', '济南市高新区']);
			
			_memberData.push(['00001','户主','户主', '户主', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '']);
			_memberData.push(['00001','户主','成员A', '妻子', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '']);
		}else if(strTemp == '00002') {
			_familyData.push(['00002','户主2','370111194709011533', '3', '农村', '五保户', '济南市高新区']);
			
			_memberData.push(['00002','户主2','户主2', '户主', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '']);
			_memberData.push(['00002','户主2','成员BB', '妻子', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '']);
			_memberData.push(['00002','户主2','成员CC', '儿女', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '']);
		}else if(strTemp == '00003') {
			_familyData.push(['00003','户主3','370111196419011258', '1', '农村', '五保户', '济南市高新区']);
			
			_memberData.push(['00003','户主3','户主3', '户主', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '']);
		}
	}
	
	declareFamilyInfoDataset.loadData(_familyData,false);
	declareFamilyMemberInfoDataset.loadData(_memberData, false);	
	
	var sbjtxxGridPanel = L5.getCmp("sbjtxxGridPanel");
	sbjtxxGridPanel.on("rowclick", onSbjtxxGridPanel);
	
	//当双击家庭信息时，在右侧显示其成员
	function onSbjtxxGridPanel(g, rowIdx, r) {
		var jtcyxxGridPanel = L5.getCmp('jtcyxxGridPanel');
		var view = jtcyxxGridPanel.getView();

		var fds = L5.DatasetMgr.lookup("declareFamilyInfoDataset");
		var fRec = fds.getAt(rowIdx);
		var jtid = fRec.get("jtid");
		
		var mds = L5.DatasetMgr.lookup("declareFamilyMemberInfoDataset");
		
		for(var i=0; i < mds.getTotalCount(); i++) {
			var cell = view.getCell(i, 0);
			var rec = mds.getAt(i);
			if(rec.get("jtid") == jtid) {
				cell.innerHTML = '<DIV style="color:red;bgColor:#cccccc;" title="" unselectable="on">' + cell.innerText + '</DIV>';
			}else {
				cell.innerHTML = '<DIV class="l-grid3-cell-inner l-grid3-col-numberer" title="" unselectable="on">' + cell.innerText + '</DIV>';
			}
		}
		/**/
		var jtxxDetails = document.getElementById("jtxxDetails");
		jtxxDetails.innerHTML = "户主姓名：" + fRec.get("hzxm") + 
			"<br>身份证号码：" + fRec.get("sfzh") + 
			"<br>家庭性质：" + fRec.get("jtxz") + 
			"<br>救助类型：" + fRec.get("jzlx") + 
			"<br>户籍行政区划：" + fRec.get("hjxzqh");
		
	}
}

//查看详细信息
function details() {
	var grid=L5.getCmp('sbjtxxGridPanel');
	var cell=grid.getSelectionModel().getSelections();
	if(cell.length!=1){
		L5.Msg.alert("提示","请选择一条记录查看!");
		return false;
	}
	
	L5.Msg.alert("提示","你选择的家庭ID是" + cell[0].get("jtid"));
}

//进行核对分发
function checkIssue() {
	L5.MessageBox.confirm('确认','确定要进行核对分发？',
		function(sta){
			if(sta=="yes"){
				var mainPanel = L5.getCmp("mainPanel");
				mainPanel.hide();
				
				var subPanel = L5.getCmp("subPanel");
				subPanel.show();
				
				L5.Msg.alert('提示','家庭成员核对信息已存储！');
			}
		});
}

//返回至查询页面
function returnQuery() { 
	var url='jsp/sdmz/economyCheck/esurveyInfoCheckIssueQuery.jsp';
	var text = '查询家庭信息';
	L5.forward(url,text);
}


/**
 * 核对单位选择
 */
//核对单位选择 人力资源和社会保障
var onSelect_dept_rl = function(e) {
	forItemHelp_dept_rl(e);
}
function forItemHelp_dept_rl(ele) {
	var multi = L5.getCmp("help_select_rl");
	multi.show(ele.target);
	multi.afterExecute = function() {
		if (!multi.getReturn().json) {
			//点清除的时候
			alert(ele.target.id);
		}
		setItemValue_dept_rl(multi.getReturn());
	}
}
function setItemValue_dept_rl(record) {
	var declareFamilyMemberInfoDataset = L5.DatasetMgr.lookup("declareFamilyMemberInfoDataset");
	var target=declareFamilyMemberInfoDataset.getCurrent();
	target.set("deptRlText",record.get('text'));
	target.set("deptRl",record.get('value'));
}

//核对单位选择 房管
var onSelect_dept_fg = function(e) {
	forItemHelp_dept_fg(e);
}
function forItemHelp_dept_fg(ele) {
	var multi = L5.getCmp("help_select_fg");
	multi.show(ele.target);
	multi.afterExecute = function() {
		if (!multi.getReturn().json) {
			//点清除的时候
			alert(ele.target.id);
		}
		setItemValue_dept_fg(multi.getReturn());
	}
}
function setItemValue_dept_fg(record) {
	var declareFamilyMemberInfoDataset = L5.DatasetMgr.lookup("declareFamilyMemberInfoDataset");
	var target=declareFamilyMemberInfoDataset.getCurrent();
	target.set("deptFgText",record.get('text'));
	target.set("deptFg",record.get('value'));
}

//核对单位选择 工商
var onSelect_dept_gs = function(e) {
	forItemHelp_dept_gs(e);
}
function forItemHelp_dept_gs(ele) {
	var multi = L5.getCmp("help_select_gs");
	multi.show(ele.target);
	multi.afterExecute = function() {
		if (!multi.getReturn().json) {
			//点清除的时候
			alert(ele.target.id);
		}
		setItemValue_dept_gs(multi.getReturn());
	}
}
function setItemValue_dept_gs(record) {
	var declareFamilyMemberInfoDataset = L5.DatasetMgr.lookup("declareFamilyMemberInfoDataset");
	var target=declareFamilyMemberInfoDataset.getCurrent();
	target.set("deptGsText",record.get('text'));
	target.set("deptGs",record.get('value'));
}

//核对单位选择 公安(车管)
var onSelect_dept_ga = function(e) {
	forItemHelp_dept_ga(e);
}
function forItemHelp_dept_ga(ele) {
	var multi = L5.getCmp("help_select_ga");
	multi.show(ele.target);
	multi.afterExecute = function() {
		if (!multi.getReturn().json) {
			//点清除的时候
			alert(ele.target.id);
		}
		setItemValue_dept_ga(multi.getReturn());
	}
}
function setItemValue_dept_ga(record) {
	var declareFamilyMemberInfoDataset = L5.DatasetMgr.lookup("declareFamilyMemberInfoDataset");
	var target=declareFamilyMemberInfoDataset.getCurrent();
	target.set("deptGaText",record.get('text'));
	target.set("deptGa",record.get('value'));
}

//核对单位选择 国税
var onSelect_dept_gsh = function(e) {
	forItemHelp_dept_gsh(e);
}
function forItemHelp_dept_gsh(ele) {
	var multi = L5.getCmp("help_select_gsh");
	multi.show(ele.target);
	multi.afterExecute = function() {
		if (!multi.getReturn().json) {
			//点清除的时候
			alert(ele.target.id);
		}
		setItemValue_dept_gsh(multi.getReturn());
	}
}
function setItemValue_dept_gsh(record) {
	var declareFamilyMemberInfoDataset = L5.DatasetMgr.lookup("declareFamilyMemberInfoDataset");
	var target=declareFamilyMemberInfoDataset.getCurrent();
	target.set("deptGshText",record.get('text'));
	target.set("deptGsh",record.get('value'));
}

//核对单位选择 地税
var onSelect_dept_ds = function(e) {
	forItemHelp_dept_ds(e);
}
function forItemHelp_dept_ds(ele) {
	var multi = L5.getCmp("help_select_ds");
	multi.show(ele.target);
	multi.afterExecute = function() {
		if (!multi.getReturn().json) {
			//点清除的时候
			alert(ele.target.id);
		}
		setItemValue_dept_ds(multi.getReturn());
	}
}
function setItemValue_dept_ds(record) {
	var declareFamilyMemberInfoDataset = L5.DatasetMgr.lookup("declareFamilyMemberInfoDataset");
	var target=declareFamilyMemberInfoDataset.getCurrent();
	target.set("deptDsText",record.get('text'));
	target.set("deptDs",record.get('value'));
}

//核对单位选择 公积金
var onSelect_dept_gjj = function(e) {
	forItemHelp_dept_gjj(e);
}
function forItemHelp_dept_gjj(ele) {
	var multi = L5.getCmp("help_select_gjj");
	multi.show(ele.target);
	multi.afterExecute = function() {
		if (!multi.getReturn().json) {
			//点清除的时候
			alert(ele.target.id);
		}
		setItemValue_dept_gjj(multi.getReturn());
	}
}
function setItemValue_dept_gjj(record) {
	var declareFamilyMemberInfoDataset = L5.DatasetMgr.lookup("declareFamilyMemberInfoDataset");
	var target=declareFamilyMemberInfoDataset.getCurrent();
	target.set("deptGjjText",record.get('text'));
	target.set("deptGjj",record.get('value'));
}

//核对单位选择 人民银行
var onSelect_dept_rmyh = function(e) {
	forItemHelp_dept_rmyh(e);
}
function forItemHelp_dept_rmyh(ele) {
	var multi = L5.getCmp("help_select_rmyh");
	multi.show(ele.target);
	multi.afterExecute = function() {
		if (!multi.getReturn().json) {
			//点清除的时候
			alert(ele.target.id);
		}
		setItemValue_dept_rmyh(multi.getReturn());
	}
}
function setItemValue_dept_rmyh(record) {
	var declareFamilyMemberInfoDataset = L5.DatasetMgr.lookup("declareFamilyMemberInfoDataset");
	var target=declareFamilyMemberInfoDataset.getCurrent();
	target.set("deptRmyhText",record.get('text'));
	target.set("deptRmyh",record.get('value'));
}

//核对单位选择 证监
var onSelect_dept_zj = function(e) {
	forItemHelp_dept_zj(e);
}
function forItemHelp_dept_zj(ele) {
	var multi = L5.getCmp("help_select_zj");
	multi.show(ele.target);
	multi.afterExecute = function() {
		if (!multi.getReturn().json) {
			//点清除的时候
			alert(ele.target.id);
		}
		setItemValue_dept_zj(multi.getReturn());
	}
}
function setItemValue_dept_zj(record) {
	var declareFamilyMemberInfoDataset = L5.DatasetMgr.lookup("declareFamilyMemberInfoDataset");
	var target=declareFamilyMemberInfoDataset.getCurrent();
	target.set("deptZjText",record.get('text'));
	target.set("deptZj",record.get('value'));
}

//核对单位选择 保监
var onSelect_dept_bj = function(e) {
	forItemHelp_dept_bj(e);
}
function forItemHelp_dept_bj(ele) {
	var multi = L5.getCmp("help_select_bj");
	multi.show(ele.target);
	multi.afterExecute = function() {
		if (!multi.getReturn().json) {
			//点清除的时候
			alert(ele.target.id);
		}
		setItemValue_dept_bj(multi.getReturn());
	}
}
function setItemValue_dept_bj(record) {
	var declareFamilyMemberInfoDataset = L5.DatasetMgr.lookup("declareFamilyMemberInfoDataset");
	var target=declareFamilyMemberInfoDataset.getCurrent();
	target.set("deptBjText",record.get('text'));
	target.set("deptBj",record.get('value'));
}


function loadData() {
	dicRlDs.loadData([
			['37010100','济南市人力资源'],
			['37010101','市中区人力资源'],
			['37010102','历城区人力资源'],
			['37010103','历下区人力资源'],
			['37010104','高新区人力资源']],false);	
	dicFgDs.loadData([
			['37010200','济南市房管'],
			['37010201','市中区房管'],
			['37010202','历城区房管'],
			['37010203','历下区房管'],
			['37010204','高新区房管']],false);	
	dicGsDs.loadData([
			['37010300','济南市工商'],
			['37010301','市中区工商'],
			['37010302','历城区工商'],
			['37010303','历下区工商'],
			['37010304','高新区工商']],false);	
	dicGaDs.loadData([
			['37010400','济南市公安(车管)'],
			['37010401','市中区公安(车管)'],
			['37010402','历城区公安(车管)'],
			['37010403','历下区公安(车管)'],
			['37010404','高新区公安(车管)']],false);	
	dicGshDs.loadData([
			['37010500','济南市国税'],
			['37010501','市中区国税'],
			['37010502','历城区国税'],
			['37010503','历下区国税'],
			['37010504','高新区国税']],false);	
	dicDsDs.loadData([
			['37010600','济南市地税'],
			['37010601','市中区地税'],
			['37010602','历城区地税'],
			['37010603','历下区地税'],
			['37010604','高新区地税']],false);	
	dicGjjDs.loadData([
			['37010700','济南市公积金'],
			['37010701','市中区公积金'],
			['37010702','历城区公积金'],
			['37010703','历下区公积金'],
			['37010704','高新区公积金']],false);	
	dicRmyhDs.loadData([
			['37010800','济南市人民银行'],
			['37010801','市中区人民银行'],
			['37010802','历城区人民银行'],
			['37010803','历下区人民银行'],
			['37010804','高新区人民银行']],false);	
	dicZjDs.loadData([
			['37010900','济南市证监'],
			['37010901','市中区证监'],
			['37010902','历城区证监'],
			['37010903','历下区证监'],
			['37010904','高新区证监']],false);	
	dicBjDs.loadData([
			['37011000','济南市保监'],
			['37011001','市中区保监'],
			['37011002','历城区保监'],
			['37011003','历下区保监'],
			['37011004','高新区保监']],false);
}