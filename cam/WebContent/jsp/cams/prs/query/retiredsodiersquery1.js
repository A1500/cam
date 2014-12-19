function init() {
	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	retiredSoldierDataset.setParameter("xzqh",orgCode);
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query() {
	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	var cx_servedMilitaryRegion=_$("cx_servedMilitaryRegion");
	var cxsj_year=_$("cxsj_year");
	if(cx_servedMilitaryRegion!=null&&cx_servedMilitaryRegion!=""){
		retiredSoldierDataset.setParameter("cx_servedMilitaryRegion",cx_servedMilitaryRegion);
	}//设置军区大单位参数
	if(cxsj_year!=null&&cxsj_year!=""){
		retiredSoldierDataset.setParameter("cxsj_year",cxsj_year);
	}//设置退役年度参数
	retiredSoldierDataset.setParameter("xzqh",orgCode);
	retiredSoldierDataset.load();
	
	
	var printDataset=L5.DatasetMgr.lookup("printDataset");
	var cx_servedMilitaryRegion=_$("cx_servedMilitaryRegion");
	var cxsj_year=_$("cxsj_year");
	if(cx_servedMilitaryRegion!=null&&cx_servedMilitaryRegion!=""){
		
		printDataset.setParameter("cx_servedMilitaryRegion",cx_servedMilitaryRegion);
	}//设置军区大单位参数
	if(cxsj_year!=null&&cxsj_year!=""){
		printDataset.setParameter("cxsj_year",cxsj_year);
	}//设置退役年度参数
	printDataset.setParameter("xzqh",orgCode);
    printDataset.setParameter("ifAll","ifAll");
    printDataset.load();
}
function showDiv() {
	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	var length =retiredSoldierDataset.getCount();
	if(length==0) {
		retiredSoldierDataset.newRecord({"servedArmy":"","name":"","specialty":"","enlistTime":"","enlistPlace":"","servedMilitaryRegion":"","content":""});
	}
	document.getElementById("reDiv").style.display="";
}
function forHelp() {
	var revalue = window
			.showModalDialog(
					"../../../bsp/organization/getselect_code.jsp?rootId="
							+ struId
							+ "&showOrganType=11,12&organType=0&isExact=1&isCheckBox=0&isTree=1",
					"",
					"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");

	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
	}
}

