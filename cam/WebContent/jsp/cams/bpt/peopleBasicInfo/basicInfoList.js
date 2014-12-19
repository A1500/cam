var ifQuery = false;
var time = new Date();
var times = time.format("Y");
var query_startTime = times+"-01-01";
var query_endTime = times+"-12-31";
var flag ;
var path ;
var changeContent;
function init() {
	    L5.Ajax.timeout=300000;
        L5.getCmp("baseGridPanel").show();
	    L5.getCmp("disbilityGridPanel").hide();
	    L5.getCmp("depentGridPanel").hide();
	    L5.getCmp("demobilizedGridPanel").hide();
	    L5.getCmp("demobilizeInelldGridPanel").hide();
	    L5.getCmp("warGridPanel").hide();
	    L5.getCmp("testedGridPanel").hide();
	    L5.getCmp("countretiredsoldierGridPanel").hide();
       //L5.QuickTips.init();
        //sipTime('');
};

/**
 * 时间查询条件赋值以及初始化
 * @param {} id
 */
function sipTime(id) {
	/*document.getElementById(id+"cxsj_qs").value=query_startTime;
	document.getElementById(id+"cxsj_zs").value=query_endTime;
	document.getElementById(id+"cxsj_z").value=query_endTime;*/
}


function showTime(id) {
	var type = document.getElementById(id+"timeType").value;
	if(type == "0") {
		document.getElementById(id+"cxsj_qs").value="";
		document.getElementById(id+"cxsj_zs").value="";
		document.getElementById(id+"cxsj_z").value="";
	} else if (type == '1') {
		document.getElementById(id+"times").style.display = "";
		document.getElementById(id+"time").style.display = "none";
		document.getElementById(id+"cxsj_qs").value=query_startTime;
		document.getElementById(id+"cxsj_zs").value=query_endTime;
	} else {
		document.getElementById(id+"times").style.display = "none";
		document.getElementById(id+"time").style.display = "";
		document.getElementById(id+"cxsj_z").value=query_endTime;
	}
}

/**
 * 
 * @param {} ds
 */
function sipQueryTime(ds,id) {
	
	var ageBegin = document.getElementById(id+"ageBegin").value;
	var ageEnd = document.getElementById(id+"ageEnd").value;
	var reg = /^\d+$/;
	if(ageBegin != null && ageBegin != "") {
		if(ageBegin.match(reg) == null) {
			L5.Msg.alert("提示","起始年龄只能为正整数");
			return false;
		}
	}
	
	if(ageEnd != null && ageEnd != "") {
		if(ageEnd.match(reg) == null) {
			L5.Msg.alert("提示","截止年龄只能为正整数");
			return false;
		}
		
		if(ageBegin != null && ageBegin != "") {
			if(parseInt(ageEnd) <= parseInt(ageBegin)) {
				L5.Msg.alert("提示","截止年龄不能小于起始年龄");
				return false;
			}
		}
	}  
	ds.setParameter("ageBegin", ageBegin);
	ds.setParameter("ageEnd",ageEnd);
	
	
	var type = document.getElementById(id+"timeType").value;
	if(type == "0") {
		return ds;
	}
	var cxsj_q;
	var cxsj_z;
	if(type=='1'){
		cxsj_q = document.getElementById(id+"cxsj_qs").value;
		cxsj_z = document.getElementById(id+"cxsj_zs").value;
		if (cxsj_q == '') {
			L5.Msg.alert('提示', '查询起始时间不能为空！');
			return false;
		}
		if(cxsj_q!=''&&!validateDateFormat(cxsj_q)){
			L5.Msg.alert("提示","查询起始时间格式不正确！");
			return false;
		}
		if (cxsj_z == '') {
			L5.Msg.alert('提示', '查询结束时间不能为空！');
			return false;
		}
		if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
			L5.Msg.alert("提示","查询结束时间格式不正确！");
			return false;
		}
	}else if(type=='2'){
		cxsj_q ="";
		cxsj_z = document.getElementById(id+"cxsj_z").value;
		if (cxsj_z == '') {
			L5.Msg.alert('提示', '审批截止时间不能为空！');
			return false;
		}
		if(cxsj_z!=''&&!validateDateFormat(cxsj_z)){
			L5.Msg.alert("提示","审批截止时间格式不正确！");
			return false;
		}
		
	}
	
	ds.setParameter("startTime", cxsj_q);
	ds.setParameter("endTime",cxsj_z);
	
	return ds;
}


