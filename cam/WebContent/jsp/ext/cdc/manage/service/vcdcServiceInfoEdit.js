function init(){
	var serviceReportDataSet=L5.DatasetMgr.lookup("serviceReportDataSet");
	var serviceInfoDataSet=L5.DatasetMgr.lookup("serviceInfoDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	if(method=="insert"){
		serviceReportDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"communityNum":"1","reportType":"N"});
		reportWorkDataSet.setParameter("organCode", organCode);
		reportWorkDataSet.load();
	}else{
		document.getElementById("backInsert").style.display = "none";
		$("reportDate").disabled=true;
		serviceReportDataSet.setParameter("RECORD_ID@=",recordId);
		serviceReportDataSet.load();
		serviceInfoDataSet.setParameter("RECORD_ID@=",recordId);
		serviceInfoDataSet.load();
		reportWorkDataSet.load();
	}
	
}
function addService(){
	var serviceInfoDataSet=L5.DatasetMgr.lookup("serviceInfoDataSet");
	serviceInfoDataSet.newRecord();
	L5.getCmp("detailWin").setVisible(true);
}
function updateService(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	L5.getCmp("detailWin").setVisible(true);
	if(records[0].get('content')!=""){
	records[0].set('contents',records[0].get('content'));
	}
}
function deleteService(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var serviceInfoDataSet=L5.DatasetMgr.lookup("serviceInfoDataSet");
	serviceInfoDataSet.remove(records[0]);
	countNum();
}
function confirm(){
	countNum();
	L5.getCmp("detailWin").setVisible(false);
}
function closeWin(){
	L5.getCmp("detailWin").setVisible(false);
}
function countNum(){
	var serviceReportDataSet=L5.DatasetMgr.lookup("serviceReportDataSet");
	var serviceReportRecord=serviceReportDataSet.getCurrent();
	serviceReportRecord.set("serviceNum",0);
	serviceReportRecord.set("publicLocaleNum",0);
	serviceReportRecord.set("onceNum",0);
	serviceReportRecord.set("publicSupplyNum",0);
	serviceReportRecord.set("publicNum",0);
	serviceReportRecord.set("publicOtherNum",0);
	serviceReportRecord.set("publicMorgNum",0);
	serviceReportRecord.set("publicDayNum",0);
	serviceReportRecord.set("publicPeopleNum",0);
	serviceReportRecord.set("publicNotdayNum",0);
	serviceReportRecord.set("facilitateNum",0);
	serviceReportRecord.set("facilitateArea",0);
	serviceReportRecord.set("facilitateMorgNum",0);
	serviceReportRecord.set("facilitateDayNum",0);
	serviceReportRecord.set("facilitatePeopleNum",0);
	serviceReportRecord.set("voluntNum",0);
	serviceReportRecord.set("voluntYearNum",0);
	serviceReportRecord.set("voluntChildNum",0);
	serviceReportRecord.set("voluntHandiNum",0);
	serviceReportRecord.set("voluntOldNum",0);
	serviceReportRecord.set("voluntDiffNum",0);
	serviceReportRecord.set("voluntOtherNum",0);
	serviceReportRecord.set("volunteerNum",0);
	serviceReportRecord.set("regNum",0);
	var serviceInfoDataSet=L5.DatasetMgr.lookup("serviceInfoDataSet");
	serviceInfoDataSet.each(function(record,index){
		if(record.get('serviceType')=='1'){
			serviceReportRecord.set("serviceNum",serviceReportRecord.get("serviceNum")+1);
			serviceReportRecord.set("publicMorgNum",serviceReportRecord.get("publicMorgNum")+1);
			serviceReportRecord.set("publicNum",serviceReportRecord.get("publicNum")+1);
			serviceReportRecord.set("publicPeopleNum",serviceReportRecord.get("publicPeopleNum")+Number(record.get("peopleNum")));
			if(record.get("serviceMode")=="1"){
				serviceReportRecord.set("publicLocaleNum",serviceReportRecord.get("publicLocaleNum")+1);
			}else if (record.get("serviceMode")=="2"){
				serviceReportRecord.set("publicSupplyNum",serviceReportRecord.get("publicSupplyNum")+1);
			}else{
				serviceReportRecord.set("publicOtherNum",serviceReportRecord.get("publicOtherNum")+1);
			}
			if(record.get("serviceTime")=="1"){
				serviceReportRecord.set("publicDayNum",serviceReportRecord.get("publicDayNum")+1);
			}else{
				serviceReportRecord.set("publicNotdayNum",serviceReportRecord.get("publicNotdayNum")+1);
			}
		}else if(record.get('serviceType')=='2'){
			serviceReportRecord.set("facilitateNum",serviceReportRecord.get("facilitateNum")+1);
			serviceReportRecord.set("facilitateMorgNum",serviceReportRecord.get("facilitateMorgNum")+1);
			serviceReportRecord.set("facilitatePeopleNum",serviceReportRecord.get("facilitatePeopleNum")+Number(record.get("peopleNum")));
			serviceReportRecord.set("facilitateArea",serviceReportRecord.get("facilitateArea")+Number(record.get("serviceArea")));
			if( record.get("serviceTime") =="1"){
				serviceReportRecord.set("facilitateDayNum",serviceReportRecord.get("facilitateDayNum")+1);
			}
		}else{
			serviceReportRecord.set("voluntNum",serviceReportRecord.get("voluntNum")+1);
			if(record.get("foundDate").substring(0, 4).toString()==(new Date).getYear()){
				serviceReportRecord.set("voluntYearNum",serviceReportRecord.get("voluntYearNum")+1);
			}
			if(record.get("content")=="1"){
				serviceReportRecord.set("voluntChildNum",serviceReportRecord.get("voluntChildNum")+1);
			}else if(record.get("content")=="2"){
				serviceReportRecord.set("voluntOldNum",serviceReportRecord.get("voluntOldNum")+1);
			}else if(record.get("content")=="3"){
				serviceReportRecord.set("voluntHandiNum",serviceReportRecord.get("voluntHandiNum")+1);
			}else if(record.get("content")=="4"){
				serviceReportRecord.set("voluntDiffNum",serviceReportRecord.get("voluntDiffNum")+1);
			}else {
				serviceReportRecord.set("voluntOtherNum",serviceReportRecord.get("voluntOtherNum")+1);
			}
			serviceReportRecord.set("volunteerNum",serviceReportRecord.get("volunteerNum")+Number(record.get("peopleNum")));
			serviceReportRecord.set("regNum",serviceReportRecord.get("regNum")+Number(record.get("registeNum")));
		}
	});
}
function save(){
	var serviceReportDataSet=L5.DatasetMgr.lookup("serviceReportDataSet");
	var serviceInfoDataSet=L5.DatasetMgr.lookup("serviceInfoDataSet");
	var count = serviceInfoDataSet.getCount();
//	if(count<=0){
//		L5.Msg.alert("提示","请至少添加一条服务信息！");
//		return;
//	}
	var record=serviceReportDataSet.getCurrent();
	if(record.get("reportDate")==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
	if(count>0){
	var isValidate = true;
	serviceInfoDataSet.each(function(record,index){
		if(record.get('serviceType')=='1'){
			if(record.get('serviceName')==""){
				isValidate ="第"+(index+1)+"条记录的服务名称为空，请修改！";
				return;
			}
			if(record.get('content')==""){
				isValidate ="第"+(index+1)+"条记录的服务内容为空，请修改！";
				return;
			}
			if(record.get('morgName')==""){
				isValidate ="第"+(index+1)+"条记录的主管单位为空，请修改！";
				return;
			}
			if(record.get('serviceMode')==""){
				isValidate ="第"+(index+1)+"条记录的服务方式为空，请修改！";
				return;
			}
			if(record.get('headmen')==""){
				isValidate ="第"+(index+1)+"条记录的负责人为空，请修改！";
				return;
			}
			if(record.get('serviceTime')==""){
				isValidate ="第"+(index+1)+"条记录的是否全天服务为空，请修改！";
				return;
			}
			if(record.get('serviceAdds')==""){
				isValidate ="第"+(index+1)+"条记录的服务地点为空，请修改！";
				return;
			}
			if(record.get('peopleNum')==null||record.get('peopleNum')==0){
				isValidate ="第"+(index+1)+"条记录的服务人员数为空或零，请修改！";
				return;
			}
			
		}else if(record.get('serviceType')=='2'){
			if(record.get('serviceName')==""){
				isValidate ="第"+(index+1)+"条记录的服务名称为空，请修改！";
				return;
			}
			if(record.get('content')==""){
				isValidate ="第"+(index+1)+"条记录的服务内容为空，请修改！";
				return;
			}
			if(record.get('morgName')==""){
				isValidate ="第"+(index+1)+"条记录的主管单位为空，请修改！";
				return;
			}
			if(record.get('headmen')==""){
				isValidate ="第"+(index+1)+"条记录的负责人为空，请修改！";
				return;
			}
			if(record.get('serviceKind')==""){
				isValidate ="第"+(index+1)+"条记录的服务性质为空，请修改！";
				return;
			}
			if(record.get('peopleNum')==null||record.get('peopleNum')==0){
				isValidate ="第"+(index+1)+"条记录的服务人员数为空或零，请修改！";
				return;
			}
			if(record.get('serviceAdds')==""){
				isValidate ="第"+(index+1)+"条记录的服务地点为空，请修改！";
				return;
			}
			if(record.get('serviceArea')==""){
				isValidate ="第"+(index+1)+"条记录的服务场所面积为空，请修改！";
				return;
			}
			if(record.get('serviceTime')==""){
				isValidate ="第"+(index+1)+"条记录的是否24小时服务为空，请修改！";
				return;
			}
		}else if(record.get('serviceType')=='3'){
			if(record.get('serviceName')==""){
				isValidate ="第"+(index+1)+"条记录的服务名称为空，请修改！";
				return;
			}
			if(record.get('contents')!=""){
				record.set("content",record.get('contents'));
			}
			if(record.get('content')==""){
				isValidate ="第"+(index+1)+"条记录的服务内容为空，请修改！";
				return;
			}
			if(record.get('serviceKind')==""){
				isValidate ="第"+(index+1)+"条记录的服务性质为空，请修改！";
				return;
			}
			if(record.get('foundDate')==""){
				isValidate ="第"+(index+1)+"条记录的成立时间为空，请修改！";
				return;
			}
			if(record.get('peopleNum')==null||record.get('peopleNum')==0){
				isValidate ="第"+(index+1)+"条记录的志愿者总人数为空或零，请修改！";
				return;
			}
			if(record.get('registeNum')==null){
				isValidate ="第"+(index+1)+"条记录的注册志愿者人数为空，请修改！";
				return;
			}
		}else{
			isValidate ="第"+(index+1)+"条记录的服务类型为空，请修改！";
			return;
		}
	});
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	isValidate = serviceReportDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcServiceReportCmd");
	command.setParameter("record",record);
	command.setParameter("serviceInfos",serviceInfoDataSet.getAllRecords());
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			var url="jsp/ext/cdc/manage/service/vcdcServiceInfoList.jsp";
			L5.forward(url,'',null);
		});
	}else{
		L5.Msg.alert("提示","保存出错！"+command.error);
	}
}
function returnBack(){
	
	L5.MessageBox.confirm("提示", "是否保存数据？",function(sta){
		if(sta=="yes"){
			save();
		}else{
			var url="jsp/ext/cdc/manage/service/vcdcServiceInfoList.jsp";
			L5.forward(url,'',null);
		}
	});
}
function gRender(val){
	if(val!=""){
		return val+" 个";
	}
}
function pRender(val){
	if(val!=""){
		return val+" 人";
	}
}
function aRender(val){
	if(val!=""){
		return val+" ㎡";
	}
}

