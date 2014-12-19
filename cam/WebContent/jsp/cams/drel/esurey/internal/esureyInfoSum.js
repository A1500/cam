//页面初始化方法
function init(){
	document.getElementById('exportOrg').innerHTML=exportOrg;
	document.getElementById('nowTime').innerHTML=nowTime;
    domicileDataset.setParameter("filterSql"," id like '"+organCode.substring(0,4)+"%000000'");
	domicileDataset.load();
	//家庭信息SamEsureyFamilyIncomeDS
	var esureyFamilyDS=L5.DatasetMgr.lookup("esureyFamilyDS");
	esureyFamilyDS.baseParams['FAMILY_ID@=']=familyId;	
	esureyFamilyDS.load();
	//家庭成员信息
	var esureyPeopleDS=L5.DatasetMgr.lookup("esureyPeopleDS");
	esureyPeopleDS.baseParams['FAMILY_ID@=']=familyId;
	esureyPeopleDS.load();
	//赡养关系信息
	var esureyRelationDS=L5.DatasetMgr.lookup("esureyRelationDS");
	esureyRelationDS.baseParams['FAMILY_ID@=']=familyId;
	esureyRelationDS.load();
	esureyRelationDS.on("load",backPeople);
	familyIds1=familyId;
	familyIds=familyId;
	
	
}
//家庭Id字符串
var familyIds1="";
var familyIds="";
//加载赡养家庭Id
function backPeople(esureyRelationDS){
	var num=esureyRelationDS.getCount();
	if(num==0){
		//加载家庭月收入
		var SamEsureyFamilyIncomeDS=L5.DatasetMgr.lookup("SamEsureyFamilyIncomeDS");
		SamEsureyFamilyIncomeDS.setParameter("familyId",familyIds);
		SamEsureyFamilyIncomeDS.load();
		SamEsureyFamilyIncomeDS.on('load',backIncome);
		//加载家庭成员
		var esureyRelPeopleDS=L5.DatasetMgr.lookup("esureyRelPeopleDS");
		esureyRelPeopleDS.baseParams["family_Id@in@String"]=familyIds1;
		esureyRelPeopleDS.load();
		esureyRelPeopleDS.on('load',backPeopleIds);
		return;
	}
	var records=esureyRelationDS.getAllRecords();
	var relPeoIds=records[0].get("peopleId");
	for(i=0;i<num;i++){
		familyIds=familyIds+"','"+records[i].get("supportFamilyId");
		familyIds1=familyIds1+","+records[i].get("supportFamilyId");
		if(i>0){
			relPeoIds=relPeoIds+","+records[i].get("peopleId");
		}
	}
	//加载家庭月收入
	var SamEsureyFamilyIncomeDS=L5.DatasetMgr.lookup("SamEsureyFamilyIncomeDS");
	SamEsureyFamilyIncomeDS.setParameter("familyId",familyIds);
	SamEsureyFamilyIncomeDS.load();
	SamEsureyFamilyIncomeDS.on('load',backIncome);
	//加载家庭成员
	var esureyRelPeopleDS=L5.DatasetMgr.lookup("esureyRelPeopleDS");
	esureyRelPeopleDS.baseParams["family_Id@in@String"]=familyIds1;
	esureyRelPeopleDS.load();
	esureyRelPeopleDS.on('load',backPeopleIds);
	var esureyPeopleDS3=L5.DatasetMgr.lookup("esureyPeopleDS3");
	esureyPeopleDS3.baseParams["PEOPLE_ID@in@String"]=relPeoIds;	
	esureyPeopleDS3.load();
}
//核对家庭收入
var familyIncome=0;
//家庭总财产
var familyWorth=0;
//赡养费用
var relIncome=0;
//赡养家庭收入
var relFamilyIncome=0;
//赡养家庭人口数
var relPeoNum=1;
//家庭人口数
var peoNum=1;
//计算家庭收入
function backIncome(SamEsureyFamilyIncomeDS){
	if(SamEsureyFamilyIncomeDS.getCount()!=0){
		var records=SamEsureyFamilyIncomeDS.getAllRecords();
		for(var i=0;i<records.length;i++){
			if(records[i].get("FAMILY_ID")==familyId){
				peoNum=records[i].get("PEOPLE_NUM");
				familyIncome=records[i].get("MONEY");
				
				familyWorth=records[i].get("WORTH");
				document.getElementById("extfamilyWorth").value=formatNum(familyWorth);
				
				document.getElementById("extmonthIncome").value=formatNum(familyIncome+relIncome);
				document.getElementById("extyearIncome").value=formatNum((familyIncome+relIncome)*12);
				document.getElementById("extyearSupportMon").value=formatNum(relIncome*12);
				document.getElementById("extmonthSupportMon").value=formatNum(relIncome);
			}else{
				relFamilyIncome=records[i].get("MONEY");
				relPeoNum=records[i].get("PEOPLE_NUM");
				if(records[i].get("DOMICILE_TYPE")==0){
					//农村户口
					var lowStandard=getLowStandard(getCurDate().substring(0,4),records[i].get("FAMILY_ADDRESS"),"02");
				}else{
					//城市户口
					var lowStandard=getLowStandard(getCurDate().substring(0,4),records[i].get("FAMILY_ADDRESS"),"01");
					
				}
			}
		}
		document.getElementById("extyearAverageIncome").value=formatNum(familyIncome*12/peoNum);
		document.getElementById("extmonthAverageIncome").value=formatNum(familyIncome/peoNum);
		checkIsLow();
	}else{
		document.getElementById("extyearAverageIncome").value=formatNum(0);
		document.getElementById("extmonthAverageIncome").value=formatNum(0);
		document.getElementById("extmonthIncome").value=formatNum(0);
		document.getElementById("extyearIncome").value=formatNum(0);
		document.getElementById("extyearSupportMon").value=formatNum(0);
		document.getElementById("extmonthSupportMon").value=formatNum(0);
	}
}
var lowIncomeAvgMonth=0;
//检查是否为低收入家庭
function checkIsLow(){
	getLowIncome();
}
//低收入类型家庭改变的时候
function checkLowIncomeType(value){
	if(value=="D1"){
		document.getElementById("validPeriod").disabled=false;
		document.getElementById("validPeriod").value="03";
		checkValidDate(document.getElementById("validPeriod").value);
	}else if(value=="D2"){
		document.getElementById("validPeriod").disabled=false;
		document.getElementById("validPeriod").value="03";
		checkValidDate(document.getElementById("validPeriod").value);
	}else{
		document.getElementById("validPeriod").value="";
		document.getElementById("validPeriod").disabled=true;
		checkValidDate(document.getElementById("validPeriod").value);
	}
}
//加载低收入标准
function getLowIncome(){
	var esureyFamilyDS=L5.DatasetMgr.lookup("esureyFamilyDS");
	var domicileType=esureyFamilyDS.get('domicileType');
	if(domicileType=="0"){
		lowStandardDs.setParameter("ASSITANCE_TYPE",'D1');
	}else if(domicileType=="1"){
		lowStandardDs.setParameter("ASSITANCE_TYPE",'D2');
	}else{
	}
	//lowStandardDs.setParameter("ASSITANCE_TYPE",'D1');
	lowStandardDs.setParameter("IN_USE",'1');
	lowStandardDs.on('load',backLowIncomeStand);
	lowStandardDs.load();
}
function backLowIncomeStand(lowStandardDs){
	if(lowStandardDs.getCount()!=0){
		var record=lowStandardDs.getCurrent();
		lowStandards=record.get("lowStandards");
		if(record.get("assitanceType")=="D1"){
			lowIncomeAvgMonth=lowStandards;
		}else{
			lowIncomeAvgMonth=lowStandards/12;
		}
		var extmonthAverageIncome=document.getElementById("extmonthAverageIncome").value;
		if(extmonthAverageIncome>lowIncomeAvgMonth){
		document.getElementById("lowIncomeType").value="";
		}else{
			if(record.get("assitanceType")=="D1"){
				document.getElementById("lowIncomeType").value="D1";
				document.getElementById("validPeriod").disabled=false;
				document.getElementById("validPeriod").value="03";
				checkValidDate(document.getElementById("validPeriod").value);
			}else {
				document.getElementById("lowIncomeType").value="D2";
				document.getElementById("validPeriod").disabled=false;
				document.getElementById("validPeriod").value="03";
				checkValidDate(document.getElementById("validPeriod").value);
			}
		}
	}else{
		L5.MessageBox.alert("提示","低收入家庭标准未设置，请先设置！");
	}
	
}

