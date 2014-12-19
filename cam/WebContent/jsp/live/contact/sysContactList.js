/**
 * 定义根节点结构
 */ 
var rootdata = {
	groupId:'-1',
	groupName:'系统联系人管理',
	organId:'1',
	parentId:'-1',
	indexNo:'1',
	recordType : 'groupRecord'
};

/**
* 定义一个dataset
*/
var dataset = new L5.model.Dataset({
	id : "struDetailDataset"
});
function getSysGroup() {
	return "1";
}
/**
* 事件处理：点击节点,将节点信息添加到table中
*/
function selectedStru(record){
	var url;
	var frame = document.getElementById("nodeFrame");
	if(record.recordType=="contactRecord"){
		var currentNode = L5.getCmp("strutree").getCurrentNode();
		var contactRecord = currentNode.record;
		var contactType = record.get("sysContact");
		if("0" == contactType) {
			url = "person.jsp";
		} else {
			url = "externalContactDetail.jsp";
		}
		var url2 = '?userId='+record.get("contactId");
		url += (url2?url2:'#');
		url = encodeURI(encodeURI(url));
		frame.src=url;
	} else {
		frame.removeAttribute("src");
	}
}

/**
 * 事件处理：获得 TreebaseParams的值
 */
function getStruParent(rec){
	var groupId = rec.get("groupId");
	return groupId?groupId:"-1";
}
var online = "";
/**
 * 返回要显示联系人的方式
 */
function changeOnlineDisplayState(rec) {
	return online;
}
/**
 * 事件处理：加载一级分组节点
 */
function start_group_tree(record)
{
	if(record.recordType=="groupRecord"&&"-1"==record.get("groupId"))
		return true;
	else
		return false;
}
/**
 * 事件处理：加载二级联系人节点
 */
function start_contact_tree(record)
{
	if(record.recordType=="groupRecord"&&"-1"!=record.get("groupId"))
		return true;
	else
		return false;
}
/**
 * 事件处理：获取不同类型树节点的显示图标
 */
function getIcon(record){
	var recordType = record.recordType;
	if(recordType=="groupRecord"&&"-1"!=record.get("groupId")){
		return L5.webPath+"/skins/images/contact/group.png";
	} else {
		return L5.webPath+"/skins/images/contact/contactlist.png";
	}
}

/**
* 事件处理：添加分组
*/
function addGroup(menuitem){
	var record = menuitem.parentMenu.record;
	L5.MessageBox.prompt("请输入分组名称", "", function(e,corptext){
		if (e == "ok") {
			var command = new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactListSaveCmd");
			command.setParameter("groupName", corptext);
			command.execute("checkSysGroupExist");
			var result = command.getReturn("result");
			if("" != result) {
				L5.MessageBox.alert("提示", result);
			} else {
				command.setParameter("groupName", corptext);
				command.execute("addSysGroup");
				if (!command.error) {
					var groupRecord = command.getReturn("groupRecord");
					delete groupRecord.javaclass;
					if(null == groupRecord) {
						L5.MessageBox.alert("提示", "增加分组出错!");
					} else {
						var rec = new L5.tree.TreeRecord.recordTypes["groupRecord"](groupRecord);
						record.getParent().insertSort(rec);
					}
				}else{ 
					L5.MessageBox.alert("错误",command.error);
				}
			}
		} 
	});
}
/**
* 事件处理：重命名分组
*/
function renameGroup(menuitem){
	var record = menuitem.parentMenu.record;
	L5.MessageBox.prompt("请输入新分组名称", "", function(e,corptext){
		if (e == "ok") {
			var command = new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactListSaveCmd");
			command.setParameter("GROUP_ID", record.get('groupId'));
			command.setParameter("newGroupName", corptext);
			command.execute("updateSysGroup");
			if (!command.error) {
				var result = command.getReturn("result");
				if("" != result) {
					L5.MessageBox.alert("提示", result);
				} else {
					record.set("groupName", corptext);
					record.commit();
					record.reload(true);
					L5.getCmp("strutree").getCurrentNode().expand();
				}
			}else{ 
				L5.MessageBox.alert("错误",command.error);
			}
			
		} 
	});
}

