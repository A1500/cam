
function init() {
		
/*		if (method==null||method==""){
			L5.Msg.alert('提示',"未知的页面命令!");
			back();
			}
		else if (method=="UPDATE"){
			document.getElementById("peopleId").readOnly=true;
			BaseinfoPeopleDataSet.baseParams["PEOPLE_ID@="]=idField;
			BaseinfoPeopleDataSet.on("load",getValue);
			BaseinfoPeopleDataSet.load();
				
				var BptPeopleDisabilityDataSet=L5.DatasetMgr.lookup("BptPeopleDisabilityDataSet");
			
		}
		function getValue() {
			//如果起先数据为空，则直接调用增加方法
			if(BaseinfoPeopleDataSet.getCount()==0){
				BaseinfoPeopleDataSet.newRecord();
				BptPeopleDisabilityDataSet.newRecord();
				return;
			}
			
				BptPeopleDisabilityDataSet.baseParams["PEOPLE_ID@="] = idField;
				BptPeopleDisabilityDataSet.load();
			
		}
		var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
		BaseinfoPeopleDataSet.load();
		var BaseinfoFamilyDataSet = L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
		BaseinfoFamilyDataSet.load();*/
		L5.QuickTips.init(); 
}
