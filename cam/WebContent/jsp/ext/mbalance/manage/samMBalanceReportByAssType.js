//页面初始化方法
function init(){
	var reportDataset=L5.DatasetMgr.lookup('reportDataset');
	reportDataset.setParameter("hospitalId",organId);
	reportDataset.setParameter("currentJsp","ass");	
	reportDataset.setParameter("regId",userId);
//	reportDataset.load();
}
var endTime;
var beginTime;
//查询方法
function query(){
	endTime=getParam("endTime");
	beginTime=getParam("beginTime");
	var reportDataset=L5.DatasetMgr.lookup('reportDataset');
	reportDataset.setParameter("assitanceType",getParam("assitanceType"));
	reportDataset.setParameter("hospitalId",organId);
	reportDataset.setParameter("currentJsp","ass");	
	reportDataset.setParameter("beginTime",getParam("beginTime"));		
	reportDataset.setParameter("endTime",getParam("endTime"));
	reportDataset.setParameter("regId",userId);
	reportDataset.load();
}
//查看明细
function lookDetail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一行记录!");
		return;
	}
	var assitanceType=selected[0].get("ASSITANCE_TYPE");
	var data=new L5.Map();
	data.put("assitanceType",assitanceType);
	data.put("beginTime",beginTime);
	data.put("endTime",endTime);
	data.put("regId",userId);
	var url='jsp/ext/mbalance/manage/detail.jsp';
	var text = '一站式救助报表明细';
	L5.forward(url,text,data);
}