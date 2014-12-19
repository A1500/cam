
function init(){
 	//var organId='<%=organId%>';
}
var str=struTypeId;
	if(str=="null" || str==""){
		str="00";
	}
var rootdata = {
	    id : 'rootId',//唯一标志record,如果是前台配置生成record,需要指定id
		struId:'rootId',
		organId:'rootId',
		struType:str,
		parentId:'-1',
		struLevel:'1',
		struPath:'rootId',
		struOrder:'1',
		isLeaf:'0',
		inUse:'1',
		organId:'rootId',
		organName:'根结点',
		shortName:'根结点',
		organType:'1',
		organTypeName:'单位',
		struTypeName:'人力资源',
		inUseOrgan:'1',
		recordType : 'stru'
	};

	function getsrcStruId(record){
		if(srcStruId!=""){
			return srcStruId;
		}else{
			alert("请先选择要变更隶属关系的组织节点");
			return false;
		}
	}
	function  getStruId(record){
		var struId=record.get('struId');
		return struId?struId:"rootId";
}
function  getStruType(record){
	var struType=record.get('struType');
	return struType?struType:"struType";
}

	//根据类型值获取图标路径
function getIcon(rec){
	var figpath=L5.webPath+"/skins/images";
	var file="images/corp_img.gif";
	if(!rec){
		return file;
	}
	var organType=rec.get('organType');
	var type=organType.substring(0, 1);
	var value=parseInt(type);
	switch(value){
			case 0: //根结点
				file =figpath+"/l5/root.gif";
				break;
			case 1: // 法人
				file =figpath+"/l5/bsp_department&corporation.gif";
				break;
			case 2: // 部门
				file =figpath+ "/l5/bsp_department&corporation.gif";
				break;
			case 6: // 岗位
				file = figpath+"/l5/bsp_post.png";
				break;
			case 8: // 职工
				file =figpath+ "/l5/bsp_employee.gif";
				break;
			default:
				file =figpath+ "/l5/other.gif";

	}
	return file;
}

function  getRadioBox(record){
	var organId=record.get("organId");
	if(organId==""){
		return '';
	}else{
		return  'radiobox';
	}
}


function  confirmValue(){
	var fromStruId=srcStruId;
    var tree = L5.getCmp('orgstrutree');
	var struId = tree.getChecked('struId');
	if(struId.length==0){
		alert("请选择组织的新上级!");
		return false;
	}
	var toStruId=struId[0];
 	var command=new L5.Command("org.loushang.bsp.organization.cmd.StruCommand");
   	command.setParameter("fromStruId",fromStruId);
  	command.setParameter("toStruId",toStruId);
  	command.execute("mergeTo");
  	if (!command.error) {
		alert("操作成功!");
		window.returnValue="OK"+";"+toStruId+";"+fromStruId;
		window.close();
	}else{
		alert(command.error);
		return false;
	}
}

function closew(){
	window.returnValue="";
	window.close();
}

