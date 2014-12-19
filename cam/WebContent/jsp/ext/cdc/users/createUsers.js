function init(){
	var tree = L5.getCmp('usertree');
	tree.root.expand();
}
var rootdata = {
	id:'rootId',
	name:'用户树',
	leve:'0',
	ups:'',
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
		if(type==0||type==1){
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
		return true;
	}
	return false;
}

function userTrigger(record){
	var rcdTp=record.recordType;
	if(rcdTp=="cityRecord"){
		var type=parseInt(record.get('leve'));
		if(type==3){
			return true;
		}
	}
	return false;
}

//事件处理：获得 TreebaseParams的值
function getId(rec){
	var type=rec.recordType;
	if(type=="userRecord"){
		var id=userId
		return id ? id : "rootId";
	}
	if(type=="cityRecord"){
		var id=userId;
		return id ? id : "rootId";
	}
}
function getName(rec){
	var type=rec.recordType;
	if(type=="cityRecord"){
		return rec.get('name');
	}
	if(type=="organRecord"){
		return rec.get('organName');
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
	return rec.get('organName');
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
			case 3: //街道,乡镇
				file = figpath + "/l5/other.gif";
				break;
			case 4: //社区
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
		file = figpath + "/l5/other.gif";
	}
	return file;
}


function selectedNode(record){
	var frame=document.getElementById("nodeFrame");
	if(record.get("communityType")=="N"){
		var url="villageList.jsp?userId="+record.get("areaCode")+"&userName="+encodeURIComponent(encodeURIComponent(record.get("areaName")));
	}else{
		var url="cityDetail.jsp?userId="+record.get("userId")+"&userName="+encodeURIComponent(encodeURIComponent(record.get("userName")));
	}
	frame.setAttribute("src", url);
}

//增加农村社区
function addOrgan(menuitem){
	var record=menuitem.parentMenu.record;
	if(record.get("id")=="rootId"){
		L5.Msg.alert("提示","请在街道名称处右击");
		return false;
	}
	var frame = document.getElementById("nodeFrame");
	var url="villageCommunityEdit.jsp?method=insert&id="+record.get("id")+"&name="+encodeURIComponent(encodeURIComponent(record.get("name")));
	frame.setAttribute("src", url);
}
//增加城市社区
function addCity(menuitem){
	var record=menuitem.parentMenu.record;
	if(record.get("id")=="rootId"){
		L5.Msg.alert("提示","请在街道名称处右击");
		return false;
	}
	var frame = document.getElementById("nodeFrame");
	var url="cityList.jsp?method=insert&id="+record.get("id")+"&name="+encodeURIComponent(encodeURIComponent(record.get("name")))+"&type="+record.getCommunityType;
	frame.setAttribute("src", url);
}
function editUser(menuitem){
	var record=menuitem.parentMenu.record;
	var frame = document.getElementById("nodeFrame");
	var url="villageCommunityEdit.jsp?method=update&userId="+record.get("userId")+"&name="+encodeURIComponent(encodeURIComponent(record.get("userName")))+"&type="+record.getCommunityType;
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
			command.execute("deleteUser");
			var tips = command.getReturn("tips");
			if(tips){
				L5.Msg.alert('提示',tips);
				return false;
			}
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