function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function excelLoad(){//导出Excel
	var domicileCode = getParam("domicileCode");
	var name = getParam("name");
	var idCard = getParam("idCard");
	var bptNo = getParam("bptNo");
	var objectState = getParam("objectState");
	var objectType = getParam("bptObjectType");//获取节点ID
	
	if(objectType=='1'){//伤残
	var BptPeopleDisabilityDataSet1=L5.DatasetMgr.lookup("BptPeopleDisabilityDataSet1");
	    BptPeopleDisabilityDataSet1.setParameter("domicileCode",getParam("disabilityDomicileCode"));
		BptPeopleDisabilityDataSet1.setParameter("name",getParam("name"));
		BptPeopleDisabilityDataSet1.setParameter("idCard",getParam("idCard"));
		BptPeopleDisabilityDataSet1.setParameter("domicileType",getParam("domicileType"));	
		BptPeopleDisabilityDataSet1.setParameter("disabilityStateCode",getParam("disabilityStateCode"));
		if(getParam("disabilityObjectType") != 1){
			BptPeopleDisabilityDataSet1.setParameter("disabilityTypeCode",getParam("disabilityObjectType"));
		}
		BptPeopleDisabilityDataSet1.setParameter("disabilityLevelCode",getParam("disabilityLevelCode"));	
		BptPeopleDisabilityDataSet1.setParameter("disabilityCaseCode",getParam("disabilityCaseCode"));
		BptPeopleDisabilityDataSet1.setParameter("disabilityGenusCode",getParam("disabilityGenusCode"));	
		BptPeopleDisabilityDataSet1.setParameter("disabilityWarCode",getParam("disabilityWarCode"));	
		BptPeopleDisabilityDataSet1.setParameter("organCode",organCode);	
		BptPeopleDisabilityDataSet1.setParameter("disabilityNo",getParam("disabilityNo"));
		BptPeopleDisabilityDataSet1.setParameter("cisprovinceMigrate",getParam("cisprovinceMigrate"));
		BptPeopleDisabilityDataSet1.setParameter("isAll","all");
		var returnValue = sipQueryTime(BptPeopleDisabilityDataSet1,"disability");
		if(returnValue) {
			BptPeopleDisabilityDataSet1 = returnValue;
			BptPeopleDisabilityDataSet1.load();
		}	
	}else if(objectType=='2'){//三属
		var DependantDataset1=L5.DatasetMgr.lookup("DependantDataset1");
	    DependantDataset1.setParameter("domicileCode",getParam("dependantDomicileCode"));
		DependantDataset1.setParameter("name",getParam("dependantName"));
		DependantDataset1.setParameter("idCard",getParam("dependantIdCard"));
		DependantDataset1.setParameter("domicileType",getParam("dependantDomicileType"));
		DependantDataset1.setParameter("disabilityStateCode",getParam("dependantDisabilityStateCode"));	
		if(getParam("dependantObjectType") != 2){
			DependantDataset1.setParameter("dependantTypeCode",getParam("dependantObjectType"));
		}
		DependantDataset1.setParameter("dependantNo",getParam("dependantNo"));
		DependantDataset1.setParameter("organCode",organCode);
		DependantDataset1.setParameter("isAll","all");
		DependantDataset1.setParameter("sisprovinceMigrate",getParam("sisprovinceMigrate"));
		var returnValue = sipQueryTime(DependantDataset1,'dependant');
		if(returnValue) {
			DependantDataset1 = returnValue;
			DependantDataset1.load();
		}
	    
	}else if(objectType=='41'){//在乡
	var demobilizedDataSet1=L5.DatasetMgr.lookup("demobilizedDataSet1");
	    demobilizedDataSet1.setParameter("domicileCode",getParam("demobilizeDomicileCode"));
		demobilizedDataSet1.setParameter("name",getParam("bilizedName"));
		demobilizedDataSet1.setParameter("idCard",getParam("bilizedIdCard"));	
		demobilizedDataSet1.setParameter("belongDate",getParam("belongDate"));	
		demobilizedDataSet1.setParameter("isKoreanwar",getParam("isKoreanwar"));	
		demobilizedDataSet1.setParameter("objectState",getParam("bilizedObjectState"));
		demobilizedDataSet1.setParameter("domicileType",getParam("bilizedDomicileType"));
		demobilizedDataSet1.setParameter("organCode",organCode);
		demobilizedDataSet1.setParameter("isAll","all");	
		demobilizedDataSet1.setParameter("zisprovinceMigrate",getParam("zisprovinceMigrate"));
		var returnValue = sipQueryTime(demobilizedDataSet1,'demobilize');
		if(returnValue) {
			demobilizedDataSet1 = returnValue;
			demobilizedDataSet1.load();
		}
		
	}else if(objectType=='42'){//带病回乡退伍军人
	var dsDemobilizeInelld1=L5.DatasetMgr.lookup("dsDemobilizeInelld1");
	    dsDemobilizeInelld1.setParameter("domicileCode",getParam("illnessDomicileCode"));
		dsDemobilizeInelld1.setParameter("name",getParam("illnessName"));
		dsDemobilizeInelld1.setParameter("idCard",getParam("illnessIdCard"));
		dsDemobilizeInelld1.setParameter("isWar",getParam("isWar"));	
		dsDemobilizeInelld1.setParameter("isInnuclear",getParam("isInnuclear"));	
		dsDemobilizeInelld1.setParameter("objectState",getParam("illnessObjectState"));			
		dsDemobilizeInelld1.setParameter("domicileType",getParam("illnessDomicileType"));
		dsDemobilizeInelld1.setParameter("organCode",organCode);
		dsDemobilizeInelld1.setParameter("isAll","all");
		dsDemobilizeInelld1.setParameter("bisprovinceMigrate",getParam("bisprovinceMigrate"));
		var returnValue = sipQueryTime(dsDemobilizeInelld1,'demobilizedIllness')
		if(returnValue) {
			dsDemobilizeInelld1 = returnValue;
			dsDemobilizeInelld1.load();
		}
	}else if(objectType=='5'){//参战
	var dataSetWar1=L5.DatasetMgr.lookup("dataSetWar1");
	    dataSetWar1.setParameter("domicileCode",getParam("warDomicileCode"));
		dataSetWar1.setParameter("name",getParam("warName"));
		dataSetWar1.setParameter("idCard",getParam("warIdCard"));
		dataSetWar1.setParameter("objectState",getParam("warObjectState"));
		dataSetWar1.setParameter("domicileType",getParam("warDomicileType"));
		dataSetWar1.setParameter("warTypeCode",getParam("warTypeCode"));
		dataSetWar1.setParameter("organCode",organCode);
		dataSetWar1.setParameter("isAll","all");
		dataSetWar1.setParameter("czisprovinceMigrate",getParam("czisprovinceMigrate"));
		var returnValue = sipQueryTime(dataSetWar1,'war')
		if(returnValue) {
			dataSetWar1 = returnValue;
			dataSetWar1.load();
		}
	}else if(objectType=='6'){//参试
	var dataSetTested1=L5.DatasetMgr.lookup("dataSetTested1");
	    dataSetTested1.setParameter("domicileCode",getParam("testDomicileCode"));		
		dataSetTested1.setParameter("name",getParam("testName"));		
		dataSetTested1.setParameter("idCard",getParam("testIdCard"));		
		dataSetTested1.setParameter("domicileType",getParam("testDomicileType"));		
		dataSetTested1.setParameter("warStateCode",getParam("warStateCode"));				
		dataSetTested1.setParameter("disabilityLevelCode",getParam("disabilityLevelCode"));
		dataSetTested1.setParameter("organCode",organCode);
		dataSetTested1.setParameter("isAll","all");			
		dataSetTested1.setParameter("csisprovinceMigrate",getParam("csisprovinceMigrate"));
		var returnValue = sipQueryTime(dataSetTested1,'test');
		if(returnValue) {
			dataSetTested1 = returnValue;
			dataSetTested1.load();
		}
	}else if(objectType=='8'){//60周岁以上农村籍退役军人
	var countretiredSoldierDataSet1=L5.DatasetMgr.lookup("countretiredSoldierDataSet1");
	    countretiredSoldierDataSet1.setParameter("domicileCode",getParam("soldierDomicileCode"));
		countretiredSoldierDataSet1.setParameter("organCode",organCode);
		countretiredSoldierDataSet1.setParameter("name",getParam("soldierName"));
		countretiredSoldierDataSet1.setParameter("idCard",getParam("soldierIdCard"));
		countretiredSoldierDataSet1.setParameter("domicileType",getParam("soldierDomicileType"));
		countretiredSoldierDataSet1.setParameter("isGuarant",getParam("isGuarant"));	
		countretiredSoldierDataSet1.setParameter("isFiveGuarant",getParam("isFiveGuarant"));	
		countretiredSoldierDataSet1.setParameter("isAll","all");
		countretiredSoldierDataSet1.setParameter("jisprovinceMigrate",getParam("jisprovinceMigrate"));	
		countretiredSoldierDataSet1.load();
		
	}else{   //全部显示
	var dsBptObject1=L5.DatasetMgr.lookup("dsBptObject1");
		dsBptObject1.setParameter("domicileCode", domicileCode);
		dsBptObject1.setParameter("name", name);
		dsBptObject1.setParameter("idCard", idCard);
		dsBptObject1.setParameter("objectState", objectState);
		dsBptObject1.setParameter("objectType", getParam("objectType"));
		dsBptObject1.setParameter("organCode", organCode);
		dsBptObject1.setParameter("bptNo", bptNo);
		dsBptObject1.setParameter("isAll","all");
		dsBptObject1.setParameter("isprovinceMigrate", getParam("isprovinceMigrate"));
		var returnValue = sipQueryTime(dsBptObject1,'');
		if(returnValue) {
			dsBptObject1 = returnValue;
			dsBptObject1.load();
		}
	}
}
function excel_click(){//导出Excel
	excelLoad();
	var objectType = getParam("bptObjectType");//获取节点ID
	
	
	var dsBptObject1=L5.DatasetMgr.lookup("dsBptObject1");
	var countretiredSoldierDataSet1=L5.DatasetMgr.lookup("countretiredSoldierDataSet1");
	var dataSetTested1=L5.DatasetMgr.lookup("dataSetTested1");
	var dataSetWar1=L5.DatasetMgr.lookup("dataSetWar1");
	var dsDemobilizeInelld1=L5.DatasetMgr.lookup("dsDemobilizeInelld1");
	var demobilizedDataSet1=L5.DatasetMgr.lookup("demobilizedDataSet1");
	var DependantDataset1=L5.DatasetMgr.lookup("DependantDataset1");
	var BptPeopleDisabilityDataSet1=L5.DatasetMgr.lookup("BptPeopleDisabilityDataSet1");
	if(objectType=='1'){//伤残
		/*if(BptPeopleDisabilityDataSet1.getCount()<1){
			L5.Msg.alert("提示","没有要导出的信息！");
			return;
		}*/
		L5.dataset2excel(BptPeopleDisabilityDataSet1,"/jsp/cams/bpt/peopleBasicInfo/excel/disabilityPeople_excel.jsp");
	}else if(objectType=='2'){//三属
		/*if(DependantDataset1.getCount()<1){
			L5.Msg.alert("提示","没有要导出的信息！");
			return;
		}*/
		L5.dataset2excel(DependantDataset1,"/jsp/cams/bpt/peopleBasicInfo/excel/dependantPeople_excel.jsp");
	}else if(objectType=='41'){//在乡
		/*if(demobilizedDataSet1.getCount()<1){
			L5.Msg.alert("提示","没有要导出的信息！");
			return;
		}*/
		L5.dataset2excel(demobilizedDataSet1,"/jsp/cams/bpt/peopleBasicInfo/excel/demobilizedPeople_excel.jsp");
	}else if(objectType=='42'){//带病回乡退伍军人
		/*if(dsDemobilizeInelld1.getCount()<1){
			L5.Msg.alert("提示","没有要导出的信息！");
			return;
		}*/
		L5.dataset2excel(dsDemobilizeInelld1,"/jsp/cams/bpt/peopleBasicInfo/excel/demobilizedIllnessPeople_excel.jsp");
	}else if(objectType=='5'){//参战
		/*if(dataSetWar1.getCount()<1){
			L5.Msg.alert("提示","没有要导出的信息！");
			return;
		}*/
		L5.dataset2excel(dataSetWar1,"/jsp/cams/bpt/peopleBasicInfo/excel/warPeople_excel.jsp");
	}else if(objectType=='6'){//参试
		/*if(dataSetTested1.getCount()<1){
			L5.Msg.alert("提示","没有要导出的信息！");
			return;
		}*/
		L5.dataset2excel(dataSetTested1,"/jsp/cams/bpt/peopleBasicInfo/excel/testPeople_excel.jsp");
	}else if(objectType=='8'){//60周岁以上农村籍退役军人
		/*if(countretiredSoldierDataSet1.getCount()<1){
			L5.Msg.alert("提示","没有要导出的信息！");
			return;
		}*/
		L5.dataset2excel(countretiredSoldierDataSet1,"/jsp/cams/bpt/peopleBasicInfo/excel/countretiredSoldierPeople_excel.jsp");
	}else{   //全部显示
		/*if(dsBptObject1.getCount()<1){
			L5.Msg.alert("提示","没有要导出的信息！"+dsBptObject1.getCount());
			return;
		}*/
		
		L5.dataset2excel(dsBptObject1,"/jsp/cams/bpt/peopleBasicInfo/excel/otherPeople_excel.jsp");
	}
}
function query() {
	var domicileCode = getParam("domicileCode");
	var name = getParam("name");
	var idCard = getParam("idCard");
	var bptNo = getParam("bptNo");
	var objectState = getParam("objectState");
	var objectType = getParam("bptObjectType");// 获取节点ID
	

	if (objectType == '1') {// 伤残
		BptPeopleDisabilityDataSet.setParameter("domicileCode",
				getParam("disabilityDomicileCode"));
		BptPeopleDisabilityDataSet.setParameter("name", getParam("disbilityname"));
		BptPeopleDisabilityDataSet.setParameter("idCard", getParam("disbilityidCard"));
		BptPeopleDisabilityDataSet.setParameter("domicileType",
				getParam("domicileType"));
		BptPeopleDisabilityDataSet.setParameter("disabilityStateCode",
				getParam("disabilityStateCode"));
		if (getParam("disabilityObjectType") != 1) {
			BptPeopleDisabilityDataSet.setParameter("disabilityTypeCode",
					getParam("disabilityObjectType"));
		}
		BptPeopleDisabilityDataSet.setParameter("disabilityLevelCode",
				getParam("disabilityLevelCode"));
		BptPeopleDisabilityDataSet.setParameter("disabilityCaseCode",
				getParam("disabilityCaseCode"));
		BptPeopleDisabilityDataSet.setParameter("disabilityGenusCode",
				getParam("disabilityGenusCode"));
		BptPeopleDisabilityDataSet.setParameter("disabilityWarCode",
				getParam("disabilityWarCode"));
		BptPeopleDisabilityDataSet.setParameter("organCode", organCode);
		BptPeopleDisabilityDataSet.setParameter("disabilityNo",
				getParam("disabilityNo"));
		BptPeopleDisabilityDataSet.setParameter("cisprovinceMigrate",
				getParam("cisprovinceMigrate"));	
		var returnValue = sipQueryTime(BptPeopleDisabilityDataSet,"disability");
		if(returnValue) {
			BptPeopleDisabilityDataSet = returnValue;
			BptPeopleDisabilityDataSet.load();
		}	
		noReclick(BptPeopleDisabilityDataSet,"disabilityQueryButton");
	} else if (objectType == '2') {// 三属
		DependantDataset.setParameter("domicileCode",
				getParam("dependantDomicileCode"));
		DependantDataset.setParameter("name", getParam("dependantName"));
		DependantDataset.setParameter("idCard", getParam("dependantIdCard"));
		DependantDataset.setParameter("domicileType",
				getParam("dependantDomicileType"));
		DependantDataset.setParameter("disabilityStateCode",
				getParam("dependantDisabilityStateCode"));
		if (getParam("dependantObjectType") != 2) {
			DependantDataset.setParameter("dependantTypeCode",
					getParam("dependantObjectType"));
		}
		DependantDataset.setParameter("dependantNo", getParam("dependantNo"));
		DependantDataset.setParameter("organCode", organCode);
		DependantDataset.setParameter("sisprovinceMigrate", getParam("sisprovinceMigrate"));
		var returnValue = sipQueryTime(DependantDataset,'dependant');
		if(returnValue) {
			DependantDataset = returnValue;
			DependantDataset.load();
		}
		noReclick(DependantDataset,"dependantQueryButton");
	} else if (objectType == '41') {// 在乡
		demobilizedDataSet.setParameter("domicileCode",
				getParam("demobilizeDomicileCode"));
		demobilizedDataSet.setParameter("name", getParam("bilizedName"));
		demobilizedDataSet.setParameter("idCard", getParam("bilizedIdCard"));
		demobilizedDataSet.setParameter("belongDate", getParam("belongDate"));
		demobilizedDataSet.setParameter("isKoreanwar", getParam("isKoreanwar"));
		demobilizedDataSet.setParameter("objectState",
				getParam("bilizedObjectState"));
		demobilizedDataSet.setParameter("domicileType",
				getParam("bilizedDomicileType"));
		demobilizedDataSet.setParameter("organCode", organCode);
		demobilizedDataSet.setParameter("zisprovinceMigrate",
				getParam("zisprovinceMigrate"));
		var returnValue = sipQueryTime(demobilizedDataSet,'demobilize');
		if(returnValue) {
			demobilizedDataSet = returnValue;
			demobilizedDataSet.load();
		}
		noReclick(demobilizedDataSet,"demobilizedQueryButton");
	} else if (objectType == '42') {// 带病回乡退伍军人
		dsDemobilizeInelld.setParameter("domicileCode",
				getParam("illnessDomicileCode"));
		dsDemobilizeInelld.setParameter("name", getParam("illnessName"));
		dsDemobilizeInelld.setParameter("idCard", getParam("illnessIdCard"));
		dsDemobilizeInelld.setParameter("isWar", getParam("isWar"));
		dsDemobilizeInelld.setParameter("isInnuclear", getParam("isInnuclear"));
		dsDemobilizeInelld.setParameter("objectState",
				getParam("illnessObjectState"));
		dsDemobilizeInelld.setParameter("domicileType",
				getParam("illnessDomicileType"));
		dsDemobilizeInelld.setParameter("organCode", organCode);
		dsDemobilizeInelld.setParameter("bisprovinceMigrate",
				getParam("bisprovinceMigrate"));
		var returnValue = sipQueryTime(dsDemobilizeInelld,'demobilizedIllness')
		if(returnValue) {
			dsDemobilizeInelld = returnValue;
			dsDemobilizeInelld.load();
		}
		noReclick(dsDemobilizeInelld,"demobilizedIllnessQueryButton");
	} else if (objectType == '5') {// 参战
		dataSetWar.setParameter("domicileCode", getParam("warDomicileCode"));
		dataSetWar.setParameter("name", getParam("warName"));
		dataSetWar.setParameter("idCard", getParam("warIdCard"));
		dataSetWar.setParameter("objectState", getParam("warObjectState"));
		dataSetWar.setParameter("domicileType", getParam("warDomicileType"));
		dataSetWar.setParameter("warTypeCode", getParam("warTypeCode"));
		dataSetWar.setParameter("organCode", organCode);
		dataSetWar.setParameter("czisprovinceMigrate", getParam("czisprovinceMigrate"));
		var returnValue = sipQueryTime(dataSetWar,'war')
		if(returnValue) {
			dataSetWar = returnValue;
			dataSetWar.load();
		}
		noReclick(dataSetWar,"warQueryButton");
	} else if (objectType == '6') {// 参试
		dataSetTested
				.setParameter("domicileCode", getParam("testDomicileCode"));
		dataSetTested.setParameter("name", getParam("testName"));
		dataSetTested.setParameter("idCard", getParam("testIdCard"));
		dataSetTested
				.setParameter("domicileType", getParam("testDomicileType"));
		dataSetTested.setParameter("warStateCode", getParam("warStateCode"));
		dataSetTested.setParameter("disabilityLevelCode",
				getParam("disabilityLevelCode"));
		dataSetTested.setParameter("organCode", organCode);
		dataSetTested.setParameter("testedType", getParam("testType"));
		dataSetTested.setParameter("csisprovinceMigrate", getParam("csisprovinceMigrate"));
		var returnValue = sipQueryTime(dataSetTested,'test');
		if(returnValue) {
			dataSetTested = returnValue;
			dataSetTested.load();
		}
		noReclick(dataSetTested,"tesedQueryButton");
	} else if (objectType == '8') {// 60周岁以上农村籍退役军人
		countretiredSoldierDataSet.setParameter("domicileCode",
				getParam("soldierDomicileCode"));
		countretiredSoldierDataSet.setParameter("organCode", organCode);
		countretiredSoldierDataSet
				.setParameter("name", getParam("soldierName"));
		countretiredSoldierDataSet.setParameter("idCard",
				getParam("soldierIdCard"));
		countretiredSoldierDataSet.setParameter("domicileType",
				getParam("soldierDomicileType"));
		countretiredSoldierDataSet.setParameter("isGuarant",
				getParam("isGuarant"));
		countretiredSoldierDataSet.setParameter("isFiveGuarant",
				getParam("isFiveGuarant"));
		countretiredSoldierDataSet.setParameter("jisprovinceMigrate",
				getParam("jisprovinceMigrate"));
		countretiredSoldierDataSet.load();
		noReclick(countretiredSoldierDataSet,"countretiredQueryButton");
	} else { // 全部显示
		dsBptObject.setParameter("domicileCode", domicileCode);
		dsBptObject.setParameter("name", name);
		dsBptObject.setParameter("idCard", idCard);
		dsBptObject.setParameter("objectState", objectState);
		dsBptObject.setParameter("objectType", getParam("objectType"));
		dsBptObject.setParameter("organCode", organCode);
		dsBptObject.setParameter("bptNo", bptNo);
		dsBptObject.setParameter("isprovinceMigrate", getParam("isprovinceMigrate"));
		var returnValue = sipQueryTime(dsBptObject,'');
		if(returnValue) {
			dsBptObject = returnValue;
			dsBptObject.load();
			noReclick(dsBptObject,"queryButton");
		}
		
	}
	// excelLoad();
}

