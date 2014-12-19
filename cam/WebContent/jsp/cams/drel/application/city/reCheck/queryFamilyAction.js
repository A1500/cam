function init() {
	document.getElementById("assistanceBegin").value=getCurYM();
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
	document.getElementById("assistanceType_treatment").value="01";
	if(organArea.substring(4,12) == '00000000'){//是市级或者省级
		samAssistanceItemList.setParameter("filterSql", "ITEM_TYPE='01' AND  AREA_CODE= '" + organArea+"'");
		samAssistanceItemList.load();	
	}else{
	    asisstanceClassDataset.setParameter("filterSql", "ASSISTANCE_TYPE='01' AND IN_USE='1' AND AREA_CODE= '" + organArea.substring(0, 6) + "000000'");//城市低保
	    asisstanceClassDataset.load();
	}
	var colModel = L5.getCmp("infoQueryGrid").getColumnModel();
	if(organArea.substring(6,12) != '000000'){//是县级以下
		colModel.setDataIndex(1,"DOMICILE_NAME");
	}else{
		 colModel.setDataIndex(1,"DOMICILE_FULL_NAME");
	}
}

function query(){

	var baseinfoFamilyDS=L5.DatasetMgr.lookup("baseinfoFamilyDS");
	baseinfoFamilyDS.baseParams["excelType"]="2";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	baseinfoFamilyDS.setParameter("cardNo",document.getElementById("cardNo").value);
	baseinfoFamilyDS.setParameter("familyName",document.getElementById("familyName").value);
	baseinfoFamilyDS.setParameter("familyCardNo",document.getElementById("familyCardNo").value);
	baseinfoFamilyDS.setParameter("sPeopleNum",document.getElementById("sPeopleNum").value);
	baseinfoFamilyDS.setParameter("ePeopleNum",document.getElementById("ePeopleNum").value);
	baseinfoFamilyDS.setParameter("assistanceType","01");
	baseinfoFamilyDS.setParameter("assistanceBegin",document.getElementById("assistanceBegin").value);
	baseinfoFamilyDS.setParameter("queryDate",document.getElementById("assistanceBegin").value);
	baseinfoFamilyDS.setParameter("povertyCause",document.getElementById("povertyCause").value);
	baseinfoFamilyDS.setParameter("assistanceClass",document.getElementById("assistanceClass").value);
	baseinfoFamilyDS.setParameter("familyType",document.getElementById("assistanceType").value);
	baseinfoFamilyDS.setParameter("isSuspect",document.getElementById("isSuspect").value);//是否疑似
	/*baseinfoFamilyDS.setParameter("belonging",document.getElementById("belonging").value);*/
	var domicileCode=document.getElementById("domicileCode").value;
	if(domicileCode){
		baseinfoFamilyDS.setParameter("domicileCode",domicileCode);
	}else{
		baseinfoFamilyDS.setParameter("domicileCode",organArea);
	}
	var sAge=document.getElementById("sAge").value;
	var eAge=document.getElementById("eAge").value;
	if(sAge){
		baseinfoFamilyDS.setParameter("sAge",(new Date().getFullYear()-sAge)+'-01-01');
	}
	if(eAge){
		baseinfoFamilyDS.setParameter("eAge",(new Date().getFullYear()-eAge-1)+"-12-31");
	}
	
	baseinfoFamilyDS.load();
	baseinfoFamilyDS.on("load", function(){
		var qrToolbar = L5.getCmp("qrToolbar");
    	if(baseinfoFamilyDS.getCount()>0) 
			qrToolbar.setText("城市低保家庭查询信息(" + baseinfoFamilyDS.getTotalCount() + "条)");
		else
			qrToolbar.setText("城市低保家庭查询信息");
    });
	noReclick(baseinfoFamilyDS,"queryId");
}

