//判断查询条件是否包含特殊字符
function __isQuoteIn(s)
{
	var re=/\"|\'|\\u201c|\\u201d|\\u2018|\\u2019|\%|\$|\\uffe5|\\u2026\u2026|\\u00b7|\\u2014|\-|\\u2014\u2014|\!|\\uff01|\#|\@|\~|\^|\*|\,|\.|\\uff0c|\\u3002|\?|\\uff1f|\;|\\uff1b|\:|\\uff1a|\{|\}|\\|\/|\[|\]|\(|\)|\+|\-|\\u3001|\||\<|\>/;
	return re.test(s);
}
//验证查询条件
function checkQueryParam(param){
	if(__isQuoteIn(getParam(param))){
		return false;
	}
	else{
		setParam(param , getParam(param).trim());
	}
	return true;	
}

//将邮件移入废件箱
function del() {
		//获取jsp中定义的ID为editGridPanel的EditGridPanel
	var grid  = L5.getCmp("editGridPanel");
	//获取被选中的记录行
	var sm = grid.getSelectionModel();
	var cell = sm.getSelections();
	var ids;
	if(cell==null || cell.length == 0){
		L5.Msg.alert("提示","请选择一条记录");
		return;
	}
	L5.MessageBox.confirm("提示","确认删除所选邮件?",
		function(sta){
			if(sta ==='yes'){
				ids = [];	
				for(var i=0; i<cell.length; i++){					
					ids[i] = cell[i].get("envId");
				}			
				//删除后台的数据
			if(ids.length !==0){
				var command = new L5.Command("org.loushang.live.engine.view.MessageSendCmd");
				//将所有被修改过的Record作为command参数传递给后台command
				command.setParameter("envs", ids);
				//通过对象调用LsPlanCommand中的deletePlan方法，执行计划删除功能
				command.execute("discard");
				if (!command.error) {
					L5.Msg.alert("提示","删除成功!");
					msgDs.setParameter("msgType" , msgType);
//					msgDs.setParameter("userId" , document.getElementById("userId").value);
					msgDs.setParameter("boxType" , document.getElementById("boxType").value);	
					msgDs.load();
					var panel  = L5.getCmp("insertRoot");
					panel.hide();
					var attach = L5.getCmp("attachGridPanel");
					attach.hide();
				}else{
					L5.Msg.alert("错误",command.error);
					return;
				}
			}			
	}});	
}

//按照查询条件查询
function queryMail(s){
	if(s=="in" || s =="trash"){
		if(!checkQueryParam("senderSearch")){
			L5.Msg.alert("错误" , "发件人包含特殊字符");
			return;
		}			
	}else{
		if(!checkQueryParam("partyNameSearch")){
			L5.Msg.alert("错误" , "收件人包含特殊字符");
			return;
		}
	}
	if(!checkQueryParam("titleSearch")){
		L5.Msg.alert("错误" , "主题包含特殊字符");
		return;
	}	
	//验证时间格式
	if(!checkDate(getParam("startTime")) || !checkDate(getParam("endTime"))){
		L5.Msg.alert("错误" , "日期格式有误!");
		return;
	}	
	if(parseInt(getParam("startTime")) > parseInt(getParam("endTime"))){
		L5.Msg.alert("错误" , "起始日期不能大于截至日期!");
		return;
	}
	msgDs.setParameter("titleSearch" , getParam("titleSearch"));
	if(s=="in" || s=="trash"){
		msgDs.setParameter("sender" ,  getParam("senderSearch"));
	}else{
		msgDs.setParameter("partyNameSearch" , getParam("partyNameSearch"));
	}
	msgDs.setParameter("startTime" , getParam("startTime"));
	msgDs.setParameter("endTime" , getParam("endTime"));	
	msgDs.setParameter("msgType" , getParam("msgTypeSearch"));
//	msgDs.setParameter("userId" , getParam("userId"));	
	msgDs.setParameter("boxType" , s);	
	//使用复杂查询
	msgDs.setParameter("queryMode" , "complex");
	msgDs.load();
	msgDs.setParameter("queryMode","simple");
}
//显示邮件具体信息
function showMail(){
var grid  = L5.getCmp("editGridPanel");
//获取被选中的记录行
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	var boxType=document.getElementById("boxType").value;
	if(records!=""){
		var msgType = records[0].get("msgType");	
		var msgId=records[0].get("msgId");	
		var panel  = L5.getCmp("insertRoot");
		var attach = L5.getCmp("attachGridPanel");
		mailDs.setParameter("msgId",msgId);
		mailDs.setParameter("boxType",boxType);
		mailDs.setParameter("method","detail");
		mailDs.load(true);
		var hasAttach=records[0].get("hasAttach");
		if(msgType=="w"||msgType=="e"){
			panel.show();
			//显示html内容不为空
			if(mailDs.getAt(0).get("content").length){
				panel.show();
				//显示html内容
				window.frames["contentFrame"].document.body.innerHTML = mailDs.getAt(0).get("content");
			}else{
				panel.hide();
			}
			if(hasAttach=="true"){			
				attach.show();
				attachDs.setParameter("msgId",msgId);
				attachDs.setParameter("boxType",boxType);
				attachDs.setParameter("method","detail");
				attachDs.load();			
			}else{
				attach.hide();
			}
		}else if(msgType=="s" || msgType=="m"){			
			panel.hide();
			attach.hide();
		}else{
			if(DeliveryMode[msgType].withContent){
				//不为空
				if(mailDs.getAt(0).get("content").length){
					panel.show();
					//显示html内容
					window.frames["contentFrame"].document.body.innerHTML = mailDs.getAt(0).get("content");
				}else{
					panel.hide();
				}
			}else{
				panel.hide();
			}
			if(DeliveryMode[msgType].withAttach){
				if(hasAttach=="true"){	
					attachDs.setParameter("msgId",msgId);
					attachDs.setParameter("boxType",boxType);
					attachDs.setParameter("method","detail");
					attachDs.load();
					attach.show();
				}else{
					attach.hide();
				}
			}else{
				attach.hide();
			}	
		}
	}
}