function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("domicileName").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("nation").value = "";
	document.getElementById("marriageCode").value = "";
	document.getElementById("careerCode").value = "";
	document.getElementById("politicalCode").value = "";
	document.getElementById("domicileType").value = "";
	document.getElementById("personalStatsTag").value = "";
	document.getElementById("bptNo").value = "";
}

function update(){ 
	//判断只允许县市区用户修改
	if(organType != 13){
		alert("只允许县市区用户修改");
		return false;
	}

	var basicInfoGrid;
	var objectType = '';
	var objectState = "";
	if(document.getElementById("bptObjectType").value=='1'){
	   basicInfoGrid=L5.getCmp('disbilityGridPanel');
	   objectState = basicInfoGrid.getSelectionModel().getSelections()[0].get('DISABILITY_STATE_CODE');
	   objectType = 11;
	}else if(document.getElementById("bptObjectType").value=='2'){
	   basicInfoGrid=L5.getCmp('depentGridPanel');
	   objectState = basicInfoGrid.getSelectionModel().getSelections()[0].get('DEPENDANT_STATE_CODE');
	   objectType = 21;
	}else if(document.getElementById("bptObjectType").value=='41'){
	   basicInfoGrid=L5.getCmp('demobilizedGridPanel');
	   objectState = basicInfoGrid.getSelectionModel().getSelections()[0].get('DEMOBILIZED_STATE_CODE');
	   objectType = 41;
	}else if(document.getElementById("bptObjectType").value=='42'){
	   basicInfoGrid=L5.getCmp('demobilizeInelldGridPanel');
	   objectState = basicInfoGrid.getSelectionModel().getSelections()[0].get('DEMOBILIZED_STATE_CODE');
	   objectType = 42;
	}else if(document.getElementById("bptObjectType").value=='5'){
	   basicInfoGrid=L5.getCmp('warGridPanel');
	   objectState = basicInfoGrid.getSelectionModel().getSelections()[0].get('WAR_STATE_CODE');
	   objectType = 51;
	}else if(document.getElementById("bptObjectType").value=='6'){
	   basicInfoGrid=L5.getCmp('testedGridPanel');
	   objectState = basicInfoGrid.getSelectionModel().getSelections()[0].get('WAR_STATE_CODE');
	   objectType = 61;
	}else if(document.getElementById("bptObjectType").value=='8'){
	   basicInfoGrid=L5.getCmp('countretiredsoldierGridPanel');
	   objectState = basicInfoGrid.getSelectionModel().getSelections()[0].get('RETIRED_STATE_CODE');
	   objectType = 81;
	}else{
	   basicInfoGrid=L5.getCmp('baseGridPanel');
	   objectState = basicInfoGrid.getSelectionModel().getSelections()[0].get('OBJECT_STATE');
	}
	var selected=basicInfoGrid.getSelectionModel().getSelections();
	if(selected[0].get("FLAG") == '1'){
		alert("不能修改已迁出人员！");
		return false;
	}
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var peopleId = selected[0].get('PEOPLE_ID');
	var familyId = selected[0].get('FAMILY_ID');
	var username = selected[0].get('NAME');
	var idCard = selected[0].get('ID_CARD');
	
	if(objectType == ''){
		objectType = selected[0].get('OBJECT_TYPE');
	}
	
	var url='basicInfoUpdate.jsp?peopleId='+peopleId+'&familyId='+familyId+'&username='+username+'&idCard='+idCard+'&objectState='+objectState+'&objectType='+objectType;
	var width = screen.width-200;
	var height = 520;
	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if (win==null) {
		return;
	}
}

