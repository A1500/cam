function init() {
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
		}
	else if (method=="INSERT"){
		ds.newRecord();
		if(deviceDs.getCount()<=0){
			var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
			command.setParameter("IdHelp","Id32");
			//获得七个随机主键
			var deviceIds = new Array();
			for(var i=0;i<7;i++){
				command.execute();
				var deviceId=command.getReturn("id");
				deviceIds[i]=deviceId;
			}
			deviceDs.newRecord({"taskCode":taskCode,"deviceId":deviceIds[0],"deviceCode":"1"});
			deviceDs.newRecord({"taskCode":taskCode,"deviceId":deviceIds[1],"deviceCode":"2"});
			deviceDs.newRecord({"taskCode":taskCode,"deviceId":deviceIds[2],"deviceCode":"3"});
			deviceDs.newRecord({"taskCode":taskCode,"deviceId":deviceIds[3],"deviceCode":"4"});
			deviceDs.newRecord({"taskCode":taskCode,"deviceId":deviceIds[4],"deviceCode":"5"});
			deviceDs.newRecord({"taskCode":taskCode,"deviceId":deviceIds[5],"deviceCode":"6"});
			deviceDs.newRecord({"taskCode":taskCode,"deviceId":deviceIds[6],"deviceCode":"7"});
		}
	}
	else if (method=="UPDATE"){
		ds.baseParams["TASK_CODE@="]=taskCode;
		ds.load();
		ds.on('load',function(){
			applyDs.setParameter("TASK_CODE@=",taskCode);
			applyDs.load(true);
			document.getElementById("approveDate").value=applyDs.getAt(0).get("approveDate");
			ds.set("approveDate",applyDs.getAt(0).get("approveDate"));
			statusDs.setParameter("TASK_CODE@=",taskCode);
			statusDs.load(true);
			document.getElementById("nextCheck").value=statusDs.getAt(0).get("nextCheck");
			document.getElementById("nextChagneCert").value=statusDs.getAt(0).get("nextChagneCert");
			ds.set("nextCheck",statusDs.getAt(0).get("nextCheck"));
			ds.set("nextChagneCert",statusDs.getAt(0).get("nextChagneCert"));
		});
		workerDataSet.setParameter("WEAL_WORKER.TASK_CODE@=",taskCode);
		workerDataSet.load();
		workerDataSet.on('load',loadDevice);
	}
	else if(method=="DETAIL"){
		ds.baseParams["TASK_CODE@="]=taskCode;
		ds.load();
		ds.on('load',function(){
			applyDs.setParameter("TASK_CODE@=",taskCode);
			applyDs.load(true);
			document.getElementById("approveDate").innerText=applyDs.getAt(0).get("approveDate");
			statusDs.setParameter("TASK_CODE@=",taskCode);
			statusDs.load(true);
			document.getElementById("nextCheck").innerText=statusDs.getAt(0).get("nextCheck");
			document.getElementById("nextChagneCert").innerText=statusDs.getAt(0).get("nextChagneCert");
		});
		workerDataSet.setParameter("WEAL_WORKER.TASK_CODE@=",taskCode);
		workerDataSet.load();
		workerDataSet.on('load',loadDevice);
	}else{
		L5.Msg.alert('提示',"未知的页面命令!");
		back();
	}
	//L5.QuickTips.init(); 
}
function loadDevice(ds){
	ds.un("load",loadDevice);
	deviceDs.setParameter("TASK_CODE@=",taskCode);
	deviceDs.load();
	deviceDs.on('load',loadProduct);
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
	workerDataSet.setParameter("WEAL_WORKER.CERT_CODE@=",_$("certCodeQuery"));		
	workerDataSet.setParameter("WEAL_WORKER.CERT_SPECIAL_CODE@=",_$("certSpecialCodeQuery"));
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
	var checkInfo = check();
	if(checkInfo){
		alert(checkInfo);
		return false;
	}
	
	var recordWorker=workerDataSet.getAllChangedRecords();
	var recordDevice=deviceDs.getAllChangedRecords();
	var devicevalid = deviceDs.isValidate();
	if(devicevalid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+devicevalid);
		return false;
	}
	var recordProduct=productDs.getAllChangedRecords();
	var productvalid = productDs.isValidate();
	if(productvalid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+productvalid);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.welfare.prosthesis.history.cmd.FitHistoryCmd");
	command.setParameter("recordInfo", recordInfo);
	command.setParameter("recordWorker", recordWorker);
	command.setParameter("recordDevice", recordDevice);
	command.setParameter("recordProduct", recordProduct);
	command.execute("saveFitHistory");
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
	reset();
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
	//workerDataSet.load();
	workerFlag=1;
}
function delW(){
	var grid=L5.getCmp("editGridWorker");
	var record=grid.getSelectionModel().getSelections();
	if(record.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var workerDataSet = L5.DatasetMgr.lookup("workerDataSet");
	workerDataSet.remove(record[0]);
}
//人员信息窗口继续添加功能
function addWorkerSubmit(){
	if(saveWorkerCheck()!=false){
		var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
		command.setParameter("IdHelp","Id32");
		command.execute();
		var workerId=command.getReturn("id");
		var workerDataSet = L5.DatasetMgr.lookup("workerDataSet");
		workerDataSet.newRecord({"workerId":workerId,"taskCode":taskCode,"corporationType":"1"});
	}
	reset();
	ifProducor();
}
//人员信息窗口确定按钮（隐藏窗口）
function hideWorker(){
	var info = validateInfo();
	if(info){
		alert(info);
		return false;
	}
	if(saveWorkerCheck()!=false){
		L5.getCmp("workerWin").setVisible(false);
	}
	ifProducor();
	reset();
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
	reset();
	ifProducor();
}
/**************************员工信息维护结束********************/
/**************************设施信息维护********************/
function addD(){
	var Grid = L5.getCmp('editGridDevice');
	Grid.stopEditing();
	var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
	command.setParameter("IdHelp","Id32");
	command.execute();
	var deviceId=command.getReturn("id");
	deviceDs.newRecord({"deviceId":deviceId,"taskCode":taskCode});
}
function delD(){
	var editGrid=L5.getCmp('editGridDevice');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	for(var i=0;i<selected.length;i++){
    	deviceDs.remove(selected[i]);
	}
}
/**************************设施信息维护结束********************/
/**************************生产能力信息维护********************/
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
/**************************生产能力信息维护结束********************/
//字号渲染
function serialNumRender(obj){
	if(obj.length==6||obj.length==11){
		document.getElementById('serialNum').value=obj+'-';
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

//持证情况
	var flag1=false;
	var flag2=false;
	var flag3=false;
	
	function checkYN(flag){
		(flag=="1")?$("certCode1").removeAttribute("disabled"):$("certCode1").disabled="disabled";
		(flag=="1")?$("certDate1").removeAttribute("disabled"):$("certDate1").disabled="disabled";
		(flag=="1")?$("certTime1").removeAttribute("disabled"):$("certTime1").disabled="disabled";
		if(flag=="0"){
			$("certDate1").value="";
			$("certCode1").value="";
			$("certTime1").value="";
			workerDataSet.getCurrent().set("certDate",$("certDate1").value);
			workerDataSet.getCurrent().set("certCode",$("certCode1").value);
			workerDataSet.getCurrent().set("certTime",$("certTime1").value);
		}
		(flag=="1")?flag1=true:flag1=false;
	}
	function checkSpecialYN(flag){
		(flag=="1")?$("certSpecialCode1").removeAttribute("disabled"):$("certSpecialCode1").disabled="disabled";
		(flag=="1")?$("certSpecialDate1").removeAttribute("disabled"):$("certSpecialDate1").disabled="disabled";
		(flag=="1")?$("certSpecialTime1").removeAttribute("disabled"):$("certSpecialTime1").disabled="disabled";
		if(flag=="0"){
			$("certSpecialCode1").value="";
			$("certSpecialDate1").value="";
			$("certSpecialTime1").value="";
			workerDataSet.getCurrent().set("certSpecialDate",$("certSpecialDate1").value);
			workerDataSet.getCurrent().set("certSpecialCode",$("certSpecialCode1").value);
			workerDataSet.getCurrent().set("certSpecialTime",$("certSpecialTime1").value);
		}
		(flag=="1")?flag2=true:flag2=false;
	}
	function checkOrthosisYN(flag){
		(flag=="1")?$("certOrthosisCode1").removeAttribute("disabled"):$("certOrthosisCode1").disabled="disabled";
		(flag=="1")?$("certOrthosisDate1").removeAttribute("disabled"):$("certOrthosisDate1").disabled="disabled";
		(flag=="1")?$("certOrthosisTime1").removeAttribute("disabled"):$("certOrthosisTime1").disabled="disabled";
		if(flag=="0"){
			$("certOrthosisCode1").value="";
			$("certOrthosisDate1").value="";
			$("certOrthosisTime1").value="";
			workerDataSet.getCurrent().set("certOrthosisDate",$("certOrthosisDate1").value);
			workerDataSet.getCurrent().set("certOrthosisCode",$("certOrthosisCode1").value);
			workerDataSet.getCurrent().set("certOrthosisTime",$("certOrthosisTime1").value);
		}
		(flag=="1")?flag3=true:flag3=false;
	}
	function validateInfo(){
		saveWorkerCheck();
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
		if(flag1){
			if($("certCode1").value==""){
				return "假肢制作师证书证书编号不能为空";
			}else if(_$("certDate1")==""){
				return "假肢制作师证书发证时间不能为空";
			}else if(_$("certTime1")==""){
				return "假肢制作师证书最后一次修改时间不能为空";
			}
			 
		}
		if(flag3){
			if($("certOrthosisCode1").value==""){
				return "矫形器制作师证书证书编号不能为空";
			}else if(_$("certOrthosisDate1")==""){
				return "矫形器制作师证书发证时间不能为空";
			}else if(_$("certOrthosisTime1")==""){
				return "矫形器制作师证书最后一次年检时间不能为空";
			}
			 
		}
		if(flag2){
			if(_$("certSpecialCode1")==""){
				return "特有工种职业资格证书证书编号不能为空";
			}else if(_$("certSpecialDate1")==""){
				return "特有工种职业资格证书发证时间不能为空";
			}else if(_$("certSpecialTime1")==""){
				return "特有工种职业资格证书最近一次年检时间不能为空";
			}
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
//初始化不选择时默认为否
function reset(){
	if(getSelected("certSituation1")==""){
		var ddl = document.getElementById("certSituation1");
		ddl.options[2].selected=true;
		checkYN(2);		
		workerDataSet.getCurrent().set("certSituation","0");	
	}
	if(getSelected("certSpecialSituation1")==""){
		var ddl = document.getElementById("certSpecialSituation1");
		ddl.options[2].selected=true;
		checkSpecialYN(2);				
		workerDataSet.getCurrent().set("certSpecialSituation","0");
	}
	if(getSelected("certOrthosisSituation1")==""){
		var ddl = document.getElementById("certOrthosisSituation1");
		ddl.options[2].selected=true;
		checkOrthosisYN(2);				
		workerDataSet.getCurrent().set("certOrthosisSituation","0");
	}
}

//总经营面积校验
function check(){
	var operateArea = parseInt(document.getElementById("operateArea").value);
	var productArea = parseInt(document.getElementById("productArea").value);
	var recoveryArea = parseInt(document.getElementById("recoveryArea").value);
	var receptionArea = parseInt(document.getElementById("receptionArea").value);
	var trainArea = parseInt(document.getElementById("trainArea").value);
	var otherArea = parseInt(document.getElementById("otherArea").value);
	var treatmentArea = parseInt(document.getElementById("treatmentArea").value);
	var leisureArea = parseInt(document.getElementById("leisureArea").value);
	var workArea = parseInt(document.getElementById("workArea").value);
	if(operateArea!=productArea+recoveryArea+receptionArea+trainArea+otherArea+treatmentArea+leisureArea+workArea){
		return "各活动室的面积总和应等于总经营面积";
	}
}
function checkArea(value){
	 if(value<120){
	 	alert("经营总面积不得小于120㎡");
	 	document.getElementById("operateArea").value="";
	 }
}