function init(){
	var EsureyFamilyDS=L5.DatasetMgr.lookup("EsureyFamilyDS");
	if(organArea.substring(4,12)=="00000000")
	{	
		var organArea1=organArea.substring(0,4);
		EsureyFamilyDS.setParameter("familyAddress",organArea);		
		
	}else if(organArea.substring(6,12)=="000000")
	{
		 var organArea1=organArea.substring(0,6);
		 EsureyFamilyDS.setParameter("familyAddress",organArea);
	}
	else{
		L5.Msg.alert("提示","你的权限不够！");
		return;
	}
	EsureyFamilyDS.load();
}
function forHelp(domId){
       var revalue=window.showModalDialog("../../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=1&organType=11,12,13&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
       if(revalue!=""&&revalue!=undefined){
          var list = revalue.split(";");
          document.getElementById(domId).value = list[1];
          document.getElementById(domId+"h").value = list[0];
       }     
}
//查询
function query(){
	var name=_$("qName");
	var idCard=_$("qIdCard");
	var familyAddress=_$("qAreah");
	var assistanceType=_$("qAssistance");
	var domicleType=_$("qDomicleType");
	var rading=_$("qRading");
	var dateBegin=_$("qDateBegin");
	var dateEnd=_$("qDateEnd");
	var EsureyFamilyDS=L5.DatasetMgr.lookup("EsureyFamilyDS");
	EsureyFamilyDS.setParameter("familyName",name);
	EsureyFamilyDS.setParameter("familyCardNo",idCard);
	EsureyFamilyDS.setParameter("familyAddress",familyAddress);	
	EsureyFamilyDS.setParameter("assistanceType",assistanceType);
	EsureyFamilyDS.setParameter("domicileType",domicleType);
	EsureyFamilyDS.setParameter("creditRating",rading);
	EsureyFamilyDS.setParameter("checkTimeBegin",dateBegin);
	EsureyFamilyDS.setParameter("checkTimeEnd",dateEnd);
	EsureyFamilyDS.setParameter("organArea",organArea);
	EsureyFamilyDS.load();	
}
/**
*详情
*/
function detail_esurey(){
	var grid=L5.getCmp("esurey_Grid");
	var selected = grid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.MessageBox.alert("提示",'请选择要查看的记录');
		return false;
	}
	var familyId=selected[0].get("FAMILY_ID");
	var data=new L5.Map();
	data.put("familyId",familyId);
	data.put("method","query");
	var text="查看困难家庭信息";
	var url="jsp/cams/drel/esurey/internal/esureyInfoDetail.jsp";
	L5.forward(url,text,data);
}
/**
*核对详情
*/
function check_detail(){
	var grid=L5.getCmp("esurey_Grid");
	var selected = grid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.MessageBox.alert("提示",'请选择要查看的记录');
		return false;
	}
	var familyId=selected[0].get("FAMILY_ID");
	var data=new L5.Map();
	data.put("familyId",familyId);
	var text="查看困难家庭成员核对信息";
	var url="jsp/cams/drel/esurey/internal/esureyInfoQueryFamily.jsp";
	L5.forward(url,text,data);
}

//打印
function forExcel() {
	var EsureyFamilyDS=L5.DatasetMgr.lookup("EsureyFamilyDS");
	if(EsureyFamilyDS.getCount() <= 0) {
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}
	var pageSize = EsureyFamilyDS.pageInfo.pageSize;
	var pageIndex = EsureyFamilyDS.pageInfo.pageIndex;
	var startCursor = EsureyFamilyDS.pageInfo.startCursor;
	EsureyFamilyDS.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	EsureyFamilyDS.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
//	dataset.baseParams["limitExcel"]=dataset.getTotalCount();
	EsureyFamilyDS.baseParams["limitExcel"]=pageSize;  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
	L5.dataset2excel(EsureyFamilyDS, "/jsp/cams/drel/esurey/internal/esureyInfoQueryListExcel.jsp");
	EsureyFamilyDS.baseParams["excelType"]="reset"; //重置导出类型
}

/**
 * 选择属地行政区划窗口
 */
function func_ForDomicileSelect() {
	queryOrganName();
	organCode=organArea.substring(0, 4)+"00000000";
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("qAreah").value = list[0];
		document.getElementById("qArea").value = list[1];
	}
}

/*
*从数据库dic_city中查询organName
*/
function queryOrganName() {
		organCode=organArea.substring(0, 4)+"00000000";
		if(organCode != null && organCode != "") {
			var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			command.setParameter("ID",organCode);
			command.execute("findOrganName");
			var fullName = command.getReturn("organName");
			if(fullName != null && fullName != "") {
				organName = fullName;
			}
		}
}