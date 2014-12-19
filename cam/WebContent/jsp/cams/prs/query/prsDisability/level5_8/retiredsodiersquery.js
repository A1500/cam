var orgName;
function init() {
	var OrgNameDataset = L5.DatasetMgr.lookup("OrgNameDataset");
	OrgNameDataset.setParameter("filterSql","id='"+xzqu+"'");
	OrgNameDataset.load();
	OrgNameDataset.on("load",function() {
		orgName = OrgNameDataset.get("text");
	});
	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	retiredSoldierDataset.setParameter("xzqh", xzqu);
	retiredSoldierDataset.setParameter("cxsjq", cxsjq);
	retiredSoldierDataset.setParameter("cxsjz", cxsjz);
	retiredSoldierDataset.setParameter("disable", disable);
	retiredSoldierDataset.setParameter("grade", grade);
	retiredSoldierDataset.setParameter("propertie", propertie);
	retiredSoldierDataset.load();
	var printDataset=L5.DatasetMgr.lookup("printDataset");
    printDataset.on("load",function(){
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
		doPrint(printDataset);});
    L5.QuickTips.init();
};

function nameRender(val,el,rec){
	return '<a href="javascript:detail(\'' + rec.get("ID") + '\')">'
			+ val + '</a>';
}
function detail(soldiersId){
	var width = screen.width-150;
    var height = screen.height-200;
	var url = '../../prsretiredsoldiers_detail.jsp?idField=' + soldiersId;
	var win = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}

var printTitle;
//打印预览调用方法
function printBill(){
	var printDataset=L5.DatasetMgr.lookup("printDataset");
	printDataset.setParameter("xzqh", xzqu);
	printDataset.setParameter("cxsjq", cxsjq);
	printDataset.setParameter("cxsjz", cxsjz);
	printDataset.setParameter("disable", disable);
	printDataset.setParameter("grade", grade);
	printDataset.setParameter("propertie", propertie);
	printDataset.setParameter("ifAll", "ifAll");
	printDataset.load();
}
// 打印方法传递的record
function doPrint(printDataset){
	printReport(getPrintDataByDataSet(printTitle,printDataset),L5.webPath+'/jsp/cams/prs/query/printd.fr3');
}
function exportCSV(){
	var ds = L5.DatasetMgr.lookup("retiredSoldierDataset");
	if(ds.getTotalCount()==0) {
		return;
	}
	var pageSize = ds.pageInfo.pageSize;
	var startCursor = ds.pageInfo.startCursor;
	ds.baseParams["ifAll"]="ifAll";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	ds.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	ds.baseParams["limitExcel"]=ds.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	var fileName = "";//+orgName;
	if(cxsjq==cxsjz){
		var times = cxsjq.split("-");
		fileName =times[0]+"年度"+orgName;
	}else{
		var timesq = cxsjq.split("-");
		var timesz = cxsjz.split("-");
		if(timesq[0]==timesz[0]){
			fileName =timesq[0]+"年度"+orgName;
		}else{
			fileName =timesq[0]+"-"+timesz[0]+"年度"+orgName;
		}
	}
	L5.dataset2excel(ds, "/jsp/cams/prs/query/soldiersexportjunqu.jsp?fileName="+fileName);
}

