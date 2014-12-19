//获取页面输入域值，并对空进行处理
function getParam(ElementId){
	var value=document.getElementById(ElementId).value;
	return value;
}
//设置页面属性的值
function setParam(ElementId , value){
	document.getElementById(ElementId).value = value;
}
function checkDate(date){
	if(date == "")
		return true;
	if(date.length != 8)
		return false;
	var dateReg = /(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))0229)/;
	if(!date.match(dateReg))
		return false;
	return true;
}
//用于验证发送时间格式
//通过验证true
//验证失败false
function checkDateTime(dateTime){
	if(dateTime == "")
		return true;
	if(dateTime.length != 17)
		return false;
	if(dateTime.substring(8,9) != ' ')
		return false;
	var dateReg = /(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))0229)/;
	var timeReg = /(([01][\d])|([2][0-4]))\:[0-5][\d]\:[0-5][\d]/;
	
	var date = dateTime.substring(0,9);
	if(!date.match(dateReg))
		return false;
	var time = dateTime.substring(9,18);
	if(!time.match(timeReg))
		return false;
    return true;	
}
//用于验证收件人输入合法
//通过验证true
//验证失败false
function checkPartyName(partyName){
	//这里验证是否具有特殊字符
	if(partyName.indexOf("'") != -1)
	 	return false;
	if(partyName.indexOf("=") != -1)
	 	return false;
	if(partyName == "~")
		return false;	
	 return true;
}
//建立ajax请求
function GetXmlHttpObject()
{
	var xmlHttp=null;
  	try
	{
    	// Firefox, Opera 8.0+, Safari
    	xmlHttp=new XMLHttpRequest();
    }catch (e){
    	// Internet Explorer
    	try
      	{
      		xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
      	}catch (e){
      		xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      	}
    }
  	return xmlHttp;
}
//异步验证信息
function checkUserInfo(){
	xmlRequestHttp = GetXmlHttpObject();
	if(!xmlRequestHttp)
		return;
	//设置参数 当前只验证收件人信息partyname , partyInfo , msgType
	var partyName = document.getElementById("partyName").value;
	var partyInfo = document.getElementById("partyInfo").value;
	var msgType = document.getElementById("msgType").value;
	var sendTime = document.getElementById("sendTime").value;
	
	var url = L5.webPath+"/MessageSender?";
	url += "partyName=" +  partyName;
	url += "&partyInfo=" + partyInfo;
	url += "&msgType=" + msgType;
	url += "&sendTime=" + sendTime;
	url += "&method=checkMessageInfo";
	
	url += "&"+ new Date().getTime();
	xmlRequestHttp.onreadystatechange=getCheckResult;
	xmlRequestHttp.open("GET" , url , true);
	xmlRequestHttp.send(null);	
}


/**
* 事件处理：显示联系人列表
*/
function queryParty(){
	if(window.partyWndExist)
		return;
	var url =  "../party/frame.jsp";
	var params = "height=400px,width=530px,resizable=no,scrollbars=yes,top="+(screen.height-400)/2 + "px,left=" + (screen.width-530)/2 + "px";
	window.partyWndExist = true;
	window.open(url , "" , params);
}
//下载选中
function downloadByUuids(uuids){
	//alert(url);
	var elemIF = document.createElement("iframe");
	elemIF.src = L5.webPath+"/UploadServlet?method=downloadall&uuids="+uuids;
	elemIF.style.display = "none";
	document.body.appendChild(elemIF);
	//window.open(url);
}
//下载单个附件
function downloadAtt(fileID){
	var url = document.getElementById("realurl").value + "/UploadServlet?method=download&uuid="+fileID;
	var elemIF = document.createElement("iframe");   
	elemIF.src = url;   
	elemIF.style.display = "none";   
	document.body.appendChild(elemIF);
}

