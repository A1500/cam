//单位类型--民政局--'A1'
var SAM_ORGAN_TYPE='A1';
//流程结束标志--未结束
var UNClOSED='0';
//当前环节--区核对
var ACT_CHECK='ACT_CHECK';
//当前环节--市核对
var ACT_CITY_CHECK='ACT_CITY_CHECK';
//当前环节--区填报
var ACT_FILLING='ACT_FILLING';
//当前环节--市转发
var ACT_CITY_SEND='ACT_CITY_SEND';
//当前环节--市下发
var ACT_ISSUE='ACT_ISSUE';
//当前环节--市填报
var ACT_CITY_FILLING='ACT_CITY_FILLING';
//当前环节--市分发
var ACT_DISPENSE='ACT_DISPENSE';
//当前环节--区转发
var ACT_BOROUGH_SEND='ACT_BOROUGH_SEND';
//当前环节--区上报
var ACT_TOWN_REPORT='ACT_TOWN_REPORT';
//环节状态--待办
var TODO='TODO';
//环节状态--转办
var TO_OTHER='TO_OTHER';
//环节状态--已办
var DONE='DONE';
//处理结果--办理完结
var RESULT_END='ED';
//处理结果--转办
var RESULT_TRANS='TR';
//核对类型---农村低保
var MININUM='02';
//核对类型---城市低保
var MININUM_CITY='01';
//核对类型--低收入
var LOW_INCOME='03';
//核对结果---非农村低保对象
var NOT_MININUM='12';
//核对结果---非城市低保对象
var NOT_MININUM_CITY='11';
//核对结果---非低收入家庭
var NOT_LOWINCOME='13';
//核对结果---无法确认
var NOT_CONFIRM="04";
//市级民政
var BE_CITY='beCity';
//区县民政
var BE_DISTRICT='beDistrict';

function init(){
	domicileDataset.setParameter("filterSql"," id like '"+organArea.substring(0,4)+"%000000'");
	domicileDataset.load();
	var tab = L5.getCmp("surey_check_tab");
	if(activeTable != ""){
		tab.setActiveTab(activeTable);
	}
	var assistanceTypeDS=L5.DatasetMgr.lookup("assistanceTypeDS");
	assistanceTypeDS.setParameter("filterSql","CODE in ('"+MININUM_CITY+"','"+MININUM+"','"+LOW_INCOME+"')");
	assistanceTypeDS.load();
	//低收入核对结果
	var lowAssistanceTypeDS=L5.DatasetMgr.lookup("lowAssistanceTypeDS");
	lowAssistanceTypeDS.setParameter("filterSql","CODE in ('"+LOW_INCOME+"','"+NOT_LOWINCOME+"','"+NOT_CONFIRM+"')");
	lowAssistanceTypeDS.load();
	todoDataSetLoad();	
	//doneDataSetLoad();
	
}
//判断用户等级
function userGrade(){
	if(organArea.substring(4,12)=="00000000"){
		return BE_CITY;
	}else if(organArea.substring(6,12)=='000000'){
		return BE_DISTRICT;
	}else{
		L5.Msg.alert('提示','此用户没有访问权限！');
		return;
	}
}

//区县待办列表
function todoDataSetLoad(){
	var todoSamSureyWfDS=L5.DatasetMgr.lookup("todoSamSureyWfDS");
	todoSamSureyWfDS.baseParams['CUR_ACTIVITY@in']=ACT_BOROUGH_SEND+","+ACT_TOWN_REPORT+","+ACT_CHECK+","+ACT_DISPENSE+","+ACT_ISSUE;
	todoSamSureyWfDS.baseParams['CUR_STATUS@in']=TODO+","+TO_OTHER+","+DONE;
	todoSamSureyWfDS.baseParams['CUR_ACTIVITY_ORGAN_TYPE']=SAM_ORGAN_TYPE;
	todoSamSureyWfDS.baseParams['CUR_ACTIVITY_AREA']=organArea;
	todoSamSureyWfDS.baseParams['IS_FINISH']=UNClOSED;
	todoSamSureyWfDS.setParameter("sort","CUR_ACTIVITY_ST");
	todoSamSureyWfDS.setParameter("dir","desc");
	todoSamSureyWfDS.load();
}
//区县已办列表
function doneDataSetLoad(){
	var doneSamSureyWfDS=L5.DatasetMgr.lookup("doneSamSureyWfDS");
	doneSamSureyWfDS.baseParams['CUR_ACTIVITY@in']=ACT_CHECK+","+ACT_DISPENSE+","+ACT_CITY_FILLING;
	doneSamSureyWfDS.baseParams['CUR_STATUS@in']=DONE+","+TO_OTHER;
	doneSamSureyWfDS.baseParams['CUR_ACTIVITY_ORGAN_TYPE']=SAM_ORGAN_TYPE;
	doneSamSureyWfDS.baseParams['CUR_ACTIVITY_AREA']=organArea;
	doneSamSureyWfDS.baseParams['IS_FINISH']=UNClOSED;
	doneSamSureyWfDS.setParameter("sort","CUR_ACTIVITY_ST");
	doneSamSureyWfDS.setParameter("dir","desc");
	doneSamSureyWfDS.load();
}

