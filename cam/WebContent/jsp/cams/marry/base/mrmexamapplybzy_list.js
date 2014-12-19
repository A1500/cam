function init() {
	var ndYearDataset = L5.DatasetMgr.lookup("ndYearDataset");
	ndYearDataset.baseParams["filterSql"]=" ks_sign = '1'  and ks_yn = '01'";//1:颁证员
	ndYearDataset.load();

	L5.QuickTips.init();
}
//根据状态显示不同的颜色
function colorshow(value){
	if(value == "") {
		return value;
	} else if(value == '应考人员') {
		return "<font color='red'>"+value+"</font>";
	}else if(value == '选考人员') {
		return "<font color='yellow'>"+value+"</font>";
	}else if(value == '已报名') {
		return "<font color='black '>"+value+"</font>";
	}
}
function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
function query() {
	var ndYear=document.getElementById("ndYear").value;
	if(!ndYear){
		L5.Msg.alert('提示', "请输入年份!");
		return false;
	}
	

	var apds = L5.DatasetMgr.lookup("apds");
	apds.baseParams["ND_YEAR"] = ndYear;
	apds.baseParams["KS_SIGN"] = "1";
	apds.baseParams["KS_YN"] = "01";
//	apds.load();
	apds.on('load',function(){
		var records = apds.getAllRecords();
		if(apds.getCurrent()){
			var innerString = "";
			for(var i = 0; i<records.length; i++){
				innerString+=(records[i].get("ksqs")+"期："+records[i].get("ksAdd")+"  ");
			}
			document.getElementById("ksqs1").innerHTML=innerString;
		}
		
	});
	apds.load();
	
	
	var ksqsDataset = L5.DatasetMgr.lookup("ksqsDataset");
	ksqsDataset.setParameter('filterSql', " ND_YEAR = '" + ndYear + "' and KS_SIGN = '1'  and ks_yn = '01'");
//	ksqsDataset.load();
	ksTimeDataset.setParameter('filterSql', " ND_YEAR = '" + ndYear + "' and KS_SIGN = '1'  and ks_yn = '01'");
	ksTimeDataset.load();
	
	var infocommand = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
	infocommand.execute("getUserInfo");
	var userLoginId = "";
	if (!infocommand.error) {
		var info = infocommand.getReturn("userInfo");
		userLoginId = info.userLoginName;// 通过登录账号查找对应的婚姻登记处。
	}
	var commDeptId = new L5.Command("com.inspur.cams.marry.base.cmd.MrmBasePersonCommand");
	commDeptId.setParameter("loginId", userLoginId);
	commDeptId.execute("getDeptId");
	var deptId = commDeptId.getReturn("deptId");
	var Personds=L5.DatasetMgr.lookup("Personds");
	Personds.setParameter("year",ndYear);
	Personds.setParameter("deptId",deptId);
	Personds.setParameter("bzyCode","02");//颁证员
	Personds.load();
	//判断颁证员的状态
//	var nowDate = new Date();
//	var nowYear = nowDate.getYear(); // 获取当前年份
	Personds.on("load",function(){
		var records = Personds.getAllRecords();
		for(var i=0;i<records.length;i++){
			if(records[i].get("GIVE") == '1'){
				if(records[i].get("KSQS") != null && records[i].get("KSQS") != ''){
					records[i].set("GIVE_OUT_TIME","已报名");
				}else{
					records[i].set("GIVE_OUT_TIME","应考人员");
				}
			}else{
				if(records[i].get("KSQS") != null && records[i].get("KSQS") != ''){
					records[i].set("GIVE_OUT_TIME","已报名");
				}else{
					records[i].set("GIVE_OUT_TIME","选考人员");
				}
			}
		}
	}); 
}
function insert() {
	var ndYear=document.getElementById("ndYear").value;
	if(!ndYear){
		L5.Msg.alert('提示', "请输入年份!");
		return false;
	}
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert('提示', "请选择报名人员!");
		return false;
	}
	var applyString = '';
	for (var i = 0; i < selected.length; i++) {
		var ksqs = selected[i].get("KSQS");
		if (ksqs == '' || ksqs == undefined) {
			L5.Msg.alert('提示', "请选择考试期数!");
			return false;
		}else if(selected[i].get("GIVE_OUT_TIME") == '已报名'){
			L5.Msg.alert('提示', "【"+selected[i].get("NAME")+"】已报名!");
			return false;
		}else if(selected[i].get("GIVE_OUT_TIME") == '未到期'){
			applyString += '【'+selected[i].get("NAME")+'】未到期,';
		}
	}
	
	L5.MessageBox.confirm('确定', applyString+'确定要报名吗?', function(state) {
		if (state == "yes") {
			var personId = [];
			var organId = [];
			var ksapId = [];
			var ksqs = [];
			var name = [];
			for (var i = 0; i < selected.length; i++) {
				personId[i] = selected[i].get("PERSON_ID");
				organId[i] = selected[i].get("DEPT_ID");
				ksqs[i] = selected[i].get("KSQS");
				name[i] = selected[i].get("NAME");
			}
			var command = new L5.Command("com.inspur.cams.marry.base.cmd.MrmExamScheduleCommand");
			command.setParameter("personId", personId);
			command.setParameter("ksqs", ksqs);
			command.setParameter("organId", organId);
			command.setParameter("name", name);
			command.setParameter("ndYear", ndYear);
			command.setParameter("ksSign","1");//颁证员
			command.execute("mrmexamapply");
			if (command.getReturn("name") != ''
					&& command.getReturn("name") != undefined) {
				L5.Msg.alert('提示', "报名失败！【" + command.getReturn("name")
								+ "】已报名，无需再次报名！");
				return false;
			}
			
			if (command.getReturn("qstj") != ''
					&& command.getReturn("qstj") != undefined) {
				L5.Msg.alert('提示', "报名失败！【" + command.getReturn("qstj")
								+ "】 报名已关闭！");
				return false;
			}
			
			if(command.getReturn("bmadd") != '' 
				&& command.getReturn("bmadd") != undefined){
				L5.Msg.alert('提示','报名失败！计划报名'+command.getReturn("bmadd")+' ');
				return false;
			}
			
			if (!command.error) {
				L5.Msg.alert('提示', "报名成功！");
				L5.forward("jsp/cams/marry/base/mrmexamapplybzy_list.jsp");
			} else {
				L5.Msg.alert('提示', "报名失败！" + command.error);
			}
		} else {
			return false;
		}
	});
}
function backTime(value, cellmeta, record, rowindex, colindex, dataset) {
	if (record.get("KSQS")) {
		record.set("KSSJ_TIME", record.get("KSQS"));
		var records = ksTimeDataset.query("value", record.get("KSQS"));
		if(records.items[0]){
			return records.items[0].get("text");
		}else{
			return "";
		}
	} else
		return "";
}
/**
 * 上传
 */