//明细
function detailHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:detail(\''+record.get("TREATMENT_ID")+'\',\''+record.get("ASSISTANCE_TYPE")+'\',\''+record.get("APPLY_ID")+'\')">'+value+'</a>';
}
//明细
//function detailHref(value,cellmeta,record,rowindex,colindex,dataset){
//	return '<a href="javascript:detail(\''+record.get("TREATMENT_ID")+'\',\''+record.get("ASSISTANCE_TYPE")+'\',\''+record.get("APPLY_ID")+'\')">'+value+'</a>';
//}
function detail(treatmentId,assistanceType,applyId){
	//getFamilyInfo(treatmentId,assistanceType,applyId);
	//var width = screen.width-100;
    //var height = screen.height-140;
	//var url="cityFamilyDetail.jsp?treatmentId="+treatmentId+"&assistanceType="+assistanceType+"&applyId="+applyId;
	//var win=window.showModalDialog(url,window,"dialogHeight:"+height+"px;dialogWidth:"+width+"px;resizable:no;scroll:yes;status:no;");
	
	var width = screen.width-100;
    var height = screen.height-140;
	var url="cityFamilyDetail.jsp?treatmentId="+treatmentId+"&assistanceType="+assistanceType+"&applyId="+applyId;
	var win=window.showModalDialog(url,window,"dialogHeight:"+height+"px;dialogWidth:"+width+"px;resizable:no;scroll:yes;status:no;");

}

function detail(treatmentId,assistanceType,applyId){
	//getFamilyInfo(treatmentId,assistanceType,applyId);
	//var width = screen.width-100;
    //var height = screen.height-140;
	//var url="cityFamilyDetail.jsp?treatmentId="+treatmentId+"&assistanceType="+assistanceType+"&applyId="+applyId;
	//var win=window.showModalDialog(url,window,"dialogHeight:"+height+"px;dialogWidth:"+width+"px;resizable:no;scroll:yes;status:no;");
	
	var width = screen.width-100;
    var height = screen.height-140;
	var url="cityFamilyDetail.jsp?treatmentId="+treatmentId+"&assistanceType="+assistanceType+"&applyId="+applyId;
	var win=window.showModalDialog(url,window,"dialogHeight:"+height+"px;dialogWidth:"+width+"px;resizable:no;scroll:yes;status:no;");

}

//导出Excel
function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("baseinfoFamilyDS");	
	if(dataset.getCount()<=0){
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}	
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
	var assistanceBegin=document.getElementById("assistanceBegin").value;
	var filename=assistanceBegin+"城市低保家庭查询";
	var class_path = "com.inspur.cams.drel.funds.release.cmd.SamReleaseCSVCommand";
	var gridObj = L5.getCmp("infoQueryGrid");
	L5.grid2excel(dataset, gridObj, filename, class_path);
}
//重置
function resetQuery() {
	document.getElementById("assistanceBegin").value=getCurYM();
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
	document.getElementById("cardNo").value="";
	document.getElementById("familyName").value="";
	document.getElementById("familyCardNo").value="";
	document.getElementById("sPeopleNum").value="";
	document.getElementById("ePeopleNum").value="";
	document.getElementById("povertyCause").value="";
	document.getElementById("assistanceClass").value="";
	document.getElementById("assistanceType").value="";
	document.getElementById("assistanceTypeName").value="";
	/*document.getElementById("belonging").value="";*/
}

//获得当前日期 2011-05
function getCurYM(){
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10){month="0"+month;}
	return year+"-"+month;
}

