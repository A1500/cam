function init() {
	var tree = L5.getCmp('canttree');
	tree.root.expand();
}

// 从数据库获取根结点数据
var rootdata = function() {
   	var command=new L5.Command("org.loushang.bsp.ext.location.cmd.CantCmd");
   	var rootRecord;
	 command.setParameter("rootId",rootId);
	   	// 要选择的cantType
	   	command.setParameter("choiceCantType",choiceCantType);
	   	// 要显示的cantType
	   	command.setParameter("showCantType",showCantType);
	    command.execute("getRootForHelp");
	    if(!command.error) {
			rootRecord=command.getReturn("rootRecord");
		}else {
			L5.Msg.alert("提示",command.error);
		}
	// 判定根结点是否符合可选条件
	var checkCantType=rootRecord.cantType;
	//是根节点但不是虚拟的根节点
	//choiceCantType==null 说明没有指定可以选择的节点类型，则所有的节点都是可以选择的
	//choiceCantType=='0' 所有的节点类型都是可以选择的，除了虚拟的根节点
	if(choiceCantType.indexOf(checkCantType)!=-1){//根节点的类型在可以选择的类型列表中
		checkCantCode=rootRecord.inuse;
	}else if((choiceCantType==null||choiceCantType=='0')&&checkCantType!='0'){
		checkCantCode=rootRecord.inuse;
	}else{
		checkCantCode="";
	}
   return {
    id : rootRecord.cantCode,// 唯一标志record,如果是前台配置生成record,需要指定id
    cantCode:rootRecord["cantCode"],
//	organId:checkorganId,
    cantName:rootRecord.cantName,
	shortName:rootRecord.shortName,
	cantType:rootRecord.cantType,
	superCode:rootRecord.superCode,
	superName:rootRecord.superName,
	inUse:checkCantCode,
	recordType : 'cant'
	};
};

//获取上级行政区划的代码
function getSuperCode(record){
	var superCode=record.get("superCode");
	return superCode;
}

//获取行政区划代码
function  getCantCode(record){
	var cantCode=record.get('cantCode');
	return cantCode?cantCode:"rootId";
}

//获取要选择的cantType
function getChoiceCantType(record){
	return choiceCantType?choiceCantType:"0";
}

//获取要显示的cantType
function getShowCantType(record){
	return showCantType?showCantType:"0";
}

//获取树上节点的显示内容
function getNodeText(record){
	var cantName=record.get('cantName');
	var superName=record.get('superName');
	var cantCode=record.get('cantCode');
	if(cantCode!=null&&cantCode=='rootId'){
		return '行政区划树';
	}else if(cantCode!=null&&superName!=null){
		return cantName.substring(superName.length);
	}
}

//确定按钮
function  confirmValue(){
	var tree = L5.getCmp('canttree');
	var cantCode = tree.getChecked("cantCode");
	var cantName = tree.getChecked("cantName");
	if(cantCode !="" && cantName !=""){
	   window.returnValue=cantCode+";"+cantName;
	   window.close();
	}else{
		L5.Msg.alert("提示","请选择组织节点!");
	    return false;
	}
  }

//获取选择框的显示状态
function getChoiceBox(record){
	// 后台判断的方法，不符合条件的，无法选中
	var cantCode=record.get("cantCode");
	var inuse=record.get("inuse");
	if(cantCode=="rootId"){
		return '';
	}
	if(inuse==""){
		return '';
	}else{
	    if(isCheckBox=="0"){
			return  'radiobox';
		}else{
			return  'checkbox';
		}
	}
}

//关闭按钮
function closew(){
	window.returnValue="";
	window.close();
}

//清除按钮
function clears(){
	window.returnValue=";;;;;;;"
	window.close();

}

//是否级联选中节点的下级，false为不选中下级
function isCheckedSub(node,parentNode){
	return false;
}