/**
*弹窗公共方法open方式
*url 窗口地址
*title 窗口标题
*width,height定义窗口大小,如果都是数字则参数设置有效
*reload bool值是否刷新父窗口
*msgType表示消息类型，根据消息类型控制弹窗的大小
*isDetail是否是明细 因为明细页面的窗口大小与编辑的窗口大小不一致
*/
function showWindow(url , title , msgType , reload , isDetail , width , height){
	var params = "resizable=no,scrollbars=yes,";
	var wndWidth = parseInt(width);
	var wndHeight = parseInt(height);
	//数字非法则使用默认值
	if(isNaN(wndWidth) || isNaN(wndHeight)){
		if(isDetail){
			switch(msgType){
				case 's':
				case 'm':
					wndHeight = 230;
					wndWidth = 700;
					break;
				case 'w':
				case 'e':
					wndWidth = 700;
					wndHeight = 500;
					break;
					break;
				default:
					wndHeight = 380;
					wndWidth = 700;
					break;			
			}
		}else{
			switch(msgType){
				case 's':
					wndWidth = 700;
					wndHeight = 330;
					break;
				case 'm':
					wndWidth = 700;
					wndHeight = 500;
					break;
				case 'w':					
				case 'e':
					wndWidth = 700;
					wndHeight = 600;
					break;	
				default:
					wndWidth = 700;
					wndHeight = 380;
					break;
			}
		}
	}//设置窗口大小结束
	params += "height="+wndHeight+"px,width="+wndWidth;
	params += "px,top=" +(screen.height-wndHeight)/2 + "px,left=" + (screen.width-wndWidth)/2 + "px;";
	//通过参数设置是否需要刷新父窗口
	//if(title)
	//	url += "&title="+ encodeURI(title);
	if(reload)
		url += "&reload=true";	
	//var encodeUrl = encodeURI(url);
//	alert(encodeUrl);
	return window.open(url , "" , params);
}

//处理邮件的转发
function handleForward(msgId , msgType){
	var command = new L5.Command("org.loushang.live.engine.view.MessageSendCmd");
	command.setParameter("msgId" , msgId);
	command.setParameter("msgType" , msgType);
//	var sender = getParam("userId");
//	command.setParameter("userId" , sender);
	command.execute("copyMail");
	if (!command.error) {	
		var newMsgId = command.getReturn("newMsgId");
		return newMsgId;
	}else{
		L5.Msg.alert('提示',command.error);
		return null;
	}
}

//处理发送结果状态
function sendStatus(){
	if(xmlRequestHttp.readyState == 4){
		if(xmlRequestHttp.responseText != ""){
			L5.Msg.alert("错误" , xmlRequestHttp.responseText);
		}else{
			L5.Msg.alert("提示" , "消息正在发送!");
		}
	}
			
}


//验证参数并设置表单数据
function checkSendParams(){
	var partyName = getParam("partyName");
	var msgType = getParam("msgType");
 	//收件人
	if(getParam("partyName") == ""){
		L5.Msg.alert("提示" , "收件人不能为空！");
		return false;
	}
	if(!checkPartyName(partyName)){
		L5.Msg.alert("提示" , "收件人包含特殊字符!");
		return false;
	}
	//验证收件人详细信息
	if(msgType == "e"){
		checkEmailAddr();
	}else if(msgType == "s"){
		checkPhoneNum();
	}else{
		checkInput();
	}
	//验证主题
	if(!checkTitle(true)){
		return false;
	}	
	if(msgType == 's' || msgType == 'e' || msgType =='w'){
		if(!checkDateTime(getParam("sendTime")))
		{
			L5.Msg.alert("提示" , "发送时间格式有误!");
			return false;
		}	
	}	
	return true;
}

