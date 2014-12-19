function init(){
	var daiBanDataSet = L5.DatasetMgr.lookup("daiBanDataSet");
	daiBanDataSet.setParameter("FILL_ORGAN_CODE",organCode);
	daiBanDataSet.setParameter("APPLY_FLAG","L");
	daiBanDataSet.load();
//	document.getElementById("add").style.display = "none";
}

function newLogoff(){
	var fisCemeInfoDataSet = L5.DatasetMgr.lookup("fisCemeInfoDataSet");
	fisCemeInfoDataSet.setParameter("MANA_LEVEL_ID",organCode);
	fisCemeInfoDataSet.setParameter("PROP","2");
	fisCemeInfoDataSet.setParameter("ORGAN_STATE","0");
	fisCemeInfoDataSet.load(true);
	if(fisCemeInfoDataSet.getCount()=="0"){
		L5.Msg.alert('提示',"当前行政区不存在可关闭的公墓！");
		return;
	}
	var data = new L5.Map();
	data.put("method","insert");
	var text="新增公墓撤销";
	var url="jsp/cams/fis/wf/loginoff/fisCemeLogoffInsert.jsp";
	L5.forward(url,text,data);
}
function update(){
	var daiBanGridPanel = L5.getCmp("daiBanGridPanel");
	var records=daiBanGridPanel.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var record = records[0];
	if(record.get("IS_REPORT")!='4'&&record.get("IS_REPORT")!='10'){
		L5.Msg.alert("提示","当前业务已提交，无法修改！");
		return;
	}
	var cemeApplyId = record.get("CEME_APPLY_ID");
	var recordId = record.get("RECORD_ID");
	var data = new L5.Map();
	data.put("method","update");
	data.put("cemeApplyId",cemeApplyId);
	data.put("recordId",recordId);
	var text="新增公墓撤销";
	var url="jsp/cams/fis/wf/loginoff/fisCemeLogoffInsert.jsp";
	L5.forward(url,text,data);
}
function detail(){
	var daiBanGridPanel = L5.getCmp("daiBanGridPanel");
	var records=daiBanGridPanel.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var record = records[0];
	var cemeApplyId = record.get("CEME_APPLY_ID");
	var data = new L5.Map();
	data.put("cemeApplyId",cemeApplyId);
	var url="jsp/cams/fis/wf/loginoff/fisCemeLogoffDetail.jsp";
	L5.forward(url,"",data);
}
function submit(){
	//业务记录保存，提交
	var daiBanGridPanel = L5.getCmp("daiBanGridPanel");
	var records=daiBanGridPanel.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("IS_REPORT")!="4"&&records[0].get("IS_REPORT")!="10"){
		L5.Msg.alert('提示',"当前业务已提交，请耐心等待，不要重复提交");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定提交当前业务?提交后不可更改',function(state){
	if(state=="yes"){
		var waitConfig = {
		   interval: 500, 
		   duration: 3000,
		   increment: 6,
		   text: 'Submitting...',
		   scope:this,
		   fn:function(){
			   var cemeApplyId = records[0].get("CEME_APPLY_ID");
				var cmd = new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
				cmd.setParameter("cemeApplyId",cemeApplyId);
				cmd.execute("updateAndSend");
				if (!cmd.error) {
					L5.Msg.alert('提示', "成功提交至下一流程!");
					queryDaiban();
				} else {
					L5.Msg.alert('提示', "保存时出现错误！" + cmd.error);
				}
			}
		};
		L5.Msg.wait("正在提交数据，请等待...", "提交数据",waitConfig);
	}else{
		return false;
	}
});
	
}
function del(){
	var daiBanGridPanel = L5.getCmp("daiBanGridPanel");
	var records=daiBanGridPanel.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var record = records[0];
	var cemeApplyId = record.get("CEME_APPLY_ID");
	var isReport = record.get("IS_REPORT");
	if(isReport!="4"&&isReport!="10"){
		L5.Msg.alert("提示","当前业务已提交，无法删除！");
		return;
	}
	L5.MessageBox.confirm('确定', '确定要删除选定记录吗?',function(state){
		if(state=="yes"){
			var cmd = new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
			cmd.setParameter("cemeApplyId",cemeApplyId);
			cmd.execute("cemeLogoffDelete");
			if (!cmd.error) {
				L5.Msg.alert('提示', "数据删除成功!");
				queryDaiban();
			} else {
				L5.Msg.alert('提示', "删除时出现错误！" + cmd.error);
			}
	   }else{
		 return false;
	   }
	});
}
function queryDaiban(){
	var daiBanDataSet = L5.DatasetMgr.lookup("daiBanDataSet");
	daiBanDataSet.setParameter("FILL_ORGAN_CODE",organCode);
	daiBanDataSet.setParameter("APPLY_FLAG","L");
	daiBanDataSet.load();
}
function query(){
	var isReport = document.getElementById("isReport").value;
	var name = document.getElementById("name").value;
	var daiBanDataSet = L5.DatasetMgr.lookup("daiBanDataSet");
	daiBanDataSet.setParameter("FILL_ORGAN_CODE",organCode);
	daiBanDataSet.setParameter("APPLY_FLAG","L");
	daiBanDataSet.setParameter("IS_REPORT",isReport);
	daiBanDataSet.setParameter("NAME",name);
	daiBanDataSet.load();
}
function showState(){
	var daiBanGridPanel = L5.getCmp("daiBanGridPanel");
	var records=daiBanGridPanel.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(!records[0].get("CUR_ACTIVITY")){
		L5.Msg.alert("提示","当前业务没有进入审批流程，请先提交!");
		return;
	}
	var workflowDs = L5.DatasetMgr.lookup("workflowDs");
	workflowDs.setParameter("primaryKey",records[0].get("CEME_APPLY_ID"));
	workflowDs.setParameter("actDefName",records[0].get("CUR_ACTIVITY"));
	workflowDs.load(true);
	var assignmentId = workflowDs.getCurrent().get("ID");
	var url="jsp/workflow/monitor/flowview.jsp?assignmentId="+assignmentId;
	var text = "流程状态";
    L5.forward(url,text);
}