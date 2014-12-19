var ifQuery = false;
var time = new Date();
var times = time.format("Y");
var query_startTime = times+"-01-01";
var query_endTime = times+"-12-31";
var flag ;
var path ;
var changeContent;
function init() {
		initSelect();
		
	    L5.Ajax.timeout=300000;
       //L5.QuickTips.init();
        //sipTime('');
}
/**
 * 
 * @param {} ds
 */
function sipQueryTime() {
	
	var ageBegin = trim(document.getElementById("ageBegin").value);
	var ageEnd = trim(document.getElementById("ageEnd").value);
	var reg = /^\d+$/;
	if(ageBegin != null && ageBegin != "") {
		if(ageBegin.match(reg) == null) {
			L5.Msg.alert("提示","起始年龄只能为正整数");
			return false;
		}
	}
	
	if(ageEnd != null && ageEnd != "") {
		if(ageEnd.match(reg) == null) {
			L5.Msg.alert("提示","截止年龄只能为正整数");
			return false;
		}
		
		if(ageBegin != null && ageBegin != "") {
			if(parseInt(ageEnd) <= parseInt(ageBegin)) {
				L5.Msg.alert("提示","截止年龄不能小于起始年龄");
				return false;
			}
		}
	}  

	
	var type = document.getElementById("timeType").value;
	
	var cxsj_q;
	var cxsj_z;
	if(type=='1'){
		cxsj_q = trim(document.getElementById("startTime").value);
		cxsj_z = trim(document.getElementById("endTime").value);
		if (cxsj_q == '') {
			L5.Msg.alert('提示', '查询起始时间不能为空！');
			return false;
		}
		if(cxsj_q!=''&&!validateDateFormat(cxsj_q)){
			L5.Msg.alert("提示","查询起始时间格式不正确！");
			return false;
		}
		if (cxsj_z == '') {
			L5.Msg.alert('提示', '查询结束时间不能为空！');
			return false;
		}
		if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
			L5.Msg.alert("提示","查询结束时间格式不正确！");
			return false;
		}
	}else if(type=='2'){
		cxsj_q ="";
		cxsj_z = trim(document.getElementById("toTime").value);
		if (cxsj_z == '') {
			L5.Msg.alert('提示', '审批截止时间不能为空！');
			return false;
		}
		if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
			L5.Msg.alert("提示","审批截止时间格式不正确！");
			return false;
		}
		
	}
	return true;
	
}

function update(){ 
	//判断只允许县市区用户修改
	if(organType != 13){
		alert("只允许县市区用户修改");
		return false;
	}

	var basicInfoGrid;
	var objectType = '';
	var objectState = "";
	
   basicInfoGrid=L5.getCmp('baseGridPanel');
   objectState = basicInfoGrid.getSelectionModel().getSelections()[0].get('OBJECT_STATE');
	
	var selected=basicInfoGrid.getSelectionModel().getSelections();
	if(selected[0].get("FLAG") == '1'){
		alert("不能修改已迁出人员！");
		return false;
	}
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var peopleId = selected[0].get('PEOPLE_ID');
	var familyId = selected[0].get('FAMILY_ID');
	var username = selected[0].get('NAME');
	var idCard = selected[0].get('ID_CARD');
	
	if(objectType == ''){
		objectType = selected[0].get('OBJECT_TYPE');
	}
	
	var url='basicInfoUpdate.jsp?peopleId='+peopleId+'&familyId='+familyId+'&username='+username+'&idCard='+idCard+'&objectState='+objectState+'&objectType='+objectType;
	var width = screen.width-200;
	var height = 520;
	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	query();
	if (win==null) {
		return;
	}
}

function detail(){
	var basicInfoGrid;
	var objectType = '';
	
	basicInfoGrid=L5.getCmp('baseGridPanel');
	
	var selected=basicInfoGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	var peopleId = selected[0].get('PEOPLE_ID');
	var familyId = selected[0].get('FAMILY_ID');
	var username = selected[0].get('NAME');
	var idCard = selected[0].get('ID_CARD');
	var objectState = selected[0].get('OBJECT_STATE');
	if(objectType == ''){
		objectType = selected[0].get('OBJECT_TYPE');
	}
	var url='../basicInfoView/basicInfoDetail.jsp?peopleId='+peopleId+'&familyId='+familyId+'&username='+username+'&idCard='+idCard+'&objectState='+objectState+'&objectType='+objectType;
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if (win==null) {
		return;
	}
}
function dossiers(){
	var basicInfoGrid;
	var objectType = '';
	
	basicInfoGrid=L5.getCmp('baseGridPanel');
	
	var selected=basicInfoGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	var peopleId = selected[0].get('PEOPLE_ID');
	var familyId = selected[0].get('FAMILY_ID');
	var objectState = selected[0].get('OBJECT_STATE');
	if(objectType == ''){
		objectType = selected[0].get('OBJECT_TYPE');
	}
	var url='../basicInfoView/peopleInfoDetail.jsp?peopleId='+peopleId+'&familyId='+familyId+'&objectType='+objectType;
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if (win==null) {
		return;
	}
}
function replaceAll(s0,s1,s2) { 
    return s0.replace(new RegExp(s1,"gm"),s2); 
}
/**
 * 打印
 */
