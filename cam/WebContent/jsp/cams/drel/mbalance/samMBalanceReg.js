var assPer=0;
var topLine=0;
var domicileCode="";
var totalPersonAssYearPay=0;
var assitanceType;
//页面初始化
function init(){
	mBalanceDS.newRecord();
	mBalanceDS.set("dataSource","GOV");
	mBalanceDS.set("status","2");
}

function getPeopleInfo(idCard){
	if( idCard.trim() == '' ){
		return ;
	}
	var peopleInfoDs = L5.DatasetMgr.lookup("peopleDs");
	peopleInfoDs.setParameter("idCard",idCard);
	peopleInfoDs.on('load',setPeopleInfo);
	peopleInfoDs.load();
	
}

function setPeopleInfo(peopleInfoDs){
	var peopleRecord;
	if(peopleInfoDs.getCount()!=0){
		peopleRecord=peopleInfoDs.getCurrent();
		domicileCode = peopleRecord.get("DOMICILE_CODE");
		var familyId=peopleRecord.get("FAMILY_ID");
		//getFamilyInfo(familyId);
	//	getFamilyAssistance(familyId);
		getOtherPay(peopleRecord.get("PEOPLE_ID"));
		getHisAss(peopleRecord.get("PEOPLE_ID"));
		var sex = peopleRecord.get("SEX");
		if("1"==sex){
			sex="男";
		} else if("2"==sex){
			sex="女";
		}
		document.getElementById("address").innerHTML=peopleRecord.get("ADDRESS");
		mBalanceDS.set("assitanceType",peopleRecord.get("ASSISTANCE_TYPE"));
		mBalanceDS.set("samCardNo",peopleRecord.get("CRAD_NO"));
		mBalanceDS.set("peopleId",peopleRecord.get("PEOPLE_ID"));
		mBalanceDS.set("familyId",familyId);
		document.getElementById("name").innerHTML=peopleRecord.get("NAME");
		document.getElementById("sex").innerHTML=sex;
		document.getElementById("workUnitName").innerHTML=peopleRecord.get("WORK_UNIT_NAME");
		mBalanceDS.set("insuranceType",peopleRecord.get("SAFEGUARD_TYPE"));
		
		
		var peopleInfoDs = L5.DatasetMgr.lookup("peopleDs");
		getTopLine(peopleInfoDs.get("DOMICILE_CODE"),mBalanceDS.get("assitanceType"));
	} else {
		L5.Msg.alert("提示","未查询到相关人员信息");
		return false;
	}
}

function getFamilyInfo(familyId){
	var familyInfoDs = L5.DatasetMgr.lookup("familyDs");
	familyInfoDs.setParameter("family_Id",familyId);
	familyInfoDs.on('load',setFamilyInfo);
	familyInfoDs.load();
}

function setFamilyInfo(familyInfoDs){
	familyInfoRecord=familyInfoDs.getCurrent();
	domicileCode=familyInfoRecord.get("DOMICILE_CODE");
	document.getElementById("address").innerHTML=familyInfoRecord.get("address");
}

function getFamilyAssistance(familyId){
	var assistanceDs=L5.DatasetMgr.lookup("familyAssistanceDs");
	assistanceDs.setParameter("FAMILY_ID",familyId);
	assistanceDs.on('load',setAssistance);
	assistanceDs.load();	
}

function setAssistance(assistanceDs){
	if(assistanceDs.getCount()!=0){
		var records=assistanceDs.getAllRecords();
		for(i=0;i<records.length;i++){
			if("01,02,03".indexOf(records[i].get("assistanceType"))>=0){
				mBalanceDS.set("assitanceType",records[i].get("assistanceType"));
				mBalanceDS.set("samCardNo",records[i].get("cardNo"));
				break;
			}
		}
		var peopleInfoDs = L5.DatasetMgr.lookup("peopleDs");
		getTopLine(peopleInfoDs.get("DOMICILE_CODE"),mBalanceDS.get("assitanceType"));
		assitanceType = mBalanceDS.get("assitanceType");
	}
}

