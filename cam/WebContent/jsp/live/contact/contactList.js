var online = "offline";
var addUser_groupId;
var create_contact_groupId;

/**
 * 定义根节点结构
 */ 
var rootdata = {
	groupId:'S001',
	groupName:'联系人管理',
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
	return "0";
}

/**
 * 事件处理：加载一级分组节点
 */
function start_group_tree(record) {
	if(record.recordType=="groupRecord"&&"S001"==record.get("groupId")) {
		return true;
	} else {
		return false;
	}
}
/**
 * 事件处理：加载二级联系人节点
 */
function start_contact_tree(record) {
	if(record.recordType=="groupRecord"&&"S001"!=record.get("groupId")) {
		return true;
	} else {
		return false;
	}
}

/**
 * 事件处理：获取不同类型树节点的显示图标
 */
function getIcon(record){
	var recordType = record.recordType;
	if(recordType=="groupRecord"&&"S001"!=record.get("groupId")){
		return L5.webPath+"/skins/images/contact/group.png";
	} else {
		return L5.webPath+"/skins/images/contact/contactlist.png";
	}
}
/**
 * 事件处理：获得 TreebaseParams的值
 */
function getStruParent(rec){
	var groupId = rec.get("groupId");
	return groupId?groupId:"S001";
}

/**
* 事件处理：点击节点,将节点信息添加到table中
*/
function selectedStru(record){
	var url;
	var frame = document.getElementById("nodeFrame");
	if(record.recordType == "contactRecord"){
		var currentNode = L5.getCmp("strutree").getCurrentNode();
		var contactRecord = currentNode.record;
		var contactType = record.get("sysContact");
		if("1" == contactType) {
			url = "person.jsp";
		} else {
			url = "externalContact.jsp";
		}
		var url2 = '?contactId='+record.get("contactId");
		url += (url2?url2:'#');
		url = encodeURI(encodeURI(url));
		frame.src=url;
	} else {
		frame.removeAttribute("src");
	}
}

/**
 * 返回要显示联系人的方式
 */
