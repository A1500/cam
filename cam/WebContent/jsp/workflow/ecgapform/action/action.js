//路径：jsp/workflow/ecgapform/action/action.js
//调用ActionCmd对应的方法，转向jsp/workflow/ecgapform/action/result.jsp，提示成功

//发起流程，从页面上获取所有表单域和url参数，表单域格式为json，key为formData，value为fieldID:fieldValue,fieldID:fieldValue,……
function create(){
	executeAction("create");	
}

//发起流程并发送，从页面上获取所有表单域，url参数
function createAndSend(){
	executeAction("createAndSend");
}

//发送，从页面上获取所有表单域，url参数
function send(){
	executeAction("send");
}

//跳转，从页面上获取所有表单域，url参数
function jumpSend(){
	executeAction("jumpSend");
}

//创建并选择发送
function createAndSelectAndSend()
{
	executeAction("createAndSelectAndSend");
}

//选择发送
function selectAndSend()
{
	executeAction("selectAndSend");
}

//默认退回
function back(){
	executeAction("back");
}

//跳转退回
function jumpBack(){
	executeAction("jumpBack");
}

//恢复
function resume(){
      executeAction("resume");
     }
//撤销
function revoke(){
	   executeAction("revoke");
}

//挂起
function suspend(){
  executeAction("suspend");
}

//终止
function terminate(){
   executeAction("terminate");
}

//跳转到结果页面
function forwardToResult(message){
	var url="jsp/workflow/ecgapform/action/result.jsp?message="+message;
	url=encodeURI(url);
	url=encodeURI(url);
	L5.forward(url,"任务处理结果");
}

//最终要执行的方法
function resetMethod(method)
{
	if(method=="createAndSelectAndSend")
	{
		return "createAndSend";
	}
	if(method=="selectAndSend")
	{
		return "send";
	}
	return method;
}

//执行操作
function executeAction(method)
{   
	//执行之前首先检查流程状态
	//checkProcessState根据URl是否含有assignmentId以及执行的方法名（method的值）判断该方法是否可以执行
	//如果含有assignmentId那么说明该流程已经创建，那么create，createAndSend，createAndSelectAndSend三个方法是不能执行的
	//如果不含assignmentId那么说明流程还没创建，那么只有create，createAndSend，createAndSelectAndSend三个方法是可以执行的
	if(checkProcessState(method))
	{
		//如果可以执行方法，则要检查表单数据是否是有效的，如果无效则不继续执行
	    if(!check(document.forms[0])){
			return;
		}
	    //如果表单数据是有效的，那么首先将要执行的js函数名转换为后台对应的方法名，
	    //js执行的createAndSelectAndSend后台需要执行createAndSend，js执行的selectAndSend后台需要执行send
	    //其他方法则同后台相对应
		var runMethod=resetMethod(method);
		//将表单数据转换为json数据格式
		var jsonObj=formToJsonObject(document.forms[0]);
		for(var j=1;j<document.forms.length;j++){
			var jsonObjothers = formToJsonObject(document.forms[j]);
			var formId = document.forms[j].id;
			jsonObj.put(formId,jsonObjothers);
		}
		
		//选择发送方式，如果只有一个环节，并且该环节只有一个处理人那么直接发送，
		//否则弹出通用帮助框，用户选择完成确定后获得用户选中的数据，然后将数据作为参数传递到	executeSend方法中执行发送
		if(hasNoChoice(method))
		{
			//如果没有选择，分为两种情况
			//	1.通过判断得到了直接发送的结果，那么表示要发送到的环节只有一个，并且该环节的参与者只有一个，那么将环节信息和参与者信息放到数组中
			//		调用执行方法执行操作
			//	2.如果通过方法名称可以直接判断出直接发送那么不对url信息增加环节信息和参与者信息
			var urlDataJsonString=null;
			try{
				var actInfo=[];
				actInfo[0]=activityList.get(0).get("actDefId");
				actInfo[1]="";
//				actInfo[2]=getJsonFromParticipantList();
				actInfo[2]="";
				//将发送条件和Url中的参数值拼装在一起
				urlDataJsonString=getUrlData(actInfo);
			}
			catch(e)
			{
				urlDataJsonString=getUrlData(null);
			}
			//将后台需要执行的方法，表单的内容以及url中的数据内容发送到executeSend方法执行调用
			executeSend(runMethod,jsonObj,urlDataJsonString);
			return;
		}
		if(activityList.size()<=0)
		{
			if(method=="jumpBack")
			{
				alert("没有可以退回到的环节！");
			}
			return;
		}
		var dialogurl=getUrlContext()+"jsp/workflow/ecgapform/help/selectactivityAndemployee.jsp?"+document.URL.split("?")[1];
		var ret=showModalDialog(dialogurl,window,"dialogWidth:700px;dialogHeight:410px;dialogLeft:250;dialogTop:150;help:no;status:no;scroll:yes;resizable:no");
		if(ret==null||ret==undefined)
		{
			return;
		}
		else
		{
			//将发送条件和Url中的参数值拼装在一起
			var urlDataJsonString=getUrlData(ret);
			//将后台需要执行的方法，表单的内容以及url中的数据内容发送到executeSend方法执行调用
			executeSend(runMethod,jsonObj,urlDataJsonString);
		}
	}
}

