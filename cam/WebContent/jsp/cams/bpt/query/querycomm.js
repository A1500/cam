var state = "2"; //默认状态
var startTimeId = "cxsj_qs"; //默认起始时间id
var endTimeId = "cxsj_zs";//  默认终止时间id
var endTime_z = "cxsj_z";//默认截止时间id
var timeType="2"; //默认批准时间方式为截止时间
var startTime=""; //起始时间
var endTime="";  //截止时间
var queryPage = false; //是否为二级页面（即从查询页面点击对应市县跳转的页面）
var urlPage = "../query_basicInfoList.jsp";
/**
 * 定义与DIC_BPT_OBJECTTYPE对应的js数组
 * @type 
 */
var objectTypeArray = [[1,'伤残'],[2,'三属'],[5,'参战'],[6,'参试'],[8,'60周岁以上农村籍退役士兵'],['B','部分烈士(错杀被平反)子女'],
[11,'残疾军人'],[12,'伤残国家机关工作人员'],[13,'伤残人民警察'],[14,'伤残民兵民工'],
[15,'因战因公伤残人员'],[21,'烈士家属'],[22,'因公牺牲军人家属'],[23,'病故军人家属'],
[41,'在乡复员军人'],[42,'带病回乡复员军人'],[81,'60周岁以上农村籍退役士兵'],['B1','部分烈士(错杀被平反)子女']];

/**
 * 根据value值从js数组中取出value对应的值
 * @param {} value
 */
function getNameFromArray(value) {
	var columnCount = objectTypeArray.length;// 第二维长度
	for(var i=0;i<columnCount;i++) {
		if(objectTypeArray[i][0] == value) {
			return objectTypeArray[i][1]; //返回对应的值
		}
	}
}

/**
 * 点击对应的查询统计人数跳转优抚基本信息页面（带有查询条件）
 * @param {} obj        触发此方法的对象（obj为触发方法的标签外围的td对象）
 * @param {} objectType 优抚对象类别 
 * @param {} type   	参试类别（或其它类别标示）
 */
function redirectQuery(obj,objectType,type) {
	var objectName=""; //优抚对象类别对应的名称
	if(objectType.indexOf(",") != -1) { //优抚对象类别为多个时采用','分割
		var objectTypeTemp = objectType.split(",");
		for(var i=0;i<objectTypeTemp.length;i++) {
			if(i == objectTypeTemp.length - 1) { //
				objectName += getNameFromArray(objectTypeTemp[i]);
			} else {
				objectName += getNameFromArray(objectTypeTemp[i])+",";
			}
		}
	} else {
		objectName = getNameFromArray(objectType);
	}
	if(!queryPage) { // 非二级页面，截止时间或开始时间从页面id获取，若为二级页面，则时间为从前台传入
		if(timeType == "1") {
			if(startTimeId != null && startTimeId != "") {
				startTime = document.getElementById(startTimeId).value;
			}
			if(endTimeId != null && endTimeId != "") {
				endTime = document.getElementById(endTimeId).value;
			}
		} else if(timeType == "2") {
			if(endTime_z != null && endTime_z != "") {
				endTime = document.getElementById(endTime_z).value;
			}
		}
	}	
	
	var domicode = getOrganCode(obj);
	var url = urlPage+"?autoQuery=true&objectType="+objectType+
	"&objectName="+escape(encodeURIComponent(objectName)) + "&state=" + state + 
	"&timeType=" + timeType + "&endTime="+endTime+
	"&organCode="+domicode;
	if(timeType == "1") {
		url += "&startTime=" + startTime;
	}
	if(type != null && type != "") {
		//type = sipQueryParam(type);
		url += "&type=" + escape(encodeURIComponent(type));
	}
	window.open(url);
}

/**
 * 拼装查询条件
 * @param {} type
 */
function sipQueryParam(type) {
	var result = "";
	var keyValue = "";
	if(type.indexOf(":") != -1) {
		if(type.indexOf(",") != -1) {
			var querys = type.split(",");
			for(var i=0;i<querys.length;i++) {
				var keyVal = querys[i];
				keyValue = keyVal.split(":");
				result = keyValue[0] + "=" + keyValue[1];
				if(i != querys.length-1) {
					result +=",";
				}
			}
		} else {
			keyValue = type.split(":");
			result = keyValue[0] + "=" + keyValue[1];
		}
	} else {
		result = type;
	}
	return result;
}

/**
 * 取的行政区划（采用在表格每一行的第一列隐藏保存行政区划code）
 * @param {} obj
 */
function getOrganCode(obj) {
	return obj.parentNode.cells[0].firstChild.innerHTML;
}


/**
 * 伤残查询统计链接查询页面
 * @param {} obj
 * @param {} level伤残等级
 * @param {} discase伤残性质
 * @param {} genusCode伤残属别
 */
function redirectQuery_dis(obj,level,discase,genusCode) {
	var levelId = "disabilityLevelCode";
	var levelNameId = "disabilityLevelCodeName";
	var disCaseId = "disabilityCaseCode";
	var genusCodeId = "disabilityGenusCode";
	var levelName = "";
	if(level == "01") {
		levelName = "一级";
	} else if(level == "02") {
		levelName = "二级";
	} else if(level == "03") {
		levelName = "三级";
	} else if(level == "04") {
		levelName = "四级";
	} else if(level == "05") {
		levelName = "五级";
	} else if(level == "06") {
		levelName = "六级";
	} else if(level == "07") {
		levelName = "七级";
	} else if(level == "08") {
		levelName = "八级";
	} else if(level == "09") {
		levelName = "九级";
	} else if(level == "10") {
		levelName = "十级";
	}
	var type = "disabilityLevelCode="+level+",disabilityLevelCodeName="+levelName
	+ ",disabilityCaseCode="+discase;
	if(genusCode != null && genusCode != "") {
		type +=",disabilityGenusCode="+genusCode;
	}
	if(level == "00") { //全部
		redirectQuery(obj.parentNode.parentNode,'1');
	} else {
		redirectQuery(obj.parentNode.parentNode,'1',type);
	}
}

