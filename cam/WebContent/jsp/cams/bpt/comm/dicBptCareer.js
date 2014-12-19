
//判断是增加还是修改方法
var flag="";
/**
 * 定义根节点结构
 */ 
var rootdata = {
	
   code:'0',
	
   name:"专业职称",
	
	
   ups:'',
	
	
   recordType : 'dicBptCareerRecord'
};

/**
* 定义一个dataset
*/
var dataset = new L5.model.Dataset({
	id : "dicBptCareer_detaildataset"
});

/**
* 事件处理：将节点信息添加到table中
*/
function selectedDiccity(record){
	dicBptCareer_detaildataset.removeAll();
	var data=L5.getCmp("dicBptCareertree").getCurrentRecord().data;
	var code=data.ups;
	dicBptCareer_detaildataset.add([new dicBptCareer_detaildataset.recordType(data,code)]);
}

/**
 * 事件处理：获得 TreebaseParams的值
 */
function getParent(rec){
	var parentObjId = rec.get('code');
	return parentObjId?parentObjId:"0";
}


function getDicCitydisabled(rec){
	return rec.get('code')=='';
}


function  confirmValue(){
	var tree = L5.getCmp('dicCitytree');
	var code = tree.getChecked("code");
	var name = tree.getChecked("name");
	var leve = tree.getChecked("leve");
	var ups = tree.getChecked("ups");
	if(id !=""){
	     window.returnValue=code+";"+name+";"+leve+";"+ups;
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
	var leaf1=rec.get('leve');
	if(leaf1=='2'){
		return true;
	}else{
		return false;
	}
}

function getChoiceBox(record){
   if(record.get("leve")=='2'||record.get("code")=='999')
      return 'radiobox';
   else
      return  '';
}

//根据类型值获取图标路径
function getIcon(rec){
	var figpath=L5.webPath+"/skins/images";
	var leve=rec.get('leve');
	var value=parseInt(leve);
	switch(value){
			case 0: //根结点
				file =figpath+"/l5/root.gif";
				break;
			case 1: // 二级节点
				file =figpath+"/l5/bsp_department&corporation.gif";
				break;
			case 2: // 三级节点
				file =figpath+ "/l5/bsp_department&corporation.gif";
				break;
			default: // 四级节点
				file = figpath+"/l5/bsp_post.png";
    }
	return file;
}
