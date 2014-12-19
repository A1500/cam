function init(){
	var fisCemeApplyInfoDataSet=L5.DatasetMgr.lookup("fisCemeApplyInfoDataSet");
	fisCemeApplyInfoDataSet.setParameter("applyFlag","E");
	fisCemeApplyInfoDataSet.setParameter("prop","1");
	fisCemeApplyInfoDataSet.setParameter("mysetwhere","ZERO_UNIT_ID@=:"+organCode);
	fisCemeApplyInfoDataSet.load(true);
//	document.getElementById("insert").style.display = "none";

}
function query(){
	var name=document.getElementById('name').value;
	var organizer=document.getElementById('organizer').value;
	var domination=document.getElementById('domination').value;
	var applyTime=document.getElementById('applyTime').value;
	var fisCemeApplyInfoDataSet=L5.DatasetMgr.lookup("fisCemeApplyInfoDataSet");
	fisCemeApplyInfoDataSet.setParameter("applyFlag","E");
	fisCemeApplyInfoDataSet.setParameter("prop","1");
	
	var allConditon="";
	if(name!=""){
		allConditon="&NAME@LIKE:%"+name+"%";
	}
	if(organizer!=""){
		allConditon+="&ORGANIZER@LIKE:%"+organizer+"%";
	}
	if(domination!=""){
		allConditon+="&DOMINATION@LIKE:%"+domination+"%";
	}
	if(applyTime!=""){
		allConditon+="&APPLY_TIME@LIKE:%"+applyTime+"%";
	}
	fisCemeApplyInfoDataSet.setParameter("mysetwhere","ZERO_UNIT_ID@=:"+organCode+allConditon);
	fisCemeApplyInfoDataSet.load(true);
}
function insert(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/cams/fis/wf/expendCeme/fisCemeInfoEdit.jsp";
	L5.forward(url,'',data);
}
function update(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	//如果该申请已经上报，isReport is 1,那么不允许进行修改和提交
	if  (records[0].get("IS_REPORT")!=5)
	{
		L5.Msg.alert("提示","改申请已经上报，当前已不具备修改权限！",function(){
			return 0;
		});
	}else{
		var data=new L5.Map();
		data.put("method","update");
		data.put("cemeApplyId",records[0].get("CEME_APPLY_ID"));
		var url="jsp/cams/fis/wf/expendCeme/fisCemeInfoEdit.jsp";
		L5.forward(url,'',data);
	}
}
function submit(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if (records[0].get("IS_REPORT")!=5)
	{
		L5.Msg.alert("提示","流程正在流转，当前已不具备提交权限！",function(){
			return 0;
		});
	}else
	{
		L5.MessageBox.confirm('确定', '确定要上报此条记录吗?',function(state){
			if (state=="yes"){
				var waitConfig = {
						   interval: 500, 
						   duration: 4000,
						   increment: 5,
						   text: 'Updating...',
						   scope:this,
						   fn:function(){
							   var command=new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
								command.setParameter("cemeApplyId",records[0].get("CEME_APPLY_ID"));
								command.execute("startOfExpend");
									
								if (!command.error){
									L5.Msg.alert("提示","已经提交到下一环节！",function(){
										var fisCemeApplyInfoDataSet=L5.DatasetMgr.lookup("fisCemeApplyInfoDataSet");
										fisCemeApplyInfoDataSet.setParameter("applyFlag","E");
										fisCemeApplyInfoDataSet.setParameter("prop","1");
										fisCemeApplyInfoDataSet.setParameter("mysetwhere","ZERO_UNIT_ID@=:"+organCode);
										fisCemeApplyInfoDataSet.load(true);
										return true;
									});
								}else{
									L5.Msg.alert("提示","提交失败！"+command.error);
								}
						   }
						};
						L5.Msg.wait("正在提交数据，请等待...", "提交数据",waitConfig);				
			}else {
				return false;
			}
		
		});
	}
}

function detail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("cemeApplyId",records[0].get("CEME_APPLY_ID"));
	var url="jsp/cams/fis/wf/expendCeme/fisCemeInfoDetail.jsp";
	
	L5.forward(url,'',data);
}
function del(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if (records[0].get("IS_REPORT")!=5)
	{
		L5.Msg.alert("提示","流程正在流转，当前已不具备删除权限！",function(){
			return false;
		});
		return;
	}
	L5.MessageBox.confirm("提示", "是否删除该数据，删除后将无法恢复？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
			command.setParameter("cemeApplyId",records[0].get("CEME_APPLY_ID"));
			command.setParameter("recordId",records[0].get("RECORD_ID"));
			command.execute("deleteExpend");
			if (!command.error){
				var fisCemeApplyInfoDataSet=L5.DatasetMgr.lookup("fisCemeApplyInfoDataSet");
				fisCemeApplyInfoDataSet.setParameter("applyFlag","B");
				fisCemeApplyInfoDataSet.setParameter("prop","1");
				fisCemeApplyInfoDataSet.setParameter("mysetwhere","CREATE_ORGAN@=:"+organCode);
				fisCemeApplyInfoDataSet.load(true);
			}else{
				L5.Msg.alert("提示","删除出错！"+command.error);
			}
		}
	});
}
//查看待办流程图
function detailWF(){
	var daiBanTaskGridPanel=L5.getCmp("grid");
	var selecteds=daiBanTaskGridPanel.getSelectionModel().getSelections();
	if(selecteds.length!=1){
		L5.Msg.alert("提示","请选择一条您要查看的记录");
		return false;
	}
	if(!selecteds[0].get("CUR_ACTIVITY")){
		L5.Msg.alert("提示","当前业务没有进入审批流程，请先提交!");
		return;
	}
	var primaryKey=selecteds[0].get("CEME_APPLY_ID");
	var actDefName=selecteds[0].get("CUR_ACTIVITY");
	var workflowDs = L5.DatasetMgr.lookup("workflowDs");
	workflowDs.setParameter("primaryKey",primaryKey);
	workflowDs.setParameter("actDefName",actDefName);
	workflowDs.load(true);
	var assignmentId = workflowDs.getCurrent().get("ID");
	var url='jsp/workflow/monitor/flowview.jsp?assignmentId='+assignmentId;
	var text = "流程状态";
    L5.forward(url,text);
}
function renderDate(value,cellmeta,record) {
	var revalue="";
	revalue+= value.substr(0,10);
	return revalue;
}
function downloadmanaFile() {
	L5.Msg.confirm('信息确认', '确认要导出信息？', function(btn) {
				    if (btn == 'yes') {
				    	//window.open('../manual.doc');
				    //	window.open('../manual.doc').document.execCommand("SaveAs", true);
				    	window.open('download.jsp');
     			   		/*var url='jsp/cams/fis/wf/download.jsp';
				    	var text = "操作手册下载";
				        L5.forward(url,text);*/

				    	}
		});
}