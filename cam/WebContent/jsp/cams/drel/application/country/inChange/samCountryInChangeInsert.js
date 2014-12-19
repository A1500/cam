var familyId='';
var photoId='';
var assistanceMode='';
var assistanceMoney='';
var assistanceClassMoney='';
var assistanceClass='';
var assistanceType="02";
//初始化加载
function init(){
applyDataSet.setParameter("APPLY_ID",applyId);
	applyDataSet.load();
	applyDataSet.on('load',loadtreat);
}
function loadtreat(ds){
	ds.un("load",loadtreat);
	familyTreatmentDataSet.setParameter("TREATMENT_ID",treatmentId);
    familyTreatmentDataSet.on("load",loadFamilyDs);//加载家庭	
    familyTreatmentDataSet.load();
}
//加载家庭信息
function loadFamilyDs(ds){
	ds.un("load",loadFamilyDs);
	familyId=ds.get("familyId");
	assistanceMode=ds.get('assistanceMode');
	assistanceMoney=ds.get('assistanceMoney');
	assistanceClassMoney=ds.get('assistanceClassMoney');
	assistanceClass=ds.get('asisstanceClass');
	familyDataSet.setParameter("FAMILY_ID",familyId);
	familyDataSet.on("load",loadPanel1);
    familyDataSet.load();
}

//打开人员列表时加载人员信息
function loadPanel1(ds){
	ds.un("load",loadPanel1);
	if(ds.getCount() == 1){
		ds.set('applyDate',nowTime);
		ds.set('assistanceMode',assistanceMode);
		ds.set('assistanceMoney',assistanceMoney);
		ds.set('assistanceClassMoney',assistanceClassMoney);
		ds.set('assistanceClass',assistanceClass);
		photoId=familyDataSet.get("photoId");
		showPhotoAbleEdit(photoId);//加载照片
	}
	peopleListDataSet.setParameter("FAMILY_ID",familyId);
	peopleListDataSet.load();
}
//按钮禁用
function buttonDisable(){
	L5.getCmp("saveId").setDisabled(true);
}
//启用按钮
function buttonEnabled(){
	L5.getCmp("saveId").setDisabled(false);
}
//保存
function save(){
	familyDataSet.set('domicileCode',document.getElementById('lrdwId').value);
	buttonDisable();
	if(!saveCheck()){
	   buttonEnabled();
	   return ;
	}
	
	var familyRecord=familyDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.drel.application.country.cmd.SamCountryChangeCmd");
	var applyRecord=applyDataSet.getCurrent();
	applyRecord.set("beginDate",_$("beginDate"));
	applyRecord.set("applyId","");
	applyRecord.set("curActivityId","audit");
	applyRecord.set("auditOpinionId","1");
	applyRecord.set("changeItem","07");
	familyRecord.set("photoTemp",document.getElementById('familyPhotoId').value);//维护照片信息
	command.setParameter("familyRecord",familyRecord);
	command.setParameter("applyRecord",applyRecord);
	command.execute("saveInChange");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			 returnBack();
		});		
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
	var familyRecord = familyDataSet.getCurrent();
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
	//校验开始日期不小于当前月份
	var beginDate=_$('beginDate');    
	if( beginDate!='' ){
		//if(beginDate < nowMonth){
			//L5.Msg.alert("提示","校验未通过：救助开始月份不能早于当前月份！");
			//return false;
		//}
		if(beginDate < beginDateOriginal){
			L5.Msg.alert("提示","校验未通过：变更后救助开始月份不能早于"+beginDateOriginal);
			return false;
		}  
	}
	return true;
}
//关闭
function returnBack(){
	var parent=window.dialogArguments;
	parent.query();
	//var baseinfoFamilyDS=parent.baseinfoFamilyDS;
	//baseinfoFamilyDS.setParameter("domicileCode",organArea);
	//baseinfoFamilyDS.setParameter("assistanceType",assistanceType);	
	//baseinfoFamilyDS.setParameter("queryDate","3000-12");	
	//baseinfoFamilyDS.load();
	window.close();
}
//获得当前日期 2011-05
function getCurYM(){
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10){month="0"+month;}
	return year+"-"+month;
}
//加载照片
function showPhotoAbleEdit(photoId){
	if(photoId){
		var src = rootPath+"download?table="+"COM_PHOTO"+"_"+photoId.substring(0,6)+"&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='"+photoId+"'";
		document.getElementById('img').src=src
	}else{
	}
}
//查看家庭明细
function detailexpand(){
	var width = screen.width-100;
    var height = screen.height-340;
	var url='../apply/samCountryExpandDetail.jsp?familyId='+familyId+'&applyId='+applyId+"&hrefFlg="+getCurrent()+"&ifFile=0";
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
//查看特定人员的明细
function peopleDetail(peopleId){
	var width = 1000;
    var height = 600;
	var url="../apply/samBasePeopleDetail.jsp?peopleId="+peopleId+"&hrefFlg="+getCurrent();
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
//明细
function getName(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:peopleDetail(\''+record.get("PEOPLE_ID")+'\')">'+value+'</a>';
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
		familyDataSet.set('address',list[1]);
		applyDataSet.set('domicileName',list[1]);
		applyDataSet.set('domicileCode',list[0]);
	}
}