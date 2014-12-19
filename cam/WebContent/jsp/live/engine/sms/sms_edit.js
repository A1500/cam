var xmlRequestHttp;
var command = new L5.Command("org.loushang.live.engine.view.MessageSendCmd");

function isPhoneNum(s){   
	var patrn=/^[0-9]{11}$/; 
	if (!patrn.exec(s)) 
		return false;  
	return true;  
}

/**
* 事件处理：保存
*/
function msgSave() {
	//验证标题长度
	if(!checkTitle(false)){
		return;
	}
	setCmdParam();
	var method = getParam("method");
	if(method=="detail"){
		command.execute("updateMessage");
	}else{
		command.execute("saveMessage");
	}
	//保存提示
	if (!command.error) {
		L5.Msg.alert("提示","短信保存成功!",function(){
			//关闭窗口
			window.close();	
		});
	}else{
		L5.Msg.alert("错误",command.error);
	}
}
/**
* 事件处理：发送
*/
function sendCmd() {
	if(!checkSendParams()){
		return;
	}
	setCmdParam();
	var method = getParam("method");
	//调用后台验证方法
	command.setParameter("isvalidate" ,	"true");
		if(method=="detail"){
			//通过对象调用LsPlanCommand中的savePlan方法，执行计划查询功能
			command.execute("updateMessage");		
		}else{
			command.execute("sendMessage");	
		}
		//保存提示
		if (!command.error) {
			command.execute("sendById");
			if(!command.error){		
				L5.Msg.alert("提示","短信正在发送!",function(){
				//关闭窗口
				window.close();	
				});
			}		
		}else{
			L5.Msg.alert("错误",command.error);
		}
}


/**
* 事件处理：发送短信 不使用消息队列
*/
function sendServlet() {
	if(!checkSendParams()){
		return;
	}
	setCmdParam();
	command.setParameter("isvalidate" ,	"true");
		var method = getParam("method");
		if(method=="detail"){
			command.execute("updateMessage");					
		}else{
			command.execute("saveMessage");			
		}
		if (!command.error) {
			setParam("method" , "sendById");
			L5.Msg.alert("提示","短信正在发送!",function(){
				//关闭窗口
				document.getElementById("smsForm").submit();
				window.close();
			});		
		}else{
			L5.Msg.alert("错误",command.error);
		}
}
function setCmdParam(){
	checkPhoneNum();
	command.reset();
	command.setParameter("partyInfo" , getParam("partyInfo"));
	command.setParameter("partyName" , getParam("partyName"));
//	command.setParameter("userId" , getParam("userId"));
	command.setParameter("msgType" , getParam("msgType"));
	command.setParameter("msgId" , getParam("msgId"));
	command.setParameter("sendTime" , getParam("sendTime"));
	command.setParameter("title" , getParam("title"));
}

function signSelected(){
	var isSigned = document.getElementById("sign");
	//如果未选中
	if(!isSigned.checked){
		var signature = document.getElementById("signature");
		signature.style.display = "none";
	}else{
		var signText = document.getElementById("signText").value;
		var signature = document.getElementById("signature");
		signature.style.display = "";
		signature.innerHTML = '您当前的签名是:'+ signText +' 已占用了<font color="red">' + signText.length + "</font>个字";
	}
	oninput();
}
//输入检测
function oninput(){
	var countArray = [];
	var topic = getParam("title");
	//选择了使用签名
	var isSigned = document.getElementById("sign");
	//如果选中则加入签名长度
	if(isSigned.checked){
		var signText = getParam("signText");
		topic += signText; 
	}
	var wordcount = document.getElementById("wordcount");
	var leftwords = document.getElementById("leftwords");
	var smsSizeId = document.getElementById("smssize");
	var sms = "";
	if(topic.length>smslength)
		sms = smscount(smslength , topic , smsSizeId , countArray);
	else{
		sms = topic;
		smsSizeId.style.display = "none";
	}
	if(sms.length <= 300){
		wordcount.innerHTML = "当前已经输入" + sms.length + "字，";
		leftwords.innerHTML = "您还可以输入" + "<font color='red'>" + parseInt(300-sms.length) + "</font>" + "字";
		setParam("smsLength" , sms.length);
	}else{
		//大于300的时候直接截断
		var oldTopic = document.getElementById("title").value;
		//再数一次
		countArray = [];
		sms = smscount(smslength , topic , smsSizeId , countArray);
		var lastLength = 0;
		if(countArray.length)
			lastLength = countArray.pop();
		document.getElementById("title").value = oldTopic.substring(0 , oldTopic.length-(sms.length - 300)+lastLength);
		wordcount.innerHTML = "当前已经输入" + 300 + "字，";
		leftwords.innerHTML = "您还可以输入" + "<font color='red'>" + 0 + "</font>" + "字";
		setParam("smsLength" ,  300);
	}
}

//短信条数计算
//countArray保存每个分隔符的长度
function smscount(len , topic , smsSizeId , countArray){
	var smsSend = ""; 
	var lenall = topic.length;
	var i = 1;
	var currentIndex = 0;
	var smsCount = 1;
	while (true) {
		if (currentIndex >= lenall) {
			smsCount = i - 1;
			break;
		}
		var lastNumber = len - ((lenall / len) / 10 + 1) - (i / 10 + 1) - 3;
		currentIndex = currentIndex + lastNumber;
		i++;
	}
	i = 1;
	currentIndex = 0;
	while (true) {
		if (currentIndex >= lenall) {
			break;
		}
		var sms = "";
		sms += "(" + i + "/" + smsCount + ")";
		countArray.push(("(" + i + "/" + smsCount + ")").length);
		var lastNumber = len - ((lenall / len) / 10 + 1) - (i / 10 + 1) - 3;
		if (currentIndex + lastNumber <= lenall) {
			sms += topic.substring(currentIndex, currentIndex + lastNumber);
		} else {
			sms += topic.substring(currentIndex, lenall);
		}
		currentIndex = currentIndex + lastNumber;
		smsSend += sms;
		i++;
	}
	smsSizeId.style.display = "";
	smsSizeId.innerHTML = '当前短信将被分作<font color="red">' + parseInt(i-1) + '</font>条发出';
	return smsSend;	
}
//处理插入常用短语事件
function phrasesChange(){
	var phrases = document.getElementById("phrases");
	var text = "";
	if(phrases.value != "")
		text = phrases.options[phrases.selectedIndex].text;
	//在短信内容的最后部分添加常用短语
	var title = document.getElementById("title");
	title.value += text;
	//设置常用短语默认
	phrases.selectedIndex = "";
	oninput();
}