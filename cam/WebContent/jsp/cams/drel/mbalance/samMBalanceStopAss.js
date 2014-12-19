//页面初始化
function init() {
	var gvnListDS=L5.DatasetMgr.lookup("gvnListDS");
	gvnListDS.setParameter("hosStatus","1");
	gvnListDS.setParameter("domicileCode",organCode);
	gvnListDS.setParameter("dataSource",'HIS');
	//gvnListDS.load();
}
//根据ElementId得到组件的value
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
//查询方法
function query(){
	var gvnListDS=L5.DatasetMgr.lookup("gvnListDS");
	gvnListDS.setParameter("domicileCode",organCode);
	gvnListDS.setParameter("assitanceType",getParam("assitanceType"));	
	gvnListDS.setParameter("idCard",getParam("idCard"));
	gvnListDS.setParameter("inTime",getParam("inTime"));
	gvnListDS.setParameter("hosStatus",'1');
	gvnListDS.setParameter("dataSource",'HIS');
	gvnListDS.setParameter("hospitalId",getParam("hosId"));
	gvnListDS.load();
}
//停助方法
function stopAss(){
	winOperation("停助","stopAssWin","0");
}
//保存停助信息
function saveStop(){
	save("停助","0","stopAssWin");
}
//取消停助窗口
function undoStop(){
	closeWin("stopAssWin");
}
//取消恢复救助窗口
function undoResume(){
	closeWin("resumeAssWin");
}
//恢复救助
function resumeAss(){
	winOperation("恢复救助","resumeAssWin","1");
}
//恢复救助
function saveResume(){
	save("恢复救助","1","resumeAssWin");
}
//打开救助/停助窗口
function winOperation(msg,winId,status){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录停助!");
		return false;
	}
	if(selected[0].get("BALANCE_TIME")){
		L5.Msg.alert("提示","此人已出院，不能进行停助/恢复救助操作！");
		return;
	}
	if(selected[0].get("STATUS")!=status){
		//打开停助/救助信息窗口
		if(win==undefined){
			var win=L5.getCmp(winId);
		}
		win=L5.getCmp(winId);
		win.show();
		var statusDataset=L5.DatasetMgr.lookup("statusDataset");
		statusDataset.newRecord();
		var hosDataset=L5.DatasetMgr.lookup("hosDataset");
		if(msg=="停助"){
			document.getElementById("stopName").innerHTML=selected[0].get("NAME");
			document.getElementById("stopIdCard").innerHTML=selected[0].get("ID_CARD");
		}else if(msg=="恢复救助"){
			document.getElementById("resumeName").innerHTML=selected[0].get("NAME");
			document.getElementById("resumeIdCard").innerHTML=selected[0].get("ID_CARD");
		}
	}else{
		L5.Msg.alert('提示',"已经"+msg+"!");
		return false;
	}
	
}
//关闭救助/停助窗口
function closeWin(winId){
	if(win==undefined){
		var win=L5.getCmp(winId);
	}
	win=L5.getCmp(winId);
	win.hide();
}
//更新救助状态表中的救助状态
function save(msg,status,winId){
	L5.MessageBox.confirm('确定', '确定'+msg+'吗?',function(state){
		if(state=="yes"){
			var editGrid=L5.getCmp('editGridPanel');
			var selected = editGrid.getSelectionModel().getSelections();
			//修改一站式救助信息表中的救助状态
			var command=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMBalanceCmd"); 
			command.setParameter("balanceId",selected[0].get("BALANCE_ID"));
			command.setParameter("status",status);
			command.execute("stopAssistance");
			//修改救助状态表中的信息
			var statusDataset=L5.DatasetMgr.lookup("statusDataset");
			var records=statusDataset.getCurrent();
			records.set("balanceId",selected[0].get("BALANCE_ID"));
			records.set("status",status);
			var statusCommand=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMStatusCmd"); 
			statusCommand.setParameter("records",records);
			statusCommand.execute("save");
			if (!command.error||statusCommand.error) {
				L5.Msg.alert('提示',msg+"成功!");
				closeWin(winId);
				var gvnListDS=L5.DatasetMgr.lookup("gvnListDS");
				gvnListDS.setParameter("domicileCode",organCode);
				gvnListDS.setParameter("hosStatus","1");
				gvnListDS.load();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
				return false;
			}
		}
	});
}