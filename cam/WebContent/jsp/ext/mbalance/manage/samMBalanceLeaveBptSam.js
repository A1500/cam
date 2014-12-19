//用于存放结算单所需数据
var data = new L5.Map();
//救助对象类别
var assitanceType;
//保险类型
var insuranceType;
//伤残等级
var disabilityLevelCode;
//优抚救助对象类别
var bptType;
//受助状态
var status=1;
//其他救助费用
var otherPay=0;
var beforeRecord;
//优抚救助比例
var BptPer;
//救助比例
var assPer;
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
//优抚补助费用
var bptAssitancePay;
var hospotalPay;
//对象属地
var domicileCode;
//封顶线
var topLine;
//保存状态标志
var saveFlag=0;
//费用回填标志
var expFlg=0;
//冲账record
var strikeRecord;
//页面初始化
function init(){
	//加载一站式住院登记信息
	var mBalanceDS=L5.DatasetMgr.lookup("mBalanceDS");
	mBalanceDS.setParameter("balance_Id",balanceId);
	mBalanceDS.load();
	//获得救助类型
	mBalanceDS.on('load',setBptType);
	
	//加载医前救助
	var beforeDS=L5.DatasetMgr.lookup("beforeDS");
	beforeDS.setParameter("PEOPLE_ID",peopleId);
	beforeDS.setParameter("STATUS",1);
	beforeDS.purgeListeners();
	beforeDS.on('load',function(){
		if(beforeDS.getCount()!=0){
			beforeRecord=beforeDS.getCurrent();
			otherPay=beforeRecord.get("assitanceMon");
		}
		//冲账
		if(strike=="strike"){
			otherPay=mBalanceDS.getCurrent().get("otherPay");
		}
		document.getElementById("otherPay").innerHTML=changeTwoDecimal(otherPay);
	});
	beforeDS.load();
	//加载人员基本信息
	var BaseinfoPeopleDataSet1 = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet1");
	BaseinfoPeopleDataSet1.setParameter("people_Id",peopleId);	
	BaseinfoPeopleDataSet1.load();
	BaseinfoPeopleDataSet1.on('load',setBaseinfo);
	
	//editGridPannel单击事件
	var expGrid = L5.getCmp("expGrid");
	expGrid.on("rowclick", backExpMsg);
	//获得封顶线
	getTopLine(domicileCode,assitanceType);
	//人员本年历史救助信息加载
	getHistoryAss(peopleId);
	
}
//回填从新农合系统中查询的费用信息
function backExpMsg(){
	var expGrid=L5.getCmp('expGrid');
	var selected = expGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return;
	}
	document.getElementById("insurancePay").value="";
	document.getElementById("illnessInsurancePay").value="";
	document.getElementById("bptAssitancePay").innerHTML="";
	document.getElementById("personalPay").innerHTML="";
	document.getElementById("hospitalPay").value="";
	document.getElementById("percentage").innerHTML="";
	document.getElementById("assitancePay").innerHTML="";
	document.getElementById("totalExpense").value=formatNum(selected[0].get("TOTAL_EXPENSE"));
	document.getElementById("insuranceExpense").value=formatNum(selected[0].get("INSURANCE_EXPENSE"));
	document.getElementById("insurancePay").value=formatNum(selected[0].get("INSURANCE_PAY"));
	document.getElementById("illnessInsurancePay").value=formatNum(selected[0].get("ILLNESS_INSURANCE_PAY"));
	document.getElementById("leaveDate").value=selected[0].get("LEAVE_DATE");
	totalExpense=selected[0].get("TOTAL_EXPENSE");
	insuranceExpense=selected[0].get("INSURANCE_EXPENSE");
	insurancePay=selected[0].get("INSURANCE_PAY");
	illnessInsurancePay=selected[0].get("ILLNESS_INSURANCE_PAY");
	//获得救助比例并回填费用
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
	document.getElementById("leaveDate").focus();
	
	
	var SamMedicalPerDS = L5.DatasetMgr.lookup("SamMedicalPerDS");
	if(disabilityLevelCode){
		SamMedicalPerDS.baseParams["disability_Level@="]=disabilityLevelCode;
		SamMedicalPerDS.baseParams["domicile_Code@like@String"]=domicileCode.substring(0,6);
		SamMedicalPerDS.baseParams["safeguard_Type@="]=insuranceType;
		SamMedicalPerDS.baseParams["YEAR@="]=getCurDate().substring(0,4);
		SamMedicalPerDS.purgeListeners();
		SamMedicalPerDS.on('load',function(){
			BptPer=0;
			if(SamMedicalPerDS.getCount()!=0){
				BptPer=SamMedicalPerDS.get("percentage");
				document.getElementById("bptPercentage").innerHTML=BptPer+"%";
			}else{
				BptPer="未找到相关信息";
				L5.Msg.alert("提示","未找到相关救助比例信息");
				document.getElementById("bptPercentage").innerHTML=BptPer;
			}
		});
		SamMedicalPerDS.load();
		SamMedicalPerDS.on('load',getBptPer);
	}else{
		SamMedicalPerDS.baseParams["domicile_Code@like@String"]=domicileCode.substring(0,6);
		SamMedicalPerDS.baseParams["safeguard_Type@="]=insuranceType;
		SamMedicalPerDS.baseParams["YEAR@="]=getCurDate().substring(0,4);
		SamMedicalPerDS.purgeListeners();
		SamMedicalPerDS.on('load',function(){
			BptPer=0;
			if(SamMedicalPerDS.getCount()!=0){
				BptPer=SamMedicalPerDS.get("percentage");
				document.getElementById("bptPercentage").innerHTML=BptPer+"%";
			}else{
				BptPer="未找到相关信息";
				L5.Msg.alert("提示","未找到相关救助比例信息");
				document.getElementById("bptPercentage").innerHTML=BptPer;
			}
		});
		SamMedicalPerDS.load();
		SamMedicalPerDS.on('load',getBptPer);
	}
}
//回填优抚对象类别
function setBptType(mBalanceDS){
	var record=mBalanceDS.getCurrent();
	//冲账
	if(strike=="strike"){
		strikeRecord=record;
	}
	if(record.get("status")==0){
		status=0;
		L5.Msg.alert('提示',"此人已停助，本次结算不能享受补助!");
	}
	
	disabilityLevelCode=record.get("disabilityLevelCode");
	data.put("balanceId",record.get("balanceId"));
	insuranceType=record.get("insuranceType");
	bptType=record.get("bptType");
	assitanceType=record.get("assitanceType");
	//调用接口加载总费用信息
	var insuranceDS=L5.DatasetMgr.lookup("insuranceDS");
	insuranceDS.setParameter("queryType","LEAVE");
	insuranceDS.setParameter("organArea",organCode);
	insuranceDS.setParameter("inDate",record.get("inDate"));
	insuranceDS.setParameter("insuranceCode",record.get("medicalCode"));
	insuranceDS.setParameter("insuranceType",record.get("insuranceType"));
	insuranceDS.load();
	document.getElementById("bptType").innerHTML=getBptTypeName(bptType,disabilityLevelCode);
		document.getElementById("totalExpense").value="";
		document.getElementById("insuranceExpense").value="";
		document.getElementById("insurancePay").value="";
		document.getElementById("illnessInsurancePay").value="";
		document.getElementById("hospitalPay").value="";
		document.getElementById("assitancePay").innerHTML="";
		document.getElementById("personalPay").innerHTML="";
}
//根据住院总费用获得救助比例
function setAssPer(value){
	var perDataset = L5.DatasetMgr.lookup("perDataset");
	if(!value){
		L5.Msg.alert('提示',"请输入住院费用!");
		return false;
	}
	document.getElementById("totalExpense").value=changeTwoDecimal(value);
}
//获得救助比例
function getPer(domicileCode,assitanceType,value){
	if(value<0){
		value=0;
	}
	if(domicileCode){
		perDataset.baseParams["domicile_Code@like@String"]=domicileCode.substring(0,6);
	}
	if(assitanceType){
		perDataset.baseParams["Type@="]=assitanceType;
	}
	
	perDataset.baseParams["lower_Limit@<=@Number"]=value;
	perDataset.baseParams["upper_Limit@>=@Number"]=value;
	perDataset.baseParams["YEAR@="]=getCurDate().substring(0,4);
	perDataset.purgeListeners();
	perDataset.on('load',function(){
	
		assPer=0;
		if(perDataset.getCount()!=0){
			assPer=perDataset.get("percentage");
			document.getElementById("percentage").innerHTML=assPer+"%";
			//计算并回填费用
			assitancePay=Math.round((insuranceExpense-insurancePay-(insuranceExpense-insurancePay-illnessInsurancePay-hospotalPay)*BptPer/100-otherPay-hospotalPay)*assPer/100*100)/100;
			if(assitancePay<0){
				assitancePay=0;
			}
			if(status==0){
				assitancePay=0;
				bptAssitancePay=0;
			}
			document.getElementById("bptAssitancePay").innerHTML=changeTwoDecimal(bptAssitancePay);
			document.getElementById("assitancePay").innerHTML=changeTwoDecimal(assitancePay);
			personalPay=Math.round((totalExpense-insurancePay-illnessInsurancePay-bptAssitancePay-hospotalPay-assitancePay-otherPay)*100)/100;
			if(personalPay<0){
				personalPay=0;
			}
			document.getElementById("personalPay").innerHTML=changeTwoDecimal(personalPay);
			
			
		}else{
			assPer="未找到相关信息";
			L5.Msg.alert("提示","未找到相关救助比例信息");
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML=assPer;
		}
	
	});
	perDataset.load();
}
//获得并回填优抚救助比例
function getBptPer(SamMedicalPerDS){
	BptPer=0;
	if(SamMedicalPerDS.getCount()!=0){
		BptPer=SamMedicalPerDS.get("percentage");
		document.getElementById("bptPercentage").innerHTML=BptPer+"%";
	}else{
		BptPer="未找到相关信息";
		L5.Msg.alert("提示","未找到相关救助比例信息");
		document.getElementById("bptPercentage").innerHTML=BptPer;
	}
}
//加载封顶线方法
function getTopLine(domicileCode,assistanceType){
	var topLineDataset=L5.DatasetMgr.lookup("topLineDataset");
	topLineDataset.setParameter("domicile_Code",domicileCode);
	topLineDataset.setParameter("type",assistanceType);
	topLineDataset.setParameter("year",getCurDate().substring(0,4));
	topLineDataset.purgeListeners();
	topLineDataset.on('load',function(){
		if(topLineDataset.getCount()!=0){
			topLine=topLineDataset.get("topLine");
		}else{
			topLine="未找到相关信息";
		}
	});
	topLineDataset.load();
//	topLineDataset.on('load',setTopLine);
}
//本年历史救助信息加载
function getHistoryAss(peopleId){
	//历史救助信息加载
	var hosDataset=L5.DatasetMgr.lookup("hosDataset");
	hosDataset.baseParams["leaveTime@like@String"]=getCurDate().substring(0,4);	
	hosDataset.baseParams["peopleId"]=peopleId;
	hosDataset.load();
	hosDataset.on('load',totalPersonAssPay);
}
//个人本年补助费用
var totalPersonAssYearPay;
//计算并回填个人本年补助费用
function totalPersonAssPay(hosDataset){
	totalPersonAssYearPay=0;
	//冲账
	if(strike=="strike"){
		totalPersonAssYearPay=0-strikeRecord.get("assitancePay")*1;
	}
	var records=hosDataset.getAllRecords();
	for(i=0;i<records.length;i++){
		totalPersonAssYearPay=totalPersonAssYearPay*1+records[i].get("ASSITANCE_PAY")*1;
	}
}


