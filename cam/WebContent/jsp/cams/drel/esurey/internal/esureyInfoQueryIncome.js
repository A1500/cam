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
	var familyAddress=_$("qAreah");
	var dateBegin=_$("qDateBegin");
	var dateEnd=_$("qDateEnd");
	var assistanceType=_$("qAssistance");
	var incomeBegin=_$("qIncomeBegin");
	var incomeEnd=_$("qIncomeEnd");
	var domicleType=_$("qDomicleType");
	var esureyBegin=_$("qEsureyBegin");
	var esureyEnd=_$("qEsureyEnd");
	if(_$("qArea")!=""&&familyAddress==""){
		familyAddress=organArea;
	}
	if(familyAddress==""){
		L5.Msg.alert("提示","行政区划必须填写！");
		return;
	}
	if(assistanceType==""){
		L5.Msg.alert("提示","救助类型必须填写！");
		return;
	}
	if(domicleType==""){
		L5.Msg.alert("提示","家庭性质必须填写！");
		return;
	}
	if(incomeBegin!=""){
		if(isFloat(incomeBegin)!=true){
			L5.Msg.alert("提示","收入范围输入格式不正确！");
			return;
		}
	}
	if(incomeEnd!=""){
		if(isFloat(incomeEnd)!=true){
			L5.Msg.alert("提示","收入范围输入格式不正确！");
			return;
		}
	}
	if(esureyBegin!=""){
		if(isFloat(esureyBegin)!=true){
			L5.Msg.alert("提示","家庭财产范围输入格式不正确！");
			return;
		}
	}
	if(esureyEnd!=""){
		if(isFloat(esureyEnd)!=true){
			L5.Msg.alert("提示","家庭财产范围输入格式不正确！");
			return;
		}
	}
	if(incomeBegin==""&&incomeEnd==""&&esureyBegin==""&&esureyEnd==""){
		L5.Msg.alert("提示","收入范围和家庭财产范围不能同时为空！");
		return;
	}
	var EsureyFamilyDS=L5.DatasetMgr.lookup("EsureyFamilyDS");
	
	EsureyFamilyDS.setParameter("familyAddress",familyAddress);
	EsureyFamilyDS.setParameter("assistanceType",assistanceType);
	EsureyFamilyDS.setParameter("domicleType",domicleType);
	EsureyFamilyDS.setParameter("dateBegin",dateBegin);
	EsureyFamilyDS.setParameter("dateEnd",dateEnd);
	EsureyFamilyDS.setParameter("incomeBegin",incomeBegin);
	EsureyFamilyDS.setParameter("incomeEnd",incomeEnd);
	EsureyFamilyDS.setParameter("esureyBegin",esureyBegin);
	EsureyFamilyDS.setParameter("esureyEnd",esureyEnd);
	EsureyFamilyDS.setParameter("organArea",organArea);
	EsureyFamilyDS.load();
}
/**
 * 选择属地行政区划窗口
 */
function func_ForDomicileSelect() {
	queryOrganName();
	organCode=organArea.substring(0, 4)+"00000000";
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode="
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