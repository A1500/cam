//新农合查询费用结果窗口
//var insuranceExpWin;
//伤残等级
var disabilityLevelCode;
//保险类型
var insuranceType;
//受助状态
var status=1;
//优抚救助对象类别
var bptType;
//对象属地
var domicileCode;
//优抚救助比例
var BptPer;
//住院总费用
var totalExpense;
//纳入保险报销费用
var insuranceExpense;
//保险支付金额
var insurancePay;
//大病保险报销
var illnessInsurancePay;
//医疗救助金额
var assitancePay;
//个人支付费用
var personalPay;
//优抚医院减免
var hospitalPay;
//其他救助费用
var otherPay;
//优抚补助费用
var bptAssitancePay;
//保存状态标志
var saveFlag=0;
//费用回填标志
var expFlg=0;
//冲账record
var strikeRecord;
//页面初始化
function init(){
	//加载一站式救助信息 
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter("balance_Id",balanceId);
	ds.load();
	ds.on('load',setBptType);
	//加载人员基本信息
	var BaseinfoPeopleDataSet1 = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet1");
	BaseinfoPeopleDataSet1.setParameter("people_Id",peopleId);	
	BaseinfoPeopleDataSet1.load();
	BaseinfoPeopleDataSet1.on('load',setBaseinfo);
	//editGridPannel单击事件
	var expGrid = L5.getCmp("expGrid");
	expGrid.on("rowclick", backExpMsg);
}
//回填从新农合系统中查询的费用信息
function backExpMsg(){
	document.getElementById("hospitalPay").value="";
	document.getElementById("specialPay").innerHTML="";
	document.getElementById("personalPay").innerHTML="";
	var expGrid=L5.getCmp('expGrid');
	var selected = expGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return;
	}
	document.getElementById("totalExpense").value=formatNum(selected[0].get("TOTAL_EXPENSE"));
	document.getElementById("insuranceExpense").value=formatNum(selected[0].get("INSURANCE_EXPENSE"));
	document.getElementById("insurancePay").value=formatNum(selected[0].get("INSURANCE_PAY"));
	document.getElementById("illnessInsurancePay").value=formatNum(selected[0].get("ILLNESS_INSURANCE_PAY"));
	document.getElementById("leaveDate").value=selected[0].get("LEAVE_DATE");
	totalExpense=selected[0].get("TOTAL_EXPENSE")*1;
	insuranceExpense=selected[0].get("INSURANCE_EXPENSE")*1;
	insurancePay=selected[0].get("INSURANCE_PAY")*1;
	illnessInsurancePay=selected[0].get("ILLNESS_INSURANCE_PAY")*1;
	expFlg=1;
}

