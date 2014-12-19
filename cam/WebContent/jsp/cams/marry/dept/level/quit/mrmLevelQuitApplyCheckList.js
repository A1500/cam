function init(){
	queryDaiBan();
	//queryYiBan();
	//queryBanJie();
	//注册tab激活函数
	var tabs1=L5.getCmp('dbPan');
	tabs1.on('activate',queryDaiBan);
	var tabs2=L5.getCmp('ybPan');
	tabs2.on('activate',queryYiBan);
	var tabs2=L5.getCmp('bjPan');
	tabs2.on('activate',queryBanJie);
	//过滤等级
	evaluLevelDataSet.filterBy(function(record, id){
		if(record.get('value') != '00' ){
			return record;
		}
	});
}
//办理						
function handle(){
	var grid = L5.getCmp('daiBanGridPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请选择一条记录！");
		return false;
	}
	var data=new L5.Map();
	data.put("method","UPDATE");
	data.put("applyId",records[0].get("applyId"));
	data.put("deptId",records[0].get("deptId"));
	data.put("applyType",records[0].get("applyType"));
	data.put("organCode",organCode);
	data.put("organName",encodeURIComponent(encodeURIComponent(records[0].get("curOrganName"))));
	data.put("organType",organType);
	var url='jsp/cams/marry/dept/level/quit/mrmLevelQuitApplyDetail.jsp';	
	L5.forward(url,"",data);		
}
//明细
function renderOrganName(value,c,rec){
	return '<a href="javascript:detail(\''+rec.get("applyId")+'\',\''+rec.get('organCode')+'\',\''+rec.get('applyType')+'\')">'+value+'</a>';
}

function detail(applyId,deptId,applyType){
	var data=new L5.Map();
	data.put("method","DETAIL");
	data.put("applyId",applyId);
	data.put("deptId",deptId);
	data.put("applyType",applyType);
	data.put("organCode",organCode);
	data.put("organType",organType);
	var url='jsp/cams/marry/dept/level/quit/mrmLevelQuitApplyDetail.jsp';	
	L5.forward(url,"",data);		
}
//查询
function queryDaiBan(){
	daiBanDataSet.setParameter("CUR_ORGAN_CODE@=",organCode);
	daiBanDataSet.setParameter("IF_FINISH@=","0");
	daiBanDataSet.setParameter("ORGAN_NAME@LIKE",_$("dbOrganName"));
	daiBanDataSet.setParameter("APPLY_LEVEL@=",_$("dbApplyLevel"));
	daiBanDataSet.setParameter("APPLY_TYPE",0);
	daiBanDataSet.load();
	daiBanDataSet.on("load",function(ds){
		if(ds.getCount<1){
			return;
		}
		for(var i=0;i<ds.getCount();i++){
			var record=ds.getAt(i);
			var organName=record.get("organName");
			var applyTime=record.get("applyTime");
			var townOrganName=record.get("townOrganName");
			var townAuditTime=record.get("townAuditTime");
			var cityOrganName=record.get("cityOrganName");
			var cityAuditTime=record.get("cityAuditTime");
			var provinceOrganName=record.get("provinceOrganName");
			var provinceAuditTime=record.get("provinceAuditTime");
			var departmentOrganName=record.get("departmentOrganName");
			var departmentAuditTime=record.get("departmentAuditTime");
			if(organType=="13"){
				if(record.get("cityOpinionId") == '2'){
					record.set("lastOrganName",cityOrganName);
					record.set("lastAuditTime",cityAuditTime);
				}else{
					record.set("lastOrganName",organName);
					record.set("lastAuditTime",applyTime);
				}
			}else if(organType=="12"){
				if(record.get("provinceOpinionId") == '2'){
					record.set("lastOrganName",provinceOrganName);
					record.set("lastAuditTime",provinceAuditTime);
				}else{
					record.set("lastOrganName",townOrganName);
					record.set("lastAuditTime",townAuditTime);
				}
			}else if(organType=="11"){
				if(record.get("departmentOpinionId") == '2'){
					record.set("lastOrganName",departmentOrganName);
					record.set("lastAuditTime",departmentAuditTime);
				}else{
					record.set("lastOrganName",cityOrganName);
					record.set("lastAuditTime",cityAuditTime);
				}
			}else{
				record.set("lastOrganName",provinceOrganName);
				record.set("lastAuditTime",provinceAuditTime);
			}
		}
		ds.commitChanges();
	});
}

