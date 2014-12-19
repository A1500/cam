var sorgId = "";
var somApplyType = "201";
var applyType = "219,220";
var taskCode = "";
var legalRecord="";
var legalDuties="00012";
function init() {
	L5.getCmp("tab").setActiveTab("1");
	L5.getCmp("tab").setActiveTab("2");
	L5.getCmp("tab").setActiveTab("3");
	L5.getCmp("tab").setActiveTab("4");
	L5.getCmp("tab").setActiveTab("5");
	L5.getCmp("tab").setActiveTab("0");
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	somApplyDataSet.setParameter("PROCESS_ID@=", processId);
	somApplyDataSet.load();
	somApplyDataSet.on('load', loadInfo);
	opinionSelect.filterBy(function(record, id){
		if(act=='auditReport'){
			if("0,1".indexOf(record.get('value'))>-1){
				return record;
			}
		}else if(act=='accept'){
			if("0,1".indexOf(record.get('value'))>-1){
				return record;
			}
		}else if(act=='watch'){
			if("0,1".indexOf(record.get('value'))>-1){
				return record;
			}
		}else if(act=='examin'){
			if("0,1".indexOf(record.get('value'))>-1){
				return record;
			}
		}else if(act=='check'){
			if("0,1".indexOf(record.get('value'))>-1){
				return record;
			}
		}else if(act=='audit'){
			if("0,1".indexOf(record.get('value'))>-1){
				return record;
			}
		}else if(act=='inform'){
			if("1".indexOf(record.get('value'))>-1){
				return record;
			}
		}
	});
	if(ifFinish == "1"){
		applyType = "219,220,221";
	}
}
function loadInfo(){
	somApplyDataSet.set("curActivity", getActDefName());
	somApplyDataSet.set("curOpinionId", "1");
	sorgId = somApplyDataSet.get('sorgId');
	taskCode = somApplyDataSet.get('taskCode');
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on('load',function(record){
		if(record.get('resideSource')== "2"){
			$("leasePeriod").style.display = "block";
		}else{
			$("leasePeriod").value = "";
			$("leasePeriod").style.display = "none";
		}
	});
	
	somFlowDataSet.setParameter("TASK_CODE@=", taskCode);
	somFlowDataSet.load();
	somElectronicDataSet_load();	
	
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeLegalDataSet=L5.DatasetMgr.lookup("somResumeLegalDataSet");
	somResumeDataSet.setParameter("TASK_CODE@=", taskCode);
	somResumeDataSet.load();
	
	somDutyDataSet.setParameter("TASK_CODE", taskCode);
	somDutyDataSet.load();
	somDutyDataSet.on('load',function(){
		if(somDutyDataSet.getCount()>0){
			var peopleId="";
			var sorgOpinion="";
			var sorgCheckDate="";
			somDutyDataSet.each(function(record, index){
				if(record.get('sorgDuties') == legalDuties){
					peopleId=record.get('peopleId');
					sorgOpinion=record.get("sorgOpinion");
					sorgCheckDate=record.get("sorgCheckDate");
					//回填法定代表人简历
					var j=0;
					for(var i=0;i<somResumeDataSet.getCount();i++){
						var somResumeRecord =somResumeDataSet.getAt(i);
						if(peopleId == somResumeRecord.get('peopleId')){
								somResumeLegalDataSet.insert(j,somResumeRecord);
								j++;
							}
					}
					//回填法定代表人简历结束
				}
			});
			somDutyDataSet.filterBy(function(record, id){
				if(record.get('sorgDuties') != legalDuties){
					if(record.get('peopleId') == peopleId){
						legalRecord=record;
						record.set("ifLegal","1");
						legalRecord.set("sorgOpinion",sorgOpinion);
						legalRecord.set("sorgCheckDate",sorgCheckDate);
					}
					return record;
				}
			});
			
			LegalPeopleDataSet.insert(0,legalRecord);
			document.getElementById("labelAge").innerHTML=getAgeByCode(legalRecord.get("idCard"));	
			synPhotoDetail(LegalPeopleDataSet.get("photoId"),null);
				
			var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
			somSessionDataSet.setParameter("TASK_CODE@=", taskCode);
			somSessionDataSet.load();
			var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
			somRuleDataSet.setParameter("TASK_CODE@=", taskCode);
			somRuleDataSet.load();	
		}else{
			//法定代表人
			LegalPeopleDataSet.newRecord();
			//届次信息
			var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
			somSessionDataSet.newRecord();
			//章程核准
			var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");
			somRuleDataSet.newRecord();		
		}	
	});		
	/*var somSessionDataSet=L5.DatasetMgr.lookup("somSessionDataSet");
	somSessionDataSet.setParameter("TASK_CODE@=", taskCode);
	somSessionDataSet.load();
	var somRuleDataSet=L5.DatasetMgr.lookup("somRuleDataSet");	
	somRuleDataSet.setParameter("TASK_CODE@=", taskCode);
	somRuleDataSet.load();
	somDutyDataSet.setParameter("TASK_CODE", taskCode);
	somDutyDataSet.load();
	somDutyDataSet.on('load',function(){
		var peopleId="";
		somDutyDataSet.each(function(record, index){
			if(record.get('sorgDuties') == legalDuties){
				peopleId=record.get('peopleId');
			}
		});
		somDutyDataSet.filterBy(function(record, id){
			if(record.get('sorgDuties') != legalDuties){
				if(record.get('peopleId') == peopleId){
					legalRecord=record;
				}
				return record;
			}
		});

		LegalPeopleDataSet.insert(0,legalRecord);
		document.getElementById("labelAge").innerHTML=getAgeByCode(legalRecord.get("idCard"));
			
	});
	somFlowDataSet.setParameter("TASK_CODE@=", taskCode);
	somFlowDataSet.load();
	somElectronicDataSet_load();*/
}

