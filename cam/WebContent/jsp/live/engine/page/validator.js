var Validator = {
	//发送时间
	dateTime: function(dateTime){
		if(dateTime == null || dateTime == "")
			return true;
		if(dateTime == "")
			return "日期格式不符合规范";
		if(dateTime.length != 17)
			return "日期格式不符合规范";
		if(dateTime.substring(8,9) != ' ')
			return "日期格式不符合规范";
		var dateReg = /(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))0229)/;
		var timeReg = /(([01][\d])|([2][0-4]))\:[0-5][\d]\:[0-5][\d]/;
	
		var date = dateTime.substring(0,9);
		if(!date.match(dateReg))
			return "日期格式不符合规范";
		var time = dateTime.substring(9,18);
		if(!time.match(timeReg))
			return "日期格式不符合规范";
   		return true;	
	},
	//主题
	title: function(title , withContent){
		var text = withContent ? "消息主题" : "消息内容";
		if(title==null || title=="")
			return text+"不能为空";
		var status = L5.Validator["lengthUTF8"](title , null , 1024)
		if(status != true){
			return text+status;
		}
		return true;
	},
	//收件人
	partyName: function(partyName){
		if(partyName==null || partyName=="")
			return "收件人不能为空";
			//这里验证是否具有特殊字符
		if(partyName.indexOf("'") != -1)
	 		return "收件人包含特殊字符";
		if(partyName.indexOf("=") != -1)
	 		return "收件人包含特殊字符";
		if(partyName == "~")
			return "收件人包含特殊字符";
		return true; 
	},
	//根据正则判断是否符合当前消息类型的联系方式格式
	regex: function(value , regx){
		if(regx==null)
			return true;
		var pattern = new RegExp(regx);
		var isValidate = pattern.test(value);
		if (isValidate == false){
			return false;
		}	
		return true;
	}
} 
//检测输入
function setPartyInfo(){
	var msgType = getParam("msgType");
	var partyName = getParam("partyName");
	var partyInfo = getParam("partyInfo");
	//去掉最后一个“;”传到后台
	if(partyInfo!=""){
		if(partyInfo.substring(partyInfo.length-1,partyInfo.length)==";"){
			partyInfo = partyInfo.substring(0,partyInfo.length-1);
		}	
	}	
	//去掉最后一个“;”传到后台
	if(partyName.substring(partyName.length-1,partyName.length)==";"){
		partyName = partyName.substring(0,partyName.length-1);
	}
	//拼装partyInfo
	var partyNames =  partyName.split(";");
	var partyInfos = partyInfo.split(";");
	//用来保存最后拼装好的partyInfo
	var finalInfos = "";
	for(var i=0; i<partyNames.length; i++){
		if(partyInfo != ""){
			for(var j=0; j<partyInfos.length; j++){
				var nameInfos = partyInfos[j].split(",");
				if(nameInfos[1] == partyNames[i])
					break;
			}
			//没有查到partyInfo则为手输
			if(j == partyInfos.length){
				if(DeliveryMode[msgType].regx){
					if(!Validator.regex(partyNames[i] , DeliveryMode[msgType].regx)){
						finalInfos += partyNames[i] + "," + partyNames[i] + "," + "i" +";";
					}else{
						finalInfos += partyNames[i] + "," + partyNames[i] + "," + "d" +";";
					}
				}else{
					finalInfos += partyNames[i] + "," + partyNames[i] + "," + "i" +";";
				}
			}else{
				finalInfos += partyInfos[j]+";";
			}
		}else{
			//全是手输
			if(DeliveryMode[msgType].regx){
				if(!Validator.regex(partyNames[i] , DeliveryMode[msgType].regx)){
					finalInfos += partyNames[i] + "," + partyNames[i] + "," + "i" +";";
				}else{
					finalInfos += partyNames[i] + "," + partyNames[i] + "," + "d" +";";
				}
			}else{
				finalInfos += partyNames[i] + "," + partyNames[i] + "," + "i" +";";
			}
		}
	}
	//将过滤后的值放到表单中
	setParam("partyName" , partyName);
	setParam("partyInfo" , finalInfos);
}