//查询
function queryYiBan(){
	if(organType=="13"){//区县		
		yiBanDataSet.setParameter("TOWN_ORGAN_CODE@=",organCode);
	}else if(organType=="12"){//市
		yiBanDataSet.setParameter("CITY_ORGAN_CODE@=",organCode);
	}else if(organType=="11"){//省
		yiBanDataSet.setParameter("PROVINCE_ORGAN_CODE@=",organCode);
	}else{//部
		yiBanDataSet.setParameter("AUDIT_RESULT@=","2");
	}
	yiBanDataSet.setParameter("CUR_ORGAN_CODE@!=",organCode);
	yiBanDataSet.setParameter("IF_FINISH@=","0");
	yiBanDataSet.setParameter("ORGAN_NAME@LIKE",_$("ybOrganName"));
	yiBanDataSet.setParameter("APPLY_LEVEL@=",_$("ybApplyLevel"));
	yiBanDataSet.setParameter("APPLY_TYPE",0);
	yiBanDataSet.load();
	yiBanDataSet.on("load",function(ds){
		if(ds.getCount<1){
			return;
		}
		for(var i=0;i<ds.getCount();i++){
			var record=ds.getAt(i);
			var townOpinionId=record.get("townOpinionId");
			var townAuditTime=record.get("townAuditTime");
			var cityOpinionId=record.get("cityOpinionId");
			var cityAuditTime=record.get("cityAuditTime");
			var provinceOpinionId=record.get("provinceOpinionId");
			var provinceAuditTime=record.get("provinceAuditTime");
			var departmentOpinionId=record.get("departmentOpinionId");
			var departmentAuditTime=record.get("departmentAuditTime");
			if(organType=="13"){
				record.set("yiBanOpinionId",townOpinionId);
				record.set("yiBanTime",townAuditTime);
			}else if(organType=="12"){
				record.set("yiBanOpinionId",cityOpinionId);
				record.set("yiBanTime",cityAuditTime);
			}else if(organType=="11"){
				record.set("yiBanOpinionId",provinceOpinionId);
				record.set("yiBanTime",provinceAuditTime);
			}else{
				record.set("yiBanOpinionId",departmentOpinionId);
				record.set("yiBanTime",departmentAuditTime);
			}
		}
		ds.commitChanges();
	});
}

//查询
function queryBanJie(){
	if(organType=="13"){//区县		
		banJieDataSet.setParameter("TOWN_ORGAN_CODE@=",organCode);
	}else if(organType=="12"){//市
		banJieDataSet.setParameter("CITY_ORGAN_CODE@=",organCode);
	}else if(organType=="11"){//省
		banJieDataSet.setParameter("PROVINCE_ORGAN_CODE@=",organCode);
	}
	banJieDataSet.setParameter("IF_FINISH@=","1");
	banJieDataSet.setParameter("ORGAN_NAME@LIKE",_$("bjOrganName"));
	banJieDataSet.setParameter("APPLY_LEVEL@=",_$("bjApplyLevel"));
	banJieDataSet.setParameter("APPLY_TYPE",0);
	banJieDataSet.load();
}
function renderAuditResult(value,c,record){
	if(value=="1"){
		return "已取消等级资格";
	}else if(value=="2"){
		return "不予取消等级资格";
	}else{
		return "";
	}
}
function printApply(){
	var editGrid = L5.getCmp("banJieGridPanel");
	var selected = editGrid.getSelectionModel().getSelections();
	if (selected.length != 1) {
		L5.Msg.alert("提示", "请选择一条记录");
		return false;
	}

	var record = selected[0];

	var url=L5.webPath+"/jsp/cams/marry/dept/print/mrmQuitPrint.jsp?applyId="+record.get("applyId");
	window.open(url);
}