function query(){
	var todoSamSureyWfDS=L5.DatasetMgr.lookup("todoSamSureyWfDS");
	todoSamSureyWfDS.baseParams['CUR_ACTIVITY@in']=ACT_BOROUGH_SEND+","+ACT_TOWN_REPORT+","+ACT_CHECK+","+ACT_DISPENSE+","+ACT_ISSUE;
	todoSamSureyWfDS.baseParams['CUR_STATUS@in']=TODO+","+TO_OTHER+","+DONE;
	todoSamSureyWfDS.baseParams['CUR_ACTIVITY_ORGAN_TYPE']=SAM_ORGAN_TYPE;
	todoSamSureyWfDS.baseParams['CUR_ACTIVITY_AREA']=organArea;
	todoSamSureyWfDS.baseParams['IS_FINISH']=UNClOSED;
	todoSamSureyWfDS.setParameter("sort","CUR_ACTIVITY_ST");
	todoSamSureyWfDS.setParameter("dir","desc");
	
	var name = getParam("name");
	var idCard = getParam("idCard");
	var assistanceType = getParam("assistanceType");
//	var applyDateQ = getParam("applyDateQ");
//	var applyDateZ = getParam("applyDateZ");
	
	todoSamSureyWfDS.baseParams["NAME"]= name;
	todoSamSureyWfDS.baseParams["ID_CARD"]= idCard;
	todoSamSureyWfDS.baseParams["ASSISTANCE_TYPE"]= assistanceType;
	//todoSamSureyWfDS.setParameter("applyDateQ", applyDateQ);
	//todoSamSureyWfDS.setParameter("applyDateZ", applyDateZ);	
	todoSamSureyWfDS.load();
}

function queryYiban(){
	var doneSamSureyWfDS=L5.DatasetMgr.lookup("doneSamSureyWfDS");
	doneSamSureyWfDS.baseParams['CUR_ACTIVITY@in']=ACT_CHECK+","+ACT_DISPENSE+","+ACT_CITY_FILLING;
	doneSamSureyWfDS.baseParams['CUR_STATUS@in']=DONE+","+TO_OTHER;
	doneSamSureyWfDS.baseParams['CUR_ACTIVITY_ORGAN_TYPE']=SAM_ORGAN_TYPE;
	doneSamSureyWfDS.baseParams['CUR_ACTIVITY_AREA']=organArea;
	doneSamSureyWfDS.baseParams['IS_FINISH']=UNClOSED;
	
	var name = getParam("nameYiban");
	var idCard = getParam("idCardYiban");
	var assistanceType = getParam("assistanceTypeYiban");
//	var applyDateQ = getParam("applyDateQYiban");
//	var applyDateZ = getParam("applyDateZYiban");
	
	doneSamSureyWfDS.baseParams["NAME"]= name;
	doneSamSureyWfDS.baseParams["ID_CARD"]= idCard;
	doneSamSureyWfDS.baseParams["ASSISTANCE_TYPE"]= assistanceType;
	//doneSamSureyWfDS.setParameter("applyDateQ", applyDateQ);
	//doneSamSureyWfDS.setParameter("applyDateZ", applyDateZ);	
	doneSamSureyWfDS.load();
}