//检测email的地址合法
function checkEmailAddr(){
	var partyName = getParam("partyName");
	var partyInfo = getParam("partyInfo");
	//去掉最后一个;
	if(partyInfo!=""){
		if(partyInfo.substring(partyInfo.length-1 , partyInfo.length)==";"){
			partyInfo = partyInfo.substring(0 , partyInfo.length-1);
		}	
	}
	if(partyName.substring(partyName.length-1,partyName.length)==";"){
		partyName = partyName.substring(0 , partyName.length-1);
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
				if(!isEmailAddr(partyNames[i])){
					finalInfos += partyNames[i] + "," + partyNames[i] + "," + "i" +";";
				}else{
					finalInfos += partyNames[i] + "," + partyNames[i] + "," + "e" +";";
				}
			}else{
				finalInfos += partyInfos[j]+";";
			}
		}else{
			//全是手输
			if(!isEmailAddr(partyNames[i])){
				finalInfos += partyNames[i] + "," + partyNames[i] + "," + "i" +";";
			}else{
				finalInfos += partyNames[i] + "," + partyNames[i] + "," + "e" +";";
			}
		}
	}
	//将过滤后的值放到表单中
	setParam("partyName" , partyName);
	setParam("partyInfo" , finalInfos);
}
//检测电话号码合法
function checkPhoneNum(){
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
				if(!isPhoneNum(partyNames[i])){
					finalInfos += partyNames[i] + "," + partyNames[i] + "," + "i" +";";
				}else{
					finalInfos += partyNames[i] + "," + partyNames[i] + "," + "s" +";";
				}
			}else{
				finalInfos += partyInfos[j]+";";
			}
		}else{
			//全是手输
			if(!isPhoneNum(partyNames[i])){
				finalInfos += partyNames[i] + "," + partyNames[i] + "," + "i" +";";
			}else{
				finalInfos += partyNames[i] + "," + partyNames[i] + "," + "s" +";";
			}
		}	
	}//for
	//将过滤后的值放到表单中
	setParam("partyName" , partyName);
	setParam("partyInfo" , finalInfos);
}
//检测输入
function checkInput(){
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
				finalInfos += partyNames[i] + "," + partyNames[i] + "," + "i" +";";
			}else{
				finalInfos += partyInfos[j]+";";
			}
		}else{
			//全是手输
			finalInfos += partyNames[i] + "," + partyNames[i] + "," + "i" +";";
		}
	}
	//将过滤后的值放到表单中
	setParam("partyName" , partyName);
	setParam("partyInfo" , finalInfos);
}

//验证主题
//sendMark表示发送操作 true
function checkTitle(sendMark){
	var msgType = getParam("msgType");
	//验证主题
	if(msgType == 'w' || msgType == 'e'){
		if(getParam("title") == "" && sendMark){
			L5.Msg.alert("提示" , "邮件主题不能为空!");
			return false;
		}
		if(getInputLength(getParam("title")) > 1024){
			L5.Msg.alert("提示" , "邮件主题超长!");
			return false;
		}
	}else if(msgType == 'm'){
		if(CKEDITOR.instances.htmlEditor.getData() == ""  && sendMark){
			L5.Msg.alert("提示" , "消息内容不能为空!");
			return false;
		}
		if(CKEDITOR.instances.htmlEditor.getData().length > 300){
			L5.Msg.alert("错误" , "站内消息内容长度大于300请修改消息内容!");
			return false;
		}
	}else if(msgType == 's'){
		var smsContent = getParam("title");
		if(smsContent == "" &&　sendMark){
			L5.Msg.alert("提示" , "短信内容不能为空!");
			return false;
		}
		if(getParam("smsLength") > 300){
			L5.Msg.alert("错误" , "短信内容长度大于300请修改短信内容!");
			return false;
		}	
		var isSigned = document.getElementById("sign");
		if(isSigned.checked){
			var uName = getParam("signText");
			smsContent += uName; 
		}
		setParam("title" , smsContent);
	}
	return true;
}
/**
* 验证前台输入的字符长度（中文算3位）
*/
function getInputLength(str){
	if(str.length != 0){
		var characterReg =  /[^\x00-\xff]/g;
		var character = str.match(characterReg);
		var length = 0;
		if(character){
			length = character.length * 3;
			length += str.replace(characterReg , "").length;
		}else{
			length = str.length;
		}	
		return length;
	}else{
		return 0;
	}	
}

