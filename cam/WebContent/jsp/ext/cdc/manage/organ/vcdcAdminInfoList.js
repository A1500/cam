var  orgCode ;
var ifInsert ;
function init(){
	buttonControl();
	var adminReportDataSet=L5.DatasetMgr.lookup("adminReportDataSet");
	adminReportDataSet.setParameter("ORGAN_CODE@=",organCode);
	adminReportDataSet.setParameter("REPORT_TYPE@=","N");
	adminReportDataSet.setParameter("ORGAN_TYPE@=",'2');
	adminReportDataSet.load();
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	var insertDataSet = L5.DatasetMgr.lookup("insertDataSet");
	insertDataSet.setParameter("organCode", organCode);
	insertDataSet.setParameter("type", "2");
	insertDataSet.load();
	insertDataSet.on("load",function(){
		ifInsert = false;
		if(insertDataSet.getCount()>=1){
			ifInsert = true;
		}else{
			ifInsert = false;
		}
	});
}
function query(){
	var adminReportDataSet = L5.DatasetMgr.lookup("adminReportDataSet");
	adminReportDataSet.setParameter("STATUS@=",_$("status"));
	adminReportDataSet.setParameter("REPORT_DATE@=",_$("reportDate"));
	adminReportDataSet.setParameter("ORGAN_CODE@=",organCode);
	adminReportDataSet.setParameter("REPORT_TYPE@=","N");
	adminReportDataSet.setParameter("ORGAN_TYPE@=",'2');
	adminReportDataSet.load();	
}
function insert(){
	var insertDataSet = L5.DatasetMgr.lookup("insertDataSet");
	insertDataSet.setParameter("organCode", organCode);
	insertDataSet.setParameter("type", "2");
	insertDataSet.load();
	if(ifInsert){
		var data=new L5.Map();
		data.put("method","insert");
		var url="jsp/ext/cdc/manage/organ/vcdcAdminInfoEdit.jsp";
		L5.forward(url,'',data);
	}else{
		L5.Msg.alert("提示","暂无本项填报任务!");
	}
}
function update(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("status")=="1"){
		L5.Msg.alert("提示","已经上报，不允许修改!");
		return;
	}
	var data=new L5.Map();
	data.put("method","update");
	data.put("recordId",records[0].get("recordId"));
	var url="jsp/ext/cdc/manage/organ/vcdcAdminInfoEdit.jsp";
	L5.forward(url,'',data);
}
function detail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("recordId",records[0].get("recordId"));
	var url="jsp/ext/cdc/manage/organ/vcdcAdminInfoDetail.jsp";
	L5.forward(url,'',data);
}
function report(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("status")=="1"){
		L5.Msg.alert("提示","该数据已经上报!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否上报该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcOrganReportCmd");
			records[0].set("status","1");
			records[0].set("submitDate",getCurDate());
			command.setParameter("record", records[0]);
			command.execute("update");
			if (!command.error){
				L5.Msg.alert("提示","上报成功！");
				if(organLevel=='JD'||organLevel=='SQ'){
					getMsg();
				}
			}else{
				L5.Msg.alert("提示","上报出错！");
			}
		}
	});
}
function sumInsert(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/ext/cdc/manage/organ/vcdcAdminInfoSum.jsp";
	L5.forward(url,'',data);
}
function sumRedo(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("status")=="1"){
		L5.Msg.alert("提示","已经上报，不允许重新汇总!");
		return;
	}
	L5.MessageBox.confirm("提示", "重新汇总将删除原汇总数据，是否继续？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcOrganReportCmd");
			command.setParameter("id",records[0].get("recordId"));
			command.execute("delete");
			if (!command.error){
				var data=new L5.Map();
				data.put("method","insert");
				var url="jsp/ext/cdc/manage/organ/vcdcAdminInfoSum.jsp";
				L5.forward(url,'',data);
			}else{
				L5.Msg.alert("提示","删除原汇总数据出错！");
			}
		}
	});
}
function sumDetail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("method","detail");
	data.put("recordId",records[0].get("recordId"));
	var url="jsp/ext/cdc/manage/organ/vcdcAdminInfoSum.jsp";
	L5.forward(url,'',data);
}

//导出数据
function exportExcel(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
    if(records.length==0){
        L5.Msg.alert("提示","请选择一条汇总记录，再导出！");
        return;
    }
    var queryCode="";
    var dataset=L5.DatasetMgr.lookup("queryDs");
    dataset.setParameter("REPORT_TYPE@=","N");
    dataset.setParameter("PARENT_CODE@=",organCode);
    dataset.load(true);
    for(var i=0;i<dataset.getCount();i++){
    	queryCode += dataset.getAt(i).get("organCode")+",";
    }
    queryCode = queryCode+organCode;
    dataset.setParameter("ORGAN_CODE@in",queryCode);
    dataset.setParameter("REPORT_TYPE@=","N");
    dataset.setParameter("REPORT_DATE@=",records[0].get("reportDate"));
    dataset.setParameter("STATUS@=","1");
    dataset.setParameter("sort","organCode");
//    dataset.setParameter("dir","desc");
    dataset.load(true);
	L5.dataset2excel(dataset,"/jsp/ext/cdc/manage/organ/cdcAdminInfoExcel.jsp?organName="+organName);
}