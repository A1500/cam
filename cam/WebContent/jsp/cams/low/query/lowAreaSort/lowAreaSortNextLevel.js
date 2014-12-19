/******************************************************************添加JS 开始***********************************************************/
var ifQuery = false;
/**
 *  1-事件处理：页面初始化
 *  最低保障家庭信息列表
 *  licb
 */
function init() {
	dsNext.setParameter("xzqu", xzqu);
    dsNext.on('load', showDiv);
	if(cxsjq!=null&&cxsjz!=null){
		dsNext.setParameter("cxsjq", cxsjq);
		dsNext.setParameter("cxsjz", cxsjz);
		dsNext.load();
	}
	L5.QuickTips.init();
	
}
 
/**
 *  2-事件处理：点击户数查看明细
 *  最低保障家庭信息列表
 *  licb
 */
function redirectFamily(obj, type) {
   alert("11");
	var url = "";
	var organCode = obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
	var startTime = document.getElementById("cxsj_q").value;// 起始时间
	var endTime = document.getElementById("cxsj_z").value;// 起止时间
	var sortType="";//属别
	
	var pagePath = "/jsp/cams/low/query/lowAreaSort/lowAreaSort_Family.jsp";
	if(type == "1") { //央属
		sortType="10";
	} else if(type == "2") { //省属
		sortType="20";
	} else if(type == "3") { //市属
		sortType="40";
	} else if(type == "4") { //县属
		sortType="50";
	} else if(type == "5") { //合计
		sortType="99";
	}
	
	var	url = L5.webPath+pagePath+"?autoQuery=true&query_organCode="+ organCode + "&startTime=" + startTime + "&endTime=" + endTime+"&sortType="+sortType;
	window.open(url);
}
/**
 *  3-事件处理：点击人数查看明细
 *  最低保障家庭成员信息列表
 *  licb
 */
function redirectPeople(obj, type) {
	var url = "";
	var organCode = obj.parentNode.parentNode.parentNode.cells[0].firstChild.innerHTML; // 行政区划
	//var startTime = document.getElementById("cxsj_q").value;// 起始时间
	//var endTime = document.getElementById("cxsj_z").value;// 起止时间
	var sortType="";//属别
	var pagePath = "/jsp/cams/low/query/lowAreaSort/lowAreaSort_People.jsp";
	if(type == "1") { //央属
		 sortType="10"; 
	} else if(type == "2") { //省属
	     sortType="20"; 
	} else if(type == "3") { //市属
	     sortType="40"; 
	} else if(type == "4") { //县属
	     sortType="50"; 
	} else if(type == "5") { //合计
	     sortType="99"; 
	}
	
	var	url = L5.webPath+pagePath+"?autoQuery=true&query_organCode="+ organCode + "&startTime=" + cxsjq + "&endTime=" + cxsjz+"&sortType="+sortType;
	window.open(url);
}

/**
 *  4-事件处理：点击查询按钮后，页面加载
 *  最低保障家庭成员信息列表
 *  licb
 */		
function showDiv() {
	document.getElementById("reDiv").style.display = "";
    
    var startTime=cxsjq.substring(0,4)+"年"+cxsjq.substring(4,6)+"月"+cxsjq.substring(6,8)+"日";
	var endTime  =cxsjz.substring(0,4)+"年"+cxsjz.substring(4,6)+"月"+cxsjz.substring(6,8)+"日";
    document.getElementById("statisticsTime").innerText =startTime+" 至 "+endTime;
	  
}
/**
 *  5-事件处理：点击查询按钮
 *  最低保障家庭成员信息列表
 *  licb
 */
function query() {
	var cxsj_q = document.getElementById("cxsj_q").value;//查询开始时间起
    var cxsj_z = document.getElementById("cxsj_z").value;//查询结束时间止
    var xzqu = document.getElementById("domicileCode").value;//行政区划
    
    if(cxsj_q=="") {
		L5.Msg.alert("提示","请填写统计起始日期！");
		return;
	}
	if(cxsj_z=="") {
		L5.Msg.alert("提示","请填写统计截止日期！");
		return;
	}
	if(xzqu==""){
	    xzqu=organCode;
	}
	dsNext.setParameter("xzqu", xzqu);
	dsNext.setParameter("cxsjq",cxsj_q);
	dsNext.setParameter("cxsjz",cxsj_z);
	dsNext.load();
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
	var statisticsTime = document.getElementById("statisticsTime").innerText;
	L5.dataset2excel(dsNext, "/jsp/cams/low/query/lowAreaSort/exportPeopleTypeExcel.jsp?statisticsTime="+statisticsTime);
}

/**
 *  8-事件处理：点击地区链接跳转下级明细数据
 *  最低生活保障家庭信息列表
 *  licb
 */
function queryNextLevel(value){
	var xzqu = value.nextSibling.innerHTML;
	if(xzqu==organCode){
		return;
	}

	if(xzqu.substring(9,12)=='000'&& xzqu.substring(6,12)!='000000'){
		return;
	}
	var data = new L5.Map();
    
    
    var xzqu = value.nextSibling.innerHTML;
	data.put("cxsj_q",cxsjq);
	data.put("cxsj_z",cxsjz);
	data.put("xzqu", xzqu);
	data.put("pageflag","1");
	var url = "/jsp/cams/low/query/lowAreaSort/lowAreaSortNextLevel.jsp";
	L5.forward(url, null, data);
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