//核对
var mininum_win;
var lowIncome_win;
function sureyCheck(){
	var grid=L5.getCmp('surey_todo_grid');
	var selected=grid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示','请选择一条要办理的记录！');
		return;
	}
	var assistanceType=selected[0].get('assistanceType');
	var surveyId=selected[0].get("surveyId");
	var name=selected[0].get("name");
	var idCard=selected[0].get("idCard");
	var flowId=selected[0].get('flowId');
	var domicileCode=selected[0].get("domicileCode");
	var apanageCode=selected[0].get("apanageCode");
	var curActivity=selected[0].get("curActivity");
	var curStatus=selected[0].get("curStatus");
	if(assistanceType==MININUM||assistanceType==MININUM_CITY){
		if(mininum_win==undefined){
			mininum_win=L5.getCmp("mininum_win");
		}
		if(assistanceType==MININUM){
			var miniAssistanceTypeDS=L5.DatasetMgr.lookup("miniAssistanceTypeDS");
			miniAssistanceTypeDS.setParameter("filterSql","CODE in ('"+MININUM+"','"+NOT_MININUM+"','"+NOT_CONFIRM+"')");
			miniAssistanceTypeDS.load();
		}else{
			var miniAssistanceTypeDS=L5.DatasetMgr.lookup("miniAssistanceTypeDS");
			miniAssistanceTypeDS.setParameter("filterSql","CODE in ('"+MININUM_CITY+"','"+NOT_MININUM_CITY+"','"+NOT_CONFIRM+"')");
			miniAssistanceTypeDS.load();
		}
		var SamSureyWfAssistanceHisDS=L5.DatasetMgr.lookup("SamSureyWfAssistanceHisDS");
		SamSureyWfAssistanceHisDS.setParameter("FLOW_ID",flowId);
		SamSureyWfAssistanceHisDS.load();
		mininum_win.show();
		$("mini_flowId").value=flowId;
		$("mini_sureyId").value=surveyId;
		$("mini_domicileCode").value=domicileCode;
		$("mini_apanageCode").value=apanageCode;
		$("mini_name").innerHTML=name;
		$("mini_idCard").innerHTML=idCard;
		$("mini_domicile").value=domicileCode;
		$("mini_apanage").value=apanageCode;
		if(userGrade()==BE_CITY){
			$("mini_dealResult").disabled=true;
			$("mini_dealResult2").disabled=false;
			$("mini_dealResult2").checked=true;
			$("mini_surveyResult").disabled=true;
			$("mini_surveyOrganName").disabled=true;
			$("mini_surveyDate").disabled=true;
			$("mini_signOrgan").disabled=true;
			$("mini_signDate").disabled=true;
			
		}else if(userGrade()==BE_DISTRICT){
			$("mini_dealResult").disabled=false;
			$("mini_dealResult2").disabled=false;
			$("mini_dealResult").checked=true;
			$("mini_dealResult2").checked=false;
			
			$("mini_surveyResult").disabled=false;
			$("mini_surveyOrganName").disabled=false;
			$("mini_surveyDate").disabled=false;
			$("mini_signOrgan").disabled=false;
			$("mini_signDate").disabled=false;
			
			$("mini_surveyOrganName").value=organName;
			$("mini_signOrgan").value=organName;
			$("mini_surveyDate").value=new Date();
			if(curActivity==ACT_DISPENSE){
				$("mini_flag").value=ACT_DISPENSE;
				$("mini_dealResult2").disabled=true;
			}
		}
		
	}else if(assistanceType==LOW_INCOME){
		if(lowIncome_win==undefined){
			lowIncome_win=L5.getCmp("lowIncome_win");
		}
		var SamSureyWfAssistanceHisDS=L5.DatasetMgr.lookup("SamSureyWfAssistanceHisDS");
		SamSureyWfAssistanceHisDS.setParameter("FLOW_ID",flowId);
		SamSureyWfAssistanceHisDS.load();
		lowIncome_win.show();
		$("lowIncome_flowId").value=flowId;
		$("lowIncome_sureyId").value=surveyId;
		$("lowIncome_domicileCode").value=domicileCode;
		$("lowIncome_apanageCode").value=apanageCode;
		$("lowIncome_name").innerHTML=name;
		$("lowIncome_idCard").innerHTML=idCard;
		$("lowIncome_domicile").value=domicileCode;
		$("lowIncome_apanage").value=apanageCode;
		if(userGrade()==BE_CITY){
			$("lowIncome_dealResult").disabled=true;
			$("lowIncome_dealResult2").disabled=false;
			$("lowIncome_dealResult2").checked=true;
			$("lowIncome_surveyResult").disabled=true;
			$("lowIncome_surveyOrganName").disabled=true;
			$("lowIncome_surveyDate").disabled=true;
			$("lowIncome_signOrgan").disabled=true;
			$("lowIncome_signDate").disabled=true;
		}else if(userGrade()==BE_DISTRICT){
			$("lowIncome_dealResult").disabled=false;
			$("lowIncome_dealResult2").disabled=false;
			$("lowIncome_dealResult").checked=true;
			$("lowIncome_dealResult2").checked=false;
			
			$("lowIncome_surveyResult").disabled=false;
			$("lowIncome_surveyOrganName").disabled=false;
			$("lowIncome_surveyDate").disabled=false;
			$("lowIncome_signOrgan").disabled=false;
			$("lowIncome_signDate").disabled=false;
			
			$("lowIncome_surveyOrganName").value=organName;
			$("lowIncome_signOrgan").value=organName;
			$("lowIncome_surveyDate").value=new Date();
			if(curActivity==ACT_DISPENSE){
				$("lowIncome_flag").value=ACT_DISPENSE;
				$("lowIncome_dealResult2").disabled=true;
			}
		}
	}
}
//低保办理完结
function mini_dealEnd(value){
		$("mini_surveyResult").disabled=false;
		$("mini_surveyOrganName").disabled=false;
		$("mini_surveyDate").disabled=false;
		$("mini_signOrgan").disabled=false;
		$("mini_signDate").disabled=false;
		
		$("mini_surveyOrganName").value=organName;
		$("mini_signOrgan").value=organName;
		$("mini_surveyDate").value=new Date();
}
//低保转办
function mini_transmit(value){
		$("mini_surveyResult").value='';
		$("mini_surveyOrganName").value='';
		$("mini_surveyDate").value='';
		$("mini_signOrgan").value='';
		$("mini_signDate").value='';
		
		$("mini_surveyResult").disabled=true;
		$("mini_surveyOrganName").disabled=true;
		$("mini_surveyDate").disabled=true;
		$("mini_signOrgan").disabled=true;
		$("mini_signDate").disabled=true;
}
//低收入办理完结
function lowIncome_dealEnd(value){
		$("lowIncome_surveyResult").disabled=false;
		$("lowIncome_surveyOrganName").disabled=false;
		$("lowIncome_surveyDate").disabled=false;
		$("lowIncome_signOrgan").disabled=false;
		$("lowIncome_signDate").disabled=false;
		
		$("lowIncome_surveyOrganName").value=organName;
		$("lowIncome_signOrgan").value=organName;
		$("lowIncome_surveyDate").value=new Date();
}
//低收入转办
function lowIncome_transmit(value){
		$("lowIncome_surveyResult").value='';
		$("lowIncome_surveyOrganName").value='';
		$("lowIncome_surveyDate").value='';
		$("lowIncome_signOrgan").value='';
		$("lowIncome_signDate").value='';
		
		$("lowIncome_surveyResult").disabled=true;
		$("lowIncome_surveyOrganName").disabled=true;
		$("lowIncome_surveyDate").disabled=true;
		$("lowIncome_signOrgan").disabled=true;
		$("lowIncome_signDate").disabled=true;
}
//移交
function transfer(){
	var grid=L5.getCmp('surey_done_grid');
	var selected=grid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示','请选择一条要核对的记录！');
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要移交选中的记录！",
		function(sta){
			if(sta=="yes"){
				var length=selected.length;
				for(var i=0;i<length;i++){
					var surveyId=selected[i].get("surveyId");
					var applyTitle=selected[i].get("applyTitle");
					var flowId=selected[i].get('flowId');
					var curActivity=selected[i].get('curActivity');
					var curStatus=selected[i].get('curStatus');
					var domicileCode=selected[i].get("domicileCode");
					var apanageCode=selected[i].get("apanageCode"); 
					
					var map=new L5.Map();
						map.put("flowId",flowId);
						map.put("surveyId",surveyId);
						map.put("organId",organId);
						map.put("userId",userId);
						map.put("organName",organName);
						map.put("userName",userName);
						map.put("domicileCode",domicileCode);
						map.put("apanageCode",apanageCode);
					if((curActivity==ACT_CHECK&&curStatus==DONE)||(curActivity==ACT_CITY_FILLING&&curStatus==DONE)){
					//区核对 已办||市填报 已办
						var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
						command.setParameter("map",map);
						command.execute("sureyGather");
						if(!command.error){
							var doneSamSureyWfDS=L5.DatasetMgr.lookup("doneSamSureyWfDS");
							doneSamSureyWfDS.remove(selected[i]);
						}else{
							L5.Msg.alert("错误",applyTitle+'移交失败！',function(){});
						}
					}else if(curActivity==ACT_CHECK&&curStatus==TO_OTHER){
					//区核对 转发
						var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
						command.setParameter("map",map);
						command.execute("districtTransmit");
						if(!command.error){
							var doneSamSureyWfDS=L5.DatasetMgr.lookup("doneSamSureyWfDS");
							doneSamSureyWfDS.remove(selected[i]);
						}else{
							L5.Msg.alert("错误",applyTitle+'移交失败！',function(){});
						}
					}else if(curActivity==ACT_DISPENSE&&curStatus==DONE){
					//市分发 已办
						var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
						command.setParameter("map",map);
						command.execute("reporting");
						if(!command.error){
							var doneSamSureyWfDS=L5.DatasetMgr.lookup("doneSamSureyWfDS");
							doneSamSureyWfDS.remove(selected[i]);
						}else{
							L5.Msg.alert("错误",applyTitle+'移交失败！',function(){});
						}
					}else if(curActivity==ACT_DISPENSE&&curStatus==TO_OTHER){
					//区县经济核对中心上报到市经济核对中心
						var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
						command.setParameter("map",map);
						command.execute("centerReport");
						if(!command.error){
							var doneSamSureyWfDS=L5.DatasetMgr.lookup("doneSamSureyWfDS");
							doneSamSureyWfDS.remove(selected[i]);
						}else{
							L5.Msg.alert("错误",applyTitle+'移交失败！',function(){});
						}
					}else if(curActivity==ACT_DISPENSE&&curStatus==TODO){
					//区县经济核对中心接到市经济核对中心转发的请求后，转发给区县民政局
						var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
						command.setParameter("map",map);
						command.execute("townCenterToTownCams");
						if(!command.error){
							var doneSamSureyWfDS=L5.DatasetMgr.lookup("doneSamSureyWfDS");
							doneSamSureyWfDS.remove(selected[i]);
						}else{
							L5.Msg.alert("错误",applyTitle+'移交失败！',function(){});
						}
					} else if(curActivity==ACT_DISPENSE&&curStatus==TO_OTHER){
					//区县经济核对中心转发核对请求至区县民政局
						var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
						command.setParameter("map",map);
						command.execute("centerReport");
						if(!command.error){
							var doneSamSureyWfDS=L5.DatasetMgr.lookup("doneSamSureyWfDS");
							doneSamSureyWfDS.remove(selected[i]);
						}else{
							L5.Msg.alert("错误",applyTitle+'移交失败！',function(){});
						}
					}
				}
			}
	});
}
//保存低保
function save_mininnum(){
	if(_$('mini_dealResult')==''&&_$('mini_dealResult2')==''){L5.Msg.alert('提示','处理结果必须填写！');return;}
	if($('mini_dealResult').checked){
		if(_$("mini_surveyResult")==NOT_MININUM||_$("mini_surveyResult")==NOT_MININUM_CITY||_$("mini_surveyResult")==NOT_CONFIRM){
			if(_$('mini_surveyResult')==''){L5.Msg.alert('提示','核对结果必须填写！');return;}
			if(_$('mini_surveyOrganName')==''){L5.Msg.alert('提示','核对单位必须填写！');return;}
			if(_$('mini_surveyDate')==''){L5.Msg.alert('提示','核对日期必须填写！');return;}
		}else{
			if(_$('mini_surveyResult')==''){L5.Msg.alert('提示','核对结果必须填写！');return;}
			if(_$('mini_surveyOrganName')==''){L5.Msg.alert('提示','核对单位必须填写！');return;}
			if(_$('mini_surveyDate')==''){L5.Msg.alert('提示','核对日期必须填写！');return;}
			if(_$('mini_signOrgan')==''){L5.Msg.alert('提示','低保证发证机关必须填写！');return;}
			if(_$('mini_signDate')==''){L5.Msg.alert('提示','低保证发证日期必须填写！');return;}
		}
		
		var  map=new L5.Map();
		map.put("flowId",_$('mini_flowId'));
		map.put("sureyId",_$('mini_sureyId'));
		map.put("surveyResult",_$('mini_surveyResult'));
		map.put("surveyOrganName",_$('mini_surveyOrganName'));
		map.put("surveyDate",_$('mini_surveyDate'));
		map.put("signOrgan",_$('mini_signOrgan'));
		map.put("signDate",_$('mini_signDate'));
		map.put("organId",organId);
		map.put("userId",userId);
		map.put("userName",userName);
		map.put("opinionCode",RESULT_END);
		map.put("opinion",_$('mini_opinion'));
		var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
		command.setParameter("map",map);
		command.execute("checkSamSurey");
		if(!command.error){
			L5.Msg.alert("提示","办理成功！");
			close_mininum();
			init();
		}else{
			L5.Msg.alert("提示","办理出错！"+command.error);
			return;
		}		
	}else if($('mini_dealResult2').checked){
		if(_$("mini_domicileCode")==_$("mini_apanageCode")){
			L5.Msg.alert("提示","此人员的户籍地和居住地都在本区，不可以移交。");
			return;
		}
		var  map=new L5.Map();
		map.put("flowId",_$('mini_flowId'));
		map.put("sureyId",_$('mini_sureyId'));
		map.put("organId",organId);
		map.put("userGrade",userGrade());
		map.put("opinionCode",RESULT_TRANS);
		map.put("opinion",_$('mini_opinion'));
		var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
		command.setParameter("map",map);
		command.execute("transmitOther");
		if(!command.error){
			L5.Msg.alert("提示","办理成功！");
			close_mininum();
			init();
		}else{
			L5.Msg.alert("提示","办理出错！"+command.error);
			return;
		}		
	}
}

