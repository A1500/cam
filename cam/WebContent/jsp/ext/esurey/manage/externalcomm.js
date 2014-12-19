 
//当前command
var command;
//当前dataset
var dataset;
//当前页面
var currentJsp;
//提交条件是否正确
var flag=true;
//页面初始化方法
function init(){
	domicileDataset.setParameter("filterSql"," id like '"+organCode.substring(0,4)+"%000000'");
	domicileDataset.load();
	//得到当前路径
	var parths=document.location.pathname.split("/");
	currentJsp=parths[parths.length-1];
	//根据当前路径中的jsp文件名判断使用哪个Command和dataset
	if(currentJsp=="esureyExternalSocial.jsp"){
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureySocialQueryCmd");
		dataset=L5.DatasetMgr.lookup("externalSocialDataset");
		query();
	}else if(currentJsp=="esureyExternalHouse.jsp"){
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyHouseQueryCmd");
		dataset=L5.DatasetMgr.lookup("externalHouseDataset");
		query();
	}else if(currentJsp=="esureyExternalBusiness.jsp"){
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyBusinessQueryCmd");
		dataset=L5.DatasetMgr.lookup("externalBusinessDataset");
		query();
	}else if(currentJsp=="esureyExternalGTax.jsp"){
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyTaxQueryCmd");
		dataset=L5.DatasetMgr.lookup("externalGTaxDataset");
		query();
	}else if(currentJsp=="esureyExternalDTax.jsp"){
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyTaxQueryCmd");
		dataset=L5.DatasetMgr.lookup("externalDTaxDataset");
		query();
	}else if(currentJsp=="esureyExternalCar.jsp"){
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyCarQueryCmd");
		dataset=L5.DatasetMgr.lookup("externalCarDataset");
	}else if(currentJsp=="esureyExternalBank.jsp"){
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyBankQueryCmd");
		dataset=L5.DatasetMgr.lookup("externalBankDataset");
		query();
	}else if(currentJsp=="esureyExternalHousingFund.jsp"){
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyHousingFundQueryCmd");
		dataset=L5.DatasetMgr.lookup("externalHousingFundDataset");
		query();
	}else if(currentJsp=="esureyExternalInsurance.jsp"){
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureyInsuranceQueryCmd");
		dataset=L5.DatasetMgr.lookup("externalInsuranceDataset");
		query();
	}else if(currentJsp=="esureyExternalSecurities.jsp"){
		command=new L5.Command("com.inspur.cams.drel.esurey.cmd.SamEsureySecuritiesQueryCmd");
		dataset=L5.DatasetMgr.lookup("externalSecuritiesDataset");
		query();
	}
	
}
//弹出救助对象属地选择通用帮助
function forHelp(){
       var revalue=window.showModalDialog("../../../../jsp/bsp/organization/getselect_code.jsp?rootId=1&showOrganType=1&organType=11,12,13&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
       if(revalue!=""&&revalue!=undefined){
          var list = revalue.split(";");
          document.getElementById("familyAddress").value = list[1];
          document.getElementById("familyAddressh").value = list[0];
       }     
}
//检查时间段合法
function checked(){
	var s=document.getElementById("startTime").value;
    var e=document.getElementById("endTime").value; 
/*	if(e!==""&&s>e){
		document.getElementById("et").innerHTML='<font color="red">开始时间不能晚于结束时间</font>';
		flag=false;
	}else{
		document.getElementById("et").innerHTML='';
*/
		flag=true;
//	}
}

//查询按钮方法
function query(){
	checked();
	if(flag){
		dataset.setParameter("name",getParam("name"));
		dataset.setParameter("idCard",getParam("idCard"));
		dataset.setParameter("familyAddress",getParam("familyAddressh"));
		dataset.setParameter("startTime",getParam("startTime"));
		dataset.setParameter("endTime",getParam("endTime"));
		dataset.setParameter("checkOrganId",organId);
		dataset.load();
	}
}

//诚信查询按钮方法
function queryCredit(){
	checked();
	if(flag){
		dataset.setParameter("creditRating",getParam("creditRating"));
		dataset.setParameter("assistanceType",getParam("assistanceType"));
		dataset.setParameter("familyAddress",getParam("familyAddressh"));
		dataset.setParameter("startTime",getParam("startTime"));
		dataset.setParameter("endTime",getParam("endTime"));
		dataset.load();
	}
}

//根据组件的ID得到组件的value
function getParam(ElementId){
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
//打印
function forExcel() {
	if(dataset.getCount() <= 0) {
		L5.Msg.alert('提示', "无查询结果，不能导出!");
		return false;
	}
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
//	dataset.baseParams["limitExcel"]=dataset.getTotalCount();
	dataset.baseParams["limitExcel"]=pageSize;  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
	if(currentJsp=="esureyExternalCar.jsp"){
		L5.dataset2excel(dataset, "/jsp/ext/esurey/manage/forCarExcel.jsp");
	}else if(currentJsp=="esureyExternalHouse.jsp"){
		L5.dataset2excel(dataset, "/jsp/ext/esurey/manage/forHouseExcel.jsp");
	}else if(currentJsp=="esureyExternalSocial.jsp"){
		L5.dataset2excel(dataset, "/jsp/ext/esurey/manage/forSocialExcel.jsp");
	}
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}
