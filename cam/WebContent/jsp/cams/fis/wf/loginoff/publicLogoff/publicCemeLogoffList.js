function init(){
	var daiBanDataSet = L5.DatasetMgr.lookup("daiBanDataSet");
	daiBanDataSet.setParameter("FILL_ORGAN_CODE",organCode);
	daiBanDataSet.setParameter("APPLY_FLAG","L");
	daiBanDataSet.load();
	
	var fisCemeDataSet=L5.DatasetMgr.lookup("fisCemeInfoDataSet");
	fisCemeDataSet.setParameter("MANA_LEVEL_ID",organCode);
	fisCemeDataSet.setParameter("ORGAN_STATE","0");
	fisCemeDataSet.setParameter("PROP","1");
	fisCemeDataSet.load();
	document.getElementById("add").style.display = "none";
}

function newLogoff(){
	var data = new L5.Map();
	data.put("method","insert");
	var text="新增公墓撤销";
	var url="jsp/cams/fis/wf/loginoff/publicLogoff/publicCemeLogoffInsert.jsp";
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
	if(record.get("IS_REPORT")!="5"){
		L5.Msg.alert("提示","当前业务已提交，无法修改");
		return;
	}
	var cemeApplyId = record.get("CEME_APPLY_ID");
	var recordId= record.get("RECORD_ID");
	var data = new L5.Map();
	data.put("method","update");
	data.put("cemeApplyId",cemeApplyId);
	data.put("recordId",recordId);
	var text="新增公墓撤销";
	var url="jsp/cams/fis/wf/loginoff/publicLogoff/publicCemeLogoffInsert.jsp";
	L5.forward(url,text,data);
}
function detail(){
	var daiBanGridPanel = L5.getCmp("daiBanGridPanel");
	var records=daiBanGridPanel.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var cemeApplyId = records[0].get("CEME_APPLY_ID");
	var recordId= records[0].get("RECORD_ID");
	var data = new L5.Map();
	data.put("cemeApplyId",cemeApplyId);
	data.put("recordId",recordId);
	var url="jsp/cams/fis/wf/loginoff/publicLogoff/publicCemeLogoffDetail.jsp";
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
	if(records[0].get("IS_REPORT")!="5"){
		L5.Msg.alert('提示',"当前业务已在审批当中，请耐心等待");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要提交当前业务吗?提交后将不可更改或删除',function(state){
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
							cmd.execute("cemeLogoffUpdate");
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
	if(isReport!="5"){
		L5.Msg.alert("提示","当前业务正在流程中或已结束，禁止删除");
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
				L5.Msg.alert('提示', "保存时出现错误！" + cmd.error);
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
function getCurrentDate(){
	var currentDate="";
	var date = new Date().toLocaleDateString();
	currentDate += date.substr(0,4)+"-";
	currentDate += "0"+date.substr(5,1)+"-";
	currentDate += date.substr(7,2);
	return currentDate;
}

function queryApply(){
	var name = document.getElementById("name").value;
	var isReport = document.getElementById("isReport").value;
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