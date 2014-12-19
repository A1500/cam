function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		ds.newRecord();
	}
	else if (method=="UPDATE"){
		ds.baseParams["TASK_CODE@="]=taskCode;
		ds.load();
		ds.on('load',function(){
			statusDs.setParameter("TASK_CODE@=",taskCode);
			statusDs.load(true);
			document.getElementById("approveDate").value=statusDs.getAt(0).get("approveDate");
			document.getElementById("nextCheck").value=statusDs.getAt(0).get("nextCheck");
			ds.set("approveDate",statusDs.getAt(0).get("approveDate"));
			ds.set("nextCheck",statusDs.getAt(0).get("nextCheck"));
		});
	}
	else if(method=="DETAIL"){
		ds.baseParams["TASK_CODE@="]=taskCode;
		ds.load();
		ds.on('load',function(){
			statusDs.setParameter("TASK_CODE@=",taskCode);
			statusDs.load(true);
			document.getElementById("approveDate").innerText=statusDs.getAt(0).get("approveDate");
			document.getElementById("nextCheck").innerText=statusDs.getAt(0).get("nextCheck");
		});
		workerDs.setParameter("TASK_CODE@=",taskCode);
		workerDs.load();
	}else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	workerDataSet.setParameter("WEAL_WORKER.TASK_CODE@=",taskCode);
	workerDataSet.load();
	workerDataSet.on('load',loadProduct);
}
function loadProduct(ds){
	ds.un("load",loadProduct);
	productDs.setParameter("TASK_CODE@=",taskCode);
	productDs.load();
}
//员工查询方法
function query(){		
	workerDataSet.setParameter("WEAL_WORKER.ID_CARD@=",_$("idCardQuery"));		
	workerDataSet.setParameter("WEAL_WORKER.NAME@=",_$("nameQuery"));		
	workerDataSet.setParameter("WEAL_WORKER.TASK_CODE@=",taskCode);
	workerDataSet.load();
}
function save(){
	var recordInfo = ds.getCurrent();
	//校验
	recordInfo.set("taskCode",taskCode);
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}
	
	var recordWorker=workerDataSet.getAllChangedRecords();
	var recordProduct=productDs.getAllChangedRecords();
	var productvalid = productDs.isValidate();
	if(productvalid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+productvalid);
		return false;
	}
	
	//维护员工总数和残疾职工总数
	workerData.setParameter("WEAL_WORKER.TASK_CODE@=",taskCode);
	workerData.load(true);
	var workers = workerData.getAllRecords();
	var disabilityNum = 0;
	for(var i=0;i<workers.length;i++){
		if(workers[i].get("disabilityType")!=""){
			disabilityNum=disabilityNum+1;
		}
	}
	recordInfo.set("workersAll",workers.length);
	recordInfo.set("workersDeform",disabilityNum);
	
	var command = new L5.Command("com.inspur.cams.welfare.welfarecorp.history.cmd.UnitHistoryCmd");
	command.setParameter("recordInfo", recordInfo);
	command.setParameter("recordWorker", recordWorker);
	command.setParameter("recordProduct", recordProduct);
	command.execute("saveUnitHistory");

	if (!command.error) {
		alert("保存成功！");	
		method="UPDATE";
		init();
		workerDataSet.setParameter("WEAL_WORKER.TASK_CODE@=",taskCode);
		workerDataSet.load();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function back(){	
	history.go(-1); 	 
}
/**************************员工信息维护********************/
var workerFlag=0;//0:新增员工，1：修改员工
function addW(){
	var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
	command.setParameter("IdHelp","Id32");
	command.execute();
	var workerId=command.getReturn("id");
	var workerDataSet = L5.DatasetMgr.lookup("workerDataSet");
	workerDataSet.newRecord({"workerId":workerId,"taskCode":taskCode,"corporationType":"1"});
	var win=L5.getCmp("workerWin");
	win.show(this);
	ifProducor();
	workerFlag=0;
}
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
	workerFlag=1;
}
function delW(){
	var grid=L5.getCmp("editGridWorker");
	var record=grid.getSelectionModel().getSelections();
	if(record.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
	if(state=="yes"){
		var command=new L5.Command("com.inspur.cams.welfare.base.cmd.WealWorkerCommand");
		command.setParameter("workerId",record[0].get("workerId"));
		command.execute("del");
		if(!command.error){
			L5.Msg.alert('提示',"删除成功");
			init();
		}else{
			L5.Msg.alert('提示',"删除时出现错误！"+command.error);
		}
	}else{
		return false;
	}
	});
}
//人员信息窗口继续添加功能
function addWorkerSubmit(){
	if(saveWorkerCheck()!=false){
		var info = validateInfo();
		if(info){
			alert(info);
			return false;
		}
		var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
		command.setParameter("IdHelp","Id32");
		command.execute();
		var workerId=command.getReturn("id");
		var workerDataSet = L5.DatasetMgr.lookup("workerDataSet");
		workerDataSet.newRecord({"workerId":workerId,"taskCode":taskCode,"corporationType":"1"});
	}
	ifProducor();
}
//人员信息窗口确定按钮（隐藏窗口）
function hideWorker(){
	if(saveWorkerCheck()==false){
		return false;
	}
	var info = validateInfo();
	if(info){
		alert(info);
		return false;
	}
	if(saveWorkerCheck()!=false){
		L5.getCmp("workerWin").setVisible(false);
	}
	ifProducor();
}
//人员信息添加确定检验
function saveWorkerCheck(){
	var workerDataSet = L5.DatasetMgr.lookup("workerDataSet");
	var record = workerDataSet.getCurrent();
	if(record==null){
	}else{
		var name = record.get("name");
		if(name==""||name==null){
			L5.Msg.alert('提醒','员工名称不能为空！');
			return false;
		}
		if(record.get("idCard")==''){
			L5.Msg.alert('提示','身份证号不能为空！');
			return false;
		}
		if(record.get("sex")==''){
			L5.Msg.alert("提示","校验未通过，性别不能为空！");
			return false;
		}
	}
}
//关闭人员信息窗口
function closeWorker(){
	var workerDataSet = L5.DatasetMgr.lookup("workerDataSet");
	if(workerFlag==0){
		workerDataSet.remove(workerDataSet.getCurrent());
	}
	L5.getCmp("workerWin").setVisible(false);
}
/**************************员工信息维护结束********************/
/**************************主要产品信息维护********************/
function addP(){
	var Grid = L5.getCmp('editGridProduct');
	Grid.stopEditing();
	var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
	command.setParameter("IdHelp","Id32");
	command.execute();
	var produceId=command.getReturn("id");
	productDs.newRecord({"produceId":produceId,"taskCode":taskCode});
}
function delP(){
	var editGrid=L5.getCmp('editGridProduct');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	for(var i=0;i<selected.length;i++){
    	productDs.remove(selected[i]);
	}
}
/**************************主要产品信息维护结束********************/
//字号渲染
function serialNumRender(obj){
	if(obj.length==6||obj.length==11){
		document.getElementById('serialNum').value=obj+'-';
	}
}
//身份证号校验
function checkIdCradNo(){
	var idCard=document.getElementById('idCard').value;
 	if(checkIDCard($("idCard")) != true && !(idCard.length==18 && idCard.lastIndexOf("N")>0 )){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		document.getElementById('idCard').value='';
		return;
	}else{
		//回填性别
		document.getElementById('sex').value=getSexByCode(idCard);
		workerDataSet.set("sex",getSexByCode(idCard));
	}
}
function checkLegalIdCradNo(obj){
	var idCard=obj.value;
 	if(checkIDCard(obj) != true && !(idCard.length==18 && idCard.lastIndexOf("N")>0 )){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		obj.value='';
		return;
	}
}
	function validateInfo(){
		if(_$("realwages1")==""){
			return "实发工资不能为空";
		}else if(_$("socialInsurance1")==""){
			return "社会保险不能为空";
		}else if(_$("busInsurance1")==""){
			return "商业保险不能为空";
		}else if(_$("endowmentInsurance1")==""){
			return "养老保险不能为空";
		}else if(_$("medicalInsurance1")==""){
			return "医疗保险不能为空";
		}else if(_$("unemployedInsurance1")==""){
			return "失业保险不能为空";
		}else if(_$("injuryInsurance1")==""){
			return "工伤保险不能为空";
		}else if(_$("maternityInsurance1")==""){
			return "生育保险不能为空";
		}else if(_$("housingFund1")==""){
			return "住房公积金不能为空";
		}
	}
		//获取下拉选框的值	
