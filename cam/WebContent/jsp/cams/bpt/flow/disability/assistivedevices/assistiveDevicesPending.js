function init(){
	var AssistiveDevicesDataset = L5.DatasetMgr.lookup("AssistiveDevicesDataset");
	AssistiveDevicesDataset.setParameter("organCode",organCode);
	AssistiveDevicesDataset.load();
	hideButton("editGridPanel",[10,11],[],[2,3,4,5,8,9,10,11],[2,3,4,5,8,9,10,11]);
}
//根据区划级别隐藏按钮
function hideButton( grid,jbuts,qbuts,citybuts,sbuts){//街道,区县,市,省
	if(organType=='14'){//街道
		for(var i=0;i<jbuts.length;i++){
			L5.getCmp(grid).getTopToolbar().items.items[jbuts[i]].hide();
		}
	}else if(organType=='13'){//区县
		for(var i=0;i<qbuts.length;i++){
			L5.getCmp(grid).getTopToolbar().items.items[qbuts[i]].hide();
		}
	}else if(organType=='12'){//市
		for(var i=0;i<citybuts.length;i++){
			L5.getCmp(grid).getTopToolbar().items.items[citybuts[i]].hide();
		}
	}else if(organType=='11'){//省
		for(var i=0;i<sbuts.length;i++){
			L5.getCmp(grid).getTopToolbar().items.items[sbuts[i]].hide();
		}
	}
}
// 启用按钮
function enableButtons() {
	L5.getCmp("add_button").setDisabled(false);
	L5.getCmp("update_button").setDisabled(false);
	L5.getCmp("detail_button").setDisabled(false);
	L5.getCmp("del_button").setDisabled(false);
	L5.getCmp("submitButton").setDisabled(false);
}
// 停用按钮
function disableButtons() {
	L5.getCmp("add_button").setDisabled(true);
	L5.getCmp("update_button").setDisabled(true);
	L5.getCmp("detail_button").setDisabled(true);
	L5.getCmp("del_button").setDisabled(true);
	L5.getCmp("submitButton").setDisabled(true);
}
function del(){
	disableButtons();
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
	enableButtons();
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  peopleId=[];
			var  applyId=[];
			for(var i=0;i<selected.length;i++){
				peopleId[i]=selected[i].get("PEOPLE_ID");
				applyId[i]=selected[i].get("APPLY_ID");
			}
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesCommand");
			command.setParameter("peopleId", peopleId);
			command.setParameter("applyId", applyId);
			command.execute("deleteRecords");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	AssistiveDevicesDataset.remove(selected[i]);
				}
				AssistiveDevicesDataset.commitChanges();
			}else{
				L5.Msg.alert('提示',"删除时出现错误！"+command.error);
			}
	enableButtons();
		}else{
	enableButtons();
			return false;
		}
	});
}
function insert(){
	var url=L5.webPath + "/jsp/cams/bpt/flow/disability/assistivedevices/assistiveDevicesInsert.jsp";
	var width = screen.width-100;
	var height = screen.height-140;
	var returnValue = window.showModalDialog(url,"","dialogHeight:"+height+"px;dialogWidth:"+width+"px;resizable:no;scroll:no;status:no;");
	if(returnValue!=""&returnValue!=undefined){
 		var list = returnValue.split(";");
 		var peopleId = list[0];
 		var familyId = list[1];
 		var applyId = list[2];
 		var url2="assistiveDevicesUpdate.jsp?peopleId="+peopleId+ "&familyId="+familyId+"&applyId="+applyId;
		var win = window.showModalDialog (url2,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		init();
		if (win==null) {
			return;
		}
 	}
}

function update(){
	var editGrid=L5.getCmp('editGridPanel');
	
	var selected=editGrid.getSelectionModel().getSelections();
	
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录进行修改！");
		return false;
	}
	var width = screen.width-100;
	var height = screen.height-140;
	var peopleId = selected[0].get("PEOPLE_ID");
	var familyId = selected[0].get("FAMILY_ID");
	var applyId = selected[0].get("APPLY_ID");
	var url=L5.webPath+ "/jsp/cams/bpt/flow/disability/assistivedevices/assistiveDevicesUpdate.jsp?peopleId="+peopleId+"&applyId="+applyId+"&familyId="+familyId;
	window.showModalDialog(url,"","dialogHeight:"+height+"px;dialogWidth:"+width+"px;resizable:no;scroll:no;status:no;");
	init();
}

//查看明细记录
function detail(){
	var editGrid=L5.getCmp('editGridPanel');
	
	var selected=editGrid.getSelectionModel().getSelections();
	
	if(selected.length!=1){
		L5.Msg.alert("提示","请选择一条记录查看！");
		return false;
	}
	var width = screen.width-100;
	var height = screen.height-140;
	var peopleId = selected[0].get("PEOPLE_ID");
	var applyId = selected[0].get("APPLY_ID");
	var familyId = selected[0].get("FAMILY_ID");
	var url="assistiveDevicesDetail.jsp?peopleId="+peopleId+"&applyId="+applyId+"&familyId="+familyId+"&applyId="+applyId;
	var win = window.showModalDialog(url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if(win==null){return;}
}

function createAndSend(){
	disableButtons();
	   	var editGrid=L5.getCmp('editGridPanel');
		var selected=editGrid.getSelectionModel().getSelections();
		if(selected.length!=1){
			L5.Msg.alert("提示","请选择一个人员进行提交！");
	enableButtons();
			return false;
		}
		 L5.getCmp("submitButton").setDisabled(true);
	   	 var AssistiveDevicesRecord = selected[0];
	   	 var peopleId = AssistiveDevicesRecord.get("PEOPLE_ID");
	   	 var applyId = AssistiveDevicesRecord.get("APPLY_ID");
	     var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesCommand");
	     command.setParameter("PEOPLE_ID", peopleId);
	     command.setParameter("APPLY_ID", applyId);
	     command.execute("verifyTownInfor");
	     var checkIncharge = command.getReturn("checkIncharge");
	     var checkApproveDate = command.getReturn("checkApproveDate");
	     var agreeFlag = command.getReturn("agreeFlag");
	     var reportFlag = command.getReturn("reportFlag");
	     if(checkIncharge=="undefined"||checkApproveDate=="undefined"||checkIncharge==null||checkApproveDate==null){
	     		L5.getCmp("submitButton").setDisabled(false);
	     		L5.Msg.alert('提示','县级审核未填写完整！');
	enableButtons();
	     		return false;
	     }
	     if(agreeFlag==null||agreeFlag=="undefined"){
	     	L5.getCmp("submitButton").setDisabled(false);
	     	L5.Msg.alert('提示','必须选择审核意见！');
	enableButtons();
	     	return false;
	     }
	     if(agreeFlag=='1'&&(reportFlag==null||reportFlag=="undefined")){
	     	L5.getCmp("submitButton").setDisabled(false);
	     	L5.Msg.alert('提示','必须选择是否上报！');
	enableButtons();
	     	return false;
	     }
	     var condition;
	     if(agreeFlag=='0'){
	     	condition = "end";
	     }else if(agreeFlag=='1'&&reportFlag=='0'){
	     	condition = "end";
	     }else{
	     	condition = "pass";
	     }
	     command.setParameter("condition",condition);
	     command.execute("createAndSend");
	     if(!command.error){
	     	   AssistiveDevicesDataset.reLoad();
			   alert("流程发起并发送成功!");
	     }else{
	     	L5.getCmp("submitButton").setDisabled(false);
	      	alert(command.error);
	     }
	enableButtons();
}