//保存低收入
function save_lowIncome(){
	if(_$('lowIncome_dealResult')==''&&_$('lowIncome_dealResult2')==''){L5.Msg.alert('提示','处理结果必须填写！');return;}
	if($('lowIncome_dealResult').checked){
		if(_$('lowIncome_surveyResult')==NOT_LOWINCOME||_$('lowIncome_surveyResult')==NOT_CONFIRM){
			if(_$('lowIncome_surveyResult')==''){L5.Msg.alert('提示','核对结果必须填写！');return;}
			if(_$('lowIncome_surveyOrganName')==''){L5.Msg.alert('提示','核对单位必须填写！');return;}
			if(_$('lowIncome_surveyDate')==''){L5.Msg.alert('提示','核对日期必须填写！');return;}
		}else{
			if(_$('lowIncome_surveyResult')==''){L5.Msg.alert('提示','核对结果必须填写！');return;}
			if(_$('lowIncome_surveyOrganName')==''){L5.Msg.alert('提示','核对单位必须填写！');return;}
			if(_$('lowIncome_surveyDate')==''){L5.Msg.alert('提示','核对日期必须填写！');return;}
			if(_$('lowIncome_signOrgan')==''){L5.Msg.alert('提示','低保证发证机关必须填写！');return;}
			if(_$('lowIncome_signDate')==''){L5.Msg.alert('提示','低保证发证日期必须填写！');return;}
		}
		
		var  map=new L5.Map();
		map.put("flowId",_$('lowIncome_flowId'));
		map.put("sureyId",_$('lowIncome_sureyId'));
		map.put("surveyResult",_$('lowIncome_surveyResult'));
		map.put("surveyOrganName",_$('lowIncome_surveyOrganName'));
		map.put("surveyDate",_$('lowIncome_surveyDate'));
		map.put("signOrgan",_$('lowIncome_signOrgan'));
		map.put("signDate",_$('lowIncome_signDate'));
		map.put("organId",organId);
		map.put("userId",userId);
		map.put("userName",userName);
		map.put("opinionCode",RESULT_END);
		map.put("opinion",_$('lowIncome_opinion'));
		var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
		command.setParameter("map",map);
		command.execute("checkSamSurey");
		if(!command.error){
			L5.Msg.alert("提示","办理成功！");
			close_lowIncome();
			init();
		}else{
			L5.Msg.alert("提示","办理出错！"+command.error);
			return;
		}		
	}else if($('lowIncome_dealResult2').checked){
		if(_$("lowIncome_domicileCode")==_$("lowIncome_apanageCode")){
			L5.Msg.alert("提示","此人员的户籍地和居住地都在本区，不可以移交。");
			return;
		}
		var  map=new L5.Map();
		map.put("flowId",_$('lowIncome_flowId'));
		map.put("sureyId",_$('lowIncome_sureyId'));
		map.put("userGrade",userGrade());
		map.put("opinionCode",RESULT_END);
		map.put("opinion",_$('lowIncome_opinion'));
		var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
		command.setParameter("map",map);
		command.execute("transmitOther");
		if(!command.error){
			L5.Msg.alert("提示","办理成功！");
			close_lowIncome();
			init();
		}else{
			L5.Msg.alert("提示","办理出错！"+command.error);
			return;
		}		
	}
}
//窗口关闭
function close_lowIncome(){
	lowIncome_win.hide();
}
function close_mininum(){
	mininum_win.hide();
}
//核对结果联动
function showMiniResult(src){
	var value=src.value;
	if(value==NOT_MININUM||value==NOT_MININUM_CITY||value==NOT_CONFIRM){
	  if(_$("mini_flag")!=ACT_DISPENSE){
		if(_$("mini_domicileCode")!=_$("mini_apanageCode")){
			L5.Msg.alert("提示","此人员为人户分离对象，若无法确认,建议转办！",function(){});
		}
	  }	
		$("mini_signOrgan").value='';
		$("mini_signDate").value='';
		$("mini_signOrgan").disabled=true;
		$("mini_signDate").disabled=true;
	}else{
		$("mini_signOrgan").value=organName;
		$("mini_signOrgan").disabled=false;
		$("mini_signDate").disabled=false;
	}
}
function showLowResult(src){
	var value=src.value;
	if(value==NOT_LOWINCOME||value==NOT_CONFIRM){
		if(_$("lowIncome_flag")!=ACT_DISPENSE){
			if(_$("lowIncome_domicileCode")!=_$("lowIncome_apanageCode")){
				L5.Msg.alert("提示","此人员为人户分离对象，若无法确认,建议转办！",function(){});
			}
		}	
		$("lowIncome_signOrgan").value='';
		$("lowIncome_signDate").value='';
		$("lowIncome_signOrgan").disabled=true;
		$("lowIncome_signDate").disabled=true;
	}else{
		$("lowIncome_signOrgan").value=organName;
		$("lowIncome_signOrgan").disabled=false;
		$("lowIncome_signDate").disabled=false;
	}
}
function getParam(ElementId) {
    var value = document.getElementById(ElementId).value;
    if (value == "") value = undefined;
    return value;
}