//执行发送操作
function executeSend(method,jsonObj,urlDataJsonString)
{
	var command=new L5.Command("org.loushang.workflow.ecgapform.action.cmd.ActionCmd");
//	给cmd中的发送方法传递 assignmentId
//	if(method=="send"){command.setParameter("assignmentId",ASSIGNMENTID);}
	command.setParameter("formData",jsonObj);
	command.setParameter("urlData",urlDataJsonString);
	command.execute(method);	
	if (!command.error) {
		var message=command.getReturn("message");
//		var assignmentId=command.getReturn("assignmentId");
		//给ASSIGNMENTID赋值，方法为创建时禁止跳转页面
//		if(method=="create"){
//			ASSIGNMENTID=assignmentId;
//		}
//		if(method!="create")
	    forwardToResult(message);
	}else{
		alert(command.error);
	}
}

//获得url域
//url格式为http://www.xxx.com?x=x&y=y?&z=z
//该方法首先以？为分隔符将url分为两部分，获取后面的部分x=x&y=y?&z=z;
//然后将后面部分的=替换为：，将&替换为,，替换后的字符串为x:x,y:y,z:z
//如果ret中含有用户从通用帮助框中选择的信息，那么将当前的actDefId替换为相应的信息并把actDefId的键值改为nextActDefId
function getUrlData(ret){
	var urlDataString=document.URL.split("?")[1];
	//将field=value&field=value&....中的=替换为：其中的&替换为,
	var urlDataString=urlDataString.replace(/=/g,":").replace(/&/g,",");
	//如果用户通过通用帮助框选择了相应信息，那么将用户选择的条件加到URL参数串中
	if(ret!=null&&ret!=undefined)
	{
		urlDataString="nextActDefId:"+ret[0]+","+ret[2]+","+urlDataString;
	}
	//给字符串加上json的开始结束字符
	var urlJsonString="{"+urlDataString+"}";
	return urlJsonString;		
}
//将参与者列表拼装成json字符串并返回
function getJsonFromParticipantList()
{
	var participants="nextActOrgans:[";
	participants+="{organId:"+participantList.get(0).get("organId")+"#organName:"+participantList.get(0).get("organName")+"}";
	participants+="]";
	return participants;
}
//检查流程状态
function checkProcessState(method){
	var urlDataString=document.URL.split("?")[1];
	var dataArr=urlDataString.split("&");
	var hasAssignmentId=false;
	for(i=0;i<dataArr.length;i++)
	{
		var data=dataArr[i].split("=");
//		if(data[0]=="assignmentId"||ASSIGNMENTID!=null)
		if(data[0]=="assignmentId")
		{
			if(method=="create"||method=="createAndSend"||method=="createAndSelectAndSend")
			{
				alert("该流程已经创建！");
				return false;
			}
			hasAssignmentId=true;
		}
	}
	if(!hasAssignmentId)
	{
		if(method!="create"&&method!="createAndSend"&&method!="createAndSelectAndSend")
		{
			alert("该流程还没有创建！请先创建流程！");
			return false;
		}
	}
	return true;
}
//按钮依赖时页面不跳转从cmd获取assignmentId
var ASSIGNMENTID;
//全局变量，环节列表
var activityList;
//全局变量，参与者列表
var participantList;
//全局变量，页面url参数数组
var paramsArray=[];
//全局变量，需要调用的方法名，查询环节调用的
var methodName;
//判断是否直接发送，如果只有一个环节，并且该环节只有一个处理人那么返回ture
//1.方法首先排除不需要判断的方法：createAndSend，send，create，back，revoke，suspend，terminate，这些方法直接执行
//2.如果方法需要判断，那么首先将url中的参数以？作为分隔符，取后面的部分，将x=x?y=y?z=z拆分成[[x,x],[y,y],[z,z]]的数组
//3.然后根据js方法判断后台需要执行什么方法来返回信息，
//		如果是createAndSelectAndSend、selectAndSend那么调用getNextActivityDefList
//		如果是jumpSend调用getAllActivityDefList
//		如果是jumpBack，调用getHistoryActivityDefListByAssignmentId
//4.根据前面判断的方法加载环节信息
//5.首先判断是否是结束环节，如果是那么直接发送，如果不是那么如果下一环节数大于1那么需要选择，否则继续判断
//6.加载参与者信息，如果参与者多于一个那么需要用户选择，否则不需要
function hasNoChoice(method){
	//排除不需要判断的方法，这些方法直接执行就行
	if(method=="createAndSend"||method=="send"||method=="create"||method=="back"||method=="revoke"||method=="suspend"||method=="terminate"||method=="resume")
	{
		return true;
	}
	//初始化查询条件信息
	setParamsArray();
	//初始化方法信息
	setMethodName(method);
	//加载环节列表
	loadActivity();
	//1.为结束环节
	if(methodName=="getNextActivityDefList"&&activityList.size()==0)
	{
		return true;
	}
	//2.后续环节多余一个
	if(activityList.size()>1)
	{
		return false;
	}
	//3.没有后续环节
	if(activityList.size()<=0)
	{
		return false;
	}
	loadParticipant();
	if(participantList.size()>1)
	{
		return false;
	}
	return true;
}

