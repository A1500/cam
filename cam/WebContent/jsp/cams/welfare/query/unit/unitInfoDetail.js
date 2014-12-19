function init() {
	ds.baseParams["TASK_CODE@="]=taskCode;
	ds.load();
	ds.on('load',function(){
		statusDs.setParameter("TASK_CODE@=",taskCode);
		statusDs.load(true);
		checkDs.setParameter("unitId",statusDs.getAt(0).get("unitId"));
		checkDs.setParameter("applyStauts","not null");//只加载通过或不通过的年检信息
		checkDs.load();
		document.getElementById("approveDate").innerText=statusDs.getAt(0).get("approveDate");
		document.getElementById("nextCheck").innerText=statusDs.getAt(0).get("nextCheck");
	});
	workerDs.setParameter("WEAL_WORKER.TASK_CODE@=",taskCode);
	workerDs.load();
	workerDs.on('load',loadProduct);
}
function loadProduct(ds){
	ds.un("load",loadProduct);
	productDs.setParameter("TASK_CODE@=",taskCode);
	productDs.load();
}
//员工查询方法
function query(){	
	workerDs.setParameter("WEAL_WORKER.ID_CARD@=",document.getElementById("idCardQuery").value);		
	workerDs.setParameter("WEAL_WORKER.NAME@=",document.getElementById("nameQuery").value);	
	workerDs.setParameter("WEAL_WORKER.TASK_CODE@=",taskCode);
	workerDs.load();
}

function back(){	
	history.go(-1); 	 
}
/**************************员工信息维护********************/

function editW(){
	var grid=L5.getCmp("editGridWorker");
	var record=grid.getSelectionModel().getSelections();
	if(record.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var win=L5.getCmp("workerWin");
	win.show(this);
	var workerId=record[0].get("workerId");
	var workerDataSet = L5.DatasetMgr.lookup("workerDataSet");
	workerDataSet.setParameter("WORKER_ID@=",workerId);
	workerDataSet.load(true);
	if(workerDataSet.getAt(0).get("disabilityType").length==0){
		$("disabilityType1").innerHTML="";
	}
	if(workerDataSet.getAt(0).get("disabilityLevel").length==0){
		$("disabilityLevel1").innerHTML="";
	}
	if(workerDataSet.getAt(0).get("education").length==0){
		$("education1").innerHTML="";
	}
	if(workerDataSet.getAt(0).get("entryType").length==0){
		$("entryType1").innerHTML="";
	}
	if(workerDataSet.getAt(0).get("jobLevel").length==0){
		$("jobLevel1").innerHTML="";
	}
	if(workerDataSet.getAt(0).get("ifProductor").length==0){
		$("ifProductor1").innerHTML="";
	}
	if(workerDataSet.getAt(0).get("allocationType").length==0){
		$("allocationType1").innerHTML="";
	}
}

//关闭人员信息窗口
function closeWorker(){
	
	L5.getCmp("workerWin").setVisible(false);
}
//年检
function detailHref(value,cellmeta,record,rowindex,colindex,dataset){
	var ds=L5.DatasetMgr.lookup("checkDs");
	return '<a href="javascript:detail(\'' + ds.indexOf(record) + '\')">' + value + '</a>';
}
function detail(index){
	var ds=L5.DatasetMgr.lookup("checkDs");
   	var record= ds.getAt(index);
   	var taskCode=record.get('TASK_CODE');
   	var checkInfoDs=L5.DatasetMgr.lookup("ds");
   	checkInfoDs.setParameter("TASK_CODE@=",taskCode);
   	checkInfoDs.load();
   	var win=L5.getCmp("checkWin");
	win.show();
}
function closeWin(){
	var win=L5.getCmp("checkWin");
	win.hide();
}

function toE(){
    var workerDsExcel = L5.DatasetMgr.lookup("workerDsExcel");
  	    workerDsExcel.setParameter("taskCode",taskCode);
	    workerDsExcel.load(true);
	var dataset = L5.DatasetMgr.lookup("workerDsExcel");
    var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();
	//ds.baseParams["limitExcel"]=pageSize;  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
	L5.dataset2excel(dataset, "/jsp/cams/welfare/welfarecorp/apply/welfarecorpQualification/wealworkerToExcelM.jsp");
	dataset.baseParams["excelType"]="reset"; //重置导出类型

 }