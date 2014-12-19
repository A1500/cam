function init(){
	var daiBanDataSet = L5.DatasetMgr.lookup("daiBanDataSet");
	daiBanDataSet.setParameter("FILL_ORGAN_CODE",organCode);
	daiBanDataSet.setParameter("APPLY_FLAG","C");
	daiBanDataSet.setParameter("CUR_ACTIVITY","变更备案");
	daiBanDataSet.load(true);
//	document.getElementById("add").style.display = "none";

}
function query(){
	var name = document.getElementById("name").value;
	var daiBanDataSet = L5.DatasetMgr.lookup("daiBanDataSet");
	daiBanDataSet.setParameter("FILL_ORGAN_CODE",organCode);
	daiBanDataSet.setParameter("APPLY_FLAG","C");
	daiBanDataSet.setParameter("CUR_ACTIVITY","变更备案");
	daiBanDataSet.setParameter("NAME",name);
	daiBanDataSet.load();
}
function add(){
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/fis/wf/change/fisCemeChangeRecordEdit.jsp';
	var text = '';
	L5.forward(url,text,data);
}
function edit(){
	var editGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var fisCemeChangeDs = L5.DatasetMgr.lookup("fisCemeChangeDs");
	fisCemeChangeDs.setParameter("CEME_APPLY_ID@=",selected[0].get('CEME_APPLY_ID'));
	fisCemeChangeDs.load(true);
	if (fisCemeChangeDs.get("ifConfirm")=="1"){
		L5.Msg.alert('提示',"变更备案已经提交，不能进行修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("recordId",selected[0].get('RECORD_ID'));
	data.put("cemeApplyId",selected[0].get('CEME_APPLY_ID'));
	data.put("changeId",selected[0].get('CHANGE_ID'));
	var url='jsp/cams/fis/wf/change/fisCemeChangeRecordEdit.jsp';
	var text = '县级发起';
	L5.forward(url,text,data);
}
function del(){
	var daiBanGridPanel = L5.getCmp("daiBanTaskGridPanel");
	var records=daiBanGridPanel.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var fisCemeChangeDs = L5.DatasetMgr.lookup("fisCemeChangeDs");
	fisCemeChangeDs.setParameter("CEME_APPLY_ID@=",records[0].get('CEME_APPLY_ID'));
	fisCemeChangeDs.load(true);
	if (fisCemeChangeDs.get("ifConfirm")=="1"){
		L5.Msg.alert('提示',"变更备案已经提交，不能进行修改!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选定记录吗?',function(state){
		if(state=="yes"){
			var record = records[0];
			var cemeApplyId = record.get("CEME_APPLY_ID");
			var isReport = record.get("IS_REPORT");
			//if(isReport!="4"){
			//	L5.Msg.alert("提示","当前业务正在流程中或已结束，不可删除");
			//	return;
			//}
			var cmd = new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
			cmd.setParameter("cemeApplyId",cemeApplyId);
			cmd.execute("cemeChangeDelete");
			if (!cmd.error) {
				L5.Msg.alert('提示', "数据删除成功!");
				init();
			} else {
				L5.Msg.alert('提示', "删除时出现错误！" + cmd.error);
			}
		}else{
			return false;
		}
	});
}
function detail(){
	var editGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var data = new L5.Map();
	data.put("recordId",selected[0].get('RECORD_ID'));
	data.put("cemeApplyId",selected[0].get('CEME_APPLY_ID'));
	var url='jsp/cams/fis/wf/change/fisCemeChangeRecordDetail.jsp';
	var text = '明细查看';
	L5.forward(url,text,data);
}
function submit(){
	var editGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var fisCemeChangeDs = L5.DatasetMgr.lookup("fisCemeChangeDs");
	fisCemeChangeDs.setParameter("CEME_APPLY_ID@=",selected[0].get('CEME_APPLY_ID'));
	fisCemeChangeDs.load(true);
	if (fisCemeChangeDs.get("ifConfirm")=="1"){
		L5.Msg.alert('提示',"变更备案已经提交，不能进行重复提交!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要上报此条记录吗?',function(state){
		if (state=="yes"){
			var waitConfig = {
					   interval: 500, 
					   duration: 4000,
					   increment: 5,
					   text: 'Updating...',
					   scope:this,
					   fn:function(){
						 //获取业务主键
							var cemeApplyId = selected[0].get("CEME_APPLY_ID");
							var command = new L5.Command("com.inspur.cams.fis.change.cmd.FisChangeCmd");
							command.setParameter("record", selected[0]);
							command.execute("createAndSendQualification");
							if(!command.error){
								L5.Msg.alert('提示','成功提交至下一环节！');
								
							}else{
								L5.Msg.alert('提示',"提交时出现错误！"+command.error);
							}
					   }
					};
					L5.Msg.wait("正在提交数据，请等待...", "提交数据",waitConfig);				
		}else {
			return false;
		}
	
	});
	
	init();
}
function renderDate(value,cellmeta,record) {
	var revalue="";
	revalue+= value.substr(0,10);
	return revalue;
}