var deptId = "";
function init() {
	// 根据登录人员获得婚姻登记处
	var infocommand = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
	infocommand.execute("getUserInfo");
	var userLoginName = "";
	var organCode = "";
	var organName = "";
	if (!infocommand.error) {
		var info = infocommand.getReturn("userInfo");
		userLoginName = info.userLoginName;// 通过登录账号查找对应的婚姻登记处。
		organCode = info.cantCode;// 通过登录账号查找对应的婚姻登记处。
		organName = info.userDepOrganName;
	}

	if (organType != 11) { // 非省级用户
		var mrmBasePersonCommand = new L5.Command("com.inspur.cams.marry.base.cmd.MrmBasePersonCommand");
		mrmBasePersonCommand.setParameter("loginId", userLoginName);
		mrmBasePersonCommand.execute("getDeptId");
		if (!mrmBasePersonCommand.error) {
			deptId = mrmBasePersonCommand.getReturn("deptId");
			deptName = mrmBasePersonCommand.getReturn("deptName");
		}

		if (deptId == "" || deptId == null) {
			alert("没有对应的婚姻登记处！");
			return false;
		}

		var excelDs = L5.DatasetMgr.lookup("excelDs");
		
		if (deptId.substring(4) == "0001") { // 市级事务处或者管理处
			ds.setParameter("substr(ORGAN_ID,1,4)", deptId.substring(0, 4));

			var excelDs = L5.DatasetMgr.lookup("excelDs");
			excelDs.setParameter("substr(ORGAN_ID,1,4)", deptId
							.substring(0, 4));
		} else {
			ds.setParameter("ORGAN_ID", deptId);
			var excelDs = L5.DatasetMgr.lookup("excelDs");
			excelDs.setParameter("ORGAN_ID", deptId);
		}

	}
	L5.DatasetMgr.lookup("ds").load();
	L5.QuickTips.init();
};

function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}
function query() {

	ds.setParameter("MRM_PYBZY.NAME@=", getParam("name"));
	// ds.setParameter("MRM_PYBZY.ZC@=",getParam("zc"));
	// ds.setParameter("MRM_PYBZY.HYZK@=",getParam("hyzk"));
	ds.setParameter("MRM_PYBZY.RYLY@=", getParam("ryly"));
	
	if(deptId != "") {
		if (deptId.substring(4) == "0001") { // 市级事务处或者管理处
			ds.setParameter("substr(ORGAN_ID,1,4)", deptId.substring(0, 4));

			excelDs.setParameter("substr(ORGAN_ID,1,4)", deptId.substring(0, 4));
		} else {
			ds.setParameter("ORGAN_ID", deptId);

			excelDs.setParameter("ORGAN_ID", deptId);
		}
	}

	excelDs.setParameter("MRM_PYBZY.NAME@=", getParam("name"));
	// excelDs.setParameter("MRM_PYBZY.ZC@=",getParam("zc"));
	// excelDs.setParameter("MRM_PYBZY.HYZK@=",getParam("hyzk"));
	excelDs.setParameter("MRM_PYBZY.RYLY@=", getParam("ryly"));

	ds.load();
}

function insert() {
/*	var data = new L5.Map();
	data.put("method", "INSERT");
	var url = 'jsp/cams/marry/mrmpybzy_edit.jsp';
	var text = '增加聘用颁证员';
	L5.forward(url, text, data);*/
	var url="mrmpybzy_edit.jsp?method=INSERT";
	var width = 1024;
	var height = 600;
    var re=window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if(re=="true"){
    	L5.Msg.alert('提示', "保存成功!");
			ds.reload();
    }

}

function update() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录修改!");
		return false;
	}
/*	var data = new L5.Map();
	data.put("method", "UPDATE");
	data.put("dataBean", selected[0].get('pybzyId'));
	var url = 'jsp/cams/marry/mrmpybzy_edit.jsp';
	var text = '修改聘用颁证员';
	L5.forward(url, text, data);*/
	var url="mrmpybzy_edit.jsp?method=UPDATE&dataBean="+selected[0].get('pybzyId');
	var width = 1024;
	var height = 340;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	
}

function del() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length < 1) {
		L5.Msg.alert('提示', "请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?', function(state) {
		if (state == "yes") {
			var delIds = [];
			for (var i = 0; i < selected.length; i++) {
				delIds[i] = selected[i].get("pybzyId");
			}
			var command = new L5.Command("com.inspur.cams.marry.base.cmd.MrmPybzyCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for (var i = 0; i < selected.length; i++) {
					ds.remove(selected[i]);
				}
				ds.commitChanges();
			} else {
				L5.Msg.alert('提示', "保存时出现错误！" + command.error);
			}
		} else {
			return false;
		}
	});
}

//链接明细
function detailHref(value,cellmeta,record,rowindex,colindex,dataset){
	return 	'<a href="javascript:detail(\''+record.get("pybzyId")+'\')">'+value+'</a>';
}

function detail(pybzyId){
	var url="mrmpybzy_detail.jsp?pybzyId="+pybzyId;
	var width = 1024;
	var height = 340;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}

// 打印
function commonExamapply() {
	var editGrid = L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert('提示', "请选择一条记录!");
		return false;
	}

	var personId = selected[0].get('pybzyId');
	document.getElementById("docpath").value = "jsp/cams/marry/words/mrmtybzy.doc";
	document.getElementById("pybzyId").value = personId;

	var url = "../comm/print/jspcommonprint.jsp?";
	var width = 1024;
	var height = 768;
	window.showModalDialog(url, window, "scroll:yes;status:no;dialogWidth:"
					+ width + "px;dialogHeight:" + height + "px;resizable:1");
	window.close();
}

/**
 * excel导出
 */
function emportExcel() {
	excelDs.load();
	excelDs.on("load", function() {
				L5.dataset2excel(excelDs,
						"/jsp/cams/marry/excel/mrmpyBzyExcel.jsp");
			});
}
