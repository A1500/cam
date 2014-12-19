function init(){
	var tree = L5.getCmp("departtree");
	tree.on("checkChange" , checkChanged);
}
/**
 * 定义根节点结构
 */
var rootdataa = {
	id : 'rootId',//唯一标志record,如果是前台配置生成record,需要指定id
	struId:'',
	organId:'',
	struType:'00',
	parentId:'-1',
	struLevel:'',
	struPath:'0',
	struOrder:'',
	isLeaf:'',
	inUse:'',
	organName:'用户列表',
	shortName:'用户列表',
	organType:'0',
	organTypeName:'单位',
	struTypeName:'人力资源',
	recordType : 'struRecord'
};
/**
*  触发加载用户类型的record
*/
function userLoaderTriggera(record){
	var rcdTp = record.recordType;
	if(rcdTp == "struRecord"){
		return true;
	}
	return false;
}
/**
*  触发加载组织机构类型的record，岗位和职工类型的不加载
*/
function struLoaderTriggera(record){
	var rcdTp = record.recordType;
	if(rcdTp == "struRecord"){
		var organType = record.get('organType');
		var type = parseInt(organType.substring(0, 1));
		if(type == 0 || type == 1 || type == 2){
			return true;
		}
	}
	return false;
}

/**
 * 事件处理：获得 TreebaseParams的值
 */
function getStruParenta(rec){
	var parentId = rec.get('parentId');
	return parentId;
}
function getStruIda(rec){
	var struId=rec.get('struId');
	return struId?struId:"rootId";
}
function getOrganTypea(rec){
	var organType = rec.get('organType');
	return organType?organType:"0";
}
function getOrganIda(rec){
	var organId = rec.get('organId');
	return organId?organId:"rootId";
}
function getStruTypea(rec){
	var struType=rec.get('struType');
	return struType?struType:"00";
}
function getStruTypeIda(rec){
var struTypeId=rec.get('struTypeId');
	return struTypeId?struTypeId:"00";
}
/**
 * 事件处理：设置organId为空
 */
function getStrudisableda(rec){
	return false;
}

//当前节点类型返回后台作为判断查询用户参数的条件
function getNodeTypea(record){
	if(record.isRoot)
		return "isRoot";

	return record.recordType;
}
/**
* 事件处理：点击节点显示维护页面
*/
function selectedStruNodea(record)
{

}
//根据类型值获取图标路径
function getIcona(record){
	var figpath=L5.webPath + "/skins/images";
	var file=figpath + "/l5/bsp_department&corporation.gif";
	if(!record){
		return file;
	}
	var rcdTp = record.recordType;
	if(rcdTp == "struRecord"){
		var organType = record.get('organType');
		var type = organType.substring(0, 1);
		var value = parseInt(type);
		switch(value){
			case 0: //根结点
				file = figpath + "/l5/root.gif";
				break;
			case 1: // 法人
				file = figpath +"/l5/bsp_department&corporation.gif";
				break;
			case 2: // 部门
				file = figpath + "/l5/bsp_department&corporation.gif";
				break;
			default:
				file = figpath + "/other_img.gif";
		}
		return file;
	}


	if(rcdTp == "userRecord"){
		file = figpath + "/l5/bsp_employee.gif";
	}
	return file;
}
function selectedNodea(record){
}
function checkbox(rec)
{
	//如果是根节点则不显示checkbox
	if(rec.get('parentId') == -1)
	{
		return "";
	}
	return "checkbox";
}
function checkChanged(node , checked)
{
	addUser();	
}


function addUser()
{
	//为了避免重复值当前先移除所有
	var queryDepart = L5.DatasetMgr.lookup("queryDepart");
	queryDepart.removeAll();
	var departtree = L5.getCmp("departtree");
	//得到选中节点
	var checkedNodes = departtree.getChecked();
	var treeIdLengh = departtree.id.length;
	for(var i=0; i<checkedNodes.length; i++)
	{
		var nodeId = departtree.id + "_" + checkedNodes[i];
		var node = departtree.getNodeById(nodeId);
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
		nodeId = departtree.id + "_" + checkedNodes[i];
		node = departtree.getNodeById(nodeId);
		var newRecord = queryDepart.newRecord();
		//判断是个组织还是个用户
		if(node.record.get("organType") == null)
		{
			newRecord.set("struId" , node.record.get("userId"));
			newRecord.set("organName" , node.record.get("userName"));
			newRecord.set("organType" , "u");
		}
		else{
			newRecord.set("struId" , node.record.get("struId"));
			newRecord.set("organName" , node.record.get("organName"));
			newRecord.set("organType" , "o");
		}
	}	
	queryDepart.commitChanges();
}
/*
function removeUser()
{
	var queryDepart = L5.DatasetMgr.lookup("queryDepart");
	var departGridPanel = L5.getCmp("departGridPanel");
	//获取被选中的记录行
	var sm = departGridPanel.getSelectionModel();
	var cell = sm.getSelections();
	if(cell){
		for(var i=0; i<cell.length; i++){
			queryDepart.remove(cell[i]);
		}
	}
}*/
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
	var queryDepart = L5.DatasetMgr.lookup("queryDepart");
	for(var i=0; i<queryDepart.getCount(); i++){
		//在界面上将名称显示出来			
		if(queryDepart.getAt(i).get("organType")=="o"){
			partyName += queryDepart.getAt(i).get("organName");
			partyName += ";"

			//将id，名称和类型以","分割存储
			partyInfo += queryDepart.getAt(i).get("struId")+","; 
			partyInfo += queryDepart.getAt(i).get("organName")+",";
			partyInfo += "o;";
		}else{	
			partyName += queryDepart.getAt(i).get("organName");
			partyName += ";"
			//将id，名称和类型以","分割存储
			partyInfo += queryDepart.getAt(i).get("struId")+","; 
			partyInfo += queryDepart.getAt(i).get("organName")+",";			
			partyInfo += "u;";
		}				
	}		
	//返回操作后的参数
	openerDoc.getElementById("partyName").value = partyName;
	openerDoc.getElementById("partyInfo").value = partyInfo;
	window.parent.close();
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
	window.parent.close();
}
//用户名处理函数
function userName(rec){
	//用户
	if(rec.get("userName") != null){
		return rec.get("userName") + "(" + rec.get("userId") + ")";
	}
	//单位
	else{
		return rec.get("organName");
	}
}