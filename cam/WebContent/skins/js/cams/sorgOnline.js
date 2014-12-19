//*****************************************外网提交时更新onlineStatus方法
function updateOnlineStatus(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("onlineStatus") == "1"){
		L5.Msg.alert("提示","该业务已经提交，请勿重复提交!");
		return;
	}
	L5.Msg.confirm("确认","请仔细核对数据后提交，提交以后将不能修改数据，请确认是否提交！",onlineSubmitFunc);
}

function onlineSubmitFunc(y){
	if(y == "yes"){
		var grid=L5.getCmp("grid");
		var records=grid.getSelectionModel().getSelections();
		records[0].set("onlineStatus","1");
		records[0].set("acceptOpinion","");//将退回来的数据重新提交时，退回意见置空
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomApplyCmd");
		command.setParameter("SomApplyRecord", records[0]);
		command.execute("updateSomApply");
		if (!command.error) {
			L5.Msg.alert("提示","提交成功！",function(){
			});		
		}else{
			L5.Msg.alert('提示',"提交时出现错误！"+command.error);
		}
	}
}

//********************************************内网列表页面退回更新onlineStatus为2方法
function updateOnlineStatusN(){
	var grid=L5.getCmp("preGrid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("onlineStatus") == "2"){
		L5.Msg.alert("提示","该业务已经退回，请勿重复退回!");
		return;
	}
	L5.Msg.confirm("确认","请确认是否退回！",onlineSubmitFuncN);
}