function operation(value) {
	var func = 'javascript:uploadById("' + value + '")';
	var str = "<a href='" + func + "'>" + '上传' + "</a>";
	return str;
}

function uploadById(id) {
	document.getElementById("updatefileId").value = id;
	var s = L5.getCmp('addNewDemobilizedGrantObject');
	s.show();
}

function upload() {
	var filename = document.getElementById("filename").value;
	if (filename == null || filename == "") {
		L5.Msg.alert("提示", "请选择上传的文件");
		return false;
	}
	var lastIndex = filename.lastIndexOf(".");
	var suffFileName = filename.substring(lastIndex + 1);// 取得模板后缀名
	if (suffFileName != "doc" && suffFileName != "docx") {
		L5.Msg.alert("提示", "上传文件格式不正确");
		return false;
	}

	var command = new L5.Command("com.inspur.cams.marry.base.cmd.MrmBasePersonCommand");
	command.setParameter("suffFileName", suffFileName);
	command.setParameter("personId",
			document.getElementById("updatefileId").value);
	command.setForm("form_content");
	command.execute("saveUpload");

	command.afterExecute = function() {
		if (!command.error) {
			L5.Msg.alert('提示', "数据保存成功!");
			L5.getCmp('addNewDemobilizedGrantObject').hide();
			init();
		} else {
			L5.Msg.alert('提示', command.error);
		}
	}
}

function cert_click(value, cellmeta, record) {
	var path = record.get("FILE_PATH");
	// var isdefault = record.get("isDefault");
	var func = 'javascript:downloadFile("' + path + '","' + value + '")';
	var str = "<a href='" + func + "'>" + value + "</a>";
	return str;
}

function downloadFile(path, filename) {
	var command = new L5.Command("com.inspur.cams.marry.base.cmd.MrmBasePersonCommand");
	command.setParameter("filePath", path);
	command.execute("ifexeit");
	var exist = command.getReturn("exist");
	if (exist) {
		filename = escape(encodeURIComponent(filename));
		window.location = L5.webPath + "/fileDownload?filePath=" + path
				+ "&fileName=" + filename;
	} else {
		L5.Msg.alert("提示", "文件不存在！");
	}
}

// 打印
function commonExamapply() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert('提示', "请选择要打印的记录!");
		return false;
	}
	if(selected[0].get('KSQS') == ''){
		L5.Msg.alert("提示","该登记员未报名");
		return false;
	}

	var personId = selected[0].get('PERSON_ID');
	document.getElementById("docpath").value = "jsp/cams/marry/words/mrmexamapplybzy.doc";
	document.getElementById("personId").value = personId;
	document.getElementById("ksqs").value = selected[0].get('KSQS');
	document.getElementById("ndyearstring").value = document.getElementById('ndYear').value;
	document.getElementById("ksSign").value = "1";

	var url = "../../comm/print/jspcommonprint.jsp?";
	var width = 1024;
	var height = 768;
	window.showModalDialog(url, window, "scroll:yes;status:no;dialogWidth:"
					+ width + "px;dialogHeight:" + height + "px;resizable:1");
	window.close();
}