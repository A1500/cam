
  
function init() {
	//L5.DatasetMgr.lookup("ds").load();	
	//L5.QuickTips.init();
};


function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){		
	ds.setParameter("BPT_COUNT_RETIRED_SOLDIER.RETIRED_NO@=",getParam("retiredNo"));		
	ds.setParameter("BPT_COUNT_RETIRED_SOLDIER.CONSCRIPT_DATE@=",getParam("conscriptDate"));		
	ds.setParameter("BPT_COUNT_RETIRED_SOLDIER.DECRUITMENT_DATE@=",getParam("decruitmentDate"));		
	ds.setParameter("BPT_COUNT_RETIRED_SOLDIER.SOLDIER_START_END_DATE@=",getParam("soldierStartEndDate"));		
	ds.setParameter("BPT_COUNT_RETIRED_SOLDIER.SOLDIER_YEARS@=",getParam("soldierYears"));		
	ds.setParameter("BPT_COUNT_RETIRED_SOLDIER.FORCES_NAME@=",getParam("forcesName"));		
	ds.setParameter("BPT_COUNT_RETIRED_SOLDIER.FORCES_NO@=",getParam("forcesNo"));		
	ds.setParameter("BPT_COUNT_RETIRED_SOLDIER.LIFE_STATE@=",getParam("lifeState"));		
	ds.setParameter("BPT_COUNT_RETIRED_SOLDIER.FAMILY_NUM@=",getParam("familyNum"));		
	ds.setParameter("BPT_COUNT_RETIRED_SOLDIER.YOUNG_NUM@=",getParam("youngNum"));		
	ds.setParameter("BPT_COUNT_RETIRED_SOLDIER.OLD_NUM@=",getParam("oldNum"));		
	ds.setParameter("BPT_COUNT_RETIRED_SOLDIER.IS_ORPHANFLAG@=",getParam("isOrphanflag"));		
	ds.setParameter("BPT_COUNT_RETIRED_SOLDIER.LABOR_ABILITY@=",getParam("laborAbility"));		
	ds.setParameter("BPT_COUNT_RETIRED_SOLDIER.IS_OTHER_BPTOBJECT@=",getParam("isOtherBptobject"));		
	ds.setParameter("BPT_COUNT_RETIRED_SOLDIER.OBJECT_TYPE@=",getParam("objectType"));		
	ds.setParameter("BPT_COUNT_RETIRED_SOLDIER.IS_GUARANT@=",getParam("isGuarant"));		
	ds.setParameter("BPT_COUNT_RETIRED_SOLDIER.IS_FIVE_GUARANT@=",getParam("isFiveGuarant"));		
	ds.setParameter("BPT_COUNT_RETIRED_SOLDIER.IDENTITY_BASIS@=",getParam("identityBasis"));		
	ds.load();
}

function insert() {
	var Grid = L5.getCmp('editGridPanel');
	Grid.stopEditing();
	ds.newRecord();	

}

function del() {
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
				delIds[i]=selected[i].get("peopleId");
			}
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCountRetiredSoldierCommand");
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
function save() {
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	var isValidate = ds.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCountRetiredSoldierCommand");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		ds.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function reset() {
	ds.rejectChanges();
}


