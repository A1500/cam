
//判断是增加还是修改方法
var flag="";
/**
 * 定义根节点结构
 */ 
var rootdata = {
	
   typeId:'0',
	
   typeName:'优抚对象',
	
   typeOrganId:'1',
	
   typeParentId:'-1',
	
   typeOrder:'0',
	
	recordType : 'dicObjecttypeRecord'
};

/**
 * 事件处理：获得 TreebaseParams的值
 */
function getParent(rec){
	var parentObjId = rec.get('typeId');
	return parentObjId?parentObjId:"1";
}


function getDicObjecttypedisabled(rec){
	return rec.get('typeId')=='';
}
/**
* 定义一个dataset
*/
var dataset = new L5.model.Dataset({
	id : "dicObjecttype_detaildataset"
});

/**
* 事件处理：将节点信息添加到table中
*/
function selectedDicObjecttype(record){
	dicObjecttype_detaildataset.removeAll();
	var data=L5.getCmp("dicObjecttypetree").getCurrentRecord().data;
	var id=data.typeId;
	dicObjecttype_detaildataset.add([new dicObjecttype_detaildataset.recordType(data,id)]);
	L5.getCmp("detailPanel").show();
	if(record.get("typeId")==rootdata.typeId){
		L5.getCmp("detailPanel").hide();
	}
	L5.getCmp("updatePanel").hide();
}


//关闭
function closew(){
	//return false;
	window.returnValue="";
	window.close();
}
//清除
function clears(){
  //window.returnValue=""+";"+""+";"+""+";"+""+";"+""+";"+""+";"+"";
   window.returnValue=";;;;;;;"
	window.close();

}

//获取选中项
function  confirmValue(){
	var tree = L5.getCmp('dicObjecttypetree');
	var typeId = tree.getChecked("typeId");
	var typeName = tree.getChecked("typeName");
//	var typeParentId = tree.getChecked("typeParentId")
//	alert(typeId);
	if(typeId !="" && typeName !=""){
		 window.returnValue=typeId+";"+typeName;
		 window.close();
	}else{
		L5.Msg.alert("提示","请选择组织节点!");
	    return false;
	}
}