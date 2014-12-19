var legalRecord="";
var legalDuties="00012";
var sorgType="J";
var sorgCodeNum="";
var cnNameNum="";
var applyType="";
var dutyId = 0;//初始dutyId
var currentId='';
var president='';//理事长
var peopleType='';
var end=false;
//初始化
function init() {
	L5.getCmp("tab").setActiveTab("1");
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("0");
	
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	somApplyDataSet.setParameter("PROCESS_ID@=", processId);
	somApplyDataSet.load();
	somApplyDataSet.on('load', loadInfo);		
	//过滤流程意见
	opinionSelect.filterBy(function(record, id){
		if("0,1".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	if(method == "yiban" || method == "end"){
		var tab=L5.getCmp("tab");
		var ipinionPanel=L5.getCmp("ipinionPanel");
		tab.remove(ipinionPanel);
	}
}
function loadInfo(){
	sorgId = somApplyDataSet.get('sorgId');
	taskCode = somApplyDataSet.get('taskCode');
	somApplyDataSet.set("curActivity", "通知申请人");
	somApplyDataSet.set("curOpinionId",'1');
	var somFlowQuery=L5.DatasetMgr.lookup("somFlowQuery");
	somFlowQuery.setParameter("TASK_CODE@=",taskCode);
	somFlowQuery.setParameter("ACTIVITY@=","批准");
	somFlowQuery.setParameter("OPINION_ID@=","1");
	somFlowQuery.load();
	somFlowQuery.on('load',function (ds){
		if(ds.getCount()==0){
			somApplyDataSet.getCurrent().set("curOpinionId","0");
			if(document.getElementById("curOpinionId")){
				document.getElementById("curOpinionId").disabled="disabled";
			}
			end=true;
		}else if(ds.getCount()==1){
			somApplyDataSet.getCurrent().set("curOpinionId","1");
			if(document.getElementById("curOpinionId")){
				document.getElementById("curOpinionId").disabled="disabled";
			}
		}
	});
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	
	somFlowDataSet.setParameter("TASK_CODE@=", taskCode);
	somFlowDataSet.load();	
	
}


//全部保存
function save(){
	//意见校验
	var somApplyValidate = somApplyDataSet.isValidate();
	if(somApplyValidate != true){
		L5.Msg.alert("提示",somApplyValidate);
		L5.getCmp("tab").setActiveTab("5");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBuildCmd");
	//业务意见
	var somApplyRecord = somApplyDataSet.getCurrent();
	somApplyRecord.set("taskCode",taskCode);
	command.setParameter("somApplyRecord",somApplyRecord);
	//保存
	command.execute("updateApply");
	if (!command.error) {
		L5.Msg.alert('提示','保存成功！',function(){
			returnClick();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
				
}
//保存并提交
function submit(){
	
	//意见校验
	var somApplyValidate = somApplyDataSet.isValidate();
	if(somApplyValidate != true){
		L5.Msg.alert("提示",somApplyValidate);
		L5.getCmp("tab").setActiveTab("5");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBuildCmd");
	//业务意见
	var somApplyRecord = somApplyDataSet.getCurrent();
	somApplyRecord.set("taskCode",taskCode);
	command.setParameter("somApplyRecord",somApplyRecord);
	//保存
	command.execute("send");
	if (!command.error) {
		if( end){//是发证环节流程结束
			L5.Msg.alert("提示","成功结束流程!",function(){
				returnClick();
			});
		}else{
			L5.Msg.alert("提示","成功提交至下一环节!",function(){
				returnClick();
			});
		}
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
//打印不予受理通知
function printNoAccept(){
	var url=rootPath+"/jsp/cams/sorg/comm/print/noAcceptForPrint.jsp?sorgType=J";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&printPeople="+currentUserName;	
	window.open(url);
}
//打印受理通知
function printAccept(){
	var url=rootPath+"/jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=J";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&printPeople="+currentUserName;	
	window.open(url);
}
//打印一次性补正材料通知
function sendForPolishing(){

}
//返回
function returnClick(){
	history.go(-1);
}