function print(){
/**
	获取bptObjectType的值
	用于判断当前显示的是哪个panel
*/
	var bptOb = document.getElementById("bptObjectType").value;
	
		bptGP = 'baseGridPanel';
	
	
	var editGrid=L5.getCmp(bptGP);
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要打印的记录!");
		return false;
	}
	var peopleId = selected[0].get('PEOPLE_ID');
	var objectType = null;
	//判断优抚类别获取类别Id
	if(bptOb == 1){
		objectType = selected[0].get('DISABILITY_TYPE_CODE');
	}else if(bptOb == 2){
		objectType = selected[0].get('OBJECT_TYPE');
	}else if(bptOb == 41){
		objectType = 41;
	}else if(bptOb == 42){
		objectType = 42;
	}else if(bptOb == 5){
		objectType = 51;
	}else if(bptOb == 6){
		objectType = 61;
	}else if(bptOb == 8){
		objectType = 81;
	}else{
		objectType = selected[0].get('OBJECT_TYPE');
	}
//	var domicile_code = selected[0].get('DOMICILE_CODE');
//	alert(peopleId+"  "+objectType);
	var data = new L5.Map();
	data.put("peopleId",peopleId);
	data.put("objectType",objectType);
	//判断优抚类别
	if(objectType == 11||objectType == 12||objectType == 13||objectType == 14||objectType == 15){//伤残
		
		if(organType == '11'){
			if(objectType == 11){
				var getValue = window.showModalDialog('../flow/disability/selectLeftOrRightPrint.jsp?type=disability&peopleId='+peopleId, 'newwindow','dialogWidth=450px;dialogHeight=360px','location:no');
				if(getValue!=""&&getValue!=undefined){
					var list = getValue.split(";");
					flag = list[1];
					
					
					changeContent = decodeURI(list[2]);
					
					changeContent=replaceAll(changeContent," ","&nbsp;");
					changeContent=replaceAll(changeContent,"\r\n","<br/>");
					changeContent=replaceAll(changeContent,"\n","<br/>");
					changeContent = escape(encodeURIComponent(changeContent));
					//alert(changeContent);
					if(flag == "0") { //左边栏
						var url="../disabilityRenewal/disabilityInfoWrite.jsp?renewalFlag=no&peopleId="+peopleId+"&changeContent="+changeContent;
						var width = 1024;
						var height = 768;
					    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
						/*path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/disleft.doc";
						change(path,changeContent,"68");*/
					} else  if(flag == "1") { //右边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/disright.doc";
						change(path,changeContent,"67");
					} else if (flag == "3") {
						openPrint(peopleId,objectType);
					}
					//var url='table/reguIdenti_apptable.jsp?peopleId='+peopleId+'&objectType='+objectType;
					//window.showModalDialog(url,window);
				}
			}else{
				
				
				var getValue = window.showModalDialog('../flow/disability/selectLeftOrRightPrint.jsp?type=disability&peopleId='+peopleId, 'newwindow','dialogWidth=450px;dialogHeight=360px','location:no');
				if(getValue!=""&&getValue!=undefined){
					var list = getValue.split(";");
					flag = list[1];
					
					
					changeContent = decodeURI(list[2]);
					
					if(flag == "0") { //左边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/disleft.doc";
						change(path,changeContent,"68");
					} else  if(flag == "1") { //右边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/disright.doc";
						change(path,changeContent,"67");
					} else if (flag == "3") {
						openPrint(peopleId,objectType);
					}
					//var url='table/reguIdenti_apptable.jsp?peopleId='+peopleId+'&objectType='+objectType;
					//window.showModalDialog(url,window);
				}
			}
		}else{
			alert("伤残只能省级用户打印！");
			return false;
		}
	}else if(objectType == 41||objectType == 42){//在乡复员军人、带病回乡
		if(organType == '12'){
			var getValue = window.showModalDialog('../flow/disability/selectLeftOrRightPrint.jsp?type=demobilized&peopleId='+peopleId, 'newwindow','dialogWidth=450px;dialogHeight=360px','location:no');
			if(getValue!=""&&getValue!=undefined){
				var list = getValue.split(";");
				flag = list[1];
				changeContent = decodeURI(list[2]);
				if(objectType == 41){//在乡复员军人
					if(flag == "0") { //左边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/left.doc";
						change(path,changeContent,"69");
					} else  if(flag == "1") { //右边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/demright.doc";
						change(path,changeContent,"65");
					} else if (flag == "3") {
						openPrint(peopleId,objectType);
					}
				} else if (objectType == 42){//带病回乡军人
					if(flag == "0") { //左边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/left.doc";
						change(path,changeContent,"69");
					} else  if(flag == "1") { //右边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/testright.doc";
						change(path,changeContent,"66");
					} else if (flag == "3") {
						openPrint(peopleId,objectType);
					}
				}
				//var url='table/reguIdenti_apptable.jsp?peopleId='+peopleId+'&objectType='+objectType;
				//window.showModalDialog(url,window);
			}
		}else{
			alert("在乡复员、带病回乡军人只能市级用户打印！");
			return false;
		}
	}else if(objectType == 21||objectType == 22||objectType == 23||objectType == 51||objectType == 61){//三属、参战、参试
		
		if(organType == '13'){
			var type;
			if(objectType == 21||objectType == 22||objectType == 23){
				type="dependant";
			}else{
				type="war";
			}
			var getValue = window.showModalDialog('../flow/disability/selectLeftOrRightPrint.jsp?type='+type+'&peopleId='+peopleId, 'newwindow','dialogWidth=450px;dialogHeight=360px','location:no');
			if(getValue!=""&&getValue!=undefined){
				var list = getValue.split(";");
				flag = list[1];
				changeContent = decodeURI(list[2]);
				if(objectType == 51){//参战军人
					if(flag == "0") { //左边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/left.doc";
						change(path,changeContent,"69");
					} else  if(flag == "1") { //右边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/testright.doc";
						change(path,changeContent,"64");
					} else if (flag == "3") {
						openPrint(peopleId,objectType);
					}
				} else if(objectType == 61) {//参试军人
					if(flag == "0") { //左边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/left.doc";
						change(path,changeContent,"69");
					} else  if(flag == "1") { //右边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/testright.doc";
						change(path,changeContent,"63");
					} else if (flag == "3") {
						openPrint(peopleId,objectType);
					}
				} else {//三属
					if(flag == "0") { //左边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/left.doc";
						change(path,changeContent,"69");
					} else  if(flag == "1") { //右边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/depright.doc";
						change(path,changeContent,"62");
					} else if (flag == "3") {
						openPrint(peopleId,objectType);
					}
				}
				//var url='table/reguIdenti_apptable.jsp?peopleId='+peopleId+'&objectType='+objectType;
				//window.showModalDialog(url,window);
			}
		}else{
			alert("三属、参战、参试只能县级用户打印！");
			return false;
		}
	}else{
		alert("您选择的用户暂不能打印！");
		return false;
	}