//打开并显示邮件具体信息
function openMail(){
var grid  = L5.getCmp("editGridPanel");
//获取被选中的记录行
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	var boxType=document.getElementById("boxType").value;

	if(records!=""){
		var msgId = records[0].get("msgId");
		var msgType = records[0].get("msgType");
		if(msgType=="w"||msgType=="e"){
			if(boxType=="temp"){
				showWindow("../mail/mail_edit.jsp?msgId="+msgId+"&msgType="+msgType+"&method=detail" , "" , msgType , true);
			}else{
				showWindow("../mail/mail_detail.jsp?msgId="+msgId+"&box="+boxType, "" , msgType , false , true);
			}
	    }else if(msgType=="s" || msgType=="m"){
	    	if(boxType=="temp"){
	    		if(msgType=="s"){
	    			showWindow("../sms/sms_edit.jsp?msgId="+msgId+"&msgType="+msgType+"&method=detail" , "" , msgType , true);
	    		}else if(msgType=="m"){
	    			showWindow("../sms/msg_edit.jsp?msgId="+msgId+"&msgType="+msgType+"&method=detail" , "" , msgType , true);
	    		}
	    	}else{
	    		showWindow("../sms/msg_detail.jsp?msgId="+msgId+"&msgType="+msgType+"&box="+boxType , "" , msgType , false , true);
	    	}
	    }else{
		    if(boxType=="temp"){
		    	var url = L5.webPath + "/jsp/" + DeliveryMode[msgType].editUrl + "?msgId="+msgId+"&msgType="+msgType+"&method=detail";
		    	showWindow(url , "" , msgType , true);
		    }else{
		    	var url = L5.webPath + "/jsp/" + DeliveryMode[msgType].detailUrl + "?msgId="+msgId+"&msgType="+msgType+"&box="+boxType;
		    	showWindow(url , "" , msgType , false , true);
		    }
		}
    }
}
//下载附件
function download(){
	var grid  = L5.getCmp("attachGridPanel");
	//获取被选中的记录行
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records.length != 1){
		L5.Msg.alert("提示","请选中一行下载！");
		return;
	}
	var fileID=records[0].get("fileID");	
	downloadAtt(fileID);
}

//下载选中链接
function downloadSelect(){
	var grid  = L5.getCmp("attachGridPanel");
	//获取被选中的记录行
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records.length == 0){
		L5.Msg.alert("提示" , "请选中至少一行！");
		return;
	}
	var uuids = "";
	for(var i=0; i<records.length; i++){
		uuids += records[i].get("fileID");
		if(i+1 != records.length)
			uuids += ",";
	}
	downloadByUuids(uuids);	
}

