//手动输入时间格式 
var temp1 = -1;
//获取当前时间
var currentDate = new Date();
var current;
function changeDateStyle(obj) {
	var temp = obj.value;
	var arr = temp.split("-");
	if (temp1<obj.value.length) {
		if(temp!=""&&temp.length == 4) {
			obj.value = temp + '-';
		} else if (obj.value.length == 8 && obj.value.split("-").length == 2) {
			obj.value = obj.value.substr(0,7)+'-'+ obj.value.substr(7,1);
		} else if (temp!=""&&temp.length==7) {
			obj.value = temp + '-';
		} else if (obj.value.length == 5 && obj.value.indexOf("-") == -1) {
			obj.value = obj.value.substr(0,4)+'-'+ obj.value.substr(4,1);
		} else if(obj.value.length ==11 && obj.value.indexOf(" ") == -1) {
			obj.value = obj.value.substr(0,10)+' '+ obj.value.substr(10,1);		
		} else if(obj.value.length ==14 && obj.value.indexOf("：") == -1) {
			obj.value = obj.value.substr(0,13)+':'+ obj.value.substr(13,1);		
		} 
	}
	temp1 = obj.value.length;
//	if(temp1==10){
//		check(obj) ;
//	}
//	else if(temp1<10&&temp1>0){
//		if(obj.value){
//			var aa="0000-01-01" +
//					"".substr(temp1,9);
//			obj.value=obj.value+aa;
//		}
//	}
}

//验证时间
function checktime(obj) {
	current =formatHi(currentDate);
	var time = obj.value;
	if(time!='' && time.length<16){
		time += current.substring(time.length);
	}
	if(time!=''){
		if(!validateDateFormat(time)) {
			L5.Msg.alert("提示","时间格式不正确!");
			obj.value = "";
			return false;
		}else {
			obj.value = time;
			return false;
		}
	}
	
	function validateDateFormat(date){
		if (!((/^[0-9]{4}-(((0[13578]|(10|12))-(0[1-9]|[1-2][0-9]|3[0-1]))|(02-(0[1-9]|[1-2][0-9]))|((0[469]|11)-(0[1-9]|[1-2][0-9]|30)))\s(([1-9]{1})|([0-1][0-9])|([1-2][0-3])):([0-5][0-9])$/).test(date))) {
			return false;
		}
		
		var r = date.match(/\d{1,4}/g);
		if (r == null) {
			return false;
		};
		var d = new Date(r[0], r[1] - 1, r[2]);
		return (d.getFullYear() == r[0] && (d.getMonth() + 1) == r[1] && d.getDate() == r[2]);	
	}
}

//无时间验证
function check(obj) {
	current =format(currentDate);
	var time = obj.value;
	if(time!='' && time.length<10){
		time += current.substring(time.length);
	}
	if(time!=''){
		if(!validateDateFormat(time)) {
			L5.Msg.alert("提示","时间格式不正确!");
			obj.value = "";
			return false;
		}else {
			obj.value = time;
			return false;
		}
	}
	
	function validateDateFormat(date) {
		if (!((/^[0-9]{4}-(((0[13578]|(10|12))-(0[1-9]|[1-2][0-9]|3[0-1]))|(02-(0[1-9]|[1-2][0-9]))|((0[469]|11)-(0[1-9]|[1-2][0-9]|30)))$/).test(date))) {
			return false;
		}
		var r = date.match(/\d{1,4}/g);
		if (r == null) {
			return false;
		};
		var d = new Date(r[0], r[1] - 1, r[2]);
		return (d.getFullYear() == r[0] && (d.getMonth() + 1) == r[1] && d.getDate() == r[2]);
	}
}
function getTimes(item) {
	LoushangDatetime(item.previousSibling);
}
function getDay(item) {
	LoushangDate(item.previousSibling);
}
//格式化日期YYYY-MM-DD H:I:S
function formatHis(date) {
	return date.getYear()+"-"+((date.getMonth()+1)>9?(date.getMonth()+1):"0"+(date.getMonth()+1))+"-"+(date.getDate()>9?date.getDate():"0"+date.getDate())+" "+date.toLocaleTimeString().substring(0,8);
}

//格式化日期YYYY-MM-DD H:I
function formatHi(date) {
	return date.getYear()+"-"+((date.getMonth()+1)>9?(date.getMonth()+1):"0"+(date.getMonth()+1))+"-"+(date.getDate()>9?date.getDate():"0"+date.getDate())+" "+date.toLocaleTimeString().substring(0,5);
}

//格式化日期YYYY-MM-DD
function format(date) {
	return date.getYear()+"-"+((date.getMonth()+1)>9?(date.getMonth()+1):"0"+(date.getMonth()+1))+"-"+(date.getDate()>9?date.getDate():"0"+date.getDate());
}

/**
 ******************
 * 		公共方法
 ******************
 */
//计算两个时间的间隔
function getTimePoor(startTime,endTime){
	//把时间按"_"切成数组
    var startArr=startTime.split("-");
    var endArr=endTime.split("-");
	//转为毫秒数
    var btime=new Date(startArr[0],startArr[1]-1,startArr[2]);
    var etime=new Date(endArr[0],endArr[1]-1,endArr[2]);
    //计算相差天数
    days=(etime.getTime()-btime.getTime())/(1000*24*60*60);
    return days ;
}

//日期后追加时间 00:00:00
function appendTime2Start(startDate){
	if(startDate)
		return startDate+" 00:00:00";
	return "";
}

//日期后追加时间 23:59:59
function appendTime2End(endDate){
	if(endDate)
		return endDate+" 23:59:59";
	return "";
}


