function init() {
	var ds = L5.DatasetMgr.lookup("ds");	
	ds.setParameter("STANDARDS_COUNTIES",organCode);
	ds.setParameter("START_DATE",startDate);
	ds.setParameter("TYPE","94");
	ds.load();
	ds.on("load",function(){
		document.getElementById("startDate").disabled = true;
		document.getElementById("dateSelect").disabled = true;
		if(ds.getCount()>0){ //加载时计算出年合计
			var records = ds.getAllRecords();
			var subTotal = [];
			var yearTotal = [];
			for(var j=0;j<records.length;j++){
				yearTotal[j] = parseFloat((records[j].get("provinceStandard")=='')?'0':records[j].get("provinceStandard"))+
							   parseFloat((records[j].get("oldLonelyMon")=='')?'0':records[j].get("oldLonelyMon"))+
							   parseFloat((records[j].get("otherSubsidyOne")=='')?'0':records[j].get("otherSubsidyOne"))+
							   parseFloat((records[j].get("otherSubsidyTwo")=='')?'0':records[j].get("otherSubsidyTwo"))+
							   parseFloat((records[j].get("otherSubsidyThree")=='')?'0':records[j].get("otherSubsidyThree"))+
							   parseFloat((records[j].get("otherSubsidyFour")=='')?'0':records[j].get("otherSubsidyFour"))+
							   parseFloat((records[j].get("otherSubsidyFive")=='')?'0':records[j].get("otherSubsidyFive"));
				records[j].set("yearTotal",yearTotal[j]);
			}
			var startDate = records[0].get("startDate");
			document.getElementById("startDate").value = startDate;
		}
	});
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}

function reset() {
	window.history.go(-1);
}