function changeOnlineDisplayState(rec) {
	return online;
}
/**
* 事件处理：添加分组
*/
function addGroup(menuitem){
	var record = menuitem.parentMenu.record;
	L5.MessageBox.prompt("请输入分组名称", "", function(e,corptext){
		if (e == "ok") {
			var command = new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactSaveCmd");
			var status = checkGroupName(corptext);
			if(status != true){
				L5.Msg.alert("提示" , status);
			}else{
				command.setParameter("groupName", corptext);
				command.execute("addUserGroup");
				if (!command.error) {
					var groupRecord = command.getReturn("groupRecord");
					if(null == groupRecord) {
						L5.MessageBox.alert("提示", "增加分组出错!");
					}else {
						delete groupRecord.javaclass;
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
			var status = checkGroupName(corptext);
			if(status != true){
				L5.Msg.alert("提示" , status);
			}else {
				//如果新名与老名一样直接return
				if(corptext == record.get('groupName'))
					return;
				var command = new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactSaveCmd");
				command.setParameter("GROUP_ID", record.get('groupId'));
				command.setParameter("newGroupName", corptext);
				command.execute("updateUserGroup");
				if (!command.error) {
					record.set("groupName", corptext);
					record.commit();
					record.reload(true);
					L5.getCmp("strutree").getCurrentNode().expand();
				}else{ 
					L5.MessageBox.alert("错误",command.error);
				}	
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
				var command = new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactSaveCmd");
				command.setParameter("groupId", record.get('groupId'));
				command.execute("deleteGroup");
				if (!command.error) {
					var prec = record.parentRecord;
					if(prec){
						prec.remove(record);
					}
				}else{ 
					L5.MessageBox.alert("提示", command.error);
				}
			}
		}
	);	
}
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
	//假如没有输入userId就不放入pset
	if(userId.indexOf("'")!=-1) {
		L5.MessageBox.alert("提示","英文单引号为非法字符！");
		return;
	}else if(userId=="~"){
		L5.MessageBox.alert("提示","单个“~”为非法字符！");
		return;
	}
	if(userName.indexOf("'")!=-1) {
		L5.MessageBox.alert("提示","英文单引号为非法字符！");
		return;
	}else if(userName=="~"){
		L5.MessageBox.alert("提示","单个“~”为非法字符！");
		return;
	}
	if(userId.length>0) {
		userDataSet.setParameter("USER_ID@like",userId.toUpperCase());
	}
	//假如没有输入userName就不放入pset
	if(userName.length>0) {
		userDataSet.setParameter("USER_NAME@like",userName.toUpperCase());
	}
	userDataSet.load(true);
	var quw=L5.getCmp("query-users-win");
	quw.hide();//隐藏上一个窗口
	document.getElementById("usersId").value = "";
	document.getElementById("usersName").value = "";
	var win=L5.getCmp("display-users-win");	//取到display窗口
	win.show();
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
	var addCLCmd=new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactSaveCmd");
	var grid = L5.getCmp("userGrid");
	//获取被选中的记录行
	var sm=grid.getSelectionModel();
	var cell=sm.getSelections();
	if(cell.length<1){
		L5.MessageBox.alert("提示","请选择一个用户");
		return;
	}
	addCLCmd.setParameter("groupId",addUser_groupId);
	addCLCmd.setParameter("user",cell[0]);//这里friend是user型的
	addCLCmd.execute("addSysContactByUser");//执行getContactAddr
	if(!addCLCmd.error){
		userDataSet.commitChanges();
		L5.MessageBox.alert("提示","添加联系人成功!");
		var win=L5.getCmp("display-users-win");	//取到display窗口
		win.hide();
		var currentNode = L5.getCmp("strutree").getCurrentNode();
		var currentRecord = currentNode.record;			
		currentRecord.reload(true);
		currentNode.expand();
	}else{
		L5.MessageBox.alert("错误",addCLCmd.error);
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
 * 显示创建联系人窗口
 */
function show_create_contact_win(menuitem){
	var record = menuitem.parentMenu.record;
	var groupId = record.get('groupId');
	var frame = document.getElementById("nodeFrame");
	var url = "externalContact.jsp?groupId="+groupId;
	frame.src=url;

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
					var command = new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactSaveCmd");
					command.setParameter("groupId", groupRecord.get('groupId'));
					command.setParameter("memberId", contactRecord.get('memberId'));
					command.execute("deleteContact");
					if (!command.error) {
						groupRecord.remove(contactRecord);
						groupRecord.commit();
						groupRecord.reload(true);
						parentNode.expand();			
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
	var strutree = L5.getCmp("strutree");
	var contactRecord = strutree.getCurrentNode().record;
	var groupRecord = strutree.getCurrentRecord().getParent();
	var command = new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactSaveCmd");
	command.setParameter("groupId", groupRecord.get('groupId'));
	command.setParameter("memberId", contactRecord.get('memberId'));
	command.setParameter("groupName", menuitem.text);
	command.execute("changeUserGroup");
	if (!command.error) {
		menuitem.parentMenu.hide();			
		menuitem.parentMenu.parentMenu.hide();
		//刷新页面数据显示
		var rootRecord = groupRecord.getParent();
		var toGroupRecord;
		for(var i=0;i<rootRecord.getCount();i++){
			var record = rootRecord.getAt(i);
			if(record.get("groupName") == menuitem.text) {
				toGroupRecord = record;
				break;
			}
		}
		toGroupRecord.insert(contactRecord);
		groupRecord.remove(contactRecord);			
		var toGroupNode = strutree.getNodeByRecord(toGroupRecord);
		toGroupNode.expand();
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
	var command = new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactSaveCmd");
	command.setParameter("groupId", groupRecord.get('groupId'));
	command.setParameter("memberId", contactRecord.get('memberId'));
	command.execute("moveToBlackListByUser");
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
			var command = new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactSaveCmd");
			command.setParameter("newNickName", corptext);
			command.setParameter("MEMBER_ID", contactRecord.get('memberId'));
			command.execute("modifyContact");
			if (!command.error) {
				contactRecord.set("nickName", corptext);
				contactRecord.commit();
				contactRecord.reload(true);
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
	var command=new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactSaveCmd");
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
	var command=new L5.Command("org.loushang.live.contact.contactlist.cmd.ContactSaveCmd");
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
/**
* 验证分组名是否合法
*/
function checkGroupName(groupName){
	if(groupName.replace(/(^\s*)|(\s*$)/g,"") == "")
		return "分组名不能为空!";
	if((groupName.indexOf("'")!=-1)||(groupName == "~")) 
		return "分组名包含特殊字符";
	return L5.Validator["lengthUTF8"](groupName , null , 128);
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
* 事件处理：显示在线好友
*/
/*
function showOnline(menuitem){
	online = "online";
	var currentNode = L5.getCmp("strutree").getCurrentNode();
	var record = currentNode.record;
	record.reload(true);
	currentNode.expand();
}*/
/**
* 事件处理：显示全部好友
*/
/*
function showAllContact(menuitem){
	online = "offline";
	var currentNode = L5.getCmp("strutree").getCurrentNode();
	var record = currentNode.record;
	record.reload(true);
	currentNode.expand();
}
*/
/**
* 验证前台输入的字符长度（中文算3位）
*/
/*
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
}*/