/******************************************************************添加JS 开始***********************************************************/
var ifQuery = false;
var isSpecial="0";
var assistanceType="01";
/**
 *  1-事件处理：页面初始化
 *  最低保障家庭信息列表
 *  licb
 */
function init() {
	document.getElementById("reDiv").style.display="none";
	document.getElementById("beginDate").value=getCurDate().substring(0,7);
	//document.getElementById("endDate").value=getCurDate().substring(0,7);
    ds.on('load', showDiv);
    if(query_organCode){
		ds.setParameter("beginDate", startTime);
		//ds.setParameter("endDate",endTime);
		ds.setParameter("releaseArea",organCode);
		ds.setParameter("isSpecial",isSpecial);
		ds.setParameter("assistanceType",assistanceType);
//		ds.load();
    }
}
 
/**
 *  2-事件处理：点击户数查看明细
 *  最低保障家庭信息列表
 *  licb
 */
function redirectFamily(obj, type) {
	var url = "";
	var organCode = obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
	var startTime = document.getElementById("beginDate").value;// 起始时间
	var endTime = document.getElementById("endDate").value;// 起止时间
	var sortType="";//属别
	
	var pagePath = "/jsp/cams/drel/report/lowAreaSort_Family.jsp";
	if(type == "1") { //央属
		sortType="01";
	} else if(type == "2") { //省属
		sortType="02";
	} else if(type == "3") { //市属
		sortType="03";
	} else if(type == "4") { //县属
		sortType="04";
	} else if(type == "5") { //合计
		sortType="99";
	}
	
	var data=new L5.Map();
	var	url =pagePath+"?autoQuery=true&query_organCode="+ organCode + "&startTime=" + startTime + "&endTime=" + endTime+"&sortType="+sortType+"&isSpecial="+isSpecial+"&assistanceType="+assistanceType;
	var text="";
	L5.forward(url,text);
}
/**
 *  3-事件处理：点击人数查看明细
 *  最低保障家庭成员信息列表
 *  licb
 */
function redirectPeople(obj, type) {
	var url = "";
	var organCode = obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
	var startTime = document.getElementById("beginDate").value;// 起始时间
	//var endTime = document.getElementById("endDate").value;// 起止时间
	var sortType="";//属别
	var pagePath = "/jsp/cams/drel/report/lowAreaSort_People.jsp";
	if(type == "1") { //央属
		 sortType="01"; 
	} else if(type == "2") { //省属
	     sortType="02"; 
	} else if(type == "3") { //市属
	     sortType="03"; 
	} else if(type == "4") { //县属
	     sortType="04"; 
	} else if(type == "5") { //合计
	     sortType="99"; 
	}
	
	var	url = pagePath+"?autoQuery=true&query_organCode="+ organCode + "&startTime=" + startTime + "&endTime=" + endTime+"&sortType="+sortType;
	var text="";
	L5.forward(url,text);
}

/**
 *  4-事件处理：点击查询按钮后，页面加载
 *  最低保障家庭成员信息列表
 *  licb
 */		
function showDiv() {
	document.getElementById("reDiv").style.display = "";
	var cxsjq_y = document.getElementById("beginDate").value;//查询开始时间
    //var cxsjz_y = document.getElementById("endDate").value;//查询结束时间
    
    var startTime=cxsjq_y.substring(0,4)+"年"+cxsjq_y.substring(5,7)+"月";
	//var endTime  =cxsjz_y.substring(0,4)+"年"+cxsjz_y.substring(5,7)+"月";
    document.getElementById("statisticsTime").innerText =startTime;
	
	
	document.getElementById('label1').innerHTML=getMoneyFormatNoPoint(ds.sum("CENTRAL_FAMILY_SUM"));
	document.getElementById('label2').innerHTML=getMoneyFormatNoPoint(ds.sum("CENTRAL_PEOPLE_SUM"));
	document.getElementById('label3').innerHTML=getMoneyFormat(ds.sum("CENTRAL_ASSISTANCE_MON"));
	document.getElementById('label4').innerHTML=getMoneyFormatNoPoint(ds.sum("PROVINCE_FAMILY_SUM"));
	document.getElementById('label5').innerHTML=getMoneyFormatNoPoint(ds.sum("PROVINCE_PEOPLE_SUM"));
	document.getElementById('label6').innerHTML=getMoneyFormat(ds.sum("PROVINCE_ASSISTANCE_MON"));
	document.getElementById('label7').innerHTML=getMoneyFormatNoPoint(ds.sum("CITY_FAMILY_SUM"));
	document.getElementById('label8').innerHTML=getMoneyFormatNoPoint(ds.sum("CITY_PEOPLE_SUM"));
	document.getElementById('label9').innerHTML=getMoneyFormat(ds.sum("CITY_ASSISTANCE_MON"));
	document.getElementById('label0').innerHTML=getMoneyFormatNoPoint(ds.sum("COUNTY_FAMILY_SUM"));
	document.getElementById('label11').innerHTML=getMoneyFormatNoPoint(ds.sum("COUNTY_PEOPLE_SUM"));
	document.getElementById('label12').innerHTML=getMoneyFormat(ds.sum("COUNTY_ASSISTANCE_MON"));
	document.getElementById('label13').innerHTML=getMoneyFormatNoPoint(ds.sum("RELEASE_FAMILY_SUM"));
	document.getElementById('label14').innerHTML=getMoneyFormatNoPoint(ds.sum("RELEASE_PEOPLE_SUM"));
	document.getElementById('label15').innerHTML=getMoneyFormat(ds.sum("ASSISTANCE_MON_SUM"));
}
function getMoneyFormatNoPoint(value){
	return formatMoney(nullToZero(value),0);
}
/**
 *  5-事件处理：点击查询按钮
 *  最低保障家庭成员信息列表
 *  licb
 */
