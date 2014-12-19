var deptId;
function init(){
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("1");
	L5.getCmp("tab").setActiveTab("0");
	query();
	applyDataSet.on('load',loadEnd);
}
function loadNew(ds){
	ds.un("load",loadNew);
	organDataSet.setParameter("regionCode",organCode);
	organDataSet.load();
}
function loadEnd(ds){
	ds.un("load",loadEnd);
	queryEnd();
	applyEndDataSet.on('load',loadNew);
}
//查询
function query(){
	applyDataSet.setParameter("ORGAN_CODE@=",deptId);
	applyDataSet.setParameter("ORGAN_NAME@LIKE",_$("curOrganName1"));
   	applyDataSet.setParameter("CUR_ORGAN_CODE",organCode);
	applyDataSet.setParameter("APPLY_TYPE@=",'4');
   	applyDataSet.setParameter("APPLY_TIME@=",_$("creatDate"));
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
    if(organType == '13'){
		applyEndDataSet.setParameter("TOWN_ORGAN_CODE",organCode);	
	}else if(organType == '12'){
		applyEndDataSet.setParameter("CITY_ORGAN_CODE",organCode);	
	}else if(organType == '11' && organCode != '0'){
		applyEndDataSet.setParameter("PROVINCE_ORGAN_CODE",organCode);	
	}
	applyEndDataSet.load();
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
	data.put("organType",organType);
	data.put("handle","true");
	data.put("deptCode",records[0].get("DEPT_CODE"));
	var url='jsp/cams/marry/dept/level/cancel/mrmLevelRectification.jsp';
	L5.forward(url,"",data);	
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
	var data=new L5.Map();
	data.put("method","UPDATE");
	data.put("applyId",records[0].get("applyId"));
	data.put("organType",organType);
	data.put("handle","true");
	data.put("organName",records[0].get("cancelOrganName"));
	data.put("skinValue",records[0].get("applyLevel"));
	data.put("deptCode",records[0].get("organCode"));
	
	var applyType = records[0].get("applyType");
	
	if(applyType == '3'){
		var url='jsp/cams/marry/dept/level/cancel/mrmLevelCancel.jsp';
	}else{
		var url='jsp/cams/marry/dept/level/cancel/mrmLevelRectification.jsp';
	}
	L5.forward(url,"",data);	
}
//删除
function deleteApply(){
	var grid = L5.getCmp('gridPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请选择一条记录！");
		return false;
	}
	var checkStatus=records[0].get("checkStatus");
	if(checkStatus!=DJC_BC && checkStatus!=QX_WTG){
		L5.Msg.alert("提示","审核状态为“在审”或“办结”，不能删除！");
		return false;
	}
  	L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
		if(sta=="yes"){
			var command = new L5.Command("com.inspur.cams.marry.application.cmd.MrmLevelApplyCmd");
			command.setParameter("applyId",records[0].get('applyId'));
			command.execute("delete");
			if (!command.error) {
				L5.Msg.alert("提示","删除成功！",function(){
					init();
				});		
			}else{
				L5.Msg.alert('提示',"删除时出现错误！"+command.error);
			}
		}
	});	
}
//明细
function renderOrganName(value,c,rec){
	return '<a href="javascript:detail(\''+rec.get("applyId")+'\',\''+rec.get('organCode')+'\',\''+rec.get('applyType')+'\')">'+value+'</a>';
}
//
function detail(applyId,deptId,applyType){
	var data=new L5.Map();
	data.put("applyId",applyId);
	data.put("deptId",deptId);
	data.put("applyType",applyType);
	var url='jsp/cams/marry/dept/level/apply/mrmLevelApplyDetail.jsp';	
	L5.forward(url,"",data);		
}
function renderapplyType(value,c,record){
	if(value == '3'){
		return "登记评定撤销";
	}else{
		return "登记评定整改";
	}
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
	
	if(applyType == '3'){
		var url='jsp/cams/marry/dept/level/cancel/mrmLevelCancel.jsp';
	}else{
		var url='jsp/cams/marry/dept/level/cancel/mrmLevelRectification.jsp';
	}
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