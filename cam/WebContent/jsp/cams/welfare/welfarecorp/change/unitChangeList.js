function init() {
	var ds = L5.DatasetMgr.lookup("ds");
	ds.setParameter("WEAL_FIT_CHANGERECORD.CORPORATION_TYPE@=","2");	
	ds.setParameter("WEAL_FIT_CHANGERECORD.MORG_AREA@LIKE",organCode+"%");
	ds.setParameter("sort","REG_DATE desc,MORG_AREA");
	ds.load();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	ds.setParameter("WEAL_FIT_CHANGERECORD.SERIAL_NUM@=",getParam("serialNumQuery"));		
	ds.setParameter("WEAL_FIT_CHANGERECORD.COMPANY_NAME@LIKE",getParam("companyNameQuery"));		
	ds.setParameter("WEAL_FIT_CHANGERECORD.LINKMAN@=",getParam("linkmanQuery"));		
	ds.setParameter("WEAL_FIT_CHANGERECORD.LEGAL_PEOPLE@=",getParam("legalPeopleQuery"));
	ds.setParameter("WEAL_FIT_CHANGERECORD.CORPORATION_TYPE@=","2");	
	ds.setParameter("WEAL_FIT_CHANGERECORD.MORG_AREA@LIKE",organCode+"%");
	ds.setParameter("sort","REG_DATE desc,MORG_AREA");
	ds.load();
}

function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/welfare/welfarecorp/change/unitChangeEdit.jsp';
	var text = '增加变更';
	L5.forward(url,text,data);
}

function update(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	if(selected[0].get("ifConfirm")=="1"){
		L5.Msg.alert('提示',"此记录已经变更,不可修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("taskCode",selected[0].get('taskCode'));
	data.put("changId",selected[0].get('changId'));
	data.put("serialNum",selected[0].get('serialNum'));
	var url='jsp/cams/welfare/welfarecorp/change/unitChangeEdit.jsp';
	var text = '修改变更';
	L5.forward(url,text,data);
}
function submit(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	if(selected[0].get("ifConfirm")=="1"){
		L5.Msg.alert('提示',"此记录已经变更,不可重复变更!");
		return false;
	}
	var changeRecord=ds.getCurrent();
	L5.MessageBox.confirm('确定', '确定要变更选中的记录吗?',function(state){
		if(state=="yes"){
			var command = new L5.Command("com.inspur.cams.welfare.welfarecorp.change.cmd.UnitChangeCmd");
			command.setParameter("changeRecord", changeRecord);
			command.execute("submitUnitChange");
			if (!command.error) {
				L5.Msg.alert('提示',"变更成功！");
				init();
			}else{
				L5.Msg.alert('提示',"保存变更时出现错误！"+command.error);
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
	data.put("taskCode",selected[0].get('taskCode'));
	data.put("changId",selected[0].get('changId'));
	var url='jsp/cams/welfare/welfarecorp/change/unitChangeDetail.jsp';
	var text = '查看变更';
	L5.forward(url,text,data);
}