//**************MenuList.js
//options对象保存要显示的下拉下列表id与text
//size表示下拉列表个数
function options(id, text , isdataSet , dataset){
	if(!isdataSet){
		this.ids = id;
		this.text = text;
		this.size = dataset;
	}
	else{
		this.ids = new Array();
		this.text = new Array();
		for(var i=0; i<dataset.getCount(); i++){
			this.ids[i] = dataset.getAt(i).get(id);
			this.text[i] = dataset.getAt(i).get(text);
		}
		this.size = dataset.getCount();
	}
}
//构造一个按钮下拉列表
//buttonId 要给加下拉列表的按钮
//listId	下拉列表div父节点的id
//msglist 	下拉列表id
//options 	下拉列表对象
function buttonList(buttonId , listId , msglistid , options){
	this.buttonListId = msglistid;
	this.buttonList = document.getElementById(this.buttonListId);
	this.parentId = listId;
	//当前没有下拉列表则构造一个
	if(!this.buttonList){
		//初始化
		this.buttonId = buttonId;
		//size表示下拉菜单条数
		this.size = options.size;
		//ids保存各个下拉菜单的id
		this.ids = new Array();
		this.isExist = false;
		this.buttonList = document.createElement("div");
		this.buttonList.id = this.buttonListId;
		this.buttonList.size = options.size;
		//定位下拉列表
		var x = document.getElementById(this.buttonId).offsetLeft;
		var y = document.getElementById(this.buttonId).offsetTop;
		var target = document.getElementById(this.buttonId).offsetParent;
	   	while (target)
	    {
	     	x += target.offsetLeft;
	    	y += target.offsetTop;
	    	target = target.offsetParent
	   	}
		document.getElementById(this.parentId).style.left = x + "px";
		document.getElementById(this.parentId).style.top = document.getElementById(this.buttonId).offsetHeight + y + "px";

		//开始构造下拉菜单
		for(var i=0; i<options.size; i++){
			var divlist = document.createElement("div");
			divlist.id = this.buttonListId + options.ids[i];
			divlist.innerHTML = options.text[i];
			divlist.className = "mouseout";
			this.buttonList.appendChild(divlist);
			this.ids[i] = divlist.id;
		}	
		document.getElementById(this.parentId).appendChild(this.buttonList);
	}
	else{
		if(document.getElementById(this.parentId).style.display == "block"){
			this.isShow = true;
		}
		else{
			this.isShow = false;
		}
		this.size = this.buttonList.size;
		this.isExist = true;
	}
}

//给各个div加入事件
buttonList.prototype.setOnClickEvent = function(id , funcName){
	document.getElementById(this.buttonListId+id).onclick = new Function(funcName+"('"+id+"')");
}

//显示div列表
buttonList.prototype.show = function (){
	if(!this.isExist)
		this.initEvent();
	document.getElementById(this.parentId).style.display = "block";
	this.isShow = true;
}

//隐藏div列表
buttonList.prototype.hide = function(){
	document.getElementById(this.parentId).style.display = "none";
	this.isShow = false;
}
//给各个div加入mouseover与mouseout事件用于显示
buttonList.prototype.initEvent = function(){
	for(var i=0; i<this.size; i++){
		document.getElementById(this.ids[i]).onmouseover = function () {
				this.className = "mouseover";	
		};
		document.getElementById(this.ids[i]).onmouseout = function () {
				this.className = "mouseout";
		};
	}
}

//显示查询窗口
function queryMsg(){
	var queryWnd = L5.getCmp("queryWnd");
	queryWnd.show();
	var select = document.getElementById("msgTypeSearch");
	if(select.options.length==0){
		for(var i=0; i<MenuItems.ids.length; i++){
			var option = document.createElement("option");
			option.text = MenuItems.text[i];
			option.value = MenuItems.ids[i];
			try{
    			select.add(option,null); // standards compliant
    		}catch(ex){
    			select.add(option); // IE only
    		}
  		}
	}
}
//显示消息类型的种类
function showTypeIco(msgType){
	var figpath=L5.webPath + "/skins/images/";
	document.getElementById("typeMark").value = msgType;
	if(msgType == 'e'){
		return '<img src="' + figpath + '/live/live_email.gif" alt="邮件">';
	}else if(msgType == 'w'){
		return '<img src="' + figpath + '/live/live_mail.gif" alt="站内邮件">';
	}else if(msgType == 's'){
		return '<img src="' + figpath + '/live/live_sms.gif" alt="短信">';
	}else if(msgType == 'm'){
		return '<img src="' + figpath + '/live/live_message.gif" alt="站内消息">';
	}else{
		return '<img src="' + figpath + DeliveryMode[msgType].icon + '" alt="' + DeliveryMode[msgType].text + '">';
	}
}


