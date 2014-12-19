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
	var borgCodes="";
	for(var i=0;i<records.length;i++){
		if(borgCodes){
			borgCodes+=",";
		}
		borgCodes+=records[i].get("borgCode");
	}
	var command=new L5.Command("com.inspur.cams.sorg.base.cmd.SomBorgChangeCmd");
	command.setParameter("CHANGE_BEFORE_ID@IN", borgCodes);
	
	command.afterExecute=function(){	
		//此处程序有问题，borgCodes为空的时候会全部查出来进行下边的提示，并不能保存
		//var changeBeforeCount=command.getReturn('changeBeforeCount');
		//if(changeBeforeCount>0){
		//	L5.Msg.alert('提示',"存在业务主管单位进行过变更，不能进行修改操作!");
		//	return false;
		//}
		
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
	};
	command.execute("queryBeforeCount");	
		
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
	var record=selected[0];
	var ifHis=record.get("ifHis");
	if(ifHis=="1"){
		var command=new L5.Command("com.inspur.cams.sorg.base.cmd.SomBorgChangeCmd");
		command.setParameter("CHANGE_BEFORE_ID", record.get("borgCode"));
		
		command.afterExecute=function(){	
			var changeBeforeCount=command.getReturn('changeBeforeCount');
			if(changeBeforeCount>0){
				L5.Msg.alert('提示',"业务主管单位进行过变更，不能进行删除操作!");
				return false;
			}
			
			doDel();
		};
		command.execute("queryBeforeCount");	
	}else{
		doDel();
	}
}
function doDel(){
	var ds=L5.DatasetMgr.lookup('somBorgList');
	var editGrid=L5.getCmp('hlistPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	
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

//业务主管单位变更
function showWinChange(){
	var editGrid=L5.getCmp('hlistPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var record=selected[0];	
	if(record.get("ifHis")=="1"){
		L5.Msg.alert('提示',"该条记录为历史业务主管单位，不能进行变更!");
		return false;
	}
	var somBorgChange=L5.DatasetMgr.lookup('somBorgChange');
	somBorgChange.newRecord({"changeBeforeId":record.get("borgCode"),"changeBeforeName":record.get("borgName")});
	
	var win=L5.getCmp("winChange");
	win.show();
}
//关闭窗口
function closeWinChange(){
	var win=L5.getCmp("winChange");
	win.hide();
}
//业务主管单位变更
function confirmWinChange(){	
	var ds=L5.DatasetMgr.lookup('somBorgList');	
	var somBorgChange=L5.DatasetMgr.lookup('somBorgChange');
	var editGrid=L5.getCmp('hlistPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	var record=selected[0];	
	var changeRecord=somBorgChange.getCurrent();	
	var command=new L5.Command("com.inspur.cams.sorg.base.cmd.SomBorgCmd");
	command.setParameter("record", record);
	command.setParameter("changeRecord", changeRecord);
	command.execute("changeBorg");	
	if (!command.error) {
		L5.Msg.alert('提示','变更成功！',function(){
			closeWinChange();
			var dataset=L5.DatasetMgr.lookup('somBorgList');
			dataset.load();
		});
	}else{
		L5.Msg.alert('提示',"变更时出现错误！"+command.error);
	}
}

//打开选择变更后名称窗口
function openChangeAfterWin(){
	L5.getCmp("changeAfterWin").show();
	$("borgNameQ").value='';
	queryChangeAfter();
}
//查询变更后名称
function queryChangeAfter(){
	var somBorgChangeAfter=L5.DatasetMgr.lookup("somBorgChangeAfter");
	somBorgChangeAfter.setParameter("MORG_CODE@=",organCode);
	somBorgChangeAfter.setParameter("IF_HIS@=","0");	
	somBorgChangeAfter.setParameter("BORG_NAME@LIKE",_$("borgNameQ"));
	somBorgChangeAfter.setParameter("BORG_CODE@!=",_$("changeBeforeId"));
	somBorgChangeAfter.load();
}
//选择变更后名称
function chooseChangeAfter() {
	var changeAfterGrid=L5.getCmp('changeAfterGrid');
	var selected=changeAfterGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
		
	var somBorgChange=L5.DatasetMgr.lookup("somBorgChange");
	somBorgChange.set("changeAfterName",selected[0].get('borgName'));
	somBorgChange.set("changeAfterId",selected[0].get('borgCode'));
	
	closeChangeAfterWin();
}
//关闭选择变更后名称窗口
function closeChangeAfterWin(){
	L5.getCmp("changeAfterWin").hide();
}

//业务主管单位变更历史
function showWinChangeHis(){
	var editGrid=L5.getCmp('hlistPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var record=selected[0];
	var command=new L5.Command("com.inspur.cams.sorg.base.cmd.SomBorgChangeCmd");
	command.setParameter("borgCode", record.get("borgCode"));
	
	command.afterExecute=function(){	
		var changeCount=command.getReturn('changeCount');
		if(changeCount<1){
			L5.Msg.alert('提示',"业务主管单位没有进行过变更!");
			return false;
		}
		
		var win=L5.getCmp("winChangeHis");
		win.show();	
		var somBorgChangeHis=L5.DatasetMgr.lookup('somBorgChangeHis');
		somBorgChangeHis.setParameter("borgCode", record.get("borgCode"));
		somBorgChangeHis.load();	
	};
	command.execute("queryCount");	
	
}
//关闭窗口
function closeWinChangeHis(){
	var win=L5.getCmp("winChangeHis");
	win.hide();
}
