//做用：数字字符串转换成数字
var ONE=1;
//查询信息
var wind;
document.write("<script language='javascript' src='esureyInfoComm.js'></script>"); 

function forHistoryInfo(){
	var idCard=_$("familyCardNo");
	if(idCard==""){
		L5.Msg.alert("提示","请输入户主身份证号码！");
		return;
	}
			
	if(wind==undefined){
	 	wind=L5.getCmp("family_help");
	}
	var command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyCmd");
	command.setParameter('idCard',idCard);
	command.execute("beExistMess");
	var num=command.getReturn('isExist')*ONE;
	if(num==0){
		L5.Msg.alert("提示","没有相关信息！");
		return;
	}
	var baseFamilyDS=L5.DatasetMgr.lookup("baseFamilyDS");
	baseFamilyDS.baseParams['FAMILY_CARD_NO@=']=idCard;
	baseFamilyDS.load();
	
	var esureyFamilyDS3=L5.DatasetMgr.lookup("esureyFamilyDS3");
	esureyFamilyDS3.baseParams['FAMILY_CARD_NO@=']=idCard;
	esureyFamilyDS3.load();
	wind.show();
}
//信息回填
function add_Family(){
	var baseinfo=L5.getCmp("base_family");
	var bSelected=baseinfo.getSelectionModel().getSelections();
	var num1=bSelected.length;
	var esureyinfo=L5.getCmp("esurey_family");
	var eSelected=esureyinfo.getSelectionModel().getSelections();
	var num2=eSelected.length;
	if(num1*1+num2*1!=1){
		L5.Msg.alert("提示","请选择一条记录！");
		return;
	}
	if(num1==1){
		var familyId=bSelected[0].get("familyId");
		var baseFamilyDS=L5.DatasetMgr.lookup("baseFamilyDS");
		baseFamilyDS.baseParams['FAMILY_ID@=']=familyId;
		baseFamilyDS.load();
		baseFamilyDS.on("load",backfillBase);
	}
	if(num2==1){
		var familyId=eSelected[0].get("familyId");
		var esureyFamilyDS3=L5.DatasetMgr.lookup("esureyFamilyDS3");
		esureyFamilyDS3.baseParams['FAMILY_ID@=']=familyId;
		esureyFamilyDS3.load();
		esureyFamilyDS3.on('load',backfillEsurey);
	}
	close_win();
}
//关闭窗口
function close_win(){
	var wind=L5.getCmp('family_help');
	wind.hide();
}
//困难家庭信息
function backfillBase(baseFamilyDS){
	if(baseFamilyDS.getCount()<1){
		return;
	}
	var record=baseFamilyDS.getCurrent();
	$("parentFamilyId").value=record.get("familyId")+",baseFamily";
	$("familyName").value=record.get("familyName");
	$("familyName").focus();
	$("peopleNum").value=record.get("peopleNum");
	$("familyPostcode").value=record.get("familyPostcode");
	$("familyPostcode").focus();
	$("address").value=record.get("address");
	$("address").focus();
	$("familyPhone").value=record.get("familyPhone");
	$("familyPhone").focus();
	$("houseStatus").value=record.get("houseQuality");
	$("houseStatus").focus();
	$("buildingStructure").value=record.get("houseStatus");
	$("buildingStructure").focus();
	$("familyMobile").value=record.get("familyMobile");
	$("familyMobile").focus();
	$("familyOtherPhone").value=record.get("familyOtherPhone");	
	$("familyOtherPhone").focus();
	$("buildArea").value=record.get("buildArea");
	$("buildArea").focus();
	//成员信息
	$("hname").value=record.get("familyName");
	$("hrelationshipType").value='01';
	$("hcyName").innerHTML=record.get("familyName");
	var baseinfoPeopleDS=L5.DatasetMgr.lookup("baseinfoPeopleDS");
	baseinfoPeopleDS.baseParams['RELATIONSHIP_TYPE@=']=record.get('familyId');
	baseinfoPeopleDS.baseParams['RELATIONSHIP_TYPE@=']='01';
	baseinfoPeopleDS.load();
	baseinfoPeopleDS.on('load',backfillBasePeople);
}
//经济核对家庭
function backfillEsurey(esureyFamilyDS3){
	if(esureyFamilyDS3.getCount()<1){
		return;
	}		
	var record=esureyFamilyDS3.getCurrent();
	var familyId=record.get('familyId');
	$("parentFamilyId").value=familyId+",esureyFamily";
	//成员信息
	$("hname").value=record.get("familyName");
	$("hrelationshipType").value='01';
	$("hcyName").innerHTML=record.get("familyName");
	$("hdomicileType").value=record.get("hdomicileType");
	//家庭信息
	var esureyFamilyDS=L5.DatasetMgr.lookup("esureyFamilyDS");
	esureyFamilyDS.baseParams['FAMILY_ID@=']=familyId;
	esureyFamilyDS.load();
	$("familyName").focus();
	var esureyPeopleDS3=L5.DatasetMgr.lookup("esureyPeopleDS3");
	esureyPeopleDS3.baseParams['FAMILY_ID@=']=familyId;
	esureyPeopleDS3.baseParams['RELATIONSHIP_TYPE@=']='01';
	esureyPeopleDS3.load();
}
//回填困难家庭户主信息
function backfillBasePeople(baseinfoPeopleDS){
	if(baseinfoPeopleDS.getCount()<1){
		return;
	}
	var record= baseinfoPeopleDS.getCurrent();
	$('hsex').value=record.get('sex');
	$('hnation').value=record.get('nation');
	$('heduCode').value=record.get('eduCode');
	$('hhealthCode').value=record.get('healthCode');
	$('hmarriageCode').value=record.get('marriageCode');
	$('hcareerCode').value=record.get('careerCode');
	$('hpoliticalCode').value=record.get('politicalCode');
	$("domicileType").value=record.get('domicileType');
	$("domicileType").focus();
	backType($("domicileType"));
	$('hdomicileType').value=record.get('domicileType');
	$('hincomeYear').value=record.get('incomeYear');
	$('hincomeMonth').value=record.get('incomeMonth');
	$('hworkUnitName').value=record.get('workUnitName');
} 