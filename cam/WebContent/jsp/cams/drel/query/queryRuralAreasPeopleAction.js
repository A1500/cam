function init() {
	document.getElementById("assistanceBegin").value=getCurYM();
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
	document.getElementById("peopleStatus").value= "01";
	document.getElementById("isAssistance").value="1";
	var colModel = L5.getCmp("infoQueryGrid").getColumnModel();
	if(organArea.substring(6,12) != '000000'){//是县级以下
		colModel.setDataIndex(1,"DOMICILE_NAME");
	}else{
		 colModel.setDataIndex(1,"DOMICILE_FULL_NAME");
	}
}

function query(){
	var baseinfoPeopleDS=L5.DatasetMgr.lookup("baseinfoPeopleDS");
	baseinfoPeopleDS.baseParams["excelType"]="2";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	var domicileCode=document.getElementById("domicileCode").value;
	if(domicileCode){
		baseinfoPeopleDS.setParameter("domicileCode",domicileCode);
	}else{
		baseinfoPeopleDS.setParameter("domicileCode",organArea);
	}
	baseinfoPeopleDS.setParameter("name",document.getElementById("name").value);
	baseinfoPeopleDS.setParameter("selfCareAbility",document.getElementById("selfCareAbility").value);
	baseinfoPeopleDS.setParameter("idCard",document.getElementById("idCard").value);
	baseinfoPeopleDS.setParameter("sex",document.getElementById("sex").value);
	baseinfoPeopleDS.setParameter("nation",document.getElementById("nation").value);
	baseinfoPeopleDS.setParameter("healthCode",document.getElementById("healthCode").value);
	baseinfoPeopleDS.setParameter("marriageCode",document.getElementById("marriageCode").value);
	baseinfoPeopleDS.setParameter("disabilityType",document.getElementById("disabilityType").value);
	baseinfoPeopleDS.setParameter("eduCode",document.getElementById("eduCode").value);
	baseinfoPeopleDS.setParameter("queryDate",document.getElementById("assistanceBegin").value);
	var sAge=document.getElementById("sAge").value;
	var eAge=document.getElementById("eAge").value;
	if(sAge){
	baseinfoPeopleDS.setParameter("sAge",(new Date().getFullYear()-sAge)+'-'+nowTime.substring(5));
	}
	if(eAge){
	baseinfoPeopleDS.setParameter("eAge",(new Date().getFullYear()-eAge-1)+'-'+nowTime.substring(5));
	}
	
	baseinfoPeopleDS.setParameter("qDisabilityLevel",document.getElementById("qDisabilityLevel").value);
	baseinfoPeopleDS.setParameter("qEduStatus",document.getElementById("qEduStatus").value);
	baseinfoPeopleDS.setParameter("qPoliticalCode",document.getElementById("qPoliticalCode").value);
//	baseinfoPeopleDS.setParameter("isAssistance","1");
	baseinfoPeopleDS.setParameter("assistanceType","03");
//	baseinfoPeopleDS.setParameter("personalStatsTag","01");
	baseinfoPeopleDS.setParameter("supportWay",document.getElementById("supportWay").value);
	baseinfoPeopleDS.setParameter("gerocomiumName",document.getElementById("gerocomiumId").value);
	baseinfoPeopleDS.setParameter("isAssistance",document.getElementById("isAssistance").value);
	baseinfoPeopleDS.setParameter("personalStatsTag",document.getElementById("peopleStatus").value);
	//与户主关系
	baseinfoPeopleDS.setParameter("qRelationshipType",document.getElementById("relationshipType").value);
	baseinfoPeopleDS.load();
	baseinfoPeopleDS.on("load", function(){
		var qrToolbar = L5.getCmp("qrToolbar");
    	if(baseinfoPeopleDS.getCount()>0) 
			qrToolbar.setText("农村五保人员查询信息(" + baseinfoPeopleDS.getTotalCount() + "条)");
		else
			qrToolbar.setText("农村五保人员查询信息");
    });
	noReclick(baseinfoPeopleDS,"queryId");
}
//明细
function detailHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:detail(\''+record.get("PEOPLE_ID")+'\',\''+record.get("APPLY_ID")+'\',\''+record.get("ASSISTANCE_TYPE")+'\')">'+value+'</a>';
}

