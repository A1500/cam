var  orgCode ;
function init(){
	var OrgCodeDataset = L5.DatasetMgr.lookup("OrgCodeDataset");
	var sFacilitiesDataSet=L5.DatasetMgr.lookup("sFacilitiesDataSet");
	
	if(method=="insert"){
	OrgCodeDataset.setParameter("filterSql","user_id = '"+organCode+"'");
	OrgCodeDataset.load();
	OrgCodeDataset.on("load",function() {
		orgCode = OrgCodeDataset.get("text");
		
		if(organLevel=='JD'){
			organCode= orgCode.substring(0,9)+"000";
		}
		var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
			if(organLevel=='JD'){
				sFacilitiesDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N"});
				reportWorkDataSet.setParameter("organCode", organCode);
			}else{
				sFacilitiesDataSet.newRecord({"organCode":orgCode,"organName":organName,"parentCode":organCode,"reportType":"N"});
				reportWorkDataSet.setParameter("organCode", orgCode);
			}
			reportWorkDataSet.load();
			});
		}else{
		$("reportDate").disabled=true;
		document.getElementById("backInsert").style.display = "none";
		sFacilitiesDataSet.setParameter("CONSTRUCTION_ID@=",constructionId);
		sFacilitiesDataSet.load();
		reportWorkDataSet.load();
	}
}
function forInsert(){
	var sFacilitiesDataSet=L5.DatasetMgr.lookup("sFacilitiesDataSet");
	sFacilitiesDataSet.removeAll();
	if(organLevel=='JD'){
		sFacilitiesDataSet.setParameter("ORGAN_CODE@=", organCode);
	}else{
		sFacilitiesDataSet.setParameter("ORGAN_CODE@=", orgCode);
	}
	sFacilitiesDataSet.setParameter("sort","CREATE_TIME");	
	sFacilitiesDataSet.setParameter("dir","desc");
	sFacilitiesDataSet.load();
	sFacilitiesDataSet.on("load",function(){
		if (sFacilitiesDataSet.getCount()>0){
		
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				if(organLevel=='JD'){
					sFacilitiesDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N"});
					reportWorkDataSet.setParameter("organCode", organCode);
				}else{
					sFacilitiesDataSet.newRecord({"organCode":orgCode,"organName":organName,"parentCode":organCode,"reportType":"N"});
					reportWorkDataSet.setParameter("organCode", orgCode);
				}
			});
		}
	});
	
}
function save(){
	if(document.getElementById('offConStatus').value == ''){
	 	L5.Msg.alert("提示","办公场所建设状态不能为空!");
	 	return false;
	}
	if(document.getElementById('offConKind').value == ''){
	 	L5.Msg.alert("提示","办公场所建设性质不能为空!");
	 	return false;
	}
	if(document.getElementById('offYear').value == ''){
	 	L5.Msg.alert("提示","办公场所使用年份不能为空!");
	 	return false;
	}
	if(document.getElementById('offConArea').value == ''){
	 	L5.Msg.alert("提示","办公场所建筑面积不能为空!");
	 	return false;
	}
	if(document.getElementById('offHouseArea').value == ''){
	 	L5.Msg.alert("提示","办公场所房间面积不能为空!");
	 	return false;
	}
	if(document.getElementById('offComputeNum').value == ''){
	 	L5.Msg.alert("提示","办公场所电脑数量不能为空!");
	 	return false;
	}
	if(document.getElementById('serConType').value == ''){
	 	L5.Msg.alert("提示","社区服务设施建设模式不能为空!");
	 	return false;
	}
	if(document.getElementById('serConStatus').value == ''){
	 	L5.Msg.alert("提示","社区服务设施建设状态不能为空!");
	 	return false;
	}
	if(document.getElementById('serPlace').value == ''){
	 	L5.Msg.alert("提示","社区服务设施所在地不能为空!");
	 	return false;
	}
	if(document.getElementById('serVillageNum').value == ''){
	 	L5.Msg.alert("提示","社区服务设施覆盖自然村个数不能为空!");
	 	return false;
	}
	if(document.getElementById('serTotleArea').value == ''){
	 	L5.Msg.alert("提示","社区服务设施覆盖面积不能为空!");
	 	return false;
	}
	if(document.getElementById('serConArea').value == ''){
	 	L5.Msg.alert("提示","社区服务设施建筑面积不能为空!");
	 	return false;
	}
	if(document.getElementById('serConKind').value == ''){
	 	L5.Msg.alert("提示","社区服务设施建设性质不能为空!");
	 	return false;
	}
	if(document.getElementById('serConFlag').value == ''){
	 	L5.Msg.alert("提示","社区服务设施是否有标识不能为空!");
	 	return false;
	}
	if(document.getElementById('serLen').value == ''){
	 	L5.Msg.alert("提示","社区服务设施服务半径不能为空!");
	 	return false;
	}
	var sFacilitiesDataSet=L5.DatasetMgr.lookup("sFacilitiesDataSet");
	var record=sFacilitiesDataSet.getCurrent();
	if(record.get("reportDate")==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
	var isValidate = sFacilitiesDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcServiceFacilitiesCmd");
	command.setParameter("record",record);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			var url="jsp/ext/cdc/manage/servicefacilities/vcdcServiceFacilitiesList.jsp";
	L5.forward(url,'',null);
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function returnBack(){
	
	L5.MessageBox.confirm("提示", "是否保存数据？",function(sta){
		if(sta=="yes"){
			save();
		}else{
			var url="jsp/ext/cdc/manage/servicefacilities/vcdcServiceFacilitiesList.jsp";
	L5.forward(url,'',null);
		}
	});
}
function reRender(val){
	if(val==''){
	return "0 万元";
	}
	return val+" 万元";
}
