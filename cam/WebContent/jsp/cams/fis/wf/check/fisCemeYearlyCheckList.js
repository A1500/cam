function init(){
	if(organType=="13"){
		act="县级整改";
	}else if(organType=="12"){
		act="市级审批";
		document.getElementById("workFlow").style.display="none";
		/*
		var editGrid=L5.getCmp('daiBanTaskGridPanel');
		editGrid.getColumnModel().setHidden(10, true);//隐藏 '当前环节'列
		editGrid.getColumnModel().setHidden(14, true);//隐藏 '发起单位'列
		editGrid.getColumnModel().setHidden(15, true);//隐藏 '当前时间'列
		*/
	}
	var daiBanDataset = L5.DatasetMgr.lookup("daiBanDataset");
	daiBanDataset.setParameter("organCode",organCode);
	daiBanDataset.load(true);
}

//重置
function resetClick() {
	document.getElementById("queryCemeName").value = '';
	document.getElementById("queryTime").value = '';
	document.getElementById("checkResult").value = '';
}
function queryDaiban(){
	var daiBanDataset = L5.DatasetMgr.lookup("daiBanDataset");
	var queryCemeName=document.getElementById("queryCemeName").value;
	var queryTime=document.getElementById("queryTime").value;
	var checkResult=document.getElementById("checkResult").value;
	daiBanDataset.setParameter("Name",'%'+queryCemeName+'%');
	daiBanDataset.setParameter("queryTime",queryTime);
	daiBanDataset.setParameter("checkResult",checkResult);
	daiBanDataset.setParameter("organCode",organCode);
	daiBanDataset.load();
}
function detail(){
	var editGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","DETAIL");
	data.put("organId",selected[0].get('ORGAN_ID'));
	data.put("recordId",selected[0].get('RECORD_ID'));
	data.put("scoreId",selected[0].get('SCORE_ID'));
	data.put("primaryKey",selected[0].get('CEME_APPLY_ID'));
	var url='jsp/cams/fis/wf/check/fisCemeYearlyCheckDetail.jsp';
	var text = '经营性公墓年检';
	L5.forward(url,text,data);
}