/**
* 事件处理：删除分组
*/
function delGroup(menuitem){
	L5.MessageBox.confirm("提示", "确认删除分组?",
			function(sta) {
				if (sta === 'yes') {
					var record = menuitem.parentMenu.record;	
					var command = new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactListSaveCmd");
					command.setParameter("groupId", record.get('groupId'));
					command.execute("deleteGroup");
					if (!command.error) {
						var result = command.getReturn("result");
						if("" != result) {
							L5.MessageBox.alert("提示", result);
						} else {
							var prec = record.parentRecord;
							if(prec){
								prec.remove(record);
							}
						}
					}else{ 
						L5.MessageBox.alert("错误",command.error);
					}	
				}
			});	
}
/**
* 事件处理：显示在线好友
*/
function showOnline(menuitem){
	online = "1";
	var currentNode = L5.getCmp("strutree").getCurrentNode();
	var record = currentNode.record;
	record.reload(true);
	currentNode.expand();
}
/**
* 事件处理：显示全部好友
*/
function showAllContact(menuitem){
	online = "0";
	var currentNode = L5.getCmp("strutree").getCurrentNode();
	var record = currentNode.record;
	record.reload(true);
	currentNode.expand();
}
var addUser_groupId;
/**
 * 弹出查询窗口
 */
function query_other_users(menuitem){
	var record = menuitem.parentMenu.record;
	addUser_groupId = record.get('groupId');
	var win=L5.getCmp("query-users-win");
	win.show();
}
/**
 * 按照查询条件查询用户
 */
function query(){
	var userDataSet=L5.DatasetMgr.lookup("userDataSet");//取到userDataSet
	//取到jsp中的userId
	var userId=document.getElementById("usersId").value;
	//取到userName
	var userName=document.getElementById("usersName").value;
	if(userId.indexOf("'")!=-1) {
		L5.MessageBox.alert("提示","英文单引号为非法字符！");
		i=i+1;
	}else if(userId=="~"){
		L5.MessageBox.alert("提示","单个“~”为非法字符！");
		i=i+1;
	}
	if(userName.indexOf("'")!=-1) {
		L5.MessageBox.alert("提示","英文单引号为非法字符！");
		i=i+1;
	}else if(userName=="~"){
		L5.MessageBox.alert("提示","单个“~”为非法字符！");
		i=i+1;
	}
	
	//假如没有输入userId就不放入pset
	if(i==0){
	if(userId.length>0) {
		userDataSet.setParameter("USER_ID@like",userId.toUpperCase());
	}
	//假如没有输入userName就不放入pset
	if(userName.length>0) {
		userDataSet.setParameter("USER_NAME@like",userName.toUpperCase());
	}
	userDataSet.load();
	var quw=L5.getCmp("query-users-win");
	quw.hide();//隐藏上一个窗口
	document.getElementById("usersId").value = "";
	document.getElementById("usersName").value = "";
	var win=L5.getCmp("display-users-win");	//取到display窗口
	win.show();
	}else{
		return false;
	}
}
/**
 * 重置查询条件
 * @return
 */
function reset(){
	document.getElementById("usersId").value="";
	document.getElementById("usersName").value="";
}

/**
 * 关闭查询窗口
 */
function exit(){
	var win=L5.getCmp("query-users-win");
	win.hide();
}
/**
 * 从显示列表返回查询窗口
 */
function Evt_butback_click(){
	var win=L5.getCmp("display-users-win");	//取到display窗口
	win.hide();//提供一个显示查询结果的js方法
	var quw=L5.getCmp("query-users-win");
	quw.show();//隐藏上一个窗口
}

/**
 * 从显示列表窗口增加好友（同时对方也把自己加进了好友）
 */
function Evt_butaddfriend_click(){
	var userDataSet=L5.DatasetMgr.lookup("userDataSet");//取到userDataSet
	//定义command
	var addCLCmd=new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactListSaveCmd");
	var grid = L5.getCmp("userGrid");
	//停止grid的编辑状态
	grid.stopEditing();
	//获取被选中的记录行
	var sm=grid.getSelectionModel();
	var cell=sm.getSelections();
	if(cell.length<1){
		L5.MessageBox.alert("提示","请选择一个用户");
		return;
	}
	addCLCmd.setParameter("groupId",addUser_groupId);
	addCLCmd.setParameter("user",cell[0]);//这里friend是user型的
	addCLCmd.execute("addSysContactList");//执行getContactAddr
	if(!addCLCmd.error){
		var result = addCLCmd.getReturn("result");
		if("" != result) {
			L5.MessageBox.alert("提示", result);
		} else {
			userDataSet.commitChanges();
			L5.MessageBox.alert("提示","添加联系人成功!");
			var win=L5.getCmp("display-users-win");	//取到display窗口
			win.hide();
			var currentNode = L5.getCmp("strutree").getCurrentNode();
			var currentRecord = currentNode.record;
			currentRecord.reload(true);
			currentNode.expand();
		}
	}else{
		L5.MessageBox.alert("提示",addCLCmd.error);
	}
}
/**
 * 关闭显示列表窗口
 */