function query() {
    var beginDate = document.getElementById("beginDate").value;//查询结束时间止
    var endDate = document.getElementById("beginDate").value;//行政区划
    
    if(beginDate=="") {
		L5.Msg.alert("提示","请填写统计起始日期！");
		return;
	}
	ds.setParameter("beginDate", beginDate);
	//ds.setParameter("endDate",endDate);
	ds.setParameter("releaseArea",organCode);
	ds.setParameter("isSpecial",isSpecial);
	ds.setParameter("assistanceType",assistanceType);
	ds.load();
}

/**
 *  6-事件处理：点击重置按钮
 *  困难家庭登记列表
 *  licb
 */
function reset(){
	var form=L5.getDom("queryForm");
	form.reset();
}
/**
 *  7-事件处理：点击导出EXCEL按钮
 *  最低生活保障家庭信息列表
 *  licb
 */
function forExcel(){
	var pageSize = ds.pageInfo.pageSize;
	var pageIndex = ds.pageInfo.pageIndex;
	var startCursor = ds.pageInfo.startCursor;
	 ds.baseParams["excelType"]="1"; //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	 ds.baseParams["startExcel"]=startCursor; //总记录中当前页记录起始位置
	 ds.baseParams["limitExcel"]=ds.getTotalCount();
	// //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	var statisticsTime = document.getElementById("statisticsTime").innerText;
	L5.dataset2excel(ds,
			"/jsp/cams/drel/report/exportPeopleTypeExcel.jsp?statisticsTime="+statisticsTime);
	 ds.baseParams["excelType"]="reset"; //重置导出类型
}
/**
 *  8-事件处理：点击地区链接跳转下级明细数据
 *  最低生活保障家庭信息列表
 *  licb
 */
function queryNextLevel(obj){
	var organCode = obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
    var beginDate = document.getElementById("beginDate").value;//查询结束时间止
    var endDate = document.getElementById("beginDate").value;//行政区划
    
    if(beginDate=="") {
		L5.Msg.alert("提示","请填写统计起始日期！");
		return;
	}
	if(endDate=="") {
		L5.Msg.alert("提示","请填写统计截止日期！");
		return;
	}
	ds.setParameter("beginDate", beginDate);
	ds.setParameter("endDate",endDate);
	ds.setParameter("releaseArea",organCode);
	ds.setParameter("isSpecial",isSpecial);
	ds.setParameter("assistanceType",assistanceType);
	ds.load();
}

/**
 *  9-事件处理：从数据库dic_city中查询organName
 *  所属机构设置
 *  licb
 */
function queryOrganName() {
	if(!ifQuery) {
		if(organCode != null && organCode != "") {
			var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			command.setParameter("ID",organCode);
			command.execute("findOrganName");
			var fullName = command.getReturn("organName");
			if(fullName != null && fullName != "") {
				organName = fullName;
			}
			ifQuery = true;
		}
	}	
}
 
function getOrganName(organCode) {
		if(organCode != null && organCode != "") {
			var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			command.setParameter("ID",organCode);
			command.execute("findOrganName");
			return command.getReturn("organName");
		}
			return "";
}
 /**
 *  10-事件处理：从数据库dic_city中查询organName
 *  查询页面中选择行政区划查询
 *  licb
 */
function query_selectDomicile() {
	queryOrganName();
	var revalue = window.showModalDialog(L5.webPath
					+ "/jsp/cams/comm/diccity/dicCity.jsp?organCode="
					+ organCode + "&radioMaxlevel=0&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileName").value = list[4];
		document.getElementById("domicileCode").value = list[0];
	}
}
function areaSelect(){
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("releaseAreaName").value = list[1];
		document.getElementById("releaseAreaCode").value = list[0];
	}
}
function releaseAreaSelect(){
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		releaseSummaryDs.set("releaseAreaName",list[1]);
		releaseSummaryDs.set("releaseAreaCode",list[0]);
	}
}
//两位小数格式化
function getMoneyFormat(value){
	return formatMoney(nullToZero(value),2);
}

/******************************************************************添加JS 结束***********************************************************/
