var  orgCode ;
var parentCode;
function init(){
	var fReportDataSet=L5.DatasetMgr.lookup("fReportDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	if(method=="insert"){
		OrgCodeDataset.setParameter("filterSql","user_id = '"+organCode+"'");
		OrgCodeDataset.load();
		OrgCodeDataset.on("load",function() {
			parentCode = organCode;
			orgCode = OrgCodeDataset.get("text");
				if(organLevel=="JD"){
					 parentCode = orgCode.substring(0,9)+"000";
				}
				fReportDataSet.newRecord({"organCode":orgCode,"organName":organName+"本级","parentCode":parentCode,"reportType":"C"});
				reportWorkDataSet.setParameter("organCode", orgCode);
				reportWorkDataSet.load();
			});
	}else{
		$("reportDate").disabled=true;
		document.getElementById("backInsert").style.display = "none";
		fReportDataSet.setParameter("RECORD_ID@=",recordId);
		fReportDataSet.on("load",function(){
			var record=fReportDataSet.getCurrent();
			if(record.get("offKindSelf")!=0){
				document.getElementById("offKind").value = "1"
			}else if(record.get("offKindLease")!=0){
				document.getElementById("offKind").value = "2"
			}else if(record.get("offKindLend")!=0){
				document.getElementById("offKind").value = "3"
			}else if(record.get("offKindOther")!=0){
				document.getElementById("offKind").value = "4"
			}
			if(record.get("offBuildNew")!=0){
				document.getElementById("offBuild").value = "1"
			}else if(record.get("offBuildChange")!=0){
				document.getElementById("offBuild").value = "2"
			}else if(record.get("offKindLend")!=0){
				document.getElementById("offBuildOther").value = "3"
			}
			
		});
		fReportDataSet.load();
		reportWorkDataSet.load();
	}
}
function forInsert(){
	var fReportDataSet=L5.DatasetMgr.lookup("fReportDataSet");
	fReportDataSet.removeAll();
	fReportDataSet.setParameter("ORGAN_CODE@=", orgCode);
	fReportDataSet.setParameter("sort","CREATE_TIME");	
	fReportDataSet.setParameter("dir","desc");
	fReportDataSet.load();
	fReportDataSet.on("load",function(){
		if (fReportDataSet.getCount()>0){
			var record=fReportDataSet.getCurrent();
			if(record.get("offKindSelf")=="1"){
				document.getElementById("offKind").value = "1"
			}else if(record.get("offKindLease")=="1"){
				document.getElementById("offKind").value = "2"
			}else if(record.get("offKindLend")=="1"){
				document.getElementById("offKind").value = "3"
			}else if(record.get("offKindOther")=="1"){
				document.getElementById("offKind").value = "4"
			}
			if(record.get("offBuildNew")=="1"){
				document.getElementById("offBuild").value = "1"
			}else if(record.get("offBuildChange")=="1"){
				document.getElementById("offBuild").value = "2"
			}else if(record.get("offKindLend")=="1"){
				document.getElementById("offBuildOther").value = "3"
			}
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				fReportDataSet.newRecord({"organCode":orgCode,"organName":organName,"parentCode":organCode,"reportType":"C"});
				reportWorkDataSet.setParameter("organCode", orgCode);
			});
		}
	});
}
function save(){
	if(document.getElementById("offNum").value==""){
		L5.Msg.alert("提示","办公服务用房数量不能为空！");
		return;
	}
	if(document.getElementById("offArea").value==""){
		L5.Msg.alert("提示","办公服务用房建筑面积不能为空！");
		return;
	}
	if(document.getElementById("offYear").value==""){
		L5.Msg.alert("提示","投入使用年份不能为空！");
		return;
	}
	if(document.getElementById("offMon").value==""){
		L5.Msg.alert("提示","办公服务用房投入资金不能为空！");
		return;
	}
	if(document.getElementById("offKind").value==""){
		L5.Msg.alert("提示","所有性质不能为空！");
		return;
	}
	if(document.getElementById("offBuild").value==""){
		L5.Msg.alert("提示","建筑性质不能为空！");
		return;
	}
	if(organLevel!="JD"){
		if(document.getElementById("outNum").value==""){
			L5.Msg.alert("提示","室外活动室数量不能为空！");
			return;
		}
		if(document.getElementById("outArea").value==""){
			L5.Msg.alert("提示","室外活动室面积不能为空！");
			return;
		}
		if(document.getElementById("outYear").value==""){
			L5.Msg.alert("提示","室外活动室投入使用年份不能为空！");
			return;
		}
		if(document.getElementById("outMon").value==""){
			L5.Msg.alert("提示","室外活动室投入资金不能为空！");
			return;
		}
	}
	var fReportDataSet=L5.DatasetMgr.lookup("fReportDataSet");
	var record=fReportDataSet.getCurrent();
	if(record.get("reportDate")==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
	var offKind = document.getElementById("offKind").value;
	if(offKind=='1'){
		record.set("offKindSelf",1);
		record.set("offKindLease",0);
		record.set("offKindLend",0);
		record.set("offKindOther",0);
	}else if(offKind=='2'){
		record.set("offKindSelf",0);
		record.set("offKindLease",1);
		record.set("offKindLend",0);
		record.set("offKindOther",0);
	}else if(offKind=='3'){
		record.set("offKindSelf",0);
		record.set("offKindLease",0);
		record.set("offKindLend",1);
		record.set("offKindOther",0);
	}else if(offKind=='4'){
		record.set("offKindSelf",0);
		record.set("offKindLease",0);
		record.set("offKindLend",0);
		record.set("offKindOther",1);
	}
	var offBuild = document.getElementById("offBuild").value;
	if(offBuild=='1'){
		record.set("offBuildNew",1);
		record.set("offBuildChange",0);
		record.set("offBuildOther",0);
	}else if(offBuild=='2'){
		record.set("offBuildNew",0);
		record.set("offBuildChange",1);
		record.set("offBuildOther",0);
	}else if(offBuild=='3'){
		record.set("offBuildNew",0);
		record.set("offBuildChange",0);
		record.set("offBuildOther",1);
	}
	var isValidate = fReportDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcFacilitiesReportCmd");
	command.setParameter("record",record);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			var url="jsp/ext/cdc/manage/facilities/cdcFacilitiesReportList.jsp";
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
			var url="jsp/ext/cdc/manage/facilities/cdcFacilitiesReportList.jsp";
			L5.forward(url,'',null);
		}
	});
}

