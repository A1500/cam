
//其他救助费用
var otherPay=0;
var illnessInsurancePay = 0;
var hospitalPay = 0;
var beforeRecord;
//救助对象类别
var assitanceType;
//受助状态
var status=1;
//对象属地
var domicileCode;
//对象ID
var peopleId;
//救助比例
var assPer;
//封顶线
var topLine;
//个人本年补助费用
var totalPersonAssYearPay;
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
	var mBalanceDS=L5.DatasetMgr.lookup("mBalanceDS");
	mBalanceDS.setParameter("balance_Id",balanceId);
	mBalanceDS.load();
	mBalanceDS.on('load',setAssType);
	//加载医前救助
	var beforeDS=L5.DatasetMgr.lookup("beforeDS");
	beforeDS.setParameter("PEOPLE_ID",peopleId);
	beforeDS.setParameter("STATUS",1);
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
	
	//将基本信息加载到页面
	var BaseinfoPeopleDataSet1 = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet1");
	BaseinfoPeopleDataSet1.setParameter("people_Id",peopleId);	
	BaseinfoPeopleDataSet1.purgeListeners();
	BaseinfoPeopleDataSet1.on('load',function(){
		//domicileCode = areaCode+'' ;
		domicileCode=BaseinfoPeopleDataSet1.get("domicileCode");
		peopleId=BaseinfoPeopleDataSet1.get("peopleId");
		document.getElementById("name").innerHTML=BaseinfoPeopleDataSet1.get("name");
		document.getElementById("sex").innerHTML=getDicText(SexDataset,BaseinfoPeopleDataSet1.get("sex"));
		document.getElementById("idCard").innerHTML=BaseinfoPeopleDataSet1.get("idCard");
		document.getElementById("workUnitName").innerHTML=BaseinfoPeopleDataSet1.get("workUnitName");
		document.getElementById("address").innerHTML=BaseinfoPeopleDataSet1.get("address");
		//获得封顶线
		getTopLine(domicileCode,assitanceType);
	});
	BaseinfoPeopleDataSet1.load();
	//editGridPannel单击事件
	var expGrid = L5.getCmp("expGrid");
	expGrid.on("rowclick", backExpMsg);
}
//回填从新农合系统中查询的费用信息
function backExpMsg(){
	var expGrid=L5.getCmp('expGrid');
	var selected = expGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return;
	}
	document.getElementById("assitancePay").innerHTML="";
	document.getElementById("personalPay").innerHTML="";
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
	getPer(domicileCode,assitanceType,insuranceExpense-insurancePay-otherPay-illnessInsurancePay);
	expFlg=1;
}
//加载救助对象类别
function setAssType(mBalanceDS){
	var record=mBalanceDS.getCurrent();
	//冲账
	if(strike=="strike"){
		strikeRecord=record;
	//	alert(record);
	}
	if(record.get("status")==0){
		status=0;
		L5.Msg.alert('提示',"此人已停助，本次结算不能享受补助!");
	}
	assitanceType=record.get("assitanceType");
	document.getElementById("leaveDate").value=getCurDate();
	document.getElementById("totalExpense").value="";
	document.getElementById("insuranceExpense").value="";
	document.getElementById("insurancePay").value="";
	document.getElementById("illnessInsurancePay").value="";
	document.getElementById("hospitalPay").value="";
	document.getElementById("assitancePay").innerHTML="";
	document.getElementById("personalPay").innerHTML="";
	if(needConnect){
		//调用接口加载总费用信息
		var insuranceDS=L5.DatasetMgr.lookup("insuranceDS");
		insuranceDS.setParameter("queryType","LEAVE");
		insuranceDS.setParameter("organArea",organCode);
		insuranceDS.setParameter("insuranceCode",record.get("medicalCode"));
		insuranceDS.setParameter("inDate",record.get("inDate"));
		insuranceDS.setParameter("insuranceType",record.get("insuranceType"));
		insuranceDS.load();
	}
	//人员本年历史救助信息加载
	getAss(peopleId);
}
function getAss(peopleId){
	//历史救助信息加载
	var hosDataset=L5.DatasetMgr.lookup("hosDataset");
	hosDataset.baseParams["leaveDate"]=getCurDate().substring(0,4)+"%";	
	hosDataset.baseParams["peopleId"]=peopleId;
	hosDataset.load();
	hosDataset.on('load',totalPersonAssPay);
}
//计算个人本年补助费用
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
//获得救助比例
function getPer(domicileCode,assitanceType,value){
	if(value<deductible*1){
		L5.Msg.alert("提示","未达到起付线，不给予医疗救助！起付线为（"+deductible+"）元！");
		var mBalanceDS=L5.DatasetMgr.lookup("mBalanceDS");
		mBalanceDS.set("assitancePay",0);
		mBalanceDS.set("personalPay",totalExpense-insurancePay);
		personalPay=totalExpense-insurancePay;
		document.getElementById("percentage").innerHTML="0%";
		document.getElementById("personalPay").innerHTML=changeTwoDecimal(totalExpense-insurancePay);
		document.getElementById("assitancePay").innerHTML="0.00";
		return;
	}
	if(domicileCode){
		perDataset.baseParams["domicile_Code@like@String"]=domicileCode.substring(0,6);
	}
	if(assitanceType){
		perDataset.baseParams["Type@="]=assitanceType;
	}
	perDataset.baseParams["lower_Limit@<=@Number"]=value-deductible*1;
	perDataset.baseParams["upper_Limit@>@Number"]=value-deductible*1;
	perDataset.baseParams["YEAR"]=getCurDate().substring(0,4);
	perDataset.purgeListeners();
	perDataset.on('load',function(){
		assPer=0;
		if(perDataset.getCount()!=0){
			assPer=perDataset.get("percentage");
			document.getElementById("percentage").innerHTML=assPer+"%";
			//计算并回填费用(deductible:行政区划为370784添加超出2000的才给予报销;新增加大病保险费用:illnessInsurancePay)
			assitancePay=Math.round((insuranceExpense-insurancePay-otherPay-illnessInsurancePay-deductible-hospitalPay)*assPer/100*100)/100;
		
			var leftAss=Math.round((topLine-totalPersonAssYearPay)*100)/100;
			if(leftAss<0){
				leftAss=0;
			}
			if(leftAss<=assitancePay){
				L5.Msg.alert("提示","本年救助金额已超出封顶线"+(assitancePay*1-leftAss*1)+"元！");
				assitancePay=leftAss;
			}
			if(status==0||assitancePay<0){
				assitancePay=0;
			}
			personalPay=Math.round((totalExpense-insurancePay-illnessInsurancePay-assitancePay-otherPay-hospitalPay)*100)/100;
			if(personalPay<0){
				personalPay=0;
			}
			document.getElementById("assitancePay").innerHTML=changeTwoDecimal(assitancePay);
			document.getElementById("personalPay").innerHTML=changeTwoDecimal(personalPay);
		}else{
			assPer="未找到相关信息";
			L5.Msg.alert("提示","未找到相关救助比例信息");
			document.getElementById("percentage").innerHTML=assPer;
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
		}
		
	});
	perDataset.load();
	
}
//加载封顶线方法
function getTopLine(domicileCode,assistanceType){
	var topLineDataset=L5.DatasetMgr.lookup("topLineDataset");
	topLineDataset.baseParams["YEAR"]=getCurDate().substring(0,4);
	topLineDataset.baseParams["domicile_Code@like@String"]=domicileCode.substring(0,6);
	topLineDataset.baseParams["Type@="]=assitanceType;
	topLineDataset.purgeListeners();
	topLineDataset.on('load',function(){
		if(topLineDataset.getCount()!=0){
			topLine=topLineDataset.get("topLine");
		}else{
			topLine="未找到相关信息";
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			L5.Msg.alert("提示","未找到相关封顶线信息");
		}
	});
	topLineDataset.load();
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
		L5.Msg.alert('提示',"请填写商业保险报销金额!");
		return false;
	}
	if(document.getElementById("hospitalPay").value==""&&(document.getElementById("hospitalPay").value+"").length==0){
		L5.Msg.alert('提示',"请填写医院减免金额!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确认保存？',function(state){
				if(state=="yes"){
					var records = mBalanceDS.getCurrent();
					records.set("totalExpense",totalExpense);
					records.set("insuranceExpense",insuranceExpense);
					records.set("insurancePay",insurancePay);
					records.set("illnessInsurancePay",illnessInsurancePay);
					records.set("hospitalPay",hospitalPay);
					records.set("assitancePay",assitancePay);
					records.set("leaveDate",document.getElementById("leaveDate").value);
					records.set("personalPay",personalPay);
					records.set("otherPay",otherPay);
					records.set("balancePeopleId",userId);
					records.set("assitancePer",assPer);
					records.set("balanceTime",getCurDate());
					records.set("status","2");
					//冲账
					if(strike=="strike"){
						//01表示新纪录
						records.set("strikeStatus","03");
						records.set("strikeBalanceId",balanceId);
						var command=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMBalanceCmd"); 
						command.setParameter("records",records);
						command.setParameter("strikeRecord",strikeRecord);
						command.setParameter("needConnect",needConnect);
						command.execute("saveStrike");
						balanceId =command.getReturn('balanceId');
					}else{
						var command=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMBalanceCmd"); 
						command.setParameter("records",records);
						command.setParameter("beforeRecord",beforeRecord);
						command.setParameter("needConnect",needConnect);
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
						saveFlag=0;
					}
				}else{
					return false;
				}
	});
}
//打印预览
function printBillClick(){
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
 
 ////////////////////手动输入结算///////////////////////////////
 
function formatTotal(value){
	if(!isFloat(value)){
			document.getElementById("totalExpense").value="";
			L5.Msg.alert("提示","请输入数字");
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			totalExpense="";
			return;
	}
	document.getElementById("totalExpense").value=formatNum(value);
	totalExpense=value*1;
	if(totalExpense&&insuranceExpense){
		if(totalExpense<insuranceExpense){
			L5.Msg.alert("提示","住院总费用不能小于纳入保险报销费用！");
			document.getElementById("totalExpense").value="";
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			totalExpense="";
			return;
		}
	}
	if(insurancePay&&totalExpense){
		if(totalExpense<insurancePay){
			L5.Msg.alert("提示","住院总费用不能小于保险支付金额！");
			document.getElementById("totalExpense").value="";
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			totalExpense="";
			return;
		}
	}
	if(totalExpense&&insuranceExpense&&insurancePay&&illnessInsurancePay){
		getPer(domicileCode,assitanceType,insuranceExpense-insurancePay-otherPay-illnessInsurancePay);
	}
}
function formatInsuranceExpense(value){
	if(!isFloat(value)){
			document.getElementById("insuranceExpense").value="";
			insuranceExpense="";
			L5.Msg.alert("提示","请输入数字");
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			return;
	}
	document.getElementById("insuranceExpense").value=formatNum(value);
	insuranceExpense=value*1;
	if(totalExpense&&insuranceExpense){
		if(totalExpense<insuranceExpense){
			L5.Msg.alert("提示","纳入保险报销费用不能大于住院总费用！");
			document.getElementById("insuranceExpense").value="";
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			insuranceExpense="";
			return;
		}
	}
	if(insuranceExpense&&insurancePay){
		if(insuranceExpense<insurancePay){
			L5.Msg.alert("提示","纳入保险报销费用不能小于保险支付金额！");
			document.getElementById("insuranceExpense").value="";
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			insuranceExpense="";
			return;
		}
	}
	if(totalExpense&&insuranceExpense&&insurancePay&&illnessInsurancePay){
		getPer(domicileCode,assitanceType,insuranceExpense-insurancePay-otherPay-illnessInsurancePay);
	}

}
//保险支付金额onChange事件，获得救助比例并计算费用
function balance(value){
	if(!isFloat(value)){
			document.getElementById("insurancePay").value="";
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
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
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			insurancePay="";
			return;
		}
	}
	if(insurancePay&&totalExpense){
		if(totalExpense<insurancePay){
			L5.Msg.alert("提示","保险支付金额不能大于住院总费用！");
			document.getElementById("insurancePay").value="";
			document.getElementById("percentage").innerHTML="";
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			insurancePay="";
			return;
		}
	}
	if(totalExpense&&insuranceExpense&&insurancePay&&illnessInsurancePay){
		getPer(domicileCode,assitanceType,insuranceExpense-insurancePay-otherPay-illnessInsurancePay);
	}
}
//大病保险报销onChange事件，
function balancePay(value){
	document.getElementById("illnessInsurancePay").value=formatNum(value);
	illnessInsurancePay=value*1;
	if(!isFloat(value)){
			document.getElementById("illnessInsurancePay").value="";
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			illnessInsurancePay="";
			L5.Msg.alert("提示","请输入数字");
			return;
	}
	if(illnessInsurancePay&&insuranceExpense){
		if(insuranceExpense<illnessInsurancePay){
			L5.Msg.alert("提示","商业保险报销金额不能大于纳入保险报销费用！");
			document.getElementById("illnessInsurancePay").value="";
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			illnessInsurancePay="";
			return;
		}
	}
	if(illnessInsurancePay&&totalExpense){
		if(totalExpense<illnessInsurancePay){
			L5.Msg.alert("提示","大病保险报销金额不能大于住院总费用！");
			document.getElementById("illnessInsurancePay").value="";
			document.getElementById("percentage").innerHTML="";
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			insurancePay="";
			return;
		}
	}
//	if(totalExpense&&insuranceExpense&&insurancePay&&illnessInsurancePay){
//		getPer(domicileCode,assitanceType,insuranceExpense-insurancePay-otherPay-illnessInsurancePay);
//	}
}
function payChange(){
	illnessInsurancePay=document.getElementById("illnessInsurancePay").value;
}
//医院减免onChange事件，
function balanceHospitalPay(value){
	document.getElementById("hospitalPay").value=formatNum(value);
	hospitalPay=value*1;
	if(!isFloat(value)){
			document.getElementById("hospitalPay").value="";
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			illnessInsurancePay="";
			L5.Msg.alert("提示","请输入数字");
			return;
	}
	
	if(hospitalPay&&insuranceExpense){
		if(illnessInsurancePay<hospitalPay){
			L5.Msg.alert("提示","医院减免金额不能大于纳入保险报销费用！");
			document.getElementById("illnessInsurancePay").value="";
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("percentage").innerHTML="";
			illnessInsurancePay="";
			return;
		}
	}
	
	if(hospitalPay&&totalExpense){
		if(totalExpense<hospitalPay){
			L5.Msg.alert("提示","医院减免金额不能大于住院总费用！");
			document.getElementById("hospitalPay").value="";
			document.getElementById("percentage").innerHTML="";
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			insurancePay="";
			return;
		}
	}
	if(insuranceExpense&&insurancePay&&otherPay&&percentage){
		document.getElementById("assitancePay").value=(insuranceExpense-insurancePay-otherPay-illnessInsurancePay-hospitalPay)*percentage;
	}
	if(totalExpense&&insuranceExpense&&insurancePay){
		getPer(domicileCode,assitanceType,insuranceExpense-insurancePay-otherPay-illnessInsurancePay-hospitalPay);
	}
}