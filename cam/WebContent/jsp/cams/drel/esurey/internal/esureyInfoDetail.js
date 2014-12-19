
function init(){
	if(fromPage=="apply"){
		document.getElementById("undoButtonId").style.display='none';
	}
	//家庭信息
	var esureyFamilyDS=L5.DatasetMgr.lookup("esureyFamilyDS");
	esureyFamilyDS.setParameter("FAMILY_ID",familyId);	
	esureyFamilyDS.load();
	//家庭成员信息
	var esureyPeopleDS=L5.DatasetMgr.lookup("esureyPeopleDS");
	esureyPeopleDS.setParameter("FAMILY_ID",familyId);
	esureyPeopleDS.load();
	//赡养家庭成员信息
	var esureyPeopleDS4=L5.DatasetMgr.lookup("esureyPeopleDS4");
	esureyPeopleDS4.setParameter("familyId",familyId);
	esureyPeopleDS4.load();
}
/**
 *  事件处理：点击户主姓名链接
 *
 */
function peopleDetailHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:peopleDetail(\''+record.data["peopleId"]+'\')">' + value + '</a>';
}
/**
 *  事件处理：点击户主姓名链接
 *
 */
function suppeopleDetailHref(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:peopleDetail2(\''+record.data["PEOPLE_ID"]+'\')">' + value + '</a>';
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
	var peopleId=cells[0].get("PEOPLE_ID");
	peopleDetail2(peopleId);
}
//查看人员信息
function peopleDetail(peopleId){
	var win=L5.getCmp('jtcyEdit');
	win.setTitle("详情");
	win.x = 10;
	win.y = 10;
	win.draggable = false;	
	win.show();
	L5.getCmp("jtcyTabpanel").setActiveTab("0");
	//人员信息
	var esureyPeopleDS2=L5.DatasetMgr.lookup("esureyPeopleDS2");
	esureyPeopleDS2.baseParams['PEOPLE_ID@=']=peopleId;
	esureyPeopleDS2.on("load",queryMess);
	esureyPeopleDS2.load();
	//经济信息
	loadEsurey(peopleId);
}
//查看人员信息
function peopleDetail2(peopleId){
	var win=L5.getCmp('jtcyEdit');
	win.setTitle("详情");
	win.x = 10;
	win.y = 10;
	win.draggable = false;	
	win.show();
	L5.getCmp("jtcyTabpanel").setActiveTab("0");
	$("sup_tr").style.display="block";
	//人员信息
	var esureyPeopleDS2=L5.DatasetMgr.lookup("esureyPeopleDS2");
	esureyPeopleDS2.baseParams['PEOPLE_ID@=']=peopleId;
	esureyPeopleDS2.on("load",queryMess);
	esureyPeopleDS2.load();
	//经济信息
	loadEsurey(peopleId);
}
function hide_win(){
	$("sup_tr").style.display="none";
	var win=L5.getCmp("jtcyEdit");
	win.hide();
}
function queryMess(){
	var esureyPeopleDS2=L5.DatasetMgr.lookup("esureyPeopleDS2");
	var record=esureyPeopleDS2.getCurrent();
	$("cyName").innerHTML=record.get("name");
	$("cyIdCard").innerHTML=record.get("idCard");
	
}
//返回List
function return_list(){
	if(method=="detailC"){
		var url="jsp/cams/drel/esurey/internal/esureyInfoCheckIssueQuery.jsp";
		L5.forward(url);
	}else if(method=="query"){
		var url="jsp/cams/drel/esurey/internal/esureyInfoQueryList.jsp";
		L5.forward(url);
	}else if(method=="detailL"){
		var url="jsp/cams/drel/esurey/internal/esureyInfoList.jsp";
		L5.forward(url);
	}else if(method=="center"){
		var url="jsp/cams/drel/esurey/internal/esureyCenterInfoList.jsp";
		L5.forward(url);
	}
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
	var supfamilyId=cells[0].get("FAMILY_ID");
	if(method=="detailC"){
		var data=new L5.Map();
		data.put("supfamilyId",supfamilyId);
		data.put("familyId",familyId);
		data.put("method","detailCS");
		var url="jsp/cams/drel/esurey/internal/esureyInfoSupDetail.jsp";
		var text="";
		L5.forward(url,text,data);
	}else if(method=="query"){
		var data=new L5.Map();
		data.put("supfamilyId",supfamilyId);
		data.put("familyId",familyId);
		data.put("method","query");
		var url="jsp/cams/drel/esurey/internal/esureyInfoSupDetail.jsp";
		var text="";
		L5.forward(url,text,data);
	}else if(method="detailL"){	
		var data=new L5.Map();
		data.put("supfamilyId",supfamilyId);
		data.put("familyId",familyId);
		data.put("method","detailLS");
		var url="jsp/cams/drel/esurey/internal/esureyInfoSupDetail.jsp";
		var text="";
		L5.forward(url,text,data);
	}
}
//经济信息
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