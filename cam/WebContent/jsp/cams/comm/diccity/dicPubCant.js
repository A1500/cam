
//判断是增加还是修改方法
var flag="";
/**
 * 定义根节点结构
 */ 
var rootdata = {
	
   cantCode:organCode,
	
   cantName:organName,
	
   superCode:'',
	
   countryCode:'',
   	
   cantNote:'',
   	
   inUse:'',
   	
   cantType:'',
   	
   shortName:'',
      	
   recordType : 'dicCityRecord'
};

/**
* 定义一个dataset
*/
var dataset = new L5.model.Dataset({
	cantCode : "diccity_detaildataset"
});

/**
* 事件处理：将节点信息添加到table中
*/
function selectedDiccity(record){
	diccity_detaildataset.removeAll();
	var data=L5.getCmp("diccitytree").getCurrentRecord().data;
	var id=data.superCode;
	diccity_detaildataset.add([new diccity_detaildataset.recordType(data,id)]);
}

/**
 * 事件处理：获得 TreebaseParams的值
 */
function getParent(rec){
	var parentObjId = rec.get('cantCode');
	return parentObjId?parentObjId:organCode;
}


function getDicCitydisabled(rec){
	return rec.get('cantCode')=='';
}


function  confirmValue(){
	var tree = L5.getCmp('dicCitytree');
	var cantCode = tree.getChecked("cantCode");
	var cantName = tree.getChecked("cantName");
	var cantType = tree.getChecked("cantType");
	var superCode = tree.getChecked("superCode");
	if(id !=""){
	     window.returnValue=cantCode+";"+cantName+";"+cantType+";"+superCode;
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
   if(record.get("cantType")==1||record.get("cantType")==0 || record.get("cantType")==2)
      return '';
   else
      return  'radiobox';
}

//根据类型值获取图标路径
function getIcon(rec){
	var figpath=L5.webPath+"/skins/images";
	var cantType=rec.get('cantType');
	var value=parseInt(cantType);
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
