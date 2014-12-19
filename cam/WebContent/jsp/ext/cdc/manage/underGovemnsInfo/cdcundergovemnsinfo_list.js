var qOrganCode;
function init() {
 	var ds =L5.DatasetMgr.lookup("ds");
 	/*
 	if(organLevel=="SQ") {//村居级
		qOrganCode = organCode;
	}else if(organLevel=="JD") {//乡镇街道级
		qOrganCode = organCode.substring(0,9);
	}else if(organLevel=="13") {//区县
		qOrganCode = organCode.substring(0,6);
	}else if(organLevel=="12") {//市
		qOrganCode = organCode.substring(0,4);
	}else if(organLevel=="11"){
		qOrganCode = organCode.substring(0,2);
	}*/
	ds.setParameter("organId", organCode);
	ds.load();
	L5.QuickTips.init();
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	ds.setParameter("ORGAN_CODE@rlike", qOrganCode);
	ds.setParameter("VILLAGE_NAME@like", getParam("villageNameQ"));
	ds.setParameter("ORGAN_NAME@like",getParam("organNameQ"));
	ds.load();
}

function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/ext/cdc/manage/underGovemnsInfo/cdcundergovemnsinfo_edit.jsp';
	var text = '增加下辖村情况进本信息';
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
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcUnderGovemnsInfoCommand");
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
function update(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");//encodeURIComponent(encodeURIComponent(selected[0].get('USER_NAME'))
	data.put("dataBean",selected[0].get('USER_ID'));
	data.put("userName",encodeURIComponent(encodeURIComponent(selected[0].get('USER_NAME'))));
	var url='jsp/ext/cdc/manage/underGovemnsInfo/cdcundergovemnsinfo_edit.jsp';
	var text = '修改下辖村情况进本信息';
	L5.forward(url,text,data);
}
