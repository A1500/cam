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
	retiredSoldierDataset.setParameter("emplacementflag", emplacementflag);
	if(employment_type!="null"){
		retiredSoldierDataset.setParameter("employment_type", employment_type);
	}//employment_type为空的时候再次传到后台会导致传过去的参数值为"null"
	if(resettlement_situation!="null"){
		retiredSoldierDataset.setParameter("resettlement_situation", resettlement_situation);
	}//同上
	retiredSoldierDataset.load();

	var printDataset=L5.DatasetMgr.lookup("printDataset");
	printDataset.setParameter("xzqh", xzqu);
	printDataset.setParameter("cxsjq", cxsjq);
	printDataset.setParameter("cxsjz", cxsjz);
	printDataset.setParameter("emplacementflag", emplacementflag);
	if(employment_type!="null"){
		printDataset.setParameter("employment_type", employment_type);
	}//employment_type为空的时候再次传到后台会导致传过去的参数值为"null"
	if(resettlement_situation!="null"){
		printDataset.setParameter("resettlement_situation", resettlement_situation);
	}//同上
	printDataset.setParameter("ifAll", "ifAll");
	printDataset.load();
	
    L5.QuickTips.init();
};


function nameRender(val,el,rec){
	return '<a href="javascript:detail(\'' + rec.get("SOLDIERS_ID") + '\')">'
			+ val + '</a>';
}
function detail(soldiersId){
	var width = screen.width-150;
    var height = screen.height-200;
	var url = '../prsretiredsoldiers_detail.jsp?idField=' + soldiersId;
	var win = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}


var printTitle;
//打印预览调用方法
function printBill(){
	var printDataset=L5.DatasetMgr.lookup("printDataset");
	printDataset.setParameter("xzqh", xzqu);
	printDataset.setParameter("cxsjq", cxsjq);
	printDataset.setParameter("cxsjz", cxsjz);
	printDataset.setParameter("flag", flag);
	printDataset.setParameter("ifAll", "ifAll");
	printDataset.setParameter("employment", employment);
	printDataset.setParameter("placement", placement);
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
	L5.dataset2excel(ds, "/jsp/cams/prs/query/soldiersexport2.jsp?fileName="+fileName);
}

//打印预览调用方法
function printBill2(){
	var printDataset=L5.DatasetMgr.lookup("printDataset");
	var records=printDataset.getAllRecords();
	if(records.length==0){return;}
    dicPlacemenRenson();
    dicResettlementSituation();
    dicServedMilitaryRegion();
    var printTile = "退役士兵安置明细表";
    printReport(getPrintDataByDataSet(printTitle,printDataset),L5.webPath+'/jsp/cams/prs/query/retiredSoldiersPlaceTongji5.fr3');
}

/**
 * 安置理由枚举值转换
 */
function dicPlacemenRenson(){
	var printDataset = L5.DatasetMgr.lookup("printDataset");
	var records=printDataset.getAllRecords();
	var n=records.length;
	if(records.length==0){return;}
	for(i=0;i<n;i++){
		var preason = records[i].get('PLACEMEN_RENSON');
		
		//1:期满原籍,2:期满易地,3:提前原籍,4:提前易地
		switch (preason) {
		case  "1":
			records[i].set("PLACEMEN_RENSON","期满原籍");
			break;
		case  "2":
			records[i].set("PLACEMEN_RENSON","期满易地");
			break;
		case  "3":
			records[i].set("PLACEMEN_RENSON","提前原籍");
			break;
		case  "4":
			records[i].set("PLACEMEN_RENSON","提前易地");
			break;
		}
	}
}

/**
 * 安置方式枚举值转换
 */
function dicResettlementSituation(){
	var printDataset = L5.DatasetMgr.lookup("printDataset");
	var records=printDataset.getAllRecords();
	var n=records.length;
	if(records.length==0){return;}
	for(i=0;i<n;i++){
		var preason = records[i].get('RESETTLEMENT_SITUATION');
		
		//1:期满原籍,2:期满易地,3:提前原籍,4:提前易地
		switch (preason) {
		case  "10":
			records[i].set("RESETTLEMENT_SITUATION","复工复学");
			break;
		case  "20":
			records[i].set("RESETTLEMENT_SITUATION","服从分配");
			break;
		case  "30":
			records[i].set("RESETTLEMENT_SITUATION","自谋职业");
			break;
		case  "40":
			records[i].set("RESETTLEMENT_SITUATION","自找单位");
			break;
		}
	}
}

