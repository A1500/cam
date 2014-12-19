function query(){
	var fisOrganReportDs = L5.DatasetMgr.lookup("fisOrganReportDs");
	var qParentOrganCode = document.getElementById("qParentOrganCode").value;
	var queryUnitName = document.getElementById("queryUnitName").value;
	if(qParentOrganCode!=""&&qParentOrganCode!="370000000000"){
		fisOrganReportDs.setParameter("organCode",qParentOrganCode);
	}
	if(queryUnitName!=""){
		fisOrganReportDs.setParameter("fName",queryUnitName);
	}
	fisOrganReportDs.load();
	
}
function resetQuery(){
	document.getElementById("qParentOrganCode").value = "";
	document.getElementById("qParentOrganName").value = "";
	document.getElementById("queryUnitName").value = "";
}

function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("fisOrganReportDs");
	if(dataset.getCount()<=0){
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}
	var queryCondition ="";
	var qParentOrganName = document.getElementById("qParentOrganName").value;
	if(qParentOrganName!=""){
		queryCondition=qParentOrganName.substring(0,qParentOrganName.length-3)
	}
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
	L5.dataset2excel(dataset,"/jsp/cams/fis/base/fisOrganReportExcel.jsp?queryCondition="+queryCondition);
	dataset.baseParams["excelType"]="reset"; //重置导出类型s
}

//选择管辖单位-无Ds赋值
function selectOrganNoDs(flag) {
	var userInfo;
	var command = new L5.Command("com.inspur.cams.fis.util.InformSessionCmd");
	command.execute("getUserInfo");
	if (!command.error) {
		userInfo = command.getReturn("userInfo");
	} else {
		alert("用户没有登录！");
		return;
	}

	var cantCode = userInfo.cantCode;
	var cantName = userInfo.cantName;
	var cantType = userInfo.userDepOrganType;

	var url = L5.webPath + "/jsp/cams/fis/comm/approvalOrganTree.jsp?cantCode="
			+ cantCode + "&cantName=" + escape(encodeURIComponent(cantName))
			+ "&cantType=" + cantType;
	var win = showModalDialog(url, null,
			"scroll:no;status:no;dialogWidth:500px;dialogHeight:550px");
	if (win == null) {
		return;
	}

	var id = "";
	var name = "";
	var id_name = "";

	// 如果是点击的是【确定】
	if (win[0].length > 0) {

		// 第一个值前面没有逗号
		id = win[0][0];// id1,id2,id3......
		name = win[1][0];// name1,name2,name3......
		id_name = id + "[" + name + "]";// id1[name1],id2[name2],id3[name3].......

		// 其余值之间用逗号分隔
		if (win[0].length > 1) {
			for (var i = 1; i < win[0].length; i++) {
				id = id + "," + win[0][i];
				name = name + "," + win[1][i];
				id_name = id_name + "," + win[0][i] + "[" + win[1][i] + "]";
			}
		}
	}
	document.getElementById("qParentOrganName").value = name;
	document.getElementById("qParentOrganCode").value = id;
}