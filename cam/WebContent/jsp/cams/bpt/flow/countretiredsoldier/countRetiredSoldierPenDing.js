function init(){
	var BptPeopleCountrySoldierDataSet = L5.DatasetMgr.lookup("BptPeopleCountrySoldierDataSet");
	BptPeopleCountrySoldierDataSet.setParameter("organCode",organCode);
	BptPeopleCountrySoldierDataSet.load();
	L5.QuickTips.init();
	hideButton("editGridPanel",[10,11,12,13],[],[2,3,4,5,8,9,10,11,12,13],[2,3,4,5,8,9,10,11,12,13]);
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
	L5.getCmp("bthSmtBtn").setDisabled(false);

}
// 停用按钮
function disableButtons() {
	L5.getCmp("add_button").setDisabled(true);
	L5.getCmp("update_button").setDisabled(true);
	L5.getCmp("detail_button").setDisabled(true);
	L5.getCmp("del_button").setDisabled(true);
	L5.getCmp("submitButton").setDisabled(true);
	L5.getCmp("bthSmtBtn").setDisabled(true);
}
function insert(){
	var url=L5.webPath + "/jsp/cams/bpt/flow/countretiredsoldier/countretiredsoldierInsert.jsp";  
	var width = screen.width-100;
    var height = screen.height-140;
    var returnValue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
 	if(returnValue!=""&returnValue!=undefined){
 		var list = returnValue.split(";");
 		var peopleId = list[0];
 		var familyId = list[1];
 		var applyId = list[2];
 		var url2="countRetiredSoldierUpdateManage.jsp?familyId="+familyId+"&peopleId="+peopleId+"&applyId="+applyId;
		var win = window.showModalDialog (url2,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		init();
		if (win=="createSend") {
			presure(applyId);
		}else{
			return;
		}
 	}
}
function presure(applyId){
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyCountrySoldierCommand");
	command.setParameter("applyId", applyId);
	command.execute("getSaveFlag");
	var saveFlag =command.getReturn("saveFlag");
	if(saveFlag=="1"){
		command.execute("applySubmit");
		if (!command.error) {
			L5.Msg.alert('提示','认定成功！');
			var BptPeopleCountrySoldierDataSet = L5.DatasetMgr.lookup("BptPeopleCountrySoldierDataSet");
			BptPeopleCountrySoldierDataSet.setParameter("organCode",organCode);
			BptPeopleCountrySoldierDataSet.load();
			L5.getCmp("submitButton").setDisabled(false);
		}else{
			L5.Msg.alert('提示',"认定时出现错误！"+command.error);
			L5.getCmp("submitButton").setDisabled(false);
		}
		enableButtons();
	}else{
		L5.Msg.alert('提示','必须县级审核之后才能提交！');
		enableButtons();
		L5.getCmp("submitButton").setDisabled(false);
	}
}
function sure(){//认定人员信息
	disableButtons();
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		enableButtons();
		return false;
	}
	L5.getCmp("submitButton").setDisabled(true);
	var applyId = selected[0].get('APPLY_ID');
	
	presure(applyId);
}
// 批量发起流程
function batchSend() {
	disableButtons();
	var name;
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择记录提交!");  
		enableButtons(); 
		return false;
	}
	L5.getCmp("bthSmtBtn").setDisabled(true);
	for(var i=0;i<selected.length;i++){
		var applyId = selected[i].get("APPLY_ID");
		name = selected[i].get("NAME");
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyCountrySoldierCommand");
		command.setParameter("applyId", applyId);
		command.execute("getSaveFlag");
		var saveFlag =command.getReturn("saveFlag");
		if(saveFlag=="1"){
			command.execute("applySubmit");
			if (!command.error) {
				if(selected.length==(i+1)){
					L5.Msg.alert('提示','批量认定成功！');
				}
			}else{
				L5.Msg.alert('提示',"【"+name+"】认定时出现错误！"+command.error);
		enableButtons();
				return false;
			}
		enableButtons();
		}else{
			L5.Msg.alert('提示','【'+name+'】未填写县级审核！');
		enableButtons();
			return false;
		}
	}
	var BptPeopleCountrySoldierDataSet = L5.DatasetMgr.lookup("BptPeopleCountrySoldierDataSet");
	BptPeopleCountrySoldierDataSet.setParameter("organCode",organCode);
	BptPeopleCountrySoldierDataSet.load();
	L5.getCmp("bthSmtBtn").setDisabled(false);
}
function update(){
		var editGrid=L5.getCmp('editGridPanel');
		var selected=editGrid.getSelectionModel().getSelections();
		if(selected.length!=1){
			L5.Msg.alert('提示',"请选择一条记录修改!");
			return false;
		} 
		var peopleId = selected[0].get('PEOPLE_ID');
		var familyId = selected[0].get('FAMILY_ID');
		var applyId = selected[0].get('APPLY_ID');
		var photoId = selected[0].get("PHOTO_ID");
		var url=L5.webPath+'/jsp/cams/bpt/flow/countretiredsoldier/countRetiredSoldierUpdateManage.jsp?peopleId='+peopleId + '&familyId=' + familyId+'&applyId='+applyId+'&photoId='+photoId;
		var width = screen.width-100;
    	var height = screen.height-140;
    	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		init();
		if (win=="createSend") {
			presure(applyId);
		}else{
			return;
		}
}

function detail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	var familyId = selected[0].get('FAMILY_ID');
	var peopleId = selected[0].get('PEOPLE_ID');
	var applyId = selected[0].get('APPLY_ID');
	var photoId = selected[0].get("PHOTO_ID");
	var width = screen.width-100;
    var height = screen.height-140;
	var url=L5.webPath+'/jsp/cams/bpt/flow/countretiredsoldier/countRetiredSoldierDetail.jsp?familyId='+familyId+'&peopleId='+peopleId+'&photoId='+photoId+'&applyId='+applyId;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if (win==null) {
		return;
	}
}
function del(){
	disableButtons();
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		enableButtons();
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyCountrySoldierCommand");
			command.setParameter("records", selected);
			command.execute("deleteCountrySoldier");
			if (!command.error) {
				init();
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
