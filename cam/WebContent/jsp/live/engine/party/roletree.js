function init(){
	var tree = L5.getCmp("roletree");
	tree.on("checkChange" , checkChanged);
}
/**
 * 定义根节点结构
 */
var rootdatab = {
	id : 'rootId',//唯一标志record,如果是前台配置生成record,需要指定id
	struId:'rootId',
	organId:'',
	struType:'00',
	parentId:'-1',
	struLevel:'',
	struPath:'0',
	struOrder:'',
	isLeaf:'',
	inUse:'',
	organName:'角色列表',
	shortName:'角色列表',
	organType:'0',
	organTypeName:'单位',
	struTypeName:'人力资源',
	recordType : 'struRecord'
};

/**
*  触发加载组织机构类型的record，岗位和职工类型的不加载
*/
function struLoaderTriggerb(record){
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
*  触发加载角色组类型的record
*/
function roleGroupLoaderTriggerb(record){
	var rcdTp = record.recordType;
	if(rcdTp == "struRecord"){
		return true;
	}

	return false;
}

/**
*  触发加载角色类型的record
*/
function roleLoaderTriggerb(record){
	var rcdTp = record.recordType;
	if(rcdTp == "struRecord" || rcdTp == "roleGroupRecord"){
		return true;
	}

	return false;
}

/**
 * 事件处理：获得 TreebaseParams的值
 */
function getStruParentb(rec){
	var parentId = rec.get('parentId');

	return parentId;
}
function getStruIdb(rec){
	var struId=rec.get('struId');
	return struId?struId:"rootId";
}
function getRoleGroupIdb(rec){
	var roleGroupId=rec.get('roleGroupId');
	return roleGroupId?roleGroupId:"";
}
function getStruTypeb(rec){
	var struType=rec.get('struType');
	return struType?struType:"00";
}
function getStruTypeIdb(rec){
	var struTypeId=rec.get('struTypeId');
	return struTypeId?struTypeId:"00";
}
/**
 * 事件处理：设置organId为空
 */
function getStrudisabledb(rec){
	return false;
}

function istRootb(record){
	if(record.isRoot)
		return false;
	return true;
}

function isStruRoleb(record){
	var parentRecord = record.parentRecord;
	if(parentRecord.recordType == "struRecord")
		return true;

	return false;
}

//当前节点类型返回后台作为判断查询角色参数的条件
function getNodeTypeb(record){
	if(record.isRoot)
		return "isRoot";

	return record.recordType;
}

//根据类型值获取图标路径
function getIconb(record){
	var figpath=L5.webPath + "/skins/images";
	var file=figpath + "/l5/bsp_rolegroup.gif";
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
	if(rcdTp == "roleRecord"){
		if(record.get('roleId')=='PUBLIC'  ){
			file = figpath + "/l5/role_public.gif";
		}
		else if(record.get('roleId')=='SUPERADMIN'){
			file = figpath + "/l5/role_superadmin.gif";
		}
		else{
			file = figpath + "/l5/role.gif";
		}

	}
	return file;
}

/**
* 事件处理：点击节点显示维护页面
*/
function selectedNodeb(record){
	/*var ds = L5.DatasetMgr.lookup('queryRole');
	ds.removeAll();
	ds.add([record]);*/
}



function handlerb(record){
    if(record.get("struId")=="rootId"){
    	return true;
    }
    return false;
}

function handlerOtherb(record){
	if(record.get("struType")!="00"){
    	return true;
    }
    return false;
}

/**
*点击确定按钮触发事件
*/
function Evt_addrole_click(){
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
	var queryRole = L5.DatasetMgr.lookup("queryRole");
	for(var i=0; i<queryRole.getCount(); i++){
		//在界面上将名称显示出来			
		//在界面上将名称显示出来			
			partyName += queryRole.getAt(i).get("roleName");
			partyName += ";"

			//将id，名称和类型以
			partyInfo += queryRole.getAt(i).get("roleId")+","; 
			partyInfo += queryRole.getAt(i).get("roleName")+",";			
			partyInfo += "r;";
	}				
	//返回操作后的参数
	openerDoc.getElementById("partyName").value = partyName;
	openerDoc.getElementById("partyInfo").value = partyInfo;
	window.parent.close();
}
function Evt_addundo_click()
{
	window.parent.parent.close();
}

function selectedStruNodeb(record)
{}
function checkbox(rec)
{
	return "checkbox";
}

function checkChanged(node){
	//选中
	if(node.ui.checkbox.checked)
	{
		//将节点展开
		//node.expand(true);
		var queryRole = L5.DatasetMgr.lookup("queryRole");
		queryRole.add(node.record);
	}else{
		var queryRole = L5.DatasetMgr.lookup("queryRole");
		queryRole.remove(node.record);
	}
}
function addRole(){
	//角色树只添加子节点即可
	//为了避免重复值当前先移除所有
	var queryRole = L5.DatasetMgr.lookup("queryRole");
	queryRole.removeAll();
	
	var roletree = L5.getCmp("roletree");
	//得到选中节点
	var checkedNodes = roletree.getChecked();
	
	//过滤掉非叶子节点
	for(var i=0; i<checkedNodes.length; i++){
		var nodeId = roletree.id + "_" + checkedNodes[i];
		var node = roletree.getNodeById(nodeId);
		//判断这个node是否为子节点，不是子节点直接过滤掉
		if(node.record.get("organType") == null){
			queryRole.add(node.record);
		}
	}
	queryRole.commitChanges();
}
function removeRole()
{
	var queryRole = L5.DatasetMgr.lookup("queryRole");
	var roleGridPanel = L5.getCmp("roleGridPanel");
	//获取被选中的记录行
	var sm = roleGridPanel.getSelectionModel();
	var cell = sm.getSelections();
	if(cell){
		for(var i=0; i<cell.length; i++){
			queryRole.remove(cell[i]);
		}
	}
}