function Evt_butclose_click(){
	var win=L5.getCmp("display-users-win");	//取到display窗口
	win.hide();//提供一个显示查询结果的js方法
}
/**
 * 查询用户详细信息
 */
function Evt_queryinfo_click(){
	var userDataSetForUserInfo=L5.DatasetMgr.lookup("userDataSetForUserInfo");//取到userDataSet
	var contactAddrDs=L5.DatasetMgr.lookup("contactAddrDs");//取到contactAddrDs
	var grid = L5.getCmp("userGrid");
	//停止grid的编辑状态
	grid.stopEditing();
	//获取被选中的记录行
	var sm=grid.getSelectionModel();
	var cell=sm.getSelections();
	if(cell.length<1){
		L5.MessageBox.alert("提示","请选择查看的记录");
		return;
	}
	//取到jsp中的userId
	var userId=cell[0].get("userId");
	//取到userName
	if(userId.length>0){//假如没有userId就不放入pset
		userDataSetForUserInfo.setParameter("USER_ID",userId);
		userDataSetForUserInfo.load(true);
		contactAddrDs.setParameter("USER_ID",userId);
		contactAddrDs.load(true);
	}
	var win=L5.getCmp("query-userinfo-win");	//取到display窗口
	var usersWin=L5.getCmp("display-users-win");
	usersWin.hide();
	win.show();//提供一个显示查询结果的js方法
}
/**
 * 改变通信方式显示形式
 */
