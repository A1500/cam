//户口性质---农村
var COUNTRY='1';
//户口性质---城市
var TOWN='2';

var wFlag;
var peopleId;
function init(){
	//家庭信息
	var esureyFamilyDS=L5.DatasetMgr.lookup("esureyFamilyDS");
	esureyFamilyDS.baseParams['FAMILY_ID@=']=familyId;
	esureyFamilyDS.on("load",fillBackType);	
	esureyFamilyDS.load();
	//成员信息
	var esureyPeopleDS=L5.DatasetMgr.lookup("esureyPeopleDS");
	esureyPeopleDS.baseParams['FAMILY_ID@=']=familyId;
	esureyPeopleDS.load();	
	//赡养家庭信息
	var esureyRelationDS=L5.DatasetMgr.lookup("esureyRelationDS");
	esureyRelationDS.baseParams['FAMILY_ID@=']=familyId;
	esureyRelationDS.load();
	esureyRelationDS.on("load",backSupFamily);
}
function fillBackType(esureyFamilyDS){
	var esureyFamily=esureyFamilyDS.getCurrent();
	var domicileType=esureyFamily.get("domicileType");
	if(domicileType==TOWN){
		$("monthSupportMonon").disabled=false;
		$("yearSupportMon").disabled=true;
	}else if(domicileType==COUNTRY){
		$("monthSupportMonon").disabled=true;
		$("yearSupportMon").disabled=false;
	}else{
		$("monthSupportMonon").disabled=true;
		$("yearSupportMon").disabled=true;
	}
}
//赡养家庭信息
function backSupFamily(esureyRelationDS){
	var supNum=esureyRelationDS.getCount();
	if(supNum==0){
		return;
	}	
	var records=esureyRelationDS.getAllRecords();	
	var supFamId="";
	var supFamIds=new Array();
	for(i=0;i<supNum;i++){
		supFamIds[i]=records[i].get("supportFamilyId");
	}
	if(supFamIds.length>1){
		supFamId=supFamIds[0];
		for(var i=1;i<supFamIds.length;i++){
			supFamId=supFamId+","+supFamIds[i];
		}
	}else{
		supFamId=supFamIds[0];
	}
	var esureyFamilyDS2=L5.DatasetMgr.lookup("esureyFamilyDS2");
	esureyFamilyDS2.baseParams["FAMILY_ID@in@String"]=supFamId;	
	esureyFamilyDS2.load();
}
//保存家庭信息
function save_family(){
	var esureyFamilyDS=L5.DatasetMgr.lookup("esureyFamilyDS");
	esureyFamilyDS.set("regAddress",_$('regAddressh'));
	var familyRecord=esureyFamilyDS.getCurrent();
	var esureyFamilyDS = L5.DatasetMgr.lookup("esureyFamilyDS");
	var valid =esureyFamilyDS.isValidate(true);
	if(valid !== true){
		L5.Msg.alert("提示","校验未通过："+valid);
		return false;
	}
	
	var esureyPeopleDS3 = L5.DatasetMgr.lookup("esureyPeopleDS3");
	var valid =esureyPeopleDS3.isValidate(true);
	if(valid !== true){
		L5.Msg.alert("提示","校验未通过："+valid);
		return false;
	}
	familyRecord.set('monthSupportMonon',document.getElementById('monthSupportMonon').value);
	familyRecord.set('yearSupportMon',document.getElementById('yearSupportMon').value);
	var command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyCmd");
	command.setParameter("SamEsureyFamily",familyRecord);
	command.execute("update");
	if(!command.error){
		L5.Msg.alert("提示","修改成功！",function(){
			if(method=="editT"){
				var url="jsp/cams/drel/esurey/internal/esureyInfoTownList.jsp";
				L5.forward(url);
			}else{
				var url="jsp/cams/drel/esurey/internal/esureyInfoList.jsp";
				L5.forward(url);
			}
		});
	}else{
		L5.Msg.alert("提示","修改时出错！"+command.error);
	}
}
//打开新增家庭成员信息面板
function addFamilyMember(grid,a,b,c) {
	var win=L5.getCmp('jtcyEdit');
	win.setTitle(grid.text);
	win.x = 10;
	win.y = 10;
	win.width = 700;
	win.height = 400;
	win.draggable = false;
	var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
	command.setParameter("IdHelp","Id30");
	command.execute();
	var newId=command.getReturn("id");
	//添加人员信息
	var esureyPeopleDS2=L5.DatasetMgr.lookup("esureyPeopleDS2");
	esureyPeopleDS2.newRecord({
  	  peopleId: newId,	
  	  familyId:familyId	
	});	
	//社保
	var SamEsureySocialDS=L5.DatasetMgr.lookup('SamEsureySocialDS');
	SamEsureySocialDS.removeAll();
	//财产收入
	var SamEsureyPeopleEstateDS=L5.DatasetMgr.lookup('SamEsureyPeopleEstateDS');
	SamEsureyPeopleEstateDS.removeAll();
	//房屋
	var SamEsureyHouseDS=L5.DatasetMgr.lookup('SamEsureyHouseDS');
	SamEsureyHouseDS.removeAll();
	//工商信息
	var SamEsureyBusinessDS=L5.DatasetMgr.lookup('SamEsureyBusinessDS');
	SamEsureyBusinessDS.removeAll();
	//车辆信息
	var SamEsureyCarDS=L5.DatasetMgr.lookup('SamEsureyCarDS');
	SamEsureyCarDS.removeAll();		
	//国税
	var SamEsureyTaxDS=L5.DatasetMgr.lookup('SamEsureyTaxDS');
	SamEsureyTaxDS.removeAll();
	//地税信息	
	var SamEsureyTaxDS2=L5.DatasetMgr.lookup('SamEsureyTaxDS2');
	SamEsureyTaxDS2.removeAll();			
	// 公积金信息
	var SamEsureyHousingFundDS=L5.DatasetMgr.lookup('SamEsureyHousingFundDS');
	SamEsureyHousingFundDS.removeAll();						
	// 人行信息
	var SamEsureyBankDS=L5.DatasetMgr.lookup('SamEsureyBankDS');
	SamEsureyBankDS.removeAll();								
	// 证监信息
	var SamEsureySecuritiesDS=L5.DatasetMgr.lookup('SamEsureySecuritiesDS');
	SamEsureySecuritiesDS.removeAll();										
	// 保监信息
	var SamEsureyInsuranceDS=L5.DatasetMgr.lookup('SamEsureyInsuranceDS');
	SamEsureyInsuranceDS.removeAll();	
											
	win.show(grid.el.dom);
	wFlag="insert";
	L5.getCmp("jtcyTabpanel").setActiveTab("0");
	$("idCard").disabled=false;
	$("relationshipType").disabled=false;
	$("cyName").innerHTML="";
	$("cyIdCard").innerHTML="";	

}

