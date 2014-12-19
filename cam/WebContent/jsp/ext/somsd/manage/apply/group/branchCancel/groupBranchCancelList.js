function init(){
	somApplyDataSet.setParameter("SORG_TYPE","S");
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
	url="jsp/ext/somsd/manage/apply/group/branchCancel/groupBranchCancelEdit.jsp";
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
	url="jsp/ext/somsd/manage/apply/group/branchCancel/groupBranchCancelEdit.jsp";
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
	data.put("method","UPDATE");
	data.put("sorgId",records[0].get('sorgId'));
	data.put("taskCode",records[0].get('taskCode'));
	var url='';
	url="jsp/ext/somsd/manage/apply/group/branchCancel/groupBranchCancelDetail.jsp";
	L5.forward(url,'',data);
}
// 受理页面
function forAccept(){
	L5.getCmp('winSorg').show();

}
function enter(){
		if(somApplyDataSet.getCount()>0)
	{
		L5.Msg.alert("提示","只能新增一条记录");
		return;
	}
	var url='jsp/ext/somsd/manage/apply/group/branchCancel/groupBranchCancelEdit.jsp?method=INSERT';
	L5.forward(url);
}
function closeWinSorg(){
	L5.getCmp('winSorg').hide();
}
function printWord(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}


	var taskCode=records[0].get('taskCode');
	var sorgId=records[0].get('sorgId');
	var url=L5.webPath+"/jsp/ext/somsd/manage/printWord/group/jsp/branch/branchCancle.jsp?taskCode="+taskCode+"&sorgId="+sorgId;
	window.open(url);
}