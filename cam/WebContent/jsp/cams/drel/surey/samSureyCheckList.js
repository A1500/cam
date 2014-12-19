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
//当前环节--市填报
var ACT_CITY_FILLING='ACT_CITY_FILLING';
//当前环节--市分发
var ACT_DISPENSE='ACT_DISPENSE';
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

//测试 
var TO_OTHER1='TO_OTHER1';
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
	doneDataSetLoad();
	
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
	todoSamSureyWfDS.baseParams['CUR_ACTIVITY@in']=ACT_DISPENSE+","+ACT_FILLING;
	todoSamSureyWfDS.baseParams['CUR_STATUS']=TODO;
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
	doneSamSureyWfDS.baseParams['CUR_ACTIVITY@in']=ACT_DISPENSE+","+ACT_CITY_FILLING+","+ACT_FILLING;
	doneSamSureyWfDS.baseParams['CUR_STATUS@in']=DONE;
	doneSamSureyWfDS.baseParams['CUR_ACTIVITY_ORGAN_TYPE']=SAM_ORGAN_TYPE;
	doneSamSureyWfDS.baseParams['CUR_ACTIVITY_AREA']=organArea;
	doneSamSureyWfDS.baseParams['IS_FINISH']=UNClOSED;
	doneSamSureyWfDS.setParameter("sort","CUR_ACTIVITY_ST");
	doneSamSureyWfDS.setParameter("dir","desc");
	doneSamSureyWfDS.load();
}

