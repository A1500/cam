function init(){
	var dicCityChangeDataSet=L5.DatasetMgr.lookup("dicCityChangeDataSet");
	dicCityChangeDataSet.setParameter("BATCH_ID@=",batchId);
	dicCityChangeDataSet.load();
	//查看页面隐藏更新删除等操作
	if(method=='detail'){
		L5.getCmp("update").hide();
		L5.getCmp("insert").hide();
		L5.getCmp("del").hide();
		L5.getCmp("check").hide();
	}
	L5.getCmp("grid").on("rowclick",function(){
		var ds=L5.DatasetMgr.lookup("dicCityDetailDataSet");
		var changeId = dicCityChangeDataSet.getCurrent().get("changeId");
		ds.setParameter("CHANGE_ID",changeId);
		ds.load();
	});
}
function query(){
	var dicCityChangeDataSet=L5.DatasetMgr.lookup("dicCityChangeDataSet");
	dicCityChangeDataSet.setParameter("PRE_CHANGE_CODE@LIKE",getParam("pre_code"));
	dicCityChangeDataSet.setParameter("PRE_CHANGE_NAME@LIKE",getParam("pre_name"));
	dicCityChangeDataSet.setParameter("POST_CHANGE_CODE@LIKE",getParam("change_code"));
	dicCityChangeDataSet.setParameter("POST_CHANGE_NAME@LIKE",getParam("change_name"));
	dicCityChangeDataSet.setParameter("CHANGE_TYPE@=",getParam("change_type"));
	dicCityChangeDataSet.setParameter("BATCH_ID@=",batchId);
	dicCityChangeDataSet.load();
}
function getParam(name){
	return document.getElementById(name).value;
}
function insert(){
	var dicCityChangeDataSet=L5.DatasetMgr.lookup("dicCityChangeDataSet");
	dicCityChangeDataSet.newRecord();
	L5.getCmp("typeWin").show();
}
function confirm(){
	var changeType = document.getElementById("changeType").value;
	if(changeType==""){
		L5.Msg.alert("提示","调整类别不能为空");
		return;
	}
	var data=new L5.Map();
	data.put("method","insert");
	data.put("batchId",batchId);
	url="";
	if(changeType=="01"){
		url="jsp/cams/comm/diccityChange/dicCityInsertEdit.jsp";
	}else if(changeType=="03"){
		url="jsp/cams/comm/diccityChange/dicCityDeleteEdit.jsp";
	}else{
		url="jsp/cams/comm/diccityChange/dicCityChangeEdit.jsp";
	}
	L5.forward(url,'',data);
}
function update(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("changeResult")=="1"){
		L5.Msg.alert("提示","已提交，不能修改!");
		return;
	}
	var data=new L5.Map();
	data.put("method","update");
	data.put("changeId",records[0].get("changeId"));
	data.put("batchId",batchId);
	var changeType = records[0].get("changeType");
	url="";
	if(changeType=="01"){
		url="jsp/cams/comm/diccityChange/dicCityInsertEdit.jsp";
	}else if(changeType=="03"){
		url="jsp/cams/comm/diccityChange/dicCityDeleteEdit.jsp";
	}else{
		url="jsp/cams/comm/diccityChange/dicCityChangeEdit.jsp";
	}
	L5.forward(url,'',data);
}
function detail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","detail");
	data.put("changeId",records[0].get("changeId"));
	var changeType = records[0].get("changeType");
	url="";
	if(changeType=="01"){
		url="jsp/cams/comm/diccityChange/dicCityInsertDetail.jsp";
	}else if(changeType=="03"){
		url="jsp/cams/comm/diccityChange/dicCityDeleteDetail.jsp";
	}else{
		url="jsp/cams/comm/diccityChange/dicCityChangeDetail.jsp";
	}
	L5.forward(url,'',data);
}

function del(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var deleteType=records[0].get("changeType");
	L5.MessageBox.confirm("提示", "是否删除该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeCmd");
			command.setParameter("changeId",records[0].get("changeId"));
			if(deleteType=="03"){
				command.execute("deleteByTrans");
			}else{
				command.execute("delete");
			}
			
			if (!command.error){
				init();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}

function check(){
	var dicCityChangeDataSet=L5.DatasetMgr.lookup("dicCityChangeDataSet");
	var isValidate = dicCityChangeDataSet.isValidate();
	if(isValidate != true){
		alert(isValidate);
		return false;
	}
	var records = dicCityChangeDataSet.getAllChangedRecords();
	if(records.length==0){
		alert("没有需要校验的数据");
		return;
	}
	//校验序号是否重复
	var count = 0;
	for(var i=0;i<records.length;i++){
		var changeCmd=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeCmd");
		changeCmd.setParameter("batchId",batchId);
		changeCmd.setParameter("serialNum",records[i].get("serialNum"));
		changeCmd.execute("isRepeat");
		var tips = changeCmd.getReturn("flag");
		if(tips){
			count++;
		}
	}
	if(count>=1){
		alert("一个批次中序号不能重复!");
		return;
	}
	
	
	var command=new L5.Command("com.inspur.cams.comm.diccityChange.cmd.DicCityChangeCmd");
	command.setParameter("records",records);
	command.execute("updateAll");
	if (!command.error){
		init();
	}else{
		L5.Msg.alert("提示","保存时出错！"+command.error);
	}
}

function winShow(){
	var ds=L5.DatasetMgr.lookup("ds");
	ds.newRecord({"batchId":batchId,"organCode":organCode,"organName":organName,"submitTiems":"3","batchType":"0"});
	L5.getCmp("batchWin").show();
}
function closeWin(){
	L5.getCmp("typeWin").hide();
	var dicCityChangeDataSet=L5.DatasetMgr.lookup("dicCityChangeDataSet");
	var records = dicCityChangeDataSet.getAllChangedRecords();
	dicCityChangeDataSet.remove(records[0]);
}
function back(){
	history.go(-1);
}