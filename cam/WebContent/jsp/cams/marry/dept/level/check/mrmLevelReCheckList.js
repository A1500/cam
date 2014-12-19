var deptId;
function init(){
	var infocommand = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
	infocommand.execute("getUserInfo");
	var userLoginId ="";
	if (!infocommand.error) {
		var info = infocommand.getReturn("userInfo");
		userLoginId =info.userLoginName;//通过登录账号查找对应的婚姻登记处。
	}
	
	var commDeptId = new L5.Command("com.inspur.cams.marry.base.cmd.MrmBasePersonCommand");
	commDeptId.setParameter("loginId",userLoginId);
	commDeptId.execute("getDeptId");
	deptId = commDeptId.getReturn("deptId");
	query();
}
//新增业务
function newApply(){	
	var queryDs=L5.DatasetMgr.lookup("queryDs");
	queryDs.setParameter("DEPT_CODE",deptId);
	queryDs.load();
	queryDs.on('load',function(){
		if(queryDs.getCurrent().get("skinValue")=='00'){
			L5.Msg.alert('提示',"当前登记机关无等级，不能申请复核");
			return false;
		}
		var applyQueryDataSet=L5.DatasetMgr.lookup("applyQueryDataSet");
	    applyQueryDataSet.setParameter("ORGAN_CODE@=",deptId);
		applyQueryDataSet.setParameter("CHECK_STATUS@IN","11,21,22,31,32,41,42,52");
		applyQueryDataSet.setParameter("APPLY_TYPE",'2');
	 	applyQueryDataSet.load();
	 	applyQueryDataSet.on("load",function(ds){
	 		if(ds.getCount()>0){
				L5.Msg.alert("提示","存在审核状态为“在审”的申报，不能新增！");
				return false; 			
	 		}
			var data=new L5.Map();
			data.put("method","INSERT");
			var url='jsp/cams/marry/dept/level/check/mrmLevelReCheckInsert.jsp';
			L5.forward(url,"",data);	
		});	
	});
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
	if(checkStatus!=DJC_BC && checkStatus!=QX_TH){
		L5.Msg.alert("提示","正在审核或审核已结束，不能办理！");
		return false;
	}
	var data=new L5.Map();
	data.put("method","UPDATE");
	data.put("applyId",records[0].get("applyId"));
	var url='jsp/cams/marry/dept/level/check/mrmLevelReCheckInsert.jsp';
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
	if(checkStatus!=DJC_BC && checkStatus!=QX_TH){
		L5.Msg.alert("提示","正在审核或审核已结束”，不能删除！");
		return false;
	}
  	L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
		if(sta=="yes"){
			var command = new L5.Command("com.inspur.cams.marry.application.cmd.MrmLevelApplyCmd");
			command.setParameter("applyId",records[0].get('applyId'));
			command.execute("delete");
			if (!command.error) {
				L5.Msg.alert("提示","删除成功！",function(){
					query();
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

function detail(applyId,deptId,applyType){
	var data=new L5.Map();
	data.put("applyId",applyId);
	data.put("deptId",deptId);
	data.put("applyType",applyType);
	var url='jsp/cams/marry/dept/level/check/mrmLevelReCheckDetail.jsp';	
	L5.forward(url,"",data);		
}
function renderCheckStatus(value,c,record){
	if(value==DJC_BC || value==QX_TH){
		return "未提交";
	}else if(value==B_TG){
		return "办结";
	}else if(value==QX_WTG){
		return "区县审核未通过";
	}else if(value==DS_WTG){
		return "市审核未通过";
	}else if(value==S_WTG){
		return "省审核未通过";
	}else if(value==B_WTG){
		return "部审核未通过";
	}else{
		return "在审";
	}
}
//查询
function query(){
	var applyDataSet = L5.DatasetMgr.lookup("applyDataSet");
	applyDataSet.setParameter("ORGAN_CODE@=",deptId);
	applyDataSet.setParameter("CUR_ORGAN_NAME@LIKE",_$("curOrganName"));
	if(_$("checkStatus")){
		applyDataSet.setParameter("CHECK_STATUS@IN",_$("checkStatus"));
	}
	applyDataSet.setParameter("APPLY_TYPE",2);
	applyDataSet.load();
}

function renderTime(value,c,rec){
	return rec.get("applyTime").substring(0,10);
}