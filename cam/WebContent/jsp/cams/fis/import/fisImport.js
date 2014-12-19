function init() {
	var ds = L5.DatasetMgr.lookup("ds");
	if(userId.length == 10 && userId.substring(0,2)=='37' && userId.substring(6,8)=='99') {
		ds.setParameter("UNIT_ID@=@String", 'BZ'+userId.substring(0,6)+'-'+userId.substring(8,10));
	} else {
		ds.setParameter("UNIT_ID@rlike@String", "BZ"+ orgCode.substring(0, 6));
	}
	ds.on('load', function() {
			if (ds.getCount() == 1) {
				document.getElementById("qUnit").value = ds.getAt(0).get("unitId");
				document.getElementById("qUnitName").value = ds.getAt(0).get("unitName");
				document.getElementById("selectBtn").style.display='none';
			}
		});
	ds.load();
}

function addUploadFile() {
	L5.Msg.progress("加载数据", "进度条", "正在上传数据，请等待...");

	var qUnit = document.getElementById("qUnit").value;
	if (qUnit == undefined || qUnit == "") {
		L5.Msg.alert('提示', "请选择殡仪馆!");
		return false;
	}
	var upload_file = document.getElementById("upload_file").value;
	if (upload_file == undefined || upload_file == "") {
		L5.Msg.alert('提示', "请先上传文件!");
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.fis.base.cmd.FisImportDataCmd");
	var upload = new L5.Map();
	upload.put("uploadContent", upload_file);
	upload.put("unitId", qUnit);
	command.setParameter("record", upload);
	command.setForm("form_content_upload");
	command.execute("uploadSave");

	// 包含有大字段的异常判断
	command.afterExecute = function() {
		if (!command.error) {
			var result = command.getReturn("result");
			if (result == "OK")
				L5.Msg.alert("提示", "上传文件成功!");
			else
				L5.Msg.alert("提示", result);
		} else {
			L5.Msg.alert("提示", ('' + command.error).replace("出现系统异常", ""), {});
		}
	}
}

// 查询殡仪馆
function forOrganHelp(domId) {
	var revalue = window
			.showModalDialog(
					L5.webPath
							+ "/jsp/cams/fis/query/fisFuneralOrganTree.jsp?radioType=0&rootId="
							+ orgCode, "",
					"dialogHeight:768px;dialogWidth:512px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("qUnit").value = list[0];
		document.getElementById("qUnitName").value = list[1];
	}
}