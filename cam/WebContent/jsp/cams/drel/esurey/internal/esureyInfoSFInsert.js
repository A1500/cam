//户口性质---农村
var COUNTRY='1';
//户口性质---城市
var TOWN='2';
var familyId;
var peopleId;
var wFlag;
var sFlag;
var esureyFamilyDS;
function init() {
	L5.getCmp("tabPanels").setActiveTab("1");
	L5.getCmp("tabPanels").setActiveTab("0");
	if(method=="insertL"){
		familyId=document.getElementById("jfamilyId").value;
		peopleId=document.getElementById("jpeopleId").value;
		esureyFamilyDS=L5.DatasetMgr.lookup("esureyFamilyDS");
		esureyFamilyDS.newRecord();
		$("familyAddress").innerHTML=organName;
		var esureyPeopleDS3=L5.DatasetMgr.lookup("esureyPeopleDS3");
		esureyPeopleDS3.newRecord();	
		clearEsurey();
	}
	if(method=="insertLS"||method=="insertTS"){
		familyId=document.getElementById("jfamilyId").value;
		peopleId=document.getElementById("jpeopleId").value;
		esureyFamilyDS=L5.DatasetMgr.lookup("esureyFamilyDS");
		esureyFamilyDS.newRecord();
		$("familyAddress").innerHTML=organName;
		var esureyPeopleDS3=L5.DatasetMgr.lookup("esureyPeopleDS3");
		esureyPeopleDS3.newRecord();	
		clearEsurey();
	}
	if(method=="editLS"||method=="editTS"){
		esureyFamilyDS=L5.DatasetMgr.lookup("esureyFamilyDS");
		esureyFamilyDS.baseParams['FAMILY_ID@=']=supFamilyId;
		esureyFamilyDS.load();
		var esureyPeopleDS3=L5.DatasetMgr.lookup("esureyPeopleDS3");
		esureyPeopleDS3.baseParams['FAMILY_ID@=']=supFamilyId;
		esureyPeopleDS3.baseParams['RELATIONSHIP_TYPE@=']='01';
		esureyPeopleDS3.on("load",querySupPeopleMess);
		esureyPeopleDS3.load();
	}
	
	var jtsfxxPanel = L5.getCmp('jtsfxxPanel');
	jtsfxxPanel.setVisible(true);
	var jtjbxxPanel = L5.getCmp('jtsffxxPanel');
	jtjbxxPanel.setVisible(false);
}
//赡养户主经济信息
function querySupPeopleMess(esureyPeopleDS3){
	var supPeoRecord=esureyPeopleDS3.getCurrent();
	$("hcyName").innerHTML=supPeoRecord.get("name");
	$("hcyIdCard").innerHTML=supPeoRecord.get("idCard");
	var peopleId=supPeoRecord.get("peopleId");
	//经济信息
	loadEsurey(peopleId);
}
//进行下一步-维护家庭赡（抚、扶）养义务人员信息
function nextJtsfcy() {
	var parentFamilyId=document.getElementById("parentFamilyId").value;
	//保存申报人的家庭信息
	//家庭Dataset
	var esureyFamilyDS = L5.DatasetMgr.lookup("esureyFamilyDS");
	esureyFamilyDS.set("regAddress",_$('regAddressh'));
	//人员Dataset
	var esureyPeopleDS3=L5.DatasetMgr.lookup("esureyPeopleDS3");
    	esureyPeopleDS3.set("peopleId",peopleId);
		esureyPeopleDS3.set("familyId",familyId);
		esureyPeopleDS3.set('sex',_$('hsex'));
		esureyPeopleDS3.set('nation',-$('hnation'));
		esureyPeopleDS3.set('eduCode',_$('heduCode'));
		esureyPeopleDS3.set('healthCode',_$('hhealthCode'));
		esureyPeopleDS3.set('marriageCode',_$('hmarriageCode'));
		esureyPeopleDS3.set('careerCode',_$('hcareerCode'));
		esureyPeopleDS3.set('politicalCode',_$('hpoliticalCode'));
		esureyPeopleDS3.set('domicileType',_$('hdomicileType'));
		esureyPeopleDS3.set('incomeYear',_$('hincomeYear'));
		esureyPeopleDS3.set('incomeMonth',_$('hincomeMonth'));
		esureyPeopleDS3.set('workUnitName',_$('hworkUnitName'));
	var esureyFamily=esureyFamilyDS.getCurrent();
	var esureyPeople=esureyPeopleDS3.getCurrent();
	esureyFamily.set("familyAddress",organArea);
   	if(method=="insertL"||method=="insertLS"||method=="insertTS"){
   		esureyFamily.set("familyId",familyId);
	    esureyFamily.set("familyType","S");
	    esureyFamily.set("domicileType",_$("domicileType"));
	    esureyFamily.set("houseStatus",_$("houseStatus"));
		esureyFamily.set("buildingStructure",_$("buildingStructure"));
	 }
	    //户主信息	
		var isSupport=esureyPeople.get("isSupport");
		esureyPeople.set("name",esureyFamily.get("familyName"));
		esureyPeople.set("relationshipType","01");
		esureyPeople.set("idCard",esureyFamily.get("familyCardNo"));
		esureyPeople.set("domicileType",esureyFamily.get("domicileType"));
  
   	//农村
		if(esureyFamily.get("domicileType")==COUNTRY){
			if(esureyPeople.get("incomeYear")==""){
				esureyPeople.set("incomeYear","0.00");
			}
			esureyPeople.set("incomeMonth",changeTwoDecimal(Math.round(esureyPeople.get("incomeYear")/12*100)/100));
		}
		//城市
		if(esureyFamily.get("domicileType")==TOWN){
			if(esureyPeople.get("incomeMonth")==""){
				esureyPeople.set("incomeMonth","0.00");
			}
			esureyPeople.set("incomeYear",changeTwoDecimal(Math.round(esureyPeople.get("incomeMonth")*12*100)/100));	
		}
		esureyPeople.set("personalStatsTag","1");
	//家庭校验
	if(_$("familyName")==""){
		L5.Msg.alert("提示","户主姓名，必须填写！");
		return;
	}
	if(_$("familyCardNo")==""){
		L5.Msg.alert("提示","身份证号码，必须填写！");
		return;
	}
	//是否赡养人员
	var isSupport=_$("hisSupport");
	if(isSupport==""){
		L5.Msg.alert("提示","是否为赡养义务人员，不能为空！");
		return;
	}
	
	//邮编
	var familyPostcode=_$("familyPostcode");
	if(familyPostcode!=""){
		if(!_isPostCode(familyPostcode)){
			L5.Msg.alert("提示","邮政编码格式不对！",function(){
				$("familyPostcode").value="";
				$("familyPostcode").focus();
			});
			return;
		}
	}
	//宅电
/*	var familyPhone=_$("familyPhone");
	if(familyPhone!=""){
		if(!isFTel(familyPhone)){
			L5.Msg.alert("提示","宅电输入错误！",function(){
				$("familyPhone").value="";
				$("familyPhone").focus();
			});
			return;
		}
	}
	*/
	//手机
	//var familyMobile=_$("familyMobile");
	//if(familyMobile!=""){
	//	if(!isMTel(familyMobile)){
	//		L5.Msg.alert("提示","手机号码输入错误！",function(){
	//			$("familyMobile").value="";
	///			$("familyMobile").focus();
	//		});
	///		return;
	//	}
	//}
	//其他联系方式
	var familyOtherPhone=_$("familyOtherPhone");
		if(familyOtherPhone!=""){
		if(!isTel(familyOtherPhone)){
			L5.Msg.alert("提示","其他联系方式输入错误！",function(){
				$("familyOtherPhone").value="";
				$("familyOtherPhone").focus();
			});
			return;
		}
	}
	//房屋面积
	if(_$("buildArea")!=""){
		var buildArea=checkMoneyFix(_$("buildArea"),2);
		if(buildArea=="整数"){
			if(_$("buildArea").length>14){
				L5.Msg.alert("提示","校验未通过：房屋面积格式不正确，整数最长不超过8位！",function(){
					$("buildArea").value="";
					$("buildArea").focus();
				});
				return;
			}
		}	
		if(buildArea==false){
			L5.Msg.alert("提示","校验未通过：房屋面积格式不正确，小数点后应保留两位！",function(){
				$("buildArea").value="";
				$("buildArea").focus();
			});
			return;
		}
	}
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
	//外部单位信息校验
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
	var command = new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyCmd");
    command.setParameter("SamEsureyFamily", esureyFamily);
    command.setParameter("esureyPeople",esureyPeople);
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
    command.setParameter("parentFamily",parentFamilyId);    
    if(method=="insertL"||method=="insertLS"||method=="insertTS"){
    	command.setParameter("signType", "insert");	
    	command.setParameter("isSupport", "YES");	
    }
    if(method=="editLS"||method=="editTS"){
    	command.setParameter("signType", "update");
    	command.setParameter("isSupport", "NO");
    }
    command.execute("insert");
	if (!command.error) {
			if("1"==isSupport){
				insert_relation(peopleId);
			}	
			peopleId="";
			L5.Msg.alert('提示','家庭信息保存成功!',function(){
			var jtsfxxPanel = L5.getCmp('jtsfxxPanel');
			jtsfxxPanel.setVisible(false);
			var jtjbxxPanel = L5.getCmp('jtsffxxPanel');
			jtjbxxPanel.setVisible(true);
			
			var esureyPeopleDS=L5.DatasetMgr.lookup("esureyPeopleDS");
			if(method=="insertL"||method=="insertLS"||method=="insertTS"){
				esureyPeopleDS.baseParams["FAMILY_ID@="]=familyId;
			}else if(method=="editLS"||method=="editTS"){
				esureyPeopleDS.baseParams["FAMILY_ID@="]=supFamilyId;
			}		
			esureyPeopleDS.load();				
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//全部保存
function allSave(){
	if(method=="editLS"){
    		L5.Msg.alert("提示","修改成功！",function(){
    		var data=new L5.Map();
			data.put("familyId",idFeld);
			data.put("method","editL");
			var text="困难家庭信息";
			var url="jsp/cams/drel/esurey/internal/esureyInfoEdit.jsp";
			L5.forward(url,text,data);
    	});   
    	return;			
    }else if(method=="editTS"){
    		L5.Msg.alert("提示","修改成功！",function(){
    		var data=new L5.Map();
			data.put("familyId",idFeld);
			data.put("method","editT");
			var text="困难家庭信息";
			var url="jsp/cams/drel/esurey/internal/esureyInfoEdit.jsp";
			L5.forward(url,text,data);
    	});   
    	return;	
    }
    L5.MessageBox.confirm('保存成功!', '是否需要继续添加赡（抚、扶）养信息？',function(state){
	if(state=="yes"){
		var data=new L5.Map();
		data.put("BeanId",idFeld);
		if(method=="insertL"){
			data.put("method","insertL");
		}else if(method=="insertLS"){
			data.put("method","insertLS");
		}else if(method=="insertTS"){
			data.put("method","insertTS");
		}
		var url="jsp/cams/drel/esurey/internal/esureyInfoSFInsert.jsp";
		var text="";
		L5.forward(url,text,data);
	}else{
		if(method=='insertLS'){
			var data=new L5.Map();
			data.put("familyId",idFeld);
			data.put("method","editL");
			var text="困难家庭信息";
			var url="jsp/cams/drel/esurey/internal/esureyInfoEdit.jsp";
			L5.forward(url,text,data);
		}else if(method=="insertL"){
			var url="jsp/cams/drel/esurey/internal/esureyInfoList.jsp";
			L5.forward(url);
		}else if(method=="insertTS"){
			var data=new L5.Map();
			data.put("familyId",idFeld);
			data.put("method","editT");
			var text="困难家庭信息";
			var url="jsp/cams/drel/esurey/internal/esureyInfoEdit.jsp";
			L5.forward(url,text,data);
		}
	}
	});						
}

//打开新增家庭赡（抚、扶）养义务人员信息面板
function addSfFamilyMember(grid,a,b,c) {
	var win=L5.getCmp('jtcyEdit');
	win.setTitle(grid.text);
	win.x = 10;
	win.y = 10;
	win.draggable = false;
	//添加人员信息
	var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
	command.setParameter("IdHelp","Id30");
	command.execute();
	var newId=command.getReturn("id");
	var esureyPeopleDS2=L5.DatasetMgr.lookup("esureyPeopleDS2");
	if(method=="insertL"||method=="insertLS"||method=="insertTS"){
		esureyPeopleDS2.newRecord({
	  	  peopleId: newId,	
	  	  familyId:familyId	
		});	
	}else if(method=="editLS"||method=="editTS"){
		esureyPeopleDS2.newRecord({
	  	  peopleId: newId,	
	  	  familyId:supFamilyId	
		});	
	}
	clearEsurey();	
	win.show(grid.el.dom);
	wFlag="insert";
	var jtcyTabpanel = L5.getCmp('jtcyTabpanel');
	jtcyTabpanel.setActiveTab(0);
	$("idCard").disabled=false;
	$("relationshipType").disabled=false;
	$("cyName").innerHTML="";
	$("cyIdCard").innerHTML="";	
	
}
//修改人员信息
function editSfFamilyMember(grid,a,b,c){
	var jtcyGridPanel=L5.getCmp("ywcyGridPanel");
	var cells= jtcyGridPanel.getSelectionModel().getSelections();
	if(cells.length<1){
		L5.Msg.alert("提示","请选择要修改的记录！");
		return;
	}
	peopleId=cells[0].get("peopleId");
	var isSupp=cells[0].get("isSupport");
	if(isSupp==1){
		sFlag="isSupport";
	}
	//人员信息
	var esureyPeopleDS2=L5.DatasetMgr.lookup("esureyPeopleDS2");
	esureyPeopleDS2.baseParams['PEOPLE_ID@=']=peopleId;
	esureyPeopleDS2.load();
	//经济信息
	loadEsurey(peopleId);
	 
	var win=L5.getCmp('jtcyEdit');
	win.setTitle(grid.text);
	win.x = 10;
	win.y = 10;
	win.draggable = false;	
	win.show(grid.el.dom);
	wFlag="update";
	L5.getCmp("jtcyTabpanel").setActiveTab("0");
	var relationType=cells[0].get("relationshipType");
	if(relationType=='1'){
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
function deleteSfFamilyMember(){
	var esureyPeopleDS=L5.DatasetMgr.lookup("esureyPeopleDS");
	var peoplePanel = L5.getCmp('ywcyGridPanel');
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
				L5.Msg.alert("提示","户主信息不可以删除！");
				return;
			}
			var isSupport=cells[0].get("isSupport");
			var command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleCmd");
			if(isSupport=="1"){
				command.setParameter("Flag","isSupport");
			}else{
				command.setParameter("Flag","notSupport");
			}
			command.setParameter("peopleId", peopleId2);
			command.setParameter("familyId",familyId2);
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
	var esureyPeopleDS2 = L5.DatasetMgr.lookup("esureyPeopleDS2");
	var esureyPeople=esureyPeopleDS2.getCurrent();
	peopleId=esureyPeople.get("peopleId");
	var idCardCheck=esureyPeople.get("idCard");
	//农村
	if(esureyPeople.get("domicileType")==COUNTRY){
		if(esureyPeople.get("incomeYear")==""){
			esureyPeople.set("incomeYear","0.00");
		}
		esureyPeople.set("incomeMonth",changeTwoDecimal(Math.round(esureyPeople.get("incomeYear")/12*100)/100));
	}
	//城市
	if(esureyPeople.get("domicileType")==TOWN){
		if(esureyPeople.get("incomeMonth")==""){
			esureyPeople.set("incomeMonth","0.00");
		}
		esureyPeople.set("incomeYear",changeTwoDecimal(Math.round(esureyPeople.get("incomeMonth")*12*100)/100));	
	}
	var isSupport=esureyPeople.get("isSupport");
	if(sFlag=="isSupport"){
		if(isSupport!=1){
			sFlag="notSupport";
		}
	}
	if(wFlag=="insert"){	
		esureyPeople.set("personalStatsTag","1");
		var relationshipType=esureyPeople.get("relationshipType");
		if(relationshipType=="1"){
			L5.Msg.alert("提示","户主已存在！");
			return;
		}
	}
	if(wFlag=="update2"){
		var relationshipType=esureyPeople.get("relationshipType");
		if(relationshipType!="1"){
			L5.Msg.alert("提示","此人员的户主关系不可以修改！");
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
	}else if(domicile==COUNTRY){
		var incomeYear=_$("incomeYear");
		if(incomeYear==""){
			L5.Msg.alert("提示","请输入年收入！");
			return;
		}
	}
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
	}else if(wFlag=="update"||wFlag=="update2"){
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
    if(wFlag=="update"||wFlag=="update2"){
    command.setParameter("signType", "update");
    }
    //赡养人员修改为非赡养人员
    if(sFlag=="notSupport"){
    command.setParameter("sFlag","notSupport");
    }
	command.execute("save");
	if (!command.error) {
		if("1"==isSupport){
			insert_relation(peopleId);
		}
		peopleId="";
		L5.Msg.alert('提示','家庭成员信息保存成功!',function(){
			hide_win();
		});					
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}	
}
//为赡养义务人员
function insert_relation(peopleId){
		var esureyRelationDS=L5.DatasetMgr.lookup("esureyRelationDS");
		var SamEsureyRelation=esureyRelationDS.newRecord();
		SamEsureyRelation.set("familyId",idFeld);
		SamEsureyRelation.set("peopleId",peopleId);
		if(method=="insertL"||method=="insertLS"||method=="insertTS"){
			SamEsureyRelation.set("supportFamilyId",familyId);
		}else if(method=="update"){
			SamEsureyRelation.set("supportFamilyId",supFamilyId);
		}	
		var command = new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyRelationCmd");
		command.setParameter("SamEsureyRelation", SamEsureyRelation);
		command.execute("insert");
		if (!command.error) {					
		}else{
			L5.Msg.alert("提示","保存时出错！"+command.error);
		}
}
//关闭人员信息和相应的经济信息窗口
function hide_win(){
	var win=L5.getCmp("jtcyEdit");
	win.hide();
	var esureyPeopleDS=L5.DatasetMgr.lookup("esureyPeopleDS");
	if(method=="insertL"||method=="insertLS"||method=="insertTS"){
		esureyPeopleDS.baseParams["FAMILY_ID@="]=familyId;
	}else if(method=="update"){
		esureyPeopleDS.baseParams["FAMILY_ID@="]=supFamilyId;
	}
	esureyPeopleDS.load();
}

//清空经济信息
function  clearEsurey(){
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
}
//根据peopleId加载经济信息
function loadEsurey(peopleId){
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