function detail(){
	var basicInfoGrid;
	var objectType = '';
	if(document.getElementById("bptObjectType").value=='1'){
	   basicInfoGrid=L5.getCmp('disbilityGridPanel');
	   objectType = 11;
	}else if(document.getElementById("bptObjectType").value=='2'){
	   basicInfoGrid=L5.getCmp('depentGridPanel');
	   objectType = 21;
	}else if(document.getElementById("bptObjectType").value=='41'){
	   basicInfoGrid=L5.getCmp('demobilizedGridPanel');
	   objectType = 41;
	}else if(document.getElementById("bptObjectType").value=='42'){
	   basicInfoGrid=L5.getCmp('demobilizeInelldGridPanel');
	   objectType = 42;
	}else if(document.getElementById("bptObjectType").value=='5'){
	   basicInfoGrid=L5.getCmp('warGridPanel');
	   objectType = 51;
	}else if(document.getElementById("bptObjectType").value=='6'){
	   basicInfoGrid=L5.getCmp('testedGridPanel');
	   objectType = 61;
	}else if(document.getElementById("bptObjectType").value=='8'){
	   basicInfoGrid=L5.getCmp('countretiredsoldierGridPanel');
	   objectType = 81;
	}else{
	   basicInfoGrid=L5.getCmp('baseGridPanel');
	}
	var selected=basicInfoGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	var peopleId = selected[0].get('PEOPLE_ID');
	var familyId = selected[0].get('FAMILY_ID');
	var username = selected[0].get('NAME');
	var idCard = selected[0].get('ID_CARD');
	var objectState = selected[0].get('OBJECT_STATE');
	if(objectType == ''){
		objectType = selected[0].get('OBJECT_TYPE');
	}
	var url='../basicInfoView/basicInfoDetail.jsp?peopleId='+peopleId+'&familyId='+familyId+'&username='+username+'&idCard='+idCard+'&objectState='+objectState+'&objectType='+objectType;
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if (win==null) {
		return;
	}
}

