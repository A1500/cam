//初始化加载
/*   3700000100  3717211144001
	增加一个“省直单位联系困难家庭（必填）”，选择是的时候“帮包村名称”必填，自动回填一个“省直单位名称”
	是否低保户改成"是否低保或五保"选择是的时候，救助类型必填,选择否，救助类型不可选择
	致贫原因必选一个
	
	
	民族默认汉族，政治面貌默认群众，救助类别默认和户主一样，
*/
function init(){
	if(method == "insert"){
		speFamilyDataset.newRecord();
	}else{
		updateLoad();
	}
	helpVillage.on("load",helpVillageLoad);
	buttonPeopleDisable();
}
//按钮禁用
function buttonPeopleDisable(){
	L5.getCmp("addPeople").setDisabled(true);
	L5.getCmp("detailPeople").setDisabled(true);
	L5.getCmp("removePeople").setDisabled(true);
}
//启用按钮
function buttonPeopleEnabled(){
	L5.getCmp("addPeople").setDisabled(false);
	L5.getCmp("detailPeople").setDisabled(false);
	L5.getCmp("removePeople").setDisabled(false);
}

function updateLoad(){
	speFamilyDataset.setParameter("family_id",familyId);
	speFamilyDataset.load();
	speFamilyDataset.on('load',setChangeItems);
}
function helpVillageLoad(ds){
	if(ds.getCount()  < 1 ){
		document.getElementById("helpVillageCodeID").disabled= 'disabled';
	}else{
		document.getElementById("helpVillageCodeID").disabled= '';
	}
}
//在选是否低保或五保
function changeassistanceType(value){
	if(value == '1'){
		document.getElementById("assistanceTypeID").disabled= '';
	}else{
		document.getElementById("assistanceTypeID").disabled= 'disabled';
	}
}
//修改页面，设置变更事项checkbox选中状态
function setChangeItems(ds){
	ds.un('load',setChangeItems);
	var changeItems = ds.get("specialpoorCause");
	
	if(changeItems!=''){
		var itemArr=changeItems.split("，");
		for(var i=0;i<itemArr.length;i++){
			document.getElementById("changeItem"+itemArr[i]).checked=true;
		} 
	}
	loadPeople();
}
function loadPeople(){
	helpVillage.setParameter("filterSql", " HELP_VILLAGE_CODE like '" +speFamilyDataset.get("domicileCode")+"%'");
	helpVillage.load();
	peopleListDataSet.setParameter("family_id",familyId);
	peopleListDataSet.load();
}
function showTemp(){
	//tempFamilyDataset.setParameter("domicile_Code@like",parentOrganCode);
	L5.getCmp("tempWin").show();
	if( speFamilyDataset.get("familyName") != '' ){
		document.getElementById('familyNameTemp').value = speFamilyDataset.get("familyName");
		queryTemp();
	}
}

