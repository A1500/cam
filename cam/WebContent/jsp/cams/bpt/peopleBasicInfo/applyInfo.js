function init(){
var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
    BaseinfoPeopleDataSet.setParameter("peopleId",peopleId);
    BaseinfoPeopleDataSet.load();
    L5.getCmp('editGridPanel').on("rowclick",getPage);
}
function getPage(){
   var grid = L5.getCmp("editGridPanel");
   var selected=grid.getSelectionModel().getSelections();
   var applyId = selected[0].get('APPLYID');
   var serviceType = selected[0].get('SERVICETYPE');
   var url = getUrl(serviceType,applyId);
  // var url= "peopleUpdate.jsp?peopleId="+peopleId;
   document.getElementById("peopleInfo").src=url;
}
function getUrl(serviceType,applyId){
	var url;
	if(serviceType=='11'||serviceType=='12'||serviceType=='13'||serviceType=='18'){
		url="../basicInfoView/pendingExam.jsp?applyId="+applyId+"&serviceType="+serviceType;
	}else if(serviceType=='14'){
		url="../basicInfoView/disabilityVeteransApproveDetail.jsp?applyId="+applyId;
	}
	if(serviceType=='17'){
		url="../basicInfoView/assistiveDevicesAppDetail.jsp?applyId="+applyId;
	}
	if(serviceType=='41'||serviceType=='45'){
		url="../basicInfoView/demobilizedExam.jsp?applyId="+applyId;
	}
	
	if(serviceType=='16'||serviceType=='23'||serviceType=='43'||serviceType=='47'||serviceType=='53'||serviceType=='63'||serviceType=='B3'||serviceType=='83'){
		url="../basicInfoView/provinceMigratExam.jsp?applyId="+applyId;
	}
	if(serviceType=='19'||serviceType=='25'||serviceType=='55'||serviceType=='65'||serviceType=='4A'||serviceType=='4B'||serviceType=='B4'||serviceType=='84'){
		url="../basicInfoView/emigratExam.jsp?applyId="+applyId;
	}
	if(serviceType=='15'||serviceType=='22'||serviceType=='42'||serviceType=='46'||serviceType=='52'||serviceType=='62'||serviceType=='B2'||serviceType=='82'){
		url="../basicInfoView/intoProviExam.jsp?applyId="+applyId;
	}
	if(serviceType=='21'||serviceType=='51'||serviceType=='61'){
		url="../basicInfoView/DWTTownapprovedDetail.jsp?applyId="+applyId;
	}
	if(serviceType=='B1'){
		url='../flow/martyroffspring/martyrOffspringTownDetail.jsp?applyId='+applyId;
	}
	if(serviceType=='81'){
		url='../flow/countretiredsoldier/townApprovedDetail.jsp?applyId='+applyId;
	}
	return url;
	
}