/**
 * 军区大单位字典表转换
 */
function dicServedMilitaryRegion(){
	var printDataset = L5.DatasetMgr.lookup("printDataset");
	var records=printDataset.getAllRecords();
	var n=records.length;
	if(records.length==0){return;}
	for(i=0;i<n;i++){
		var preason = records[i].get('SERVED_MILITARY_REGION');
		
		//1:期满原籍,2:期满易地,3:提前原籍,4:提前易地
		switch (preason) {
		case  "1":
			records[i].set("SERVED_MILITARY_REGION","沈阳军区");
			break;
		case  "2":
			records[i].set("SERVED_MILITARY_REGION","北京军区");
			break;
		case  "3":
			records[i].set("SERVED_MILITARY_REGION","兰州军区");
			break;
		case  "4":
			records[i].set("SERVED_MILITARY_REGION","济南军区");
			break;
		case  "5":
			records[i].set("SERVED_MILITARY_REGION","南京军区");
			break;
		case  "6":
			records[i].set("SERVED_MILITARY_REGION","广州军区");
			break;
		case  "7":
			records[i].set("SERVED_MILITARY_REGION","成都军区");
			break;
		case  "8":
			records[i].set("SERVED_MILITARY_REGION","海军航空兵");
			break;
		case  "9":
			records[i].set("SERVED_MILITARY_REGION","海军直属单位");
			break;
		case  "10":
			records[i].set("SERVED_MILITARY_REGION","东海舰队");
			break;
		case  "11":
			records[i].set("SERVED_MILITARY_REGION","南海舰队");
			break;
		case  "12":
			records[i].set("SERVED_MILITARY_REGION","北海舰队");
			break;
		case  "13":
			records[i].set("SERVED_MILITARY_REGION","空军直属单位");
			break;
		case  "14":
			records[i].set("SERVED_MILITARY_REGION","沈阳军区空军");
			break;
		case  "15":
			records[i].set("SERVED_MILITARY_REGION","北京军区空军");
			break;
		case  "16":
			records[i].set("SERVED_MILITARY_REGION","兰州军区空军");
			break;
		case  "17":
			records[i].set("SERVED_MILITARY_REGION","济南军区空军");
			break;
		case  "18":
			records[i].set("SERVED_MILITARY_REGION","南京军区空军");
			break;
		case  "19":
			records[i].set("SERVED_MILITARY_REGION","广州军区空军");
			break;
		case  "20":
			records[i].set("SERVED_MILITARY_REGION","成都军区空军");
			break;
		case  "21":
			records[i].set("SERVED_MILITARY_REGION","公安厅");
			break;
		case  "22":
			records[i].set("SERVED_MILITARY_REGION","国防大学");
			break;
		case  "23":
			records[i].set("SERVED_MILITARY_REGION","军事科学院");
			break;
		case  "24":
			records[i].set("SERVED_MILITARY_REGION","总装备部");
			break;
		case  "25":
			records[i].set("SERVED_MILITARY_REGION","总政治部");
			break;
		case  "26":
			records[i].set("SERVED_MILITARY_REGION","总参谋部");
			break;
		case  "27":
			records[i].set("SERVED_MILITARY_REGION","总后勤部");
			break;
		case  "28":
			records[i].set("SERVED_MILITARY_REGION","第二炮兵部队");
			break;
		case  "29":
			records[i].set("SERVED_MILITARY_REGION","人民武装警察部队");
			break;
		}
	}
}

function servicedTimeRenderer(value, cellmeta, record, rowindex, colindex, dataset){
			var year = parseInt(value/12);
			var month = parseInt(value%12);
			if(year==0){
				return month+"个月";
			}else if(month==0){
				return year+"年";
			}else{
				return year+"年"+month+"个月"
			}
}