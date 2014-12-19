//获得核对状态
function getCheckFlg(value,cellmeta,record,rowindex,colindex,dataset){
	if(record.get("IF_CHECK")=="1"){
		var esureyFamilyDS=L5.DatasetMgr.lookup('esureyFamilyDS');
		esureyFamilyDS.setParameter("family_Id",record.get("APPLY_ID"));
		esureyFamilyDS.load(true);
		if(esureyFamilyDS.getCurrent()){
			if(esureyFamilyDS.get('curActivity')=='03'&&esureyFamilyDS.get('curState')=='3'){
				return	'<a href="javascript:getCheckResult(\''+record.get("APPLY_ID")+'\',\''+record.get("FAMILY_ID")+'\')">已核对</a>';
			}else{
				return '核对中';				
			}
		}
		return '';
	}else{
		return '';
	}
}
function getCheckResult(applyId,familyId){
	var data=new L5.Map();
	data.put("familyId",familyId);
	var text="查看困难家庭成员核对信息";
	var url="/jsp/cams/drel/esurey/internal/esureyInfoQueryFamily.jsp?familyId="
					+ applyId+"&fromPage=apply";
	var width = screen.width-100;
	var height = screen.height-140;
	window.showModalDialog(L5.webPath+url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	
}
// 城市低保待办打印
function printCityDaiBan() {
	doPrint('daiBanGridPanel','城市居民最低生活保障');
}
// 城市低保已办打印
function printCityYiBan() {
	doPrint('YiBanGridPanel','城市居民最低生活保障');
}
// 城市低保结束打印
function printCityJieShu() {
	doPrint('YiBanGridPanel','城市居民最低生活保障');
}

// 五保代办打印
function printFiveDaiBan() {
	doPrint('daiBanGridPanel','农村五保供养');

}
// 五保已办打印
function printFiveYiBan() {
	doPrint('YiBanGridPanel','农村五保供养');

}
// 五保结束打印
function printFiveJieShu() {
	doPrint('YiBanGridPanel','农村五保供养');

}

// 农村低保代办打印
function printCountryDaiban() { 
	doPrint('daiBanGridPanel','农村居民最低生活保障');
}
// 农村低保已办打印
function printCountryYiBan() { 
	doPrint('YiBanGridPanel','农村居民最低生活保障');
}
// 农村低保结束打印
function printCountryJieShu() { 
	doPrint('YiBanGridPanel','农村居民最低生活保障');
}
function doPrint(gridId,assistanceName){
	var selected = L5.getCmp(gridId).getSelectionModel()
			.getSelections();
	if (selected.length < 1) {
		L5.Msg.alert("提示", "请选择记录！");
		return;
	}
	var RfrUrl = L5.webPath + '/jsp/cams/drel/application/print/applyNotice.fr3'
	if("农村五保供养"==assistanceName){
		RfrUrl = L5.webPath + '/jsp/cams/drel/application/print/fiveApplyNotice.fr3'
		for(var i=0;i<selected.length;i++){
			if(selected[i].get("SUPPORT_WAY")=="03"){
				selected[i].set("SUPPORT_WAY","集中供养");
			} else {
				selected[i].set("SUPPORT_WAY","分散供养");
			}
		}
	}
	printReport(getPrintDataByRecords(assistanceName, getCurrentDate(), '',
					organName, selected), RfrUrl);
}