//修改人员信息
function editFamilyMember(grid,a,b,c){
	var jtcyGridPanel=L5.getCmp("jtcyGridPanel");
	var cells= jtcyGridPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要修改的记录！");
		return;
	}
	peopleId=cells[0].get("peopleId");
	//人员信息
	var esureyPeopleDS2=L5.DatasetMgr.lookup("esureyPeopleDS2");
	esureyPeopleDS2.baseParams['PEOPLE_ID@=']=peopleId;
	esureyPeopleDS2.load();
	//社保
	var SamEsureySocialDS=L5.DatasetMgr.lookup('SamEsureySocialDS');
	SamEsureySocialDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureySocialDS.load();
	//财产收入
	var SamEsureyPeopleEstateDS=L5.DatasetMgr.lookup('SamEsureyPeopleEstateDS');
	SamEsureyPeopleEstateDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyPeopleEstateDS.load();
	//房屋
	var SamEsureyHouseDS=L5.DatasetMgr.lookup('SamEsureyHouseDS');
	SamEsureyHouseDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyHouseDS.load();
	//工商信息
	var SamEsureyBusinessDS=L5.DatasetMgr.lookup('SamEsureyBusinessDS');
	SamEsureyBusinessDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyBusinessDS.load();
	//车辆信息
	var SamEsureyCarDS=L5.DatasetMgr.lookup('SamEsureyCarDS');
	SamEsureyCarDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyCarDS.load();		
	//国税
	var SamEsureyTaxDS=L5.DatasetMgr.lookup('SamEsureyTaxDS');
	SamEsureyTaxDS.baseParams['TAXES_TYPE@=']='0';
	SamEsureyTaxDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyTaxDS.load();		
	//地税信息	
	var SamEsureyTaxDS2=L5.DatasetMgr.lookup('SamEsureyTaxDS2');
	SamEsureyTaxDS2.baseParams['TAXES_TYPE@=']='1';
	SamEsureyTaxDS2.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyTaxDS2.load();	
	// 公积金信息
	var SamEsureyHousingFundDS=L5.DatasetMgr.lookup('SamEsureyHousingFundDS');
	SamEsureyHousingFundDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyHousingFundDS.load();						
	// 人行信息
	var SamEsureyBankDS=L5.DatasetMgr.lookup('SamEsureyBankDS');
	SamEsureyBankDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyBankDS.load();								
	// 证监信息
	var SamEsureySecuritiesDS=L5.DatasetMgr.lookup('SamEsureySecuritiesDS');
	SamEsureySecuritiesDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureySecuritiesDS.load();										
	// 保监信息
	var SamEsureyInsuranceDS=L5.DatasetMgr.lookup('SamEsureyInsuranceDS');
	SamEsureyInsuranceDS.baseParams['PEOPLE_ID@=']=peopleId;
	SamEsureyInsuranceDS.load();
	 
	var win=L5.getCmp('jtcyEdit');
	win.setTitle(grid.text);
	win.x = 10;
	win.y = 10;
	win.width = 700;
	win.height = 400;
	win.draggable = false;	
	win.show(grid.el.dom);
	L5.getCmp("jtcyTabpanel").setActiveTab("0");
	wFlag="update";
	var relationshipType=cells[0].get("relationshipType");
	if(relationshipType=='1'){
		$("idCard").disabled=true;
		$("relationshipType").disabled=true;
	}else{
		$("idCard").disabled=false;
		$("relationshipType").disabled=false;
	}
	$("cyName").innerHTML=cells[0].get("name");
	$("cyIdCard").innerHTML=cells[0].get("idCard");
	
}
//删除人员信息
function deleteFamilyMember(){
	var esureyPeopleDS=L5.DatasetMgr.lookup("esureyPeopleDS");
	var peoplePanel = L5.getCmp('jtcyGridPanel');
	var cells= peoplePanel .getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要删除的记录！");
		return;
	}
	L5.MessageBox.confirm('提示', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var familyId2=cells[0].get("familyId");
			var peopleId2=cells[0].get("peopleId");
			var relationshipType=cells[0].get("relationshipType");
			if(relationshipType=='1'){
				L5.Msg.alert("提示","户主不可以删除！");
				return;	
			}
			var command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleCmd");
			command.setParameter("peopleId", peopleId2);
			command.setParameter("familyId",familyId2);
			command.setParameter("Flag","notSupport");
			command.execute("delete");
			if (!command.error) {
				esureyPeopleDS.remove(cells[0]);					
			}else{
				L5.Msg.alert("提示","删除时出错！"+command.error);
			}
		}	
	});		
}
//添加人员信息和相应的经济信息

