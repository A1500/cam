var  orgCode ;
var ifInsert ;
function init(){
	buttonControl();
	var peopleReportDataSet=L5.DatasetMgr.lookup("peopleReportDataSet");
	peopleReportDataSet.setParameter("ORGAN_CODE@=",organCode);
	peopleReportDataSet.setParameter("REPORT_TYPE@=","C");
	peopleReportDataSet.load();
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	var insertDataSet = L5.DatasetMgr.lookup("insertDataSet");
	insertDataSet.setParameter("organCode", organCode);
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
	var peopleReportDataSet = L5.DatasetMgr.lookup("peopleReportDataSet");
	peopleReportDataSet.setParameter("STATUS@=",_$("status"));
	peopleReportDataSet.setParameter("REPORT_DATE@=",_$("reportDate"));
	peopleReportDataSet.setParameter("REPORT_TYPE@=","C");
	peopleReportDataSet.setParameter("ORGAN_CODE@=",organCode);
	peopleReportDataSet.load();	
}
function insert(){
	var insertDataSet = L5.DatasetMgr.lookup("insertDataSet");
	insertDataSet.setParameter("organCode", organCode);
	insertDataSet.load();
	if(ifInsert){
		var data=new L5.Map();
		data.put("method","insert");
		var url="jsp/ext/cdc/manage/people/cdcPeopleReportEdit.jsp";
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
	var url="jsp/ext/cdc/manage/people/cdcPeopleReportEdit.jsp";
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
	var url="jsp/ext/cdc/manage/people/cdcPeopleReportDetail.jsp";
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
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcPeopleReportCmd");
			records[0].set("status","1");
			records[0].set("submitDate",getCurDate());
			command.setParameter("record", records[0]);
			command.execute("update");
			if (!command.error){
				if(organLevel=="SQ"||organLevel=="JD"){
					L5.Msg.alert("提示","上报成功！");
					getMsg();
				}else{
					L5.Msg.alert("提示","上报成功！");
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
	var url="jsp/ext/cdc/manage/people/cdcPeopleReportSum.jsp";
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
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcPeopleReportCmd");
			command.setParameter("id",records[0].get("recordId"));
			command.execute("delete");
			if (!command.error){
				var data=new L5.Map();
				data.put("method","insert");
				var url="jsp/ext/cdc/manage/people/cdcPeopleReportSum.jsp";
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
	var url="jsp/ext/cdc/manage/people/cdcPeopleReportSum.jsp";
	L5.forward(url,'',data);
}
//导出数据
function exportExcel(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
    if(records.length==0){
        L5.Msg.alert("提示","请选择要导出的记录！");
        return;
    }
    var queryCode="";
    var ds=L5.DatasetMgr.lookup("queryDs");
    ds.setParameter("REPORT_TYPE@=","C");
    ds.setParameter("PARENT_CODE@=",organCode);
    ds.load(true);
    for(var i=0;i<ds.getCount();i++){
    	queryCode += ds.getAt(i).get("organCode")+",";
    }
    queryCode = queryCode+organCode;
    var dataset=L5.DatasetMgr.lookup("queryDs2");
    dataset.setParameter("ORGAN_CODE@in",queryCode);
    dataset.setParameter("REPORT_TYPE@=","C");
    dataset.setParameter("REPORT_DATE@=",records[0].get("reportDate"));
    dataset.setParameter("sort","organCode");
//    dataset.setParameter("dir","desc");
    dataset.load(true);
	L5.dataset2excel(dataset,"/jsp/ext/cdc/manage/people/cdcPeopleInfoExcel.jsp?organName="+organName);
}
