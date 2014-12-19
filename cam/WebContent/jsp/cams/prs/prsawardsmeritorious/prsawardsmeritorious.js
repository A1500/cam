function init() { 
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
	}else if(method=="INSERT"){
		prsawardsmeritoriousDataset.newRecord();
		var awardGrid = L5.getCmp('editGridPanel');
		awardGrid.stopEditing();
	}else if (method=="UPDATE"){
		prsawardsmeritoriousDataset.setParameter("SOLDIERS_ID",idField);
		prsawardsmeritoriousDataset.load();
	}else{
		L5.Msg.alert('提示',"未知的页面命令!");
		
	}
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function insert() {
	var record = prsawardsmeritoriousDataset.getCurrent();
	if(record==null){
		prsawardsmeritoriousDataset.newRecord();
		record = prsawardsmeritoriousDataset.getCurrent();
	}else{
		var times =record.get("awardsNumber");
		if(isNaN(times)||times==''){
			L5.Msg.alert('提示',"获奖次数格式不正确,不能保存! ");
	
		}else{
			prsawardsmeritoriousDataset.newRecord();	
			var Grid = L5.getCmp('awardGridPanel');
			Grid.stopEditing();
		}
	}
	
}

function del() {
	var editGrid=L5.getCmp('awardGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("awardsId");
			}
			var command=new L5.Command("com.inspur.cams.prs.prsawardsmeritorious.cmd.PrsAwardsMeritoriousCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	prsawardsmeritoriousDataset.remove(selected[i]);
				}
				prsawardsmeritoriousDataset.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
	
}
function save() {
	var records = prsawardsmeritoriousDataset.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	var isValidate = prsawardsmeritoriousDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.prs.prsawardsmeritorious.cmd.PrsAwardsMeritoriousCommand");
	command.setParameter("records", records);
	command.setParameter("soldiersId",idField);
	command.execute("save");
	if (!command.error) {
		prsawardsmeritoriousDataset.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function reset() {
	prsawardsmeritoriousDataset.rejectChanges();
}
/**
 * 弹窗编辑立功受奖信息
 */
 
function insertWin(){
	var prsawardsmeritoriousDataset = L5.DatasetMgr
	.lookup("prsawardsmeritoriousDataset");
	prsawardsmeritoriousDataset.newRecord();
	var win=L5.getCmp("awardWin");
	win.show(this);
	//prsawardsmeritoriousDataset.remove(prsawardsmeritoriousDataset.getcurrent());
	
}
function update(){
	var awardGridPanel=L5.getCmp('awardGridPanel');
	var selected=awardGridPanel.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var soldiersId=selected[0].get('soldiersId');
	var win=L5.getCmp("awardWin");
	win.show(this);
	/*
	var prsawardsmeritoriousDataset=L5.DatasetMgr.lookup("prsawardsmeritoriousDataset");
	prsawardsmeritoriousDataset.setParameter("AWARDS_ID",awardsId);
	prsawardsmeritoriousDataset.load();
	*/

}
/**
 * 关闭按钮
 */
function close(){

var prsawardsmeritoriousDataset=L5.DatasetMgr.lookup("prsawardsmeritoriousDataset");
		prsawardsmeritoriousDataset.remove(prsawardsmeritoriousDataset.getCurrent());

L5.getCmp("awardWin").setVisible(false);
//prsawardsmeritoriousDataset.setParameter("SOLDIERS_ID",idField);
	  //	prsawardsmeritoriousDataset.load();
}
/**
 * 继续添加按钮
 */
function awardSubmit(){
	var prsawardsmeritoriousDataset = L5.DatasetMgr.lookup("prsawardsmeritoriousDataset");
	var record = prsawardsmeritoriousDataset.getCurrent();
	if(record==null){
		
	}else{
		var awardsType = record.get("awardsType");
		if(awardsType==""||awardsType==null){
			L5.Msg.alert('提醒','立功受奖种类不能为空！');
			return false;
		}
		var awardsName = record.get("awardsName");
		if(awardsName==""||awardsName==null){
			L5.Msg.alert('提醒','立功受奖名称不能为空！');
			return false;
		}
		var awardsNumber = record.get("awardsNumber");
		if(awardsNumber==""||awardsNumber==null){
			L5.Msg.alert('提醒','立功受奖次数不能为空！');
			return false;
		}
		if(isNaN(awardsNumber)){
			L5.Msg.alert('提醒','立功受奖次数格式不正确！');
			return false;
		}
		var awardsTime = record.get("awardsTime");
		if(awardsTime!=""&&awardsTime!=null){
			if(isNaN(awardsTime)||awardsTime.length!=4){
				L5.Msg.alert('提醒','立功受奖年份格式不正确！');
				return false;
			} 
		}
	}
	prsawardsmeritoriousDataset.newRecord();
}
/**
 * 修改立功次数，当立功次数小于0时，改为默认值1
 */
function changeAwardsNumber(cell, col, record, row) {
	if(isNaN(cell)) {
		L5.Msg.alert('提醒','立功受奖次数格式不正确！');
		record.set("awardsNumber",1);
		return 1;
	}
	if(cell != undefined && cell != "") {
		var num = parseInt(cell);
		if(num < 1) {
			record.set("awardsNumber",1);
			return 1;
		} else {
			return cell;
		}
	} else if(cell == undefined) {
		return "";
	} else {
		return cell;
	}
}
/**
 * 确定按钮
 */
function hide(){
	var prsawardsmeritoriousDataset = L5.DatasetMgr.lookup("prsawardsmeritoriousDataset");
	var record = prsawardsmeritoriousDataset.getCurrent();
	if(record==null){
		
	}else{
		var awardsType = record.get("awardsType");
		if(awardsType==""||awardsType==null){
			L5.Msg.alert('提醒','立功受奖种类不能为空！');
			return false;
		}
		var awardsName = record.get("awardsName");
		if(awardsName==""||awardsName==null){
			L5.Msg.alert('提醒','立功受奖名称不能为空！');
			return false;
		}
		var awardsNumber = record.get("awardsNumber");
		if(awardsNumber==""||awardsNumber==null){
			L5.Msg.alert('提醒','立功受奖次数不能为空！');
			return false;
		}
		if(isNaN(awardsNumber)){
			L5.Msg.alert('提醒','立功受奖次数格式不正确！');
			return false;
		}
		var awardsTime = record.get("awardsTime");
		if(awardsTime!=""&&awardsTime!=null){
			if(isNaN(awardsTime)||awardsTime.length!=4){
				L5.Msg.alert('提醒','立功受奖年份格式不正确！');
				return false;
			} 
		}
	}
	L5.getCmp("awardWin").setVisible(false);
}