function forHelp() {
	if(!ifQuery) {
		if (organCode != null && organCode != "") {
			var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			command.setParameter("ID", organCode);
			command.execute("findOrganName");
			var fullName = command.getReturn("organName");
			if (fullName != null && fullName != "") {
				organName = fullName;
			}
			ifQuery = true;
		}
	}
	var revalue = window.showModalDialog(L5.webPath
					+ "/jsp/cams/comm/diccity/dicCity.jsp?organCode="
					+ organCode + "&radioMaxlevel=0&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	// var
	// revalue=window.showModalDialog(L5.webPath+"/jsp/cams/bpt/comm/getselect_code.jsp?rootId="+struId+"&showOrganType=1&organType=1&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");

		// 获取优抚对象类别的值，然后判断是哪个查询页面,写入所属机构的值
		var type = getParam("bptObjectType");
		if (type == '1') {
			document.getElementById("disabilityDomicileCode").value = list[0];
			document.getElementById("disabilityDomicileName").value = list[4];
		} else if (type == '2') {
			document.getElementById("dependantDomicileCode").value = list[0];
			document.getElementById("dependantDomicileName").value = list[4];
		} else if (type == '41') {
			document.getElementById("demobilizeDomicileCode").value = list[0];
			document.getElementById("demobilizeDomicileName").value = list[4];
		} else if (type == '42') {
			document.getElementById("illnessDomicileCode").value = list[0];
			document.getElementById("illnessDomicileName").value = list[4];
		} else if (type == '5') {
			document.getElementById("warDomicileCode").value = list[0];
			document.getElementById("warDomicileName").value = list[4];
		} else if (type == '6') {
			document.getElementById("testDomicileCode").value = list[0];
			document.getElementById("testDomicileName").value = list[4];
		} else if (type == '8') {
			document.getElementById("soldierDomicileCode").value = list[0];
			document.getElementById("soldierDomicileName").value = list[4];
		} else {
			document.getElementById("domicileCode").value = list[0];
			document.getElementById("domicileName").value = list[4];
		}

	}
}

