var CorpName='';
var UserName='';
var CorpCode='';
var CorpType='';
function init(){
	//得到当前登录信息
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomBorgCmd");
	command.execute("getOnLine");
	CorpName=command.getReturn('CorpName');
	UserName=command.getReturn('UserName');
	CorpCode=command.getReturn('CorpCode');
	CorpType=command.getReturn('CorpType');
	
	var dataset=L5.DatasetMgr.lookup('somBorgList');
//	dataset.setParameter("borg_level@=",CorpType);
	dataset.load();
}
//增加一条新的记录
function newBorg(){
	var dataset=L5.DatasetMgr.lookup('somBorgList');
	var r=dataset.newRecord();
//	r.set('borgLevel',CorpType);
	if(organType == "11"){
		r.set('borgLevel',"1");
	}
	if(organType == "12"){
		r.set('borgLevel',"2");
	}
	if(organType == "13"){
		r.set('borgLevel',"3");
	}
	r.set('ifHis',"0");
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
			var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomBorgCmd");
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
	if(args[0] == ''){
		return true;
	}
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
	var borgName=document.getElementById('borgName').value;
	var dataset=L5.DatasetMgr.lookup('somBorgList');
	if(!borgName==""){
		dataset.setParameter("borg_Name@like",borgName+"%");
	}
	if(borgName==" "||borgName=="~"||borgName=="%"){
		L5.Msg.alert("提示","主管单位名称包含非法查询字符！");
		return false;
	}
	dataset.load();
}

function del(){
	var ds=L5.DatasetMgr.lookup('somBorgList');
	var editGrid=L5.getCmp('hlistPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("borgCode");
			}
			var command=new L5.Command("com.inspur.cams.sorg.base.cmd.SomBorgCmd");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	ds.remove(selected[i]);
				}
				ds.commitChanges();
			}else{
				L5.Msg.alert('提示',"删除时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}