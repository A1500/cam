var villageCodeString = "";
function init(){
	query();
	document.getElementById("lrdwmc").value=organName;
	document.getElementById("lrdwId").value=organArea;
}
//新增业务
function insert(){
	var url="jsp/cams/drel/specialpoorFamily/specialpoorFamilyInsert.jsp?method=insert";
	L5.forward(url);
}
//办理						
function update(){
	var grid = L5.getCmp('daiBanGridPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
	    var url="jsp/cams/drel/specialpoorFamily/specialpoorFamilyInsert.jsp?method=update&familyId="+records[0].get("familyId");
		L5.forward(url);
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
function deleteFamily(){
	var grid = L5.getCmp('daiBanGridPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var command = new L5.Command("com.inspur.cams.drel.special.cmd.SpecialpoorFamilyCmd");
		command.setParameter("familyId",records[0].get("familyId"));
		command.execute("deleteFamily");
		if (!command.error) {
			L5.Msg.alert("提示","删除成功！",function(){
				speFamilyDataset.reload();
			});		
		}else{
			L5.Msg.alert('提示',"删除时出现错误！"+command.error);
		}
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//导出
function printCityDaiBan(){
	 
}
//查询
function query(){
   var lrdwId=document.getElementById("lrdwId").value;
    if(""==lrdwId){
    	lrdwId=organArea;
    }
	var familyName=document.getElementById("familyName").value;
	speFamilyDataset.setParameter("domicile_Code@like",queryCode);
	speFamilyDataset.setParameter("family_Name@like",familyName);
	var supportNameID = document.getElementById("supportNameID").value;
	if(supportNameID != '' ){
		SpecialpoorSupportRefDataset.setParameter("support_Unit_Code",supportNameID);
		SpecialpoorSupportRefDataset.load();
		SpecialpoorSupportRefDataset.on("load",findVillage);
	}else{
		speFamilyDataset.load();
	}
	noReclick(speFamilyDataset,"queryId");
}
function findVillage(ds){
	ds.un("load",findVillage);
	villageCodeString = "";
	for (var i = 0 ;i<ds.getCount();i++){
		var record = ds.getAt(i);
		villageCodeString += record.get("helpVillageCode")+",";
	}
	speFamilyDataset.setParameter("help_Village_Code@in",villageCodeString.substring(0,villageCodeString.length-1));
	speFamilyDataset.load();
}
/**
 * 选择属地行政区划窗口
 */
function func_ForDomicileSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("lrdwId").value = list[0];
		document.getElementById("lrdwmc").value = list[1];
	}
}
//获取当前时间
function getCurrent(){
	
	return (new Date()).getTime();
}