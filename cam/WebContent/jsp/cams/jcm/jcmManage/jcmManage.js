function init(){
	var tree = L5.getCmp('companytree');
	tree.root.expand();
	
	var frame=document.getElementById("nodeFrame");
	var url="../companyManage/jcmCompanyProfileDetail.jsp?companyId=ABEA145B8EA947268912100D8CB4327B";
	frame.setAttribute("src", url);
}
var rootdata = {
	companyId:'ABEA145B8EA947268912100D8CB4327B',
	companyName:'山东省民政厅',
	organType:'0',
	orderCompanyId:'',
	peopleId:'',
	peopleName:'',
	recordType:'cityRecord'
};
/**
 *  触发加载组织机构类型的record，岗位和职工类型的不加载
*/
function cityTrigger(record){
	var rcdTp=record.recordType;
	if(rcdTp=="cityRecord"){
		var type=parseInt(record.get('organType'));
		if(type==0||type==1){
			return true;
		}
	}
	return false;
}

function handlerOther(record){
	if(record.get("organType")=="1"){
    	return true;
    }
    return false;
}

function userTrigger(record){
	
//	var rcdTp=record.recordType;
//	if(rcdTp=="cityRecord"){
//		var type=parseInt(record.get('organType'));
//		if(type==1){
//			return true;
//		}
//	}
//	return false;
	return true;
}

//事件处理：获得 TreebaseParams的值
function getId(rec){
	var type=rec.recordType;
	if(type=="userRecord"){
		var id=rec.get("companyId");
		return id ? id : "rootId";
	}
	if(type=="cityRecord"){
		var id=rec.get("companyId");
		return id ? id : "rootId";
	}
}
function getName(rec){
	var type=rec.recordType;
	if(type=="cityRecord"){
		return rec.get('companyName');
	}
	if(type=="organRecord"){
		return rec.get('organName');
	}
	if(type=="userRecord"){
		return rec.get('userName');
	}
}
function getLeve(rec){
	return rec.get('organType');
}
function getUps(rec){
	return rec.get('orderCompanyId');
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
function getPeopleId(rec){
	return rec.get('peopleId');
}
function getPeopleName(rec){
	return rec.get('peopleName');
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
		var value = parseInt(record.get('organType'));
		switch(value){
			case 0: // 法人
				file =figpath+"/l5/bsp_department&corporation.gif";
				break;
			case 1: // 岗位
				file = figpath+"/l5/bsp_post.png";
				break;
			default:
				file =figpath+ "/l5/other.gif";
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


function selectedNode(record){
	var frame=document.getElementById("nodeFrame");
	if(record.get("communityType")=="N"){
		var url="villageList.jsp?userId="+record.get("areaCode")+"&userName="+encodeURIComponent(encodeURIComponent(record.get("areaName")));
	}else{
		var url="cityDetail.jsp?userId="+record.get("userId")+"&userName="+encodeURIComponent(encodeURIComponent(record.get("userName")));
	}
	frame.setAttribute("src", url);
}

//单位信息点击
function comSelect(record){
	var frame=document.getElementById("nodeFrame");
	var url="../companyManage/jcmCompanyProfileDetail.jsp?companyId="+record.get("companyId");
	frame.setAttribute("src", url);
}


//单位信息点击
function peoSelect(record){
	var frame=document.getElementById("nodeFrame");
	var url="../peopleManage/jcmPeopleInfoDetail.jsp?peopleId="+record.get("peopleId");
	frame.setAttribute("src", url);
}
//增加单位
function addOrgan(menuitem){
	var record=menuitem.parentMenu.record;
	var frame = document.getElementById("nodeFrame");
	var url="../companyManage/jcmCompanyProfileEdit.jsp?method=insert&companyId="+record.get("companyId")+"&organType=0";
	frame.setAttribute("src", url);
}

//增加单位
function editOrgan(menuitem){
	var record=menuitem.parentMenu.record;
	var frame = document.getElementById("nodeFrame");
	var url="../companyManage/jcmCompanyProfileEdit.jsp?method=update&companyId="+record.get("companyId")+"&organType=0";
	frame.setAttribute("src", url);
}
//增加部门
function addDept(menuitem){
	var record=menuitem.parentMenu.record;
	var frame = document.getElementById("nodeFrame");
	var url="../companyManage/jcmCompanyProfileEdit.jsp?method=insert&companyId="+record.get("companyId")+"&organType=1";
	frame.setAttribute("src", url);
}
//增加部门
function editDept(menuitem){
	var record=menuitem.parentMenu.record;
	var frame = document.getElementById("nodeFrame");
	var url="../companyManage/jcmCompanyProfileEdit.jsp?method=update&companyId="+record.get("companyId")+"&organType=1";
	frame.setAttribute("src", url);
}
//增加人员
function addPeo(menuitem){
	var record=menuitem.parentMenu.record;
	var frame = document.getElementById("nodeFrame");
	var url="../peopleManage/jcmPeopleInfoEdit.jsp?method=insert&companyId="+record.get("companyId");
	frame.setAttribute("src", url);
}
function editUser(menuitem){
	var record=menuitem.parentMenu.record;
	var frame = document.getElementById("nodeFrame");
	var url="../peopleManage/jcmPeopleInfoEdit.jsp?method=update&peopleId="+record.get("peopleId");
	frame.setAttribute("src", url);
}
//删除用户
function delUser(menuitem){
	var record = menuitem.parentMenu.record;
	var peopleId = record.get("peopleId");
	L5.MessageBox.confirm("提示", "确定删除该人员？",function(sta){
		if(sta=="yes"){
			var command = new L5.Command("com.inspur.cams.jcm.cmd.JcmPeopleInfoCmd");
			command.setParameter("peopleId", peopleId);
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

//删除单位
function delCom(menuitem){
	var record = menuitem.parentMenu.record;
	var companyId = record.get("companyId");
	L5.MessageBox.confirm("提示", "确定删除？",function(sta){
		if(sta=="yes"){
			var command = new L5.Command("com.inspur.cams.jcm.cmd.JcmCompanyProfileCmd");
			command.setParameter("companyId", companyId);
			command.execute("deleteCom");
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

