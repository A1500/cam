function init() {
	//L5.DatasetMgr.lookup("ds").load();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	
	//ds.setParameter("DIS_RELIEF_INFO.INFO_ID@=",getParam("infoId"));		
	ds.setParameter("DIS_RELIEF_INFO.RECORD_ID@=",getParam("recordId"));		
	ds.setParameter("DIS_RELIEF_INFO.RELIEF_TYPE@=",getParam("reliefType"));		
	/*ds.setParameter("DIS_RELIEF_INFO.REQUIRED_FOR_FOOD@=",getParam("requiredForFood"));		
	ds.setParameter("DIS_RELIEF_INFO.REQUIRED_FOR_CLOTHES@=",getParam("requiredForClothes"));		
	ds.setParameter("DIS_RELIEF_INFO.REQUIRED_FOR_HEAT@=",getParam("requiredForHeat"));		
	ds.setParameter("DIS_RELIEF_INFO.REQUIRED_FOR_DISEASE@=",getParam("requiredForDisease"));		
	ds.setParameter("DIS_RELIEF_INFO.REQUIRED_FOR_OTHERS@=",getParam("requiredForOthers"));		
	ds.setParameter("DIS_RELIEF_INFO.DAMAGE_TIME@=",getParam("damageTime"));		
	ds.setParameter("DIS_RELIEF_INFO.DISASTER_TYPE@=",getParam("disasterType"));		
	ds.setParameter("DIS_RELIEF_INFO.COLLAPSED_HOUSE@=",getParam("collapsedHouse"));		
	ds.setParameter("DIS_RELIEF_INFO.SERIOUS_DAMAGE_HOUSE@=",getParam("seriousDamageHouse"));		
	ds.setParameter("DIS_RELIEF_INFO.GENERAL_DAMAGE_HOUSE@=",getParam("generalDamageHouse"));		
	ds.setParameter("DIS_RELIEF_INFO.REBUILD_HOUSE@=",getParam("rebuildHouse"));		
	ds.setParameter("DIS_RELIEF_INFO.REPAIRED_HOUSE@=",getParam("repairedHouse"));		
	ds.setParameter("DIS_RELIEF_INFO.DEAD_NAME@=",getParam("deadName"));		
	ds.setParameter("DIS_RELIEF_INFO.DEAD_SEX@=",getParam("deadSex"));		
	ds.setParameter("DIS_RELIEF_INFO.DEAD_AGE@=",getParam("deadAge"));		
	ds.setParameter("DIS_RELIEF_INFO.DEAD_FOLK@=",getParam("deadFolk"));		
	ds.setParameter("DIS_RELIEF_INFO.DEAD_POPULACE@=",getParam("deadPopulace"));		
	ds.setParameter("DIS_RELIEF_INFO.DEAD_MISSING_PLACE@=",getParam("deadMissingPlace"));		
	ds.setParameter("DIS_RELIEF_INFO.DEAD_MISSING_TIME@=",getParam("deadMissingTime"));		
	ds.setParameter("DIS_RELIEF_INFO.DEAD_MISSING_REASON@=",getParam("deadMissingReason"));		
	ds.setParameter("DIS_RELIEF_INFO.APPROVAL_TIMES@=",getParam("approvalTimes"));		
	ds.setParameter("DIS_RELIEF_INFO.APPROVAL_FOOD@=",getParam("approvalFood"));		
	ds.setParameter("DIS_RELIEF_INFO.APPROVAL_CLOTHES@=",getParam("approvalClothes"));		
	ds.setParameter("DIS_RELIEF_INFO.APPROVAL_REBUILED_HOUSE@=",getParam("approvalRebuiledHouse"));		
	ds.setParameter("DIS_RELIEF_INFO.APPROVAL_REPAIRED_HOUSE@=",getParam("approvalRepairedHouse"));		
	ds.setParameter("DIS_RELIEF_INFO.APPROVAL_MONRY@=",getParam("approvalMonry"));		
	ds.setParameter("DIS_RELIEF_INFO.ACCEPT_PEOPLE_NAME@=",getParam("acceptPeopleName"));		
	ds.setParameter("DIS_RELIEF_INFO.ACCEPT_DATE@=",getParam("acceptDate"));		
	ds.setParameter("DIS_RELIEF_INFO.CHECK_PEOPLE_ORGAN_ID@=",getParam("checkPeopleOrganId"));		
	ds.setParameter("DIS_RELIEF_INFO.CHECK_PEOPLE_NAME@=",getParam("checkPeopleName"));		
	ds.setParameter("DIS_RELIEF_INFO.CHECK_DATE@=",getParam("checkDate"));		
	ds.setParameter("DIS_RELIEF_INFO.AUDIT_PEOPLE_ORGAN_ID@=",getParam("auditPeopleOrganId"));		
	ds.setParameter("DIS_RELIEF_INFO.AUDIT_PEOPLE_NAME@=",getParam("auditPeopleName"));		
	ds.setParameter("DIS_RELIEF_INFO.AUDIT_DATE@=",getParam("auditDate"));		
	ds.setParameter("DIS_RELIEF_INFO.GRANT_PEOPLE_ORGAN_ID@=",getParam("grantPeopleOrganId"));		
	ds.setParameter("DIS_RELIEF_INFO.GRANT_PEOPLE_NAME@=",getParam("grantPeopleName"));		
	ds.setParameter("DIS_RELIEF_INFO.GRANT_TIME@=",getParam("grantTime"));		
	ds.setParameter("DIS_RELIEF_INFO.COMMENT@=",getParam("comment"));		
	ds.setParameter("DIS_RELIEF_INFO.ORGAN_CODE@=",getParam("organCode"));		
	ds.setParameter("DIS_RELIEF_INFO.ORGAN_NAME@=",getParam("organName"));		
	ds.setParameter("DIS_RELIEF_INFO.WORKFLOW_STATUS@=",getParam("workflowStatus"));		
	ds.setParameter("DIS_RELIEF_INFO.WORKFLOW_RECEIVE_ORGAN@=",getParam("workflowReceiveOrgan"));		
	**/
	ds.load();
}

function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/dis/assistance/dc_info/dc_info_edit.jsp';
	var text = '增加DIS_RELIEF_INFO';
	L5.forward(url,text,data);

}

function update(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("dataBean",selected[0].get('infoId'));
	var url='jsp/cams/dis/assistance/dc_info/dc_info_edit.jsp';
	var text = '修改DIS_RELIEF_INFO';
	L5.forward(url,text,data);
}

function del(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("infoId");
			}
			var command=new L5.Command("com.inspur.cams.dis.base.cmd.DisReliefInfoCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	ds.remove(selected[i]);
				}
				ds.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}

function detail(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","DETAIL");
	data.put("dataBean",selected[0].get('infoId'));
	var url='jsp/cams/dis/assistance/dc_info/dc_info_detail.jsp';
	var text = '查看明细DIS_RELIEF_INFO';
	L5.forward(url,text,data);
}