function detail(peopleId,applyId,assistanceType){
	getPeopleInfo(peopleId,applyId,assistanceType);
}

//导出Excel
function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("baseinfoPeopleDS");	
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
	var filename=assistanceBegin+"农村五保人员查询";
	var class_path = "com.inspur.cams.drel.funds.release.cmd.SamReleaseCSVCommand";
	var gridObj = L5.getCmp("infoQueryGrid");
	L5.grid2excel(dataset, gridObj, filename, class_path);

}
//重置
function resetQuery() {
	document.getElementById("queryForm").reset();
	document.getElementById("domicileName").value=organName;
	document.getElementById("domicileCode").value=organArea;
	document.getElementById("assistanceBegin").value=getCurYM();
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
//人员类型选择
function openHelp(ds,displayName,value) {
	var itemWin = L5.getCmp("multiItem_help");
	if(itemWin) {
		itemWin.show();
		return;
	} else {
		var itemDs = L5.DatasetMgr.lookup(ds);
		var item_config={};
		item_config.id="multiItem_help";
		item_config.dataset = itemDs;
		item_config.gridColumns=[{header:"编号",sortable:true,field:"value"},{header:"名称",sortable:true,field:"text"}];
		var multiItem_search=new L5.SearchAreaM();
		multiItem_search.addTextField("code","编码","DIC_ASSITANCE_TYPE_EXT.CODE");
		multiItem_search.addTextField("name","内容","DIC_ASSITANCE_TYPE_EXT.NAME");
		itemWin = new L5.MultiSimpleGridHelp(item_config,multiItem_search);
		itemWin.show();
	}
	//进行调用
	itemWin.afterExecute=function(){
		var result=this.getReturn();
    	if(result!=null&&!itemWin.isClear){
    		setValue(result,displayName,value);
    	} else {
    		displayDbClick(displayName,value);
    	}
	}
}
function setValue(result,displayName,value) {
	var jzlxDisplay = document.getElementById(displayName);
	var jzlxquery = document.getElementById(value);
	jzlxDisplay.value="";
	jzlxquery.value="";
	var reValue = "";
	if(L5.isArray(result)) {
		for(var i=0;i<result.length;i++) {
			var record = result[i];
			if(jzlxDisplay.value=="") {
				jzlxDisplay.value += (record.get("text"));
				jzlxquery.value += (record.get("value"));
			} else {
				jzlxDisplay.value += (","+record.get("text"));
				jzlxquery.value += (","+record.get("value"));
			}
		}
	} else {
		jzlxDisplay.value = result.get("text");
		jzlxquery.value = result.get("value");
	}
}
function displayDbClick(displayName,value) {
	document.getElementById(displayName).value="";
	document.getElementById(value).value="";
}
function detailFamily(){
	var grid = L5.getCmp('infoQueryGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var width = screen.width-100;
	    var height = screen.height-140;
	    var treatmentId=records[0].get("TREATMENT_ID");
	    var applyId=records[0].get("APPLY_ID");
	     var assistanceType=records[0].get("ASSISTANCE_TYPE");
		var url="fiveFamilyDetail.jsp?treatmentId="+treatmentId+"&assistanceType="+assistanceType+"&applyId="+applyId;
		var win=window.showModalDialog(url,window,"dialogHeight:"+height+"px;dialogWidth:"+width+"px;resizable:no;scroll:yes;status:no;");
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//弹出敬老院
function func_ForGeroSelect(){
	var baseinfoPeopleDS=L5.DatasetMgr.lookup("baseinfoPeopleDS");
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/drel/samu/geroTree/geroTree.jsp?radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("gerocomiumId").value = list[0];
		document.getElementById("gerocomiumName").value = list[1];
	}
}