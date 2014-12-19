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
	url="jsp/ext/somsd/manage/apply/ungov/buildLegal/ungovBuildLegalEdit.jsp";
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
	url="jsp/ext/somsd/manage/apply/ungov/buildLegal/ungovBuildLegalEdit.jsp";
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
	url="jsp/ext/somsd/manage/apply/ungov/buildLegal/ungovBuildLegalDetail.jsp";
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
	var url='jsp/ext/somsd/manage/apply/ungov/buildLegal/ungovBuildLegalEdit.jsp?method=INSERT';
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
	var printListWin = L5.getCmp("printListWin");
	printListWin.show();
}
//确定按钮(window)
function printSelect(){
	var DJSQ = document.getElementById("DJSQ").checked;
	var FRDJ = document.getElementById("FRDJ").checked;
	var NSJG = document.getElementById("NSJG").checked;
	var ZCHZ = document.getElementById("ZCHZ").checked;
	if(DJSQ==true){
		var url=L5.webPath+"/jsp/ext/somsd/manage/printWord/ungov/jsp/buildLegal/ungovBuildLegalWord.jsp?taskCode="+taskCode+"&sorgId="+sorgId;
		window.open(url);
	}else if(FRDJ==true){
		var url=L5.webPath+"/jsp/ext/somsd/manage/printWord/ungov/jsp/buildLegal/ungovLegalWord.jsp?taskCode="+taskCode+"&sorgId="+sorgId;
		window.open(url);
	}else if(NSJG==true){
		//由于内设机构数量不确定，所以有多少个，就打开多少个window(将主键传递过去,title是为html的title用，区别多个打印)
		somOfficeDataSet.setParameter("TASK_CODE",taskCode);
		somOfficeDataSet.load();
		somOfficeDataSet.on("load",function(){
			var officeRecords = somOfficeDataSet.getAllRecords();
			var officeCount = somOfficeDataSet.getCount();
			if(officeCount==0){
				L5.Msg.alert("提示","内设机构数量为0！");
				return false;
			}else if(officeCount>0){
				for(var i=0;i<officeCount;i++){
					var url=L5.webPath+"/jsp/ext/somsd/manage/printWord/ungov/jsp/comm/ungovOfficeWord.jsp?taskCode="+taskCode+"&sorgId="+sorgId+"&id="+officeRecords[i].get("id")+"&title="+officeRecords[i].get("name");
					window.open(url);
				}
			}
		});
	}else if(ZCHZ==true){
		var url=L5.webPath+"/jsp/ext/somsd/manage/printWord/ungov/jsp/rule/ungovRuleWord.jsp?taskCode="+taskCode+"&sorgId="+sorgId;
		window.open(url);
	}
}
//取消按钮(window)
function printUndo(){
	var printListWin = L5.getCmp("printListWin");
	printListWin.hide();
}





