function init() {
	if(method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		//document.getElementById("startYear").value =respectiveYears;
		//document.getElementById("organId").value =organId;
	}
	else if (method=="DETAIL"){
	    document.getElementById("startYear").value =respectiveYears;
		document.getElementById("organId").value =organId;
	}
	else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}

//生成明细
function query(){
	var buildDate =document.getElementById("buildDate").value;
	if(buildDate==''){
	   L5.Msg.alert('提示',"生成日期(起)不能为空!");
	   return false;
	}
	if(buildDate!=''&&!validateDateFormat(buildDate)){
		L5.Msg.alert("提示","生成日期(起)格式不正确！");
		return false;
	}
	var currentDate = getCurDate();
	if(buildDate>currentDate){
		L5.Msg.alert('提示','生成日期不能大于当前日期！');
		return false;
	}
	var startDate =document.getElementById("startDate").value;
	if(startDate==''){
	   L5.Msg.alert('提示',"应发日期(起)不能为空!");
	   return false;
	}
	if(startDate!=''&&!validateDateFormat(startDate+'-01')){
		L5.Msg.alert("提示","应发日期(起)格式不正确！");
		return false;
	}
	var endDate =document.getElementById("endDate").value;
	if(endDate==''){
	   L5.Msg.alert('提示',"应发日期(止)不能为空!");
	   return false;
	}
	if(endDate!=''&&!validateDateFormat(endDate+'-01')){
		L5.Msg.alert("提示","应发日期(止)格式不正确！");
		return false;
	}
	if(getParam("startDate")>getParam("endDate")){
	   L5.Msg.alert('提示',"应发日期(止)不能早于应发日期(起)!");
	   return false;
	}
	
	//organCode = organCode.substr(0,6);
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCapitalDetailCommand");
	command.setParameter("organCode",organCode);
	command.setParameter("registerType","21");
	command.execute("getPreBuildDate");//取得上次生成日期
	var preEndDate = command.getReturn("preEndDate");//取得上次发放结束时间
	if(preEndDate!=undefined){
		if(preEndDate>=getParam("startDate")){
			L5.Msg.alert("提示","上次发放结束日期为"+preEndDate+"\n"+"应发时间起必须大于此日期");
			return false;
		}
	}
	var preBuildDate =command.getReturn("preBuildDate");
	if(preBuildDate==undefined){
		preBuildDate = getCurDate();
	}
	//调用存储过程，并生成明细表和费用总表
	command.setParameter("buildDate",getParam("buildDate"));
	command.setParameter("startDate",getParam("startDate"));
	command.setParameter("endDate",getParam("endDate"));
	command.setParameter("preBuildDate",preBuildDate);
	command.execute("insertDepdtPension");
	
	ds.setParameter("organId",organCode);
	ds.setParameter("registerType","21");
	ds.setParameter("startDate",getParam("startDate"));	
	ds.setParameter("endDate",getParam("endDate"));		
	ds.setParameter("buildDate",getParam("buildDate"));
	ds.load();
}

function save(){
   var records = ds.getAllRecords();
   if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
   }
   var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCapitalDetailCommand");
	
	command.setParameter("records", records);
	
	command.execute("saveData");
	if (!command.error) {
		ds.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function func_close(){
	window.close();
}
/**
 * 所属机构帮助
 *//*
function forHelp(){
	//alert("struId="+struId);
	var revalue=window.showModalDialog("../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=1&organType=1&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
	var list = revalue.split(";");
		document.getElementById("queryOrganCode").value = list[0];
		document.getElementById("organName").value = list[1];
	}
}*/
//获得当前日期 
function getCurDate(){
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10){month="0"+month;}
	var day = date.getDate();
	if(day<10){day = "0"+day;}
	return year+"-"+month+"-"+day;
}