function forHelpOT() {
	
	 
	var revalue = window.showModalDialog("../dicobjecttype/dicobjecttype.jsp");
	 
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		var listTypeId = list[0].split(",");

		/*
		 * 获取第一个数的第一位和最后一个数的第一位， 相等则是有相同的一个上级节点，反之则不是同一个上级节点
		 */
		var tistart = 0;// 第一个数的第一位
		var tiend = 0;// 最后一个数的第一位
		if (listTypeId.length != 0) {
			tistart = listTypeId[0].substring(0, 1);// 获取第一个数的第一位
			tiend = listTypeId[listTypeId.length - 1].substring(0, 1);// 获取最后一个数的第一位
		}
		if (listTypeId.length != 0 && tistart == tiend) {
			document.getElementById("bptObjectType").value = tistart;
			if (tistart == 1) {// 伤残
				document.getElementById("disabilityObjectTypeName").value = list[1];
				document.getElementById("disabilityObjectType").value = list[0];

				L5.getCmp("form").hide();
				L5.getCmp("disabilityform").show();
				L5.getCmp("dependantform").hide();
				L5.getCmp("demobilizeform").hide();
				L5.getCmp("demobilizedIllnessform").hide();
				L5.getCmp("warform").hide();
				L5.getCmp("testform").hide();
				L5.getCmp("countretiredsoldierform").hide();
				sipTime('disability');

				L5.getCmp("baseGridPanel").hide();
				L5.getCmp("disbilityGridPanel").show();
				L5.getCmp("depentGridPanel").hide();
				L5.getCmp("demobilizedGridPanel").hide();
				L5.getCmp("demobilizeInelldGridPanel").hide();
				L5.getCmp("warGridPanel").hide();
				L5.getCmp("testedGridPanel").hide();
				L5.getCmp("countretiredsoldierGridPanel").hide();
				
			} else if (tistart == 2) {// 三属
				document.getElementById("dependantObjectTypeName").value = list[1];
				document.getElementById("dependantObjectType").value = list[0];

				L5.getCmp("form").hide();
				L5.getCmp("disabilityform").hide();
				L5.getCmp("dependantform").show();
				L5.getCmp("demobilizeform").hide();
				L5.getCmp("demobilizedIllnessform").hide();
				L5.getCmp("warform").hide();
				L5.getCmp("testform").hide();
				L5.getCmp("countretiredsoldierform").hide();
				sipTime('dependant');

				L5.getCmp("baseGridPanel").hide();
				L5.getCmp("disbilityGridPanel").hide();
				L5.getCmp("depentGridPanel").show();
				L5.getCmp("demobilizedGridPanel").hide();
				L5.getCmp("demobilizeInelldGridPanel").hide();
				L5.getCmp("warGridPanel").hide();
				L5.getCmp("testedGridPanel").hide();
				L5.getCmp("countretiredsoldierGridPanel").hide();
			} else if (list[0] == 41) {// 在乡
				document.getElementById("bilizedObjectTypeName").value = list[1];
				document.getElementById("bilizedObjectType").value = list[0];
				document.getElementById("bptObjectType").value = list[0];

				L5.getCmp("form").hide();
				L5.getCmp("disabilityform").hide();
				L5.getCmp("dependantform").hide();
				L5.getCmp("demobilizeform").show();
				L5.getCmp("demobilizedIllnessform").hide();
				L5.getCmp("warform").hide();
				L5.getCmp("testform").hide();
				L5.getCmp("countretiredsoldierform").hide();
				sipTime('demobilize');

				L5.getCmp("baseGridPanel").hide();
				L5.getCmp("disbilityGridPanel").hide();
				L5.getCmp("depentGridPanel").hide();
				L5.getCmp("demobilizedGridPanel").show();
				L5.getCmp("demobilizeInelldGridPanel").hide();
				L5.getCmp("warGridPanel").hide();
				L5.getCmp("testedGridPanel").hide();
				L5.getCmp("countretiredsoldierGridPanel").hide();
			} else if (list[0] == 42) {// 带病回乡
				document.getElementById("illnessObjectTypeName").value = list[1];
				document.getElementById("illnessObjectType").value = list[0];
				document.getElementById("bptObjectType").value = list[0];

				L5.getCmp("form").hide();
				L5.getCmp("disabilityform").hide();
				L5.getCmp("dependantform").hide();
				L5.getCmp("demobilizeform").hide();
				L5.getCmp("demobilizedIllnessform").show();
				L5.getCmp("warform").hide();
				L5.getCmp("testform").hide();
				L5.getCmp("countretiredsoldierform").hide();
				sipTime('demobilizedIllness');

				L5.getCmp("baseGridPanel").hide();
				L5.getCmp("disbilityGridPanel").hide();
				L5.getCmp("depentGridPanel").hide();
				L5.getCmp("demobilizedGridPanel").hide();
				L5.getCmp("demobilizeInelldGridPanel").show();
				L5.getCmp("warGridPanel").hide();
				L5.getCmp("testedGridPanel").hide();
				L5.getCmp("countretiredsoldierGridPanel").hide();
			} else if (tistart == 5) {// 参战
				document.getElementById("warObjectTypeName").value = list[1];
				document.getElementById("warObjectType").value = list[0];

				L5.getCmp("form").hide();
				L5.getCmp("disabilityform").hide();
				L5.getCmp("dependantform").hide();
				L5.getCmp("demobilizeform").hide();
				L5.getCmp("demobilizedIllnessform").hide();
				L5.getCmp("warform").show();
				L5.getCmp("testform").hide();
				L5.getCmp("countretiredsoldierform").hide();
				sipTime('war');

				L5.getCmp("baseGridPanel").hide();
				L5.getCmp("disbilityGridPanel").hide();
				L5.getCmp("depentGridPanel").hide();
				L5.getCmp("demobilizedGridPanel").hide();
				L5.getCmp("demobilizeInelldGridPanel").hide();
				L5.getCmp("warGridPanel").show();
				L5.getCmp("testedGridPanel").hide();
				L5.getCmp("countretiredsoldierGridPanel").hide();
			} else if (tistart == 6) {// 参试
				document.getElementById("testObjectTypeName").value = list[1];
				document.getElementById("testObjectType").value = list[0];

				L5.getCmp("form").hide();
				L5.getCmp("disabilityform").hide();
				L5.getCmp("dependantform").hide();
				L5.getCmp("demobilizeform").hide();
				L5.getCmp("demobilizedIllnessform").hide();
				L5.getCmp("warform").hide();
				L5.getCmp("testform").show();
				L5.getCmp("countretiredsoldierform").hide();
				sipTime('test');

				L5.getCmp("baseGridPanel").hide();
				L5.getCmp("disbilityGridPanel").hide();
				L5.getCmp("depentGridPanel").hide();
				L5.getCmp("demobilizedGridPanel").hide();
				L5.getCmp("demobilizeInelldGridPanel").hide();
				L5.getCmp("warGridPanel").hide();
				L5.getCmp("testedGridPanel").show();
				L5.getCmp("countretiredsoldierGridPanel").hide();
			} else if (tistart == 8) {// 60周岁以上农村籍退役军人
				document.getElementById("soldierObjectTypeName").value = list[1];
				document.getElementById("soldierObjectType").value = list[0];

				L5.getCmp("form").hide();
				L5.getCmp("disabilityform").hide();
				L5.getCmp("dependantform").hide();
				L5.getCmp("demobilizeform").hide();
				L5.getCmp("demobilizedIllnessform").hide();
				L5.getCmp("warform").hide();
				L5.getCmp("testform").hide();
				L5.getCmp("countretiredsoldierform").show();

				L5.getCmp("baseGridPanel").hide();
				L5.getCmp("disbilityGridPanel").hide();
				L5.getCmp("depentGridPanel").hide();
				L5.getCmp("demobilizedGridPanel").hide();
				L5.getCmp("demobilizeInelldGridPanel").hide();
				L5.getCmp("warGridPanel").hide();
				L5.getCmp("testedGridPanel").hide();
				L5.getCmp("countretiredsoldierGridPanel").show();
			} else {
				document.getElementById("objectType").value = list[0];
				document.getElementById("objectTypeName").value = list[1];
				document.getElementById("bptObjectType").value = list[0];

				L5.getCmp("form").show();
				L5.getCmp("disabilityform").hide();
				L5.getCmp("dependantform").hide();
				L5.getCmp("demobilizeform").hide();
				L5.getCmp("demobilizedIllnessform").hide();
				L5.getCmp("warform").hide();
				L5.getCmp("testform").hide();
				L5.getCmp("countretiredsoldierform").hide();
				sipTime('');

				L5.getCmp("baseGridPanel").show();
				L5.getCmp("disbilityGridPanel").hide();
				L5.getCmp("depentGridPanel").hide();
				L5.getCmp("demobilizedGridPanel").hide();
				L5.getCmp("demobilizeInelldGridPanel").hide();
				L5.getCmp("warGridPanel").hide();
				L5.getCmp("testedGridPanel").hide();
				L5.getCmp("countretiredsoldierGridPanel").hide();
			}
		} else {
			document.getElementById("objectType").value = list[0];
			document.getElementById("objectTypeName").value = list[1];
			document.getElementById("bptObjectType").value = list[0];

			L5.getCmp("form").show();
			L5.getCmp("disabilityform").hide();
			L5.getCmp("dependantform").hide();
			L5.getCmp("demobilizeform").hide();
			L5.getCmp("demobilizedIllnessform").hide();
			L5.getCmp("warform").hide();
			L5.getCmp("testform").hide();
			L5.getCmp("countretiredsoldierform").hide();
			sipTime('');

			L5.getCmp("baseGridPanel").show();
			L5.getCmp("disbilityGridPanel").hide();
			L5.getCmp("depentGridPanel").hide();
			L5.getCmp("demobilizedGridPanel").hide();
			L5.getCmp("demobilizeInelldGridPanel").hide();
			L5.getCmp("warGridPanel").hide();
			L5.getCmp("testedGridPanel").hide();
			L5.getCmp("countretiredsoldierGridPanel").hide();
		}

	}
}
/**
 * 打印
 */