function add_people(){
	//人员信息
	var esureyPeopleDS2 = L5.DatasetMgr.lookup("esureyPeopleDS2");
	var esureyPeople=esureyPeopleDS2.getCurrent();
	
	var esureyPeopleDS = L5.DatasetMgr.lookup("esureyPeopleDS");
	
	var esureyFamilyDS = L5.DatasetMgr.lookup("esureyFamilyDS");
	var familyRecord=esureyFamilyDS.getCurrent();
	peopleId=esureyPeople.get("peopleId");
	var idCardCheck=esureyPeople.get("idCard");
	if(wFlag=="insert"){
		esureyPeople.set("personalStatsTag","1");
		var ePeopleId=esureyPeople.get("peopleId");
		if(esureyPeople.get("relationshipType")=="1"){
			L5.Msg.alert("提示","户主已经存在！");
			return;
		}
	}
	var esureyPeopleDS2 = L5.DatasetMgr.lookup("esureyPeopleDS2");
	var valid =esureyPeopleDS2.isValidate(true);
	if(valid !== true){
		L5.Msg.alert("提示","校验未通过："+valid);
		return false;
	}
	var domicile=_$("domicileType");
	if(domicile==TOWN){
		var incomeMonth=_$("incomeMonth");
		if(incomeMonth==""){
			L5.Msg.alert("提示","请输入月收入！");
			return;
		}
		//城市
		if(esureyPeople.get("incomeMonth")!=""){
			esureyPeople.set("incomeYear",esureyPeople.get("incomeMonth")*12);	
		}
	}else if(domicile==COUNTRY){
		var incomeYear=_$("incomeYear");
		if(incomeYear==""){
			L5.Msg.alert("提示","请输入年收入！");
			return;
		}
		//农村
		if(esureyPeople.get("incomeYear")!=""){
			esureyPeople.set("incomeMonth",changeTwoDecimal(parseFloat(esureyPeople.get("incomeYear")/12*100)/100));
		}
	}
	esureyPeople.set("incomeYear",document.getElementById("incomeYear").value);	
	esureyPeople.set("incomeMonth",document.getElementById("incomeMonth").value);	
	//校验身份证和成员的唯一性
	var command2=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleCmd");
	command2.setParameter("familyId",familyId);
	command2.setParameter("idCard",idCardCheck);
	command2.execute("checkUnqiue");
	var nPeopleId=command2.getReturn("peopleId");
	if(wFlag=="insert"){
		if(nPeopleId!="0"){
			L5.Msg.alert("提示","此家庭成员已经存在！");
			return;
		}
	}else if(wFlag=="update"){
		if(nPeopleId!="0"){
			if(peopleId!=nPeopleId){
				L5.Msg.alert("提示","此身份证号重复！");
				return;
			}
		}
	}	
	//社保信息
	var SamEsureySocialDS = L5.DatasetMgr.lookup("SamEsureySocialDS");
	var valid =SamEsureySocialDS.isValidate(true);
	if(valid != true){
		L5.Msg.alert("提示","社保信息："+valid);
		return false;
	}
	//财产信息
	var SamEsureyPeopleEstateDS = L5.DatasetMgr.lookup("SamEsureyPeopleEstateDS");
	var valid =SamEsureyPeopleEstateDS.isValidate(true);
	if(valid !=true){
		L5.Msg.alert("提示","财产信息："+valid);
		return false;
	}
	//房屋信息
	var SamEsureyHouseDS = L5.DatasetMgr.lookup("SamEsureyHouseDS");
	var valid =SamEsureyHouseDS.isValidate(true);
	if(valid != true){
		L5.Msg.alert("提示","房屋信息："+valid);
		return false;
	}
	//工商信息
	var SamEsureyBusinessDS = L5.DatasetMgr.lookup("SamEsureyBusinessDS");
	var valid =SamEsureyBusinessDS.isValidate(true);
	if(valid != true){
		L5.Msg.alert("提示","工商信息："+valid);
		return false;
	}
	//车辆信息
	var SamEsureyCarDS = L5.DatasetMgr.lookup("SamEsureyCarDS");
	var valid =SamEsureyCarDS.isValidate(true);
	if(valid != true){
		L5.Msg.alert("提示","车辆信息："+valid);
		return false;
	}
	//国税信息
	var SamEsureyTaxDS = L5.DatasetMgr.lookup("SamEsureyTaxDS");
	var valid =SamEsureyTaxDS.isValidate(true);
	if(valid != true){
		L5.Msg.alert("提示","国税信息："+valid);
		return false;
	}
	//地税信息
	var SamEsureyTaxDS2 = L5.DatasetMgr.lookup("SamEsureyTaxDS2");
	var valid =SamEsureyTaxDS2.isValidate(true);
	if(valid != true){
		L5.Msg.alert("提示","地税信息："+valid);
		return false;
	}
	//公积金信息
	var SamEsureyHousingFundDS = L5.DatasetMgr.lookup("SamEsureyHousingFundDS");
	var valid =SamEsureyHousingFundDS.isValidate(true);
	if(valid != true){
		L5.Msg.alert("提示","公积金信息："+valid);
		return false;
	}
	//人民银行
	var SamEsureyBankDS = L5.DatasetMgr.lookup("SamEsureyBankDS");
	var valid =SamEsureyBankDS.isValidate(true);
	if(valid != true){
		L5.Msg.alert("提示","人民银行信息："+valid);
		return false;
	}
	//证监
	var SamEsureySecuritiesDS = L5.DatasetMgr.lookup("SamEsureySecuritiesDS");
	var valid =SamEsureySecuritiesDS.isValidate(true);
	if(valid != true){
		L5.Msg.alert("提示","证监信息："+valid);
		return false;
	}
	//保监
	var SamEsureyInsuranceDS = L5.DatasetMgr.lookup("SamEsureyInsuranceDS");
	var valid =SamEsureyInsuranceDS.isValidate(true);
	if(valid != true){
		L5.Msg.alert("提示","保监信息："+valid);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleCmd");
    command.setParameter("SamEsureyPeople", esureyPeople);
    //社保信息
	var SamEsureySocialDS=L5.DatasetMgr.lookup('SamEsureySocialDS');
	var SocialRecords = SamEsureySocialDS.getAllChangedRecords();
    command.setParameter("SocialBeans", SocialRecords);
     //财产信息
	var SamEsureyPeopleEstateDS=L5.DatasetMgr.lookup('SamEsureyPeopleEstateDS');
	var estateRecords = SamEsureyPeopleEstateDS.getAllChangedRecords();
	command.setParameter("estateRecords", estateRecords);
 	 //社保信息
	var SamEsureyHouseDS=L5.DatasetMgr.lookup('SamEsureyHouseDS');
	var houseRecords = SamEsureyHouseDS.getAllChangedRecords();
    command.setParameter("houseRecords", houseRecords);	
   //工商信息
	var SamEsureyBusinessDS=L5.DatasetMgr.lookup('SamEsureyBusinessDS');
	var businessRecords = SamEsureyBusinessDS.getAllChangedRecords();
    command.setParameter("businessRecords", businessRecords);	   
   //车辆信息
	var SamEsureyCarDS=L5.DatasetMgr.lookup('SamEsureyCarDS');
	var carRecords = SamEsureyCarDS.getAllChangedRecords();
    command.setParameter("carRecords", carRecords);	   		
	//国税
	var SamEsureyTaxDS=L5.DatasetMgr.lookup('SamEsureyTaxDS');
	var taxRecords = SamEsureyTaxDS.getAllChangedRecords();
    command.setParameter("taxRecords", taxRecords);	
    //地税信息 
    var SamEsureyTaxDS2=L5.DatasetMgr.lookup('SamEsureyTaxDS2');
	var taxRecords2 = SamEsureyTaxDS2.getAllChangedRecords();
    command.setParameter("taxRecords2", taxRecords2);	  				
	// 公积金信息
	var SamEsureyHousingFundDS=L5.DatasetMgr.lookup('SamEsureyHousingFundDS');
	var fundRecords = SamEsureyHousingFundDS.getAllChangedRecords();
    command.setParameter("fundRecords", fundRecords);	   						
	// 人行信息
	var SamEsureyBankDS=L5.DatasetMgr.lookup('SamEsureyBankDS');
	var bankRecords = SamEsureyBankDS.getAllChangedRecords();
    command.setParameter("bankRecords", bankRecords);	   								
	// 证监信息
	var SamEsureySecuritiesDS=L5.DatasetMgr.lookup('SamEsureySecuritiesDS');
	var securitiesRecords = SamEsureySecuritiesDS.getAllChangedRecords();
    command.setParameter("securitiesRecords", securitiesRecords);	   										
	// 保监信息
	var SamEsureyInsuranceDS=L5.DatasetMgr.lookup('SamEsureyInsuranceDS');
	var insuranceRecords = SamEsureyInsuranceDS.getAllChangedRecords();
    command.setParameter("insuranceRecords", insuranceRecords);
    //增加
    if(wFlag=="insert"){	   		
    command.setParameter("signType", "insert");
    }
    //更新
    if(wFlag=="update"){
    command.setParameter("signType", "update");
    }
	command.execute("save");
	if (!command.error) {
		peopleId="";
		L5.Msg.alert('提示','家庭成员信息保存成功!',function(){
			hide_win();
		});					
	}else{
		L5.Msg.alert('提示',"保存时出现错误"+command.error);
	}	
}
//关闭人员信息和相应的经济信息窗口
function hide_win(){
	var win=L5.getCmp("jtcyEdit");
	win.hide();
	var esureyPeopleDS=L5.DatasetMgr.lookup("esureyPeopleDS");
	esureyPeopleDS.baseParams["FAMILY_ID@="]=familyId;
	esureyPeopleDS.load();
	var esureyFamilyDS = L5.DatasetMgr.lookup("esureyFamilyDS");
	var familyRecord=esureyFamilyDS.getCurrent();
	esureyPeopleDS.on('load',function (){
		var yearIncomeS=0;
		var monthIncomeS=0;
		var esureyPeoples=esureyPeopleDS.getAllRecords();
		for(var i=0;i<esureyPeopleDS.getCount();i++){
			var esureyPeople=esureyPeoples[i];
			yearIncomeS = accAdd(yearIncomeS,parseFloat(esureyPeople.get("incomeYear")));
			//yearIncomeS+parseFloat(esureyPeople.get("incomeYear"));
			monthIncomeS = accAdd(monthIncomeS,parseFloat(esureyPeople.get("incomeMonth")));
			//monthIncomeS+parseFloat(esureyPeople.get("incomeMonth"));
		}
		familyRecord.set("yearIncome",yearIncomeS);
		familyRecord.set("monthIncome",monthIncomeS);
		familyRecord.set("yearAverageIncome",changeTwoDecimal(accDiv(yearIncomeS,esureyPeopleDS.getCount())));//changeTwoDecimal(yearIncomeS/esureyPeopleDS.getCount()));
		familyRecord.set("monthAverageIncome",changeTwoDecimal(accDiv(monthIncomeS,esureyPeopleDS.getCount())));//changeTwoDecimal(monthIncomeS/esureyPeopleDS.getCount()));
	});
}
function accDiv(arg1,arg2){ 
	var t1=0,t2=0,r1,r2; 
	try{t1=arg1.toString().split(".")[1].length}catch(e){} 
	try{t2=arg2.toString().split(".")[1].length}catch(e){} 
	with(Math){ 
		r1=Number(arg1.toString().replace(".","")) 
		r2=Number(arg2.toString().replace(".","")) 
		return (r1/r2)*pow(10,t2-t1); 
	} 
} 
function accAdd(arg1,arg2){ 
	var r1,r2,m; 
	try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0} 
	try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0} 
	m=Math.pow(10,Math.max(r1,r2)) 
	return (arg1*m+arg2*m)/m 
} 
//添加赡养家庭
function add_supFamily(){
	var data=new L5.Map();
	data.put("BeanId",familyId);
	if(method=="editL"){
		data.put("method","insertLS");
	}else if(method=="editT"){
		data.put("method","insertTS");
	}
	var url="jsp/cams/drel/esurey/internal/esureyInfoSFInsert.jsp";
	var text="";
	L5.forward(url,text,data);
}
//修改赡养家庭
function edit_supFamily(){
	var grid=L5.getCmp("supGridPanel");
	var selected = grid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.MessageBox.alert("提示",'请选择要修改的记录');
		return false;
	}
	var supFamilyId=selected[0].get("familyId");
	var data=new L5.Map();
	data.put("BeanId",familyId);
	data.put("supFamilyId",supFamilyId);
	if(method=="editL"){
		data.put("method","editLS");
	}else if(method=="editT"){
		data.put("method","editTS");
	}
	var text="困难家庭信息";
	var url="jsp/cams/drel/esurey/internal/esureyInfoSFInsert.jsp";
	L5.forward(url,text,data);
	
}
//赡养家庭详情
function detail_supFamily(){
	var supGridPanel = L5.getCmp('supGridPanel');
	supGridPanel.stopEditing();
	var cells= supGridPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要查看的记录！");
		return;
	}
	var supfamilyId=cells[0].get("familyId");	
	if(method=="editT"){
		var data=new L5.Map();
		data.put("supfamilyId",supfamilyId);
		data.put("familyId",familyId);
		data.put("method","detailTS");
		var url="jsp/cams/drel/esurey/internal/esureyInfoSupDetail.jsp";
		var text="";
		L5.forward(url,text,data);
	}else if(method=="editL"){
		var data=new L5.Map();
		data.put("supfamilyId",supfamilyId);
		data.put("familyId",familyId);
		data.put("method","detailLS");
		var url="jsp/cams/drel/esurey/internal/esureyInfoSupDetail.jsp";
		var text="";
		L5.forward(url,text,data);
	}
	
}
//删除赡养家庭
function delete_supFamily(){
	var esureyFamilyDS2=L5.DatasetMgr.lookup("esureyFamilyDS2");
	var grid=L5.getCmp("supGridPanel");
	var selected = grid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.MessageBox.alert("提示",'请选择要删除的记录');
		return false;
	}
	L5.MessageBox.confirm('提示', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var supFamId=selected[0].get("familyId");
			var command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyCmd");
			command.setParameter("familyId",familyId);
			command.setParameter("supFamId", supFamId);
			command.execute("deleteSupFamily");
			if (!command.error) {
				esureyFamilyDS2.remove(selected[0]);					
			}else{
				L5.Msg.alert("提示","删除时出错！"+command.error);
			}
		}	
	});		
}
//回填身份证
function check_IdCard(){
	if(_$('idCard')==''){
		return;
	}
	if(checkIDCard($("idCard"))==true){
		$("cyIdCard").innerHTML=_$("idCard");
	}else{
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		$("idCard").value="";
		$("idCard").focus();
		return;
	}
}