//根据有效期限计算有效期至
function checkValidDate(value){
	//var date=new Date(nowMonth.substring(0,4),nowMonth.substring(5,7));
	var date=new Date();
	if(value=="01"){
		//date.setTime(date.getTime() + 3 *30* 24 * 60 * 60 * 1000);
		date.setMonth(date.getMonth()+3);
		//date.setDate(date.getDate()-1);
		document.getElementById("validDate").value=date;
	}else if(value=="02"){
		date.setMonth(date.getMonth()+6);
		//date.setDate(date.getDate()-1);
		document.getElementById("validDate").value=date;
	}else if(value=="03"){
		date.setYear(date.getYear()+1);
		//date.setDate(date.getDate()-1);
		document.getElementById("validDate").value=date;
	}else{
		document.getElementById("validDate").value="";
	}	
}
//加载低保标准
function getLowStandard(year,apanageCode,familyType){
	var lowStandardDs=L5.DatasetMgr.lookup("lowStandardDs");
	lowStandardDs.baseParams["VALID_YEAR"]=year;
	lowStandardDs.baseParams["DOMICILE_CODE@like@String"]=apanageCode.substring(0,6);
	lowStandardDs.baseParams["ASSITANCE_TYPE"]=familyType;
	lowStandardDs.on('load',backLowStand);
	lowStandardDs.load();
	
}
function backLowStand(lowStandardDs){
	if(lowStandardDs.getCount()!=0){
		var record=lowStandardDs.getCurrent();
		if(record.get("assitanceType")=="02"){
			relIncome=relIncome+(relFamilyIncome/relPeoNum*1-record.get("lowStandards")/12)*0.3;
		}else{
			relIncome=relIncome+(relFamilyIncome/relPeoNum*1-record.get("lowStandards")*1)*0.5;
		}
		document.getElementById("extmonthIncome").value=formatNum(familyIncome+relIncome);
		document.getElementById("extyearIncome").value=formatNum((familyIncome+relIncome)*12);
		document.getElementById("extyearSupportMon").value=formatNum(relIncome*12);
		document.getElementById("extmonthSupportMon").value=formatNum(relIncome);
		return record.get("lowStandars");
		
	}else{
		L5.MessageBox.alert("提示","低保标准未设置，请先设置！");
	}
}
//人员Id字符串
var peopleIds="";
//根据familyId获得家庭成员Id字符串
function backPeopleIds(esureyRelPeopleDS){
	if(esureyRelPeopleDS.getCount()!=0){
		var peopleRecords=esureyRelPeopleDS.getAllRecords();
		peopleIds=peopleRecords[0].get("peopleId");
		if(esureyRelPeopleDS.getCount()>0){
			for(i=1;i<peopleRecords.length;i++){
				peopleIds=peopleIds+"','"+peopleRecords[i].get("peopleId");
			}
		}
		//加载家庭成员月收入
		var SamEsureyPeoIncomeDS=L5.DatasetMgr.lookup("SamEsureyPeoIncomeDS");
		SamEsureyPeoIncomeDS.setParameter("peopleId",peopleIds);
		SamEsureyPeoIncomeDS.load()
	}
}
//赡养家庭收入
var relFamilyIncom=0;
//赡养费用
var relIncom=0;
function backRelIncome(SamEsureyFamilyIncomeDS){
	if(SamEsureyFamilyIncomeDS.getCount()!=0){
		var record=SamEsureyFamilyIncomeDS.getCurrent();
		relFamilyIncom=record.get("MONEY");
	}
}
/**
 *  事件处理：点击户主姓名链接
 *
 */
function peopleDetailHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:peopleDetail(\''+record.data["peopleId"]+'\')">' + value + '</a>';
}
//困难家庭查看
function detail_people(){
	var cells;
	var jtcyGridPanel = L5.getCmp('jtcyGridPanel');
	jtcyGridPanel.stopEditing();
	cells= jtcyGridPanel.getSelectionModel().getSelections();	
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要查看的记录！");
		return;
	}
	var peopleId=cells[0].get("peopleId");
	peopleDetail(peopleId);
}
//赡养家庭查看
function detail_people1(){
	var jtcysfGridPanel = L5.getCmp('jtcysfGridPanel');
	jtcysfGridPanel.stopEditing();
	cells= jtcysfGridPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要查看的记录！");
		return;
	}
	var peopleId=cells[0].get("peopleId");
	peopleDetail(peopleId);
}
//赡养家庭成员查看
function detail_people2(){
	var supPeoplePanel = L5.getCmp('supPeoplePanel');
	supPeoplePanel.stopEditing();
	cells= supPeoplePanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要查看的记录！");
		return;
	}
	var peopleId=cells[0].get("peopleId");
	peopleDetail(peopleId);
	
}
//回填人员收入
function backPeoIncome(SamEsureyPeoIncomeDS){
	if(SamEsureyPeoIncomeDS.getCount()>0){
		var record=SamEsureyPeoIncomeDS.getCurrent();
		document.getElementById("extincomeYear").value=formatNum(record.get("MONEY")*12);
		document.getElementById("extincomeMonth").value=formatNum(record.get("MONEY"));
	}else{
		document.getElementById("extincomeYear").value=formatNum(0);
		document.getElementById("extincomeMonth").value=formatNum(0);
	}
}
//查看人员信息
function peopleDetail(peopleId){
	var win=L5.getCmp('jtcyEdit');
	win.x = 0;
	win.y = 0;
	win.width = document.body.clientWidth;
	win.height = document.body.clientHeight;
	win.draggable = false;	
	win.show();
	L5.getCmp("jtcyTabpanel").setActiveTab("2");
	L5.getCmp("jtcyTabpanel").setActiveTab("0");
	//加载家庭成员月收入
	var SamEsureyPeoIncomeDS=L5.DatasetMgr.lookup("SamEsureyPeoIncomeDS");
	SamEsureyPeoIncomeDS.setParameter("peopleId",peopleId);
	SamEsureyPeoIncomeDS.load();
	SamEsureyPeoIncomeDS.on('load',backPeoIncome);
//	for(i=0;i<peopleIdsForIncom.length;i++){
//		if(peopleId==peopleIdsForIncom[i]){
//			document.getElementById("incomeYear").value=peoplesMonthIncome[i]*12;
//			document.getElementById("incomeMonth").value=peoplesMonthIncome[i];
//		}	
//	}
	//人员信息
	var esureyPeopleDS2=L5.DatasetMgr.lookup("esureyPeopleDS2");
	esureyPeopleDS2.baseParams['PEOPLE_ID@=']=peopleId;
	esureyPeopleDS2.on("load",queryMess);
	esureyPeopleDS2.load();
	//社保
	var SamEsureySocialDS=L5.DatasetMgr.lookup('SamEsureySocialDS');
	SamEsureySocialDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureySocialDS.baseParams['TYPE@=']='1';
	SamEsureySocialDS.load();
	//财产收入
	var SamEsureyPeopleEstateDS=L5.DatasetMgr.lookup('SamEsureyPeopleEstateDS');
	SamEsureyPeopleEstateDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyPeopleEstateDS.baseParams['TYPE@=']='1';
	SamEsureyPeopleEstateDS.load();
	//房屋
	var SamEsureyHouseDS=L5.DatasetMgr.lookup('SamEsureyHouseDS');
	SamEsureyHouseDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyHouseDS.baseParams['TYPE@=']='1';
	SamEsureyHouseDS.load();
	//工商信息
	var SamEsureyBusinessDS=L5.DatasetMgr.lookup('SamEsureyBusinessDS');
	SamEsureyBusinessDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyBusinessDS.baseParams['TYPE@=']='1';
	SamEsureyBusinessDS.load();
	//车辆信息
	var SamEsureyCarDS=L5.DatasetMgr.lookup('SamEsureyCarDS');
	SamEsureyCarDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyCarDS.baseParams['TYPE@=']='1';
	SamEsureyCarDS.load();		
	//国税/地税信息
	var SamEsureyTaxDS=L5.DatasetMgr.lookup('SamEsureyTaxDS');
	SamEsureyTaxDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyTaxDS.baseParams['TYPE@=']='1';
	SamEsureyTaxDS.load();				
	// 公积金信息
	var SamEsureyHousingFundDS=L5.DatasetMgr.lookup('SamEsureyHousingFundDS');
	SamEsureyHousingFundDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyHousingFundDS.baseParams['TYPE@=']='1';
	SamEsureyHousingFundDS.load();						
	// 人行信息
	var SamEsureyBankDS=L5.DatasetMgr.lookup('SamEsureyBankDS');
	SamEsureyBankDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyBankDS.baseParams['TYPE@=']='1';
	SamEsureyBankDS.load();								
	// 证监信息
	var SamEsureySecuritiesDS=L5.DatasetMgr.lookup('SamEsureySecuritiesDS');
	SamEsureySecuritiesDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureySecuritiesDS.baseParams['TYPE@=']='1';
	SamEsureySecuritiesDS.load();										
	// 保监信息
	var SamEsureyInsuranceDS=L5.DatasetMgr.lookup('SamEsureyInsuranceDS');
	SamEsureyInsuranceDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyInsuranceDS.baseParams['TYPE@=']='1';
	SamEsureyInsuranceDS.load();
	//人员信息
	var esureyPeopleDS2=L5.DatasetMgr.lookup("esureyPeopleDS2");
	esureyPeopleDS2.baseParams['PEOPLE_ID@=']=peopleId;
	esureyPeopleDS2.on("load",queryMess);
	esureyPeopleDS2.load();
	
	
	//外部单位填报经济信息加载
	//社保
	var SamEsureySocialExtDS=L5.DatasetMgr.lookup('SamEsureySocialExtDS');
	SamEsureySocialExtDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureySocialExtDS.baseParams['TYPE@=']='2';
	SamEsureySocialExtDS.load();
	//财产收入
	var SamEsureyPeopleEstateExtDS=L5.DatasetMgr.lookup('SamEsureyPeopleEstateExtDS');
	SamEsureyPeopleEstateExtDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyPeopleEstateExtDS.baseParams['TYPE@=']='2';
	SamEsureyPeopleEstateExtDS.load();
	//房屋
	var SamEsureyHouseExtDS=L5.DatasetMgr.lookup('SamEsureyHouseExtDS');
	SamEsureyHouseExtDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyHouseExtDS.baseParams['TYPE@=']='2';
	SamEsureyHouseExtDS.load();
	//工商信息
	var SamEsureyBusinessExtDS=L5.DatasetMgr.lookup('SamEsureyBusinessExtDS');
	SamEsureyBusinessExtDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyBusinessExtDS.baseParams['TYPE@=']='2';
	SamEsureyBusinessExtDS.load();
	//车辆信息
	var SamEsureyCarExtDS=L5.DatasetMgr.lookup('SamEsureyCarExtDS');
	SamEsureyCarExtDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyCarExtDS.baseParams['TYPE@=']='2';
	SamEsureyCarExtDS.load();		
	//国税/地税信息
	var SamEsureyTaxExtDS=L5.DatasetMgr.lookup('SamEsureyTaxExtDS');
	SamEsureyTaxExtDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyTaxExtDS.baseParams['TYPE@=']='2';
	SamEsureyTaxExtDS.load();				
	// 公积金信息
	var SamEsureyHousingFundExtDS=L5.DatasetMgr.lookup('SamEsureyHousingFundExtDS');
	SamEsureyHousingFundExtDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyHousingFundExtDS.baseParams['TYPE@=']='2';
	SamEsureyHousingFundExtDS.load();						
	// 人行信息
	var SamEsureyBankExtDS=L5.DatasetMgr.lookup('SamEsureyBankExtDS');
	SamEsureyBankExtDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyBankExtDS.load();								
	// 证监信息
	var SamEsureySecuritiesExtDS=L5.DatasetMgr.lookup('SamEsureySecuritiesExtDS');
	SamEsureySecuritiesExtDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureySecuritiesExtDS.baseParams['TYPE@=']='2';
	SamEsureySecuritiesExtDS.load();										
	// 保监信息
	var SamEsureyInsuranceExtDS=L5.DatasetMgr.lookup('SamEsureyInsuranceExtDS');
	SamEsureyInsuranceExtDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyInsuranceExtDS.baseParams['TYPE@=']='2';
	SamEsureyInsuranceExtDS.load();
}
function hide_win(){
	var win=L5.getCmp("jtcyEdit");
	win.hide();
}
function queryMess(){
	var esureyPeopleDS2=L5.DatasetMgr.lookup("esureyPeopleDS2");
	var record=esureyPeopleDS2.getCurrent();
	$("cyName").innerHTML=record.get("name");
	$("cyIdCard").innerHTML=record.get("idCard");
	$("excyName").innerHTML=record.get("name");
	$("excyIdCard").innerHTML=record.get("idCard");
	//$("peopleId").innerHTML=record.get("peopleId");
}
//返回List
function return_list(){
	var url="jsp/cams/drel/esurey/internal/esureyInfoSumList.jsp";
	L5.forward(url);
}
//查看家庭
function detail_family(){
	var jtcysfGridPanel = L5.getCmp('jtcysfGridPanel');
	jtcysfGridPanel.stopEditing();
	var cells= jtcysfGridPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要查看的记录！");
		return;
	}
	var supfamilyId=cells[0].get("familyId");
	var win=L5.getCmp('supFamilyEdit');
	win.x = 0;
	win.y = 0;
	win.width = document.body.clientWidth;
	win.height = document.body.clientHeight;
	win.draggable = false;	
	win.show();
	//家庭信息
	var esureyFamilyDS2=L5.DatasetMgr.lookup("esureyFamilyDS2");
	esureyFamilyDS2.baseParams['FAMILY_ID@=']=supfamilyId;	
	esureyFamilyDS2.load();
	//家庭成员信息
	var esureyPeopleDS4=L5.DatasetMgr.lookup("esureyPeopleDS4");
	esureyPeopleDS4.baseParams['FAMILY_ID@=']=supfamilyId;
	esureyPeopleDS4.load();
}
//赡养家庭窗口关闭
function suphide_win(){
	var win2=L5.getCmp("supFamilyEdit");
	win2.hide();
}
function save_return_list(){
	 L5.MessageBox.confirm('确定', '保存审核汇总信息？',function(state){
	if(state=="yes"){
		//家庭汇总存储
		var extyearIncome=_$("extyearIncome"); 
		var extyearAverageIncome=_$("extyearAverageIncome"); 
		var extmonthIncome=_$("extmonthIncome"); 
		var extmonthAverageIncome=_$("extmonthAverageIncome");
		var extyearSupportMon=_$("extyearSupportMon"); 
		var extmonthSupportMon=_$("extmonthSupportMon"); 
		var extmonthAverageIncome=_$("extmonthAverageIncome");
		var validPeriod=_$("validPeriod");
		var validDate=_$("validDate");
		var lowIncomeType=_$("lowIncomeType");  
		var creditRating=_$("creditRating");
		if(!creditRating){
			L5.Msg.alert("提示","请填写家庭诚信等级！");
			return;
		}
		var SamEsureyFamilySumDS=L5.DatasetMgr.lookup("SamEsureyFamilySumDS");
		var record=SamEsureyFamilySumDS.newRecord();
		record.set("yearIncome",_$("extyearIncome"));
		record.set("yearSupportMon",_$("extyearSupportMon"));
		record.set("monthSupportMonon",_$("extmonthSupportMon"));
		record.set("yearAverageIncome",_$("extyearAverageIncome"));
		record.set("monthIncome",_$("extmonthIncome"));
		record.set("familyWorth",_$("extfamilyWorth"));
		record.set("monthAverageIncome",_$("extmonthAverageIncome"));
		record.set("validPeriod",_$("validPeriod"));
		record.set("validDate",_$("validDate"));
		record.set("lowIncomeType",_$("lowIncomeType"));
		record.set("creditRating",creditRating);
		record.set("familyId",familyId);
		record.set("surveyId",surveyId);
		
		var command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyFamilySumCmd");
		command.setParameter("record", record);
		command.execute("save");
		//人员汇总存储
		var SamEsureyPeoIncomeDS=L5.DatasetMgr.lookup("SamEsureyPeoIncomeDS");
		var peoCommand=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleSumCmd");
		if(SamEsureyPeoIncomeDS.getCount()>0){
			var peoIncomeRecords=SamEsureyPeoIncomeDS.getAllRecords();
			peoCommand.setParameter("records", peoIncomeRecords);
			peoCommand.setParameter("surveyId", surveyId);
			peoCommand.execute("saveSum");
		}
		if (!command.error&&!peoCommand.error) {
			L5.MessageBox.alert("提示","保存成功！");
			var esureyFamilyDS=L5.DatasetMgr.lookup("esureyFamilyDS");
			var familyRecord=esureyFamilyDS.getCurrent();
		    var familyAddress=familyRecord.get("familyAddress");
 
	       //if(familyAddress.substring(4,12)=="00000000"){
			//    familyRecord.set("curActivity","01");
			//    familyRecord.set("curState","1");
		   //}else if(familyAddress.substring(6,12)=="000000"&&familyAddress.substring(4,12)!="00000000"){
			//    familyRecord.set("curActivity","02");
			//    familyRecord.set("curState","1");
		   // }
		    familyRecord.set("curState","3");
			var familyCommand = new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyCmd");
		    familyCommand.setParameter("SamEsureyFamily", familyRecord);
			familyCommand.execute("update");
			var url="jsp/cams/drel/esurey/internal/esureyInfoSumList.jsp";
			L5.forward(url);
		
		}else{
			L5.MessageBox.alert("提示","保存时出错！"+command.error);
		}
	}else{
		return;
	}
	});				
	
	
}

