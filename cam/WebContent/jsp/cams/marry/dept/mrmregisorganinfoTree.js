function init(){
	var tree = L5.getCmp('usertree');
	tree.root.expand();
}
var rootdata = {
	id:'rootId',
	name:'婚姻登记机构',
	leve:'0',
	ups:'',
	organId:'',
	organName:'',
	userId:'',
	userName:'',
	recordType:'cityRecord'
};
/**
 *  触发加载组织机构类型的record，岗位和职工类型的不加载
*/
function cityTrigger(record){
	var rcdTp=record.recordType;
	if(rcdTp=="cityRecord"){
		var type=parseInt(record.get('leve'));
		if(type==0){
			return true;
		}
	}
	return false;
}

/**
*  触发加载用户类型的record
*/
function organTrigger(record){
	var rcdTp=record.recordType;
	if(rcdTp=="cityRecord"){
		var type=parseInt(record.get('leve'));
		if(type > 0) {	
			return true;
		}
	}
	rcdTp=="organRecord";
	return false;
}
function userTrigger(record){
	var rcdTp=record.recordType;
	if(rcdTp=="organRecord"){
		return true;
	}
	return false;
}

//事件处理：获得 TreebaseParams的值
function getId(rec){
	var type=rec.recordType;
	if(type=="cityRecord"){
		var id=rec.get('id');
		return id ? id : "rootId";
	}
	if(type=="organRecord"){

		return rec.get('organId');
	}
}
function getName(rec){
	var type=rec.recordType;
	if(type=="cityRecord"){
		return rec.get('name');
	}
	if(type=="organRecord"){
		return rec.get('name');
	}
	if(type=="userRecord"){
		return rec.get('userName');
	}
}
function getLeve(rec){
	return rec.get('leve');
}
function getUps(rec){
	return rec.get('ups');
}
function getOrganId(rec){
	return rec.get('organId');
}
function getOrganName(rec){
	return rec.get('name');
}
function getOrganType(rec){
	return rec.get('organType');
}
function getUserId(rec){
	return rec.get('userId');
}
function getUserName(rec){
	return rec.get('userName');
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
	if(rcdTp == "cityRecord"){
		var value = parseInt(record.get('leve'));
		switch(value){
			case 0: //省
				file = figpath + "/l5/other.gif";
				break;
			case 1: //市
				file = figpath +"/l5/other.gif";
				break;
			case 2: //县
				file = figpath + "/l5/other.gif";
				break;
			default:
				file = figpath + "/l5/module.gif";
		}
		return file;
	}
	if(rcdTp == "organRecord"){
		file = figpath + "/l5/module.gif";
	}
	if(rcdTp == "userRecord"){
		file = figpath + "/l5/bsp_employee.gif";
	}
	return file;
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

function selectedNode(record){
	var frame=document.getElementById("nodeFrame");
	if(record.recordType=="organRecord"){
    	var url="mrmregisorganinfo_edit.jsp?method=UPDATE&organId="+record.get("organId")+"&regionCode="+record.get("regionCode")+"&regionName="+encodeURIComponent(encodeURIComponent(record.get("regionName")));

		frame.setAttribute("src", url);
	}else if(record.recordType=="userRecord"){
		var url="../person/mrmbaseperson_edit.jsp?method=update&userId="+record.get("userId");
		frame.setAttribute("src", url);
	}else{
		return;
	}
}

//增加单位
function addOrgan(menuitem){
	var record=menuitem.parentMenu.record;
	var frame = document.getElementById("nodeFrame");
	var url="mrmregisorganinfo_edit.jsp?method=INSERT&regionCode="+record.get("id")+"&regionName="+encodeURIComponent(encodeURIComponent(record.get("name")));
	//var url="comExtOrganEdit.jsp?method=insert&id="+record.get("id")+"&name="+encodeURIComponent(encodeURIComponent(record.get("name")));
	frame.setAttribute("src", url);
}
//删除单位
function delOrgan(menuitem){
	var record = menuitem.parentMenu.record;
	if(record.recordType != "organRecord"){
		return;
	}
	var organId = record.get("organId");
	L5.MessageBox.confirm("提示", "删除单位将同步删除该单位下的用户，确定删除？",function(sta){
		if(sta=="yes"){
			var command = new L5.Command("com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoCommand");
			command.setParameter("organId", organId);
			command.execute("deleteOrgan");
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
		}else return;
	});
}
//增加用户
function addUser(menuitem){
	var record=menuitem.parentMenu.record;
	var frame = document.getElementById("nodeFrame");
	var url="../person/mrmbaseperson_edit.jsp?method=insert&organId="+record.get("organId")
		+"&organName="+encodeURIComponent(encodeURIComponent(record.get("organName")))
		+"&organType="+record.get("organType")
		+"&areaCode="+record.get("areaCode")
		+"&areaName="+encodeURIComponent(encodeURIComponent(record.get("areaName")));
	frame.setAttribute("src", url);
}
//删除用户
function delUser(menuitem){
	var record = menuitem.parentMenu.record;
	if(record.recordType != "userRecord"){
		return;
	}
	var userId = record.get("userId");
	L5.MessageBox.confirm("提示", "确定删除该用户？",function(sta){
		if(sta=="yes"){
			var command = new L5.Command("com.inspur.cams.comm.extuser.cmd.ComExtUserCmd");
			command.setParameter("userId", userId);
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
		}else return;
	});
}

//查询用户
function queryUser(menuitem){
	var frame = document.getElementById("nodeFrame");
    var url;
	url = "user_list.jsp";
	frame.setAttribute("src", url);
}