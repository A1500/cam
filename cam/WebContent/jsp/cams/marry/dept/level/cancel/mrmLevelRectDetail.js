var deptId;
function init(){
	if(organType=="11"){
		var tab=L5.getCmp("tab");
		var tab1=L5.getCmp("tab1");
		tab.remove(tab1);
		L5.getCmp("tab").setActiveTab("1");
		L5.getCmp("tab").setActiveTab("0");
		query();
		applyDataSet.on('load',loadEnd);
	}else{
		L5.getCmp("tab").setActiveTab("2");
		L5.getCmp("tab").setActiveTab("1");
		L5.getCmp("tab").setActiveTab("0");
		loadOrgan();
	}
	
	
	if(isEnd == "true"){
		organCode="999";
	}
}
function loadOrgan(){
	organDataSet.setParameter("regionCode",organCode);
	organDataSet.load();
	organDataSet.on('load',loadQuery);
}
function loadQuery(ds){
	ds.un("load",loadQuery);
	query();
	applyDataSet.on('load',loadEnd);
}
function loadEnd(ds){
	ds.un("load",loadEnd);
	queryEnd();
}
//办理						
function handle(){
	var grid = L5.getCmp('gridPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请选择一条记录！");
		return false;
	}
	var checkStatus=records[0].get("checkStatus");
	var data=new L5.Map();
	data.put("method","END");
	data.put("applyId",records[0].get("applyId"));
	data.put("organName",records[0].get("cancelOrganName"));
	data.put("skinValue",records[0].get("applyLevel"));
	data.put("deptCode",records[0].get("organCode"));
	
	if(isEnd == "true"){
		data.put("organType","0");
	}else{
		data.put("handle","true");
		data.put("organType",organType);
	}
	var url='jsp/cams/marry/dept/level/cancel/mrmLevelRectification.jsp';
	L5.forward(url,"",data);	
}
//查询
function query(){
	applyDataSet.setParameter("ORGAN_CODE@=",deptId);
	applyDataSet.setParameter("ORGAN_NAME@LIKE",_$("curOrganName1"));
   	if(organCode == '999'){//如果是部里
   		applyDataSet.setParameter("CUR_ORGAN_CODE","999");
   	}else{
   	 	applyDataSet.setParameter("CUR_ORGAN_CODE",organCode);
   	}
   	applyDataSet.setParameter("APPLY_TIME@=",_$("creatDate"));
	applyDataSet.setParameter("APPLY_TYPE@=",'4');
   	applyDataSet.setParameter("IF_FINISH","0");
	applyDataSet.load();
}
function queryEnd(){
	applyEndDataSet.setParameter("ORGAN_CODE@=",deptId);
	applyEndDataSet.setParameter("APPLY_TYPE@=",'4');
	applyEndDataSet.setParameter("ORGAN_NAME@LIKE",_$("curOrganName"));
	if(organCode == '999'){//如果是部里
   		applyEndDataSet.setParameter("CUR_ORGAN_CODE","999");
		applyEndDataSet.setParameter("IF_FINISH","1");
   	}
   	if( _$("checkStatus")!= '' ){
		applyEndDataSet.setParameter("CHECK_STATUS@IN",_$("checkStatus"));
    }
    
	if(organType == '12'){
		applyEndDataSet.setParameter("CITY_ORGAN_CODE",organCode);	
	}else if(organType == '11' && organCode != '0'){
		applyEndDataSet.setParameter("PROVINCE_ORGAN_CODE",organCode);	
	}
	applyEndDataSet.load();
}
function handleEnd(){
	var grid = L5.getCmp('gridEndPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请选择一条记录！");
		return false;
	}
	var data=new L5.Map();
	data.put("method","END");
	data.put("applyId",records[0].get("applyId"));
	data.put("organType",organType);
	data.put("organName",records[0].get("cancelOrganName"));
	data.put("skinValue",records[0].get("applyLevel"));
	data.put("deptCode",records[0].get("organCode"));
	
	var applyType = records[0].get("applyType");
	var url='jsp/cams/marry/dept/level/cancel/mrmLevelRectification.jsp';
	L5.forward(url,"",data);	
}

function printApply(){
	var editGrid = L5.getCmp("gridEndPanel");
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert("提示", "请选择一条记录");
		return false;
	}

	var record = selected[0];

	var url=L5.webPath+"/jsp/cams/marry/dept/print/mrmRectPrint.jsp?applyId="+record.get("applyId");
	window.open(url);
}
function newRect(){
	var grid = L5.getCmp('gridanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请选择一条记录！");
		return false;
	}
	var skinValue=records[0].get("SKIN_VALUE");
	if(skinValue.trim() == ''  || skinValue.trim() == '00'){
		L5.Msg.alert("提示","该登记机关无评定等级！无需整改操作！");
		return false;
	}
	var data=new L5.Map();
	data.put("method","INSERT");
	data.put("organName",records[0].get("NAME"));
	data.put("skinValue",skinValue);
	if(isEnd == "true"){
		data.put("organType","0");
	}else{
		data.put("handle","true");
		data.put("organType",organType);
	}
	data.put("deptCode",records[0].get("DEPT_CODE"));
	var url='jsp/cams/marry/dept/level/cancel/mrmLevelRectification.jsp';
	L5.forward(url,"",data);	
}
function childRegsion(value, cellmeta, record) { // 登录名称机关添加链接（点击查询下一级）
	var regsion = record.get("REGION_CODE");
	var functionStr = 'queryChildRegsion("' + regsion + '")';
	return "<a href='#' onclick='javascript:" + functionStr + "'>" + value
			+ "</a>";
}
function queryChildRegsion(regsion) { // 查询下一级
	organDataSet.setParameter("regionCode",regsion);
	organDataSet.load();
}