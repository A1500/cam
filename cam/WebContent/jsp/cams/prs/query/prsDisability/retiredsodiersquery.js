function init() {
	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	retiredSoldierDataset.setParameter("xzqh", xzqu);
	retiredSoldierDataset.setParameter("cxsjq", cxsjq);
	retiredSoldierDataset.setParameter("cxsjz", cxsjz);
	retiredSoldierDataset.setParameter("disable", disable);
	retiredSoldierDataset.setParameter("grade", grade);
	retiredSoldierDataset.setParameter("propertie", propertie);
	retiredSoldierDataset.on("load",showDiv);
	retiredSoldierDataset.load();
    L5.QuickTips.init();
};

function showDiv() {
	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	document.getElementById("Rtime").innerText = new Date();
	var length =retiredSoldierDataset.getCount();
	if(length==0) {
		retiredSoldierDataset.newRecord({"servedArmy":"","name":"","specialty":"","enlistTime":"","enlistPlace":"","servedMilitaryRegion":"","content":""});
	}
	document.getElementById("reDiv").style.display="";
}

function soldiersDetail(obj) {
    var data = new L5.Map();
  	var soldiersId=obj.nextSibling.innerHTML;
    data.put("idField",soldiersId);
    var url='jsp/cams/prs/readonly/prsretiredsoldiers_detail.jsp';
    var text = '退役士兵安置信息';
    L5.forward(url, text, data);
}
var printTitle;
//打印预览调用方法
function printBill(){
	var printDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	var records=printDataset.getAllRecords();
	var MilitaryRegionCodeDataset = L5.DatasetMgr.lookup("MilitaryRegionCodeDataset")
	var recordEnum = MilitaryRegionCodeDataset.getAllRecords();
	var enumLength = recordEnum.length;
	var n=records.length;
	if(records.length==0){return}
	for(i=0;i<n;i++){
		var record = records[i];
			var value = records[i].get('REGION');
			var flag = records[i].get('FLAG');
			var preason = records[i].get('PRENSON');
			for(var j=0;j<enumLength;j++) {
				var valueEnum = recordEnum[j].get("value");
				if(valueEnum == value) {
					records[i].set("REGION",recordEnum[j].get("text"));
					break;
				}
			}
			if(flag==1){
				records[i].set("FLAG","否");
			}else{
				records[i].set("FLAG","是");
			}
			//1:期满原籍,2:期满易地,3:提前原籍,4:提前易地
			switch (preason) {
			case  "1":
				records[i].set("PRENSON","期满原籍");
				break;
			case  "2":
				records[i].set("PRENSON","期满易地");
				break;
			case  "3":
				records[i].set("PRENSON","提前原籍");
				break;
			case  "4":
				records[i].set("PRENSON","提前易地");
				break;
			}
	}	
	doPrint(printDataset);
}
// 打印方法传递的record
function doPrint(printDataset){
	printReport(getPrintDataByDataSet(printTitle,printDataset),L5.webPath+'/jsp/cams/prs/query/printd.fr3');
}

