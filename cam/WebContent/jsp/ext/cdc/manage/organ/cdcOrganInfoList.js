var  orgCode ;
var ifInsert ;
function init(){
	myButtonControl();
	if(organLevel=="SQ"){
		var OrgCodeDataset = L5.DatasetMgr.lookup("OrgCodeDataset");
		OrgCodeDataset.setParameter("filterSql","user_id = '"+organCode+"'");
		OrgCodeDataset.load(true);
		var areaCode = OrgCodeDataset.get("text");
		
		var organReportDataSet=L5.DatasetMgr.lookup("organReportDataSet");
		organReportDataSet.setParameter("ORGANCODE",areaCode);
		organReportDataSet.setParameter("REPORTTYPE","C");
		organReportDataSet.setParameter("SQFLAG","SQ");
		organReportDataSet.setParameter("ORGANTYPE","1");
		organReportDataSet.load();
	}else{
		var OrgCodeDataset = L5.DatasetMgr.lookup("OrgCodeDataset");
		var organReportDataSet=L5.DatasetMgr.lookup("organReportDataSet");
		OrgCodeDataset.setParameter("filterSql","user_id = '"+organCode+"'");
		OrgCodeDataset.load();
		OrgCodeDataset.on("load",function() {
			if(organLevel=="SQ"){
				organReportDataSet.setParameter("ORGANCODE",organCode);
				organReportDataSet.setParameter("REPORTTYPE","C");
				organReportDataSet.setParameter("orgCode",orgCode);	
				organReportDataSet.setParameter("ORGANTYPE","1");
				organReportDataSet.load();
			}else{
				orgCode = OrgCodeDataset.get("text");
				if(organLevel == "JD"){
					organCode=orgCode.substring(0,9)+"000"
				}
				organReportDataSet.setParameter("orgCode",orgCode);
				organReportDataSet.setParameter("ORGANCODE",organCode);
				organReportDataSet.setParameter("REPORTTYPE","C");
				organReportDataSet.setParameter("ORGANTYPE","1");
				organReportDataSet.load();
			}
			
		});
	}
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	var insertDataSet = L5.DatasetMgr.lookup("insertDataSet");
	insertDataSet.setParameter("organCode", organCode);
	insertDataSet.setParameter("type", "1");
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
	var organReportDataSet = L5.DatasetMgr.lookup("organReportDataSet");
	organReportDataSet.setParameter("ORGANCODE",organCode);
	if(organLevel=="SQ"){
		organReportDataSet.setParameter("JDFLAG","JD");	
	}else{
		organReportDataSet.setParameter("orgCode",orgCode);
	}
	organReportDataSet.setParameter("REPORTDATE",_$("reportDate"));
	organReportDataSet.setParameter("STATUS",_$("status"));
	organReportDataSet.setParameter("REPORTTYPE","C");
	organReportDataSet.setParameter("ORGANTYPE",'1');
	organReportDataSet.load();
}
function insert(){
	
	var insertDataSet = L5.DatasetMgr.lookup("insertDataSet");
	insertDataSet.setParameter("organCode", organCode);
	insertDataSet.load();
	if(ifInsert){
		var data=new L5.Map();
		data.put("method","insert");
		var url="jsp/ext/cdc/manage/organ/cdcOrganInfoEdit.jsp";
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
	if(records[0].get("STATUS")=="1"){
		L5.Msg.alert("提示","已经上报，不允许修改!");
		return;
	}
	var data=new L5.Map();
	data.put("method","update");
	data.put("recordId",records[0].get("RECORDID"));
	var url="jsp/ext/cdc/manage/organ/cdcOrganInfoEdit.jsp";
	L5.forward(url,'',data);
}
function detail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(organLevel!="SQ"){
		if(records[0].get("ORGANCODE")==organCode){
			var data=new L5.Map();
			data.put("method","detail");
			data.put("recordId",records[0].get("RECORDID"));
			var url="jsp/ext/cdc/manage/organ/cdcOrganInfoSum.jsp";
			L5.forward(url,'',data);
		}
	}
	
	var data=new L5.Map();
	data.put("recordId",records[0].get("RECORDID"));
	var url="jsp/ext/cdc/manage/organ/cdcOrganInfoDetail.jsp";
	L5.forward(url,'',data);
}
function report(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("STATUS")=="1"){
		L5.Msg.alert("提示","该数据已经上报!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否上报该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcOrganReportCmd");
			command.setParameter("id", records[0].get("RECORDID"));
			command.execute("report");
			if (!command.error){
				L5.Msg.alert("提示","上报成功！");
				if(organLevel=='JD'||organLevel=='SQ'){
					getMsg();
				}
				var organReportDataSet = L5.DatasetMgr.lookup("organReportDataSet");
				organReportDataSet.reload();
			}else{
				L5.Msg.alert("提示","上报出错！");
			}
		}
	});
}
function sumInsert(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/ext/cdc/manage/organ/cdcOrganInfoSum.jsp";
	L5.forward(url,'',data);
}
function sumRedo(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("STATUS")=="1"){
		L5.Msg.alert("提示","已经上报，不允许重新汇总!");
		return;
	}
	L5.MessageBox.confirm("提示", "重新汇总将删除原汇总数据，是否继续？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcOrganReportCmd");
			command.setParameter("id",records[0].get("RECORDID"));
			command.execute("delete");
			if (!command.error){
				var data=new L5.Map();
				data.put("method","insert");
				var url="jsp/ext/cdc/manage/organ/cdcOrganInfoSum.jsp";
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
	if(organLevel!="SQ"){
		if(records[0].get("ORGANCODE")!=organCode){
			L5.Msg.alert("提示","不是汇总数据!");
			return;
		}
	}
	var data=new L5.Map();
	data.put("method","detail");
	data.put("recordId",records[0].get("RECORDID"));
	var url="jsp/ext/cdc/manage/organ/cdcOrganInfoSum.jsp";
	L5.forward(url,'',data);
}
function myButtonControl(){
	if(organLevel=="SQ"){
		$("sum1").style.display="none";
		$("sum2").style.display="none";
		$("sum3").style.display="none";
	}
	/*if(organLevel!="SQ"){
		$("detail1").innerText =" 本级填报 ";
		$("detail1").style.display="";
	}*/
	if(organLevel=="11"){
		$("detail1").style.display="none";
		$("detail2").style.display="none";
		$("detail3").style.display="none";
		$("report").style.display="none";
	}
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
    dataset.setParameter("REPORT_TYPE@=","C");
    dataset.setParameter("PARENT_CODE@=",organCode);
    dataset.load(true);
    for(var i=0;i<dataset.getCount();i++){
    	queryCode += dataset.getAt(i).get("organCode")+",";
    }
    queryCode = queryCode+organCode;
    dataset.setParameter("ORGAN_CODE@in",queryCode);
    dataset.setParameter("REPORT_TYPE@=","C");
    dataset.setParameter("REPORT_DATE@=",records[0].get("reportDate"));
    dataset.setParameter("ORGAN_TYPE@=","1");
    dataset.setParameter("sort","organCode");
//    dataset.setParameter("dir","desc");
    dataset.load(true);
	L5.dataset2excel(dataset,"/jsp/ext/cdc/manage/organ/cdcOrganInfoExcel.jsp?organName="+organName);
}