//*************************************************数字转换成两位小数*****************************************************
//取两位小数
function changeTwoDecimal(num){
    var f_Num=parseFloat(num);
    f_Num=Math.round(f_Num*100)/100;
    var s_Num=f_Num.toString();
    var pos_Num=s_Num.indexOf('.');
    if(pos_Num<0){
    	pos_Num=s_Num.length;
		s_Num+='.';
    }
    while(s_Num.length <= pos_Num + 2){
		s_Num += '0';
     }
    return s_Num;
}
function changeSupMon(src){
	if(src!=""){
		if(isFloat(src)!=true){
			L5.Msg.alert("提示","格式不正确，请输入数字！",function(){
				$("yearSupportMon").value="";
				$("yearSupportMon").focus();
			});
			return;
		}
		var num=changeTwoDecimal(src);
		$("yearSupportMon").value=num;
	}
}
function changeSupYear(src){
	if(src!=""){
		if(isFloat(src)!=true){
			L5.Msg.alert("提示","格式不正确，请输入数字！",function(){
				$("monthSupportMonon").value="";
				$("monthSupportMonon").focus();
			});
			return;
		}
		var num=changeTwoDecimal(src);
		$("monthSupportMonon").value=num;
	}
}
/**
 * 选择属地行政区划窗口
 */
function func_ForDomicileSelect() {
	queryOrganName();
	organCode=organArea.substring(0, 4)+"00000000";
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&level=2&organCode="
					+ organCode + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("regAddressh").value = list[0];
		document.getElementById("regAddress").value = list[1];
	}
}

/*
*从数据库dic_city中查询organName
*/
function queryOrganName() {
		organCode=organArea.substring(0, 4)+"00000000";
		if(organCode != null && organCode != "") {
			var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			command.setParameter("ID",organCode);
			command.execute("findOrganName");
			var fullName = command.getReturn("organName");
			if(fullName != null && fullName != "") {
				organName = fullName;
			}
		}
}