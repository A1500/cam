//页面初始化
function init() {	
	L5.DatasetMgr.lookup("dsPeo");
	var familyDataset=L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
	familyDataset.newRecord();
	
}
//根据ElementId得到组件的value
function getParam(ElementId){
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}

//查询方法
function query(){
	var familyDataset=L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
	familyDataset.removeAll();
	var BaseinfoPeoDataSetMem=L5.DatasetMgr.lookup("BaseinfoPeoDataSetMem");
	BaseinfoPeoDataSetMem.removeAll();
	var hosDataset=L5.DatasetMgr.lookup("hosDataset");
	document.getElementById("address").innerHTML="";
	document.getElementById("assistanceType").innerHTML="";
	document.getElementById("homeCardNo").innerHTML="";
	
	hosDataset.removeAll();
	var dsPeo = L5.DatasetMgr.lookup("dsPeo");
	dsPeo.setParameter("hospitalId",organId);
	if(!(getParam("name")||getParam("idCard")||getParam("cardType")||getParam("cardNo"))){
		L5.Msg.alert('提示',"请输入查询条件!");
		return false;
	}else if(getParam("cardType")==4){
		if(!getParam("idCard")){
			L5.Msg.alert('提示',"请输入身份证号!");
			return false;
		}else{
			dsPeo.setParameter("assistanceType",getParam("cardType"));	
			dsPeo.setParameter("name",getParam("name"));	
			dsPeo.setParameter("idCard",getParam("idCard"));
			dsPeo.setParameter( "cardNo",getParam("cardNo"));
			dsPeo.removeAll();
			dsPeo.load();
			dsPeo.on('load',inHos);
		}
	}else if(getParam("cardType")&&getParam("cardType")!=4){
		if(!getParam("cardNo")&&!getParam("idCard")){
			L5.Msg.alert('提示',"证件编号或身份证号必须输入其中一项!");
			return false;
		}else{
			dsPeo.setParameter("assistanceType",getParam("cardType"));	
			dsPeo.setParameter("name",getParam("name"));	
			dsPeo.setParameter("idCard",getParam("idCard"));	
			dsPeo.setParameter("cardNo",getParam("cardNo"));	
			dsPeo.removeAll();
			dsPeo.load();
			dsPeo.on('load',inHos);
		}
	}else{
		if(!getParam("cardNo")&&!getParam("idCard")){
			L5.Msg.alert('提示',"证件编号或身份证号必须输入其中一项!");
			return false;
		}else{
			dsPeo.setParameter("name",getParam("name"));	
			dsPeo.setParameter("idCard",getParam("idCard"));	
			dsPeo.setParameter("cardNo",getParam("cardNo"));
			dsPeo.removeAll();
			dsPeo.load();
			dsPeo.on('load',inHos);
		}
	}
}
//用于存储查询出来的带登记人员信息
var record;
//查询后信息加载
function inHos(dsPeo){
	if(dsPeo.getCount()!=0){
		record=dsPeo.getCurrent();
		//家庭基本信息加载
		var familyDataset=L5.DatasetMgr.lookup("BaseinfoFamilyDataSet");
		familyDataset.setParameter("family_Id",record.get('FAMILY_ID'));
		familyDataset.load();
		familyDataset.on('load',backFamilyMsg);
		//家庭成员信息加载
		var BaseinfoPeoDataSetMem=L5.DatasetMgr.lookup("BaseinfoPeoDataSetMem");
		BaseinfoPeoDataSetMem.setParameter("family_Id",record.get('FAMILY_ID'));	
		BaseinfoPeoDataSetMem.load();
		//历史救助信息加载
		var hosDataset=L5.DatasetMgr.lookup("hosDataset");
		hosDataset.setParameter("historyYear",getCurDate().substring(0,4));	
		hosDataset.setParameter("peopleId",record.get('PEOPLE_ID'));
		hosDataset.load();
		//家庭救助信息加载
		getFamilyAssistance(record.get('FAMILY_ID'));
	}else{
		L5.Msg.alert("提示","没有查到您的记录");
		return false;
		
	}
}
function backFamilyMsg(familyDataset){
	if(familyDataset.getCount()!=0){
		var record=familyDataset.getCurrent();
		var address=record.get("address");
		var town="";
		var village="";
		if(record.get("village")&&record.get("town")){
			cityDataset.baseParams["ID@in@String"]=record.get("village")+","+record.get("town");
			cityDataset.purgeListeners();
			cityDataset.load();
		}
		cityDataset.on("load", function(){
			if(cityDataset.getCount()!=0){
				cityRecords=cityDataset.getAllRecords();
				for(i=0;i<cityRecords.length;i++){
					if(cityRecords[i].get("id").indexOf("000")>0){
						town=cityRecords[i].get("name");
					}else{
						village=cityRecords[i].get("name");
					}
				}
			}
			document.getElementById("address").innerHTML=town+village+address;
		});
	}
}
//家庭信息加载
function getFamilyAssistance(familyId){
	var SamFamilyAssistanceDataSet=L5.DatasetMgr.lookup("SamFamilyAssistanceDataSet");
	SamFamilyAssistanceDataSet.setParameter("family_Id",familyId);
	SamFamilyAssistanceDataSet.load();
	SamFamilyAssistanceDataSet.on('load',getAssistance);
}
//救助类型代码
var assistanceType;
//证件编号
var cardNo;
//获取救助类型、证件类型、证件编号
function getAssistance(SamFamilyAssistanceDataSet){
	assistanceType=null;
	cardNo=null;
	if(SamFamilyAssistanceDataSet.getCount()!=0){
		var records=SamFamilyAssistanceDataSet.getAllRecords();
		for(i=0;i<records.length;i++){
			//03代表受助类型为五保
			if(records[i].get("assistanceType")==03){
				assistanceType=records[i].get("assistanceType");
				cardNo=records[i].get("cardNo");
				//家庭证件信息回填
				if(assistanceType!=05){
					document.getElementById("assistanceType").innerHTML=getDicText(assitanceTypeDataset,assistanceType);
					document.getElementById("homeCardNo").innerHTML=cardNo;
				}
				return;
			}else if(records[i].get("assistanceType")==02||records[i].get("assistanceType")==01){
				assistanceType=records[i].get("assistanceType");
				cardNo=records[i].get("cardNo");
				
				//家庭证件信息回填
				if(assistanceType){
					document.getElementById("assistanceType").innerHTML=getDicText(assitanceTypeDataset,assistanceType);
					document.getElementById("homeCardNo").innerHTML=cardNo;
				}
				return;
			}else if(records[i].get("assistanceType")==11){
				assistanceType=records[i].get("assistanceType");
				cardNo=records[i].get("cardNo");
				//家庭证件信息回填
				if(assistanceType){
					document.getElementById("assistanceType").innerHTML=getDicText(assitanceTypeDataset,assistanceType);
					document.getElementById("homeCardNo").innerHTML=cardNo;
				}
			}
		}
		
	}else{
		document.getElementById("assistanceType").innerHTML="";
		document.getElementById("homeCardNo").innerHTML="";
	}
}
//医疗保险代码
var safeguardType;
//优抚证件名
var bptType;
//伤残等级
var disabilityLevelCode;
//优抚证书编号
var bptCardNo;
//加载优抚信息
function getBpt(selected){
	safeguardType=null;
	bptType=null;
	disabilityLevelCode=null;
	bptCardNo=null;
	if(selected[0].get("disabilityFlag")!=0){
			disabilityLevelCode=selected[0].get("disabilityLevelCode");
			bptType=1;
			bptCardNo=selected[0].get("disabilityNo");
			return;
		}else if(selected[0].get("dependantFlag")!=0||selected[0].get("demobilizedFlag")!=0){
			if(selected[0].get("dependantFlag")){
				bptType=2;
				bptCardNo=selected[0].get("dependantNo");
			}	
			 if(selected[0].get("demobilizedFlag")!=0){
				bptType=3;
				bptCardNo=selected[0].get("demobilizedNo");
			}
			return;	
		}else if(selected[0].get("warFlag")!=0){
			bptType=4;
			bptCardNo=selected[0].get("warNo");
		}
}
//住院登记按钮事件
function inHosReg(){
	var	insuranceDS=L5.DatasetMgr.lookup("insuranceDS");
	insuranceDS.removeAll();
	var editGrid=L5.getCmp('peoEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var SMBDataset = L5.DatasetMgr.lookup("SMBDataset");
	SMBDataset.setParameter("peopleId",selected[0].get("peopleId"));
	SMBDataset.load();
	SMBDataset.on('load',inCheck);
}
//取消住院登记窗口
function undoReg(){
	if(win==undefined){
		var win=L5.getCmp("inRegiste");
	}
	win=L5.getCmp("inRegiste");
	win.hide();
}
var insuranceType="";
//重复住院登记校验
function inCheck(SMBDataset){
	if(SMBDataset.getCount()!=0){
		L5.Msg.alert('提示',"此人已住院!");
		return false;
	}else{
		var editGrid=L5.getCmp('peoEditGridPanel');
		var selected = editGrid.getSelectionModel().getSelections();
		//加载优抚信息
		getBpt(selected);
		if(!assistanceType&&!bptType){
			L5.Msg.alert('提示',"此人没有录入相关优抚救助类型或其家庭不属于救助家庭!");
			return;
		}
		//打开登记信息窗口
		if(win==undefined){
			var win=L5.getCmp("inRegiste");
		}
		win=L5.getCmp("inRegiste");
		var ds=L5.DatasetMgr.lookup("ds");
		ds.removeAll();
		ds.newRecord();
		win.show();
		//editGridPannel单击事件
		var expGrid = L5.getCmp("insuranceGrid");
		expGrid.on("rowclick", backInsuranceMsg);
		//证件信息回填
		var SamFamilyAssistanceDataSet=L5.DatasetMgr.lookup("SamFamilyAssistanceDataSet");
		if(assistanceType!=05&&assistanceType!=undefined){
			if(bptType!=undefined){
				if(disabilityLevelCode&&assistanceType!=04){
					document.getElementById("hosCardType").innerHTML=getDicText(assitanceTypeDataset,assistanceType)+"证"+","+getDicText(disbilityLevelDataset,disabilityLevelCode)+getBptName(bptType);
					document.getElementById("hosCardNo").innerText=cardNo+","+bptCardNo;
				}else{
					document.getElementById("hosCardType").innerHTML=getDicText(assitanceTypeDataset,assistanceType)+"证"+","+getBptName(bptType);
					document.getElementById("hosCardNo").innerText=cardNo+","+bptCardNo;
				}
			}else{
				document.getElementById("hosCardType").innerHTML=getDicText(assitanceTypeDataset,assistanceType)+"证";
				document.getElementById("hosCardNo").innerText=cardNo;
			}
		}else{
			if(bptType!=undefined){
				if(disabilityLevelCode!=undefined){
					document.getElementById("hosCardType").innerHTML=getDicText(disbilityLevelDataset,disabilityLevelCode)+getBptName(bptType);
					document.getElementById("hosCardNo").innerText=bptCardNo;
				}else{
					document.getElementById("hosCardType").innerHTML=getBptName(bptType);
					document.getElementById("hosCardNo").innerText=bptCardNo;
				}
			}
		}
		
		safeguardType=selected[0].get("safeguardType");
		if(""==safeguardType){
			safeguardType="4";
		}
		ds.set("insuranceType",safeguardType);
		//document.getElementById("hosInsuranceType").innerHTML=getDicText(SafeguardDataset,safeguardType);;
		document.getElementById("hosName").innerHTML=selected[0].get("name");
		document.getElementById("hosIdCard").innerHTML=selected[0].get("idCard");
		
		document.getElementById("sex").value = selected[0].get("sex");
		document.getElementById("birthday").value = selected[0].get("birthday");
		document.getElementById("domicileCode").value = selected[0].get("domicileCode");
	}
}
//保存住院登记信息
function save(){
	var editGrid=L5.getCmp('peoEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	var ds=L5.DatasetMgr.lookup("ds");
	ds.set("hospitalRecordId",document.getElementById("hospitalRecordId").value);
	ds.set("hospitalDep",document.getElementById("hospitalDep").value);
	ds.set("disease",document.getElementById("disease").value);
	//校验
	var valid = ds.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}	
	
	var hospitalRecordId = document.getElementById('hospitalRecordId').value;
	var cmd=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMBalanceCmd"); 
	cmd.setParameter("hospitalRecordId",hospitalRecordId.trim());
	cmd.execute("checkOnlyRecordId");	
	var flag = cmd.getReturn('flag');
	
	if(flag == 'false'){
		L5.Msg.alert('提示',"住院号已经存在！");
		return false;
	}
	
    var records = ds.getCurrent();
    records.set("balanceId",document.getElementById("balanceId").value);
    records.set("familyId",selected[0].get("familyId"));
    records.set("peopleId",selected[0].get("peopleId"));
    records.set("hospitalId",document.getElementById("hospitalId").value);
    records.set("hospitalName",organName);
	records.set("status",1);
	records.set("dataSource","HIS");
	records.set("strikeStatus","00");
	records.set("hospitalArea",organCode);
	records.set("regID",userId);
	records.set("regPeople",userName);
	records.set("insuranceType",safeguardType);
	
	records.set("name",document.getElementById("hosName").innerHTML);
	records.set("idCard",document.getElementById("hosIdCard").innerHTML);
	records.set("sex",document.getElementById("sex").value);
	records.set("birthday",document.getElementById("birthday").value);
	records.set("domicileCode",document.getElementById("domicileCode").value);
	
	
		
    if(assistanceType!=05){
	    records.set("assitanceType",assistanceType);
	    records.set("samCardNo",cardNo);
    }
	if(bptType!=undefined){
		if(disabilityLevelCode!=undefined){
		    records.set("bptCardNo",bptCardNo);
		    records.set("bptType",bptType);
		    records.set("disabilityLevelCode",disabilityLevelCode);
		}else{
		    records.set("bptCardNo",bptCardNo);
		    records.set("bptType",bptType);
		}
	}
    
    
	var command=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMBalanceCmd"); 
	command.setParameter("records",records);
	command.execute("insert");	
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
		var url='jsp/ext/mbalance/manage/samMBalancePeople.jsp';
		var text = '一站结算入院备案';
		L5.forward(url,text);
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//查看家庭成员明细
function peoDetail(){
	var editGrid=L5.getCmp('peoEditGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	//显示人员详细信息窗口
	if(win==undefined){
		var win=L5.getCmp("peoDetailWin");
	}
	win=L5.getCmp("peoDetailWin");
	win.purgeListeners();
	//加载照片
	var photoc=selected[0].get("photoId");
	win.on("activate",function(){
		if(photoc!=""){
			var paths = document.location.pathname.split("/");
			L5.fly('peoPhoto').dom.src = paths[0] + '/' + paths[1]+ "/download?table=com_photo_06"+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+ photoc + "'";
		} else {
			L5.fly('peoPhoto').dom.src="";
		}
	});
	win.show();
	document.getElementById("detailCardType").innerHTML="";
	document.getElementById("detailCardNo").innerText="";
	
	//加载优抚信息
	getBpt(selected);
	//加载人员信息
	var baseinfoPeoDataSetMemDetail=L5.DatasetMgr.lookup("BaseinfoPeoDataSetMemDetail");
	baseinfoPeoDataSetMemDetail.setParameter("people_Id",selected[0].get('peopleId'));
	baseinfoPeoDataSetMemDetail.load();
	//历史救助信息加载
	var hosDataset=L5.DatasetMgr.lookup("hosDataset");
	hosDataset.setParameter("historyYear",getCurDate().substring(0,4));	
	hosDataset.setParameter("peopleId",selected[0].get('peopleId'));
	hosDataset.load();
	hosDataset.on('load',historyAssPay);
	
	cityDataset.setParameter("ID",selected[0].get('domicileCode'));
	cityDataset.purgeListeners();
	cityDataset.load();
	cityDataset.on('load',function(){
		if(cityDataset.getCount()>0){
			var cityRecord=cityDataset.getCurrent();
			document.getElementById("domicileName").innerHTML=cityRecord.get("name");
		}
	});
	//回填封顶线
		
	if(bptType!=undefined){
		document.getElementById("topLine").innerHTML="无";
	}else{
		var topLineDataset=L5.DatasetMgr.lookup("topLineDataset");
		topLineDataset.setParameter("domicile_Code",(selected[0].get('domicileCode').substring(0,6)+"000000"));
		topLineDataset.setParameter("type",assistanceType);
		topLineDataset.load();
		topLineDataset.on('load',setTopLine);
	}
	//证件信息回填
	if(assistanceType!=05&&assistanceType!=undefined){
		if(bptType!=undefined){
			if(disabilityLevelCode!=undefined){
				document.getElementById("detailCardType").innerHTML=getDicText(assitanceTypeDataset,assistanceType)+"证"+","+getDicText(disbilityLevelDataset,disabilityLevelCode)+getBptName(bptType);
				document.getElementById("detailCardNo").innerText=cardNo+","+bptCardNo;
			}else{
				document.getElementById("detailCardType").innerHTML=getDicText(assitanceTypeDataset,assistanceType)+"证"+","+getBptName(bptType);
				document.getElementById("detailCardNo").innerText=cardNo+","+bptCardNo;
			}
		}else{
			document.getElementById("detailCardType").innerHTML=getDicText(assitanceTypeDataset,assistanceType)+"证";
			document.getElementById("detailCardNo").innerText=cardNo;
		}
	}else{
		if(bptType!=undefined){
			if(disabilityLevelCode!=undefined){
				document.getElementById("detailCardType").innerHTML=getDicText(disbilityLevelDataset,disabilityLevelCode)+getBptName(bptType);
				document.getElementById("detailCardNo").innerText=bptCardNo;
			}else{
				document.getElementById("detailCardType").innerHTML=getBptName(bptType);
				document.getElementById("detailCardNo").innerText=bptCardNo;
			}
		}
	}
}
//个人本年补助费用
var totalPersonAssYearPay;
//计算并回填个人本年补助费用
function historyAssPay(hosDataset){
	totalPersonAssYearPay=0;
	var records=hosDataset.getAllRecords();
	for(i=0;i<records.length;i++){
		totalPersonAssYearPay=totalPersonAssYearPay*1+records[i].get("ASSITANCE_PAY")*1;
	}
	document.getElementById("hYearMoney").innerHTML=changeTwoDecimal(totalPersonAssYearPay);
}
//回填封顶线方法
function setTopLine(topLineDataset){
	if(topLineDataset.getCount()!=0){
		document.getElementById("topLine").innerHTML=changeTwoDecimal(topLineDataset.get("topLine"));
	}else{
		document.getElementById("topLine").innerHTML="未找到相关信息";
	}
}



//调用新农合接口查询信息
function queryFromInsurance(){
	if(!document.getElementById("medicalCode").value){
		L5.Msg.alert('提示',"请输入医疗保险号!");
		return;
	}
	if(!document.getElementById("inDate").value){
		L5.Msg.alert('提示',"请输入入院日期!");
		return;
	}
	L5.Ajax.timeout=60*1000;
	var	insuranceDS=L5.DatasetMgr.lookup("insuranceDS");
	insuranceDS.removeAll();
	insuranceDS.setParameter("organArea",organCode);
	insuranceDS.setParameter("queryType","IN");
	insuranceDS.setParameter("insuranceCode",document.getElementById("medicalCode").value);
	insuranceDS.setParameter("inDate",document.getElementById("inDate").value);
	insuranceDS.setParameter("insuranceType",safeguardType);
	insuranceDS.load();
}
//回填住院信息
function backInsuranceMsg(){
	var editGrid=L5.getCmp('insuranceGrid');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return;
	}
	if(""==selected[0].get("DISEASE")){
		ds.set("disease",selected[0].get("DISEASE_CODE"));
	} else {
		ds.set("disease",selected[0].get("DISEASE"));
	}
	ds.set("diseaseCode",selected[0].get("DISEASE_CODE"));
	ds.set("hospitalRecordId",selected[0].get("RECORD_NO"));
	ds.set("hospitalDep",selected[0].get("HOSPITAL_DEP"));
}
function validIdCard(obj){
	obj.value=obj.value.toUpperCase();
	if(is18IDCard(obj.value)){
		return true;
	}
	L5.Msg.alert('提示',"身份证号码不是合法的18位身份证号码!");
	return false;
}
function checkOnlyRecordId(){
	var hospitalRecordId = document.getElementById('hospitalRecordId').value;
	if( hospitalRecordId.trim() == '' ){
		return false;
	}
	var command=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMBalanceCmd"); 
	command.setParameter("hospitalRecordId",hospitalRecordId);
	command.setParameter("hospitalId",organId);
	command.execute("checkOnlyRecordId");	
	var flag = command.getReturn('flag');
	
	if(flag == 'false'){
		L5.Msg.alert('提示',"住院号已经存在！");
		return false;
	}else{
		return true;
	}
}