//新建邮件触发事件
function newMsg() {
	//构造一个下拉菜单options对象
	var msgTypeDs = L5.DatasetMgr.lookup("msgTypeDs");
	var lists = new options(MenuItems.ids ,  MenuItems.text , false , MenuItems.ids.length);
	//jsp下拉菜单div id：msgtypeMenu
	//下拉菜单id  	id:msglist
	var menu = new buttonList("menulist" , "msgtypeMenu" , "msglist" , lists);
	//点击不同下拉菜单选项设置处理事件，要求每个处理函数都必须调用hide方法
	for(var i=0; i<MenuItems.ids.length; i++){
		if(MenuItems.ids[i] == "e"){
			menu.setOnClickEvent("e" , "newEMail");
		}else if(MenuItems.ids[i] == "w"){
			menu.setOnClickEvent("w" , "newWebMail");
		}else if(MenuItems.ids[i] == "s"){
			menu.setOnClickEvent("s" , "newSms");
		}else if(MenuItems.ids[i] == "m"){
			menu.setOnClickEvent("m" , "newMessage");
		}else{
			menu.setOnClickEvent(MenuItems.ids[i] , "newMessageaa");
		}
	}
	menu.show();
}
//新建消息
function newMessageaa(id){
	//获得下拉菜单 需要下拉列表id与其父节点id
	var menu = new buttonList(null , "msgtypeMenu" , "msglist" , null);
	menu.hide();
	var url = L5.webPath + "/jsp/" + DeliveryMode[id].editUrl+"?msgType=" + id + "&method=new";
	var text = DeliveryMode[id].text;
	showWindow(url , "" , id , true); 
}

//新建站内邮件
function newWebMail(){
	//获得下拉菜单 需要下拉列表id与其父节点id
	var menu = new buttonList(null , "msgtypeMenu" , "msglist" , null);
	menu.hide();
	var url = "../mail/mail_edit.jsp?msgType=w&method=new";
	var text = "编写邮件";	
	showWindow(url , "" , 'w' , true); 
}
//新建邮件
function newEMail(){
	//获得下拉菜单 需要下拉列表id与其父节点id
	var menu = new buttonList(null , "msgtypeMenu" , "msglist" , null);
	menu.hide();
	var url = "../mail/mail_edit.jsp?msgType=e&method=new";
	var text = "编写邮件";
	showWindow(url , "" , 'e' , true);
}
//新建站内消息
function newMessage(){
	//获得下拉菜单 需要下拉列表id与其父节点id
	var menu = new buttonList(null , "msgtypeMenu" , "msglist" , null);
	menu.hide();
	var url = "../sms/msg_edit.jsp?msgType=m&method=new";
	var text = "编写消息";
	showWindow(url , "" , 'm' , true); 
}
//新建短信
function newSms(){
	//获得下拉菜单 需要下拉列表id与其父节点id
	var menu = new buttonList(null , "msgtypeMenu" , "msglist" , null);
	menu.hide();
	var url = "../sms/sms_edit.jsp?msgType=s&method=new";
	var text = "编写短信";
	showWindow(url , "" , 's' , true); 
}

window.document.onclick = function(ev){
	try{
		var menu = new buttonList(null , "msgtypeMenu" , "msglist" , null);
		var areaLeft = parseInt(document.getElementById(menu.parentId).style.left , 10);
		var areaTop = parseInt(document.getElementById(menu.parentId).style.top , 10);
		var x = y = null;
		ev = ev||window.event;
		
		if(ev.pageX || ev.pageY){ 
		   	x = ev.pageX;
		   	y = ev.pageY;
		}else{ 
			x = ev.clientX + document.body.scrollLeft - document.body.clientLeft;
			y = ev.clientY + document.body.scrollTop  - document.body.clientTop;
		} 
		var height = parseInt(menu.size , 10)*20;
		if(x!=null && y!=null)
			if((x<areaLeft || x>areaLeft+80) || (y<areaTop-24 || y>height) && menu.isShow){				
				menu.hide();
			}
	}catch(e){
		return;
	}
}
function titleFilter(title){
	var htmlReg = /<[^>]+>/g;
	var msgType = document.getElementById("typeMark").value;
	return title.replace(htmlReg , "");
}