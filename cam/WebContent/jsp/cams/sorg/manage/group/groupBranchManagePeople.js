var fileCode = "S087";
var dutyId='';
var people_type='';
var currentRecord="";
function init(){
	document.getElementById("cnName").innerHTML=cnName;
	document.getElementById("sorgCode").innerHTML=sorgCode;	
	guidePeopleInit();
	somOrganDataSet.setParameter("SORG_ID",mainSorgId);
	somOrganDataSet.load();
	somOrganDataSet.on('load', function(){
		var record=somOrganDataSet.getCurrent();
		document.getElementById("McnName").innerHTML=record.get('cnName');
		document.getElementById("MsorgCode").innerHTML=record.get('sorgCode');	
	});
	
	
	aspForJianShi.setParameter("SORG_ID",sorgId);
	aspForJianShi.load();	
	aspForJianShi.on('load',function(){
		currentRecord=somDutyDataSet.newRecord();
		aspForJianShi.each(function(record, id){
			if(record.get('regStatus') == '3'){
				currentRecord = record;
				somResumeInsertDataSet.setParameter("DUTY_ID",currentRecord.get('dutyId'));
				somResumeInsertDataSet.load();
			}
		});
	});
	//上传列表关闭事件
	var win=L5.getCmp("uploadPeopleList");
	if(win!=null){
		win.on("hide",function(el){
			var selected=L5.getCmp('uploadPeopleGrid').getSelectionModel().getSelections();
			var record=selected[0];
			somPeopleElectronicDataSet_branch_load(record.get("dutyId"));
		});	
	}
}
function idCardFocus(){
	$("idCard").focus();
}
// 保存
function save(){
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomDutyCmd");
	if(currentRecord.get('dutyId')!=''){
		command.setParameter("somDutyRecord",currentRecord);
	}
	//个人简历
	var somResumeRecords = somResumeInsertDataSet.getAllRecords();
	command.setParameter("somResumeRecords",somResumeRecords);
	command.setParameter("sorgId",sorgId);
	command.execute("saveBranchPeople");
	
	if(!command.error){
		L5.Msg.alert('提示','保存成功！',function(){
			returnBack();
		});	
	}else{
		L5.Msg.alert('提示',"保存时出现错误！");
	}
}
// 返回备案列表页面
function returnBack(){
	var data=new L5.Map();
	var url="";
	if(method=="insert" || method=="update" || method=="detail"|| method=="his"){
		data.put("sorgId",sorgId);
		data.put("cnName",encodeURIComponent(encodeURIComponent(cnName)));
		data.put("sorgCode",sorgCode);	
		data.put("searchCnName",encodeURIComponent(encodeURIComponent(searchCnName)));
		data.put("searchSorgCode",searchSorgCode);	
		url="jsp/cams/sorg/manage/group/groupManagePeopleList.jsp";
	}else if(method=="hisDetail"){
		data.put("sorgId",sorgId);
		data.put("cnName",encodeURIComponent(encodeURIComponent(cnName)));
		data.put("sorgCode",sorgCode);	
		data.put("searchCnName",encodeURIComponent(encodeURIComponent(searchCnName)));
		data.put("searchSorgCode",searchSorgCode);	
		url="jsp/cams/sorg/manage/group/groupManagePeopleHis.jsp";	
	}
	L5.forward(url,'',data);	
}
//---------------------------------------------------------------
//同步法律要件
function somPeopleElectronicDataSet_branch_load(dutyId){
	somPeopleElectronicDataSet.setParameter("fileCodes",fileCode);
	somPeopleElectronicDataSet.setParameter("dutyId",dutyId);
	somPeopleElectronicDataSet.setParameter("sorgId",sorgId);
	somPeopleElectronicDataSet.setParameter("applyType",applyType);
	somPeopleElectronicDataSet.load();
}
//新增负责人
function add(){
	if(currentRecord.get('dutyId')!=''){
		L5.Msg.alert("提示","只能新增一位分支机构负责人!");
		return;
	}
	somDutyDataSet.removeAll();
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomDutyCmd");
	command.execute('getDutyId');
	dutyId = command.getReturn('dutyId');
	somDutyDataSet.newRecord({"dutyId":dutyId,"ifServe":"1","ifPartyLeader":"0","sorgType":"S","regStatus":"3","sorgDuties":"00002","taskCode":taskCode,"sorgId":sorgId});
	sorgDutiesDataSet.filterBy(function(record, id){
		if("00002".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	L5.getCmp("peopleWin").show();
	L5.getCmp("peoplePanel").setActiveTab("2");
	L5.getCmp("peoplePanel").setActiveTab("1");
	L5.getCmp("peoplePanel").setActiveTab("0");
	//initPhoto("1");//初始化照片
	guidePeopleInit();
	somPeopleElectronicDataSet_branch_load(dutyId);//同步法律要件
	people_type="S";
}	
// 修改负责人
function update(){
	var grid=L5.getCmp("peopleGrid");
	currentPeople=grid.getSelectionModel().getSelected();
	if(!currentPeople){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	dutyId=currentPeople.get('dutyId');
	if(currentRecord.get('dutyId') != dutyId){
		L5.Msg.alert("提示","只能修改审批中的人员!");
		return;
	}
	people_type='SU';
	somDutyDataSet.removeAll();
	var record=somDutyDataSet.newRecord();
	somDutyDataSet.remove(record);
	somDutyDataSet.insert(0,currentPeople.copy());
	
	sorgDutiesDataSet.filterBy(function(record, id){
		if("00002".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	L5.getCmp("peopleWin").show();
	L5.getCmp("peoplePanel").setActiveTab("2");
	L5.getCmp("peoplePanel").setActiveTab("1");
	L5.getCmp("peoplePanel").setActiveTab("0");
	var birthday=currentPeople.get("birthday");
	showAge();
	//synPhoto(somDutyDataSet.get("photoId"),"1");//同步照片
	somPeopleElectronicDataSet_branch_load(dutyId);//同步法律要件
}
// 查看负责人明细
function detail(){
	var grid=L5.getCmp("peopleGrid");
	var detailRecord=grid.getSelectionModel().getSelected();
	if(!detailRecord){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	if(currentRecord.get('dutyId') == detailRecord.get('dutyId')){
		somResumeDataSet.removeAll();
		somResumeDataSet.add(somResumeInsertDataSet.getAllRecords());
	}else{
		somResumeDataSet.removeAll();
		somResumeDataSet.setParameter("DUTY_ID",detailRecord.get('dutyId'));
		somResumeDataSet.load();
	}
	
	somDutyDataSet.removeAll();
	somDutyDataSet.insert(0,detailRecord.copy());
	L5.getCmp("peopleDetailWin").show();
	var birthday=somDutyDataSet.get('birthday');
	var day=new Date();
	var year=day.getYear();
	var birthYear=birthday.substring(0,4);
	document.getElementById("age1").innerHTML=parseInt(year)-parseInt(birthYear);
	//synPhotoDetail(somDutyDataSet.get("photoId"),"2");//同步照片
	somPeopleElectronicDataSet_branch_load(detailRecord.get('dutyId'));//同步法律要件
}
//删除负责人
function del(){
	var grid = L5.getCmp('peopleGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		if(currentRecord.get('dutyId') != records[0].get('dutyId')){
			L5.Msg.alert("提示","只能删除审批中的人员!");
			return;
		}
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				aspForJianShi.remove(records[0]);
				//删除此人的简历
				somResumeInsertDataSet.each(function(record, id){
					if(record.get('dutyId') == records[0].get('dutyId')){
						somResumeInsertDataSet.remove(record);
					}
				});
				currentRecord=somDutyDataSet.newRecord();
			}
			else return;
		});		
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}
function countRender(value){
	if(value === undefined){
		value=0;
	}
	return "负责人总人数: "+value+" 人";

}
// 增加个人简历
function addResume(){
	somResumeInsertDataSet.newRecord({"dutyId":dutyId});
}

// 删除个人简历
function delResume(){
	var grid = L5.getCmp('somResumeGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				somResumeInsertDataSet.remove(records[0]);
			}
			else return;
		});		
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
	}
}

function renderDate(value) {
	if(value.length>8){
		L5.Msg.alert("提示","日期不要超过8位,请检查！");
		return value;
	}
	return value;
}

function checkIdCard(){
	var idCard=_$("idCard");
	if(idCard=="") return;
	// 根据证件号码索引人员
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	var record=somDutyDataSet.getCurrent();
	
	var winPeopleDataSet=L5.DatasetMgr.lookup("winPeopleDataSet");
	winPeopleDataSet.setParameter("ID_CARD",_$('idCard'));
	winPeopleDataSet.load();
	winPeopleDataSet.on('load', function(){
		if(winPeopleDataSet.getCount()>0){
			L5.getCmp("win_peopleValidate").show();
		}else{
			record.set("peopleId","");	//未查到人员时peopleId置空
		}
	});
	
	//如果为身份证号，获取出生年月和性别
	if(idCard.length==15||idCard.length==18){
		record.set("sex",getSexByCode(idCard));
		record.set("birthday",getBirthdayByCode(idCard));
		showAge();
	}
}
function showAge(){
	var birthday=_$("birthday");
	var day=new Date();
	var year=day.getYear();
	var birthYear=birthday.substring(0,4);
	document.getElementById("age").innerHTML=parseInt(year)-parseInt(birthYear);
}
// 数据校验
function checkData(){
	if(_$("idCard")==""){
		L5.Msg.alert('提示','身份证号不能为空！');
		return false;
	}
	if(_$("name")==""){
		L5.Msg.alert('提示','姓名不能为空！');
		return false;
	}
	if(_$("sex")==""){
		L5.Msg.alert('提示','性别不能为空！');
		return false;
	}
	if(_$("birthday")==""){
		L5.Msg.alert('提示','出生年月不能为空！');
		return false;
	}
	if(_$("sorgDuties")==""){
		L5.Msg.alert('提示','担任职务不能为空！');
		return false;
	}
	if(_$("ifPartyLeader")==""){
		L5.Msg.alert('提示','是否党政机关领导干部不能为空！');
		return false;
	}else if(_$("ifPartyLeader")=="1"){
		if(_$("promiseOrgan")==""||_$("promiseCode")==""){
			L5.Msg.alert('提示','批准机关和批准文号不能为空！');
			return false;
		}
	}
	return true;
}
//任职信息中新增人员
function addItem(){
	var idCard=document.getElementById("idCard").value;
	var somDutyInsertDataSet = L5.DatasetMgr.lookup("somDutyInsertDataSet");
	var record = somDutyInsertDataSet.getCurrent();
	record.set("idCard",idCard);
	//回填性别
	record.set("sex",getSexByCode(idCard));
	//回填出生年月	
	record.set("birthday",getBirthByCode(idCard));
	//回填年龄
	$("age").innerHTML = getAgeByCode(idCard);
	var win = L5.getCmp("win_peopleValidate");
	win.hide();
}
function editItem(){
	var grid=L5.getCmp("gridPeople");
	var record=grid.getSelectionModel().getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var ifLimit=record.get("ifLimit");
	var restrictPeopleId=record.get("restrictPeopleId");
	if(ifLimit=='1'){
		L5.Msg.alert("提示","此人为受限人员，不能担任负责人！",function(){		
			return;
		});
	}else if(ifLimit=='0'){
		var command = new L5.Command("com.inspur.cams.sorg.restrict.cmd.SomRestrictPeopleDetailCmd");
		command.setParameter("PEOPLE_ID",restrictPeopleId);
		command.execute("getNum");
		var num = command.getReturn("num");
		if(num>0){
			L5.MessageBox.confirm('确定', '此人有'+num+'条受限记录，确定其担任负责人？',function(sta){
				if(sta=="yes"){
					editItemInfo();
					return;
				}else{	
					return;
				}
			});
		}		
	}else{
		editItemInfo();
	}
}
function editItemInfo(){	
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	var peopleRecord=somDutyDataSet.getCurrent();
	var grid=L5.getCmp("gridPeople");
	var record=grid.getSelectionModel().getSelected();
	//回填人员基础信息
	peopleRecord.set("peopleId",record.get("peopleId"));
	peopleRecord.set("idCard",record.get("idCard"));
	peopleRecord.set("name",record.get("name"));
	peopleRecord.set("aliasName",record.get("aliasName"));
	peopleRecord.set("sex",record.get("sex"));
	peopleRecord.set("folk",record.get("folk"));
	peopleRecord.set("birthday",record.get("birthday"));
	peopleRecord.set("nation",record.get("nation"));
	peopleRecord.set("politics",record.get("politics"));
	peopleRecord.set("education",record.get("education"));
	peopleRecord.set("populace",record.get("populace"));
	peopleRecord.set("birthplace",record.get("birthplace"));
	peopleRecord.set("adds",record.get("adds"));
	peopleRecord.set("postCode",record.get("postCode"));
	peopleRecord.set("phone",record.get("phone"));
	peopleRecord.set("ifPartyLeader",record.get("ifPartyLeader"));
	peopleRecord.set("ifRetire",record.get("ifRetire"));
	peopleRecord.set("workName",record.get("workName"));
	peopleRecord.set("workPhone",record.get("workPhone"));
	peopleRecord.set("workDuties",record.get("workDuties"));
	peopleRecord.set("profession",record.get("profession"));
	peopleRecord.set("ifFulltime",record.get("ifFulltime"));
	peopleRecord.set("resume",record.get("resume"));
	peopleRecord.set("photoId",record.get("photoId"));
	//synPhoto(peopleRecord.get("photoId"),"1");//同步照片
	L5.getCmp("win_peopleValidate").setVisible(false);
}
//获取连任信息
function getRenew(){
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	var record=somDutyDataSet.getCurrent();
	
	var peopleId=_$('peopleId');
	var sorgDuties=_$('sorgDuties');
	if(peopleId==""||sorgDuties==""){
		record.set('ifRenew','0');
		record.set('renewNum','0');
		return;
	}
	var winDutyDataSet=L5.DatasetMgr.lookup("winDutyDataSet");
	winDutyDataSet.setParameter("SORG_ID@=",sorgId);
	winDutyDataSet.setParameter("PEOPLE_ID@=",peopleId);
	winDutyDataSet.setParameter("SORG_DUTIES@=",sorgDuties);
	winDutyDataSet.setParameter("IF_SERVE@=","1");
	winDutyDataSet.load();
	winDutyDataSet.on('load', function(){
		//alert(winDutyDataSet.getCount());为什么会执行多遍？
		if(winDutyDataSet.getCount()>0){
			var renewNum=winDutyDataSet.get('renewNum');
			var ifRenew=winDutyDataSet.get('ifRenew');
			if(method=="insert"){
				record.set('ifRenew','1');
				record.set('renewNum', parseInt(renewNum)+1);
			}else{
				record.set('ifRenew',ifRenew);
				record.set('renewNum', renewNum);
			}
		}else{
			record.set('ifRenew','0');
			record.set('renewNum','0');
		}
	});
}
//关闭人员索引窗口
function closeItem(){
	L5.getCmp("win_peopleValidate").setVisible(false);
}
function ifPartyLeaderChange(){
	if(_$("ifPartyLeader")=="1"){
		$("promiseOrgan").style.display="block";
		$("promiseCode").style.display="block";
	}else{
		$("promiseOrgan").value="";
		$("promiseCode").value="";
		$("promiseOrgan").style.display="none";
		$("promiseCode").style.display="none";
	}
}
function ifServeChange(){
	if(_$("ifServe")=="0"){
		$("peopleEndDate").style.display="block";
	}else{
		$("peopleEndDate").value="";
		$("peopleEndDate").style.display="none";
	}
}
function closePeopleWIn(){
	var win = L5.getCmp("peopleWin");
	win.hide();
}
function closePeopleDetailWIn(){
	var win = L5.getCmp("peopleDetailWin");
	win.hide();
}
function confirm(){
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomPeopleCmd");
	command.setParameter("ID_CARD",_$("idCard"));
	command.execute("queryRestrictNum");
	var restrictNum = command.getReturn("restrictNum");
	var ifLimit=command.getReturn("ifLimit");
	if(restrictNum > 0){
		if(ifLimit=='1'){
			L5.Msg.alert("提示","此人为受限人员，不能担任负责人！",function(){		
				return;
			});
		}else if(ifLimit=='0'){
			var command = new L5.Command("com.inspur.cams.sorg.restrict.cmd.SomRestrictPeopleDetailCmd");
			command.setParameter("ID_CARD",_$("idCard"));
			command.execute("queryPeopleNum");
			var peopleNum = command.getReturn("peopleNum");
			if(peopleNum > 0){
				L5.MessageBox.confirm('确定', '此人有'+peopleNum+'条受限记录，确定其担任负责人？',function(sta){
					if(sta=="yes"){
						confirmInfo();
						return;
					}else{	
						return;
					}
				});
			}
		}else{
			confirmInfo();
		}
	}else{
		confirmInfo();
	}
}
function confirmInfo(){
	if(!checkData()) return;
	var IsValidate = somDutyDataSet.isValidate();
	if(IsValidate != true){
		L5.Msg.alert("提示",IsValidate);
		return false;
	}
	var somResumeInsertDataSetIsValidate = somResumeInsertDataSet.isValidate();
	if(somResumeInsertDataSetIsValidate != true){
		L5.Msg.alert("提示",somResumeInsertDataSetIsValidate);
		return false;
	}
	var record=somDutyDataSet.getCurrent();
	if(record.get("startDate") == ""){
		L5.Msg.alert('提示','任职开始日期不能为空！');
		return false;
	}
	//维护照片信息
	if(_$("photoId1")){
		var newPhotoId = savePhoto(_$("photoId1"),"J");//保存照片到数据库并返回photoId
		if(newPhotoId!=null){
			somDutyDataSet.set("photoId",newPhotoId);
		}
	}
	
	if(people_type == "S"){
		aspForJianShi.insert(aspForJianShi.getCount(),somDutyDataSet.getCurrent().copy());
	}else if(people_type == "SU"){
		aspForJianShi.remove(currentPeople);
		aspForJianShi.insert(aspForJianShi.getCount(),somDutyDataSet.getCurrent().copy());
	}
	currentRecord=somDutyDataSet.getCurrent().copy();
	aspForJianShi.commitChanges();

	L5.getCmp("peopleWin").setVisible(false);
}


function guidePeopleInit(){
	L5.getCmp("gridPeople").on("rowclick",function(grid,rowIndex,e){
		var record=grid.getSelectionModel().getSelected();
		if(record){
			var peopleId=record.get('peopleId');
			var winDutyDataSet=L5.DatasetMgr.lookup("winDutyDataSet");
			winDutyDataSet.setParameter("PEOPLE_ID@=",peopleId);
			winDutyDataSet.load();
			winDutyDataSet.on('load',function(){
				winDutyDataSet.filterBy(function(record, id){
					if("00012".indexOf(record.get('sorgDuties'))==-1){
						return record;
					}
				});
			});
		}
	});
	//过滤负责人职务：法定代表人
	sorgDutiesSelect.filterBy(function(record, id){
		if("00012".indexOf(record.get('value'))==-1){
			return record;
		}
	});	
}

function back(){
	window.history.go(-1);	
}

function checkIdCardThisPage(){
	if(_$("idCard")=="") return;
	//身份证号
	if(checkIDCard(document.getElementById("idCard")) != true){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		return;
	}
	// 根据证件号码索引人员
	var record=somDutyDataSet.getCurrent();
	
	var winPeopleDataSet=L5.DatasetMgr.lookup("winPeopleDataSet");
	winPeopleDataSet.setParameter("ID_CARD",_$("idCard"));
	winPeopleDataSet.load();
	winPeopleDataSet.on('load', function(){
		if(winPeopleDataSet.getCount()>0){
			L5.getCmp("win_peopleValidate").show();
		}else{
			record.set("peopleId","");	//未查到人员时peopleId置空
		}
	});
	
	//如果为身份证号，获取出生日期和性别
	if(_$("idCard").length==18){
		record.set("sex",getSexByCode(_$("idCard")));
		record.set("birthday",getBirthByCode(_$("idCard")));
		showAge();
	}
}