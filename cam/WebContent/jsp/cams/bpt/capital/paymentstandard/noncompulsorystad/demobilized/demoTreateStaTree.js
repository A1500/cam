/**
 * 定义根节点结构
 */ 
var rootdata = {
	
   id:organCode,
	
   name:organName,
	
   leve:'0',
	
   ups:'',
	
   flag:'',
	
   recordType : 'dicCityRecord'
};

/**
* 定义一个dataset
*/
var dataset = new L5.model.Dataset({
	id : "diccity_detaildataset"
});

/**
 * 事件处理：获得 TreebaseParams的值
 */
function getParent(rec){
	var parentObjId = rec.get('id');
	return parentObjId?parentObjId:organCode;
}

//是否级联选中节点的下级，false为不选中下级
function isCheckedSub(node,parentNode){
	return false;
}

function getIsLeaf(rec){
	var leaf1=rec.get('isLeaf');
	if(leaf1=='4'){
		return true;
	}else{
		return false;
	}
}

//根据类型值获取图标路径
function getIcon(rec){
	var figpath=L5.webPath+"/skins/images";
	var leve=rec.get('leve');
	var value=parseInt(leve);
	switch(value){
			case 1: //根结点
				file =figpath+"/l5/root.gif";
				break;
			case 2: // 二级节点
				file =figpath+"/l5/bsp_department&corporation.gif";
				break;
			case 3: // 三级节点
				file =figpath+ "/l5/bsp_department&corporation.gif";
				break;
			default: // 四级节点
				file = figpath+"/l5/bsp_post.png";
    }
	return file;
}

function selectedNode(record){
	var organCode = record.get("id");
	var frame = document.getElementById("nodeFrame");
	var level = record.get("leve");
	url = "demoTreateStaList.jsp?organCode="+organCode+"&leve="+level;
	frame.setAttribute("src", url);
}
