var status = "";
function init(){
	var camsBriefDataSet=L5.DatasetMgr.lookup("camsBriefDataSet");
	camsBriefDataSet.setParameter("sort","ENTER_SERIAL_NUM");
	camsBriefDataSet.setParameter("dir","asc");
	camsBriefDataSet.load();
}
function getParam(name){
	return document.getElementById(name).value;
}
function query(){
	var camsBriefDataSet=L5.DatasetMgr.lookup("camsBriefDataSet");
	camsBriefDataSet.setParameter("ENTER_NAME@LIKE",getParam("enter_name"));
	camsBriefDataSet.setParameter("SHOW_NAME@LIKE",getParam("show_name"));
	camsBriefDataSet.load();
}
function insert(){
	var ds=L5.DatasetMgr.lookup("briefDs");
	var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
	command.setParameter("IdHelp", "Id32");
	command.execute();
	var configId=command.getReturn("id");
	ds.newRecord({"configId":configId});
	status= "insert";
	L5.getCmp("briefWin").show();
}
function update(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var ds=L5.DatasetMgr.lookup("briefDs");
	ds.setParameter("CONFIG_ID@=",records[0].get("configId"));
	ds.load(true);
	status= "update";
	L5.getCmp("briefWin").show();
}
function del(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否删除该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.comm.brief.cmd.CamsBriefConfigCmd");
			command.setParameter("configId",records[0].get("configId"));
			command.execute("delete");
			if (!command.error){
				var camsBriefDataSet=L5.DatasetMgr.lookup("camsBriefDataSet");
				camsBriefDataSet.load();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}
function confirm(){
	var enterSerialNum = document.getElementById("enterSerialNum").value;	
	var showSerialNum = document.getElementById("showSerialNum").value;
	if(enterSerialNum!=""){
		if(!CheckTxt(enterSerialNum,"录入顺序号")){
			return false;
		}
	}
	if(showSerialNum!=""){
		if(!CheckTxt(showSerialNum,"显示顺序号")){
			return false;
		}
	}
	var ds=L5.DatasetMgr.lookup("briefDs");
	
	var record = ds.getCurrent();
	var command=new L5.Command("com.inspur.cams.comm.brief.cmd.CamsBriefConfigCmd");
	command.setParameter("record",record);
	if(status=="update"){
		command.execute("update");
	}else{
		command.execute("insert");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功");
		closeWin();
		init();
	}else{
		L5.Msg.alert("提示","保存出错！"+command.error);
	}
}
function CheckTxt(obj) {
	var regExp= /^(0|[1-9]\d*)$/;
 	var value = obj;
	if(!value.match(regExp)){ 
		alert("请输入正确的数字");
		return false;
   }else{
	   return true;
   }
 }

function closeWin(){
	L5.getCmp("briefWin").hide();
}
