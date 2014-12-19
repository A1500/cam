function Evt_butsave_click() {
	var memberId = extContactDs.getCurrent().get("memberId");
	if(memberId==""){
		creat_contact();				
	} else{
		var status1 = update_user();
		if(status1!=0 && status1!=1){
			L5.Msg.alert("错误" , status1);
			return;
		}
		var status2 = save_addr();
		if(status2!=0 && status2!=1){
			L5.Msg.alert("错误" , status2);
			return;
		}
		if(status1==0 && status2==0){
			L5.Msg.alert("提示" , "没有需要保存的数据");
			return;
		}
		var parentWin = window.parent.window;
		var tree = parentWin.L5.getCmp("strutree");			
		//修改节点只需要更改树中显示名称，其余不需要同步
		var node = tree.getNodeByRecordId(extContactDs.getCurrent().get("memberId"), "contactRecord");
		node.record.set("nickName", extContactDs.getCurrent().get("nickName"));
		node.record.commit();										
		L5.MessageBox.alert("提示", "联系人信息保存成功!");
	}
}
//取消修改联系人信息
function Evt_butundo_click() {
	// 取消所有的修改操作
	extContactDs.rejectChanges();
	contactAddrDs.rejectChanges();
}
function update_user() {
	var infoRecords = extContactDs.getAllChangedRecords();
	if (infoRecords.length < 1) {
		return 0;
	}
	var contactName = document.getElementById("contactName").value;
	var nickName = document.getElementById("nickName").value;
	var status ;
	if (!contactName) {
		return "姓名(名称)不能为空!";
	}else{
		status = checkName(contactName);
		if(status != true)
			return "姓名(名称)"+status;
	}
	status = checkName(nickName);
	if(status != true)
		return "昵称"+status;
	var command = new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactSaveCmd");
	command.setParameter("extContact", infoRecords[0]);
	command.execute("modifyExtContact");
	// 保存提示
	if (!command.error) {
		extContactDs.setParameter("CONTACT_USER_ID" , contactId);
		extContactDs.load(true);		
		return 1;
	} else {
		return command.error;
	}
}
function save_addr() {
	// 获取所有被修改的记录
	var addrRecords = contactAddrDs.getAllChangedRecords();
	// 如果没有被修改的记录
	if (addrRecords.length < 1) {
		return 0;
	} else {
		//数据格式校验
		for ( var i = 0; i < addrRecords.length; i++) {
			var deliveryMode = addrRecords[i].get("deliveryMode");
			var deliveryAddr = addrRecords[i].get("deliveryAddr");
			var status = checkAddr(deliveryMode , deliveryAddr);
			if(status !== true)
			 	return status;
		}
	}
	var command = new L5.Command("org.loushang.live.contact.privacy.cmd.UserSaveCmd");
	command.setParameter("contactAddrDs" , addrRecords);
	command.setParameter("contactId" , contactId);
	command.execute("saveContactAddr");
	if (!command.error) {// 保存提示
		contactAddrDs.setParameter("OWNER_ID"  ,contactId);
		contactAddrDs.load(true);
		return 1;
	}else{ 
		return command.error;
	}
}

/**
 * 事件处理：创建联系人
 */
function creat_contact(){	
	var name=document.getElementById("contactName").value;
	var nickName=document.getElementById("nickName").value;
	var addrRecords = contactAddrDs.getAllChangedRecords();
	var status;
	var command = new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactSaveCmd");
	if(name) {//假如没有输入就不放入pset
		status = checkName(name);
		if(status != true){
			L5.Msg.alert("提示" , "姓名"+status);
			return;
		}
		command.setParameter("name", name);
		if(nickName) {
			status = checkName(nickName);
			if(status != true){
				L5.Msg.alert("提示" , "昵称"+status);
				return;
			}
			command.setParameter("nickName", nickName);
		} else {
			command.setParameter("nickName", name);
		}
		command.setParameter("groupId" , groupId);
		command.setParameter("allRecords" , addrRecords);
		command.execute("addExtContactByUser");
		if (!command.error) {
			var parentWin = window.parent.window;
			var currentNode =parentWin.L5.getCmp("strutree").getCurrentNode();
			var currentRecord = currentNode.record;
			currentRecord.reload(true);
			currentNode.expand();	
			var contact = command.getReturn("contact");
			contactId = contact.contactId;
			L5.MessageBox.alert("提示", "联系人信息保存成功!",function(){
				//将页面重新加载，避免出现页面未跳转，修改功能为保存功能的问题
				contactAddrDs.setParameter("OWNER_ID" , contactId);
				contactAddrDs.load(true);
				extContactDs.setParameter("CONTACT_USER_ID" , contactId);
				extContactDs.load(true);
			});
		}else{ 
			L5.MessageBox.alert("错误",command.error);
		}
	} else {
		L5.MessageBox.alert("提示", "联系人姓名(名称)不能为空!");
	}
}