function getSelected(elementId){
	var ddl = document.getElementById(elementId);
	var index = ddl.selectedIndex;
	var value = ddl.options[index].value;
	return value;
}
function ifProducor(){
	if(getSelected("ifProductor1").length==0){
		var ddl = document.getElementById("ifProductor1");
		ddl.options[2].selected=true;
		workerDataSet.getCurrent().set("ifProductor","0");			
	}
}
function toE(){
	var dataset = L5.DatasetMgr.lookup("workerDataSet");
	L5.dataset2excel(dataset, "/jsp/cams/welfare/welfarecorp/apply/welfarecorpQualification/wealworkerToExcel.jsp");
}
//导入
function empImport(){
	var win = L5.getCmp("importExcelWin");
	win.show();
}
function click_close(){
	var win = L5.getCmp("importExcelWin");
	win.hide();
}
function click_import(){
	var excelFile = document.getElementById("excelFile").value;
	if(!excelFile){
		L5.Msg.alert("提示","导入文件不能为空！");
		return;
	}else if(excelFile.lastIndexOf(".xls")==-1){
		L5.Msg.alert("提示","请导入Excel文件！");
		return;
	}
	var command=new L5.Command("com.inspur.cams.welfare.base.cmd.WealWorkerCommand");
	command.setParameter("taskCode",taskCode);
	command.setParameter("excelFile",excelFile);
	command.setForm("form_content");
	command.execute("importExcel");
	command.afterExecute=function(){
		if(!command.error){
			var erro = command.getReturn("erro");
			if(typeof(erro)=="undefined"){
				var win=L5.getCmp("importExcelWin");
				win.hide();
				query();
			}else{
				L5.Msg.alert("提示",erro,{});
			}
		}else{
	        L5.Msg.alert("提示",(''+command.error).replace("出现系统异常",""),{});
        }
	}
}
function downLoad(){
	var url = L5.webPath + "/fileDownload?filePath=jsp/cams/welfare/history/unit/fuliEmp.xls&fileName=fuliEmp.xls&project=1";
    window.location = url;
}