//将基本信息加载到页面
function setBaseinfo(BaseinfoPeopleDataSet1){
	domicileCode=BaseinfoPeopleDataSet1.get("domicileCode");
	document.getElementById("name").innerHTML=BaseinfoPeopleDataSet1.get("name");
	document.getElementById("sex").innerHTML=getDicText(SexDataset,BaseinfoPeopleDataSet1.get("sex"));
	document.getElementById("leaveDate").value=getCurDate();
	document.getElementById("idCard").innerHTML=BaseinfoPeopleDataSet1.get("idCard");
	document.getElementById("workUnitName").innerHTML=BaseinfoPeopleDataSet1.get("workUnitName");
	document.getElementById("address").innerHTML=BaseinfoPeopleDataSet1.get("address");
	
	//加载优抚补助比例
	var SamMedicalPerDS = L5.DatasetMgr.lookup("SamMedicalPerDS");
	if(disabilityLevelCode){
		SamMedicalPerDS.baseParams["disability_Level@="]=disabilityLevelCode;
		SamMedicalPerDS.baseParams["domicile_Code@like@String"]=domicileCode.substring(0,6);
		SamMedicalPerDS.baseParams["safeguard_Type@="]=insuranceType;
		SamMedicalPerDS.load();
		SamMedicalPerDS.on('load',getBptPer);
	}else{
		SamMedicalPerDS.baseParams["domicile_Code@like@String"]=domicileCode.substring(0,6);
		SamMedicalPerDS.baseParams["safeguard_Type@="]=insuranceType;
		SamMedicalPerDS.baseParams["YEAR"]=getCurDate().substring(0,4);
		SamMedicalPerDS.load();
		SamMedicalPerDS.on('load',getBptPer);
	}
}
//回填优抚对象类别
function setBptType(ds){
	var record=ds.getCurrent();
	//冲账
	if(strike=="strike"){
		strikeRecord=record;
	}
	if(record.get("status")==0){
		status=0;
		L5.Msg.alert('提示',"此人已停助，本次结算不能享受补助!");
	}
	disabilityLevelCode=record.get("disabilityLevelCode");
	insuranceType=record.get("insuranceType");
	bptType=record.get("bptType");
	//调用接口加载总费用信息
	var insuranceDS=L5.DatasetMgr.lookup("insuranceDS");
	insuranceDS.setParameter("queryType","LEAVE");
	insuranceDS.setParameter("organArea",organCode);
	insuranceDS.setParameter("inDate",record.get("inDate"));
	insuranceDS.setParameter("insuranceCode",record.get("medicalCode"));
	insuranceDS.setParameter("insuranceType",record.get("insuranceType"));
	insuranceDS.load();
	document.getElementById("bptType").innerHTML=getBptTypeName(bptType,disabilityLevelCode);
	document.getElementById("leaveDate").value=getCurDate();
	document.getElementById("totalExpense").value="";
	document.getElementById("insuranceExpense").value="";
	document.getElementById("insurancePay").value="";
	document.getElementById("illnessInsurancePay").value="";
	document.getElementById("hospitalPay").value="";
	document.getElementById("specialPay").innerHTML="";
	document.getElementById("personalPay").innerHTML="";
}
//获得并回填优抚救助比例
function getBptPer(SamMedicalPerDS){
	BptPer=0;
	if(SamMedicalPerDS.getCount()!=0){
		BptPer=SamMedicalPerDS.get("percentage");
		document.getElementById("percentage").innerHTML=BptPer+"%";
	}else{
		BptPer="未找到相关信息";
		L5.Msg.alert("提示","未找到相关救助比例信息");
		document.getElementById("percentage").innerHTML=BptPer;
	}
}

