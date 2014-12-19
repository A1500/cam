var  orgName ;
var printFlag=0;
function init() {

		var OrgNameDataset = L5.DatasetMgr.lookup("OrgNameDataset");
	OrgNameDataset.setParameter("filterSql","id='"+orgCode+"'");
	OrgNameDataset.load();
	OrgNameDataset.on("load",function() {
	orgName = OrgNameDataset.get("text");
});
	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
 	retiredSoldierDataset.baseParams["FLAG@="]="1";
 	retiredSoldierDataset.baseParams["ALLOT_FLAG@="]="1";
	//retiredSoldierDataset.load();
	var grid=L5.getCmp('editGridPanel');
	//给grid增加双击侦听事件。
	//grid.on("rowdblclick",update);
	L5.QuickTips.init();
	var printDataset = L5.DatasetMgr.lookup("printDataset");
	printDataset.on("load",ss)	;
}
function ss(){
	var printDataset = L5.DatasetMgr.lookup("printDataset");
		var records=printDataset.getAllRecords();
		var MilitaryRegionCodeDataset = L5.DatasetMgr.lookup("MilitaryRegionCodeDataset")
		var recordEnum = MilitaryRegionCodeDataset.getAllRecords();
		var enumLength = recordEnum.length;
		var n=records.length;
		if(records.length==0){return}
		for(i=0;i<n;i++){
			var preason = records[i].get('PRENSON');
			
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
function excel_click() {
	var ds = L5.DatasetMgr.lookup("retiredSoldierDataset");
	if(ds.getTotalCount()==0) {
		//L5.Msg.alert("消息","无可导出数据！");
		return;
	}
	var pageSize = ds.pageInfo.pageSize;
	//var pageIndex = ds.pageInfo.pageIndex;
	var startCursor = ds.pageInfo.startCursor;
	ds.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	ds.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	ds.baseParams["limitExcel"]=ds.getTotalCount();  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为ds.getTotalCount()
	L5.dataset2excel(ds, "/jsp/cams/prs/prsretiredsoldiers/soldiersexport.jsp");
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	
	var cYear=document.getElementById("cYear").value;
	if (cYear == '') {
		L5.Msg.alert('提示', '转业年度不能为空！');
		return false;
	}
	retiredSoldierDataset.setParameter("orgCode",orgCode);
	retiredSoldierDataset.setParameter("cYear",getParam("cYear"));
	//retiredSoldierDataset.setParameter("name",getParam("name"));
	retiredSoldierDataset.setParameter("servedMilitaryRegion",getParam("servedMilitaryRegion"));
	retiredSoldierDataset.setParameter("domicileCode",getParam("domicileCode"));
	retiredSoldierDataset.setParameter("retiredSoldierType","3");
	//retiredSoldierDataset.setParameter("sendback",getParam("sendback"));
	retiredSoldierDataset.load();
   printFlag=1;
}

function insert() {
	var data = new L5.Map();
	data.put("type","0");
		var url='jsp/cams/prs/prsretiredsoldiers/prsretiredsoldiers_insert.jsp';
		var text = '添加退役士兵信息';
		L5.forward(url,text,data);
}

function update(){

	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("idField",selected[0].get('SOLDIERSID'));
	var url='jsp/cams/prs/prsretiredsoldiers/prsretiredsoldiers_detail.jsp';
	var text = '修改退役士兵信息';
	L5.forward(url,text,data);
}

function del(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("SOLDIERSID");
			}
			var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
			var command=new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	retiredSoldierDataset.remove(selected[i]);
				}
				retiredSoldierDataset.commitChanges();

			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}

function detail(){

	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	var data = new L5.Map();
	data.put("idField",selected[0].get('SOLDIERSID'));
	var url='jsp/cams/prs/readonly/prsretiredsoldiers_detail.jsp';
	var text = '查看退役士兵信息';
	L5.forward(url,text,data);
}

function forHelp() {
	// var struId='<%=struId%>';
	var organName="山东省";
	var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode="+orgCode+"&organName="+encodeURIComponent(encodeURIComponent(organName)),"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");

	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];

	}
}
function func_ForDomicileSelect() {
	var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode=370000000000&organName=山东省","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("enlistPlace").value = list[0];
		document.getElementById("enlistPlaceName").value = list[1];
	}
}
var printTitle;
function print(){
	if(printFlag==0){
	L5.Msg.alert("提示", "没有需要打印的记录!");
		return false;
	}
	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	var printDataset=L5.DatasetMgr.lookup("printDataset");
	//var pageSize = retiredSoldierDataset.pageInfo.pageSize;
	var startCursor = retiredSoldierDataset.pageInfo.startCursor;
	printDataset.baseParams["flag"]="2";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	printDataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	printDataset.baseParams["limitExcel"]=retiredSoldierDataset.getTotalCount();
	printDataset.setParameter("orgCode",orgCode);
	var cYear=document.getElementById("cYear").value;
	printDataset.setParameter("cYear",getParam("cYear"));
	printDataset.setParameter("servedMilitaryRegion",getParam("servedMilitaryRegion"));
	printDataset.setParameter("domicileCode",getParam("domicileCode"));
	
	printDataset.setParameter("retiredSoldierType","3");
	printDataset.load();
	
}
function doPrint(printDataset){

	printReport(getPrintDataByDataSet(printTitle,printDataset),L5.webPath+'/jsp/cams/prs/query/sdd.fr3');
}

function getPrintDataByDataSet(reportName,printDataset){
	var dqsj=document.getElementById("cYear").value;
	var region=document.getElementById("servedMilitaryRegion").value;
	var sj=new Date();
	var xmlStr="<?xml version='1.0' encoding='GBK' standalone='no'?>";
	xmlStr+="<Report ReportName='' Creater='"+dqsj+"' CreateOrgan='" +sj+"' ReportNo='"+region+"' ReportType=''>";
	var records=printDataset.getAllRecords();
	
	var n=records.length;
	if(records.length==0){return}
	for(i=0;i<n;i++){
		xmlStr +="<Info>";
		
		
		L5.each(records[i].fields.items,function(item,index){xmlStr+="<"+item.name+">"+records[i].get(item.name)+"</"+item.name+">";});
		xmlStr +="</Info>";
	}
	
	xmlStr +="</Report>";
	return xmlStr;

}
function func_ForDomicileSelect() {
	var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode=370000000000&organName=山东省","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("enlistPlace").value = list[0];
		document.getElementById("enlistPlaceName").value = list[1];
	}
}
