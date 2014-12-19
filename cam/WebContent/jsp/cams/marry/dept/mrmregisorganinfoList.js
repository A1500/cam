var ifAddHref = false; // 是否查询下一级
var addRegsionCode = organCode;
function init() {
	 if (addRegsionCode.substring(2,12) == "0000000000") { // 如是省级用户，则允许查询下一级
	    ifAddHref = true;
	  }
 
	//增加市本级校验 2012年3月7日 开始
	var infocommand = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
		infocommand.execute("getUserInfo");
		var userLoginName ="";
		var organCode ="";
		var organName ="";
		if (!infocommand.error) {
			var info = infocommand.getReturn("userInfo");
			  userLoginName =info.userLoginName;//通过登录账号查找对应的婚姻登记处。
			  organCode =info.cantCode;//通过登录账号查找对应的婚姻登记处。
			  organName =info.userDepOrganName;
			}
	var mrmBasePersonCommand = new L5.Command("com.inspur.cams.marry.base.cmd.MrmBasePersonCommand");
		mrmBasePersonCommand.setParameter("loginId",userLoginName);
		mrmBasePersonCommand.execute("getDeptId");
		if (!mrmBasePersonCommand.error) {
			 deptId = mrmBasePersonCommand.getReturn("deptId");
			 deptName= mrmBasePersonCommand.getReturn("deptName");
			}
		
	    if(organCode.substring(2,12) != "0000000000"){
				if(deptId=="" || deptId==null){
					//ds.newRecord();
					return false;
				}
			}
    //增加市本级校验 2012年3月7日 结束
	var ds = L5.DatasetMgr.lookup("ds"); 
	ds.setParameter("regionCode", addRegsionCode);
    if(organCode.substring(2,12) != "0000000000"){
      ds.setParameter("deptId", deptId);
	 }
	ds.load();
	L5.QuickTips.init();
}

function childRegsion(value, cellmeta, record) { // 登录名称机关添加链接（点击查询下一级）
	if (ifAddHref) { // 允许查询下一级
		var regsion = record.get("REGION_CODE");
		var functionStr = 'queryChildRegsion("' + regsion + '")';
		return "<a href='#' onclick='javascript:" + functionStr + "'>" + value
				+ "</a>";
	} else {
		return value;
	}
}

function queryChildRegsion(regsion) { // 查询下一级
	ifAddHref = false;
	addRegsionCode = regsion;
	var queryDs = L5.DatasetMgr.lookup("ds");
	queryDs.setParameter("regionCode", regsion);
	queryDs.load();
}

function detailRenderer(value, cellmeta, record) { // 代码链接到修改或者查看页面
	var keyId = record.get("ORGAN_ID");
	var regionCode = record.get("REGION_CODE");
	var regionName = record.get("REGION_NAME");
	var dept_code = record.get("DEPT_CODE");
	var name = record.get("NAME");
	var functionStr = 'detail("' + keyId + '","' + regionCode + '","'
			+ regionName + '","' + dept_code + '","' + name + '")';
	return "<a href='#' onclick='javascript:" + functionStr + "'>" + value
			+ "</a>";
}

function detail(keyId, regionCode, regionName, dept_code,name) {
	var data = new L5.Map();
	var text = "";
	var url = '';
	if (organCode.substring(2) != "0000000000"
			&& organCode.substring(4) == "00000000") { // 市级用户跳转查看页面
		data.put("dataBean", keyId);
		text = "查看登记机关信息";
		url = "jsp/cams/marry/dept/mrmregisorganinfo_detail.jsp";
		if(dept_code.substring(4) == "0001" || dept_code.substring(4)=="0099") { //市级管理跳转修改页面或者市级登记处
			data.put("organId", keyId);
			data.put("dept_code", dept_code);
			data.put("name",encodeURIComponent(encodeURIComponent(name)));
			data.put("method", "UPDATE");
			text = "修改登记机关信息";
			url = "jsp/cams/marry/dept/mrmregisorganinfo_edit.jsp";
		}
	} else { // 省级用户以及县级用户跳转修改页面
		data.put("organId", keyId);
		data.put("dept_code", dept_code);
		data.put("name",encodeURIComponent(encodeURIComponent(name)));
		data.put("method", "UPDATE");
		if (organCode.substring(2) == "0000000000") { // 省级用户
			if (ifAddHref) {
				data.put("regionCode", organCode);
			} else {
				data.put("regionCode", regionCode.substring(0, 4) + "00000000");
			}
		}

		if (regionName != null && regionName != "") {
			data.put("regionName",
					encodeURIComponent(encodeURIComponent(regionName)));
		} else {
			data.put("regionName", "");
		}
		text = "修改登记机关信息";
		url = "jsp/cams/marry/dept/mrmregisorganinfo_edit.jsp";
	}
	L5.forward(url, text, data);

}

function insert() {
	var data = new L5.Map();
	data.put("method", "INSERT");
	data.put("regionCode", addRegsionCode);
	text = "修改登记机关信息";
	url = "jsp/cams/marry/dept/mrmregisorganinfo_edit.jsp";
	L5.forward(url, text, data);
}

function stopUser() {
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录停用!");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoCommand"); 
	selected[0].set("VALID_FLAG","0");
	command.setParameter("record",selected[0]);
	command.execute("updateValid");
	if (!command.error) {
		L5.Msg.alert('提示',"停用成功!");
		
	}else{
		L5.Msg.alert('提示',"停用失败！"+command.error);
	}
}

/**
 * 登记机关打印
 * @return {Boolean}
 */
function print() {
	var editGrid = L5.getCmp("editGridPanel");
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert("提示", "请选择一条记录");
		return false;
	}

	var record = selected[0];
	var regsionCode = record.get("DEPT_CODE");

	var docPath = "";
	document.getElementById("organId").value = record.get("ORGAN_ID");
	if (regsionCode.substring(4) == "0001") { // 事务处
		docPath = "jsp/cams/marry/dept/print/mrmRegisOrganProvince.doc";
	} else {
		docPath = "jsp/cams/marry/dept/print/mrmRegisOrgan.doc";
	}

	document.getElementById("docpath").value = docPath;
	var url = "../../comm/print/jspcommonprint.jsp";
	var text = '登记机关打印';
	var width = 1024;
	var height = 768;
	window.showModalDialog(url, window, "scroll:yes;status:no;dialogWidth:"
					+ width + "px;dialogHeight:" + height + "px;resizable:1");
}
//等级评定申报查看
function djsb() {
	//提取列表中得到登记机关代码的值
		var editGrid = L5.getCmp("editGridPanel");
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert("提示", "请选择一条记录");
		return false;
	}
	var record = selected[0];
	var regsionCode = record.get("DEPT_CODE");
	var data=new L5.Map();

	data.put("deptId",regsionCode);
	var url='jsp/cams/marry/dept/level/mrm_level_applyst.jsp';
	
	L5.forward(url,'',data);
	};
/**
 * 导出excel
 */
function emport() {
	var excelDs = L5.DatasetMgr.lookup("excelDs");
	excelDs.setParameter("regionCode",addRegsionCode);
	excelDs.load();
	excelDs.on("load",function() {
		L5.dataset2excel(excelDs,"/jsp/cams/marry/dept/excel/mrmRegisOrganEmportExcel.jsp");
	});
}
