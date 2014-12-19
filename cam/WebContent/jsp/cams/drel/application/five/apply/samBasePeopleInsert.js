var assistancePeopleNum='';
var peopleNum='';
var idCard="";
//初始化
function init(){
	if(isMod == '1'){
		document.getElementById('isAssistance').disabled='disabled';
		document.getElementById('relationshipType').disabled='disabled';
		document.getElementById('peopleName').disabled='disabled';
		document.getElementById('idCard_people').disabled='disabled';
	}
	//新增家庭成员
	if(peopleId==''||peopleId=='null'){
		if(flag == '1'){
			var parent=window.dialogArguments;
			var ds=parent.familyDataSet;
			baseinfoPeopleDataSet.newRecord({'familyId':familyId,"name":ds.get('familyName'),"idCard":ds.get('familyCardNo'),'nation':'01',"relationshipType":'01','domicileType':'1',"apanageName":ds.get('domicileName'),
			"apanageCode":ds.get('domicileCode'),"politicalCode":"13",
				"marriageCode":'90',"healthCode":'10',"eduCode":'99'});
			$('selfCareAbility').value='01';
			$('eduStatus').value='99'; 
			//document.getElementById('relationshipType').disabled='disabled';
			document.getElementById('isAssistance').value = '1';
		//	document.getElementById('isAssistance').disabled='disabled';
			checkIdCard_people();
		}else{
			var parent=window.dialogArguments;
			var ds=parent.familyDataSet;
			baseinfoPeopleDataSet.newRecord({'familyId':familyId,'domicileType':'1','nation':'01',"apanageName":ds.get('domicileName'),"apanageCode":ds.get('domicileCode'),"politicalCode":"13",
				"marriageCode":'90',"healthCode":'10',"eduCode":'99'});
			$('selfCareAbility').value='01';
			$('eduStatus').value='99';
		}
		samPeopleExtendDataSet.newRecord();
		samPeopleDiseaseDataSet.newRecord();
		samPeopleDisabilityDataSet.newRecord();
		samPeopleEduDataSet.newRecord();
		$('diseaseType').disabled=true;
		$('disabilityLevel').disabled=true;
		initPhoto("1");//初始化照片
	}else{
		//修改家庭成员
		//加载成员信息
		loadPeopleInfo();
	}
}
//加载成员信息
function loadPeopleInfo(){
	baseinfoPeopleDataSet.setParameter("PEOPLE_ID",peopleId);
	baseinfoPeopleDataSet.load();
	baseinfoPeopleDataSet.on('load',loadSamPeopleExtendDataSet);
}
//加载成员扩展信息
function loadSamPeopleExtendDataSet(ds){
	ds.un("load",loadSamPeopleExtendDataSet);
	var record=ds.getCurrent();	
	idCard=record.get('idCard');	
	//回填年龄
	$("age").innerHTML=getAgeByCode(record.get("idCard"));
	if(record.get('relationshipType')=='01'){
		//$('relationshipType').disabled='disabled';
		//document.getElementById('isAssistance').disabled='disabled';
	}
	//同步照片
	synPhoto(record.get("photoId"),"1");
	
	if(ds.get('personalStatsTag')!='01'){//人员状态
		if(flag == '1'){
			ds.set("relationshipType",'01');//本人	
		}else{
			ds.set("relationshipType",'');	
		}	
	}
	
	samPeopleExtendDataSet.setParameter("PEOPLE_ID",peopleId);
	samPeopleExtendDataSet.load();
	samPeopleExtendDataSet.on('load',loadSamPeopleDiseaseDataSet);
}
//加载疾病信息
function loadSamPeopleDiseaseDataSet(ds){
	ds.un("load",loadSamPeopleDiseaseDataSet);
	if(ds.getCount()>0){
		$('selfCareAbility').value=ds.get('selfCareAbility');
		$('isAssistance').value=ds.get('isAssistance');
		$('peopleTypeName').value=ds.get('peopleTypeName');
		$('peopleType').value=ds.get('peopleType');
	}
	
	samPeopleDiseaseDataSet.setParameter("PEOPLE_ID",peopleId);
	samPeopleDiseaseDataSet.load();
	samPeopleDiseaseDataSet.on('load',loadSamPeopleDisabilityDataSet);
}
//加载残疾信息
function loadSamPeopleDisabilityDataSet(ds){
	ds.un("load",loadSamPeopleDisabilityDataSet);
	if(ds.getCount()>0){
		$('diseaseType').value=ds.get('diseaseType');
	}else{
		//非必填
		ds.newRecord();
		$('diseaseType').disabled=true;
	}
	
	samPeopleDisabilityDataSet.setParameter("PEOPLE_ID",peopleId);
	samPeopleDisabilityDataSet.load();
	samPeopleDisabilityDataSet.on('load',loadSamPeopleEduDataSet);
}
//加载教育信息
function loadSamPeopleEduDataSet(ds){
	ds.un("load",loadSamPeopleEduDataSet);
	if(ds.getCount()>0){
		$('disabilityType').value=ds.get('disabilityType');
		$('disabilityLevel').value=ds.get('disabilityLevel');
	}else{
		//非必填
		ds.newRecord();
		$('disabilityLevel').disabled=true;
	}
	
	samPeopleEduDataSet.setParameter("PEOPLE_ID",peopleId);
	samPeopleEduDataSet.load();
	samPeopleEduDataSet.on('load',loadDataSet);
}
//加载
function loadDataSet(ds){
	ds.un("load",loadDataSet);
	if(ds.getCount()>0){
		$('eduStatus').value=ds.get('eduStatus');
	}else{
		ds.newRecord();
	}	
}
//关闭窗口
function closePeople(){
	window.close();
}
//按钮禁用
function buttonDisable(){
	L5.getCmp("confirmPeopleId").setDisabled(true);
	L5.getCmp("closePeopleId").setDisabled(true);
}
//启用按钮
function buttonEnabled(){
	L5.getCmp("confirmPeopleId").setDisabled(false);
	L5.getCmp("closePeopleId").setDisabled(false);
}