/*****区县经济核对中心  移交核对任务至随对应的区县民政局 开始****/
/*****区县经济核对中心  将区外部单位发送的请求转发给对应区县的民政局*****/
//移交
function townTransfer(){
	var grid=L5.getCmp('surey_todo_grid');
	var selected=grid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示','请选择一条要核对的记录！');
		return;
	}
	L5.MessageBox.confirm("提示", "你确定要移交选中的记录！",
		function(sta){
			if(sta=="yes"){
				var length=selected.length;
				for(var i=0;i<length;i++){
					var surveyId=selected[i].get("surveyId");
					var applyTitle=selected[i].get("applyTitle");
					var flowId=selected[i].get('flowId');
					var curActivity=selected[i].get('curActivity');
					var curStatus=selected[i].get('curStatus');
					var domicileCode=selected[i].get("domicileCode");
					var apanageCode=selected[i].get("apanageCode"); 
					var map=new L5.Map();
						map.put("flowId",flowId);
						map.put("surveyId",surveyId);
						map.put("organId",organId);
						map.put("userId",userId);
						map.put("organName",organName);
						map.put("userName",userName);
						map.put("domicileCode",domicileCode);
						map.put("apanageCode",apanageCode);
					if((curActivity==ACT_BOROUGH_SEND&&curStatus==TODO)||(curActivity==ACT_DISPENSE&&curStatus==TODO)){
					//区县经济核对中心移交核对任务至所对应的区县民政局
						var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
						command.setParameter("map",map);
						command.execute("centerDistribute");
						if(!command.error){
							var SamSureyWfDS=L5.DatasetMgr.lookup("todoSamSureyWfDS");
							SamSureyWfDS.remove(selected[i]);
						}else{
							L5.Msg.alert("错误",applyTitle+'移交失败！',function(){});
						}
					}else if((curActivity==ACT_TOWN_REPORT&&curStatus==DONE)||(curActivity==ACT_TOWN_REPORT&&curStatus==TODO)){
					//区县经济核对中心上报核对结果到市经济核对中心
						var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
						command.setParameter("map",map);
						command.execute("townReportToCity");
						if(!command.error){
							var SamSureyWfDS=L5.DatasetMgr.lookup("todoSamSureyWfDS");
				 
							SamSureyWfDS.remove(selected[i]);
						}else{
							L5.Msg.alert("错误",applyTitle+'移交失败！',function(){});
						}
					}else if((curActivity==ACT_CHECK&&curStatus==TODO)){
					    //区县经济核对中心  将区外部单位发送的请求转发给对应区县的民政局 (区县)
						var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
						command.setParameter("map",map);
						command.execute("centerReportToTown");
						if(!command.error){
							var SamSureyWfDS=L5.DatasetMgr.lookup("todoSamSureyWfDS");
							SamSureyWfDS.remove(selected[i]);
						}else{
							L5.Msg.alert("错误",applyTitle+'移交失败！',function(){});
						}
					} else if((curActivity==ACT_CHECK&&curStatus==TO_OTHER)){
					    //区县经济核对中心 接到申请人所在民政局的和对结果后进行判断，若不存在人户分离的现象责按照申请人所在区县的民政局核对结果为准，
					    //反之由区县的经济核对中心递交申请到市经济核对中心，再有市经济核对中心向另外一个区县转发
						var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
						command.setParameter("map",map);
				 
						command.execute("centerCheckIfIdentical");
						if(!command.error){
							var SamSureyWfDS=L5.DatasetMgr.lookup("todoSamSureyWfDS");
							SamSureyWfDS.remove(selected[i]);
						}else{
							L5.Msg.alert("错误",applyTitle+'移交失败！',function(){});
						}
					} else if((curActivity==ACT_CITY_SEND&&curStatus==TODO)||(curActivity==ACT_CITY_CHECK&&curStatus==TODO)){
					//市转发 待办||市核对 待办
						var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
						command.setParameter("map",map);
						command.execute("cityDistribute");
						if(!command.error){
							var SamSureyWfDS=L5.DatasetMgr.lookup("todoSamSureyWfDS");
							SamSureyWfDS.remove(selected[i]);
						}else{
							L5.Msg.alert("错误",applyTitle+'移交失败！',function(){});
						}
					}else if((curActivity==ACT_CITY_FILLING&&curStatus==DONE)){
					//市经济核对中心将核对结果反馈给市外部单位 || 区县外部单位申报的核对请求处理，
						var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
						command.setParameter("map",map);
						command.execute("cityDistributeToApply");
						if(!command.error){
							var SamSureyWfDS=L5.DatasetMgr.lookup("todoSamSureyWfDS");
							SamSureyWfDS.remove(selected[i]);
						}else{
							L5.Msg.alert("错误",applyTitle+'移交失败！',function(){});
						}
					}else if(curActivity==ACT_FILLING&&curStatus==DONE){
					//区填报 已办
						var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
						command.setParameter("map",map);
						command.execute("districtFilling");
						if(!command.error){
							var SamSureyWfDS=L5.DatasetMgr.lookup("todoSamSureyWfDS");
							SamSureyWfDS.remove(selected[i]);
						}else{
							L5.Msg.alert("错误",applyTitle+'移交失败！',function(){});
						}
					//}else if(curActivity==ACT_FILLING&&curStatus==TO_OTHER){
					}else if(curActivity==ACT_ISSUE&&curStatus==TODO){
					//最后一步区县  TODO
						var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
						command.setParameter("map",map);
						command.execute("townCenterDistributeToApply");
						if(!command.error){
							var SamSureyWfDS=L5.DatasetMgr.lookup("todoSamSureyWfDS");
							SamSureyWfDS.remove(selected[i]);
						}else{
							L5.Msg.alert("错误",applyTitle+'移交失败！',function(){});
						}
					} else if((curActivity==ACT_CHECK&&curStatus==DONE)){
				 
						var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
						command.setParameter("map",map);
						command.execute("sureyGather");
						if(!command.error){
							var doneSamSureyWfDS=L5.DatasetMgr.lookup("todoSamSureyWfDS");
							doneSamSureyWfDS.remove(selected[i]);
						}else{
							L5.Msg.alert("错误",applyTitle+'移交失败！',function(){});
						}
					}
				}
			}
	});
}
/*****地市流程调整 结束****/