function queryTemp(){
	var domicileCodeTemp = document.getElementById('domicileCodeTemp').value;
	var familyNameTemp = document.getElementById('familyNameTemp').value;
	
	if( domicileCodeTemp == '' && familyNameTemp == '' ){
		L5.Msg.alert("提示","请至少输入一项查询条件！");
		return ;
	}
	
	tempFamilyDataset.setParameter("domicile_Code@like",parentOrganCode);
	tempFamilyDataset.setParameter("address@like",domicileCodeTemp);
	tempFamilyDataset.setParameter("family_Name@like",familyNameTemp);
	tempFamilyDataset.load();
}
function chooseTemp(){
	var grid = L5.getCmp('queryGridPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		speFamilyDataset.set("familyName",records[0].get("familyName"));
		speFamilyDataset.set("peopleNum",records[0].get("peopleNum"));
		speFamilyDataset.set("address",records[0].get("address"));
		speFamilyDataset.set("assistanceFlag",records[0].get("assistanceFlag"));
		speFamilyDataset.set("specialpoorCause",records[0].get("specialpoorCause"));
		speFamilyDataset.set("familyCardNo",records[0].get("familyCardNo"));
		var changeItems = records[0].get("specialpoorCause");
		if(changeItems!=''){
			var itemArr=changeItems.split("，");
			for(var i=0;i<itemArr.length;i++){
				document.getElementById("changeItem"+itemArr[i]).checked=true;
			} 
		}
		speFamilyDataset.set("note",records[0].get("specialpoorCauseName"));
		
		L5.getCmp("tempWin").hide();
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
function showPeopleTemp(){
	L5.getCmp("tempPeopleWin").show();
	if( peopleListDataSet.get("name") != '' ){
		document.getElementById('namePeopleTemp').value = peopleListDataSet.get("name");
		queryPeopleTemp();
	}
}
function queryPeopleTemp(){
	var peopleCardTemp = document.getElementById('peopleCardTemp').value;
	var namePeopleTemp = document.getElementById('namePeopleTemp').value;
	
	if( peopleCardTemp == '' && namePeopleTemp == '' ){
		L5.Msg.alert("提示","请至少输入一项查询条件！");
		return ;
	}
	
	baseinfoPeopleDS.setParameter("idCard",peopleCardTemp);
	baseinfoPeopleDS.setParameter("name",namePeopleTemp);
	baseinfoPeopleDS.setParameter("domicileCode",organArea);
	baseinfoPeopleDS.setParameter("queryDate",getCurYM());
	
	baseinfoPeopleDS.load();
}
function choosePeopleTemp(){
	var grid = L5.getCmp('queryGridPeoplePanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		peopleListDataSet.set("name",records[0].get("NAME"));
		peopleListDataSet.set("idCard",records[0].get("ID_CARD"));
		peopleListDataSet.set("nation",records[0].get("NATION"));
		peopleListDataSet.set("marriageCode",records[0].get("MARRIAGE_CODE"));
		peopleListDataSet.set("politicalCode",records[0].get("POLITICAL_CODE"));
		peopleListDataSet.set("disabilityCaseCode",records[0].get("DISABILITY_TYPE")); 
		peopleListDataSet.set("disabilityLevelCode",records[0].get("DISABILITY_LEVEL"));
		peopleListDataSet.set("assistanceType",records[0].get("ASSISTANCE_TYPE"));
		peopleListDataSet.set("eduCode",records[0].get("EDU_CODE"));
		peopleListDataSet.set("domicileType",records[0].get("DOMICILE_TYPE"));
		peopleListDataSet.set("incomeMonth",records[0].get("INCOME_MONTH"));
		checkIdCard_people();
		L5.getCmp("tempPeopleWin").hide();
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//按钮禁用
function buttonDisable(){
	L5.getCmp("saveId").setDisabled(true);
}
//启用按钮
function buttonEnabled(){
	L5.getCmp("saveId").setDisabled(false);
}
//校验身份证
function checkCradNo(obj){
	var cardNo=obj.value;
	if(cardNo==''){
		return;
	}
	if(checkIDCard(obj) != true && !(cardNo.length==18 && cardNo.lastIndexOf("N")>0 )){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		obj.value='';
		return;
	}
}
//保存
function save(){
	
	buttonDisable();
	var familyIsValidate = speFamilyDataset.isValidate();
	if(familyIsValidate != true){
		L5.Msg.alert("提示",familyIsValidate);
		 buttonEnabled();
		return false;
	}
	var familyRecord=speFamilyDataset.getCurrent();
	
	var specialpoorCauseName = '' ;
	var specialpoorCause = '' ;
	
	var checkboxs = document.getElementsByName("changeItem");       
	for(var i =0;i<checkboxs.length;i++){
		if( checkboxs[i].checked ){
			specialpoorCause += checkboxs[i].value + "，";
			specialpoorCauseName += checkboxs[i].nextSibling.nodeValue + "，";
		}
	}
	if(specialpoorCause != ''){
		familyRecord.set("specialpoorCauseName",specialpoorCauseName.substr(0,specialpoorCauseName.length-1));
		familyRecord.set("specialpoorCause",specialpoorCause.substr(0,specialpoorCause.length-1));
	}else{
		familyRecord.set("specialpoorCauseName",specialpoorCauseName);
		familyRecord.set("specialpoorCause",specialpoorCause);
	}
	//邮编
	var familyPostcode=speFamilyDataset.get('familyPostcode');
	if(familyPostcode!= '' && _isPostCode(familyPostcode) != true){
		L5.Msg.alert("提示","校验未通过："+"邮编格式不正确");
		 buttonEnabled();
		return false;
	}
	if(speFamilyDataset.get('ifSupport') == '1' && speFamilyDataset.get('helpVillageCode') == ''){
		L5.Msg.alert("提示","您选择了家庭是省直单位联系困难家庭，请选择帮包村名称！");
		buttonEnabled();
		return false;
	}
	if(speFamilyDataset.get('assistanceFlag') == '1' && speFamilyDataset.get('assistanceType') == ''){
		L5.Msg.alert("提示","您选择了家庭是低保户，请选择救助类型！");
		buttonEnabled();
		return false;
	}
	var peopleIsValidate = peopleListDataSet.isValidate();
	if(peopleIsValidate != true){
		L5.Msg.alert("提示",peopleIsValidate);
		 buttonEnabled();
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.drel.special.cmd.SpecialpoorFamilyCmd");
	
	command.setParameter("familyRecord",familyRecord);
	command.setParameter("peoples",peopleListDataSet.getAllRecords());
	command.execute("saveFamily");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			familyId =  command.getReturn("familyId");
			updateLoad();
			peopleListDataSet.on('load',findFirstLoad);
			buttonEnabled();
			buttonPeopleEnabled();
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		 buttonEnabled();
	}
}
function findFirstLoad(ds){
	ds.un('load',findFirstLoad);
	
	if( ds.getCount() < 1 ){
		var familyRecord=speFamilyDataset.getCurrent();
		peopleListDataSet.newRecord({"name":familyRecord.get("familyName"),
				"idCard":familyRecord.get("familyCardNo"),
					"address":familyRecord.get("address"),"relationshipType":"01",
						"nation":"01","politicalCode":'13',"assistanceType":familyRecord.get("assistanceType")});
		L5.getCmp("peopleWin").show();
		if(peopleListDataSet.get("idCard") != ''){
			peopleListDataSet.set("sex",getSexByCode(peopleListDataSet.get("idCard")));
			//回填出生年月	
			peopleListDataSet.set("birthday",getBirthByCode(peopleListDataSet.get("idCard")));
			getAge(getBirthByCode(peopleListDataSet.get("idCard")));
		}
	}
}
//关闭
function returnBack(){
	var url="jsp/cams/drel/specialpoorFamily/specialpoorFamilyList.jsp";
	L5.forward(url);
}
//获得当前日期 2011-05
function getCurYM(){
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10){month="0"+month;}
	return year+"-"+month;
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
		speFamilyDataset.set('domicileName',list[1]);
		speFamilyDataset.set('domicileCode',list[0]);
		speFamilyDataset.set('address',list[4]);
		
		if(speFamilyDataset.get("ifSupport") == '1'){
			helpVillage.setParameter("filterSql", " HELP_VILLAGE_CODE like '" +list[0]+"%'");
	  	    helpVillage.load();
	  	    speFamilyDataset.set('helpVillageCode','');
			speFamilyDataset.set('supportName','');
		} 
	}
}
//选择省直单位联系困难家庭时触发的方法
function queryVillage(value){
	if(value == '1'){
		if(speFamilyDataset.get('domicileCode') != '' ){
			helpVillage.setParameter("filterSql", " HELP_VILLAGE_CODE like '" +speFamilyDataset.get('domicileCode')+"%'");
	  	    helpVillage.load();
		}else{
			L5.Msg.alert("提示","请先选择 <地区> !");
			return;
		}
	}else {
		document.getElementById("helpVillageCodeID").disabled= 'disabled';
		speFamilyDataset.set('helpVillageCode','');
		speFamilyDataset.set('supportName','');
		return ;
	}
}
//选择帮包村名称时的方法
function querySupport(value){
	if(value != '' ){
		var command = new L5.Command("com.inspur.cams.drel.special.cmd.SpecialpoorFamilyCmd");
		command.setParameter("helpVillageCode",value);
		command.execute("getSupportName");
		var supportName = command.getReturn("supportName");
		speFamilyDataset.set('supportName',supportName);
	}else{
		speFamilyDataset.set('supportName','');
	}
}
//#############################################人员方法
function insertPeople(){
	 isUpdate = false;
	peopleListDataSet.newRecord({"domicileCode":organArea,"domicileName":organName,"nation":"01",
		"politicalCode":'13',"assistanceType":speFamilyDataset.get("assistanceType")});
	
	L5.getCmp("peopleWin").show();
}

var isUpdate = false;

function updatePeople(){
	var grid = L5.getCmp('peoplePanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		 isUpdate = true;
		 L5.getCmp("peopleWin").show();
		 if(records[0].get("birthday") != ''){
			 getAge(records[0].get("birthday"));
		 }
		 if(records[0].get("relationshipType") == '01'){
			records[0].set("name",speFamilyDataset.get("familyName"));
			records[0].set("idCard",speFamilyDataset.get("familyCardNo"));
			records[0].set("address",speFamilyDataset.get("address"));
			if(records[0].get("idCard") != ''){
				records[0].set("sex",getSexByCode(records[0].get("idCard")));
				//回填出生年月	
				records[0].set("birthday",getBirthByCode(records[0].get("idCard")));
				getAge(getBirthByCode(records[0].get("idCard")));
			}
		 }
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}

function deletePeople(){
	var grid = L5.getCmp('peoplePanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		peopleListDataSet.remove(records[0]);
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
function savePeople(){
	
	var peopleIsValidate = peopleListDataSet.getCurrent().validateRecord();
	if(peopleIsValidate != true){
		L5.Msg.alert("提示",peopleIsValidate);
		return false;
	}
	L5.getCmp("peopleWin").hide();
}
function returnPeople(){
	if(!isUpdate){
		peopleListDataSet.remove(peopleListDataSet.getCurrent());
	}
	L5.getCmp("peopleWin").hide();
}
function checkIdCard_people(){
	var idCard_people=_$('idCard_people');
	if(_$('idCard_people')==''){
		L5.Msg.alert("提示","请输入身份证号");
		return;
	}
	//身份证号
	if(checkIDCard($("idCard_people")) != true && !(idCard_people.length==18 && idCard_people.lastIndexOf("N")>0 )){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		$('idCard_people').value='';
		return;
	}else{
		//回填性别
		peopleListDataSet.set("sex",getSexByCode(idCard_people));
		//回填出生年月	
		peopleListDataSet.set("birthday",getBirthByCode(idCard_people));
		getAge(getBirthByCode(idCard_people));
	}
	
}
//计算年龄
function getAge(birthday){
	$("age").innerHTML=getAgeByBirthday(birthday);
}