function getTime(time){
	var  times = time.split("-");
	time = times[0]+"."+times[1];
	return time;
}
function soldiersDetail(obj) {
    var data = new L5.Map();
  	soldiersId=obj.nextSibling.innerHTML;
    data.put("idField",soldiersId);
    var url='jsp/cams/prs/readonly/prsretiredsoldiers_detail.jsp';
    var text = '退役士兵安置信息';
    L5.forward(url, text, data);
}
function detail(obj){
 	var data = new L5.Map();
  	soldiersId=obj.nextSibling.innerHTML;
	var width = screen.width-150;
    var height = screen.height-200;
	var url = 'prsretiredsoldiers_detail.jsp?idField=' + soldiersId;
	var win = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
var printTitle;
//打印预览调用方法
function printBill(){
	var printDataset=L5.DatasetMgr.lookup("printDataset");
	var records=printDataset.getAllRecords();
    if(records.length==0){return;}
    dicPlacemenRenson();
    dicResettlementSituation();
    dicServedMilitaryRegion();
    var url=L5.webPath+'/jsp/cams/prs/query/retiredSoldiersPlace23.fr3';
    var printTile = "退役士兵安置地明细表";
    printReport(getPrintDataByDataSet(printTitle,printDataset),L5.webPath+'/jsp/cams/prs/query/retiredSoldiersPlace24.fr3');
//    doReportPrint(printTitle,'kk','d',printDataset ,url);

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

/**
 * 安置理由枚举值转换回来
 */
function dicBackPlacemenRenson(){
	var printDataset = L5.DatasetMgr.lookup("printDataset");
	var records=printDataset.getAllRecords();
	var n=records.length;
	if(records.length==0){return;}
	for(i=0;i<n;i++){
		var preason = records[i].get('PLACEMEN_RENSON');
		
		//1:期满原籍,2:期满易地,3:提前原籍,4:提前易地
		switch (preason) {
		case  "期满原籍":
			records[i].set("PLACEMEN_RENSON","1");
			break;
		case  "期满易地":
			records[i].set("PLACEMEN_RENSON","2");
			break;
		case  "提前原籍":
			records[i].set("PLACEMEN_RENSON","3");
			break;
		case  "提前易地":
			records[i].set("PLACEMEN_RENSON","4");
			break;
		}
	}
}

/**
 * 安置方式枚举值转换回来
 */
function dicBackResettlementSituation(){
	var printDataset = L5.DatasetMgr.lookup("printDataset");
	var records=printDataset.getAllRecords();
	var n=records.length;
	if(records.length==0){return;}
	for(i=0;i<n;i++){
		var preason = records[i].get('RESETTLEMENT_SITUATION');
		
		//1:期满原籍,2:期满易地,3:提前原籍,4:提前易地
		switch (preason) {
		case  "复工复学":
			records[i].set("RESETTLEMENT_SITUATION","10");
			break;
		case  "服从分配":
			records[i].set("RESETTLEMENT_SITUATION","20");
			break;
		case  "自谋职业":
			records[i].set("RESETTLEMENT_SITUATION","30");
			break;
		case  "自找单位":
			records[i].set("RESETTLEMENT_SITUATION","40");
			break;
		}
	}
}

/**
 * 军区大单位字典表转换回来
 */
function dicBackServedMilitaryRegion(){
	var printDataset = L5.DatasetMgr.lookup("printDataset");
	var records=printDataset.getAllRecords();
	var n=records.length;
	if(records.length==0){return;}
	for(i=0;i<n;i++){
		var preason = records[i].get('SERVED_MILITARY_REGION');
		
		//1:期满原籍,2:期满易地,3:提前原籍,4:提前易地
		switch (preason) {
		case  "沈阳军区":
			records[i].set("SERVED_MILITARY_REGION","1");
			break;
		case  "北京军区":
			records[i].set("SERVED_MILITARY_REGION","2");
			break;
		case  "兰州军区":
			records[i].set("SERVED_MILITARY_REGION","3");
			break;
		case  "济南军区":
			records[i].set("SERVED_MILITARY_REGION","4");
			break;
		case  "南京军区":
			records[i].set("SERVED_MILITARY_REGION","5");
			break;
		case  "广州军区":
			records[i].set("SERVED_MILITARY_REGION","6");
			break;
		case  "成都军区":
			records[i].set("SERVED_MILITARY_REGION","7");
			break;
		case  "海军航空兵":
			records[i].set("SERVED_MILITARY_REGION","8");
			break;
		case  "海军直属单位":
			records[i].set("SERVED_MILITARY_REGION","9");
			break;
		case  "东海舰队":
			records[i].set("SERVED_MILITARY_REGION","10");
			break;
		case  "南海舰队":
			records[i].set("SERVED_MILITARY_REGION","11");
			break;
		case  "北海舰队":
			records[i].set("SERVED_MILITARY_REGION","12");
			break;
		case  "空军直属单位":
			records[i].set("SERVED_MILITARY_REGION","13");
			break;
		case  "沈阳军区空军":
			records[i].set("SERVED_MILITARY_REGION","14");
			break;
		case  "北京军区空军":
			records[i].set("SERVED_MILITARY_REGION","15");
			break;
		case  "兰州军区空军":
			records[i].set("SERVED_MILITARY_REGION","16");
			break;
		case  "济南军区空军":
			records[i].set("SERVED_MILITARY_REGION","17");
			break;
		case  "南京军区空军":
			records[i].set("SERVED_MILITARY_REGION","18");
			break;
		case  "广州军区空军":
			records[i].set("SERVED_MILITARY_REGION","19");
			break;
		case  "成都军区空军":
			records[i].set("SERVED_MILITARY_REGION","20");
			break;
		case  "公安厅":
			records[i].set("SERVED_MILITARY_REGION","21");
			break;
		case  "国防大学":
			records[i].set("SERVED_MILITARY_REGION","22");
			break;
		case  "军事科学院":
			records[i].set("SERVED_MILITARY_REGION","23");
			break;
		case  "总装备部":
			records[i].set("SERVED_MILITARY_REGION","24");
			break;
		case  "总政治部":
			records[i].set("SERVED_MILITARY_REGION","25");
			break;
		case  "总参谋部":
			records[i].set("SERVED_MILITARY_REGION","26");
			break;
		case  "总后勤部":
			records[i].set("SERVED_MILITARY_REGION","27");
			break;
		case  "第二炮兵部队":
			records[i].set("SERVED_MILITARY_REGION","28");
			break;
		case  "人民武装警察部队":
			records[i].set("SERVED_MILITARY_REGION","29");
			break;
		}
	}
}

/**
 * 导出Excel
 */
function exportCSV(){
	var ds = L5.DatasetMgr.lookup("retiredSoldierDataset");
	if(ds.getTotalCount()<1){
		return;
	}
	var cxsj_year = _$("cxsj_year");
	var cx_servedMilitaryRegion = _$("cx_servedMilitaryRegion");
	var pageSize = ds.pageInfo.pageSize;
	var startCursor = ds.pageInfo.startCursor;
	ds.baseParams["ifAll"]="ifAll";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	ds.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	ds.baseParams["limitExcel"]=ds.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	L5.dataset2excel(ds,"/jsp/cams/prs/query/soldiersexport1.jsp?cxsj_year="+cxsj_year+"&cx_servedMilitaryRegion="+cx_servedMilitaryRegion);
}

function nameRender(val,el,rec){
	return '<a href="javascript:detail(\'' + rec.get("SOLDIERS_ID") + '\')">'
			+ val + '</a>';
}
function detail(soldiersId){
	var width = screen.width-150;
    var height = screen.height-200;
	var url = 'prsretiredsoldiers_detail.jsp?idField=' + soldiersId;
	var win = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}