//	var text = '优抚对象定期认证打印';
//	L5.forward(url,text,data);
	
}
//证件变更时的打印页面
function change(path,changeContent,serviceType_temp) {
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10){
		month="0"+month;
	}
	document.getElementById("docPath").value = path;
	document.getElementById("printYear").value = year;
	document.getElementById("printMonth").value = month;
	document.getElementById("changeContent").value = changeContent ;
	
	document.getElementById("bptQueryPathServiceType").value = serviceType_temp;
	
	var url="../../../cams/comm/print/print_noDataSet.jsp";
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}
function excel_click(){//导出Excel
	selectCondition('fieldSelect');
	
}
function excel_imp(){
	var dsBptObject1=L5.DatasetMgr.lookup("dsBptObject1");
	var elements = document.forms[0];
	for(var i=0;i<elements.length;i++){
	   //alert(elements[i].type);
	   switch(elements[i].type){ //对于不同的元素做不同的处理
	     case "text":
		   	//alert((elements[i].value?elements[i].value:'')+':'+elements[i].id);
		   if(elements[i].id!="domicileName"&&elements[i].id!="objectTypeName"&&elements[i].id!="disabilityLevelCodeName"){
		   		dsBptObject1.setParameter(elements[i].id, elements[i].value);
		   };
		   break;
		 case "select-one":
		 	//alert((elements[i].value?elements[i].value:'')+':'+elements[i].id);
		 	if(elements[i].id!="timeType"){
		   		dsBptObject1.setParameter(elements[i].id, elements[i].value);
		   };
		 	break;
		 case "hidden":
		 	//alert((elements[i].value?elements[i].value:'')+':'+elements[i].id);
		 	dsBptObject1.setParameter(elements[i].id, elements[i].value);
		 	break;
		 default:break;
	   }
	}
	dsBptObject1.setParameter("organCode",organCode);
	//dsBptObject1.setParameter("excel","1");
	dsBptObject1.load();
	//var objectType = getParam("bptObjectType");//获取节点ID
	var r1 = fieldds.getRightAll();
	var d1 = fieldds.getDataArrary();
	var fields1="";
	for(var i=0; i<r1.length;i++){
		for(var j=0; j<d1.length;j++){
			if(r1[i][0]==d1[j][0]){
				fields1+=d1[j][3]+",";
			}
		}
	}
	L5.dataset2excel(dsBptObject1,"/jsp/cams/bpt/peopleBasicInfo/excel/bptPeople_excel.jsp?fields="+fields1);
	noReclick(dsBptObject1,"excelButton");
	fwin_close();
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return trim(value);
}
function query(){
	if(!sipQueryTime()){
		return;
	};
	var elements = document.forms[0];
	for(var i=0;i<elements.length;i++){
	   //alert(elements[i].type);
	   switch(elements[i].type){ //对于不同的元素做不同的处理
	     case "text":
		   	//alert((elements[i].value?elements[i].value:'')+':'+elements[i].id);
		   if(elements[i].id!="domicileName"&&elements[i].id!="objectTypeName"&&elements[i].id!="disabilityLevelCodeName"){
		   		dsBptObject.setParameter(elements[i].id, trim(elements[i].value));
		   };
		   break;
		 case "select-one":
		 	//alert((elements[i].value?elements[i].value:'')+':'+elements[i].id);
		 	if(elements[i].id!="timeType"){
		   		dsBptObject.setParameter(elements[i].id, elements[i].value);
		   };
		 	break;
		 case "hidden":
		 	//alert((elements[i].value?elements[i].value:'')+':'+elements[i].id);
		 	dsBptObject.setParameter(elements[i].id, elements[i].value);
		 	break;
		 default:break;
	   }
	}
	dsBptObject.setParameter("organCode",organCode);
	dsBptObject.load();
	
}