//点击上传附件按钮
function clickUploadFile(){
	if(sorgId == ""){
		L5.Msg.alert('提示','请先填写“基金会中文名称！”');
		L5.getCmp("tab").setActiveTab("0");
		return false;
	}
	uploadFile();
}
//弹出上传附件窗口
function uploadFile(){
	if(sorgId == ""){
		L5.Msg.alert('提示','请先填写“基金会名称/中文！”');
		L5.getCmp("tab").setActiveTab("0");
		L5.getCmp("tab1").setActiveTab("0");
		return false;
	}
	var uploadGrid=L5.getCmp('uploadGrid');
	var selected=uploadGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请先选择一条记录!");
		return false;
	}
	var record=selected[0];
	var catalogCode = record.get("catalogCode");
	winElectronicDataSet_load(catalogCode);
	var win=L5.getCmp("uploadList");
	win.show();
}
//增加上传附件
function addUploadFile(){
	var win=L5.getCmp("uploadWin");
	win.show();
	
}
//删除附件
function delUploadFile(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:clickDelete(\'' + winElectronicDataSet.indexOf(record) + '\')">' + '点击删除' + '</a>';
}
function clickDelete(index){
	var record= winElectronicDataSet.getAt(index);
	L5.MessageBox.confirm('', '你确定要删除吗？',function(sure){
		if(sure=="yes"){
			var electronicId = record.get("electronicId");
			var command=new L5.Command("com.inspur.cams.sorg.upload.cmd.SomElectronicCmd");
			command.setParameter("electronicId",electronicId);
			command.execute("delElectronic");
			if (!command.error) {
				var uploadGrid=L5.getCmp('uploadGrid');
				var selected=uploadGrid.getSelectionModel().getSelected();
				winElectronicDataSet_load(selected.get("catalogCode"));	
				L5.Msg.alert('提示','删除成功！');
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}
		else 
			return;
		}
	);	
}
//保存
function save(){
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBuildCmd");
	//法人
	var organRecord = somOrganDataSet.getCurrent();
	command.setParameter("organRecord",organRecord);
	//负责人
	var somDutyRecords = somDutyDataSet.getAllRecords();
	command.setParameter("somDutyRecords",somDutyRecords);
	//法定代表人
	var LegalPeopleRecord = LegalPeopleDataSet.getCurrent();
	command.setParameter("LegalPeopleRecord",LegalPeopleRecord);
	//届次
	var somSessionRecord = somSessionDataSet.getCurrent();
	command.setParameter("somSessionRecord",somSessionRecord);
	//章程核准信息
	var somRuleRecord = somRuleDataSet.getCurrent();
	command.setParameter("somRuleRecord",somRuleRecord);
	//业务意见
	var somApplyRecord = somApplyDataSet.getCurrent();
	command.setParameter("somApplyRecord",somApplyRecord);
	command.execute("updateBuildInfo");
	
	if(!command.error){
		L5.Msg.alert('提示','保存成功！',function(){
			returnClick();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//保存并提交
function submit() {
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBuildCmd");
	//法人
	var organRecord = somOrganDataSet.getCurrent();
	command.setParameter("organRecord",organRecord);
	//负责人
	var somDutyRecords = somDutyDataSet.getAllRecords();
	command.setParameter("somDutyRecords",somDutyRecords);
	//法定代表人
	var LegalPeopleRecord = LegalPeopleDataSet.getCurrent();
	command.setParameter("LegalPeopleRecord",LegalPeopleRecord);
	//届次
	var somSessionRecord = somSessionDataSet.getCurrent();
	command.setParameter("somSessionRecord",somSessionRecord);
	//章程核准信息
	var somRuleRecord = somRuleDataSet.getCurrent();
	command.setParameter("somRuleRecord",somRuleRecord);
	//业务意见
	var somApplyRecord = somApplyDataSet.getCurrent();
	command.setParameter("somApplyRecord",somApplyRecord);
	command.execute("updateForSend");
	if(!command.error){
		L5.Msg.alert('提示','成功提交至下一环节!',function(){
			returnClick();
		});
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
//返回
function returnClick(){
	history.go(-1);
}
//判断住所来源，如果是租赁则显示租赁期限
function changeResideSource(){
	if(_$("resideSource") == "2"){
		$("leasePeriod").style.display = "block";
	}else{
		$("leasePeriod").value = "";
		$("leasePeriod").style.display = "none";
	}
}

function click_upload(){
	var uploadGrid=L5.getCmp('uploadGrid');
	var selected=uploadGrid.getSelectionModel().getSelections();
	var record=selected[0];
	record.set("sorgId",somOrganDataSet.get("sorgId"));
	record.set("sorgKind","");
	record.set("sorgType","S");
	record.set("cnName",somOrganDataSet.get("cnName"));
	record.set("fileMess",_$("fileMess"));
	var command=new L5.Command("com.inspur.cams.sorg.upload.cmd.SomElectronicCmd");
	command.setParameter("uploadRd",record);
	command.setForm("form_content");
	command.execute("uploadSave");
	//包含有大字段的异常判断
	command.afterExecute=function(){
		if(!command.error){
		L5.Msg.alert("提示","上传附件成功!",function(){
			var win=L5.getCmp("uploadWin");
			win.hide();
		});
		somElectronicDataSet_load();
		}else{
	        L5.Msg.alert("提示",(command.error+'').replace("出现系统异常",""),{});
        }
	}
}


//校验登记证号是否重复
function sorgCodeUK(){
	if(_$("sorgCode").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBuildCmd");
		command.setParameter("sorgCode",_$("sorgCode"));
		command.execute("sorgCodeUK");
		sorgCodeNum = command.getReturn("sorgCodeNum");
		if(sorgCodeNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的机构登记证号已存在");
			return;
		}
	}
}

//校验社团分支机构代码
function validateSorgCode(){
	$("name").innerHTML = "";
	$("legalPeople").innerHTML = "";
	$("mainSorgId").value = "";
	$("cnName").value = "";
	var mainSorgCode = _$("mainSorgCode");
	if(mainSorgCode.trim() == ""){
		return;
	}
	var somMainOrganDataSet = L5.DatasetMgr.lookup("somMainOrganDataSet");
	somMainOrganDataSet.setParameter("SORG_TYPE@=","J");
	somMainOrganDataSet.setParameter("SORG_CODE@=",mainSorgCode);
	somMainOrganDataSet.load();
	somMainOrganDataSet.on("load",function(ds){
		if(ds.getCount() == 0){
			L5.Msg.alert("提示","输入的基金会登记证号不存在!");
			return ;
		}
		if(ds.get("sorgStatus") == "32" || ds.get("sorgStatus") == "62"){
			L5.Msg.alert("提示",'“'+ds.get("cnName")+'”已被注销，请重新输入！');
			return;
		}
		if(ds.get("sorgStatus") == "52"){
			L5.Msg.alert("提示",'“'+ds.get("cnName")+'”已被撤销，请重新输入！'); 
			ds.newRecord();
			return;
		}
		$("name").innerHTML = ds.get("cnName");
		$("legalPeople").innerHTML = ds.get("legalPeople");
		$("mainSorgId").value = ds.get("sorgId");
		$("mainSorgCode").value = ds.get("sorgCode");
		$("cnName").value = ds.get("cnName");
	});
}
function changSorgKind(){
	if(_$("sorgKind") == "2"){
		$("actArea").style.display = "block";
	}else{
		$("actArea").value = "";
		$("actArea").style.display = "none";
	}
}
function showAge(){
	$("age").innerHTML = getAgeByBirthday(_$("birthday"));
}
function validateIdcard(){
	if(_$("idCard") != ""){
		if(checkIDCard($("idCard")) == true){
		}else{
			L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
			return;
		}
	}
}
//任职信息中新增人员
function addItem(){
	var idCard=document.getElementById("idCard").value;
	var somDutyInsertDataSet = L5.DatasetMgr.lookup("somDutyInsertDataSet");
	somDutyInsertDataSet.removeAll();
	var record = somDutyInsertDataSet.newRecord();
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
//任职信息中回填此人信息
function editItem(){
	var grid = L5.getCmp("gridPeople");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return ;
	}
	var peopleId = record.get("peopleId");
	var somDutyInsertDataSet = L5.DatasetMgr.lookup("somDutyInsertDataSet");
	somDutyInsertDataSet.removeAll();
	var newRecord = somDutyInsertDataSet.newRecord();
	newRecord.set("peopleId",record.get("peopleId"));
	newRecord.set("idCard",record.get("idCard"));
	$("age").innerHTML = getAgeByCode(record.get("idCard"));
	newRecord.set("name",record.get("name"));
	newRecord.set("aliasName",record.get("aliasName"));
	newRecord.set("sex",record.get("sex"));
	newRecord.set("folk",record.get("folk"));
	newRecord.set("ifFulltime",record.get("ifFulltime"));
	newRecord.set("birthday",record.get("birthday"));
	newRecord.set("nation",record.get("nation"));	
	newRecord.set("politics",record.get("politics"));
	newRecord.set("education",record.get("education"));
	newRecord.set("birthplace",record.get("birthplace"));
	newRecord.set("phone",record.get("phone"));
	newRecord.set("adds",record.get("adds"));
	newRecord.set("ifRetire",record.get("ifRetire"));
	newRecord.set("populace",record.get("populace"));
	newRecord.set("postCode",record.get("postCode"));
	newRecord.set("workDuties",record.get("workDuties"));
	newRecord.set("workPhone",record.get("workPhone"));
	newRecord.set("workName",record.get("workName"));
	newRecord.set("ifPartyLeader",record.get("ifPartyLeader"));
	newRecord.set("resume",record.get("resume"));
	newRecord.set("profession",record.get("profession"));	
	newRecord.set("peoplePartyType",record.get("peoplePartyType"));
	newRecord.set("joinDate",record.get("joinDate"));
	newRecord.set("relation",record.get("relation"));
	newRecord.set("partyDuties",record.get("partyDuties"));
	newRecord.set("ifMoblie",record.get("ifMoblie"));
	newRecord.set("developDate",record.get("developDate"));
	newRecord.set("activistsDate",record.get("activistsDate"));
	newRecord.set("applicationDate",record.get("applicationDate"));
	newRecord.set("ifLegal",record.get("ifLegal"));
	var win = L5.getCmp("win_peopleValidate");
	win.hide();
	
}
//关闭窗口
function closeItem(){
	var win = L5.getCmp("win_peopleValidate");
	win.hide();
}

function getActDefName(){
	if(act=='auditReport'){
		return "名称核准";
	}else if(act=='accept'){
		return "受理";
	}else if(act=='watch'){
		return "现场勘查";
	}else if(act=='examin'){
		return "初审";
	}else if(act=='check'){
		return "审核";
	}else if(act=='audit'){
		return "批准";
	}else if(act=='inform'){
		return "通知申请人";
	}
}
//------------------负责人处理------------------------------
//增加负责人按钮
function add(){
	somDutyInsertDataSet.newRecord();
	var win=L5.getCmp("peopleWin");
	win.show();
}
//点击更新一条负责人
var updateRecord;
function update(){
	var grid=L5.getCmp("peopleGrid");
	updateRecord=grid.getSelectionModel().getSelected().copy();
	if(!updateRecord){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	somDutyInsertDataSet.removeAll();
	somDutyInsertDataSet.insert(0,updateRecord);
	var win = L5.getCmp("peopleWin");
	win.show();
}
//点击删除一条负责人
function del(){
	var grid = L5.getCmp('peopleGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
	L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
		if(sta=="yes"){
			var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
			somDutyDataSet.remove(records[0]);
			if(records[0].get("ifLegal") == '1'){
				LegalPeopleDataSet.removeAll();
			}
		}
		else return;
	}
	);		
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
}
//点击确定 保存一条负责人信息
function confirm(){
	var somDutyInsertDataSet = L5.DatasetMgr.lookup("somDutyInsertDataSet");
	//校验
	var somDutyInsertValidate = somDutyInsertDataSet.isValidate();
	if(somDutyInsertValidate != true){
		L5.Msg.alert("提示",somDutyInsertValidate);
		return false;
	}
	
	var record=somDutyInsertDataSet.getCurrent();
	record.set("ifServe","1");
	record.set("promiseOrgan",document.getElementById('promiseOrgan_add').value);
	record.set("promiseCode",document.getElementById('promiseCode_add').value);
	if(updateRecord != ""){
		somDutyDataSet.remove(updateRecord);
	}
	somDutyDataSet.insert(somDutyDataSet.getCount(),record);
	somDutyDataSet.commitChanges();
	var win=L5.getCmp("peopleWin");
	win.hide();
}
//负责人录入中输入身份证号进行查询
function checkPeopleInfo(){
	var idCard=document.getElementById("idCard").value;
	//身份证号
	if(checkIDCard(document.getElementById("idCard")) != true){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		return;
	}
	var winPeopleDataSet = L5.DatasetMgr.lookup("winPeopleDataSet");
	winPeopleDataSet.setParameter("ID_CARD@=",idCard);
	winPeopleDataSet.load();
	var win_peopleValidate=L5.getCmp("win_peopleValidate");
	win_peopleValidate.show();
}

//选择是否党政机关领导
function valid_ifPartyLeader_add(){
	if(document.getElementById('ifPartyLeader_add').value == '1'){
		document.getElementById('promiseOrgan_add').style.display="block";
		document.getElementById('promiseCode_add').style.display="block";
	}else{
		document.getElementById('promiseOrgan_add').style.display="none";
		document.getElementById('promiseCode_add').style.display="none";
		document.getElementById('promiseOrgan_add').value="";
		document.getElementById('promiseCode_add').value="";
	}
}
//选定为法定代表人
function chooseLegal(){
	var grid = L5.getCmp('peopleGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
	L5.MessageBox.confirm('确定', '选定[ '+records[0].get("name")+' ]为法定代表人？',function(sta){
		if(sta=="yes"){
			if(LegalPeopleDataSet.getCount() == 1 && LegalPeopleDataSet.getCurrent().get("idCard") != ""){
				L5.MessageBox.confirm('确定', '法定代表人已经存在，是否覆盖？',function(yes){
					if(yes=="yes"){
						var record=LegalPeopleDataSet.getCurrent();
						somDutyDataSet.remove(record);
						record.set("ifLegal",'0');
						somDutyDataSet.insert(somDutyDataSet.getCount(),record);
						LegalPeopleDataSet.removeAll();
						records[0].set("ifLegal",'1');
						somDutyDataSet.commitChanges();
						LegalPeopleDataSet.insert(0,records[0]);
						var idCard=records[0].get("idCard");
						document.getElementById("labelAge").innerHTML = getAgeByCode(idCard);
						//回填简历信息
						var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
						var somResumeLegalDataSet=L5.DatasetMgr.lookup("somResumeLegalDataSet");
						somResumeLegalDataSet.removeAll();
						var peopleId = LegalPeopleDataSet.getCurrent().get("peopleId");
						var j=0;
						for(var i=somResumeDataSet.getCount()-1;i>=0;i--){
							var somResumeRecord =somResumeDataSet.getAt(i);
							if(peopleId == somResumeRecord.get('peopleId')){
									somResumeLegalDataSet.insert(j,somResumeRecord);
									j++;
								}
						}
					}
					else return;
				})
				return;
			}
			records[0].set("ifLegal",'1');
			somDutyDataSet.commitChanges();
			LegalPeopleDataSet.removeAll();
			LegalPeopleDataSet.insert(0,records[0]);
			var idCard=records[0].get("idCard");
			document.getElementById("labelAge").innerHTML = getAgeByCode(idCard);
			//回填简历信息
			var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
			var somResumeLegalDataSet=L5.DatasetMgr.lookup("somResumeLegalDataSet");
			somResumeLegalDataSet.removeAll();
			var peopleId = LegalPeopleDataSet.getCurrent().get("peopleId");
			var j=0;
			for(var i=somResumeDataSet.getCount()-1;i>=0;i--){
				var somResumeRecord =somResumeDataSet.getAt(i);
				if(peopleId == somResumeRecord.get('peopleId')){
						somResumeLegalDataSet.insert(j,somResumeRecord);
						j++;
					}
			}
		}
		else return;
	}
	);		
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
}
//查看负责人
function detailPeople(){
	var grid = L5.getCmp("peopleGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	somDutyInsertDataSet.removeAll();
	somDutyInsertDataSet.insert(0,record);
	
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeInsertDataSet.removeAll();
	var j=0;
	for(var i=somResumeDataSet.getCount()-1;i>=0;i--){
		var somResumeRecord =somResumeDataSet.getAt(i);
		if(record.get('peopleId')==somResumeRecord.get('peopleId')){
				somResumeInsertDataSet.insert(j,somResumeRecord);
				j++;
			}
	}
	
	L5.getCmp("peopleWin").show();
	synPhotoDetail(somDutyInsertDataSet.get("photoId"),"1");//同步照片
	$("peopleAge").innerHTML = getAgeByCode(record.get("idCard"));
}
//负责人窗户关闭
function winClosePeople(){
	var win = L5.getCmp("peopleWin");
	win.hide();
}

