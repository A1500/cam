/** 页面加载后自动运行，初始化事件等操作。
 */
function init(){
	dictDs.baseParams['sort'] = 'dict_code';
	dictDs.baseParams['dir'] = 'asc';
	dictDs.setParameter('IN_USE@=','1');
	dictDs.load();
}

function disableEdit() {
	if( dictDs.getCurrent().state === 1 ){
		return true;
	}
	return false;
}
function itemquery(){
	var records = dictDs.getAllChangedRecords();
	if(records.length>0){
		L5.Msg.alert('提示','请先保存');
		return false;
	}
	var grid=L5.getCmp('dictPanel');
	var selected = grid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',MSG_SEL_ONE_RECORD);
		return false;
	}
	var url='jsp/bsp/dict/item_query.jsp?DICT_CODE='+selected[0].get("dictCode");;
	L5.forward(url,CAPTION_DICT_ITEM);
}
/**
 *  新增按钮的处理函数。
 */
function insert(){
	var dictGrid = L5.getCmp('dictPanel');
	dictGrid.stopEditing();
	dictDs.newRecord({"inUse":1});
}

function save() {
	var records = dictDs.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示',MSG_NOCHANGE);
		return false;
	}
	var msg = dictDs.isValidate();
	if(msg !== true){
		L5.Msg.alert('提示',msg);
		return false;
	}

	var dictCode =[];
	var dictName=[];
	var leng = records.length;
	for(var i=0; i<leng; i++){
		dictCode[i]=records[i].get('dictCode');
		dictName[i]=records[i].get('dictName');
		if(dictCode[i]==null || dictCode[i]==""){
			L5.Msg.alert( '提示','字典编码不能为空');
			return;
		}
		if(dictName[i]==null || dictName[i]==""){
			L5.Msg.alert( '提示','字典编码为' +dictCode[i]+'的字典名称不能为空');
			return;
		}
	}
	//检查是否有重复记录
	var tempRecord;
	for(var i=0; i<leng; i++){
		tempRecord = records[i];
		for(var j=i+1; j<leng; j++){
			if(tempRecord.get("dictCode") == records[j].get("dictCode")){
				L5.Msg.alert("提示","新增记录中有重复记录");
				return;
			}
			
		}
	}
	var command = new L5.Command("org.loushang.bsp.dict.DictCommand");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		var echo = command.getReturn('echo');
		var leng = records.length;
		for(var i=0; i<leng; i++) {
			records[i].set('setMan',echo[0]);
			records[i].set('setTime',echo[1]);
		}
		dictDs.commitChanges();
		L5.Msg.alert('提示','保存成功');
	}else{
		L5.Msg.alert('提示',command.error);
	}
}

/** 删除按钮的处理函数。
 */
function del(){
	var grid=L5.getCmp('dictPanel');
	var selected = grid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',MSG_SEL_DEL_RECORD);
		return false;
	}
   	L5.MessageBox.confirm("提示", "你确定要删除吗？", function(sta) {
		if (sta == "yes") {
			var dictCodes=[];
			for(var i=0;i<selected.length;i++){
				// 如果是新增的记录，就不应该走后台数据库
				if(selected[i].state !== 1) {
					dictCodes.push(selected[i].get("dictCode"));
				} 
			}
			if( dictCodes.length > 0) {
				var command=new L5.Command("org.loushang.bsp.dict.DictCommand");
				command.setParameter("dictCodes", dictCodes);
				command.execute("delete");
				if (!command.error) {
					for(var i=0; i<selected.length; i++){
						dictDs.remove(selected[i]);
					}
					L5.Msg.alert('提示','删除成功');
				}else{
					L5.Msg.alert('提示',command.error);
				}
			}else{
				for(var i=0; i<selected.length; i++){
					dictDs.remove(selected[i]);
				}
			}
		} else{
			return  false;
		}
	});
}
function query_name() {
  var dictName = document.getElementById('dictName_text').value;
  var dictCode = document.getElementById('dictCode_text').value;
  if(dictName!=""&&(dictName.indexOf("'")!=-1||dictName.indexOf("~"))!=-1){
	  L5.Msg.alert('提示',"查询条件不能包含单引号或者波浪线等特殊字符");
	  return;
  }
  if(dictCode!=""&&(dictCode.indexOf("'")!=-1||dictCode.indexOf("~"))!=-1){
	  L5.Msg.alert('提示',"查询条件不能包含单引号或者波浪线等特殊字符");
	  return;
  }
  var trimedName = dictName.replace(/(^(\s)+)|((\s)+$)/g,"");
  var trimedCode = dictCode.replace(/(^(\s)+)|((\s)+$)/g,"");
  if( trimedName.length > 0) {
	  dictDs.setParameter('dict_name@like',trimedName);
  } else {
	  dictDs.setParameter('dict_name@=',"");
  }
  if( trimedCode.length > 0) {
	  dictDs.setParameter('dict_code@like',trimedCode);
  } else {
	  dictDs.setParameter('dict_code@=',"");
  }
  dictDs.setParameter('IN_USE@=',"1");
  dictDs.load();
}

function reset(){
	document.getElementById('dictName_text').value="";
	 var dictCode = document.getElementById('dictCode_text').value="";
}