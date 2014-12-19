function init(){
	somApplyDataSet.setParameter("SORG_TYPE","J");
	somApplyDataSet.setParameter("APPLY_TYPE",applyType);
	somApplyDataSet.setParameter("CREATE_PERSON",userId);
	somApplyDataSet.setParameter("CREATE_ORGAN",morgArea);
	somApplyDataSet.setParameter("DATA_SOURCE","ONLINE");
	somApplyDataSet.load();
	somApplyDataSet.on('load',function(){
		somApplyDataSet.filterBy(function(record, id){
				if(record.get('onlineStatus')!="9"){
					return record;
				}
		});
	});
	L5.QuickTips.init();
}
function insert(){
	var data=new L5.Map();
	data.put("method","INSERT");
	url="jsp/ext/somsd/manage/apply/fund/change/fundChangeEdit.jsp";
	L5.forward(url,'',data);	
}
function update(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(records[0].get("onlineStatus") == "1"){
		L5.Msg.alert("提示","该业务已经提交，不能修改!");
		return;
	}
	var data=new L5.Map();
	data.put("method","UPDATE");
	data.put("sorgId",records[0].get('sorgId'));
	data.put("taskCode",records[0].get('taskCode'));
	var url='';
	url="jsp/ext/somsd/manage/apply/fund/change/fundChangeEdit.jsp";
	L5.forward(url,'',data);	
}
function detail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var data=new L5.Map();
	data.put("sorgId",records[0].get('sorgId'));
	data.put("taskCode",records[0].get('taskCode'));
	var url='';
	url="jsp/ext/somsd/manage/apply/fund/change/fundChangeDetail.jsp";
	L5.forward(url,'',data);	
}
//打印
function printList(){
var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	 taskCode=records[0].get('taskCode');
	 sorgId=records[0].get('sorgId');
var win=L5.getCmp("printItemWin");
		win.show();
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.setParameter("TASK_CODE@=",taskCode);
	somChangeList.load();
}
function printItem(){
	var heldGrid=L5.getCmp("heldGrid");
	var records=heldGrid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var id=records[0].get('id');
		var url=L5.webPath+"/jsp/ext/somsd/manage/printWord/fund/jsp/mainChange/changeApply.jsp?id="+id+"&sorgId="+sorgId+"&taskCode="+taskCode;
		window.open(url);
}