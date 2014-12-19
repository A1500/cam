function init(){
  var tree = L5.getCmp('roletree');
  tree.root.expand();
}

/**
 * 定义根节点结构
 */
var rootdata = {
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
	organName:'角色树',
	shortName:'角色树',
	organType:'0',
	organTypeName:'单位',
	struTypeName:'人力资源',
	recordType : 'struRecord'
};

/**
*  触发加载组织机构类型的record，岗位和职工类型的不加载
*/
function struLoaderTrigger(record){
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
function roleGroupLoaderTrigger(record){
	var rcdTp = record.recordType;
	if(rcdTp == "struRecord"){
		return true;
	}

	return false;
}

/**
*  触发加载角色类型的record
*/
function roleLoaderTrigger(record){
	var rcdTp = record.recordType;
	if(rcdTp == "struRecord" || rcdTp == "roleGroupRecord"){
		return true;
	}

	return false;
}

/**
 * 事件处理：获得 TreebaseParams的值
 */
function getStruParent(rec){
	var parentId = rec.get('parentId');

	return parentId;
}
function getStruId(rec){
	var struId=rec.get('struId');
	return struId?struId:"rootId";
}
function getRoleGroupId(rec){
	var roleGroupId=rec.get('roleGroupId');
	return roleGroupId?roleGroupId:"";
}
function getStruType(rec){
	var struType=rec.get('struType');
	return struType?struType:"00";
}
function getStruTypeId(rec){

	return struTypeId?struTypeId:"00";
}
/**
 * 事件处理：设置organId为空
 */
function getStrudisabled(rec){
	return false;
}

function istRoot(record){
	if(record.isRoot)
		return false;
	return true;
}

function isStruRole(record){
	var parentRecord = record.parentRecord;
	if(parentRecord.recordType == "struRecord")
		return true;

	return false;
}

//当前节点类型返回后台作为判断查询角色参数的条件
function getNodeType(record){
	if(record.isRoot)
		return "isRoot";

	return record.recordType;
}

//根据类型值获取图标路径
function getIcon(record){
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
function selectedNode(record){
//	var win = window.frames["appFrame"].window;
	if(record.recordType != "roleRecord"){
		return ;
	}

	var parentRecord = record.parentRecord;
	var frame = document.getElementById("nodeFrame");
    var url;
	url = "role_edit.jsp?method=UPDATE" +
	"&primeKey=" + encodeURIComponent(encodeURIComponent(record.get("roleId"))) +
	"&struId=" + encodeURIComponent(encodeURIComponent(record.get("relationId"))) +
	"&organName=" + encodeURIComponent(encodeURIComponent(parentRecord.get("organName"))) +
	"&roleGroupId=" + encodeURIComponent(encodeURIComponent(record.get("roleGroupId"))) +
	"&roleGroupName=" + encodeURIComponent(encodeURIComponent(parentRecord.get("roleGroupName"))) +
	"&prePage=role_tree";
	//如果之前显示的页面也是维护页面，点击其他角色节点时不再刷新页面只加载用户数据
	//if(frame.src && (frame.src.indexOf("role_edit.jsp?method=UPDATE") != -1)){
		//window.frames["nodeFrame"].window.setDisplay(record.get("relationId"), record.get("roleGroupId"));
	//	window.frames["nodeFrame"].window.loadRole(record.get("roleId"), false);
	//} else {
		frame.setAttribute("src", url);
	//}
}

function selectedStruNode(record){
	if(record.recordType != "struRecord"){
		return ;
	}
	if(record.get('struId')==""){
		return;
	}
	var parentRecord = record.parentRecord;
	var frame = document.getElementById("nodeFrame");
    var url;
	url = "role_edit.jsp?method=UPDATE&delwith=true"+
	"&prePage=role_tree";
//	url+="&primeKey="+encodeURIComponentComponent(encodeURIComponentComponent(record.get("userId")));
//	url+="&struId="+encodeURIComponentComponent(encodeURIComponentComponent(parentRecord.get("struId")));
	frame.setAttribute("src", url);
}

function handler(record){
    if(record.get("struId")=="rootId"){
    	return true;
    }
    return false;
}

function handlerOther(record){
	if(record.get("struType")!="00"){
    	return true;
    }
    return false;
}

//定义角色
function  addRole(menuitem){
	var record=menuitem.parentMenu.record;
	var frame = document.getElementById("nodeFrame");
    var url;
	url = "role_edit.jsp?method=INSERT"+
	"&struId="+encodeURIComponent(encodeURIComponent(record.get("struId")))+
	"&organName="+encodeURIComponent(encodeURIComponent(record.get("organName")))+
	"&prePage=role_tree";
	frame.setAttribute("src", url);
}

//删除角色
function  delRole(menuitem){
	var record = menuitem.parentMenu.record;
	if(record.recordType != "roleRecord"){
		return ;
	}

	var primeKey = record.get("roleId");
	L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
		if(sta=="yes"){
			var command = new L5.Command("org.loushang.bsp.permit.pap.role.cmd.RoleCommand");
			command.setParameter("delIds", new Array(primeKey));
			command.execute("delete");
			if (!command.error) {
				var prec = record.parentRecord;
				if(prec){
					prec.remove(record);
				}
				L5.Msg.alert('提示','删除成功');
			}else{
				L5.Msg.alert('出错',command.error);
			}
		}
		else
			return;
	});
}

//导出角色
function  exportRole(menuitem){
	// TODO
	alert("导出角色");
}

//导入角色
function  importRole(menuitem){
	// TODO
	alert("导入角色");
}
//转向批量授权页面
function batchAuthorized(menuitem){
	var record = menuitem.parentMenu.record;
	var prec = record.parentRecord;
	var roleId=record.get("roleId");
	var organId=prec.get("organId");
	var userId=window.showModalDialog("batch_authorized.jsp?roleId="+roleId+"&organId="+organId,"","dialogHeight:500px;dialogWidth:500px;resizable:no;scroll:no;status:no;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);
}