function btnAddAddr(){
	var addrWnd = L5.getCmp("addrWnd");
	var modeArray = getModeIndex();
	if(modeArray.length){
		addrWnd.show();
		resetWnd(modeArray);
	}else{
		L5.Msg.alert("提示" , "当前没有可以添加的联系方式!");
	}
}
function addAddr(){
	var addrWnd = L5.getCmp("addrWnd");
	var modeSel = document.getElementById("deliveryModeSel");
	var deliveryMode = modeSel.options[modeSel.selectedIndex].value;
	var addr = document.getElementById("addrText").value;
	var status = checkAddr(deliveryMode ,addr);
	if(status != true){
		L5.Msg.alert("提示" , status);
		return;
	}
	var newRecord = contactAddrDs.newRecord();
	newRecord.set("deliveryMode" , deliveryMode);
	newRecord.set("deliveryAddr" , addr);
	addrWnd.hide();
}
//获取过滤后的联系方式index
//过滤已经存在的联系方式，站内邮件，站内消息
function getModeIndex(){
	var modeArray = [];
	if(ContactInfo=="")
	 	return modeArray;
	//过滤已经有的联系方式
	for(var i=0; i<deliveryModeDs.getCount(); i++){
		for(var j=0; j<contactAddrDs.getCount(); j++){
			if(deliveryModeDs.getAt(i).get("deliveryMode") == contactAddrDs.getAt(j).get("deliveryMode"))
				break;
		}
		//过滤掉已经被屏蔽的联系方式
		if(ContactInfo!="" && j==contactAddrDs.getCount() && ContactInfo.indexOf(deliveryModeDs.getAt(i).get("deliveryMode"))!=-1)
			modeArray.push(i);
	}
	return modeArray;
}
function cancelAddr(){
	var addrWnd = L5.getCmp("addrWnd");
	addrWnd.hide();
}
function btnDelAddr(){
	var grid  = L5.getCmp("contactAddrGrid");
	//获取被选中的记录行
	var sm = grid.getSelectionModel();
	var cell = sm.getSelections();
	for(var i=0; i<cell.length; i++){
		contactAddrDs.remove(cell[i]);
	}
}
/**
*验证地址合法性
*dmode 联系方式
*address 联系地址
*regx    验证正则
*返回 true 正确 ， 否则为错误信息
*/
function checkAddr(dMode , address , regx){
	var regm = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	var regTel = /^[0-9]{11}$/;
	if(!address)
		return "联系地址不能为空!"; 
	if(dMode == 'e'){
		if(!address.match(regm)){
			return "邮件地址不符合规范";
		}
	}else if(dMode == 's'){
		if(!address.match(regTel)){
			return "手机号码不符合规范";
		}
	}else{
		if(!address.match(regx)){
			return "联系地址不符合规范";
		}
	}
	return true;
}
function checkName(name){
	return L5.Validator["lengthUTF8"](name , null , 30);
}
//重置窗口数据
function resetWnd(modeArray){	
	var modeSel = document.getElementById("deliveryModeSel");
	//先要移除所有的option
	for(i=0; i<modeSel.options.length; i=0)
		modeSel.remove(0);
	for(i=0; i<modeArray.length; i++){
		var option = document.createElement('option');
		option.value = deliveryModeDs.getAt(modeArray[i]).get("deliveryMode");
		option.text = deliveryModeDs.getAt(modeArray[i]).get("deliveryName");
		try
	    {
	    	modeSel.add(option,null); // standards compliant
	    }catch(ex){
	    	modeSel.add(option); // IE only
		}	
	}
	document.getElementById("addrText").value = "";
}
function changeDisplay(deliveryMode) {
	var deliveryModeDs = L5.DatasetMgr.lookup("deliveryModeDs");
	var deliveryName = "";
	var records = deliveryModeDs.getAllRecords();
	for(var i = 0;i< records.length;i++)
	{
		var record = records[i];
		if(deliveryMode==record.get("deliveryMode"))
		{
			deliveryName = record.get("deliveryName");
			break;
		}
	}
	return deliveryName;
}