function getOffMon(){
	var sum1  = document.getElementById("offFinanceMon").value;
	var sum2 = document.getElementById("offSelfMon").value;
	var sum3 = document.getElementById("offEndowMon").value;
	var sum4 = document.getElementById("offOtherMon").value;
	var fReportDataSet=L5.DatasetMgr.lookup("fReportDataSet");
	var record=fReportDataSet.getCurrent();
	record.set("offMon",(Number(sum1)+Number(sum2)+Number(sum3)+Number(sum4)));
}

function getOutMon(){
	var sum1  = document.getElementById("outFinanceMon").value;
	var sum2 = document.getElementById("outSelfMon").value;
	var sum3 = document.getElementById("outOtherMon").value;
	var sum4 = document.getElementById("outEnbowMon").value;
	var fReportDataSet=L5.DatasetMgr.lookup("fReportDataSet");
	var record=fReportDataSet.getCurrent();
	record.set("outMon",Number(sum1)+Number(sum2)+Number(sum3)+Number(sum4));
}
function reRender(val){
	return val+" 万元";
}

//如是小数，保留到两位
function fordecimalcheck(item){
	var offOtherMon=item.value;
	if (offOtherMon > ""){ 
	   var reg=/^\d+(\.\d{0,2})?$/; 
	  
	   if ((offOtherMon.match(reg)== null)){ 
	    L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
	    item.focus();
	    }); 
	    item.value="";
	    return ; 
	 	}
	}
}
//判断是否是整数
function forcheck(item){
	var offOtherMon=item.value;
	if (offOtherMon > ""){ 
	   var reg=/[^\d]/g;
	   if ((offOtherMon.match(reg)!= null)){ 
	     L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
	    item.focus();
	    }); 
	    item.value="";
	    return ; 
	 	}
	}
}