function openPrint(peopleId,objectType) {
	var url="../../comm/print/jspcommonprint.jsp?";
	var docpath;
	if(objectType == 11){//残疾军人
		//docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityJR_apptable.doc";
		url="../disabilityRenewal/disabilityInfoWrite.jsp?renewalFlag=no&peopleId="+peopleId;
	}else if(objectType == 12){//伤残国家机关工作人员
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityGZ_apptable.doc";
		
	}else if(objectType == 13){//伤残人民警察
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityJC_apptable.doc";
		
	}else if(objectType == 14){//伤残民兵民工
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityMB_apptable.doc";
		
	}else if(objectType == 15){//因战因公伤残人员
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityMB_apptable.doc";
		
	}else if(objectType == 21){//烈士家属
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/dependantLS_apptable.doc";
		
	}else if(objectType == 22){//因公牺牲军人家属
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/dependantYG_apptable.doc";
	
	}else if(objectType == 23){//病故军人家属
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/dependantBG_apptable.doc";
		
	}else if(objectType == 41){//在乡复员军人
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/demobilized_apptable.doc";
		
	}else if(objectType == 42){//带病回乡复员军人
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/demobilizedIllness_apptable.doc";
		
	}else if(objectType == 51){//参战
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/war_apptable.doc";
		
	}else if(objectType == 61){//参试
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/tested_apptable.doc";
		
	}
	
	document.getElementById("docpath").value=docpath;
	var ements = document.getElementsByName("printQuery");
	for(var i=0;i<ements.length;i++) {
		var obj = ements[i];
		if(obj.getAttribute("queryData") == "queryData") {
			var idValue = obj.getAttribute("id");
			if(idValue == "peopleId") {
				obj.value = peopleId;
			} else if(idValue == "objectType") {
				obj.value = objectType;
			}
		}
	}
	document.getElementById("bptQueryPathServiceType").value=objectType;
	
	
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	window.close();
}
function reset(){document.forms[0].reset();}
function forHelp() {
	if(!ifQuery) {
		if (organCode != null && organCode != "") {
			var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			command.setParameter("ID", organCode);
			command.execute("findOrganName");
			var fullName = command.getReturn("organName");
			if (fullName != null && fullName != "") {
				organName = fullName;
			}
			ifQuery = true;
		}
	}
	var revalue = window.showModalDialog(L5.webPath
					+ "/jsp/cams/comm/diccity/dicCity.jsp?organCode="
					+ organCode + "&radioMaxlevel=0&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	// var
	// revalue=window.showModalDialog(L5.webPath+"/jsp/cams/bpt/comm/getselect_code.jsp?rootId="+struId+"&showOrganType=1&organType=1&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[4];
		// 获取优抚对象类别的值，然后判断是哪个查询页面,写入所属机构的值
		/*var type = getParam("objectType");
		if (type == '1') {
			document.getElementById("disabilityDomicileCode").value = list[0];
			document.getElementById("disabilityDomicileName").value = list[4];
		} else if (type == '2') {
			document.getElementById("dependantDomicileCode").value = list[0];
			document.getElementById("dependantDomicileName").value = list[4];
		} else if (type == '41') {
			document.getElementById("demobilizeDomicileCode").value = list[0];
			document.getElementById("demobilizeDomicileName").value = list[4];
		} else if (type == '42') {
			document.getElementById("illnessDomicileCode").value = list[0];
			document.getElementById("illnessDomicileName").value = list[4];
		} else if (type == '5') {
			document.getElementById("warDomicileCode").value = list[0];
			document.getElementById("warDomicileName").value = list[4];
		} else if (type == '6') {
			document.getElementById("testDomicileCode").value = list[0];
			document.getElementById("testDomicileName").value = list[4];
		} else if (type == '8') {
			document.getElementById("soldierDomicileCode").value = list[0];
			document.getElementById("soldierDomicileName").value = list[4];
		} else {
			document.getElementById("domicileCode").value = list[0];
			document.getElementById("domicileName").value = list[4];
		}*/

	}
}
function setMultiselect(data){
	doubs.reloadData(data);
	var queryTable = document.getElementById("queryTable");
	var tableRows = queryTable.rows.length;
	for (var i = tableRows-1; i > 1; i--) {
		queryTable.deleteRow(i);
	}
}

