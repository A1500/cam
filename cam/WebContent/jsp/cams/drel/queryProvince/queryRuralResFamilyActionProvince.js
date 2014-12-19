function init() {
	document.getElementById("assistanceBegin").value=getCurYM();
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
	document.getElementById("assistanceType_treatment").value=assistanceType;
}

function query(){

	var baseinfoFamilyDS=L5.DatasetMgr.lookup("baseinfoFamilyDS");
	baseinfoFamilyDS.baseParams["excelType"]="2";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	baseinfoFamilyDS.setParameter("cardNo",document.getElementById("cardNo").value);
	baseinfoFamilyDS.setParameter("familyName",document.getElementById("familyName").value);
	baseinfoFamilyDS.setParameter("familyCardNo",document.getElementById("familyCardNo").value);
	baseinfoFamilyDS.setParameter("sPeopleNum",document.getElementById("sPeopleNum").value);
	baseinfoFamilyDS.setParameter("ePeopleNum",document.getElementById("ePeopleNum").value);
	baseinfoFamilyDS.setParameter("assistanceType",assistanceType);
	baseinfoFamilyDS.setParameter("assistanceBegin",document.getElementById("assistanceBegin").value);
	baseinfoFamilyDS.setParameter("queryDate",document.getElementById("assistanceBegin").value);
	baseinfoFamilyDS.setParameter("povertyCause",document.getElementById("povertyCause").value);
	
	baseinfoFamilyDS.setParameter("sAssitancePeopleNum",document.getElementById("sAssitancePeopleNum").value);
	baseinfoFamilyDS.setParameter("eAssitancePeopleNum",document.getElementById("eAssitancePeopleNum").value);
	baseinfoFamilyDS.setParameter("assistanceMoneyStart",document.getElementById("assistanceMoneyStart").value);
	baseinfoFamilyDS.setParameter("assistanceMoneyEnd",document.getElementById("assistanceMoneyEnd").value);
	
	
	var domicileCode=document.getElementById("domicileCode").value;
	if(domicileCode){
		baseinfoFamilyDS.setParameter("domicileCode",domicileCode);
	}else{
		baseinfoFamilyDS.setParameter("domicileCode",organArea);
	}
	baseinfoFamilyDS.load();
	baseinfoFamilyDS.on("load", function(){
		var qrToolbar = L5.getCmp("qrToolbar");
    	if(baseinfoFamilyDS.getCount()>0) 
			qrToolbar.setText("家庭查询信息(" + baseinfoFamilyDS.getTotalCount() + "条)");
		else
			qrToolbar.setText("家庭查询信息");
    });
	noReclick(baseinfoFamilyDS,"queryId");
}

//明细
function detailHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:detail(\''+record.get("TREATMENT_ID")+'\',\''+record.get("ASSISTANCE_TYPE")+'\',\''+record.get("APPLY_ID")+'\')">'+value+'</a>';
}

function detail(treatmentId,assistanceType,applyId){
	//getFamilyInfo(treatmentId,assistanceType,applyId);
	var width = screen.width-100;
    var height = screen.height-140;
    var url ;
    if(assistanceType == '01'){
    	url="../query/cityFamilyDetail.jsp?treatmentId="+treatmentId+"&assistanceType="+assistanceType+"&applyId="+applyId;
    }else if(assistanceType == '02'){
    	url="../query/countryFamilyDetail.jsp?treatmentId="+treatmentId+"&assistanceType="+assistanceType+"&applyId="+applyId;
    }else if(assistanceType == '03'){
        url="../query/fiveFamilyDetail.jsp?treatmentId="+treatmentId+"&assistanceType="+assistanceType+"&applyId="+applyId;
    }
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
	 if(assistanceType == '01'){
    	var filename=assistanceBegin+"城市低保家庭查询";
    }else if(assistanceType == '02'){
   	    var filename=assistanceBegin+"农村低保家庭查询";
    }else if(assistanceType == '03'){
        var filename=assistanceBegin+"农村五保家庭查询";
    }
	
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
	document.getElementById("assistanceTypeName").value="";
	document.getElementById("sAssitancePeopleNum").value="";
	document.getElementById("eAssitancePeopleNum").value="";
	document.getElementById("assistanceMoneyStart").value="";
	document.getElementById("assistanceMoneyEnd").value="";
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