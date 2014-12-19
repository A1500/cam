function init() {
	userDataset.load(true);
	if(userDataset.getCount()==0){
		L5.Msg.confirm('提示', '您还没有开通消息平台相关服务，是否开通？',function(state){
		if(state=="yes"){
			var command = new L5.Command("org.loushang.live.contact.register.cmd.ServiceSaveCmd");
			// execute方法可以指定参数
			command.execute("userOpenService");
			//如果执行没有错误,dataset接受所有修改,否则弹出错误信息：
			if (!command.error) {
				//scDataset.commitChanges();
				L5.Msg.alert("提示","开通成功!",function(){
					userDataset.load();
					contactAddrDs.load();
				});
			}else{
				L5.Msg.alert("提示",command.error);
			}
		}else{
			return;
		}
	});
	}else{
		contactAddrDs.load();
	}
}
/**
*保存按钮事件
*/
function Evt_butsave_click() {
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
	L5.Msg.alert("提示" , "保存成功!");
}
/**
*用户信息保存方法
*返回0表示没有可保存的数据
*返回1保存成功
*否则返回错误说明
**/
function update_user() {
	var infoRecords = userDataset.getAllChangedRecords();
	if (infoRecords.length < 1) {
		return 0;
	}
	var userName = document.getElementById("userName").value;
	var birthday = document.getElementById("birthday").value;
	if (!userName) {
		return "姓名不能为空";
	} 
	var status = L5.Validator["lengthUTF8"](userName , null , 30);
	if(status != true)
		return "姓名"+status;
	var command = new L5.Command("org.loushang.live.contact.privacy.cmd.UserSaveCmd");
	// 将所有被修改过的Record作为command参数传递给后台command
	command.setParameter("user", infoRecords[0]);
	// 通过对象调用UserSaveCmd中的execute方法
	command.execute("updateUser");
	// 保存提示
	if (!command.error) {
		userDataset.commitChanges();
	} else {
		return command.error;
	}
	return 1;
}
/**
*联系方式保存方法
*返回0表示没有可保存的数据
*返回1保存成功
*否则返回错误说明
**/
function save_addr() {
	// 获取所有被修改的记录
	var addrRecords = contactAddrDs.getAllChangedRecords();
	if (addrRecords.length < 1) {
		return 0;
	}else {
		for(var i = 0; i < addrRecords.length; i++){
			var deliveryMode = addrRecords[i].get("deliveryMode");
			var deliveryAddr = addrRecords[i].get("deliveryAddr");	
			var status = checkAddr(deliveryMode , deliveryAddr);
			if(status !== true){
				return status;
			}
		}
		var command = new L5.Command("org.loushang.live.contact.privacy.cmd.UserSaveCmd");
		// 将所有被修改过的Record作为command参数传递给后台command
		command.setParameter("contactAddrDs", addrRecords);
		// 通过对象调用UserSaveCmd中的execute方法
		command.execute("updateContactAddr");
		if (!command.error) {// 保存提示
			contactAddrDs.commitChanges();
			contactAddrDs.load();
			return 1;
		}else{ 
			return command.error;
		}
	}
}
// 取消修改个人信息
function Evt_butundo_click() {
	// 取消所有的修改操作
	userDataset.rejectChanges();
	contactAddrDs.rejectChanges();
}

function btnDelAddr(){
	var grid  = L5.getCmp("contactAddrGrid");
	//获取被选中的记录行
	var sm = grid.getSelectionModel();
	var cell = sm.getSelections();
	if(cell.length){
		L5.MessageBox.confirm("提示","确认删除?",
			function(sta){
				if(sta == 'yes'){
					var delIds = [];
					for(var i=0; i<cell.length; i++){
						delIds.push(cell[i].get("addrId"));
					}
					if(delIds.length){
						var command = new L5.Command("org.loushang.live.contact.privacy.cmd.UserSaveCmd");
						// 将所有被修改过的Record作为command参数传递给后台command
						command.setParameter("delIds", delIds);
						command.execute("deleteContactAddr");
						if(!command.error){
							contactAddrDs.load();
						}else{
							L5.Msg.alert("错误" , command.error);
						}
					}
				}
		});
	}else{
		L5.Msg.alert("提示" , "请选择一条记录");
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
	var status = checkAddr(deliveryMode , addr);
	if(status === true){
		var command = new L5.Command("org.loushang.live.contact.privacy.cmd.UserSaveCmd");
		command.setParameter("deliveryMode" , deliveryMode);
		command.setParameter("address" , addr);
		command.execute("addContactAddr");
		if(command.error){
			L5.Msg.alert("错误" , command.error);
		}else{
			addrWnd.hide();
			contactAddrDs.load();
		}
	}else{
		L5.Msg.alert("提示" , status);
	}
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
function cancelAddr(){
	var addrWnd = L5.getCmp("addrWnd");
	addrWnd.hide();
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