function forHelpOT() { 
	var revalue = window.showModalDialog("../dicobjecttype/dicobjecttype.jsp");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		var listTypeId = list[0].split(",");

		/*
		 * 获取第一个数的第一位和最后一个数的第一位， 相等则是有相同的一个上级节点，反之则不是同一个上级节点
		 */
		var tistart = 0;// 第一个数的第一位
		var tiend = 0;// 最后一个数的第一位
		if (listTypeId.length != 0) {
			tistart = listTypeId[0].substring(0, 1);// 获取第一个数的第一位
			tiend = listTypeId[listTypeId.length - 1].substring(0, 1);// 获取最后一个数的第一位
		}
		
		if (listTypeId.length != 0 && tistart == tiend) {
			document.getElementById("bptObjectType").value = tistart;
			if (tistart == 1) {// 伤残
				setMultiselect(base.concat(sc));
				fieldds.reloadData(basepeople.concat(disablitypeople));
			} else if (tistart == 2) {// 三属
				setMultiselect(base.concat(ss));
				fieldds.reloadData(basepeople.concat(depantpoeple));
			} else if (list[0] == 41) {// 在乡
				setMultiselect(base.concat(zx));
				fieldds.reloadData(basepeople.concat(demopeople));
			} else if (list[0] == 42) {// 带病回乡
				setMultiselect(base.concat(db)); 
				fieldds.reloadData(basepeople.concat(demoillpeople));
			} else if (tistart == 5) {// 参战
				setMultiselect(base.concat(cz));
				fieldds.reloadData(basepeople.concat(warpeople));
			} else if (tistart == 6) {// 参试
				setMultiselect(base.concat(cs));
				fieldds.reloadData(basepeople.concat(testpeople));
			} else if (tistart == 8) {// 村籍退役军人
				setMultiselect(base.concat(ls));
				fieldds.reloadData(basepeople.concat(soldierpeople));
			} else if (tistart == 'B') {// 老列
				setMultiselect(base.concat(ll));
				fieldds.reloadData(basepeople.concat(martyrpeople));
			} else {
				setMultiselect(base);
				fieldds.reloadData(basepeople);
			}
			document.getElementById("objectType").value = list[0];
			document.getElementById("objectTypeName").value = list[1];
			document.getElementById("bptObjectType").value = list[0];
			//L5.getCmp("conditionSelectedId").reset();
		} else {
			setMultiselect(base);
			
			document.getElementById("objectType").value = list[0];
			document.getElementById("objectTypeName").value = list[1];
			document.getElementById("bptObjectType").value = list[0];
			
		}
		//initFav();
	}
}
// 选择查询条件
function selectCondition(id) {
	var conditionSelect = L5.getCmp(id);
	conditionSelect.show();
}