function print(){
/**
	获取bptObjectType的值
	用于判断当前显示的是哪个panel
*/
	var bptOb = document.getElementById("bptObjectType").value;
	var bptGP = null;
	if(bptOb == 1){
		bptGP = 'disbilityGridPanel';
	}else if(bptOb == 2){
		bptGP = 'depentGridPanel';
	}else if(bptOb == 41){
		bptGP = 'demobilizedGridPanel';
	}else if(bptOb == 42){
		bptGP = 'demobilizeInelldGridPanel';
	}else if(bptOb == 5){
		bptGP = 'warGridPanel';
	}else if(bptOb == 6){
		bptGP = 'testedGridPanel';
	}else if(bptOb == 8){
		bptGP = 'countretiredsoldierGridPanel';
	}else{
		bptGP = 'baseGridPanel';
	}
	
	var editGrid=L5.getCmp(bptGP);
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要打印的记录!");
		return false;
	}
	var peopleId = selected[0].get('PEOPLE_ID');
	var objectType = null;
	//判断优抚类别获取类别Id
	if(bptOb == 1){
		objectType = selected[0].get('DISABILITY_TYPE_CODE');
	}else if(bptOb == 2){
		objectType = selected[0].get('DEPENDANT_TYPE_CODE');
	}else if(bptOb == 41){
		objectType = 41;
	}else if(bptOb == 42){
		objectType = 42;
	}else if(bptOb == 5){
		objectType = 51;
	}else if(bptOb == 6){
		objectType = 61;
	}else if(bptOb == 8){
		objectType = 81;
	}else{
		objectType = selected[0].get('OBJECT_TYPE');
	}
