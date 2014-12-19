//页面初始化方法
function init(){
	domicileDataset.setParameter("filterSql"," id like '"+organCode.substring(0,4)+"%000000'");
	domicileDataset.load();
	var reportDataset=L5.DatasetMgr.lookup('reportDataset');
	reportDataset.setParameter("hospitalArea",organCode);
	reportDataset.setParameter("currentJsp","hos");	
//	reportDataset.load();
}

var beginTime;
var endTime;
var bptType;
//查询方法
function query(){
	endTime=getParam("endTime");
	beginTime=getParam("beginTime");
	bptType =getParam("bptType");
	var reportDataset=L5.DatasetMgr.lookup('reportDataset');
	if(getParam("hosId")){
		reportDataset.setParameter("hospitalId",getParam("hosId"));
	}else{
		reportDataset.setParameter("hospitalArea",organCode);
	}
	reportDataset.setParameter("bptType",getParam("bptType"));
	reportDataset.setParameter("currentJsp","hos");	
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
	var hospitalId=selected[0].get("HOSPITAL_ID");
	var bptType = selected[0].get("BPT_TYPE");
	var data=new L5.Map();
	
	data.put("currentJsp","hos");
	data.put("hospitalId",hospitalId);
	data.put("bptType",bptType);
	data.put("beginTime",beginTime);
	data.put("endTime",endTime);	
	
	var url='jsp/cams/drel/mbalance/yfDetail.jsp';
	var text = '一站式救助报表明细';
	L5.forward(url,text,data);
}