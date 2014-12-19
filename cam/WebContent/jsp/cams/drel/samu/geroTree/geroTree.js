
//判断是增加还是修改方法
var flag="";
/**
 * 定义根节点结构
 */ 
var rootdata = {
	
   id:organCode,
	
   name:organName,
	
   leve:'-1',
	
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
* 事件处理：将节点信息添加到table中
*/
function selectedDiccity(record){
	diccity_detaildataset.removeAll();
	var data=L5.getCmp("dicCitytree").getCurrentRecord().data;
	var id=data.ups;
	diccity_detaildataset.add([new diccity_detaildataset.recordType(data,id)]);
}
/**
 * 事件处理：获得 TreebaseParams的值
 */
function getParent(rec){
	var parentObjId = rec.get('id');
	var levelValue = rec.get("leve");
	if(levelValue*1 < level*1) {
		if(levelValue=='2'||(organCode.substr(9,3)=="000"&&organCode.substr(6,6)!="000000")||organCode.substr(6,6)=="000000"&&organCode.substr(4,8)!="00000000"&&organCode.substr(2,10)!="0000000000"){
			return '1';
		}else{
			return parentObjId?parentObjId:organCode;
		}
	}else{
		return "null";
	}
}		
/**
 * 事件处理：获得 TreebaseParams的值
 */
function getParentOrgan(rec) {
	var parentObjId = rec.get('id');
	if(parentObjId.substr(9,3)=="000"&&parentObjId.substr(6,6)!="000000"){
		return parentObjId ? parentObjId.substring(0, 9) : organCode;
	}else{
		return parentObjId ? parentObjId.substring(0, 6) : organCode;
	}
	
}

// 敬老院信息
function getOrganManage(record) {
	var leve = record.get("leve");
	// 区县触发
	if (organCode.substr(6,6)=="000000"||leve == '2'||  (organCode.substr(9,3)=="000"&&organCode.substr(6,6)!="000000")) {
		return true;
	}
	return false;
}
function  confirmValue(){
	var tree = L5.getCmp('dicCitytree');
	var gerocomiumId = tree.getChecked("GEROCOMIUM_ID");
	var gerocomiumName = tree.getChecked("GEROCOMIUM_NAME");
	if(gerocomiumId !=""){
	     window.returnValue=gerocomiumId+";"+gerocomiumName;
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

function getChoiceBox(record){
   if(record.get("leve")*1<=radioMaxlevel*1)
      return '';
   else
      return  radioType;
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
