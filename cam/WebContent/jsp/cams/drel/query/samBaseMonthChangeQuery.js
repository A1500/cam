function init(){
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
	document.getElementById("startMonth").value=getCurYM();
	document.getElementById("endMonth").value=getCurYM();
}

function query(){
	var baseinfoFamilyDS=L5.DatasetMgr.lookup("baseinfoFamilyDS");
	var changeItem=document.getElementById("changeItem").value;
	var assistanceType=document.getElementById("assistanceType").value;
	var startMonth = document.getElementById("startMonth").value;//查询时间
    var endMonth = document.getElementById("endMonth").value;//查询时间
    if(startMonth==""  || endMonth=="" ) {
		L5.Msg.alert("提示","请填写统计查询时间！");
		return;
	}
	baseinfoFamilyDS.setParameter("startMonth", startMonth);
	baseinfoFamilyDS.setParameter("endMonth", endMonth);
	baseinfoFamilyDS.setParameter("assistanceType",assistanceType);
	baseinfoFamilyDS.setParameter("changeItem",changeItem);
	var domicileCode=document.getElementById("domicileCode").value;
	if(domicileCode){
		baseinfoFamilyDS.setParameter("domicileCode",domicileCode);
	}else{
		baseinfoFamilyDS.setParameter("domicileCode",organArea);
	}
	baseinfoFamilyDS.load();
	baseinfoFamilyDS.on("load", function(){
		var qrToolbar = L5.getCmp("qrToolbar");
    	if(assistanceType=="01"){
			qrToolbar.setText("城市低保基本情况变动查询信息(" + baseinfoFamilyDS.getTotalCount() + "条)");
		}
		else if(assistanceType=="02"){
			qrToolbar.setText("农村低保基本情况变动查询信息(" + baseinfoFamilyDS.getTotalCount() + "条)");
		}else{
			qrToolbar.setText("农村五保基本情况变动查询信息(" + baseinfoFamilyDS.getTotalCount() + "条)");
		}
    });
	
}

function resetQuery(){
	document.getElementById("changeItem").value="new";
	document.getElementById("assistanceType").value="01";
	document.getElementById("startMonth").value=getCurYM();
	document.getElementById("endMonth").value=getCurYM();
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
}
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
	var startMonth=document.getElementById("startMonth").value;
	var endMonth=document.getElementById("endMonth").value;
	var filename="";
	if(startMonth!=endMonth){
		filename=startMonth+"至"+endMonth+"基本情况变动查询信息";
	}else{
		filename=startMonth+"基本情况变动查询信息";
	}
	var class_path = "com.inspur.cams.drel.funds.release.cmd.SamReleaseCSVCommand";
	var gridObj = L5.getCmp("infoQueryGrid");
	L5.grid2excel(dataset, gridObj, filename, class_path);
}

//明细
function detailHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:detail(\''+record.get("TREATMENT_ID")+'\',\''+record.get("ASSISTANCE_TYPE")+'\',\''+record.get("APPLY_ID")+'\')">'+value+'</a>';
}

function detail(treatmentId,assistanceType,applyId){
	var width = screen.width-100;
    var height = screen.height-140;
    if(assistanceType=="01"){
	var url="cityFamilyDetail.jsp?treatmentId="+treatmentId+"&assistanceType="+assistanceType+"&applyId="+applyId;
	}else if(assistanceType=="02"){
	var url="countryFamilyDetail.jsp?treatmentId="+treatmentId+"&assistanceType="+assistanceType+"&applyId="+applyId;
	} else if(assistanceType=="03"){
	var url="fiveFamilyDetail.jsp?treatmentId="+treatmentId+"&assistanceType="+assistanceType+"&applyId="+applyId;
	}
	var win=window.showModalDialog(url,window,"dialogHeight:"+height+"px;dialogWidth:"+width+"px;resizable:no;scroll:yes;status:no;");

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
//获得当前日期
function getCurYM(){
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10){month="0"+month;}
	return year+"-"+month;
}