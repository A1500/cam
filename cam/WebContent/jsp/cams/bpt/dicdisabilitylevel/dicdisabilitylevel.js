
//判断是增加还是修改方法
var flag="";
/**
 * 定义根节点结构
 */ 
var rootdata = {
	
   code:'0',
	
   name:'伤残等级',
	
   organId:'1',
	
   parentId:'-1',
	
   sortOrder:'0',
	
   levelId:'0',
	
	recordType : 'dicDisabilityLevelRecord'
};

/**
 * 事件处理：获得 TreebaseParams的值
 */
function getParent(rec){
	var parentObjId = rec.get('levelId');
	return parentObjId?parentObjId:"1";
}


function getDicDisabilityLeveldisabled(rec){
	return rec.get('levelId')=='';
}
/**
* 定义一个dataset
*/
var dataset = new L5.model.Dataset({
	id : "dicDisabilityLevel_detaildataset"
});

/**
* 事件处理：将节点信息添加到table中
*/
function selectedDicDisabilityLevel(record){
	dicDisabilityLevel_detaildataset.removeAll();
	var data=L5.getCmp("dicDisabilityLeveltree").getCurrentRecord().data;
	var id=data.levelId;
	dicDisabilityLevel_detaildataset.add([new dicDisabilityLevel_detaildataset.recordType(data,id)]);
	L5.getCmp("detailPanel").show();
	if(record.get("levelId")==rootdata.levelId){
		L5.getCmp("detailPanel").hide();
	}
	L5.getCmp("updatePanel").hide();
}

//获取选中项
function  confirmValue(){
	var tree = L5.getCmp('dicDisabilityLeveltree');
	var code = tree.getChecked("code");
	var name = tree.getChecked("name");

	if(code !="" && name !=""){
		 window.returnValue=code+";"+name;
		 window.close();
	}else{
		L5.Msg.alert("提示","请选择组织节点!");
	    return false;
	}
}

//关闭
function closew(){
	window.returnValue="";
	window.close();
}
//清除
function clears(){
   window.returnValue=";;;;;;;"
	window.close();

}