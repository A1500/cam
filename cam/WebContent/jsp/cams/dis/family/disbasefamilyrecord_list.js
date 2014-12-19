function init() {
	L5.DatasetMgr.lookup("ds").load();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	
	ds.setParameter("DIS_BASE_FAMILY_RECORD.RECORD_ID@=",getParam("recordId"));		
	ds.setParameter("DIS_BASE_FAMILY_RECORD.ORGAN_CODE@=",getParam("organCode"));		
	ds.setParameter("DIS_BASE_FAMILY_RECORD.ORGAN_NAME@=",getParam("organName"));		
	ds.setParameter("DIS_BASE_FAMILY_RECORD.TOWN_CODE@=",getParam("townCode"));		
	ds.setParameter("DIS_BASE_FAMILY_RECORD.VILLIAGE_CODE@=",getParam("villiageCode"));		
	ds.setParameter("DIS_BASE_FAMILY_RECORD.NAME@=",getParam("name"));		
	ds.setParameter("DIS_BASE_FAMILY_RECORD.ID_CARD@=",getParam("idCard"));		
	ds.setParameter("DIS_BASE_FAMILY_RECORD.FAMILY_NUM@=",getParam("familyNum"));		
	ds.setParameter("DIS_BASE_FAMILY_RECORD.FAMILY_TYPE@=",getParam("familyType"));		
	ds.setParameter("DIS_BASE_FAMILY_RECORD.FAMILY_REGISTER@=",getParam("familyRegister"));		
	ds.setParameter("DIS_BASE_FAMILY_RECORD.HOUSE_COUNT@=",getParam("houseCount"));		
	ds.setParameter("DIS_BASE_FAMILY_RECORD.HOUSE_STRUCTURE@=",getParam("houseStructure"));		
	ds.load();
}

function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/dis/family/disbasefamilyrecord_edit.jsp';
	var text = '增加DIS_BASE_FAMILY_RECORD';
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
	data.put("dataBean",selected[0].get('recordId'));
	var url='jsp/cams/dis/family/disbasefamilyrecord_edit.jsp';
	var text = '修改DIS_BASE_FAMILY_RECORD';
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
				delIds[i]=selected[i].get("recordId");
			}
			var command=new L5.Command("com.inspur.cams.dis.base.cmd.DisBaseFamilyRecordCommand");
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