//	var domicile_code = selected[0].get('DOMICILE_CODE');
//	alert(peopleId+"  "+objectType);
	var data = new L5.Map();
	data.put("peopleId",peopleId);
	data.put("objectType",objectType);
	//判断优抚类别
	if(objectType == 11||objectType == 12||objectType == 13||objectType == 14){//伤残
		
		if(organType == '11'){
			var getValue = window.showModalDialog('../flow/disability/selectLeftOrRightPrint.jsp?type=disability&peopleId='+peopleId, 'newwindow','dialogWidth=450px;dialogHeight=360px','location:no');
			if(getValue!=""&&getValue!=undefined){
				var list = getValue.split(";");
				flag = list[1];
				changeContent = decodeURI(list[2]);
				if(flag == "0") { //左边栏
					path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/disleft.doc";
					change(path,changeContent,"68");
				} else  if(flag == "1") { //右边栏
					path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/disright.doc";
					change(path,changeContent,"67");
				} else if (flag == "3") {
					openPrint(peopleId,objectType);
				}
				//var url='table/reguIdenti_apptable.jsp?peopleId='+peopleId+'&objectType='+objectType;
				//window.showModalDialog(url,window);
			}
		}else{
			alert("伤残只能省级用户打印！");
			return false;
		}
	}else if(objectType == 41||objectType == 42){//在乡复员军人、带病回乡
		if(organType == '12'){
			var getValue = window.showModalDialog('../flow/disability/selectLeftOrRightPrint.jsp?type=demobilized&peopleId='+peopleId, 'newwindow','dialogWidth=450px;dialogHeight=360px','location:no');
			if(getValue!=""&&getValue!=undefined){
				var list = getValue.split(";");
				flag = list[1];
				changeContent = decodeURI(list[2]);
				if(objectType == 41){//在乡复员军人
					if(flag == "0") { //左边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/left.doc";
						change(path,changeContent,"69");
					} else  if(flag == "1") { //右边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/demright.doc";
						change(path,changeContent,"65");
					} else if (flag == "3") {
						openPrint(peopleId,objectType);
					}
				} else if (objectType == 42){//带病回乡军人
					if(flag == "0") { //左边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/left.doc";
						change(path,changeContent,"69");
					} else  if(flag == "1") { //右边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/testright.doc";
						change(path,changeContent,"66");
					} else if (flag == "3") {
						openPrint(peopleId,objectType);
					}
				}
				//var url='table/reguIdenti_apptable.jsp?peopleId='+peopleId+'&objectType='+objectType;
				//window.showModalDialog(url,window);
			}
		}else{
			alert("在乡复员、带病回乡军人只能市级用户打印！");
			return false;
		}
	}else if(objectType == 21||objectType == 22||objectType == 23||objectType == 51||objectType == 61){//三属、参战、参试
		
		if(organType == '13'){
			var type;
			if(objectType == 21||objectType == 22||objectType == 23){
				type="dependant";
			}else{
				type="war";
			}
			var getValue = window.showModalDialog('../flow/disability/selectLeftOrRightPrint.jsp?type='+type+'&peopleId='+peopleId, 'newwindow','dialogWidth=450px;dialogHeight=360px','location:no');
			if(getValue!=""&&getValue!=undefined){
				var list = getValue.split(";");
				flag = list[1];
				changeContent = decodeURI(list[2]);
				if(objectType == 51){//参战军人
					if(flag == "0") { //左边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/left.doc";
						change(path,changeContent,"69");
					} else  if(flag == "1") { //右边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/testright.doc";
						change(path,changeContent,"64");
					} else if (flag == "3") {
						openPrint(peopleId,objectType);
					}
				} else if(objectType == 61) {//参试军人
					if(flag == "0") { //左边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/left.doc";
						change(path,changeContent,"69");
					} else  if(flag == "1") { //右边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/testright.doc";
						change(path,changeContent,"63");
					} else if (flag == "3") {
						openPrint(peopleId,objectType);
					}
				} else {//三属
					if(flag == "0") { //左边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/left.doc";
						change(path,changeContent,"69");
					} else  if(flag == "1") { //右边栏
						path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/depright.doc";
						change(path,changeContent,"62");
					} else if (flag == "3") {
						openPrint(peopleId,objectType);
					}
				}
				//var url='table/reguIdenti_apptable.jsp?peopleId='+peopleId+'&objectType='+objectType;
				//window.showModalDialog(url,window);
			}
		}else{
			alert("三属、参战、参试只能县级用户打印！");
			return false;
		}
	}else{
		alert("您选择的用户暂不能打印！");
		return false;
	}
//	var text = '优抚对象定期认证打印';
//	L5.forward(url,text,data);
	
}

//伤残等级
function forDisability(){
	var revalue=window.showModalDialog("../dicdisabilitylevel/dicdisabilitylevel.jsp");
	if(revalue!=""&&revalue!=undefined){
          var list = revalue.split(";");      
          
          if(list[0] == 0){
//         	document.getElementById("disabilityLevelCode").value=list[0];
            document.getElementById("disabilityLevelCodeName").value="所有伤残等级";
          }else{
          	document.getElementById("disabilityLevelCode").value=list[0];
            document.getElementById("disabilityLevelCodeName").value=list[1];
          }
          
	}
}

function openPrint(peopleId,objectType) {
	var docpath;
	if(objectType == 11){//残疾军人
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityJR_apptable.doc";
		
	}else if(objectType == 12){//伤残国家机关工作人员
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityGZ_apptable.doc";
		
	}else if(objectType == 13){//伤残人民警察
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityJC_apptable.doc";
		
	}else if(objectType == 14){//伤残民兵民工
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityMB_apptable.doc";
		
	}else if(objectType == 15){//因战因公伤残人员
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityZG_apptable.doc";
		
	}else if(objectType == 21){//烈士家属
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/dependantLS_apptable.doc";
		
	}else if(objectType == 22){//因公牺牲军人家属
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/dependantYG_apptable.doc";
	
	}else if(objectType == 23){//病故军人家属
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/dependantBG_apptable.doc";
		
	}else if(objectType == 41){//在乡复员军人
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/demobilized_apptable.doc";
		
	}else if(objectType == 42){//带病回乡复员军人
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/demobilizedIllness_apptable.doc";
		
	}else if(objectType == 51){//参战
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/war_apptable.doc";
		
	}else if(objectType == 61){//参试
		docpath = "jsp/cams/bpt/peopleBasicInfo/table/tested_apptable.doc";
		
	}
	
	document.getElementById("docpath").value=docpath;
	var ements = document.getElementsByName("printQuery");
	for(var i=0;i<ements.length;i++) {
		var obj = ements[i];
		if(obj.getAttribute("queryData") == "queryData") {
			var idValue = obj.getAttribute("id");
			if(idValue == "peopleId") {
				obj.value = peopleId;
			} else if(idValue == "objectType") {
				obj.value = objectType;
			}
		}
	}
	document.getElementById("bptQueryPathServiceType").value=objectType;
	
	var url="../../comm/print/jspcommonprint.jsp?";
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	window.close();
}
//证件变更时的打印页面
function change(path,changeContent,serviceType_temp) {
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10){
		month="0"+month;
	}
	document.getElementById("docPath").value = path;
	document.getElementById("printYear").value = year;
	document.getElementById("printMonth").value = month;
	document.getElementById("changeContent").value = changeContent ;
	
	document.getElementById("bptQueryPathServiceType").value = serviceType_temp;
	
	var url="../../../cams/comm/print/print_noDataSet.jsp";
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}