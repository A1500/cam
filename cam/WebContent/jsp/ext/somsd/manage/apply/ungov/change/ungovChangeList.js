var taskCode;
var sorgId;
function init(){
	somApplyDataSet.setParameter("SORG_TYPE","M");
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
	url="jsp/ext/somsd/manage/apply/ungov/change/ungovChangeEdit.jsp";
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
	url="jsp/ext/somsd/manage/apply/ungov/change/ungovChangeEdit.jsp";
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
	url="jsp/ext/somsd/manage/apply/ungov/change/ungovChangeDetail.jsp";
	L5.forward(url,'',data);	
}

// 受理页面
function forAccept(){
	L5.getCmp('winSorg').show();
	
}
function enter(){
	var url='jsp/ext/somsd/manage/apply/ungov/change/ungovChangeEdit.jsp?method=INSERT';
	L5.forward(url);
}
function closeWinSorg(){
	L5.getCmp('winSorg').hide();
}

//打印按钮
function printWord(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	taskCode=records[0].get('taskCode');
	sorgId = records[0].get('sorgId');
	var winPrint = L5.getCmp("winPrint");
	winPrint.show();
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	somChangeList.setParameter("TASK_CODE@=",records[0].get('taskCode'));
	somChangeList.load();
}

//确定按钮(window)
function printSelect(){
	var changePrint = L5.getCmp("changePrint");
	var records = changePrint.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var id = records[0].get("id");
	var url=L5.webPath+"/jsp/ext/somsd/manage/printWord/ungov/jsp/change/ungovChangeWord.jsp?taskCode="+taskCode+"&sorgId="+sorgId+"&id="+id;//id为选中行的主键
	window.open(url);
}
//取消按钮(window)
function printUndo(){
	var winPrint = L5.getCmp("winPrint");
	winPrint.hide();
}









