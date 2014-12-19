var  orgCode ;
var ifInsert ;
function init(){
	myButtonControl();
	var OrgCodeDataset = L5.DatasetMgr.lookup("OrgCodeDataset");
	var sFacilitiesDataSet=L5.DatasetMgr.lookup("sFacilitiesDataSet");
	OrgCodeDataset.setParameter("filterSql","user_id = '"+organCode+"'");
	OrgCodeDataset.load();
	OrgCodeDataset.on("load",function() {
		if(organLevel=='JD'){
			sFacilitiesDataSet.setParameter("ORGANCODE",organCode);
			sFacilitiesDataSet.load();
		}else{
			orgCode = OrgCodeDataset.get("text");
			sFacilitiesDataSet.setParameter("orgCode",orgCode);
			sFacilitiesDataSet.setParameter("ORGANCODE",organCode);
			sFacilitiesDataSet.load();
		}
			
		});
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
	var sFacilitiesDataSet = L5.DatasetMgr.lookup("sFacilitiesDataSet");
	sFacilitiesDataSet.setParameter("ORGANCODE",organCode);
	sFacilitiesDataSet.setParameter("orgCode",orgCode);
	sFacilitiesDataSet.setParameter("REPORTDATE",_$("reportDate"));
	sFacilitiesDataSet.setParameter("STATUS",_$("status"));
	sFacilitiesDataSet.load();	
}
function insert(){
	var insertDataSet = L5.DatasetMgr.lookup("insertDataSet");
	insertDataSet.setParameter("organCode", organCode);
	insertDataSet.load();
	if(ifInsert){
		var data=new L5.Map();
		data.put("method","insert");
		var url="jsp/ext/cdc/manage/servicefacilities/vcdcServiceFacilitiesEdit.jsp";
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
	if(organLevel=="JD"){
		if(records[0].get("ORGAN_CODE")!=organCode){
			L5.Msg.alert("提示","非本级填报数据，不允许修改!");
			return;
		}
	}else{
		if(records[0].get("ORGAN_CODE")!=orgCode){
			L5.Msg.alert("提示","非本级填报数据，不允许修改!");
			return;
		}
	}
	var data=new L5.Map();
	data.put("method","update");
	data.put("constructionId",records[0].get("CONSTRUCTION_ID"));
	var url="jsp/ext/cdc/manage/servicefacilities/vcdcServiceFacilitiesEdit.jsp";
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
	data.put("constructionId",records[0].get("CONSTRUCTION_ID"));
	var url="jsp/ext/cdc/manage/servicefacilities/vcdcServiceFacilitiesDetail.jsp";
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
	if(organLevel=="JD"){
		if(records[0].get("ORGAN_CODE")!=organCode){
			L5.Msg.alert("提示","非本级填报数据，不允许修改!");
			return;
		}
	}
	L5.MessageBox.confirm("提示", "是否上报该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcServiceFacilitiesCmd");
			command.setParameter("id", records[0].get("CONSTRUCTION_ID"));
			command.execute("report");
			if (!command.error){
				L5.Msg.alert("提示","上报成功！");
				if(organLevel=='JD'||organLevel=='SQ'){
					getMsg();
				}
				var sFacilitiesDataSet=L5.DatasetMgr.lookup("sFacilitiesDataSet");
				sFacilitiesDataSet.reload();
			}else{
				L5.Msg.alert("提示","上报出错！");
			}
		}
	});
}
function sumInsert(){
	var data=new L5.Map();
	data.put("method","insert");
	var url="jsp/ext/cdc/manage/servicefacilities/vcdcServiceFacilitiesSum.jsp";
	L5.forward(url,'',data);
}
function sumRedo(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("ORGAN_CODE") != organCode){
		L5.Msg.alert("提示","非本级填报数据，不允许重新汇总!");
		return;
	}
	if(records[0].get("STATUS")=="1"){
		L5.Msg.alert("提示","已经上报，不允许重新汇总!");
		return;
	}
	L5.MessageBox.confirm("提示", "重新汇总将删除原汇总数据，是否继续？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcServiceFacilitiesCmd");
			command.setParameter("delIds",records[0].get("CONSTRUCTION_ID"));
			command.execute("delete");
			if (!command.error){
				var data=new L5.Map();
				data.put("method","insert");
				var url="jsp/ext/cdc/manage/servicefacilities/vcdcServiceFacilitiesSum.jsp";
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
	if(records[0].get("ORGAN_CODE")!=organCode){
			L5.Msg.alert("提示","非本级汇总数据!");
			return;
	}
	var data=new L5.Map();
	data.put("method","detail");
	data.put("constructionId",records[0].get("CONSTRUCTION_ID"));
	var url="jsp/ext/cdc/manage/servicefacilities/vcdcServiceFacilitiesSum.jsp";
	L5.forward(url,'',data);
}
function myButtonControl(){
	if(organLevel=="JD"){
		$("sum1").style.display="none";
		$("sum2").style.display="none";
		$("sum3").style.display="none";
	}
	if(organLevel=="11"){
		$("detail1").style.display="none";
		$("detail2").style.display="none";
	}
}