function formatHospitalPay(value){
	if(!isFloat(value)){
			document.getElementById("hospitalPay").value="";
			document.getElementById("specialPay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			hospitalPay="";
			L5.Msg.alert("提示","请输入数字");
			return;
	}
	document.getElementById("hospitalPay").value=formatNum(value);
	hospitalPay=value*1;
	if(BptPer!="未找到相关信息"&&totalExpense&&insuranceExpense&&insurancePay&&illnessInsurancePay&&hospitalPay){
		balance(hospitalPay);
	}
}
//计算个人支付费用
function balance(value){
	bptAssitancePay=Math.round((insuranceExpense-insurancePay-illnessInsurancePay-value)*BptPer/100*100)/100;
	if(assitancePay<0){
		assitancePay=0;
	}
	if(bptAssitancePay<0){
		L5.Msg.alert('提示',"医疗补助金额过高!");
		document.getElementById("hospitalPay").value="";
		document.getElementById("specialPay").innerHTML="";
		document.getElementById("personalPay").innerHTML="";
		hospitalPay="";
		return;
	}
		
	if(status==0){
		assitancePay=0;
		bptAssitancePay=0;
	}
	personalPay=Math.round((totalExpense-insurancePay-illnessInsurancePay-bptAssitancePay-value)*100)/100;
	document.getElementById("specialPay").innerHTML=changeTwoDecimal(bptAssitancePay);
	document.getElementById("personalPay").innerHTML=changeTwoDecimal(personalPay);
}
/////////////////保存出院信息/////////////////
function save(){
//	if(expFlg==0){
//		L5.Msg.alert("提示","请在下面列表中选中一条记录并将其回填！");
//		return;
//	}
	if(saveFlag==1){
		L5.Msg.alert("提示","不能重复保存出院信息！");
		return;
	}
	if(BptPer=="未找到相关信息"){
	L5.Msg.alert("提示","未找到相关优抚救助比例信息,请联系民政部门设置优抚救助比比例！");
		return;
	}
	var ds=L5.DatasetMgr.lookup("ds");
	var record=ds.getCurrent();
	//非空校验
	if(document.getElementById("leaveDate").value==""){
		L5.Msg.alert('提示',"请填写出院日期!");
		return false;
	}
	if(document.getElementById("totalExpense").value==""&&(document.getElementById("totalExpense").value+"").length==0){
		L5.Msg.alert('提示',"请填写住院总费用!");
		return false;
	}
	if(document.getElementById("insuranceExpense").value==""&&(document.getElementById("insuranceExpense").value+"").length==0){
		L5.Msg.alert('提示',"请填写纳入保险报销费用!");
		return false;
	}
	if(document.getElementById("insurancePay").value==""&&(document.getElementById("insurancePay").value+"").length==0){
		L5.Msg.alert('提示',"请填写保险支付金额!");
		return false;
	}
	if(document.getElementById("illnessInsurancePay").value==""&&(document.getElementById("illnessInsurancePay").value+"").length==0){
		L5.Msg.alert('提示',"请填写大病保险报销金额!");
		return false;
	}
	if(document.getElementById("hospitalPay")==""&&(document.getElementById("hospitalPay")+"").length==0){
		L5.Msg.alert('提示',"请填写优抚医院减免!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确认保存？',function(state){
				if(state=="yes"){
						var records = ds.getCurrent();
						var command=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMBalanceCmd"); 
						records.set("totalExpense",totalExpense);
						records.set("leaveDate",document.getElementById("leaveDate").innerHTML);
						records.set("insuranceExpense",insuranceExpense);
						records.set("insurancePay",insurancePay);
						records.set("illnessInsurancePay",illnessInsurancePay);
						records.set("assitancePay",assitancePay);
						records.set("specialPay",bptAssitancePay);
						records.set("personalPay",personalPay);
						records.set("otherPay",otherPay);
						records.set("balancePeopleId",userId);
						records.set("specialPer",BptPer);
						records.set("balanceTime",getCurDate());
						//冲账
						if(strike=="strike"){
							//03表示新纪录
							records.set("strikeStatus","03");
							records.set("strikeBalanceId",balanceId);
							var command=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMBalanceCmd"); 
							command.setParameter("records",records);
							command.setParameter("strikeRecord",strikeRecord);
							command.execute("saveStrike");
						}else{
							var command=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMBalanceCmd"); 
							command.setParameter("records",records);
							command.execute("save");
						}	
						if (!command.error) {
							saveFlag=1;
							L5.MessageBox.confirm('确定', '保存成功，是否打印结算单？',function(state){
									if(state=="yes"){
											printBill(balanceId,cityDataset.get("name"));
									}else{
										return false;
									}
							});
						}else{
							L5.Msg.alert('提示',"保存时出现错误！"+command.error);
						}
				}else{
					return false;
				}
	});
}
//打印预览
function seePrintBpt(){
	if (saveFlag!=1) {
		L5.Msg.alert('提示',"请先保存数据!");
		return;
	}
	printBill(balanceId,cityDataset.get("name"));
}
//返回
function back()
 {	 	var url='jsp/ext/mbalance/manage/samMBalanceList.jsp';
		var text = '一站结算_住院登记';
		L5.forward(url,text);	 
 }
 //根据性别代码判断性别
 function getSex(sex){
 	if(sex==0){
 		return "男";
 	}else{
 		return "女";
 	}
 }
 
 //////////////////////////////////手动输入计算费用///////////////////////////////////////
 
 function formatTotal(value){
	if(!isFloat(value)){
			document.getElementById("totalExpense").value="";
			document.getElementById("specialPay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			totalExpense="";
			L5.Msg.alert("提示","请输入数字");
			return;
	}
	document.getElementById("totalExpense").value=formatNum(value);
	totalExpense=value*1;
	if(totalExpense&&insuranceExpense){
		if(totalExpense<insuranceExpense){
			L5.Msg.alert("提示","住院总费用不能小于纳入保险报销费用！");
			document.getElementById("totalExpense").value="";
			document.getElementById("specialPay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			totalExpense="";
			return;
		}
	}
	if(insurancePay&&totalExpense){
		if(totalExpense<insurancePay){
			L5.Msg.alert("提示","住院总费用不能小于保险支付金额！");
			document.getElementById("totalExpense").value="";
			document.getElementById("specialPay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			totalExpense="";
			return;
		}
	}
	if(BptPer!="未找到相关信息"&&totalExpense&&insuranceExpense&&insurancePay&&illnessInsurancePay&&hospitalPay){
		balance(hospitalPay);
	}
}
function formatInsuranceExpense(value){
	if(!isFloat(value)){
			document.getElementById("insuranceExpense").value="";
			document.getElementById("specialPay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			insuranceExpense="";
			L5.Msg.alert("提示","请输入数字");
			return;
	}
	document.getElementById("insuranceExpense").value=formatNum(value);
	insuranceExpense=value*1;
	if(totalExpense&&insuranceExpense){
		if(totalExpense<insuranceExpense){
			L5.Msg.alert("提示","纳入保险报销费用不能大于住院总费用！");
			document.getElementById("insuranceExpense").value="";
			document.getElementById("specialPay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			insuranceExpense="";
			return;
		}
	}
	if(insuranceExpense&&insurancePay){
		if(insuranceExpense<insurancePay){
			L5.Msg.alert("提示","纳入保险报销费用不能小于保险支付金额！");
			document.getElementById("insuranceExpense").value="";
			document.getElementById("specialPay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			insuranceExpense="";
			return;
		}
	}
	if(BptPer!="未找到相关信息"&&totalExpense&&insuranceExpense&&insurancePay&&illnessInsurancePay&&hospitalPay){
		balance(hospitalPay);
	}

}
//保险支付金额onChange事件，获得救助比例并计算费用
function formatInsurancePay(value){
	if(!isFloat(value)){
			document.getElementById("insurancePay").value="";
			document.getElementById("specialPay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			insurancePay="";
			L5.Msg.alert("提示","请输入数字");
			return;
	}
	document.getElementById("insurancePay").value=formatNum(value);
	insurancePay=value*1;
	if(insurancePay&&insuranceExpense){
		if(insuranceExpense<insurancePay){
			L5.Msg.alert("提示","保险支付金额不能大于纳入保险报销费用！");
			document.getElementById("insurancePay").value="";
			document.getElementById("specialPay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			insurancePay="";
			return;
		}
	}
	if(insurancePay&&totalExpense){
		if(totalExpense<insurancePay){
			L5.Msg.alert("提示","保险支付金额不能大于住院总费用！");
			document.getElementById("insurancePay").value="";
			document.getElementById("specialPay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			insurancePay="";
			return;
		}
	}
	if(BptPer!="未找到相关信息"&&totalExpense&&insuranceExpense&&insurancePay&&illnessInsurancePay&&hospitalPay){
		balance(hospitalPay);
	}
}
//大病保险报销onChange事件
function payChange(value){
	document.getElementById("illnessInsurancePay").value=formatNum(value);
	illnessInsurancePay=value*1;
	if(!isFloat(value)){
			document.getElementById("illnessInsurancePay").value="";
			document.getElementById("specialPay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			illnessInsurancePay="";
			L5.Msg.alert("提示","请输入数字");
			return;
	}
	if(illnessInsurancePay&&insuranceExpense){
		if(insuranceExpense<illnessInsurancePay){
			L5.Msg.alert("提示","大病保险报销金额不能大于纳入保险报销费用！");
			document.getElementById("illnessInsurancePay").value="";
			document.getElementById("specialPay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			illnessInsurancePay="";
			return;
		}
	}
	if(illnessInsurancePay&&totalExpense){
		if(totalExpense<illnessInsurancePay){
			L5.Msg.alert("提示","大病保险报销金额不能大于住院总费用！");
			document.getElementById("illnessInsurancePay").value="";
			document.getElementById("specialPay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			illnessInsurancePay="";
			return;
		}
	}
	if(BptPer!="未找到相关信息"&&totalExpense&&insuranceExpense&&insurancePay&&illnessInsurancePay&&hospitalPay){
		balance(hospitalPay);
	}
}