function getOtherPay(peopleId){
	var beforeDs=L5.DatasetMgr.lookup("beforeDs");
	beforeDs.setParameter("PEOPLE_ID",peopleId);
	beforeDs.setParameter("STATUS",1);
	beforeDs.on("load",setOtherPay);	
	beforeDs.load();	
}
function setOtherPay(beforeDs){
	if(beforeDs.getCount()!=0){
		beforeRecord=beforeDs.getCurrent();
		mBalanceDS.set("otherPay",beforeRecord.get("assitanceMon"));
		document.getElementById("otherPay").innerHTML=changeTwoDecimal(beforeRecord.get("assitanceMon"));
	}else{
		mBalanceDS.set("otherPay","0");
		document.getElementById("otherPay").innerHTML="0.00";
	}	
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
	if(assitanceType && domicileCode){
		getTopLine(domicileCode,assitanceType);
	}	
	perDataset.baseParams["lower_Limit@<@Number"]=value;
	perDataset.baseParams["upper_Limit@>=@Number"]=value;
	perDataset.baseParams["YEAR@="]=getCurDate().substring(0,4);
	perDataset.purgeListeners();
	perDataset.on('load',function(){	
		assPer=0;
		if(perDataset.getCount()!=0){
			assPer=perDataset.get("percentage");
			document.getElementById("assitancePer").innerHTML=assPer;
			mBalanceDS.set("assitancePer",assPer);
			//计算并回填费用
			var assitancePay=Math.round((mBalanceDS.get("insuranceExpense")-mBalanceDS.get("insurancePay")-mBalanceDS.get("otherPay")-mBalanceDS.get("illnessInsurancePay")-mBalanceDS.get("hospitalPay"))*assPer/100*100)/100;
			if(assitancePay<0){
				assitancePay=0;
			}
			var shouldPay = topLine-totalPersonAssYearPay;
			if(assitancePay<shouldPay){
			    document.getElementById("assitancePay").innerHTML=changeTwoDecimal(assitancePay);
			    mBalanceDS.set("assitancePay",assitancePay);
			} else {
			    if(shouldPay>0){
				    document.getElementById("assitancePay").innerHTML=changeTwoDecimal(topLine-totalPersonAssYearPay);
				    assitancePay=topLine-totalPersonAssYearPay;
				    mBalanceDS.set("assitancePay",topLine-totalPersonAssYearPay);
				} else {
					mBalanceDS.set("assitancePay",0);
				    document.getElementById("assitancePay").innerHTML="0.00";
				    assitancePay=0;
				    
				}
			    
			}
			
			var personalPay=Math.round((mBalanceDS.get("totalExpense")-mBalanceDS.get("insurancePay")-assitancePay-mBalanceDS.get("otherPay")-mBalanceDS.get("illnessInsurancePay")-mBalanceDS.get("hospitalPay"))*100)/100;
			
			if(personalPay<0){
				personalPay=0;
			}
			mBalanceDS.set("personalPay",personalPay);
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

function getHisAss(peopleId){
	//历史救助信息加载
	var hisAss=L5.DatasetMgr.lookup("hisDs");
	hisAss.baseParams["peopleId"]=peopleId;
	hisAss.load();
	hisAss.on('load',totalPersonAssPay);
}
//计算个人本年补助费用
function totalPersonAssPay(hisAss){
	totalPersonAssYearPay=0;
	if(hisAss.getTotalCount>0){
		totalPersonAssYearPay=hisAss.get("yearAssistance")
	}
}
//加载封顶线方法
function getTopLine(domicileCode,assistanceType){
	var topLineDataset=L5.DatasetMgr.lookup("topLineDataset");
	topLineDataset.setParameter("domicile_Code",domicileCode.substring(0,6)+"000000");
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
	if(assPer!="未找到相关信息"&&topLine!="未找到相关信息"&&totalExpense&&insuranceExpense&&insurancePay&&hospitalPay){
		balance(value);
	}
}


//计算个人支付费用
function balance(value){
	var mBalanceDS=L5.DatasetMgr.lookup("mBalanceDS");	
	var totalExpense=document.getElementById("totalExpense").value*1;
	var insuranceExpense=document.getElementById("insuranceExpense").value*1;
	var insurancePay=document.getElementById("insurancePay").value*1;
	var illnessInsurancePay = document.getElementById("illnessInsurancePay").value*1;
	var hospitalPay = document.getElementById("hospitalPay").value*1;
	if(""==totalExpense||""==insuranceExpense||""==insurancePay || ""== illnessInsurancePay || ""==hospitalPay){
		return ;
	}
	if(insuranceExpense<insurancePay){
		L5.Msg.alert("提示","保险支付金额不能大于纳入保险报销费用！");
		mBalanceDS.set("personalPay","");
		mBalanceDS.set("assitancePay","");
		mBalanceDS.set("assitancePer","");
		return;
	}
	if(totalExpense<insurancePay){
		L5.Msg.alert("提示","保险支付金额不能大于住院总费用！");
		mBalanceDS.set("personalPay","");
		mBalanceDS.set("assitancePay","");
		mBalanceDS.set("assitancePer","");
		return;
	}
	if(totalExpense<illnessInsurancePay){
		L5.Msg.alert("提示","商业保险支付金额不能大于住院总费用！");
		mBalanceDS.set("personalPay","");
		mBalanceDS.set("assitancePay","");
		mBalanceDS.set("assitancePer","");
		return;
	}
	if(insuranceExpense<illnessInsurancePay){
		L5.Msg.alert("提示","商业保险支付金额不能大于纳入保险报销费用！");
		mBalanceDS.set("personalPay","");
		mBalanceDS.set("assitancePay","");
		mBalanceDS.set("assitancePer","");
		return;
	}
	if(totalExpense<hospitalPay){
		L5.Msg.alert("提示","医院减免支付金额不能大于住院总费用！");
		mBalanceDS.set("personalPay","");
		mBalanceDS.set("assitancePay","");
		mBalanceDS.set("assitancePer","");
		return;
	}
	if(insuranceExpense<hospitalPay){
		L5.Msg.alert("提示","医院减免支付金额不能大于纳入保险报销费用！");
		mBalanceDS.set("personalPay","");
		mBalanceDS.set("assitancePay","");
		mBalanceDS.set("assitancePer","");
		return;
	}
	getPer(domicileCode,mBalanceDS.get("assitanceType"),insuranceExpense-insurancePay-otherPay);
}
//保存出院信息
function save(){
	var mBalanceDS=L5.DatasetMgr.lookup("mBalanceDS");beforeDs=L5.DatasetMgr.lookup("beforeDs");
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
	var command=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMBalanceCmd"); 
	command.setParameter("records",record);
	command.setParameter("beforeRecord",beforeDs.getCurrent());
	command.execute("reg");
	if (!command.error) {
		L5.MessageBox.confirm('确定', '保存成功，是否继续录入？',function(state){
			if(state=="yes"){
				document.getElementById("idCard").value="";
				document.getElementById("name").innerHTML="";
				document.getElementById("sex").innerHTML="";
				document.getElementById("workUnitName").innerHTML="";
				document.getElementById("address").innerHTML="";
				var mBalanceDS=L5.DatasetMgr.lookup("mBalanceDS");
				mBalanceDS.removeAll();
				mBalanceDS.newRecord();
			} else {
				back();
			}	
			
		});
		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
	
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
function back() {	 	
	var data=null;
	var url='jsp/cams/drel/mbalance/samMBalanceRegList.jsp';
	var text = '结算登记';
	L5.forward(url,text,data);	 
 }
//////////////////////////////////手动输入计算费用///////////////////////////////////////
 
 function formatTotal(value){
	 var mBalanceDS=L5.DatasetMgr.lookup("mBalanceDS");
	 if(!isFloat(value)){
		L5.Msg.alert("提示","请输入数字");
		return;
	 }
	 document.getElementById("totalExpense").value=formatNum(value);
	 balance(value);
}
function formatInsuranceExpense(value){
	var mBalanceDS=L5.DatasetMgr.lookup("mBalanceDS");
	if(!isFloat(value)){
		L5.Msg.alert("提示","请输入数字");
		return;
	}
	document.getElementById("insuranceExpense").value=formatNum(value);
	balance(value);
}

function formatIllnessInsurancePay(value){
	var mBalanceDS=L5.DatasetMgr.lookup("mBalanceDS");
	if(!isFloat(value)){
		L5.Msg.alert("提示","请输入数字");
		return;
	}
	document.getElementById("illnessInsurancePay").value=formatNum(value);
	balance(value);
}


//保险支付金额onChange事件，获得救助比例并计算费用
function formatInsurancePay(value){
	var mBalanceDS=L5.DatasetMgr.lookup("mBalanceDS");
	if(!isFloat(value)){
		L5.Msg.alert("提示","请输入数字");
		return;
	}
	document.getElementById("insurancePay").value=formatNum(value);
	balance(value);
}

//大病保险报销onChange事件，
function balancePay(value){
	var insuranceExpense=document.getElementById("insuranceExpense").value*1;
	var totalExpense=document.getElementById("totalExpense").value*1;
	document.getElementById("illnessInsurancePay").value=formatNum(value);
	illnessInsurancePay=value*1;
	if(!isFloat(value)){
			document.getElementById("illnessInsurancePay").value="";
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("assitancePer").innerHTML="";
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
			document.getElementById("assitancePer").innerHTML="";
			illnessInsurancePay="";
			return;
		}
	}
	if(illnessInsurancePay&&totalExpense){
		if(totalExpense<illnessInsurancePay){
			L5.Msg.alert("提示","商业保险报销金额不能大于住院总费用！");
			document.getElementById("illnessInsurancePay").value="";
			document.getElementById("assitancePer").innerHTML="";
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			insurancePay="";
			return;
		}
	}
}

//医院减免onChange事件，
function balanceHospitalPay(value){
	var totalExpense=document.getElementById("totalExpense").value*1; 
	var insuranceExpense=document.getElementById("insuranceExpense").value*1;
	var insurancePay=document.getElementById("insurancePay").value*1;
	var assitancePer=document.getElementById("assitancePer").value*1;
	document.getElementById("hospitalPay").value=formatNum(value);
	hospitalPay=value*1;
	if(!isFloat(value)){
			document.getElementById("hospitalPay").value="";
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("assitancePer").innerHTML="";
			illnessInsurancePay="";
			L5.Msg.alert("提示","请输入数字");
			return;
	}
	
	if(hospitalPay&&insuranceExpense){
		if(insuranceExpense<hospitalPay){
			L5.Msg.alert("提示","医院减免金额不能大于纳入保险报销费用！");
			document.getElementById("illnessInsurancePay").value="";
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			document.getElementById("assitancePer").innerHTML="";
			illnessInsurancePay="";
			return;
		}
	}
	
	if(hospitalPay&&totalExpense){
		if(totalExpense<hospitalPay){
			L5.Msg.alert("提示","医院减免金额不能大于住院总费用！");
			document.getElementById("hospitalPay").value="";
			document.getElementById("assitancePer").innerHTML="";
			document.getElementById("assitancePay").innerHTML="";
			document.getElementById("personalPay").innerHTML="";
			insurancePay="";
			return;
		}
	}
	if(totalExpense&&insuranceExpense&&insurancePay){
		getPer(domicileCode,assitanceType,insuranceExpense-insurancePay-otherPay-illnessInsurancePay-hospitalPay);
	}
}