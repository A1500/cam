//页面初始化方法
function init(){
	var reportDataset=L5.DatasetMgr.lookup('reportDataset');
	reportDataset.setParameter("currentJsp","ass");	
	reportDataset.setParameter("domicileCode",organCode);
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
	reportDataset.setParameter("currentJsp","ass");	
	reportDataset.setParameter("domicileCode",organCode);
	reportDataset.setParameter("beginTime",getParam("beginTime"));		
	reportDataset.setParameter("endTime",getParam("endTime"));	
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
	data.put("organCode",organCode);
	data.put("beginTime",beginTime);
	data.put("endTime",endTime);
	var url='jsp/cams/drel/mbalance/detail.jsp';
	var text = '一站式救助报表明细';
	L5.forward(url,text,data);
}