function serviceTypeChange(){
	var type = document.getElementById("serviceType").value;
	var public=document.getElementById("public");
	var benefit= document.getElementById("benefit");
	var volunteer= document.getElementById("volunteer");
	if(type =='1'){
			public.style.display="";
			benefit.style.display="none";
			volunteer.style.display="none";
	}else if(type =='2'){
			public.style.display="none";
			benefit.style.display="";
			volunteer.style.display="none";
	}else{
			public.style.display="none";
			benefit.style.display="none";
			volunteer.style.display="";
	}

}


//判断是否是整数
function forcheck(item){
	var offOtherMon=item.value;
	if (offOtherMon > ""){ 
	 //  var reg=/^\d+(\.\d{2})?$/; 
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

function forInsert(){
	var serviceReportDataSet=L5.DatasetMgr.lookup("serviceReportDataSet");
	var serviceInfoDataSet=L5.DatasetMgr.lookup("serviceInfoDataSet");
	serviceReportDataSet.removeAll();
	serviceReportDataSet.setParameter("ORGAN_CODE@=", organCode);
	serviceReportDataSet.setParameter("sort","CREATE_TIME");	
	serviceReportDataSet.setParameter("dir","desc");
	serviceReportDataSet.load();
	serviceReportDataSet.on("load",function(){
		if (serviceReportDataSet.getCount()>0){
			serviceInfoDataSet.setParameter("RECORD_ID@=",serviceReportDataSet.getAt(0).get("recordId"));
			serviceInfoDataSet.on("load",function(){
				serviceInfoDataSet.each(function(record,index){
					record.set("serviceId","");
				});
			});
			serviceInfoDataSet.load();
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				serviceReportDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"communityNum":"1","reportType":"N"});
			});
		}
	});
}