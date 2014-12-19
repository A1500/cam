function init(){
	var tree=L5.getCmp('usertree');
	tree.root.expand();
}
var rootdata = {
	id:'rootId',
	name:'社区树',
	leve:'0',
	ups:'',
	organId:'',
	organName:'',
	userId:'',
	userName:'',
	recordType:'cityRecord'
};
//dic_city触发，点击省、市、县时查询dic_city下级
function cityTrigger(record){
	var rcdTp=record.recordType;
	if(rcdTp=="cityRecord"){
		var leve=parseInt(record.get('leve'));
		if(leve==0||leve==1||leve==2){
			return true;
		}
	}
	return false;
}
//com_ext_user触发，点击街道时查询com_ext_user
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
//传入查询条件
function getId(rec){
	var type=rec.recordType;
	if(type=="cityRecord"){
		var id=rec.get('id');
		return id ? id : "rootId";
	}
	if(type=="userRecord"){
		return rec.get('id');
	}
}
function getName(rec){
	var type=rec.recordType;
	if(type=="cityRecord"){
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
//菜单触发
function menuIsTown(record){
	if(record.get('leve')==3){
		return true;
	}
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
function confirmValue(){
	var tree=L5.getCmp('usertree');
	var userIds=tree.getChecked('userId');
	var userNames=tree.getChecked('userName');
	if(userIds.length<1){
		L5.Msg.alert("提示","没有选择社区");
		return;
	}
	var re=new Array();
	re[0]=userIds;
	re[1]=userNames;
	window.returnValue=re;
	window.close();
}
function closeWin(){
	window.returnValue=new Array();
	window.close();
}