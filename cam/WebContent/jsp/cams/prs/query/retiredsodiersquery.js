var printTitle;
var printFlag=0;
function init() {
	document.getElementById("sendback").value=1;
	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	retiredSoldierDataset.setParameter("organCode",organCode);
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

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query() {
var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
   var cxsj_q = _$("cxsj_q");
   var cxsj_z = _$("cxsj_z");
   var sendback=_$("sendback");
   /*
	 if (cxsj_q == '') {
		L5.Msg.alert('提示', '退役年度不能为空！');
		return false;
	}
	*/
	if (cxsj_q != '') {
	if (cxsj_z == '') {
		var time_q=cxsj_q+'-01-01';
		var time_z=cxsj_q+'-12-31';
		retiredSoldierDataset.setParameter("time_q",time_q);
		retiredSoldierDataset.setParameter("time_z",time_z);
		
	}
	if (cxsj_z != '') {
		var time_q=cxsj_q+'-01-01';
		var time_z=cxsj_z+'-12-31';
		retiredSoldierDataset.setParameter("time_q",time_q);
		retiredSoldierDataset.setParameter("time_z",time_z);
	
	}
	}
	var domicileName = _$("domicileName");
	if (domicileName == '') {
		L5.Msg.alert('提示', '安置地不能为空！');
		return false;
	}
	
	var domicileCode = _$("domicileCode");
	if(domicileCode.substring(6)=="999000"){
		domicileCode = domicileCode.substring(0,6)+"000000";
	}
	if(domicileCode.substring(2,12)=="0000000000"){	
		var organCode1=domicileCode.substring(0,2);
		retiredSoldierDataset.setParameter("wherePlacement",organCode1);
	}else if(domicileCode.substring(4,12)=="00000000"){	
		var organCode1=domicileCode.substring(0,4);
		retiredSoldierDataset.setParameter("wherePlacement",organCode1);
	}else if(domicileCode.substring(6,12)=="000000"){
		var  organCode1=domicileCode;
		retiredSoldierDataset.setParameter("wherePlacement",organCode1);
	}
	
   // retiredSoldierDataset.setParameter("WHERE_PLACEMEN@=",domicileCode);
     retiredSoldierDataset.setParameter("flag",sendback);
     retiredSoldierDataset.setParameter("sort","SERVED_MILITARY_REGION");
    retiredSoldierDataset.load();
    noReclick(retiredSoldierDataset,"queryButton");
    printFlag=1;
}

function forHelp() {
	var organName="山东省";
	var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode="+organCode+"&organName="+encodeURIComponent(encodeURIComponent(organName)),"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	
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

function nameRender(val,el,rec){
	return '<a href="javascript:detail(\'' + rec.get("ID") + '\')">'
			+ val + '</a>';
}
function detail(soldiersId){
	var width = screen.width-150;
    var height = screen.height-200;
	var url = 'prsretiredsoldiers_detail.jsp?idField=' + soldiersId;
	var win = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}

//打印预览调用方法
function printBill(){
if(printFlag==0){
	L5.Msg.alert("提示", "没有需要打印的记录!");
	return false;
	}
	var printDataset=L5.DatasetMgr.lookup("printDataset");
	var domicileName = _$("domicileName");
	var cxsj_q = _$("cxsj_q");
   	var cxsj_z = _$("cxsj_z");
   	var sendback=_$("sendback");
	
	if (cxsj_q != '') {
		if (cxsj_z == '') {
			var time_q=cxsj_q+'-01-01';
			var time_z=cxsj_q+'-12-31';
			printDataset.setParameter("time_q",time_q);
			printDataset.setParameter("time_z",time_z);
		}
	}
	var domicileName = _$("domicileName");
	
	var domicileCode = _$("domicileCode");
	if(domicileCode.substring(2,12)=="0000000000"){	
		var organCode1=domicileCode.substring(0,2);
		printDataset.setParameter("wherePlacement",organCode1);
	}else if(domicileCode.substring(4,12)=="00000000"){	
		var organCode1=domicileCode.substring(0,4);
		printDataset.setParameter("wherePlacement",organCode1);
	}else if(domicileCode.substring(6,12)=="000000"){
		var  organCode1=domicileCode;
		printDataset.setParameter("wherePlacement",organCode1);
	}
    printDataset.setParameter("flag",sendback);
    printDataset.setParameter("ifAll","ifAll");
    printDataset.setParameter("sort","SERVED_MILITARY_REGION");
	printDataset.load();
}
// 打印方法传递的record
function doPrint(printDataset){
	printReport(getPrintDataByDataSet(printTitle,printDataset),L5.webPath+'/jsp/cams/prs/query/XF1.fr3');
}
function exportCSV(){
	var ds = L5.DatasetMgr.lookup("retiredSoldierDataset");
	if(ds.getTotalCount()==0) {
		return;
	}
	var url = "/jsp/cams/prs/query/soldiersexportjunqu.jsp";
	var cxsj_q = _$("cxsj_q");
	var domicileName = _$("domicileName");
	var fileName = cxsj_q+"年度"+domicileName;
	url+="?fileName="+fileName;
	var pageSize = ds.pageInfo.pageSize;
	var startCursor = ds.pageInfo.startCursor;
	ds.baseParams["ifAll"]="ifAll";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	ds.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	ds.baseParams["limitExcel"]=ds.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	L5.dataset2excel(ds,url );
	
}