function onlineSubmitFuncN(y){
	if(y == "yes"){
		var win=L5.getCmp('undo_Win');
		win.show();
		document.getElementById("undoSeason").value="";
	}
}
function confirmSubmitFuncN(){
	var grid=L5.getCmp("preGrid");
	var records=grid.getSelectionModel().getSelections();
	records[0].set("onlineStatus","2");
	records[0].set("acceptOpinion",document.getElementById("undoSeason").value);
	var command = new L5.Command("com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineCommand");
	command.setParameter("SomApplyOnlineRecord", records[0]);
	command.execute("updateSomApply");
	if (!command.error) {
		L5.Msg.alert("提示","退回成功！",function(){
			closeSubmitFuncN();
		});		
	}else{
		L5.Msg.alert('提示',"退回时出现错误！"+command.error);
	}
}
function closeSubmitFuncN(){
	var win=L5.getCmp('undo_Win');
	win.hide();
}
//***********************************内网受理页面退回更新onlineStatus为2方法，并添加回退原因——acceptOpinion
function updateOnlineStatusAndSeason(){
	var win=L5.getCmp('undoWin');
	win.show();
	document.getElementById("undoSeason").value="";
}
function confirmUndo(){
	var undoDataSet=L5.DatasetMgr.lookup("undoDataSet");
	undoDataSet.setParameter("TASK_CODE",taskCode);
	undoDataSet.load(true);//社会组织
	if(undoDataSet.getCount()>0){
		var record=undoDataSet.getAt(0);
		record.set("onlineStatus","2");
		record.set("acceptOpinion",document.getElementById("undoSeason").value);
		var command = new L5.Command("com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineCommand");
		command.setParameter("SomApplyOnlineRecord", record);
		command.execute("updateSomApply");
		if (!command.error) {
			L5.Msg.alert("提示","退回成功！",function(){
				var win=L5.getCmp('undoWin');
				win.hide();
			});		
		}else{
			L5.Msg.alert('提示',"退回时出现错误！"+command.error);
		}
	}
	
}
function closeUndo(){
	var win=L5.getCmp('undoWin');
	win.hide();
}
//************************************内网列表页面删除更新onlineStatus为9方法
function updateOnlineStatusDel(){
	var grid=L5.getCmp("preGrid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("onlineStatus") == "2"){
		L5.Msg.alert("提示","该业务不能删除!");
		return;
	}
	L5.Msg.confirm("确认","删除后不可恢复，是否确认删除？",confirmDel);
}
function confirmDel(y){
	if(y == "yes"){
		var grid=L5.getCmp("preGrid");
		var records=grid.getSelectionModel().getSelections();
		records[0].set("onlineStatus","9");//确认删除后，更改内网记录状态为9：删除
		var command = new L5.Command("com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineCommand");
		command.setParameter("SomApplyOnlineRecord", records[0]);
		command.execute("updateSomApply");
		if (!command.error) {
			L5.Msg.alert("提示","删除成功！",function(){
				init();
			});		
		}else{
			L5.Msg.alert('提示',"删除时出现错误！"+command.error);
		}
	}
}
//**********************外网列表页面删除更新onlineStatus为9方法*************************/
function updateOnlineStatusDelW(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("onlineStatus")!= "0" && records[0].get("onlineStatus")!=""&& records[0].get("onlineStatus")!="2"){
		L5.Msg.alert("提示","该业务不能删除!");
		return;
	}
	L5.Msg.confirm("确认","删除后不可恢复，是否确认删除？",confirmDelW);
}
function confirmDelW(y){
	if(y == "yes"){
		var grid=L5.getCmp("grid");
		var records=grid.getSelectionModel().getSelections();
		records[0].set("onlineStatus","9");//确认删除后，更改外网记录状态为9：删除
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomApplyCmd");
		command.setParameter("SomApplyRecord", records[0]);
		command.execute("updateSomApply");
		if (!command.error) {
			L5.Msg.alert("提示","删除成功！",function(){
				init();
			});		
		}else{
			L5.Msg.alert('提示',"删除时出现错误！"+command.error);
		}
	}
}
//**********************内网预受理页面提交至已受理状态，更新onlineStatus为3方法*************************/
function updateOnlineStatusAccept(){
	var updateStatusDataSet=L5.DatasetMgr.lookup("updateStatusDataSet");
	updateStatusDataSet.setParameter("TASK_CODE",taskCode);
	updateStatusDataSet.load(true);//社会组织
	if(updateStatusDataSet.getCount()>0){
		var record=updateStatusDataSet.getAt(0);
			if(record.get("dataSource")=="ONLINE"){
			record.set("onlineStatus","3");//提交成功后，更改外网记录状态为3：内网受理
			var command = new L5.Command("com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineCommand");
			command.setParameter("SomApplyOnlineRecord", record);
			command.execute("updateSomApply");
			if (!command.error) {
			}else{
				L5.Msg.alert('提示',"更改外网当前状态出错！"+command.error);
			}
		}
	}
}
//**********************内网业务审批通过后，根据taskCode更新onlineStatus为4方法*************************/
function updateOnlineStatusPass(taskCode){
	var updateStatusDataSet=L5.DatasetMgr.lookup("updateStatusDataSet");
	updateStatusDataSet.setParameter("TASK_CODE@=",taskCode);
	updateStatusDataSet.load(true);//社会组织
	if(updateStatusDataSet.getCount()>0){
		var record=updateStatusDataSet.getAt(0);
			if(record.get("dataSource")=="ONLINE"){
			record.set("onlineStatus","4");//业务审批通过成功后，更改外网记录状态为4:审批通过
			var command = new L5.Command("com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineCommand");
			command.setParameter("SomApplyOnlineRecord", record);
			command.execute("updateSomApply");
			if (!command.error) {
			}else{
				L5.Msg.alert('提示',"更改外网业务状态出错！"+command.error);
			}
		}
	}
}
//**********************内网业务审批不通过，根据taskCode更新onlineStatus为5方法*************************/
function updateOnlineStatusNoPass(taskCode){
	var updateStatusDataSet=L5.DatasetMgr.lookup("updateStatusDataSet");
	updateStatusDataSet.setParameter("TASK_CODE@=",taskCode);
	updateStatusDataSet.load(true);//社会组织
	if(updateStatusDataSet.getCount()>0){
		var record=updateStatusDataSet.getAt(0);
			if(record.get("dataSource")=="ONLINE"){
			record.set("onlineStatus","5");//业务审批不通过，更改外网记录状态为5:审批不通过
			var command = new L5.Command("com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineCommand");
			command.setParameter("SomApplyOnlineRecord", record);
			command.execute("updateSomApply");
			if (!command.error) {
			}else{
				L5.Msg.alert('提示',"更改外网业务状态出错！"+command.error);
			}
		}
	}
}