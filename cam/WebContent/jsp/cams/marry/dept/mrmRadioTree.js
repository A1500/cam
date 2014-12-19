function init(){
	var tree = L5.getCmp('marryTree');
	tree.root.expand();
}
var rootdata = {
	id:'rootId',
	name:'婚姻登记机构',
	leve:'0',
	ups:'',
	flag:'',
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

/**
 * 事件处理：获得 TreebaseParams的值
 */
function getParent(rec){
	var parentObjId = rec.get('id');
	return parentObjId?parentObjId:organCode;
}


function getDicCitydisabled(rec){
	return rec.get('id')=='';
}


function  confirmValue(){
	var tree = L5.getCmp('marryTree');
	var id = tree.getChecked("organId");
	var deptCode = tree.getChecked("deptCode");
	var name = tree.getChecked("name");
	if(id !=""){
	     window.returnValue=id+";"+name+";"+deptCode;
	     window.close();
	}else{
		L5.Msg.alert("提示","请选择组织节点!");
	    return false;
	}
}

function closew(){
	//return false;
	window.returnValue="";
	window.close();
}

function clears(){
  //window.returnValue=""+";"+""+";"+""+";"+""+";"+""+";"+""+";"+"";
   window.returnValue=";;;;;;;"
	window.close();

}

function getChoiceBox(record){
      return  'radiobox';
}