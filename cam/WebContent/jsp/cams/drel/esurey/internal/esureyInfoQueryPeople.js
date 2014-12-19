function init(){
	L5.getCmp('jtcyTabpanel').setActiveTab("1");
	L5.getCmp('jtcyTabpanel').setActiveTab('0');
	var esureyPeopleDS=L5.DatasetMgr.lookup("esureyPeopleDS");
	esureyPeopleDS.setParameter('peopleId',peopleId);
	if(isSup=="1"){
		$("sup_tr").style.display='block';
	}
	esureyPeopleDS.on('load',fillbackMess);
	esureyPeopleDS.load();
	loadEsurey(peopleId);
	loadExtEsurey(peopleId);
}
//回填
function fillbackMess(esureyPeopleDS){
	var record=esureyPeopleDS.getCurrent();
	$('cyName').innerHTML=record.get("NAME");
	$('cyIdCard').innerHTML=record.get("ID_CARD");
	$('excyName').innerHTML=record.get("NAME");
	$('excyIdCard').innerHTML=record.get("ID_CARD");
}
//返回
function return_list(){
	var data=new L5.Map();
	data.put("familyId",familyId);
	var text="";
	var url="jsp/cams/drel/esurey/internal/esureyInfoQueryFamily.jsp";
	L5.forward(url,text,data);
}
//申报经济信息
function loadEsurey(peopleId){
	//社保
	var SamEsureySocialDS=L5.DatasetMgr.lookup('SamEsureySocialDS');
	SamEsureySocialDS.baseParams['TYPE@=']='1';
	SamEsureySocialDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureySocialDS.load();
	//财产收入
	var SamEsureyPeopleEstateDS=L5.DatasetMgr.lookup('SamEsureyPeopleEstateDS');
	SamEsureyPeopleEstateDS.baseParams['TYPE@=']='1';
	SamEsureyPeopleEstateDS.baseParams['PEOPLE_ID@=']=peopleId;
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
	//国税
	var SamEsureyTaxDS=L5.DatasetMgr.lookup('SamEsureyTaxDS');
	SamEsureyTaxDS.baseParams['TAXES_TYPE@=']='0';
	SamEsureyTaxDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyTaxDS.baseParams['TYPE@=']='1';
	SamEsureyTaxDS.load();		
	//地税信息	
	var SamEsureyTaxDS2=L5.DatasetMgr.lookup('SamEsureyTaxDS2');
	SamEsureyTaxDS2.baseParams['TAXES_TYPE@=']='1';
	SamEsureyTaxDS2.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyTaxDS2.baseParams['TYPE@=']='1';
	SamEsureyTaxDS2.load();				
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
}
//核对经济信息
function loadExtEsurey(peopleId){
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
	//国税
	var SamEsureyTaxExtDS=L5.DatasetMgr.lookup('SamEsureyTaxExtDS');
	SamEsureyTaxExtDS.baseParams['TAXES_TYPE@=']='0';
	SamEsureyTaxExtDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyTaxExtDS.baseParams['TYPE@=']='2';
	SamEsureyTaxExtDS.load();		
	//地税信息	
	var SamEsureyTaxExtDS2=L5.DatasetMgr.lookup('SamEsureyTaxExtDS2');
	SamEsureyTaxExtDS2.baseParams['TAXES_TYPE@=']='1';
	SamEsureyTaxExtDS2.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyTaxExtDS2.baseParams['TYPE@=']='2';
	SamEsureyTaxExtDS2.load();				
	// 公积金信息
	var SamEsureyHousingFundExtDS=L5.DatasetMgr.lookup('SamEsureyHousingFundExtDS');
	SamEsureyHousingFundExtDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyHousingFundExtDS.baseParams['TYPE@=']='2';
	SamEsureyHousingFundExtDS.load();						
	// 人行信息
	var SamEsureyBankExtDS=L5.DatasetMgr.lookup('SamEsureyBankExtDS');
	SamEsureyBankExtDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyBankExtDS.baseParams['TYPE@=']='2';
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