//打印证书
function printList(){
	//var familyName=_$('supfamilyName');
	var esureyFamilyDS=L5.DatasetMgr.lookup("esureyFamilyDS");
	var familyName=esureyFamilyDS.get("familyName");
	var familyCardNo=esureyFamilyDS.get("familyCardNo");
	var yearAverageIncome=_$('extyearAverageIncome');
	var monthAverageIncome=_$('extmonthAverageIncome');
	var validPeriod=_$('validPeriod');
	if(familyName!='' && familyCardNo!='' && yearAverageIncome!=''&& monthAverageIncome!='' && validPeriod!=''){
		var url="esureyInfoSumForPrint.jsp?familyName="+encodeURIComponent(encodeURIComponent(familyName))+"&familyCardNo="+familyCardNo+"&yearAverageIncome="+yearAverageIncome+"&validPeriod="+validPeriod+"&monthAverageIncome="+monthAverageIncome;
		window.open(url);
	}else{
		L5.Msg.alert('提示',"填入所需数据:有效期！");
		return;
	}
}
//导出
function exportWord(){
	//创建Word应用程序对象
	var oWD = new ActiveXObject("Word.Application");
	//向Word应用程序对象中添加一个文档对象,并取出其中的Range(0)
	var oRange =oWD.documents.add().Range(0,0);
	//根据HTML页面创建TextRange对象,以便定位到要打印的元素中
	var sel = document.body.createTextRange();
	//定位到TextRage对象中要打印的元素上,GridView1是要打印的元素的ID
	sel.moveToElementText(externalUnit);
	//选中GridView1元素的所有HTML内容
	sel.select();
	//将选中的内容复制到剪切板上
	sel.execCommand("Copy");
	//粘贴到Word文档对象中去
	oRange.Paste();
	//显示Word程序和文档内容
	oWD.Application.Visible = true;
	//peopleDetail(document.getElementById("peopleId").innerHTML);
	returnBack();
	
}
function returnBack(){
	var data=new L5.Map();
	data.put("familyId",familyId);
	var text="审核汇总困难家庭信息";
	var url="jsp/cams/drel/esurey/internal/esureyInfoSum.jsp";
	L5.forward(url,text,data);
}