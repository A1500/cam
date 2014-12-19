var taskCode;
var sorgId;
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
	url="jsp/ext/somsd/manage/apply/group/managePeople/groupManagePeopleEdit.jsp";
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
	url="jsp/ext/somsd/manage/apply/group/managePeople/groupManagePeopleEdit.jsp";
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
	url="jsp/ext/somsd/manage/apply/group/managePeople/groupManagePeopleDetail.jsp";
	L5.forward(url,'',data);	
}

function enter(){
	var sorgType=document.getElementById('sorgType').value;
	var url='jsp/ext/somsd/manage/apply/group/managePeople/groupManagePeopleEdit.jsp?method=INSERT&sorgType='+sorgType;
	L5.forward(url);
}
function closeWinSorg(){
	L5.getCmp('winSorg').hide();
}
//负责人打印列表
function printWord(){
var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	 taskCode=records[0].get('taskCode');
	 sorgId=records[0].get('sorgId');
	var win=L5.getCmp("printHeldWin");
		win.show();
	var ds=L5.DatasetMgr.lookup("somDutyInsertDataSet");
		ds.setParameter("SORG_ID",sorgId);
		ds.setParameter("SORG_DUTIES!=", "00012");
		somDutyInsertDataSet.load();
}
//打印
function printHeld(){
	var heldGrid=L5.getCmp("heldGrid");
	var records=heldGrid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var dutyId=records[0].get('dutyId');

		var url=L5.webPath+"/jsp/ext/somsd/manage/printWord/group/jsp/leaderWord.jsp?dutyId="+dutyId+"&sorgId="+sorgId;
		window.open(url);
}
