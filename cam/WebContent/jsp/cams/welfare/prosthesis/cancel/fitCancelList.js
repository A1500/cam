function init() {
	var ds=L5.DatasetMgr.lookup("ds");
	//根据企业类别加载数据
	ds.setParameter("CORPORATION_TYPE@=","1");
	ds.load();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	ds.setParameter("CORPORATION_TYPE@=","1");
	ds.setParameter("WEAL_FIT_LOGOFF.SERIAL_NUM@=",getParam("serialNumQuery"));		
	ds.setParameter("WEAL_FIT_LOGOFF.COMPANY_NAME@LIKE",getParam("companyNameQuery"));		
	ds.setParameter("WEAL_FIT_LOGOFF.LINKMAN@=",getParam("linkmanQuery"));		
	ds.setParameter("WEAL_FIT_LOGOFF.LOGOFF_DATE@=",getParam("logoffDateQuery"));		
	ds.setParameter("WEAL_FIT_LOGOFF.LEGAL_PEOPLE@=",getParam("legalPeopleQuery"));		
	ds.load();
}

function cancel(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要注销的记录!");
		return false;
	}
	var record=ds.getCurrent();
	if(record.get("ifConfirm")=="1"){
		alert("此记录已经注销,不可重复注销!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要注销选中的记录吗?注销后数据无法恢复（注销前请确认是否已收缴正副本证书）!',function(state){
		if(state=="yes"){
			var command = new L5.Command("com.inspur.cams.welfare.base.cmd.WealFitLogoffCommand");
			command.setParameter("record", record);
			command.execute("prosthesisCancel");
			if (!command.error) {
				alert("注销成功！");	
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}

function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/welfare/prosthesis/cancel/fitCancelEdit.jsp';
	var text = '增加注销';
	L5.forward(url,text,data);

}

function update(){
	var record=ds.getCurrent();
	if(record.get("ifConfirm")=="1"){
		alert("此记录已经注销,不可修改!");
		return false;
	}
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("taskCode",selected[0].get('taskCode'));
	var url='jsp/cams/welfare/prosthesis/cancel/fitCancelEdit.jsp';
	var text = '修改注销';
	L5.forward(url,text,data);
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
	var url='jsp/cams/welfare/prosthesis/cancel/fitCancelDetail.jsp';
	var text = '查看注销';
	L5.forward(url,text,data);
}