//确认添加人员
function confirmPeople(){
	baseinfoPeopleDataSet.set('apanageCode',document.getElementById('lrdwId').value);
	 buttonDisable();
	if(!confirmPeopleCheck()){
	   buttonEnabled();
	   return ;
	}
	//身份证号
	if(checkIDCard($("idCard_people")) != true && !(_$("idCard_people").length==18 && _$("idCard_people").lastIndexOf("N")>0 )){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		$('idCard_people').value='';
		 buttonEnabled();
		return;
	}
	//维护照片信息
    baseinfoPeopleDataSet.set("photoTemp",_$("photoId1"));
	samPeopleExtendDataSet.set('selfCareAbility',_$('selfCareAbility'));
	if(_$('healthCode')=='40'){
		samPeopleDiseaseDataSet.set('diseaseType',_$('diseaseType'));
	}
	if(_$('disabilityType')!=''){
		samPeopleDisabilityDataSet.set('disabilityType',_$('disabilityType'));
		samPeopleDisabilityDataSet.set('disabilityLevel',_$('disabilityLevel'));
	}
	samPeopleExtendDataSet.set('isAssistance',_$('isAssistance'));	
	samPeopleEduDataSet.set('eduStatus',_$('eduStatus'));
	//处理多选
	var inputs=_$("peopleType").split(','); 
	peopleTypeDataset.removeAll();
	if(inputs[0]){
		for(var i=0;i<inputs.length;i++){
			peopleTypeDataset.newRecord({"peopleType":inputs[i]});
		}  
	}
	
	var baseinfoPeopleRecord=baseinfoPeopleDataSet.getCurrent();
	var peopleTypeRecords=peopleTypeDataset.getAllRecords();
	var peopleExtendRecord=samPeopleExtendDataSet.getCurrent();
	var peopleDiseaseRecord=samPeopleDiseaseDataSet.getCurrent();
	var peopleDisabilityRecord=samPeopleDisabilityDataSet.getCurrent();
	var peopleEduRecord=samPeopleEduDataSet.getCurrent();
	if(baseinfoPeopleRecord.get('personalStatsTag')!='01'){//人员状态
		baseinfoPeopleDataSet.set("familyId",familyId);	
		baseinfoPeopleDataSet.set("personalStatsTag",'01');	
		if(flag == '1'){
			flag='';
		}	
	}
	baseinfoPeopleRecord.set("familyId",familyId);	
	peopleExtendRecord.set('peopleType',_$('peopleType'));
	peopleExtendRecord.set('peopleTypeName',_$('peopleTypeName'));
	var command = new L5.Command("com.inspur.cams.drel.application.five.cmd.SamFiveApplyCmd");
	command.setParameter("baseinfoPeopleRecord",baseinfoPeopleRecord);
	command.setParameter("peopleTypeRecords",peopleTypeRecords);
	command.setParameter("peopleExtendRecord",peopleExtendRecord);
	if(_$('diseaseType')!=''){
		command.setParameter("peopleDiseaseRecord",peopleDiseaseRecord);
	}
	if(_$('disabilityType')!=''){
		command.setParameter("peopleDisabilityRecord",peopleDisabilityRecord);
	}
	command.setParameter("peopleEduRecord",peopleEduRecord);
	command.setParameter("applyId",applyId);
	command.setParameter("isChangeUpdate",isChangeUpdate);
	command.execute("insertPeopleInfo");
	
	
	var errorLog = command.getReturn("error");
	if( errorLog != 'true' && isChangeUpdate != '1'  ){
		L5.Msg.alert('提示',errorLog);
		buttonEnabled();
		return;
	}
	
	assistancePeopleNum=command.getReturn("assistancePeopleNum");
	peopleNum=command.getReturn("peopleNum");
	if (!command.error) {
		 buttonEnabled();
		//获取户主性别
		if(_$('relationshipType')=='01'){//本人
			window.dialogArguments.familySex=_$('sex');
			//家庭基本信息
			var parent=window.dialogArguments;
			var familyDataSet=parent.familyDataSet;
			familyDataSet.set('familyName',baseinfoPeopleRecord.get('name'));
			familyDataSet.set('familyCardNo',baseinfoPeopleRecord.get('idCard'));
		}
		
		//保存成功的提示信息
		saveSuccessAlert();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		buttonEnabled();
	}
}
//确认添加人员校验
function confirmPeopleCheck(){
	var baseinfoPeopleDataSetValidate = baseinfoPeopleDataSet.isValidate();
	if(baseinfoPeopleDataSetValidate != true){
		L5.Msg.alert("提示",baseinfoPeopleDataSetValidate);
		return false;
	}	
	var samPeopleEduDataSetValidate = samPeopleEduDataSet.isValidate();
	if(samPeopleEduDataSetValidate != true){
		L5.Msg.alert("提示",samPeopleEduDataSetValidate);
		return false;
	}	
	
	if(_$('selfCareAbility')==''){
		L5.Msg.alert("提示","请选择生活自理能力！");
		return false;
	}
	if(_$('healthCode')=='90'){
		if(_$('diseaseType')==''){
			L5.Msg.alert("提示","请选择重病病种！");
			return false;
		}
	}
	if(_$('disabilityType')!=''){
		if(_$('disabilityLevel')==''){
			L5.Msg.alert("提示","请选择残疾等级！");
			return false;
		}
	}
	if(_$('isAssistance')==''){
		L5.Msg.alert("提示","请选择是否供养对象！");
		return false;
	}	
	var eduStatus=_$('eduStatus');
	if(eduStatus==''){
		L5.Msg.alert("提示","请选择学业状况！");
		return false;
	}
	if(eduStatus=='02'){//在读
		var school=samPeopleEduDataSet.get('school');
		if(school==''){
			L5.Msg.alert("提示","校验未通过："+"人员学业状况为在读，请输入教育信息！");
			return false;
		}
	}
	
	//电话
	var contactPhone_edu=_$('contactPhone_edu');
	if(contactPhone_edu!= '' && isTel(contactPhone_edu) != true){
		L5.Msg.alert("提示","校验未通过："+"人员教育信息中联系电话格式不正确");
		return false;
	}
	
	//校验性别是否符合逻辑
	var relationshipType=_$('relationshipType');
	var sex=_$('sex');
	if(relationshipType=='10'){//配偶	
		if(sex==window.dialogArguments.familySex){
			L5.Msg.alert("提示","校验未通过："+'配偶性别输入错误！');
			return false;
		}
	}else if(relationshipType=='20'){//子/婿
		if(sex=='2'){
			L5.Msg.alert("提示","校验未通过："+'与户主关系"子/婿"同性别"女"不符！');
			return false;
		}
	}else if(relationshipType=='30'){//女/媳
		if(sex=='1'){
			L5.Msg.alert("提示","校验未通过："+'与户主关系"女/媳"同性别"男"不符！');
			return false;
		}			
	}
	return true;
}
//保存成功的提示信息
function saveSuccessAlert(){
	if(peopleId==''||peopleId=='null'){
		L5.MessageBox.confirm('提示','保存成功！是否继续添加家庭成员？',function(state){
			if(state=="yes"){		
				//继续添加成员
				goOnInsert();
				//刷新父窗口
				confirmClosePeople();
			}else{
				//刷新父窗口
				confirmClosePeople();
				//关闭窗口
				window.close();
			}
		});
	}else{
		L5.Msg.alert("提示","保存成功！",function(){
			confirmClosePeople();
			window.close();
		});	
	}	
}
//继续添加成员
function goOnInsert(){
	//$('relationshipType').disabled='';	
	//$('isAssistance').disabled='';
	$("age").innerHTML='';	
	$('selfCareAbility').value='';
	$('isAssistance').value='';
	
	$('diseaseType').value='';

	$('disabilityType').value='';
	$('disabilityLevel').value='';

	$('eduStatus').value='';

	baseinfoPeopleDataSet.removeAll();
	peopleTypeDataset.removeAll();
	samPeopleExtendDataSet.removeAll();
	samPeopleDiseaseDataSet.removeAll();
	samPeopleDisabilityDataSet.removeAll();
	samPeopleEduDataSet.removeAll();
	var parent=window.dialogArguments;
	var ds=parent.familyDataSet;
	baseinfoPeopleDataSet.newRecord({'familyId':familyId,'nation':'01',"relationshipType":'01','domicileType':'1',"apanageName":ds.get('domicileName'),
			"apanageCode":ds.get('domicileCode'),"politicalCode":"13",
				"marriageCode":'90',"healthCode":'10',"eduCode":'99'});
			$('selfCareAbility').value='01';
			$('eduStatus').value='99'; 
	samPeopleExtendDataSet.newRecord();
	samPeopleDiseaseDataSet.newRecord();
	samPeopleDisabilityDataSet.newRecord();
	
	$("peopleType").value=''; 
	$("peopleTypeName").value=''; 
	
	samPeopleEduDataSet.newRecord();
	$('diseaseType').disabled=true;
	$('disabilityLevel').disabled=true;
	initPhoto("1");//初始化照片
}
//刷新父窗口
function confirmClosePeople(){
	var parent=window.dialogArguments;
	//家庭成员列表
	var peopleListDataSet=parent.peopleListDataSet;
	peopleListDataSet.setParameter("FAMILY_ID",familyId);
	peopleListDataSet.load();
	//加载被赡（抚、扶）养人
	var supportedPeopleDataSet=parent.supportedPeopleDataSet;
    supportedPeopleDataSet.setParameter("filterSql", "FAMILY_ID='" + familyId + "'");
    supportedPeopleDataSet.load();
	//家庭基本信息
	var familyDataSet=parent.familyDataSet;
	familyDataSet.set("assistancePeopleNum",assistancePeopleNum);
	familyDataSet.set("peopleNum",peopleNum);
}
function checkIdCard_people(){
	var idCard_people=_$('idCard_people');
	if(_$('idCard_people')==''){
		L5.Msg.alert("提示","请输入身份证号");
		return;
	}
	//身份证号
	if(checkIDCard($("idCard_people")) != true && !(_$("idCard_people").length==18 && _$("idCard_people").lastIndexOf("N")>0 )){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		$('idCard_people').value='';
		return;
	}else  if(idCard != idCard_people){
		var idCard_people=_$("idCard_people");
		//查询身份证是否存在
		var command = new L5.Command("com.inspur.cams.drel.application.city.cmd.SamCityApplyCmd");
		command.setParameter("cardNo",idCard_people);
		command.execute("checkIDCard");
		var errorFlag=command.getReturn("errorFlag");
		peopleId=command.getReturn("peopleId");
		var personalStatsTag=command.getReturn("personalStatsTag");//人员状态
		var returnFamilyId=command.getReturn("familyId");
		if(errorFlag =='' ){
			if(peopleId != '' && typeof(peopleId)!="undefined" && peopleId!=null){
				loadPeopleInfo();
			}else{
				//回填相应信息
				if( idCard_people.substr(0,1) != 'B' ){
					fillBirthdayInfo(idCard_people);
				}
			}
		}else{//有此人享有其他待遇的提示
			if(personalStatsTag=='01'){
				L5.Msg.alert("提示",errorFlag);
				$("idCard_people").value='';
				return;
			}else if(personalStatsTag=='03'){//死亡
				L5.Msg.alert("提示","该人员已死亡！");
				$("idCard_people").value='';
				return;
			}else if(personalStatsTag=='06'){//分户迁出
				//修改家庭成员
				//加载成员信息
				loadPeopleInfo();
			}else{//其它的人员状态
				if(flag=='1'){//户主
					//修改家庭成员
					//加载成员信息
					loadPeopleInfo();	
				}else{//非户主
				  	L5.MessageBox.confirm('提示', errorFlag.substring(0,2)+'所在家庭'+errorFlag.substring(2)+'，是否把该人员从原来家庭中分离出来？',function(sta){
						if(sta=="yes"){
						  	L5.MessageBox.confirm('提示','该人员状态为'+getDicText(samPersonalStatsDataSet,personalStatsTag)+'，确定要提取该人员信息吗？',function(sta_tq){
								if(sta_tq=="yes"){
									//修改家庭成员
									//加载成员信息
									loadPeopleInfo();	
								}else{
									$("idCard_people").value='';
									return;
								}
							});	
						}else{
							$("idCard_people").value='';
							return;
						}
					});
				}
			}
		}
	}else{
		//回填相应信息
		if( idCard_people.substr(0,1) != 'B' ){
			fillBirthdayInfo(idCard_people);
		}
	}
}
//是否已经录入本人
function hasSelf(){
	var relationshipType=_$('relationshipType');
	if(relationshipType=='01'){	
		var hasSelef=false;	
		var parent=window.dialogArguments;
		var peopleListDataSet=parent.peopleListDataSet;
		peopleListDataSet.each(function(record, index){
			if(record.get('RELATIONSHIP_TYPE') =='01'){//本人		
				hasSelef=true;			
				return false;
			}
		});
		
		if(hasSelef){			
			L5.Msg.alert("提示","已经录入户主信息，不能重复录入！");
			$('relationshipType').value='';
		}
	}
}
//获取重病病种
function getDiseaseType(){
	var healthCode=_$('healthCode');
	var diseaseType=$('diseaseType');
	if(healthCode=='40'){//重病
		diseaseType.disabled=false;
	}else{
		diseaseType.value='';
		diseaseType.disabled=true;
	}
}
//获取残疾等级
function getDisabilityLevel(){
	var disabilityType=_$('disabilityType');
	var disabilityLevel=$('disabilityLevel');
	if(disabilityType!=''){
		disabilityLevel.disabled=false;
	}else{
		disabilityLevel.value='';
		disabilityLevel.disabled=true;
	}
}
//字典表解析
function getDicText(dicDataSet,value){
	for (var i=0;i<dicDataSet.getTotalCount();i++){
		var record = dicDataSet.getAt(i);
		if(dicDataSet.getAt(i).get('value')==value){
			return record.get('text');
		}
	}
	return "";
}	
/**
 * 选择户籍地行政区划窗口
*/
function func_ForApanageSelect() {
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
					+ window.dialogArguments.cityCode + "&organName="
					+ escape(encodeURIComponent(window.dialogArguments.cityName))+"&level=4", "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("apanageCode").value = list[0];
		baseinfoPeopleDataSet.set('apanageName',list[1]);
		baseinfoPeopleDataSet.set('apanageCode',list[0]);
	}
}
//计算年龄
function getAge(birthday){
	$("age").innerHTML=getAgeByBirthday(birthday);
}
//回填性别 出生年月信息
function fillBirthdayInfo(idCard_people){
	//回填性别
	baseinfoPeopleDataSet.set("sex",getSexByCode(idCard_people));
	//回填出生年月	
	baseinfoPeopleDataSet.set("birthday",getBirthByCode(idCard_people));
	getAge(getBirthByCode(idCard_people));
}