/**
 * 定义根节点结构
 */ 
var rootdata = {
	groupId:'-1',
	groupName:'系统联系人',
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

function addUser(){
	//为了避免重复值当前先移除所有
	var userDs = L5.DatasetMgr.lookup("userDs");
	userDs.removeAll();
	var strutree = L5.getCmp("strutree");
	//得到选中节点
	var checkedNodes = strutree.getChecked();
	var treeIdLengh = strutree.id.length;
	for(var i=0; i<checkedNodes.length; i++)
	{
		var nodeId = strutree.id + "_" + checkedNodes[i];
		var node = strutree.getNodeById(nodeId);
		removeChildNodes(node.childNodes , checkedNodes , treeIdLengh);
	}	
	for(var i=checkedNodes.length-1; i>=0 ;i--)
	{
		var nodeId = departtree.id + "_" + checkedNodes[i];
		var node = departtree.getNodeById(nodeId);
		removeChildNodes(node.childNodes , checkedNodes , treeIdLengh);
	}
	//将过滤后的节点放到dataset中
	for(i=0; i<checkedNodes.length; i++)
	{
		nodeId = strutree.id + "_" + checkedNodes[i];
		node = strutree.getNodeById(nodeId);
		var newRecord = userDs.newRecord();
		//判断是个分组还是个用户
		if(node.record.get("contactId") == null)
		{
			newRecord.set("userId" , node.record.get("groupId"));
			newRecord.set("userName" , node.record.get("groupName"));
			newRecord.set("userType" , "d");
		}
		else{
			newRecord.set("userId" , node.record.get("contactId"));
			newRecord.set("userName" , node.record.get("nickName"));
			newRecord.set("userType" , "u");
		}	
	}	
	//清空状态
	userDs.commitChanges();
}
function removeUser(){
	var userDs = L5.DatasetMgr.lookup("userDs");
	var userGridPanel = L5.getCmp("userGridPanel");
	//获取被选中的记录行
	var sm = userGridPanel.getSelectionModel();
	var cell = sm.getSelections();
	if(cell){
		for(var i=0; i<cell.length; i++){
			userDs.remove(cell[i]);
		}
	}
}

//递归移除子节点
function removeChildNodes(childNodes , checkedNodes , treeIdLength)
{
	if(childNodes != null)
	{
		for(var i=0; i<childNodes.length; i++)
		{
			checkedNodes.remove(childNodes[i].id.substr(treeIdLength+1));
			removeChildNodes(childNodes[i].childNodes , checkedNodes , treeIdLength);
		}
	}
}

function Evt_adduser_cancel()
{
	var win = window.parent.parent.L5.getCmp("treewnd");
	win.hide();
}
function nickName(rec){
	return rec.get("nickName") + "(" + rec.get("contactId") + ")";
}

function checkbox(rec)
{
	if(!rec.isRoot)
		return "checkbox";
}
function checkChanged(node , checked)
{	
	addUser();	
}


function Evt_adduser_click()
{
	var openerDoc = window.parent.opener.document;
	//取得对话框参数
	var partyName = decodeURI(openerDoc.getElementById("partyName").value);
	var partyInfo = decodeURI(openerDoc.getElementById("partyInfo").value);  

	//如果最后一个不是“;”添加一个
	if(partyInfo!=""&&partyInfo.substring(partyInfo.length-1,partyInfo.length)!=";"){
		partyInfo = partyInfo+";";
	}	
	//如果最后一个不是“;”添加一个
	if(partyName!=""&&partyName.substring(partyName.length-1,partyName.length)!=";"){
		partyName = partyName+";";
	}
	var userDs = L5.DatasetMgr.lookup("userDs");
	for(var i=0; i<userDs.getCount(); i++){
		//在界面上将名称显示出来			
		partyName += userDs.getAt(i).get("userName");
		partyName += ";"
		//将id，名称和类型以","分割存储
		partyInfo += userDs.getAt(i).get("userId")+","; 
		partyInfo += userDs.getAt(i).get("userName")+",";
		partyInfo += userDs.getAt(i).get("userType")+";";;				
	}		
	//返回操作后的参数
	openerDoc.getElementById("partyName").value = partyName;
	openerDoc.getElementById("partyInfo").value = partyInfo;
	window.parent.close();
}


function Evt_adduser_cancel()
{
	window.parent.parent.close();
}