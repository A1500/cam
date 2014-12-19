function init() {
	//L5.DatasetMgr.lookup("workerDataSet").load();	
	//L5.QuickTips.init();
	workerDataSet.setParameter("WEAL_WORKER.TASK_CODE@=",taskCode);
	workerDataSet.load();
	
};


function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){		
	workerDataSet.setParameter("WEAL_WORKER.ID_CARD@=",getParam("idCard"));		
	workerDataSet.setParameter("WEAL_WORKER.NAME@=",getParam("name"));		
	workerDataSet.setParameter("WEAL_WORKER.CERT_CODE@=",getParam("certCode"));		
	workerDataSet.setParameter("WEAL_WORKER.CERT_SPECIAL_CODE@=",getParam("certSpecialCode"));	
	workerDataSet.setParameter("WEAL_WORKER.TASK_CODE@=",taskCode);	
	workerDataSet.load();
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
//人员信息窗口继续添加功能
function addWorkerSubmit(){
	workerFlag="0";
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
	ifProducor();
}
function del() {
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	workerDataSet.remove(selected[0]);
}
function editW(){
	var grid=L5.getCmp("editGridPanel");
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

//人员信息窗口确定按钮
function confirmWorker(){
	var info = validateInfo();
	if(info){
		alert(info);
		return false;
	}
	L5.getCmp("workerWin").hide();
	ifProducor();
	//L5.getCmp("workerWin").setVisible(false);
}
function save() {
	var isValidate = workerDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	var records = workerDataSet.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	var command = new L5.Command("com.inspur.cams.welfare.base.cmd.WealWorkerCommand");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		workerDataSet.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!",function(){
			window.close();
		});
		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
	
}

	//获取下拉选框的值	
	function getSelected(elementId){
		var ddl = document.getElementById(elementId);
		var index = ddl.selectedIndex;
		//return index;
		var value = ddl.options[index].value;
		return value;
	}
	function validateInfo(){
		if(_$("name1")==""){
			return "姓名不能为空";
		}else if(_$("idCard1")==""){
			return "姓名不能为空";
		}else if(getSelected("sex1")==""){
			return "性别不能为空";
			alert();
		}else if(_$("realwages1")==""){
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
//关闭人员信息窗口
function closeWorker(){
	var workerDataSet = L5.DatasetMgr.lookup("workerDataSet");
	if(workerFlag==0){
		workerDataSet.remove(workerDataSet.getCurrent());
	}
	L5.getCmp("workerWin").setVisible(false);
}
//获取下拉选框的值	
function getSelected(elementId){
	var ddl = document.getElementById(elementId);
	var index = ddl.selectedIndex;
	var value = ddl.options[index].value;
	return value;
}
function ifProducor (){
	if(getSelected("ifProductor1").length==0){
		var ddl = document.getElementById("ifProductor1");
		ddl.options[2].selected=true;
		workerDataSet.getCurrent().set("ifProductor","0");			
	}
}
//身份证号校验
function checkIdCradNo(){
	var idCard=document.getElementById('idCard1').value;
 	if(checkIDCard($("idCard1")) != true && !(idCard.length==18 && idCard.lastIndexOf("N")>0 )){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		document.getElementById('idCard1').value='';
		return;
	}else{
		//回填性别
		document.getElementById('sex1').value=getSexByCode(idCard);
		workerDataSet.set("sex",getSexByCode(idCard));
	}
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
				L5.Msg.alert("提示","导入成功!",function(){
					var win=L5.getCmp("importExcelWin");
					win.hide();
					query();
				});
			}else{
				L5.Msg.alert("提示",erro,{});
			}
		}else{
	        L5.Msg.alert("提示",(''+command.error).replace("出现系统异常",""),{});
        }
	}
}
function downLoad(){
	var url = L5.webPath + "/fileDownload?filePath=jsp/ext/welfare/manage/apply/welfarecorp/fuliEmp.xls&fileName=fuliEmp.xls&project=1";
    window.location = url;
}

