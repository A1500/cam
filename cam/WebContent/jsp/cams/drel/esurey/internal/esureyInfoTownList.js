/**
*页面初始化方法
*/
function init(){
	var EsureyFamilyDS=L5.DatasetMgr.lookup("EsureyFamilyDS");
	EsureyFamilyDS.setParameter("CUR_ACTIVITY","02");
	EsureyFamilyDS.setParameter("CUR_STATE","0");
	EsureyFamilyDS.setParameter("CHECK_ORG_AREA",organCode);
	EsureyFamilyDS.setParameter('FAMILY_TYPE','K');
	EsureyFamilyDS.load();
}
/**
*查询
*/
function query(){
	var EsureyFamilyDS=L5.DatasetMgr.lookup("EsureyFamilyDS");
    var qName=_$("qName"); 
    var qIdCard=_$("qIdCard");

	EsureyFamilyDS.baseParams['FAMILY_NAME@=']=qName;
	EsureyFamilyDS.baseParams['FAMILY_CARD_NO@=']=qIdCard;	
	EsureyFamilyDS.baseParams['CUR_ACTIVITY@=']='02';
	EsureyFamilyDS.baseParams['CUR_STATE@=']='0';
	EsureyFamilyDS.baseParams['FAMILY_TYPE@=']='K';
	EsureyFamilyDS.baseParams['CHECK_ORG_AREA@=']=organCode;
	
	EsureyFamilyDS.load();
}
/*
*修改
*/
function edit_esurey(){
	var grid=L5.getCmp("esurey_Grid");
	var selected = grid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.MessageBox.alert("提示",'请选择要修改的记录');
		return false;
	}
	if(selected[0].get("curActivity")!="02"||selected[0].get("curState")=="4"){
		L5.Msg.alert("提示","已经审核，不能修改！");
		return;
	}
	var familyId=selected[0].get("familyId");
	var data=new L5.Map();
	data.put("familyId",familyId);
	data.put("method","editT");
	var text="困难家庭信息";
	var url="jsp/cams/drel/esurey/internal/esureyInfoEdit.jsp";
	L5.forward(url,text,data);
}

/**
*审核
*/
function check_esurey(){
	var esureyGrid=L5.getCmp('esurey_Grid');
	var selected=esureyGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.MessageBox.alert("提示",'请选择要审核的记录');
		return false;
	}
	if(selected[0].get("curActivity")!="02"||selected[0].get("curState")=="4"){
		L5.Msg.alert("提示","已经审核，不能重复审核！");
		return;
	}
	var data = new L5.Map();
	data.put("familyId",selected[0].get('familyId'));
	var url='jsp/cams/drel/esurey/internal/esureyInfoTownCheck.jsp';
	var text = '乡镇（街道）审核';
	L5.forward(url,text,data);
}
