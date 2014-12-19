function init(){
	jcmUserinfoList.setParameter("organCode",organArea);
	jcmUserinfoList.load();
}

function insert(){
	jcmUserinfo.removeAll();
	jcmUserinfo.newRecord();
	L5.getCmp('userinfo').show();
	document.getElementById('companyName').disabled=false;
}

// 弹出主管
function func_ForManaSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=-2&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("organCode").value = list[0];
		document.getElementById("organName").value = list[1];
	}
}
// 弹出主管
function func_ForManaSelectWin() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=-2&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		var reocrd = jcmUserinfo.getCurrent();
		reocrd.set("organCode", list[0]);
		reocrd.set("organName", list[1]);
	}
}

function query(){
	if(document.getElementById('organCode').value = '' ){
		jcmUserinfoList.setParameter("organCode",organArea);
	}else{
		jcmUserinfoList.setParameter("organCode",document.getElementById('organCode').value);
	}
	jcmUserinfoList.setParameter("userId",document.getElementById('userId').value);
	jcmUserinfoList.setParameter("companyName",document.getElementById('unitName').value);
	jcmUserinfoList.setParameter("companyType",document.getElementById('unitType').value);
	jcmUserinfoList.load();
}

function confirmWin(){
	var userIsValidate = jcmUserinfo.isValidate();
	if(userIsValidate != true){
		L5.Msg.alert("提示",userIsValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.jcm.cmd.JcmCompanyProfileCmd");   
	command.setParameter("userInfo",jcmUserinfo.getCurrent());
	command.execute("insertUser");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function closeWin(){
	L5.getCmp('userinfo').hide();
}
function chooseUnit(){
	L5.getCmp('unitWin').show();
	jcmUserinfoquery.setParameter("ORGAN_CODE",organArea);
	jcmUserinfoquery.load();
}
function submitUnit(){
	var grid = L5.getCmp('subgrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
	 	var record = jcmUserinfo.getCurrent();
	 	record.set('companyId',records[0].get('companyId'));
	 	record.set('companyName',records[0].get('companyName'));
	 	document.getElementById('companyName').disabled="true" ;
	 	L5.getCmp('unitWin').hide();
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}

function querychoose(){
	if(document.getElementById('organCode1').value = '' ){
		jcmUserinfoquery.setParameter("organ_Code",organArea);
	}else{
		jcmUserinfoquery.setParameter("organ_Code",document.getElementById('organCode1').value);
	}
	jcmUserinfoquery.setParameter("company_Name@like",document.getElementById('unitName1').value+'%');
	jcmUserinfoquery.setParameter("company_Type",document.getElementById('unitType1').value);
	jcmUserinfoquery.load();
}
// 弹出主管
function func_ForManaSelect1() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=-2&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("organCode1").value = list[0];
		document.getElementById("organName1").value = list[1];
	}
}