var x;
var y;
//查询条件
var base=[['birthday', '出生日期','date'], 
	['nation', '民族','NationDataset'],//基本信息
	['sex', '性别','SexDataset'], 
	['relationship_type', '与户主关系','RelationshipTypeDataset'], 
	['domicile_type', '户籍类别','DomicileDataset'],
	['safeguard_type', '医疗保障方式','SafeguardDataset'], 
	['isprovinceMigrate', '是否为迁移人员','isprovinceMigrateds'],
	['objectState', '优抚对象状态','ObjectStateDataset'],
	['BPT_NO', '证书编号','']];
var sc=[['disability_level_code','伤残等级','Level'],//伤残
	['disability_case_code','伤残性质','DisabilityCaseDataset'],
	['conscript_date_start,conscript_date_end','入伍时间起-止','dates'],
	['veterans_date_start,veterans_date_end','退伍时间起-止','dates'],
	['disability_war_code','伤残时期','BptWarDataset'],
	['disability_genus_code','伤残属别','DisabilityGenusDataset'],
	['disability_date','致残时间','date'],
	['old_lonely_flag','是否孤老','yesorno'],
	['insanity_flag','是否精神病','yesorno'],
	['work_ability_code','劳动能力','WorkAbilityCodeEnum'],
	['viability_code','生活能力','ViabilityCodeEnum'],
	['support_pattern','供养方式','SupportPatternEnum']];
var ss=[['relationship','与牺牲病故军人关系','RelationTypeEnum'],//三属
	['student_flag','是否正在上学','yesorno'],
	['handicap_flag','是否残疾','yesorno'],
	['old_lonely_flag','是否孤老','yesorno'],
	['orphan_flag','是否孤儿','yesorno'],
	['work_ability_code','劳动能力','WorkAbilityCodeEnum'],
	['viability_code','生活能力','ViabilityCodeEnum'],
	['support_pattern','供养方式','SupportPatternEnum'],
	['holder_flag','是否持证人','yesorno'],
	['lezsw_name','烈士(牺牲,病故军人)姓名',''],
	['lezsw_sex','烈士(牺牲,病故军人)性别','SexDataset']];
var cz=[['conscriptc_date','入伍(参加工作)时间','date'],//参战
	['decruitment_date','退伍时间','date'],
	['war_type_code','参战类别','dsWarData'],
	['old_lonely_flag','是否孤老','yesorno'],
	['insanity_flag','是否精神病','yesorno'],
	['work_ability_code','劳动能力','WorkAbilityCodeEnum'],
	['viability_code','生活能力','ViabilityCodeEnum'],
	['support_pattern','供养方式','SupportPatternEnum'],
	['health_state_code','健康状况','HealthDataset'],
	['life_state_code','生活状况','dsLife']];
var cs=[['conscriptc_date','入伍(参加工作)时间','date'],//参试
	['decruitment_date','退伍时间','date'],
	['tested_type','参试类别','dsTest'],
	['is_health_flag','职业健康检查','yesorno'],
	['health_state_code','健康状况','HealthDataset'],
	['old_lonely_flag','是否孤老','yesorno'],
	['insanity_flag','是否精神病','yesorno'],
	['work_ability_code','劳动能力','WorkAbilityCodeEnum'],
	['life_state_code','生活状况','dsLife'],
	['viability_code','生活能力','ViabilityCodeEnum'],
	['support_pattern','供养方式','SupportPatternEnum']];
var db=[['conscript_date','入伍时间','date'],//带病
	['decruitment_date','退伍时间','date'],
	['is_war','是否参战','yesorno'],
	['is_innuclear','是否参试','yesorno'],
	['old_lonely_flag','是否孤老','yesorno'],
	['insanity_flag','是否精神病','yesorno'],
	['work_ability_code','劳动能力','WorkAbilityCodeEnum'],
	['viability_code','生活能力','ViabilityCodeEnum'],
	['support_pattern','供养方式','SupportPatternEnum'],
	['physiclal_status','身体状况','PhysiclalStatusEnum']];
