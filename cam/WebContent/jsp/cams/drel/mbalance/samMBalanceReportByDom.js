//页面初始化方法
function init(){
	var reportDataset=L5.DatasetMgr.lookup('reportDataset');
	reportDataset.setParameter("currentJsp","dom");	
	reportDataset.setParameter("domicileCode",organCode);
//	reportDataset.load();
}

var beginTime;
var endTime;
//查询方法
function query(){
	endTime=getParam("endTime");
	beginTime=getParam("beginTime");
	var reportDataset=L5.DatasetMgr.lookup('reportDataset');
	if(getParam("qapanageCode")){
		reportDataset.setParameter("domicileCode",getParam("qapanageCode"));
	}
	else{
		reportDataset.setParameter("domicileCode",organCode);
	}
	reportDataset.setParameter("beginTime",getParam("beginTime"));	
	reportDataset.setParameter("currentJsp","dom");	
	reportDataset.setParameter("endTime",getParam("endTime"));	
	reportDataset.load();
}
//重置查询条件
function resetQ(){
	document.getElementById("domicileCode").value="";
	document.getElementById("beginTime").value="";
	document.getElementById("endTime").value="";
	document.getElementById("domicile").value="";
}
//查看明细
function lookDetail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一行记录!");
		return;
	}
	var domicileCode=selected[0].get("DOMICILE_CODE");
	var data=new L5.Map();
	
	data.put("domicileCode",domicileCode);
	data.put("beginTime",beginTime);
	data.put("endTime",endTime);
	
	var url='jsp/cams/drel/mbalance/detail.jsp';
	var text = '一站式救助报表明细';
	L5.forward(url,text,data);
}