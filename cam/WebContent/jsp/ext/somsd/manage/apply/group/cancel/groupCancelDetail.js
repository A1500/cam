var applyType="004";
function init() {
		somOrganDataSet.setParameter("SORG_ID",sorgId);
		somOrganDataSet.load();
		somApplyDataSet.setParameter("TASK_CODE", taskCode);
		somApplyDataSet.load();
		//加载社会组织清算组织人员信息
		somLiqpeopleDataSet.setParameter("SORG_ID@=",sorgId);
		somLiqpeopleDataSet.load();
		//加载电子档案
		somElectronicDataSet_load();
}
//返回
function goBack(){
		history.go(-1);
}

//关闭添加清算组织成员
function closeWinLiqpeople(){
	var win = L5.getCmp("winLiqpeople");
	win.setVisible(false);
}