function query(){
	var todoSamSureyWfDS=L5.DatasetMgr.lookup("todoSamSureyWfDS");
	todoSamSureyWfDS.baseParams['CUR_ACTIVITY@in']=ACT_DISPENSE+","+ACT_FILLING;
	todoSamSureyWfDS.baseParams['CUR_STATUS']=TODO;
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
	doneSamSureyWfDS.baseParams['CUR_ACTIVITY@in']=ACT_DISPENSE+","+ACT_CITY_FILLING+","+ACT_FILLING;
	doneSamSureyWfDS.baseParams['CUR_STATUS@in']=DONE;
	doneSamSureyWfDS.baseParams['CUR_ACTIVITY_ORGAN_TYPE']=SAM_ORGAN_TYPE;
	doneSamSureyWfDS.baseParams['CUR_ACTIVITY_AREA']=organArea;
	doneSamSureyWfDS.baseParams['IS_FINISH']=UNClOSED;
	doneSamSureyWfDS.setParameter("sort","CUR_ACTIVITY_ST");
	doneSamSureyWfDS.setParameter("dir","desc");
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
//处理：区县核对流程除了户籍所在区县的民政局能进行‘转办’。
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
	//根据surveyId查询SAM_SUREY中业务申请行政区划是否为区县还是市，以此判断是市核对流程还是区县核对流程
	var domicileCode=selected[0].get("domicileCode");
	var apanageCode=selected[0].get("apanageCode");
	var curActivity=selected[0].get("curActivity");
	var curStatus=selected[0].get("curStatus");
	var curActivityArea=selected[0].get("curActivityArea");
	if(assistanceType==MININUM||assistanceType==MININUM_CITY){
		if(mininum_win==undefined){
			mininum_win=L5.getCmp("mininum_win");
		}
		var miniAssistanceTypeDS=L5.DatasetMgr.lookup("miniAssistanceTypeDS");
		miniAssistanceTypeDS.removeAll();
		var SamSureyWfAssistanceHisDS=L5.DatasetMgr.lookup("SamSureyWfAssistanceHisDS");
		SamSureyWfAssistanceHisDS.setParameter("FLOW_ID",flowId);
		SamSureyWfAssistanceHisDS.load();
		mininum_win.show();
		var samSureyDS = L5.DatasetMgr.lookup("samSureyDS");  
		samSureyDS.setParameter("SURVEY_ID@=",surveyId);
		samSureyDS.load();
		samSureyDS.on("load",function(ds){
			 if(assistanceType==MININUM){
				miniAssistanceTypeDS.setParameter("filterSql","CODE in ('"+MININUM+"','"+NOT_MININUM+"')");
			 }else{
				miniAssistanceTypeDS.setParameter("filterSql","CODE in ('"+MININUM_CITY+"','"+NOT_MININUM_CITY+"')");
			 }
			   
			miniAssistanceTypeDS.load();
	    });
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
		var lowAssistanceTypeDS=L5.DatasetMgr.lookup("lowAssistanceTypeDS");
		lowAssistanceTypeDS.removeAll();
		var SamSureyWfAssistanceHisDS=L5.DatasetMgr.lookup("SamSureyWfAssistanceHisDS");
		SamSureyWfAssistanceHisDS.setParameter("FLOW_ID",flowId);
		SamSureyWfAssistanceHisDS.load();
		lowIncome_win.show();
		 var samSureyDS = L5.DatasetMgr.lookup("samSureyDS");  
		 samSureyDS.setParameter("SURVEY_ID@=",surveyId);
		 samSureyDS.load();
		 samSureyDS.on("load",function(ds){
			 lowAssistanceTypeDS.setParameter("filterSql","CODE in ('"+LOW_INCOME+"','"+NOT_LOWINCOME+"')");
			 lowAssistanceTypeDS.load();
	     });
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
//区县民政局将填报的结果上报到区县经济核对中心，区县经济核对中心上报到市经济核对中心
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
					if((curActivity==ACT_CITY_FILLING&&curStatus==DONE)){
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
					}  else if((curActivity==ACT_FILLING&&curStatus==DONE)){
		 
					//区县填报的核对结果上报给区县的经济核对中心||
						var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
						command.setParameter("map",map);
						command.execute("townCamsTotownCenter");
						
						if(!command.error){
							var doneSamSureyWfDS=L5.DatasetMgr.lookup("doneSamSureyWfDS");
							doneSamSureyWfDS.remove(selected[i]);
						}else{
							L5.Msg.alert("错误",applyTitle+'移交失败！',function(){});
						}
					} else if(curActivity==ACT_CHECK&&curStatus==DONE){
					//区县民政局将填写的核对结果上报给区县的经济核对中心
						var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
						command.setParameter("map",map);
						command.execute("townReport");
						if(!command.error){
							var doneSamSureyWfDS=L5.DatasetMgr.lookup("doneSamSureyWfDS");
							doneSamSureyWfDS.remove(selected[i]);
						}else{
							L5.Msg.alert("错误",applyTitle+'移交失败！',function(){});
						}
					}else if(curActivity==ACT_CHECK&&curStatus==TO_OTHER1){
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
					}else if(curActivity==ACT_CHECK&&curStatus==TO_OTHER){
		
					//区县经济核对中心接到区县民政局的和对结果后进行判断，若和对对象不存在人户分离的现象就按照区县填报的结果来算，反之进行转发到市经济核对中心
						var command=new L5.Command("com.inspur.cams.drel.surey.comm.cmd.SamSureyWfCmd");
						command.setParameter("map",map);
						command.execute("townCenterToCityCenter");
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
	}else if($('lowIncome_dealResult3').checked){
		if(_$("lowIncome_domicileCode")==_$("lowIncome_apanageCode")){
			L5.Msg.alert("提示","此人员的户籍地和居住地都在本区，不可以移交。");
			return;
		}
		var  map=new L5.Map();
		map.put("flowId",_$('lowIncome_flowId'));
		map.put("sureyId",_$('lowIncome_sureyId'));
		map.put("userGrade",userGrade());
		map.put("opinionCode",RESULT_TRANS);
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
		$("mini_signOrgan").value='';
		$("mini_signDate").value='';
		$("mini_signOrgan").disabled=true;
		$("mini_signDate").disabled=true;
	}else{
		$("mini_signOrgan").value=organName;
		$("mini_signOrgan").disabled=false;
		$("mini_signDate").disabled=false;
	}
	var domicileCode= $('mini_domicile').value;
	var apanageCode= $('mini_apanage').value;
	var ds = L5.DatasetMgr.lookup("samSureyDS");  
	if((ds.get("applyOrganArea").substring(4,12)!="00000000")
			&&(ds.get("applyOrganArea").substring(6,12)=='000000' )
			&&(domicileCode!=apanageCode)
			&&(organArea==domicileCode)
			&&(value==NOT_MININUM||value==NOT_MININUM_CITY)){ 
		
		$('mini_dealResult2').checked=true;
		$('mini_dealResult').checked=false;
	}else{
		$('mini_dealResult2').checked=false;
		$('mini_dealResult').checked=true;
	}
}
function showLowResult(src){
	var value=src.value;
	if(value==NOT_LOWINCOME||value==NOT_CONFIRM){
		
		$("lowIncome_signOrgan").value='';
		$("lowIncome_signDate").value='';
		$("lowIncome_signOrgan").disabled=true;
		$("lowIncome_signDate").disabled=true;
	}else{
		$("lowIncome_signOrgan").value=organName;
		$("lowIncome_signOrgan").disabled=false;
		$("lowIncome_signDate").disabled=false;
	}
	var domicileCode= $('lowIncome_domicile').value;
	var apanageCode= $('lowIncome_apanage').value;
	var ds = L5.DatasetMgr.lookup("samSureyDS");  
	if((ds.get("applyOrganArea").substring(4,12)!="00000000")
			&&(ds.get("applyOrganArea").substring(6,12)=='000000' )
			&&(domicileCode!=apanageCode)
			&&(organArea==domicileCode)
			&&(value==NOT_LOWINCOME)){
	
		$('lowIncome_dealResult3').checked=true;
		$('lowIncome_dealResult').checked=false;
	}else{
		$('lowIncome_dealResult3').checked=false;
		$('lowIncome_dealResult').checked=true;
	}
}
function getParam(ElementId) {
    var value = document.getElementById(ElementId).value;
    if (value == "") value = undefined;
    return value;
}