var zx=[['conscript_date','入伍时间','date'],//在乡
	['decruitment_date','复员时间','date'],
	['belongdate','属于时期','warDs'],
	['is_koreanwar','是否抗美援朝','yesorno'],
	['old_lonely_flag','是否孤老','yesorno'],
	['insanity_flag','是否精神病','yesorno'],
	['work_ability_code','劳动能力','WorkAbilityCodeEnum'],
	['viability_code','生活能力','ViabilityCodeEnum'],
	['support_pattern','供养方式','SupportPatternEnum']];
var ll=[['status_type','身份类别','StatusTypeEnum'],//老列
	['sacrifice_date','牺牲时间','date'],
	['lezsw_approve_date','批准烈士（平反）时间','date'],
	['old_lonely_flag','是否孤老','yesorno'],
	['orphan_flag','是否孤儿','yesorno'],
	['life_state_code','生活状况','dsLife'],
	['work_ability_code','劳动能力','WorkAbilityCodeEnum'],
	['viability_code','生活能力','ViabilityCodeEnum'],
	['support_pattern','供养方式','SupportPatternEnum']];
var ls=[['conscript_date','入伍（参加工作时间）','date'],//60
	['decruitment_date','退役时间','date'],
	['forces_name','服役部队名称（番号）',''],
	['forces_no','服役部队代号',''],
	['soldier_start_date','服义务兵（开始时间）','date'],
	['soldier_end_date','服义务兵（结束时间）','date'],
	['soldier_years','所服义务兵折算年限',''],
	['old_lonely_flag','是否孤老','yesorno'],
	['work_ability_code','劳动能力','WorkAbilityCodeEnum'],
	['life_state_code','生活能力','ViabilityCodeEnum']];

/*
function initFav() {
	document.getElementById("conditionSelectedId").value = "";
	x = new L5.ux.ItemSelector({
				field : "",
				applyTo : "conditions",
				id : "conditionSelectedId",
				name : "conditionSelectedName",
				dataFields : ["value", "text"],
				fromData : y,
				valueField : "value",
				displayField : "text",
				msWidth : 135,
				msHeight : 220
			});
}*/

