function init(){
	var manageReportDataSet=L5.DatasetMgr.lookup("manageReportDataSet");
	var manageDataSet=L5.DatasetMgr.lookup("manageDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	if(method=="insert"){
		document.getElementById("backInsert").style.display = "block";
		manageDataSet.newRecord();
		manageReportDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N"});
		reportWorkDataSet.setParameter("organCode", organCode);
		reportWorkDataSet.load();
	}else{
		document.getElementById("backInsert").style.display = "none";
		$("reportDate").disabled=true;
		manageReportDataSet.setParameter("RECORD_ID@=",recordId);
		manageReportDataSet.load();
		manageDataSet.setParameter("RECORD_ID@=",recordId);
		manageDataSet.load();
		reportWorkDataSet.load();
	}
}
function forInsert(){
	var manageReportDataSet=L5.DatasetMgr.lookup("manageReportDataSet");
	manageReportDataSet.removeAll();
	manageReportDataSet.setParameter("ORGAN_CODE@=", organCode);
	manageReportDataSet.setParameter("sort","CREATE_TIME");	
	manageReportDataSet.setParameter("dir","desc");
	manageReportDataSet.load();
	manageReportDataSet.on("load",function(){
		if (manageReportDataSet.getCount()>0){
			var manageDataSet=L5.DatasetMgr.lookup("manageDataSet");
			manageDataSet.setParameter("RECORD_ID@=",manageReportDataSet.getAt(0).get("recordId"));
			manageDataSet.load();
			manageDataSet.on("load",function(){
				manageDataSet.each(function(record,index){
					record.set("manageId","");
				});
			});
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				manageReportDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N"});
			});
		}
	});
	
}
function save(){
	var reportTime = document.getElementById("reportDate").value;
	if(reportTime==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
	if(document.getElementById("ifRule").value==""){
		L5.Msg.alert("提示","是否建立村民自治章程不能为空！");
		return;
	}
	if(document.getElementById("ifPact").value==""){
		L5.Msg.alert("提示","是否建立村规民约不能为空！");
		return;
	}
	if(document.getElementById("ifPact").value==""){
		L5.Msg.alert("提示","是否建立村务档案不能为空！");
		return;
	}
	var manageDataSet=L5.DatasetMgr.lookup("manageDataSet");
	var isValidate = manageDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var record=manageDataSet.getCurrent();
	//给上报数据赋值
	var manageReportDataSet=L5.DatasetMgr.lookup("manageReportDataSet");
	manageReportDataSet.set("reportDate",reportTime);
	manageReportDataSet.set("memberNum",record.get("memberNum"));
	if(record.get("ifRule")=='0'){
		manageReportDataSet.set("ruleNum",0);
		manageReportDataSet.set("notRuleNum",1);
	}else{
		manageReportDataSet.set("notRuleNum",0);
		manageReportDataSet.set("ruleNum",1);
	}
	if(record.get("ifPact")=='0'){
		manageReportDataSet.set("pactNum",0);
		manageReportDataSet.set("notPactNum",1);
	}else{
		manageReportDataSet.set("notPactNum",0);
		manageReportDataSet.set("pactNum",1);
	}
	if(record.get("ifArchive")=='0'){
		manageReportDataSet.set("archiveNum",0);
		manageReportDataSet.set("notArchiveNum",1);
	}else{
		manageReportDataSet.set("notArchiveNum",0);
		manageReportDataSet.set("archiveNum",1);
	}
	
	var reportRrecod = manageReportDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcManageReportCmd");
	command.setParameter("reportRrecod",reportRrecod);
	command.setParameter("record",record);
	
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}

	if (!command.error){ 
		L5.Msg.alert("提示","保存成功！",function(){
			var url="jsp/ext/cdc/manage/manage/vcdcManageInfoList.jsp";
			L5.forward(url,'',null);
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}

}
function forcheck(item){
var offOtherMon=item.value;
if (offOtherMon > "") 
{ 
   var reg=/^\d+$/; 
   if ( (offOtherMon.match(reg)== null)) 
    { 
     L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
	    item.focus();
	    }); 
	    item.value="";
	    return ; 
    }
}
}
function returnBack(){
	L5.MessageBox.confirm("提示", "是否保存数据？",function(sta){
		if(sta=="yes"){
			save();
		}else{
			var url="jsp/ext/cdc/manage/manage/vcdcManageInfoList.jsp";
			L5.forward(url,'',null);
		}
	});
}