function changeDisplay(deliveryMode)
{
	var deliveryModeDs = L5.DatasetMgr.lookup("deliveryModeDs");
	var deliveryName = "";
	deliveryModeDs.load(true);
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
/**
 * 从显示详细信息窗口增加好友
 */
function Evt_butaddfriend2_click(){
	Evt_butaddfriend_click();//添加好友，这里应该是早有已经选定的记录，如果没有该怎么办？这里处理一下
	Evt_butclose2_click();//关闭详细信息窗口
}
/**
 * 关闭详细信息窗口
 */
function Evt_butclose2_click(){
	var win=L5.getCmp("query-userinfo-win");	//取到display窗口
	win.hide();//提供一个显示查询结果的js方法
}
var create_contact_groupId;
/**
 * 显示创建联系人窗口
 */
function show_create_contact_win(menuitem){
	var record = menuitem.parentMenu.record;
	create_contact_groupId = record.get('groupId');
	var win=L5.getCmp("create_contact_win");
	win.show();	
}
/**
 * 关闭创建联系人窗口
 */
function exit_create_contact_win(){
	var win=L5.getCmp("create_contact_win");
	win.hide();
}
/**
 * 事件处理：创建联系人
 */
function creat_contact(){
	deliveryModeDs.reload(true);
	var name=document.getElementById("name").value;
	var nickName=document.getElementById("nickName").value;
	var allRecords = deliveryModeDs.getAllRecords();
	var changedRecords = deliveryModeDs.getAllChangedRecords();
	if(changedRecords.length != 0) {
		var regm = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
		var regTel = /^[0-9]{11}$/;
		//进行校验
		for ( var i = 0; i < changedRecords.length; i++) {
			var deliveryName = changedRecords[i].get("deliveryName");
			var deliveryMode = changedRecords[i].get("deliveryMode");
			if (("电子邮件" == deliveryName) || ("站内邮件" == deliveryName)) {
				// 如果联系方式选择的是邮箱
				if (!deliveryMode.match(regm) && deliveryMode != "") {
					L5.MessageBox.alert("提示","邮箱地址格式错误!");
					return false;
				}
			}
			// 联系方式选择的是短信
			if ("短信" == deliveryName) {
				deliveryMode=deliveryMode.trim();
				if (!deliveryMode.match(regTel) && deliveryMode != "") {
					L5.MessageBox.alert("提示","请正确输入11位手机号!");
					return false;
				} 
			}
		}
	}
	var command = new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactListSaveCmd");
	if(""!=name && name.length>0) {//假如没有输入就不放入pset
		command.setParameter("name", name);
		if(""!=nickName && nickName.length>0) {
			//假如没有输入就不放入pset
			command.setParameter("nickName", nickName);
		} else {
			command.setParameter("nickName", name);
		}
		command.setParameter("groupId", create_contact_groupId);
		command.setParameter("allRecords", allRecords);
		command.execute("addSysContact");
		exit_create_contact_win();
		if (!command.error) {
			var result = command.getReturn("result");
			if("" != result) {
				L5.MessageBox.alert("提示", result);
			} else {
				var currentNode = L5.getCmp("strutree").getCurrentNode();
				var currentRecord = currentNode.record;
				currentRecord.reload(true);
				currentNode.expand();
				document.getElementById("name").value = "";
				document.getElementById("nickName").value = "";
			}
		}else{ 
			L5.MessageBox.alert("错误",command.error);
		}
	} else {
		L5.MessageBox.alert("提示", "联系人姓名(名称)不能为空!");
	}
}
/**
 * 	页面输出右键菜单
 */
function out_menu(){
	var menu = new L5.menu.Menu();
	var menuItem = new L5.menu.Item({ text: '移动联系人至'});
	var item2 = menu.add(menuItem,
			{ text: '删除联系人', handleClick:function(){delete_contact(this);} },
			{ text: '修改备注姓名', handleClick:function(){modify_contact(this);} }
		);
	var menu2 = new L5.menu.Menu({autoScroll:true,maxItemNum:8});
	
	var ds = L5.DatasetMgr.lookup("groupDataSet");
	ds.load(true);
	var groupRecord = L5.getCmp("strutree").getCurrentRecord().getParent(); 
	var currentName = groupRecord.get('groupName');
	for(var i=0;i<ds.getCount();i++){
		var record = ds.getAt(i);
		var bean =  record.toBean("org.loushang.live.contact.contactlist.data.Group");
		var groupName = bean.groupName;
		if(groupName!=currentName)
			menu2.add({ text: groupName, handleClick:function(){change_group(this);}  });	
	}
	menuItem.menu=menu2;
	menu.render();
	var xy = [L5.EventObject.getPageX(), L5.EventObject.getPageY()];
	menu.showAt(xy);
}
/**
 * 事件处理：删除联系人
 */
function delete_contact(menuitem){
	L5.MessageBox.confirm("提示", "确认删除联系人?",
			function(sta) {
				if (sta === 'yes') {
					menuitem.parentMenu.hide();
					var currentNode = L5.getCmp("strutree").getCurrentNode();
					var parentNode = currentNode.parentNode;
					var contactRecord = currentNode.record;
					var groupRecord = L5.getCmp("strutree").getCurrentRecord().getParent(); 
					var command = new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactListSaveCmd");
					command.setParameter("groupId", groupRecord.get('groupId'));
					command.setParameter("memberId", contactRecord.get('memberId'));
					command.execute("deleteContactList");
					if (!command.error) {
						var result = command.getReturn("result");
						if("" != result) {
							L5.MessageBox.alert("提示", result);
						} else {
							groupRecord.remove(contactRecord);
							groupRecord.commit();
							groupRecord.reload(true);
							parentNode.expand();			
						}
					}else{ 
						L5.MessageBox.alert("错误",command.error);
					}
				}
			});	
}
/**
 * 事件处理：移动联系人至其他分组
 */
function change_group(menuitem){
	var contactRecord = L5.getCmp("strutree").getCurrentNode().record;
	var groupRecord = L5.getCmp("strutree").getCurrentRecord().getParent(); 
	var command = new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactListSaveCmd");
	command.setParameter("groupId", groupRecord.get('groupId'));
	command.setParameter("memberId", contactRecord.get('memberId'));
	command.setParameter("groupName", menuitem.text);
	command.execute("changeSysGroup");
	if (!command.error) {
		var result = command.getReturn("result");
		if("" != result) {
			L5.MessageBox.alert("提示", result);
		} else {
			//reload
			menuitem.parentMenu.hide();			
			menuitem.parentMenu.parentMenu.hide();
			var re = L5.getCmp("strutree").getRootNode().record;
			re.commit();
			re.reload(true);
			L5.getCmp("strutree").getRootNode().expand();
		}
	}else{ 
		L5.MessageBox.alert("错误",command.error);
	}
}
/**
 * 事件处理：移至黑名单
 */
function move_to_blacklist(menuitem){
	var contactRecord = L5.getCmp("strutree").getCurrentNode().record;
	var groupRecord = L5.getCmp("strutree").getCurrentRecord().getParent(); 
	var command = new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactListSaveCmd");
	command.setParameter("groupId", groupRecord.get('groupId'));
	command.setParameter("memberId", contactRecord.get('memberId'));
	command.execute("moveToBlackListBySys");
	if (!command.error) {
		var result = command.getReturn("result");
		if("" != result) {
			L5.MessageBox.alert("提示", result);
		} else {
			//reload
			menuitem.parentMenu.hide();
			var re = L5.getCmp("strutree").getRootNode().record;
			re.reload(true);
			L5.getCmp("strutree").getRootNode().expand();
		}
	}else{ 
		L5.MessageBox.alert("错误",command.error);
	}
}
/**
 * 事件处理：修改联系人昵称
 */
function modify_contact(menuitem){
	menuitem.parentMenu.hide();
	var contactRecord = L5.getCmp("strutree").getCurrentNode().record;
	L5.MessageBox.prompt("请输入新昵称", "", function(e,corptext){
		if (e == "ok") {
			var command = new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactListSaveCmd");
			command.setParameter("newNickName", corptext);
			command.setParameter("MEMBER_ID", contactRecord.get('memberId'));
			command.execute("modifyContactList");
			if (!command.error) {
				var result = command.getReturn("result");
				if("" != result) {
					L5.MessageBox.alert("提示", result);
				} else {
					contactRecord.set("nickName", corptext);
					contactRecord.commit();
					contactRecord.reload(true);
				}
			}else{ 
				L5.MessageBox.alert("错误",command.error);
			}
			
		} 
	});
}
/**
* 上移分组
*/
function upGroup(menuItem)
{
	var record = menuItem.parentMenu.record;
	var index = record.get("indexNo")-0;
	//如果是第一个节点业务，则无上移功能	
	if(!(index>0))
		return;
	var upperRecord = getUpperRecord(record);
	if(!upperRecord || upperRecord===undefined)
	{
		return;
	}
	record.set("indexNo",upperRecord.get("indexNo"));
	upperRecord.set("indexNo",index);
	var records = new Array();
	records[0]=record;
	records[1]=upperRecord;
	var command=new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactListSaveCmd");
	command.setParameter("records",records);
	command.execute("swapGroupRecords");
	if(!command.error){
		swapGroupRecords(record,upperRecord);
	}
}
/**
* 下移分组
*/
function downGroup(menuItem)
{
	var record = menuItem.parentMenu.record;
	var index = record.get("indexNo")-0;
	//如果是最后一个节点业务，则无下移功能
	var downerRecord = getDownerRecord(record);
	if(!downerRecord || downerRecord===undefined)
	{
		return;
	}
	record.set("indexNo",downerRecord.get("indexNo"));
	downerRecord.set("indexNo",index);
	var records = new Array();
	records[0]=record;
	records[1]=downerRecord;
	var command=new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactListSaveCmd");
	command.setParameter("records",records);
	command.execute("swapGroupRecords");
	if(!command.error){
		swapGroupRecords(record,downerRecord);
	}
}
//得到指定节点的上临节点的record
function getUpperRecord(rcd)
{
	var parentRcd = rcd.parentRecord;
	//取得所有父节点下的子节点
	var brotherRcd = parentRcd.children.items;
	var leng = brotherRcd.length;
	//获得上临节点
	for(var i=1; i<leng; i++){
		//如果该节点的索引号为制定节点的索引号，则取上一节点
		if(brotherRcd[i].get("indexNo")==rcd.get("indexNo")){
			return brotherRcd[i-1];
		}
	}
}
//得到指定节点的下临节点的record
function getDownerRecord(rcd)
{
	var parentRcd = rcd.parentRecord;
	//取得所有父节点下的子节点
	var brotherRcd = parentRcd.children.items;
	var leng = brotherRcd.length;
	//获得下临节点
	for(var i=0; i<leng-1; i++){
		//如果该节点的索引号为制定节点的索引号，则取下一节点
		if(brotherRcd[i].get("indexNo")==rcd.get("indexNo")){
			return brotherRcd[i+1];
		}
	}
}
function swapGroupRecords(rec1,rec2)
{
	var groupId = rec1.get("groupId");
	var groupName =rec1.get("groupName");
	var indexNo =rec1.get("indexNo");
	var stat =rec1.get("stat");
	var createTime =rec1.get("createTime");
	var updateTime =rec1.get("updateTime");
	rec1.set("groupId",rec2.get("groupId"));
	rec1.set("groupName",rec2.get("groupName"));
	rec1.set("indexNo",rec2.get("indexNo"));
	rec1.set("stat",rec2.get("stat"));
	rec1.set("createTime",rec2.get("createTime"));
	rec1.set("updateTime",rec2.get("updateTime"));
	rec2.set("groupId",groupId);
	rec2.set("groupName",groupName);
	rec2.set("indexNo",indexNo);
	rec2.set("stat",stat);
	rec2.set("createTime",createTime);
	rec2.set("updateTime",updateTime);
	rec1.commit();
	rec1.reload();
	rec2.commit();
	rec2.reload();
}

/**
 * 通过对象的Id从页面上获得值
 * @param ElementId
 * @returns value
 */
function getParam(ElementId){
	var value=document.getElementById(ElementId).value;//通过dom获取值
	if(value=="")
		value=undefined;//假如未定义就返回undefined
	return value;
}