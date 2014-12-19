
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
	inUseStru:'1',
	organId:'rootId',
	organName:'根结点',
	shortName:'根结点',
	organType:'1',
	organTypeName:'单位',
	struTypeName:'人力资源',
	inUseOrgan:'1',
	recordType : 'stru'
};

function orgstruStart(record){
	if(record.isRoot)
		return true;
	else
	 	return false;

}
function orgstrunormalStart(record){
	if(!record.isRoot)
		return true;
	else
	 	return false;
}
function orgstruEnd(record){
	return true;
}


function getParentId(record){
	var pid=record.get("struId");
	return pid;
}

function getStruType(rec){
	var struType=rec.get('struType');
	return struType?struType:"00";
}

function  getStruId(record){
	//var struId='<%=struId%>';
	//return struId;
	var struId=record.get('struId');
	return struId?struId:"rootId";
}

function getUpStruId(rec){

	return upstruId?upstruId:"1";
}

function  confirmValue(){
	var parentId=upstruId;
	var tree = L5.getCmp('orgstrutree');
	var check = tree.getChecked('struId');
	var primaryKey='';
	for(var i=0;i<check.length;i++){
		if(i==check.length-1){
			primaryKey=primaryKey+check[i];
		}else{
			primaryKey=primaryKey+check[i]+",";
		}
	}
	if(primaryKey!=''){
		var command=new L5.Command("org.loushang.bsp.organization.cmd.StruCommand");
		command.setParameter("parentId",parentId);
		command.setParameter("primaryKey",primaryKey);
		command.execute("addSelectAndSub");
		if (!command.error) {
		alert("操作成功!");
		window.returnValue="OK";
			window.close();

		}else{
			alert(command.error);
			return false;
		}
	}else{
		alert("请选择下级！");
		return false;
	}
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
function closew(){
	//return false;
	window.returnValue="";
	window.close();

}