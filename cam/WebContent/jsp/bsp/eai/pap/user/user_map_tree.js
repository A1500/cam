function init(){
  var tree = L5.getCmp('usertree');
  tree.root.expand();
  var frame = document.getElementById("nodeFrame");
  var url;
	url = "user_role.jsp"
	frame.setAttribute("src", url);
}

/**
 * 定义根节点结构
 */
var rootdata = {
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
	organName:'用户树',
	shortName:'用户树',
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
*  触发加载用户类型的record
*/
function userLoaderTrigger(record){
	var rcdTp = record.recordType;
	if(rcdTp == "struRecord"){
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
function getOrganType(rec){
	var organType = rec.get('organType');
	return organType?organType:"0";
}
function getOrganId(rec){
	var organId = rec.get('organId');
	return organId?organId:"rootId";
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

//当前节点类型返回后台作为判断查询用户参数的条件
function getNodeType(record){
	if(record.isRoot)
		return "isRoot";

	return record.recordType;
}

function istRoot(record){
	if(record.isRoot)
		return false;
	return true;
}
function isRoot(record){
	if(record.isRoot)
		return true;
	return false;
}

//根据类型值获取图标路径
function getIcon(record){
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

/**
* 事件处理：点击节点显示维护页面
*/
function selectedNode(record){
//	var win = window.frames["appFrame"].window;
	if(record.recordType != "userRecord"){
		return;
	}
	var userId=record.get("userId");
	var parentRecord = record.parentRecord;
	var frame = document.getElementById("nodeFrame");
    var url;
	url = "role_assigned.jsp?userId="+userId;
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

//定义用户
function  addUser(menuitem){
	var record=menuitem.parentMenu.record;
	var frame = document.getElementById("nodeFrame");
    var url;
	url = "user_edit.jsp?method=INSERT";
	url+="&struId="+encodeURIComponent(encodeURIComponent(record.get("struId")));
	url+="&deptName="+encodeURIComponent(encodeURIComponent(record.get("organName")));
	url+="&deptId="+encodeURIComponent(encodeURIComponent(record.get("deptId")));
	url+="&corpId="+encodeURIComponent(encodeURIComponent(record.get("cropId")));
	frame.setAttribute("src", url);
}

//查询用户
function  queryUser(menuitem){
	var frame = document.getElementById("nodeFrame");
    var url;
	url = "user_role.jsp";
	frame.setAttribute("src", url);
}


//删除用户
function  delUser(menuitem){
	var record = menuitem.parentMenu.record;
	if(record.recordType != "userRecord"){
		return ;
	}
	var primeKey = record.get("userId");
	L5.MessageBox.confirm(RES_PROMOT, RES_DELETE,function(sta){
		if(sta=="yes"){
			var command = new L5.Command("org.loushang.bsp.eai.pap.user.cmd.UserCmd");
			command.setParameter("delId", primeKey);
			//command.execute("validateDelete");
			//var retMes = command.getReturn("return");
			//if(retMes.size()>0){//存在正在被使用的
				//alert(alert_delete_mes+mes);
			//}else{
				command.execute("delete");
				if (!command.error) {
					var prec = record.parentRecord;
					if(prec){
						prec.remove(record);
					}
					L5.Msg.alert('提示','删除成功');
					var frame = document.getElementById("nodeFrame");
                	frame.setAttribute("src", "");

				}else{
					L5.Msg.alert(command.error);
				}
			//}
		}else return;
	});
}
function getUserInfo(record){
	var rcdTp = record.recordType;
	if(rcdTp == "userRecord"){
		var userId=record.get("userId");
		var userName=record.get("userName");
		if(userName!=null&&userName!='')
		return userId+"【"+userName+"】";
		else
			return userId;
	}
	return "";
}