function win_sure() {
	//var conditionSelectedId = document.getElementById("conditionSelectedId").value;
	var  rightall= doubs.getRightAll();
	var  gda= doubs.getDataArrary();
	var queryTable = document.getElementById("queryTable");
	var tableRows = queryTable.rows.length;
	for (var i = tableRows-1; i > 1; i--) {
		queryTable.deleteRow(i);
	}
	var rowIndex = 1;
	var cellIndex = 0;
	var newRow;
	var newCellTd;
	var newCellInput;
	if (rightall.length>0) {
		//var conditionKeys = conditionSelectedId.split(',');
		newRow = queryTable.insertRow();
		rowIndex++;
		for (var i = 0; i < rightall.length; i++) {
			for (var j = 0; j < gda.length; j++) {
				if (rightall[i][0] == gda[j][0]) {
					conditionText = gda[j][1];
					if (cellIndex == 3) {
						newRow = queryTable.insertRow();
						newRow.setAttribute("id", "row" + rowIndex);
						rowIndex++;
						cellIndex = 0;
					}
					newCellTd = newRow.insertCell();
					newCellTd.innerHTML = "<td width='8%'>" + conditionText + "</td>";
					newCellTd.setAttribute("id", rightall[i][0] + "Td");
					tdField = document.getElementById(rightall[i][0] + "Td");
					tdField.setAttribute("className", "FieldLabel");
					cellIndex++;
					if(gda[j][2]=="date"){
						newCellInput = newRow.insertCell();
						newCellInput.className = "FieldInput";
						newCellInput.innerHTML = "<input type='text' id='"
								+ rightall[i][0]
								+ "' class='TextEditor' title="
								+ conditionText
								+ "  format='Y-m-d' style='width: 80px;' maxlength='10'onpropertychange='changeDateStyle(this)'/><img "
								+ "src='../../../../skins/images/default/rl.gif' align='middle' onclick='getTimes(this);' >";
					} else if(gda[j][2]=="Level"){
						newCellInput = newRow.insertCell();
						newCellInput.className = "FieldInput";
						newCellInput.innerHTML = "<input type='text' id='disabilityLevelCodeName'"
								+ "  title='"
								+ conditionText
								+ "'  onclick='forDisability()' readonly='readonly'/>"
								+ "<input type='hidden' name='disabilityLevelCode' id='disabilityLevelCode' >";
					}else if(gda[j][2]=="dates"){
						newCellInput = newRow.insertCell();
						newCellInput.className = "FieldInput";
						newCellInput.innerHTML = "<input type='text' id='"
							+ rightall[i][0].split(",")[0]
						+ "' class='TextEditor' title="
						+ conditionText
						+ "  format='Y-m-d' style='width: 70px;' maxlength='10'onpropertychange='changeDateStyle(this)'/><img "
						+ "src='../../../../skins/images/default/rl.gif' align='middle' onclick='getTimes(this);' >--"
						+"<input type='text' id='"
						+ rightall[i][0].split(",")[1]
						+ "' class='TextEditor' title="
						+ conditionText
						+ "  format='Y-m-d' style='width: 70px;' maxlength='10'onpropertychange='changeDateStyle(this)'/><img "
						+ "src='../../../../skins/images/default/rl.gif' align='middle' onclick='getTimes(this);' >";
					} else if(gda[j][2]!=""){
						newCellInput = newRow.insertCell();
						newCellInput.className = "FieldInput";
						newCellInput.appendChild(createSelect(gda[j][2],rightall[i][0]));
					} else{
						newCellInput = newRow.insertCell();
						newCellInput.className = "FieldInput";
						newCellInput.innerHTML = "<input type='text' id='"
								+ rightall[i][0]
								+ "' class='TextEditor' title="
								+ conditionText
								+ " />";
					}
					
				}
			}
		}
		
		if(cellIndex==1){
			newCellInput.colSpan = 5;
		}else if(cellIndex==2){
			newCellInput.colSpan = 3;
		}

	}
	L5.getCmp('baseGridPanel').setHeight("100%"); 
	var win = L5.getCmp('conditionSelect');
	win.hide();
}
function createSelect(dsid,inId) {
	var inDataSet= L5.DatasetMgr.lookup(dsid);
	var records = inDataSet.getAllRecords();
	var select = document.createElement("<select></select>");
	select.id = inId;
	var option = document.createElement("<option></option>");
	select.appendChild(option);
	option.value = "";
	option.text = "请选择......";

	for (var i = 0; i < records.length; i++) {
		var option_i = document.createElement("<option></option>");
		select.appendChild(option_i);
		option_i.value = records[i].get("value");
		option_i.text = records[i].get("text");
	}
	return select;
}
function cwin_close() {
	var win = L5.getCmp("conditionSelect");
	win.hide();
}
function fwin_close() {
	var win = L5.getCmp("fieldSelect");
	win.hide();
}
function showTime(id) {
	var type = document.getElementById(id+"timeType").value;
	if(type == "0") {
		document.getElementById(id+"startTime").value="";
		document.getElementById(id+"endTime").value="";
		document.getElementById(id+"toTime").value="";
	} else if (type == '1') {
		document.getElementById(id+"times").style.display = "";
		document.getElementById(id+"time").style.display = "none";
		document.getElementById(id+"startTime").value=query_startTime;
		document.getElementById(id+"endTime").value=query_endTime;
	} else {
		document.getElementById(id+"times").style.display = "none";
		document.getElementById(id+"time").style.display = "";
		document.getElementById(id+"toTime").value=query_endTime;
	}
}

//双边栏
var doubs,fieldds;
function initSelect(){
	doubs = new doubSelect();
		var config={
			render:"conditions",
			lsText:"可选条件",
			rsText:"已选条件",
			data:base,
			object:"doubs",
			allmove:false
		};
	 	doubs.init(config);
	 fieldds = new doubSelect();
		var fconfig={
			render:"fields",
			lsText:"可选字段",
			rsText:"已选字段",
			data:basepeople,
			object:"fieldds",
			allmove:true
		};
	 	fieldds.init(fconfig);
				 		
 }
 //伤残等级
function forDisability(){
	var revalue=window.showModalDialog("../dicdisabilitylevel/dicdisabilitylevel.jsp");
	if(revalue!=""&&revalue!=undefined){
          var list = revalue.split(";");      
          
          if(list[0] == 0){
//         	document.getElementById("disabilityLevelCode").value=list[0];
            document.getElementById("disabilityLevelCodeName").value="所有伤残等级";
          }else{
          	document.getElementById("disabilityLevelCode").value=list[0];
            document.getElementById("disabilityLevelCodeName").value=list[1];
          }
          
	}
}