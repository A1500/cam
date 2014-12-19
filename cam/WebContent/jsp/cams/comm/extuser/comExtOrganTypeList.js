//增加一条新的记录
function newBorg(){
	var dataset=L5.DatasetMgr.lookup('somBorgList');
	var r=dataset.newRecord();
	r.set('borgLevel',CorpType);
	r.set('morgName',CorpName);
}
//保存修改
function saveBorg(){
	var dataset=L5.DatasetMgr.lookup('somBorgList');
	var isValidate=dataset.isValidate(true);
	var records = dataset.getAllChangedRecords();
	if(records=='' || records.length==0){
		L5.Msg.alert('提示','没有进行改动！');return;
	}
	if(isValidate!=true){
		L5.Msg.alert("错误","无法通过校验！"+isValidate);
		return;
	}

	L5.MessageBox.confirm('确定', '你确定要保存吗？',function(sta){
		if(sta=="yes"){
			var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomBorgSaveCmd");
			command.setParameter("records", records);
			command.execute();
			if (!command.error) {
				dataset.commitChanges();
				L5.Msg.alert('提示','保存成功！');
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}
		else 
			return;
	}
	);			
}
//查看明细
function showWin(){
	var grid = L5.getCmp('hlistPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var borgCode=records[0].get("borgCode");
		var somBorgView=L5.DatasetMgr.lookup('somBorgView');
		somBorgView.setParameter("borg_Code@=",borgCode);
		somBorgView.load();
		var win=L5.getCmp("showwindow");
		win.show();
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//关闭窗口
function closeWin(){
	var win=L5.getCmp("showwindow");
	win.hide();
}
//校验电话
function checkPhone(args){
	if(isTel(args[0])){
		return true;
	}else if(!isTel(args[0])){
		return "格式不对";
	}
}
//校验是否含有非法字符
function checkQuotein(args){
	if(!isQuoteIn(args[0])){
		return true;
	}else if(isQuoteIn(args[0])){
		return "含有非法字符";
	}
}
//校验是否含有非法字符
function checkQuotefor(args){
	if(!isQuoteIn(args[0])){
		return true;
	}else if(isQuoteIn(args[0])){
		return "含有非法字符";
	}
}

function forQuery(){
	var borgType=document.getElementById('borgType').value;
	var borgName=document.getElementById('borgName').value;
	var borgPeople=document.getElementById('borgPeople').value;
	var morgName=document.getElementById('morgName').value;
	var dataset=L5.DatasetMgr.lookup('somBorgList');
	if(borgType=="") borgType=undefined;	
		if(borgType==" "||borgType=="~"||borgType=="%"){
			L5.Msg.alert("提示","主管单位类型包含非法查询字符！");
			return false;
		}
		dataset.setParameter("borg_Type@=",borgType);
	if(borgName=="") borgName=undefined;	
		if(borgName==" "||borgName=="~"||borgName=="%"){
			L5.Msg.alert("提示","主管单位名称包含非法查询字符！");
			return false;
		}
		dataset.setParameter("borg_Name@=",borgName);
	if(borgPeople=="") borgPeople=undefined;	
		if(borgPeople==" "||borgPeople=="~"||borgPeople=="%"){
			L5.Msg.alert("提示","主管单位联系人包含非法查询字符！");
			return false;
		}
		dataset.setParameter("borg_People@=",borgPeople);
		
	if(morgName=="") morgName=undefined;	
		if(morgName==" "||morgName=="~"||morgName=="%"){
			L5.Msg.alert("提示","登记管理机关名称包含非法查询字符！");
			return false;
		}
		dataset.setParameter("morg_Name@=",morgName);
		dataset.setParameter("borg_level@=",CorpType);
		dataset.load();
}