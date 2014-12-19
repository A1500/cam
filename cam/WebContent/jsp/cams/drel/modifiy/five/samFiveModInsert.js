var familyId='';
var beginDate='';
var assistance_cardNo='';
var photoId='';
var familySex='';
var organCode='';
var fullName='';
var idCard="";
function init(){
	loadAsisstanceClass();//修改时加载页面	
	//窗口关闭的时候，执行一下存储过程。
	window.onbeforeunload=function(){  
		var parent=window.dialogArguments;
		parent.query();
	} 
}
function countTotle(){
}
//按钮禁用
function buttonDisable(){
	L5.getCmp("houseAdd").setDisabled(true);
	L5.getCmp("estateAdd").setDisabled(true);
}
//启用按钮
function buttonEnabled(){
	L5.getCmp("houseAdd").setDisabled(false);
	L5.getCmp("estateAdd").setDisabled(false);
}
//修改时加载页面
function loadInfo(ds){
	ds.un("load",loadInfo);
	applyDataSet.setParameter("APPLY_ID",applyId);
	applyDataSet.load();
	applyDataSet.on("load",loadFamilyDs);
}
//加载分类施保类别字典
function loadAsisstanceClass(){
	//加载供养机构字典
	var supportOrgDataset = L5.DatasetMgr.lookup("supportOrgDataset");
	  supportOrgDataset.setParameter("filterSql", "SERVE_TOWNS_ID LIKE '%" + organArea.substring(0,9) + "%' AND IF_CURRENT='1'");
	    supportOrgDataset.load();
	supportOrgDataset.on('load',loadInfo);
}
//加载家庭信息
function loadFamilyDs(ds){
	if(ds.getCount() == 1){
		beginDate=ds.get('beginDate');
		assistance_cardNo=ds.get('cardNo');
		familyId=ds.get('familyId');
		var supportWay=ds.get('supportWay');
		$('supportWay').value=ds.get('supportWay');//供养方式
		getSupportOrg();
		if(supportWay=='03'){//集中供养
			var supportOrg=ds.get('supportOrg'); 	
		//	$('supportOrg').disabled=false;
			$('supportOrg').value=supportOrg;//供养机构
		}
	}
	ds.un("load",loadFamilyDs);
    familyDataSet.setParameter("FAMILY_ID",familyId);
    familyDataSet.on("load",loadBank);
    familyDataSet.load();
}
function loadBank(ds){
	if(ds.getCount() == 1){
		ds.set('beginDate',beginDate);
		ds.set('cardNo',assistance_cardNo);
		photoId=ds.get("photoId");
		idCard=ds.get('familyCardNo');
		showPhotoAbleEdit(photoId);//加载照片
		if( organArea.substring(organArea.length-3,organArea.length) != '000'){
			ds.set("domicileCode",organArea);
			ds.set("domicileName",organName);
		}
	}
	ds.un("load",loadBank);
	bankAccountDS.setParameter("FAMILY_ID",familyId);
    bankAccountDS.on("load",loadPeopleListDs);
    bankAccountDS.load();
}
//加载家庭成员基本信息
function loadPeopleListDs(ds){
	if(ds.getCount() == 0 ){
		bankAccountDS.newRecord({"releaseWay":"01","accountStatus":"1","assistanceType":"03"});
	}
	ds.un("load",loadPeopleListDs);
  	peopleListDataSet.setParameter("FAMILY_ID",familyId);
	peopleListDataSet.load();
    peopleListDataSet.on("load",loadSupportedPeopleDs);
}
//加载被赡（抚、扶）养人
function loadSupportedPeopleDs(ds){
    ds.un("load",loadSupportedPeopleDs);
    ds.each(function(record, index){
		if(record.get('RELATIONSHIP_TYPE') =='01'){//本人		
			familySex=record.get('SEX');			
			return;
		}
	});
	var supportedPeopleDataSet = L5.DatasetMgr.lookup("supportedPeopleDataSet");
    supportedPeopleDataSet.setParameter("filterSql", "FAMILY_ID='" + familyId + "'");
    supportedPeopleDataSet.load();
    supportedPeopleDataSet.on("load",loadHouseDs);
}
//加载房产信息
function loadHouseDs(ds){
    ds.un("load",loadHouseDs);
  	houseListDataset.setParameter("FAMILY_ID",familyId);
	houseListDataset.load();
    houseListDataset.on("load",loadEstateDs);
}
//加载财产信息
function loadEstateDs(ds){
     ds.un("load",loadEstateDs);
  	estateListDataset.setParameter("FAMILY_ID",familyId);
	estateListDataset.load();
    estateListDataset.on("load",loadSupportDs);
}
//加载赡养人员信息
function loadSupportDs(ds){
    ds.un("load",loadSupportDs);
 	supportListDataset.setParameter("FAMILY_ID",familyId);
	supportListDataset.load();
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
	}else if(idCard != cardNo ){
		cardNo=obj.value;
		//相应操作
		var command = new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityApplyCmd");
		command.setParameter("cardNo",cardNo);
		command.execute("checkIDCard");
		var errorFlag=command.getReturn("errorFlag");
		var returnFamilyId=command.getReturn("familyId");
		if(errorFlag != '' && typeof(errorFlag)!="undefined" && errorFlag!=null){//有此人享有其他待遇的提示
			L5.Msg.alert("提示",errorFlag);
			obj.value='';
			return;
		}else{
			if(returnFamilyId != '' && typeof(returnFamilyId)!="undefined" && returnFamilyId!=null){
				familyId=returnFamilyId
				familyDataSet.setParameter("FAMILY_ID",familyId);
			    familyDataSet.on("load",loadBank);
			    familyDataSet.load();
			    applyId="null";
			}
		}
	}
}
//保存
function save(){
	buttonDisable();
	if(!saveCheck()){
	   buttonEnabled();
	   return ;
	}
	var applyRecord=applyDataSet.getCurrent();
	var familyRecord=familyDataSet.getCurrent();
	
	//处理多选
	var inputs=_$("assistanceType").split(','); 
	AssistanceDataset.removeAll();
	if(inputs[0]){
		for(var i=0;i<inputs.length;i++){
		  	AssistanceDataset.newRecord({"assistanceType":inputs[i]});
		}  
	}
	var command = new L5.Command("com.inspur.cams.drel.mod.cmd.SamModCmd");
	//供养方式、供养机构
	var supportWay=_$('supportWay');
	if(supportWay=='03'){//集中供养
		var supportOrg=_$('supportOrg');
		applyRecord.set("supportOrg",supportOrg);//供养机构
	}
	applyRecord.set("supportWay",supportWay);//供养方式
	
	applyRecord.set("applyId",applyId);
	applyRecord.set("familyId",familyId);
	familyRecord.set("familyId",familyId);
	familyRecord.set("assistanceType",_$('assistanceType'));
	familyRecord.set("assistanceTypeName",_$('assistanceTypeName'));
	familyRecord.set("photoTemp",document.getElementById('familyPhotoId').value);//维护照片信息
	familyRecord.set("photoId",photoId);//维护照片信息
	command.setParameter("applyRecord",applyDataSet.getCurrent());
	command.setParameter("familyRecord",familyDataSet.getCurrent());
	command.setParameter("AssistanceRecords",AssistanceDataset.getAllRecords());
	command.setParameter("bankAccount",bankAccountDS.getCurrent());	
	command.execute("insertInfo");
	if (!command.error) {
		var hasSelef=false;
		peopleListDataSet.each(function(record, index){
			if(record.get('RELATIONSHIP_TYPE') =='01'){//本人		
				hasSelef=true;			
				return false;
			}
		});
		if(!hasSelef){
			familyId=command.getReturn("familyId");
			applyId=command.getReturn("applyId");
			applyDataSet.removeAll();
			applyDataSet.setParameter("APPLY_ID",applyId);
			applyDataSet.load();
			
			var width = 1000;
		    var height = 433;
			var url="../../application/five/apply/samBasePeopleInsert.jsp?familyId="+familyId+"&flag=1"+"&hrefFlg="+getCurrent()+"&applyId="+applyId;
			window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
			buttonEnabled();
		}else{		
			L5.Msg.alert("提示","保存成功！",function(){			
				photoId=command.getReturn("photoId");
				if(applyId==''){
					applyId=command.getReturn("applyId");
					applyDataSet.removeAll();
					applyDataSet.setParameter("APPLY_ID",applyId);
					applyDataSet.load();
				}
				buttonEnabled();
			});
		}
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		buttonEnabled();
	}
}
//保存校验
function saveCheck(){
	var familyIsValidate = familyDataSet.isValidate();
	if(familyIsValidate != true){
		L5.Msg.alert("提示",familyIsValidate);
		return false;
	}
	if(document.getElementById("supportWay").value == '04' ){
		var bankAccountDSIsValidate = bankAccountDS.isValidate();
		if(bankAccountDSIsValidate != true){
			L5.Msg.alert("提示",bankAccountDSIsValidate);
			return false;
		}
	}

	var familyRecord=familyDataSet.getCurrent();
	
	if(familyRecord.get("domicileCode") == '' || familyRecord.get("domicileName") == ''){
		L5.Msg.alert("提示","校验未通过："+"地区不能为空!");
		return false;
	}
	//邮编
	var familyPostcode=familyRecord.get('familyPostcode');
	if(familyPostcode!= '' && _isPostCode(familyPostcode) != true){
		L5.Msg.alert("提示","校验未通过："+"家庭基本信息中居住地邮编格式不正确");
		return false;
	}
	
	//供养方式、供养机构
	var supportWay=_$('supportWay');
	if(supportWay==''){
		L5.Msg.alert("提示",'请选择供养方式！');
		return false;
	}
	if(supportWay=='03'){//集中供养
		var supportOrg=_$('supportOrg');
		if(supportOrg==''){
			L5.Msg.alert("提示",'请选择供养机构！');
			return false;
		}		
	}
	return true;
}
//关闭
function returnBack(){
	window.close();
}
//新增人员信息
function addPeople(){
	if(familyId==''){
		L5.Msg.alert("提示","请先保存家庭基本信息，然后录入家庭成员信息！");
		return;
	}

	var hasSelef=false;
	peopleListDataSet.each(function(record, index){
		if(record.get('RELATIONSHIP_TYPE') =='01'){//本人		
			hasSelef=true;			
			return false;
		}
	});
	if(!hasSelef){
		var width = 1000;
	    var height = 433;
		var url="../../application/five/apply/samBasePeopleInsert.jsp?familyId="+familyId+"&flag=1"+"&hrefFlg="+getCurrent()+"&applyId="+applyId;
		window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	}else{		
		var width = 1000;
	    var height = 433;
		var url="../../application/five/apply/samBasePeopleInsert.jsp?familyId="+familyId+"&hrefFlg="+getCurrent()+"&applyId="+applyId;
		window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	}
}
//修改人员信息
function changePeople(){
	var grid = L5.getCmp('peoplePanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var width = 1000;
	    var height = 433;
		var url="../../application/five/apply/samBasePeopleInsert.jsp?familyId="+familyId+"&peopleId="+records[0].get('PEOPLE_ID')+"&hrefFlg="+getCurrent()+"&applyId="+applyId+"&isMod=1"+"&isChangeUpdate=1";
		window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//删除人员信息
function removePeople(){
	var grid = L5.getCmp('peoplePanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		if(records[0].get("RELATIONSHIP_TYPE")=='01'){			
			L5.Msg.alert('提示',"不能删除户主信息！");
			return;
		}
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				var delId=records[0].get("PEOPLE_ID");
				var command=new L5.Command("com.inspur.cams.drel.application.five.cmd.SamFiveApplyCmd");
				command.setParameter("delId", delId);
				command.setParameter("familyId", familyId);
				command.execute("deletePeopleInfo");
				var assistancePeopleNum=command.getReturn("assistancePeopleNum");
				var peopleNum=command.getReturn("peopleNum");
				if (!command.error) {
					L5.Msg.alert("提示","删除成功！",function(){
						peopleListDataSet.remove(records[0]);
						familyDataSet.set("assistancePeopleNum",assistancePeopleNum);
						familyDataSet.set("peopleNum",peopleNum);
					});		
				}else{
					L5.Msg.alert('提示',"删除时出现错误！"+command.error);
				}
			}
			else{
				return;
			}
		});	
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//新增房屋信息
function addHouse(){
	if(familyId==''){
		L5.Msg.alert("提示","请先保存家庭基本信息！");
		return;
	}
	var width = 800;
    var height = 123;
	var url="../../comm/houseEdit.jsp?familyId="+familyId+"&hrefFlg="+getCurrent();
	window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
//修改房屋信息
function changeHouse(){
	var grid = L5.getCmp('housePanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var width = 800;
	    var height = 123;
		var url="../../comm/houseEdit.jsp?familyId="+familyId+"&houseId="+records[0].get('houseId')+"&hrefFlg="+getCurrent();
		window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//删除房屋信息
function removeHouse(){
	var grid = L5.getCmp('housePanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamFamilyHouseCmd");
				var delId=records[0].get("houseId");
				command.setParameter("delId", delId);
				command.execute("delete");				
				houseListDataset.remove(records[0]);
			}
			else{
				return;
			}
		});	
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//新增财产信息
function addEstate(){
	if(familyId==''){
		L5.Msg.alert("提示","请先保存家庭基本信息！");
		return;
	}
	var width = 600;
    var height = 143;
	var url="../../comm/estateEdit.jsp?familyId="+familyId+"&hrefFlg="+getCurrent();
	window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
//修改财产信息
function changeEstate(){
	var grid = L5.getCmp('estatePanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var width = 600;
	    var height = 143;
		var url="../../comm/estateEdit.jsp?familyId="+familyId+"&estateId="+records[0].get('estateId')+"&hrefFlg="+getCurrent();
		window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//删除财产信息
function removeEstate(){
	var grid = L5.getCmp('estatePanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamFamilyEstateCmd");
				var delId=records[0].get("estateId");
				command.setParameter("delId", delId);
				command.execute("delete");				
				estateListDataset.remove(records[0]);
			}
			else{
				return;
			}
		});	
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//新增赡扶抚养义务人员
function addSupport(){
	if(familyId==''){
		L5.Msg.alert("提示","请先保存家庭基本信息！");
		return;
	}
	var width = 850;
   		 var height = 200;
	var url="../../comm/supportEdit.jsp?familyId="+familyId+"&assistanceType=03"+"&hrefFlg="+getCurrent();
	window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
//修改赡扶抚养义务人员
function changeSupport(){
	var grid = L5.getCmp('supportPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var width = 850;
   		 var height = 200;
		var url="../../comm/supportEdit.jsp?familyId="+familyId+"&supportId="+records[0].get('supportId')+"&assistanceType=03"+"&hrefFlg="+getCurrent()+"&isMod=1";
		window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
//删除赡扶抚养义务人员
function removeSupport(){
	var grid = L5.getCmp('supportPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamFamilySupportCmd");
				var delId=records[0].get("supportId");
				command.setParameter("delId", delId);
				command.execute("delete");				
				supportListDataset.remove(records[0]);
			}
			else{
				return;
			}
		});	
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
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
		familyDataSet.set('domicileName',list[1]);
		familyDataSet.set('domicileCode',list[0]);
	}
}
/**
 * 选择户籍地行政区划窗口
*/
function func_ForApanageSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ cityCode + "&organName="
					+ escape(encodeURIComponent(cityName))+"&level=4", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("apanageCode").value = list[0];
		familyDataSet.set('apanageName',list[1]);
		familyDataSet.set('apanageCode',list[0]);
	}
}
//修改时显示照片
function showPhotoAbleEdit(photoId){
	if(photoId){
		var src = rootPath+"download?table="+"COM_PHOTO"+"_"+photoId.substring(0,6)+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+photoId+"'";
		document.getElementById('img').src=src
	}else{
	}
}
//根据供养方式获取供养机构
function getSupportOrg(){
	var supportWay=$('supportWay');
	var supportOrg=$('supportOrg');
	if(supportWay.value!='' && supportWay.value=='03'){//03：集中供养
		supportOrg.disabled=false;
		document.getElementById("bankTr").style.display = 'none';
	}else{
		supportOrg.value='';
		supportOrg.disabled=true;
		document.getElementById("bankTr").style.display = 'block';
	}
}
//计算评议人数
function countDiscussionNum(){
	var total=document.getElementById('total').value ;
	var agreeNum= document.getElementById('agreeNum').value ;
	if(total == '' || agreeNum == '' ){
		return;
	}
	if(parseInt(total) - parseInt(agreeNum) < 0){
		L5.Msg.alert("提示","评议总人数不得小于同意人数！");
		acceptDiscussionDataset.set('total','');
		acceptDiscussionDataset.set('agreeNum','');
		acceptDiscussionDataset.set('disagreeNum','');
		return;
	}
	var disagreeNum = parseInt(total) - parseInt(agreeNum);
	acceptDiscussionDataset.set('disagreeNum',disagreeNum);
}
//变更户主
function changePeopleRelationshipType(){
	var win=L5.getCmp("changeApplyPeople");
	win.show();
}
//变更户主点保存按钮
function changeRelationshipType(){
	var flag = 0;
	peopleListDataSet.each(function(record,index){
		if(record.get('RELATIONSHIP_TYPE') == '01' ){
			flag++;
		}
	});
	if(flag > 1){
		L5.Msg.alert("提示","不可以存在多个户主！");
		peopleListDataSet.rejectChanges();
		return;
	}
	if(flag == 0){
		L5.Msg.alert("提示","至少存在一个户主！");
		peopleListDataSet.rejectChanges();
		return;
	}
	if(peopleListDataSet.getAllChangedRecords().length == 0){
		return;
	}
	var command = new L5.Command("com.inspur.cams.drel.application.five.cmd.SamFiveChangeCmd");
	command.setParameter("peoples",peopleListDataSet.getAllChangedRecords());
	command.execute("updatePeopleRelationshipType");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			peopleListDataSet.commitChanges();
			peopleListDataSet.each(function(record,index){
				if(record.get('RELATIONSHIP_TYPE') == '01' ){
					familyDataSet.set('familyName',record.get('NAME'));
					familyDataSet.set('familyCardNo',record.get('ID_CARD'));
				}
			});
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//关闭变更户主窗口
function closeWin(){
	var win=L5.getCmp("changeApplyPeople");
	win.hide();
}