// 弹出本地的行政区划
function func_ForDomicileSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
	}
}
function formatDate2String(date) {
	return date.getYear()+"-"+((date.getMonth()+1)>9?(date.getMonth()+1):"0"+(date.getMonth()+1))+"-"+(date.getDate()>9?date.getDate():"0"+date.getDate());
}
function endDateRender(value,cellmeta,record,rowindex,colindex,dataset){
	if("3000-12"==value||"3000-12-12"==value){
		return "";
	}
	return value;
}
//办理						
function handle(){
	var grid = L5.getCmp('infoQueryGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	
	if(records&&records.length==1){
		var width = screen.width-100;
	    var height = screen.height-140;
		var familyCardNo = records[0].get("FAMILY_CARD_NO");
		/*if(CURACTIVITYID != =nameValue){
				L5.Msg.alert("警告","此业务因乡镇（街道）操作时出现问题！请联系维护人员！");
				return;
			}
		    */
		familyDataSet.setParameter("FAMILY_CARD_NO", familyCardNo);
		familyDataSet.load(true);
		applyDataSet.removeAll();
		var command = new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityChangeCmd");
	    command.setParameter("applyRecord", applyDataSet.newRecord());
	    command.setParameter("familyRecord", familyDataSet.getCurrent());
	    command.setParameter("ensureId", records[0].get("ENSURE_ID"));
	    //command.execute("insertChangeFromRecheck");
	    command.execute("insertInfoFromRecheck");
	    if(!command.error){
//	    	L5.Msg.alert("警告","此业务因乡镇（街道）操作时出现问题！请联系维护人员！");
	    	alert("执行成功！");
	    	query();
	    }else{
	    	alert("执行失败！"+command.error);
	    }
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}

//批量审批
function batchHandle(){
	var grid = L5.getCmp('infoQueryGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	var familyIds = "";
	if(records&&records.length > 0){
		for(var i =0; i<records.length; i++){
			familyIds+=records[i].get("FAMILY_CARD_NO");
			if(i<records.length-1){
				familyIds+=";";
			}			
		}
		var command = new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityChangeCmd");
	    command.setParameter("familyIds", familyIds);
	    command.execute("batchInsertInfoFromRecheck");
	    if(!command.error){

	    	alert("批量登记执行成功！");
	    	query();
	    }else{
	    	alert("执行失败！"+command.error);
	    }
		
	}else{
		L5.Msg.alert("提示","请至少选择一条记录！");
	}
}

//获取当前时间
function getCurrent(){
	
	return (new Date()).getTime();
}
//显示当前标示
function getCheckFlag(value,a,rec){
   
	var str="";
	if(value="1"){
	
		str="未使用";
	}else{
	  str="已使用";
	}
	return str;
}



function peopleDetail(){
	var grid = L5.getCmp('infoQueryGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	cardNumDs.setParameter("APPLY_ID@=",records[0].get("APPLY_ID"));
	cardNumDs.load(true);
	var str = "";
	for(var i=0;i<cardNumDs.getCount();i++){
		str += cardNumDs.getAt(0).get("peopleId")+",";
	}
	str+="0";//随便添加个
	var _url="../../../comm/ensureInfo/peopleInfoDetail.jsp?peopleId="+str;
	var width = screen.width;
	var height = screen.height;
	var returnValue = window.showModalDialog(_url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:0");
}
var mydate="";
function ignore(){
	var grid = L5.getCmp('infoQueryGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records.length<1){
		L5.Msg.alert("提醒","至少选择一条记录！");
		return;
	}
	var ignoreWin = L5.getCmp("ignoreWin");
	ignoreWin.show();
	document.getElementById("operator").value=opreateName;
	var date = new Date();
    mydate = date.getYear()+"-"+date.getMonth()+"-"+date.getDay();
	document.getElementById("operateTime").value=mydate;
}

function ignoreConfirm(){
	var grid = L5.getCmp('infoQueryGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	var command = new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityChangeCmd");
    command.setParameter("ignoreReason", document.getElementById("ignoreReason").value);
    command.setParameter("operateTime", mydate);
    command.setParameter("organArea", organArea);
    command.setParameter("records", records);
    command.execute("ignoreSuspectedPersonnel");
    if(!command.error){
    	alert("执行成功！");
    	query();
    }else{
    	alert("执行失败！"+command.error);
    }
}


function closeWin(){
	var ignoreWin = L5.getCmp("ignoreWin");
	ignoreWin.hide();
}