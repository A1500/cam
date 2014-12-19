function init() {
	ds.setParameter("WEAL_FIT_STATUS.STATUS@=","1");//加载状态正常
	ds.load();
};
function getParam(ElementId){
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	ds.setParameter("WEAL_FIT_STATUS.STATUS@=","1");//加载状态正常
	ds.setParameter("WEAL_FIT_STATUS.SERIAL_NUM@LIKE",getParam("serialNum"));		
	ds.setParameter("WEAL_FIT_STATUS.COMPANY_NAME@LIKE",getParam("companyName"));		
	ds.setParameter("WEAL_FIT_STATUS.LEGAL_PEOPLE@LIKE",getParam("legalPeople"));
	ds.load();
}
function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/welfare/history/fit/fitHistoryEdit.jsp';
	var text = '历史数据采集新增';
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
	data.put("taskCode",selected[0].get('taskCode'));
	var url='jsp/cams/welfare/history/fit/fitHistoryEdit.jsp';
	var text = '历史数据采集修改';
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
			var	taskCode=selected[0].get("taskCode");
			var	fitId=selected[0].get("fitId");
			var command=new L5.Command("com.inspur.cams.welfare.prosthesis.history.cmd.FitHistoryCmd");
			command.setParameter("taskCode", taskCode);
			command.setParameter("fitId", fitId);
			command.execute("deleteFitHistory");
			if (!command.error) {
				L5.Msg.alert('提示',"删除成功!");
			    ds.remove(selected[i]);
				ds.commitChanges();
			}else{
				L5.Msg.alert('提示',"删除时出现错误！"+command.error);
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
	var url='jsp/cams/welfare/history/fit/fitHistoryDetail.jsp';
	var text = '历史数据采集修改';
	L5.forward(url,text,data);
}