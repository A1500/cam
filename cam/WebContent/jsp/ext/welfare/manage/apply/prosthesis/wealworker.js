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
	reset();
	ifProducor();
	workerFlag=0;
}
//人员信息窗口继续添加功能
function addWorkerSubmit(){
	reset();
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
	reset();
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
	reset();
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
//关闭人员信息窗口
function closeWorker(){
	var workerDataSet = L5.DatasetMgr.lookup("workerDataSet");
	if(workerFlag==0){
		workerDataSet.remove(workerDataSet.getCurrent());
	}
	L5.getCmp("workerWin").setVisible(false);
	reset();
}
//获取下拉选框的值	
function getSelected(elementId){
	var ddl = document.getElementById(elementId);
	var index = ddl.selectedIndex;
	var value = ddl.options[index].value;
	return value;
}
//初始化不选择时默认为否
function reset (){
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