function formatHospitalPay(value){
	if(!isFloat(value)){
			document.getElementById("hospitalPay").value="";
			document.getElementById("bptAssitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			document.getElementById("assitancePay").innerHTML="";
			hospitalPay="";
			L5.Msg.alert("提示","请输入数字");
			return;
	}
	document.getElementById("hospitalPay").value=formatNum(value);
	hospitalPay=value*1;
	if(assPer!="未找到相关信息"&&BptPer!="未找到相关信息"&&topLine!="未找到相关信息"&&totalExpense&&insuranceExpense&&insurancePay&&illnessInsurancePay&&hospitalPay){
		balance(value);
	}
}


//计算个人支付费用
function balance(value){
		hospotalPay=value;
		if(BptPer!=0){
			bptAssitancePay=Math.round((insuranceExpense-insurancePay-illnessInsurancePay-value)*BptPer/100*100)/100;
		}
		//bptAssitancePay=(insuranceExpense-insurancePay)*BptPer-value;
		
		if(insuranceExpense-insurancePay-hospotalPay<0){
			L5.Msg.alert('提示',"医疗补助金额过高!");
			document.getElementById("hospitalPay").value="";
			return;
		}
		//获得救助比例
	getPer(domicileCode,assitanceType,(insuranceExpense-insurancePay-(insuranceExpense-insurancePay-value)*BptPer/100-otherPay-value));
}
//保存出院信息
function save(){
	if(saveFlag==1){
		L5.Msg.alert("提示","不能重复保存出院信息！");
		return;
	}
	if(topLine=="未找到相关信息"){
		L5.Msg.alert("提示","未找到相关封顶线信息,请联系民政部门设置封顶线信息！");
		return;
	}
	if(BptPer=="未找到相关信息"){
	L5.Msg.alert("提示","未找到相关优抚救助比例信息,请联系民政部门设置优抚救助比比例！");
		return;
	}
	if(assPer=="未找到相关信息"){
	L5.Msg.alert("提示","未找到相关救助比例信息,请联系民政部门设置救助比比例！");
		return;
	}
	var mBalanceDS=L5.DatasetMgr.lookup("mBalanceDS");
	var valid = mBalanceDS.isValidate();
	var record=mBalanceDS.getCurrent();
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
		L5.Msg.alert('提示',"请填写大病保险金额!");
		return false;
	}
	if(document.getElementById("hospitalPay")==""&&(document.getElementById("hospitalPay")+"").length==0){
		L5.Msg.alert('提示',"请填写优抚医院减免!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确认保存？',function(state){
				if(state=="yes"){
					var records = mBalanceDS.getCurrent();
					records.set("totalExpense",totalExpense);
					records.set("insuranceExpense",insuranceExpense);
					records.set("insurancePay",insurancePay);
					records.set("illnessInsurancePay",illnessInsurancePay);
					records.set("leaveDate",document.getElementById("leaveDate").innerHTML);
					records.set("assitancePay",assitancePay);
					records.set("specialPay",bptAssitancePay);
					records.set("personalPay",personalPay);
					records.set("otherPay",otherPay);
					records.set("balancePeopleId",userId);
					records.set("assitancePer",assPer);
					records.set("specialPer",BptPer);
					records.set("balanceTime",getCurDate()); 
					//冲账
					if(strike=="strike"){
						//01表示新纪录
						records.set("strikeStatus","03");
						records.set("strikeBalanceId",balanceId);
						var command=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMBalanceCmd"); 
						command.setParameter("records",records);
						command.setParameter("strikeRecord",strikeRecord);
						command.execute("saveStrike");
					}else{
						var command=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMBalanceCmd"); 
						command.setParameter("records",records);
						command.setParameter("beforeRecord",beforeRecord);
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
function seePrintBptSam(){
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
			document.getElementById("bptAssitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			document.getElementById("assitancePay").innerHTML="";
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
			document.getElementById("bptAssitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			document.getElementById("assitancePay").innerHTML="";
			totalExpense="";
			return;
		}
	}
	if(insurancePay&&totalExpense){
		if(totalExpense<insurancePay){
			L5.Msg.alert("提示","住院总费用不能小于保险支付金额！");
			document.getElementById("totalExpense").value="";
			document.getElementById("bptAssitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			document.getElementById("assitancePay").innerHTML="";
			totalExpense="";
			return;
		}
	}
	if(assPer!="未找到相关信息"&&BptPer!="未找到相关信息"&&topLine!="未找到相关信息"&&totalExpense&&insuranceExpense&&insurancePay&&illnessInsurancePay&&hospitalPay){
		balance(value);
	}
}
function formatInsuranceExpense(value){
	if(!isFloat(value)){
			document.getElementById("insuranceExpense").value="";
			document.getElementById("bptAssitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			document.getElementById("assitancePay").innerHTML="";
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
			document.getElementById("bptAssitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			document.getElementById("assitancePay").innerHTML="";
			insuranceExpense="";
			return;
		}
	}
	if(insuranceExpense&&insurancePay){
		if(insuranceExpense<insurancePay){
			L5.Msg.alert("提示","纳入保险报销费用不能小于保险支付金额！");
			document.getElementById("insuranceExpense").value="";
			document.getElementById("bptAssitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			document.getElementById("assitancePay").innerHTML="";
			insuranceExpense="";
			return;
		}
	}
	if(assPer!="未找到相关信息"&&BptPer!="未找到相关信息"&&topLine!="未找到相关信息"&&totalExpense&&insuranceExpense&&insurancePay&&illnessInsurancePay&&hospitalPay){
		balance(value);
	}

}
//保险支付金额onChange事件，获得救助比例并计算费用
function formatInsurancePay(value){
	if(!isFloat(value)){
			document.getElementById("insurancePay").value="";
			document.getElementById("bptAssitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			document.getElementById("assitancePay").innerHTML="";
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
			document.getElementById("bptAssitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			document.getElementById("assitancePay").innerHTML="";
			insurancePay="";
			return;
		}
	}
	if(insurancePay&&totalExpense){
		if(totalExpense<insurancePay){
			L5.Msg.alert("提示","保险支付金额不能大于住院总费用！");
			document.getElementById("insurancePay").value="";
			document.getElementById("bptAssitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			document.getElementById("assitancePay").innerHTML="";
			insurancePay="";
			return;
		}
	}
	if(assPer!="未找到相关信息"&&BptPer!="未找到相关信息"&&topLine!="未找到相关信息"&&totalExpense&&insuranceExpense&&insurancePay&&illnessInsurancePay&&hospitalPay){
		balance(value);
	}
}
//大病保险报销onChange事件
function payChange(value){
	document.getElementById("illnessInsurancePay").value=formatNum(value);
	illnessInsurancePay=value*1;
	if(!isFloat(value)){
			document.getElementById("illnessInsurancePay").value="";
			document.getElementById("bptAssitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			document.getElementById("assitancePay").innerHTML="";
			illnessInsurancePay="";
			L5.Msg.alert("提示","请输入数字");
			return;
	}
	if(illnessInsurancePay&&insuranceExpense){
		if(insuranceExpense<illnessInsurancePay){
			L5.Msg.alert("提示","大病保险报销金额不能大于纳入保险报销费用！");
			document.getElementById("illnessInsurancePay").value="";
			document.getElementById("bptAssitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			document.getElementById("assitancePay").innerHTML="";
			illnessInsurancePay="";
			return;
		}
	}
	if(illnessInsurancePay&&totalExpense){
		if(totalExpense<illnessInsurancePay){
			L5.Msg.alert("提示","大病保险报销金额不能大于住院总费用！");
			document.getElementById("illnessInsurancePay").value="";
			document.getElementById("bptAssitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			document.getElementById("assitancePay").innerHTML="";
			illnessInsurancePay="";
			return;
		}
	}
	if(assPer!="未找到相关信息"&&BptPer!="未找到相关信息"&&topLine!="未找到相关信息"&&totalExpense&&insuranceExpense&&insurancePay&&illnessInsurancePay&&hospitalPay){
		balance(value);
	}
}