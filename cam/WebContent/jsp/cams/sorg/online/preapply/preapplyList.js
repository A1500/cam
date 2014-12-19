function init(){
	applyTypeDataset.setParameter("filterSql", "code like '"+startString+"'");

	applyTypeDataset.load();
	somApplyDataSet.setParameter("CREATE_ORGAN",morgArea);
	somApplyDataSet.setParameter("SORG_TYPE",sorgType);
	somApplyDataSet.setParameter("ONLINE_STATUS","1");
	somApplyDataSet.load();
	somApplyYiBanDataSet.setParameter("CREATE_ORGAN",morgArea);
	somApplyYiBanDataSet.setParameter("SORG_TYPE",sorgType);
	somApplyYiBanDataSet.load();
	//交换状态过滤，只保留已提交和退回
	onlineStatusDataSet.filterBy(function(record, id){
		if("1".indexOf(record.get('value'))>-1){
			return record;
		}
		if("2".indexOf(record.get('value'))>-1){
			return record;
		}
	});
}
function back(){
	history.go(-1);
}
function queryItem(){
	var cnName=_$("cnName");
	var taskCode=_$("taskCode");
	var applyType = _$("applyType");
	var onlineStatus = _$("onlineStatus");
	var  sorgCode = _$("sorgCode");
	/*
	if(cnName=="" && taskCode==""){
		L5.Msg.alert("提示","请至少输入基金会名称或受理编号!");
		return false;
	}
	*/
	somApplyDataSet.setParameter("TASK_CODE",taskCode);
	somApplyDataSet.setParameter("SORG_NAME","%"+cnName+"%");
	//somOrganDataset.setParameter("CN_NAME@like",_$("sorgName"));
	somApplyDataSet.setParameter("CREATE_ORGAN",morgArea);
	somApplyDataSet.setParameter("SORG_TYPE",sorgType);
	somApplyDataSet.setParameter("APPLY_TYPE",applyType);
	somApplyDataSet.setParameter("ONLINE_STATUS",onlineStatus);
	somApplyDataSet.setParameter("SORG_CODE",sorgCode);
	somApplyDataSet.load();
}
function queryItemYiBan(){
	var cnName=_$("cnNameY");
	var taskCode=_$("taskCodeY");
	var applyType = _$("applyTypeY");
		var  sorgCode = _$("sorgCodeY");
	/*
	if(cnName=="" && taskCode==""){
		L5.Msg.alert("提示","请至少输入基金会名称或受理编号!");
		return false;
	}
	*/
	somApplyYiBanDataSet.setParameter("TASK_CODE",taskCode);
	somApplyYiBanDataSet.setParameter("SORG_NAME","%"+cnName+"%");
	somApplyYiBanDataSet.setParameter("CREATE_ORGAN",morgArea);
	somApplyYiBanDataSet.setParameter("SORG_TYPE",sorgType);
	somApplyYiBanDataSet.setParameter("APPLY_TYPE",applyType);
	somApplyYiBanDataSet.setParameter("SORG_CODE",sorgCode);
	somApplyYiBanDataSet.load();
}
function detail(){
	var grid=L5.getCmp("preGrid");
	var selected = grid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert("提示",errorMsg);
		return false;
	}
	var record=selected[0];
	if(record.get("ONLINE_STATUS")!="1"){
		L5.Msg.alert("提示","该业务已经受理，不能重复受理!");
		return false;
	}
	var data=new L5.Map();
	data.put('taskCode',record.get("TASK_CODE"));
	var url='';
	var applyType = record.get("APPLY_TYPE");
	if( applyType == '000' ){
		url='jsp/cams/sorg/online/preapply/group/nameApproval/groupnameApprovalPre.jsp';
	}else if( applyType == '001' ){
		url='jsp/cams/sorg/online/preapply/group/prepare/groupPreparePre.jsp';
	}else if( applyType == '002' ){
		url='jsp/cams/sorg/online/preapply/group/mainBuild/groupBuildPre.jsp';
	}else if( applyType == '003' ){
		url='jsp/cams/sorg/online/preapply/group/change/groupChangePre.jsp';
	}else if( applyType == '004' ){
		url='jsp/cams/sorg/online/preapply/group/cancel/groupCancelPre.jsp';
	}else if( applyType == '005' ){
		url='jsp/cams/sorg/online/preapply/group/branchBuild/groupBranchBuildPre.jsp';
	}else if( applyType == '006' ){
		url='jsp/cams/sorg/online/preapply/group/branchChange/groupBranchChangePre.jsp';
	}else if( applyType == '007' ){
		url='jsp/cams/sorg/online/preapply/group/branchCancel/groupBranchCancelPre.jsp';
	}else if( applyType == '008' ){
		url='jsp/cams/sorg/online/preapply/group/rule/groupRulePre.jsp';
	}else if( applyType == '009' ){
		url='jsp/cams/sorg/online/preapply/group/election/groupElectionPre.jsp';
	}else if( applyType == '032' ){
		url='jsp/cams/sorg/online/preapply/group/delayElection/groupDelayElectionPre.jsp';
	}else if( applyType == '017' ){
		url='jsp/cams/sorg/online/preapply/group/managePeople/groupManagePeoplePre.jsp';
	}else if( applyType == '033' ){
		url='jsp/cams/sorg/online/preapply/group/peopleCentre/groupPeopleCentrePre.jsp';
	}else if( applyType == '016' ){
		url='jsp/cams/sorg/online/preapply/group/fee/groupFeePre.jsp';
	}

	 else if( applyType == '200' ){
		url='jsp/cams/sorg/online/preapply/fund/nameApproval/fundNameAppPre.jsp';
	}else if( applyType == '201' ){
		url='jsp/cams/sorg/online/preapply/fund/mainBuild/fundBuildPre.jsp';
	}else if( applyType == '202' ){
		url='jsp/cams/sorg/online/preapply/fund/change/fundChangePre.jsp';
	}else if( applyType == '203' ){
		url='jsp/cams/sorg/online/preapply/fund/cancel/fundCancelPre.jsp';
	}else if( applyType == '204' ){
		url='jsp/cams/sorg/online/preapply/fund/branchBuild/fundBranchBuildPre.jsp';
	}else if( applyType == '205' ){
		url='jsp/cams/sorg/online/preapply/fund/branchChange/fundBranchChangePre.jsp';
	}else if( applyType == '206' ){
		url='jsp/cams/sorg/online/preapply/fund/branchCancel/fundBranchCancelPre.jsp';
	}else if( applyType == '208' ){
		url='jsp/cams/sorg/online/preapply/fund/rule/fundRulePre.jsp';
	}else if( applyType == '209' ){
		url='jsp/cams/sorg/online/preapply/fund/election/fundElectionPre.jsp';
	}else if( applyType == '234' ){
		url='jsp/cams/sorg/online/preapply/fund/delayElection/fundDelayElectionPre.jsp';
	}else if( applyType == '224' ){
		url='jsp/cams/sorg/online/preapply/fund/managePeople/fundManPeoplePre.jsp';
	}else if( applyType == '235' ){
		url='jsp/cams/sorg/online/preapply/fund/peopleCentre/fundPeopleCentrePre.jsp';
	}


	 else if( applyType == '100' ){
		url='jsp/cams/sorg/online/preapply/ungov/nameApproval/ungovNameApprovalPre.jsp';
	}else if( applyType == '101' ){
		url='jsp/cams/sorg/online/preapply/ungov/buildLegal/ungovBuildLegalPre.jsp';
	}else if( applyType == '102' ){
		url='jsp/cams/sorg/online/preapply/ungov/change/ungovChangePre.jsp';
	}else if( applyType == '103' ){
		url='jsp/cams/sorg/online/preapply/ungov/cancel/ungovCancelPre.jsp';
	}else if( applyType == '106' ){
		url='jsp/cams/sorg/online/preapply/ungov/buildIndividual/ungovBuildIndividualPre.jsp';
	}else if( applyType == '105' ){
		url='jsp/cams/sorg/online/preapply/ungov/buildPartner/ungovBuildPartnerPre.jsp';
	}else if( applyType == '108' ){
		url='jsp/cams/sorg/online/preapply/ungov/rule/ungovRulePre.jsp';
	}
	text='';
	L5.forward(url,text,data);
}