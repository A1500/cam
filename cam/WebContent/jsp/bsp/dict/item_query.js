var parentCode = null;
/** 页面加载后自动运行，初始化事件等操作。
 */
function init(){
	if(parentCode===null){
		document.getElementById('parentQuery_button').style.display = 'none';
		//document.getElementById('back_button').style.display = "";
	}
	dictItemDs.setParameter("DICT_CODE",dictCode);
	dictItemDs.setParameter("IN_USE","1");
	dictItemDs.load();

}
function disableEdit() {
	if(dictItemDs.getCurrent().state === 1) {
		return true;
	}
	return false;
}
function insert(){
	var itemGrid = L5.getCmp('dictItemPanel');
	itemGrid.stopEditing();
	dictItemDs.newRecord({"dictCode":dictCode,"xh":0,"parentCode":parentCode});
}
function checkRef(ids) {
	var cmd = new L5.Command("org.loushang.bsp.dict.DictItemCommand")
	cmd.setParameter("ids",ids);
	cmd.setParameter("dicCode",dictCode);
	cmd.execute('checkRef');
	if(!cmd.error) {
		var ids = cmd.getReturn('ids');;
		return ids===undefined?null:ids;
	}
}
function save() {
	var records = dictItemDs.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert( '提示',MSG_NOCHANGE);
		return false;
	}
	var msg = dictItemDs.isValidate();
	if(msg !== true){
		L5.Msg.alert( '提示',msg);
		return false;
	}
	var leng = records.length;
	var ids = [];

	for(var i=0; i<leng; i++) {
	    if(records[i].state=="1")
		 ids[i] = records[i].get('itemCode');
	}
	if(ids.length>0){
		var existId = checkRef(ids);
		if( existId !== null ) {
			L5.Msg.alert( '提示','字典编号为' +existId.join(",")+'的字典项已经存在');
			return;
		}
	}
	var dictCode =[];
	for(var i=0; i<leng; i++){
		dictCode[i]=records[i].get('itemValue');
		if(dictCode[i]==null || dictCode[i]==""){
			L5.Msg.alert( '提示','字典编号为' +ids[i]+'字典名称不能为空');
			return;
		}
	} 
	
	//检查是否有重复记录
	var tempRecord;
	for(var i=0; i<leng; i++){
		tempRecord = records[i];
		for(var j=i+1; j<leng; j++){
			if(tempRecord.get("itemCode") == records[j].get("itemCode")){
				L5.Msg.alert("提示","新增记录中有重复记录");
				return;
			}
			
		}
	}

	var command = new L5.Command("org.loushang.bsp.dict.DictItemCommand");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		dictItemDs.commitChanges();
		L5.Msg.alert('提示','数据保存成功!');
	}else{
		L5.Msg.alert( '提示',command.error);
	}
}

function childquery() {
	var records = dictItemDs.getAllChangedRecords();
	if(records.length>0){
		L5.Msg.alert('提示','请先保存');
		return false;
	}
	var grid=L5.getCmp('dictItemPanel');
	var selected = grid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert( '提示',MSG_SEL_ONE_RECORD);
		return false;
	}
	document.getElementById('parentQuery_button').style.display = "";
	document.getElementById('back_button').style.display = "none";
	parentCode=selected[0].get("itemCode");
	dictItemDs.setParameter("DICT_CODE",dictCode);
	dictItemDs.setParameter("PARENT_CODE",parentCode);
	dictItemDs.setParameter("IN_USE","1");
	dictItemDs.load();
}

function parentquery(){

	var command=new L5.Command("org.loushang.bsp.dict.DictItemCommand");
	command.setParameter("dictCode", dictCode);
	command.setParameter("itemCode", parentCode);
	command.execute("parent");
	if (!command.error) {
		parentCode=command.getReturn("parentCode");
		if(parentCode === null) {
			document.getElementById('parentQuery_button').style.display = 'none';
			document.getElementById('back_button').style.display = ""
		}
		dictItemDs.setParameter("DICT_CODE",dictCode);
		dictItemDs.setParameter("PARENT_CODE",parentCode);
		dictItemDs.setParameter("IN_USE","1");
		dictItemDs.load();
	}else{
		L5.Msg.alert( '提示',command.error);
	}
}
/** 删除按钮的处理函数。
 */
function del(){
	var grid=L5.getCmp('dictItemPanel');
	var selected = grid.getSelectionModel().getSelections();

	if(selected.length<1){
		L5.Msg.alert( '提示',MSG_SEL_DEL_RECORD);
		return false;
	}
  	L5.MessageBox.confirm("提示", "你确定要删除吗？", function(sta) {
		if (sta == "yes") {
			//存放原有记录，即不是新增加的记录
			var oldRecords = new Array();
			for( var i=0; i<selected.length; i++) {
				if( selected[i].state !== 1) {
					oldRecords.push(selected[i]);
				}
			}
			if(oldRecords.length > 0){
				var command=new L5.Command("org.loushang.bsp.dict.DictItemCommand");
				command.setParameter("records", oldRecords);
				command.execute("delete");
				if (!command.error) {
					for(var i=0; i<selected.length; i++){
						dictItemDs.remove(selected[i]);
					}
					L5.Msg.alert('提示','删除成功');
				}else{
					L5.Msg.alert( '提示',command.error);
				}
			}else{
				for(var i=0; i<selected.length; i++){
					dictItemDs.remove(selected[i]);
				}
			}
		} else {
			return  false;
		}
	});
}
function backquery(){
	var url="jsp/bsp/dict/dict_query.jsp";
	L5.forward(url,"字典管理");
}