//新增年检,出本级下的公墓名称
function add(){
	var CemeInfoDs = L5.DatasetMgr.lookup("CemeInfoDs");
	CemeInfoDs.setParameter("MANA_LEVEL_ID",organCode);
	CemeInfoDs.setParameter("PROP","2");
	CemeInfoDs.load(true);
	if(CemeInfoDs.getCount() == 0){
		L5.Msg.alert('提示', "该区划下没有可参检的经营性公墓信息!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","INSERT");
	data.put("prop","2");
	var url='jsp/cams/fis/wf/check/fisCheck.jsp';
	var text = '经营性公墓年检';
	L5.forward(url,text,data);
}

//年检修改，判断是否县级 并且未上报
function edit(){
	var editGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	//分析处理前状态4：未报，0：已报 2:市级驳回
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	if(selected[0].get("IS_REPORT")=="4" || selected[0].get("IS_REPORT")=="10"){
			
			var data = new L5.Map();
			data.put("method","UPDATE");
			data.put("prop","2");
			data.put("taskCode",selected[0].get('CEME_APPLY_ID'));
			data.put("organId",selected[0].get('ORGAN_ID'));
			data.put("scoreId",selected[0].get('SCORE_ID'));
			var url='jsp/cams/fis/wf/check/fisCheck.jsp';
			var text = '经营性公墓年检';
			L5.forward(url,text,data);
		}else{
			L5.Msg.alert('提示',"该记录还没有进行检查!");
		}
	if(!(selected[0].get("IS_REPORT")=="4") && !(selected[0].get("IS_REPORT")=="10")){
		L5.Msg.alert('提示',"业务进行中，不能修改!");
		return false;
	}
}
//县级提交上级
function submit(){
	var editGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var historyDataSet = L5.DatasetMgr.lookup("historyDataSet");
	historyDataSet.setParameter("CEME_APPLY_ID",selected[0].get("CEME_APPLY_ID"));
	historyDataSet.load(true);
	var historyRecord = historyDataSet.getCurrent();
	historyRecord.set("checkResult","3");
	
	//判断是否已经上报过了
	if(!(selected[0].get("IS_REPORT")=="4") && !(selected[0].get("IS_REPORT")=="10")){
		L5.Msg.alert('提示',"该记录已经上报!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要上报选中的记录吗?上报后不可更改!',function(state){
		if(state=="yes"){
			var waitConfig = {
			   interval: 500, 
			   duration: 3000,
			   increment: 5,
			   text: 'Submiting...',
			   scope:this,
			   fn:function(){
			   		var command=new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
					command.setParameter("record",selected[0]);
					command.setParameter("hisRecord",historyRecord);
					command.setParameter("prop","2");
					command.setParameter("parentOrganCode",parentOrganCode);
					command.setParameter("parentOrganName",parentOrganName);
					command.setParameter("organType",organType);
					command.execute("createAndSendYearlyCheck");
			   		
			   		if(organType == "13"){
						if(!command.error){
							L5.Msg.alert('提示',"成功上报到下一环节");
							init();
						}else{
							L5.Msg.alert('提示',"上报时出现错误！"+command.error);
						}
					}
					if(organType == "12"){
						if(!command.error){
							L5.Msg.alert('提示',"上报成功");
							init();
						}else{
							L5.Msg.alert('提示',"上报时出现错误！"+command.error);
						}
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
	var editGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	
	//if(organType=="13"){县级未上报 和 市级未上报
		if(selected[0].get("IS_REPORT")=="4" || selected[0].get("IS_REPORT")=="10") {
			L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
				if(state=="yes"){
					var taskCode=selected[0].get("CEME_APPLY_ID");
					var scoreId=selected[0].get("SCORE_ID");
					var command=new L5.Command("com.inspur.cams.fis.base.cmd.FisCemeApplyInfoCmd");
					command.setParameter("cemeApplyId",taskCode);
					command.setParameter("scoreId",scoreId);
					command.execute("deleteAll");
					if(!command.error){
						L5.Msg.alert('提示',"删除成功");
						init();
					}else{
						L5.Msg.alert('提示',"删除时出现错误！"+command.error);
					}
					
				}else{
					return false;
				}
			});
		}
		else{
			L5.Msg.alert('提示',"已经提交的业务不能删除！");
		}
	//}
	
}

//选择公墓名称
function forCemeSelect(){
	var reValue = openCemeChoose();
	if (reValue != "" && reValue != undefined) {
		var arrs = reValue.split(",");
		document.getElementById("queryCemeName").value = arrs[1];
	}
}
function openCemeChoose(){
	return window.showModalDialog("../fisCemeInfomation.jsp?manaCode="+organCode+"&prop=2", "","dialogHeight:400px;dialogWidth:400px;resizable:yes;scroll:yes;status:no;");
}
function workFlow(){
	var daiBanTaskGridPanel=L5.getCmp("daiBanTaskGridPanel");
	var selecteds=daiBanTaskGridPanel.getSelectionModel().getSelections();
	if(selecteds.length!=1){
		L5.Msg.alert("提示","请选择一条您要查看的记录");
		return false;
	}
	if(selecteds[0].get("CUR_ACTIVITY")=="县级检查"){
		L5.Msg.alert("提示","当前业务没有进入审批流程，请先提交!");
		return;
	}
	var workflowDs = L5.DatasetMgr.lookup("workflowDs");
	workflowDs.setParameter("primaryKey",selecteds[0].get("CEME_APPLY_ID"));
	workflowDs.setParameter("actDefName",selecteds[0].get("CUR_ACTIVITY"));
	workflowDs.load(true);
	var assignmentId = workflowDs.getCurrent().get("ID");
	var url='jsp/workflow/monitor/flowview.jsp?assignmentId='+assignmentId;
	L5.forward(url);
}
