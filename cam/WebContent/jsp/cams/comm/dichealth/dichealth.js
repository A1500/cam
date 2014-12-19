
//判断是增加还是修改方法
var flag="";
/**
 * 定义根节点结构
 */ 
var rootdata = {
	
   code:'1',
	
   type:'1',
	
   typeName:'健康状况',
	
   name:'健康状况',
	
	recordType : 'dicHealthRecord'
};

/**
 * 事件处理：获得 TreebaseParams的值
 */
function getParent(rec){
	var parentObjId = rec.get('code');
	return parentObjId?parentObjId:"1";
}


function getDicHealthdisabled(rec){
	return rec.get('code')=='';
}
/**
* 定义一个dataset
*/
var dataset = new L5.model.Dataset({
	id : "dicHealth_detaildataset"
});



function  confirmValue(){
	var tree = L5.getCmp('dicHealthtree');
	var code = tree.getChecked("code");
	var name = tree.getChecked("name");
	if(code=='30') {
		alert("请选择慢性病的详细类型！");
		return false;
	}
	if(code=='60') {
		alert("请选择残疾的详细类型！");
		return false;
	}
	if(code !=""){
	     window.returnValue=code+";"+name;
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
function getChoiceBox(record){
alert(record.get("type"));
alert(record.get("code"));
   if(record.get("type")==record.get("code"))
      return '';
   else
      return  radioType;
}