//获得应用程序上下文
function getUrlContext()
{
	var url=document.URL.split("?")[0];
	var temp="";
	var prefix="";
	if(url.indexOf("http://")!=-1){
		prefix="http://";
		url=url.replace("http://","");
		temp=url.split("/");
	}else if(url.indexOf("https://")!=-1){
		prefix="https://";
		url=url.replace("https://","");
		temp=url.split("/");
	}
	return prefix+temp[0]+"/"+temp[1]+"/";
}

//加载环节信息，methodName为cmd需要调用的方法名，paramsArray为查询参数的数组，结构为[["name",value],["name",value].....]
function loadActivity()
{
	//查询环节
	var command=new L5.Command("org.loushang.workflow.tasklist.help.cmd.TaskHelpCmd"); 
	//如果查询条件不为空那么将查询条件设置到command中
	if(paramsArray!=undefined)
	{
		for(i=0;i<paramsArray.length;i++)
		{
			//paramsArray[i][0]为查询字段名，paramsArray[i][1]为查询字段值，分别对应之前数组元素中的name,value
			command.setParameter(paramsArray[i][0],paramsArray[i][1] );
		}
	}
	command.execute(methodName);
	if (!command.error) {
		activityList=command.getReturn("result");	
	}else{
		alert(command.error);
	}
}

//加载参与者信息
function loadParticipant()
{
	//初始化command信息	
	var command=new L5.Command("org.loushang.workflow.tasklist.help.cmd.TaskHelpCmd"); 
	command.setParameter("curActDefUniqueId", getActDefUniqueId());
	//如果查询条件不为空那么将查询条件设置到command中
	if(paramsArray!=undefined)
	{
		for(i=0;i<paramsArray.length;i++)
		{
			//paramsArray[i][0]为查询字段名，paramsArray[i][1]为查询字段值，分别对应之前数组元素中的name,value
			command.setParameter(paramsArray[i][0],paramsArray[i][1] );
		}
	}
	command.execute("getActivityDefEmployeeList");
	if (!command.error) {
		participantList=command.getReturn("result");
	}else{
		alert(command.error);
	}
}
//获得commad需要执行的方法参数，该参数通过查询页面传入
//返回值为数组，结构为：[["name",value],["name",value].....]
function setParamsArray()
{
	//从URL中获取相关参数，并设置到command中
	var urlString=document.URL.split("?")[1];
	var urlParams=urlString.split("&");
	for(i=0;i<urlParams.length;i++)
	{
		var temp=urlParams[i].split("=");
		paramsArray[i]=[temp[0],temp[1]];
	}
}

//获得commad需要执行的方法名，该参数通过查询页面传入
function setMethodName(method)
{
	if(method=="createAndSelectAndSend"||method=="selectAndSend")
	{
		methodName="getNextActivityDefList";
		return ;
	}
	if(method=="jumpSend")
	{
		methodName="getAllActivityDefList";
		return;
	}
	if(method=="jumpBack")
	{
		methodName="getHistoryActivityDefListByAssignmentId";
		return;
	}
	if(method=="resume")
	{
		methodName="resume";
		return;
	}
}

//获得环节定义唯一ID
function getActDefUniqueId(){
	
    if(activityList.size()>0)
	{
		var rcd=activityList.get(0);
		return rcd.get("actDefUniqueId");
	}
	return null;
}

