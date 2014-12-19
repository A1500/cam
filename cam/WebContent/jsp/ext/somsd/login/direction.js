function menuClick(title,applyType){
	//社团年检
	if(applyType == '014'){
		var url='jsp/ext/somsd/manage/check/group/somchecktask/somchecktask_list.jsp';	
	}
	if(applyType == '015'){
		var url='jsp/ext/somsd/manage/partyCheck/partychecktask/partychecktask_list.jsp';	
	}
	//基金会年检
	if(applyType == '214'){
		var url='jsp/ext/somsd/manage/check/fund/somchecktask/somchecktask_list.jsp';	
	}
	//民办非年检
	if(applyType == '114'){
		var url='jsp/ext/somsd/manage/check/ungov/somchecktask/somchecktask_list.jsp';	
	}
	/**
	 * 社会团体
	 */
	if(applyType == '000'){
		var url='jsp/ext/somsd/manage/apply/group/nameApproval/groupNameApprovaList.jsp';	
	}
	if(applyType == '001'){
		var url='jsp/ext/somsd/manage/apply/group/prepare/groupPrepareList.jsp';	
	}
	if(applyType == '002'){
		var url='jsp/ext/somsd/manage/apply/group/mainbuild/groupBuildList.jsp';	
	}
	if(applyType == '003'){
		var url='jsp/ext/somsd/manage/apply/group/change/groupChangeList.jsp';	
	}
	if(applyType == '004'){
		var url='jsp/ext/somsd/manage/apply/group/cancel/groupCancelList.jsp';	
	}
	if(applyType == '005'){
		var url='jsp/ext/somsd/manage/apply/group/branchBuild/groupBranchBuildList.jsp';	
	}
	if(applyType == '006'){
		var url='jsp/ext/somsd/manage/apply/group/branchChange/groupBranchChangeList.jsp';	
	}
	if(applyType == '007'){
		var url='jsp/ext/somsd/manage/apply/group/branchCancel/groupBranchCancelList.jsp';	
	}
	if(applyType == '008'){
		var url='jsp/ext/somsd/manage/apply/group/rule/groupRuleList.jsp';	
	}
	if(applyType == '009'){
		var url='jsp/ext/somsd/manage/apply/group/election/groupElectionList.jsp';	
	}
	if(applyType == '032'){
		var url='jsp/ext/somsd/manage/apply/group/delayElection/groupDelayElectionList.jsp';	
	}
	if(applyType == '017'){
		var url='jsp/ext/somsd/manage/apply/group/managePeople/groupManagePeopleList.jsp';	
	}
	if(applyType == '016'){
		var url='jsp/ext/somsd/manage/apply/group/fee/groupFeeExtList.jsp';	
	}
	if(applyType == '033'){
		var url='jsp/ext/somsd/manage/apply/group/peopleCentre/groupPeopleCentreList.jsp';	
	}
	
	
	/**
	 * 基金会
	 */
	if(applyType == '200'){//基金会申请名称核准
		var url='jsp/ext/somsd/manage/apply/fund/nameApproval/fundNameApprovaList.jsp';	
	}
	if(applyType == '201'){//基金会设立登记
		var url='jsp/ext/somsd/manage/apply/fund/mainbuild/fundBuildList.jsp';	
	}
	if(applyType == '202'){//基金会变更登记
		var url='jsp/ext/somsd/manage/apply/fund/change/fundChangeList.jsp';	
	}
	if(applyType == '203'){//基金会注销登记
		var url='jsp/ext/somsd/manage/apply/fund/cancel/fundCancelList.jsp';	
	}
	if(applyType == '204'){//基金会分支（代表）机构设立登记
		var url='jsp/ext/somsd/manage/apply/fund/branchBuild/fundBranchBuildList.jsp';	
	}
	if(applyType == '205'){//基金会分支（代表）机构变更登记
		var url='jsp/ext/somsd/manage/apply/fund/branchChange/fundBranchChangeList.jsp';	
	}
	if(applyType == '206'){//基金会分支（代表）机构注销登记
		var url='jsp/ext/somsd/manage/apply/fund/branchCancel/fundBranchCancelList.jsp';	
	}
	if(applyType == '208'){//基金会章程核准
		var url='jsp/ext/somsd/manage/apply/fund/rule/fundRuleList.jsp';
	}
	if(applyType == '209'){//基金会换届审批
		var url='jsp/ext/somsd/manage/apply/fund/election/fundElectionList.jsp';	
	}
	if(applyType == '234'){//基金会延期换届选举报批
		var url='jsp/ext/somsd/manage/apply/fund/electionDelay/fundElectionDelayList.jsp';	
	}
	if(applyType == '224'){//基金会负责人换届备案
		var url='jsp/ext/somsd/manage/apply/fund/managePeople/fundManPeopleList.jsp';	
	}
	if(applyType == '235'){
		var url='jsp/ext/somsd/manage/apply/fund/peopleCentre/fundPeopleCentreList.jsp';	
	}
	/**
	 * 民办非企业
	 */
	if(applyType == '100'){
		var url='jsp/ext/somsd/manage/apply/ungov/nameApproval/ungovNameApprovalList.jsp';	
	}
	if(applyType == '101'){
		var url='jsp/ext/somsd/manage/apply/ungov/buildLegal/ungovBuildLegalList.jsp';	
	}
	if(applyType == '105'){
		var url='jsp/ext/somsd/manage/apply/ungov/buildPartner/ungovBuildPartnerList.jsp';	
	}
	if(applyType == '106'){
		var url='jsp/ext/somsd/manage/apply/ungov/buildIndividual/ungovBuildIndividualList.jsp';	
	}
	if(applyType == '102'){
		var url='jsp/ext/somsd/manage/apply/ungov/change/ungovChangeList.jsp';	
	}
	if(applyType == '103'){
		var url='jsp/ext/somsd/manage/apply/ungov/cancel/ungovCancelList.jsp';	
	}
	if(applyType == '108'){
		var url='jsp/ext/somsd/manage/apply/ungov/rule/ungovRuleList.jsp';	
	}
	loadPage(title,url);
}