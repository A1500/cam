var fileCode = "J072";
function init(){
	document.getElementById("cnName").innerHTML=cnName;
	document.getElementById("sorgCode").innerHTML=sorgCode;	
	
	somOrganDataSet.setParameter("SORG_ID",mainSorgId);
	somOrganDataSet.load();
	somOrganDataSet.on('load', function(ds){
		document.getElementById("McnName").innerHTML=ds.get('cnName');
		document.getElementById("MsorgCode").innerHTML=ds.get('sorgCode');	
	});
	
	
	aspForJianShi.setParameter("SORG_ID",sorgId);
	aspForJianShi.load();			
	
}
function forDetail(){
	var grid=L5.getCmp("peopleGrid");
	var selectRecord=grid.getSelectionModel().getSelected();
	if(!selectRecord){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	somDutyDataSet.removeAll();
	var record=somDutyDataSet.newRecord();
	somDutyDataSet.remove(record);
	somDutyDataSet.insert(0,selectRecord.copy());
	somResumeInsertDataSet.removeAll();
	somResumeInsertDataSet.setParameter("DUTY_ID",selectRecord.get('dutyId'));
	somResumeInsertDataSet.load();
	L5.getCmp("peopleWin").show();
	L5.getCmp("peoplePanel").setActiveTab("2");
	L5.getCmp("peoplePanel").setActiveTab("1");
	L5.getCmp("peoplePanel").setActiveTab("0");
	var birthday=selectRecord.get("birthday");
	var day=new Date();
	var year=day.getYear();
	var birthYear=birthday.substring(0,4);
	document.getElementById("age").innerHTML=parseInt(year)-parseInt(birthYear);
	synPhoto(somDutyDataSet.get("photoId"),"1");//同步照片
	//同步法律要件
	somPeopleElectronicDataSet.setParameter("fileCodes",fileCode);
	somPeopleElectronicDataSet.setParameter("dutyId",selectRecord.get("dutyId"));
	somPeopleElectronicDataSet.setParameter("sorgId",sorgId);
	somPeopleElectronicDataSet.setParameter("applyType",applyType);
	somPeopleElectronicDataSet.load();
}
function returnBack(){
	var data=new L5.Map();
	var url="";
	data.put("sorgId",sorgId);
	data.put("cnName",encodeURIComponent(encodeURIComponent(cnName)));
	data.put("sorgCode",sorgCode);	
	data.put("searchCnName",encodeURIComponent(encodeURIComponent(searchCnName)));
	data.put("searchSorgCode",searchSorgCode);	
	url="jsp/cams/sorg/manage/fund/fundManagePeopleList.jsp";
	L5.forward(url,'',data);	
}
function closePeopleWIn(){
	var win = L5.getCmp("peopleWin");
	win.hide();
}
function countRender(value){
	if(value === undefined){
		value=0;
	}
	return "负责人总人数: "+value+" 人";

}