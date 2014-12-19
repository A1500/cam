
function init(){
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.setParameter("sort","WORK_ID");
	reportWorkDataSet.setParameter("dir","DESC");
	
	reportWorkDataSet.load();
	L5.QuickTips.init();
}
function insert(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/cams/comm/brief/camsReportWorkEdit.jsp";
	L5.forward(url,'',data);
}
function update(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","update");
	data.put("workId",records[0].get("workId"));
	var url="jsp/cams/comm/brief/camsReportWorkEdit.jsp";
	L5.forward(url,'',data);
}
/************************************添加任务的开启和关闭功能  zhangdd  2013-04-23 开始*********************************/
 /**
 *  上报任务管理
 *  事件处理：点击开启按钮
 *  
 *
 */
function unlock(){
    var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	//如果状态已经是开启状态则返回   0：开启  1：关闭
	if(records[0].get("status")=='1'){
		L5.Msg.alert("提示","该条任务已经开启!");
		return;
	}else{
	    L5.MessageBox.confirm("提示", "是否确认开启上报任务？",function(sta){
			if(sta=="yes"){ 
				var command=new L5.Command("com.inspur.cams.comm.brief.cmd.CamsReportWorkCommand"); 
			    command.setParameter("workId",records[0].get("workId"));
				command.execute("unlock");
				if (!command.error){//变更无误刷新结果
				  L5.Msg.alert("提示","操作成功!");
				  
				  var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
				  reportWorkDataSet.load();
				}else{
					L5.Msg.alert("提示","操作出错！");
				}
			}
		}); 
	}
}
 /**
 *  上报任务管理
 *  事件处理：点击关闭按钮
 *  
 *
 */
function lock(){
    var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	//如果状态已经是关闭状态则返回   0：开启  1：关闭
	if(records[0].get("status")=='0'){
		L5.Msg.alert("提示","该条任务已经关闭!");
		return;
	}else{
	    L5.MessageBox.confirm("提示", "是否确认关闭上报任务？",function(sta){
			if(sta=="yes"){
				var command=new L5.Command("com.inspur.cams.comm.brief.cmd.CamsReportWorkCommand"); 
				command.setParameter("workId",records[0].get("workId"));
				command.execute("lock");
				if (!command.error){
				    L5.Msg.alert("提示","操作成功!");
				    var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
				    reportWorkDataSet.load();
				}else{
					L5.Msg.alert("提示","操作出错！");
				}
			}
		});
    }
}

/************************************添加任务的开启和关闭功能 zhangdd  2013-04-23 开始*********************************/

function del() {
	var grid = L5.getCmp("grid");
	var records = grid.getSelectionModel().getSelections();
	if (records.length == 0) {
		L5.Msg.alert("提示", "请先选中一行!");
		return;
	}
	L5.MessageBox.confirm("提示", "确定删除该记录？", function(sta) {
		if (sta == "yes") {
			var command = new L5.Command("com.inspur.cams.comm.brief.cmd.CamsReportWorkCommand");
			command.setParameter("workId", records[0].get("workId"));
			command.execute("delete");
			if (!command.error) {
				L5.Msg.alert("提示", "删除成功！", function() {
							init();
						});
			} else {
				L5.Msg.alert("提示", "删除出错！" + command.error);
			}
		}
	});
}