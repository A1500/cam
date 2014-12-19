var fileCode = "S059";
var end=false;
function init() {
	L5.getCmp("tab").setActiveTab("0");
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	somApplyDataSet.setParameter("PROCESS_ID@=", processId);
	somApplyDataSet.load();
	somApplyDataSet.on('load', loadInfo);
	//过滤tab页
	if(method != "daiban"){
		L5.getCmp("tab").remove(4);
	}
	opinionDataSet.filterBy(function(record, id){
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
			if("0,1,2".indexOf(record.get('value'))>-1){
				return record;
			}
		}else if(act=='check'){
			if("0,1,2".indexOf(record.get('value'))>-1){
				return record;
			}
		}else if(act=='audit'){
			if("0,1,2".indexOf(record.get('value'))>-1){
				return record;
			}
		}else if(act=='inform'){
			if("0,1".indexOf(record.get('value'))>-1){
				return record;
			}
		}else if(act=='print'){
			if("0,1".indexOf(record.get('value'))>-1){
				return record;
			}
		}else if(act=='issue'){
			if("0,1".indexOf(record.get('value'))>-1){
				return record;
			}
		}
	});
	//社团职务过滤
	sorgDutiesSelect.filterBy(function(record, id){
		if("00002".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	if(L5.getCmp("win_peopleValidate")){
		var winDutyDataSet = L5.DatasetMgr.lookup("winDutyDataSet");
		//显示职务列表
		L5.getCmp("gridPeople").on("rowclick",function(g,rowIndex,e){
			winDutyDataSet.removeAll();
			var sm = g.getSelectionModel();
			var record = sm.getSelected();
			winDutyDataSet.setParameter("PEOPLE_ID",record.get("peopleId"));
			winDutyDataSet.load();
		});
		//身份验证window关闭时把数据清空
		L5.getCmp("win_peopleValidate").on("beforehide",function(){
			winDutyDataSet.removeAll();
		});
	}

	//负责人window关闭时把数据清空
	if(L5.getCmp("peopleWin")){
		L5.getCmp("peopleWin").on("beforehide",function(){
			updateRecord="";
		});
	}
	//电子档案上传窗口关闭事件
	uploadListCloseEvent();
	uploadPeopleListCloseEvent();
}
function loadInfo(){
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	sorgId = somApplyDataSet.get('sorgId');
	taskCode = somApplyDataSet.get('taskCode');
	somApplyDataSet.set("curActivity", getActDefName());
	somApplyDataSet.set("curOpinionId", "1");
	if(act=='inform'&&method=='daiban'){//是通知受理人
		var somFlowQuery=L5.DatasetMgr.lookup("somFlowQuery");
		somFlowQuery.setParameter("TASK_CODE@=",taskCode);
		somFlowQuery.setParameter("ACTIVITY@=","批准");
		somFlowQuery.setParameter("OPINION_ID@=","1");
		somFlowQuery.load();
		somFlowQuery.on('load',function (ds){
			if(ds.getCount()==0){
				somApplyDataSet.getCurrent().set("curOpinionId","0");
				document.getElementById("curOpinionId").disabled="disabled";
				end=true;
			}else if(ds.getCount()==1){
				somApplyDataSet.getCurrent().set("curOpinionId","1");
				document.getElementById("curOpinionId").disabled="disabled";
			}
		});
	}
	var record = somApplyDataSet.getCurrent();
	if(act=='watch'&&method=='daiban'){
		$("watchInfo1").style.display="block";
		$("watchInfo2").style.display="block";
		$("prospectAttendPeople").value=record.get("prospectAttendPeople");
		$("prospectPlace").value=record.get("prospectPlace");
		$("prospectDate").value=record.get("prospectDate");
		record.set("prospectAttendPeople","");
		record.set("prospectPlace","");
		record.set("prospectDate","");
	}
	sorgId = somApplyDataSet.get('sorgId');
	taskCode = somApplyDataSet.get('taskCode');
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on("load",function(ds){
		$("mainSorgId").value = ds.get("mainSorgId");
		$("name").innerHTML = ds.get("name");
	});
	somSessionDataSet.setParameter("TASK_CODE@=", taskCode);
	somSessionDataSet.load();

	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeDataSet.setParameter("TASK_CODE", taskCode);
	somResumeDataSet.load();
	somResumeDataSet.on('load',function(){
		somDutyDataSet.setParameter("TASK_CODE", taskCode);
		somDutyDataSet.load();
		somDutyDataSet.on('load',function(){
			if(somDutyDataSet.getCount() > 0){
				isOnly = false;
			}
		});
	});

	somFlowDataSet.setParameter("TASK_CODE@=", taskCode);
	somFlowDataSet.load();
	somElectronicDataSet_load();
}
//保存
function save(){
	var somOrganRecord=somOrganDataSet.getCurrent();
	somOrganRecord.set("mainSorgId",_$("mainSorgId"));
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somApplyRecord=somApplyDataSet.getCurrent();
	if(act=="watch"){
		somApplyRecord.set("prospectAttendPeople",_$("prospectAttendPeople"));
		somApplyRecord.set("prospectPlace",_$("prospectPlace"));
		somApplyRecord.set("prospectDate",_$("prospectDate"));
	}
	var somSessionRecord=somSessionDataSet.getCurrent();
	var somDutyRecords=somDutyDataSet.getAllRecords();

	var somOrganValidate = somOrganDataSet.isValidate();
	if(somOrganValidate != true){
		L5.Msg.alert("提示",somOrganValidate);
		return false;
	}
	//社团名称/中文
	/*if(cnNameNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的分支/代表机构名称已存在");
		return;
	}*/
	//社团邮编
	if(_isPostCode(_$("sorgPost")) != true){
		L5.Msg.alert("提示","校验未通过："+"机构邮编格式不正确");
		return;
	}
	if(somDutyDataSet.getCount()==0){
		L5.Msg.alert("提示","请先录入分支(代表)机构负责人信息");
		return;
	}
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupBranchBuildCmd");
	command.setParameter("somApplyRecord", somApplyRecord);
	command.setParameter("somOrganRecord", somOrganRecord);
	command.setParameter("somSessionRecord", somSessionRecord);
	command.setParameter("somDutyRecords", somDutyRecords);
	//个人简历
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeRecords = somResumeDataSet.getAllRecords();
	command.setParameter("somResumeRecords",somResumeRecords);
	command.execute("update");
	if(!command.error){
		L5.Msg.alert("提示","保存成功!",function(){
			window.history.go(-1);
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//保存并提交
function submit() {
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	var somOrganRecord=somOrganDataSet.getCurrent();
	somOrganRecord.set("mainSorgId",_$("mainSorgId"));
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somApplyRecord=somApplyDataSet.getCurrent();
	if(act=="watch"){
		somApplyRecord.set("prospectAttendPeople",_$("prospectAttendPeople"));
		somApplyRecord.set("prospectPlace",_$("prospectPlace"));
		somApplyRecord.set("prospectDate",_$("prospectDate"));
	}

	var somSessionRecord=somSessionDataSet.getCurrent();
	var somDutyRecords=somDutyDataSet.getAllRecords();
	//if(method=="INSERT"){
		var somOrganValidate = somOrganDataSet.isValidate();
		if(somOrganValidate != true){
			L5.Msg.alert("提示",somOrganValidate);
			return false;
		}
		//社团名称/中文
		/*if(cnNameNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的分支/代表机构名称已存在");
			return;
		}*/
		//社团邮编
		if(_isPostCode(_$("sorgPost")) != true){
			L5.Msg.alert("提示","校验未通过："+"机构邮编格式不正确");
			return;
		}
	//}
	if(somDutyDataSet.getCount()==0){
		L5.Msg.alert("提示","请先录入分支(代表)机构负责人信息");
		return;
	}
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupBranchBuildCmd");
	command.setParameter("somApplyRecord", somApplyRecord);
	command.setParameter("somOrganRecord", somOrganRecord);
	command.setParameter("somSessionRecord", somSessionRecord);
	command.setParameter("somDutyRecords", somDutyRecords);
	//个人简历
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeRecords = somResumeDataSet.getAllRecords();
	command.setParameter("somResumeRecords",somResumeRecords);
	if(act=='issue'){
		command.setParameter("fetchPeople", fetchPeople);
		command.setParameter("fetchDate", fetchDate);
		command.setParameter("fetchPhone", fetchPhone);
	}
	command.execute("updateAndSend");
	if(!command.error){
		L5.Msg.alert("提示","成功提交至下一环节!",function(){
		if(act == 'audit'){
			if(somApplyRecord.get("curOpinionId")=="1"){ //同意-批准通过-根据taskCode更改外网业务状态
				updateOnlineStatusPass(somApplyRecord.get("taskCode"));
			}
			if(somApplyRecord.get("curOpinionId")=="0"){ //不同意-批准不通过-根据taskCode更改外网业务状态
				updateOnlineStatusNoPass(somApplyRecord.get("taskCode"));
			}
		}
			window.history.go(-1);
		});
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
//打印不予受理通知
function printNoAccept(){
	var url=rootPath+"/jsp/cams/sorg/comm/print/noAcceptForPrint.jsp?sorgType=S";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&printPeople="+currentUserName;
	window.open(url);
}
//打印受理通知
function printAccept(){
	var url=rootPath+"/jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=S";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&printPeople="+currentUserName;
	window.open(url);
}
//打印一次性补正材料通知
function sendForPolishing(){

}
//返回
function goBack(){
	history.go(-1);
}
//向dataset中增加数据
function addRecordToDataset(dataset,record){
	var methodName=window.dialogArguments.methodName;
	var ret=window.dialogArguments.activityList;
	dataset.removeAll();
	dataset.add(record);
}
function getValue() {
	//如果起先数据为空，则直接调用增加方法
	if(somOrganDataSet.getCount()==0){
		somOrganDataSet.newRecord();
		return;
	}
}
var sorgCodeNum = "";
var cnNameNum = "";
//校验社会组织名称是否重复
function cnNameUK(){
	if(_$("cnName").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("cnName",_$("cnName"));
		command.execute("cnNameUK");
		cnNameNum = command.getReturn("cnNameNum");
		if(cnNameNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的机构名称已存在");
			return;
		}
	}
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
	}else if(act=='print'){
		return "打印证书";
	}else if(act=='inform'){
		return "通知申请人";
	}else if(act=='issue'){
		return "发证";
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
		if(record.get('dutyId')==somResumeRecord.get('dutyId')){
				somResumeInsertDataSet.insert(j,somResumeRecord);
				j++;
			}
	}
	if(typeof somPeopleElectronicDataSet != 'undefined'){
		somPeopleElectronicDataSet_load(fileCode,record.get('dutyId'));//同步人员法律要件
	}

	var win = L5.getCmp("peopleWin");
	win.show();
	L5.getCmp("peoplePanel1").setActiveTab("2");
	L5.getCmp("peoplePanel1").setActiveTab("1");
	L5.getCmp("peoplePanel1").setActiveTab("0");
	$("peopleAge").innerHTML = getAgeByCode(record.get("idCard"));
}
//选择领证人
function choseIssuePeople(){
	var win=L5.getCmp('forchoseIssuePeople');
	win.show();
}
//选择领证人里面的确认按钮
function buttonForFetch(){
	fetchPeople=document.getElementById('fetchPeople').value;
	fetchDate=document.getElementById('fetchDate').value;
	fetchPhone=document.getElementById('fetchPhone').value;
	if(fetchPeople==''){
		L5.Msg.alert('提示',"领证人不能为空！");return;
	}else if(fetchDate==''){
		L5.Msg.alert('提示',"领证日期不能为空！");return;
	}else if(fetchPhone==''){
		L5.Msg.alert('提示',"领证人联系电话不能为空！");return;
	}
	var win=L5.getCmp('forchoseIssuePeople');
	win.hide();
}
function closeForFetch(){
	var win=L5.getCmp('forchoseIssuePeople');
	win.hide();
}
//关闭打印证书窗口
function winCloseCert(){
	var win = L5.getCmp("forPrint");
	win.setVisible(false);
}
//弹出打印证书窗口
function printCert(){
	var win=L5.getCmp("forPrint");
	win.show();
	$("business").value = somOrganDataSet.get("business");
}
var fetchPeople='';//领证人
var fetchDate='';//领证日期
var fetchPhone='';//领证人联系电话
var PrintDate='';//发证日期
var beginDate='';//有效期限起
var endDate='';//有效期限止
var issueReasonDesc='';//发证原因描述
var sorgCode='';
var business='';
var actArea='';
//打印证书
function forCertType(){
	//登记证号
	if(sorgCodeNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的分支（代表）机构登记证号已存在");
		return;
	}
	var sorgId = somApplyDataSet.get('sorgId');
	var taskCode = somApplyDataSet.get('taskCode');
	var certType=_$('certType');
	endDate=_$('endDate');
	beginDate=_$('beginDate');
	PrintDate=_$('PrintDate');
	issueReasonDesc=_$('issueReasonDesc');
	sorgCode=_$('branchSorgCode');
	business=_$('business');
	actArea=_$('actArea');
	if(certType!='' && endDate!='' && beginDate!='' && PrintDate!=''&& sorgCode!=''&&actArea!=''){
		if(endDate<beginDate){
			L5.Msg.alert('提示',"有效期限止不得早于有效期限起！");
			return;
		}
		var openUrl=url+"/jsp/cams/sorg/comm/print/groupBranchBuildForPrint.jsp?id="+sorgId+"&PrintDate="+PrintDate+"&beginDate="+beginDate+"&endDate="+endDate+"&taskCode="+taskCode+"&certType="+certType;
		openUrl+='&sorgCode='+sorgCode+"&business="+encodeURIComponent(business)+"&actArea="+encodeURIComponent(actArea);
		PostNewWin(openUrl);
	}else{
		L5.Msg.alert('提示',"填入所需数据！");
		return;
	}
}
//打印证书环节提交
function sendForPrint(){
	if(endDate=='' || beginDate=='' || PrintDate==''){
		L5.Msg.alert("提示","请先打印证书!");
		return;
	}
	if(act=='print'){
		if(fetchPeople=='' || fetchDate=='' ||fetchPhone==''){
			L5.Msg.alert("提示","请先填写领证信息！");
			return false;
		}
	}
	//登记证号
	if(sorgCodeNum != 0){
		L5.Msg.alert("提示","校验未通过："+"输入的分支（代表）机构登记证号已存在");
		return;
	}
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	if(somApplyDataSetIsValidate != true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		return false;
	}
	var somApplyRecord=somApplyDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupBranchBuildCmd");
	command.setParameter("certType", _$("certType"));
	command.setParameter("actArea", _$("actArea"));
	command.setParameter("endDate", endDate);
	command.setParameter("beginDate", beginDate);
	command.setParameter("PrintDate", PrintDate);
	command.setParameter("issueReasonDesc", issueReasonDesc);
	command.setParameter("sorgCode", sorgCode);
	command.setParameter("business", business);
	command.setParameter("fetchPeople", fetchPeople);
	command.setParameter("fetchDate", fetchDate);
	command.setParameter("fetchPhone", fetchPhone);
	command.setParameter("somApplyRecord", somApplyRecord);
	command.execute("printForSend");
	if (!command.error) {
		L5.Msg.alert("提示","成功提交至下一环节!",function(){
			window.history.go(-1);
		});
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}

function valid_ifPartyLeader_win(){
	if(_$("ifPartyLeader_win") == "1"){
		$("promiseCode_win").style.display = "block";
		$("promiseOrgan_win").style.display = "block";
	}else{
		$("promiseCode_win").value = "";
		$("promiseOrgan_win").value = "";
		$("promiseCode_win").style.display = "none";
		$("promiseOrgan_win").style.display = "none";
	}
}

function validateIdcard_win(){
	if(_$("idCard_add") == ""){
		return;
	}
	if(_$("cardType_add") == "01"){
		if(checkIDCard($("idCard_add")) == true){
			var cardTypeValue = _$("cardType_add");
			var idCardValue = _$("idCard_add");
			var winPeopleDataSet = L5.DatasetMgr.lookup("winPeopleDataSet2");
			winPeopleDataSet.setParameter("CARD_TYPE@=",cardTypeValue);
			winPeopleDataSet.setParameter("ID_CARD@=",idCardValue);
			winPeopleDataSet.load();
			winPeopleDataSet.on("load",function(ds){
				if(ds.getCount() != 0){
					var winMemberDataSet = L5.DatasetMgr.lookup("winMemberDataSet2");
					winMemberDataSet.removeAll();
					var win = L5.getCmp("win_peopleValidate2");
					win.show();
				}else{
					var winPresidePeopleDataSet = L5.DatasetMgr.lookup("winPresidePeopleDataSet");
					winPresidePeopleDataSet.removeAll();
					var rd = winPresidePeopleDataSet.newRecord();
					rd.set("cardType",cardTypeValue);
					rd.set("idCard",idCardValue);
					rd.set("sex",getSexByCode(idCardValue));
					rd.set("birthday",getBirthByCode(idCardValue));
				}
			});
			var winPresidePeopleDataSet = L5.DatasetMgr.lookup("winPresidePeopleDataSet");
			var record = winPresidePeopleDataSet.getCurrent();
			//回填性别
			record.set("sex",getSexByCode(idCardValue));
			//回填出生年月
			record.set("birthday",getBirthByCode(idCardValue));
		}else{
			L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
			return;
		}
	}else{
		var cardTypeValue = _$("cardType_add");
		var idCardValue = _$("idCard_add").toUpperCase();
		var winPeopleDataSet = L5.DatasetMgr.lookup("winPeopleDataSet2");
		winPeopleDataSet.setParameter("CARD_TYPE@=",cardTypeValue);
		winPeopleDataSet.setParameter("ID_CARD@=",idCardValue);
		winPeopleDataSet.load();
		winPeopleDataSet.on("load",function(ds){
			if(ds.getCount() != 0){
				var winMemberDataSet = L5.DatasetMgr.lookup("winMemberDataSet2");
				winMemberDataSet.removeAll();
				var win = L5.getCmp("win_peopleValidate2");
				win.show();
			}else{
				var winPresidePeopleDataSet = L5.DatasetMgr.lookup("winPresidePeopleDataSet");
				winPresidePeopleDataSet.removeAll();
				var rd = winPresidePeopleDataSet.newRecord();
				rd.set("cardType",cardTypeValue);
				rd.set("idCard",idCardValue);
			}
		});
	}
}
function validateSorgCode(){
	$("name").innerHTML = "";
	$("mainSorgId").value = "";
	$("cnName").value = "";
	var mainSorgCode = _$("mainSorgCode");
	if(mainSorgCode.trim() == ""){
		return;
	}
	var somMainOrganDataSet = L5.DatasetMgr.lookup("somMainOrganDataSet");
	somMainOrganDataSet.setParameter("SORG_TYPE@=","S");
	somMainOrganDataSet.setParameter("SORG_CODE@=",mainSorgCode);
	somMainOrganDataSet.load();
	somMainOrganDataSet.on("load",function(ds){
		if(ds.getCount() == 0){
			L5.Msg.alert("提示","输入的社会团体登记证号不存在!");
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
		$("mainSorgId").value = ds.get("sorgId");
		$("mainSorgCode").value = ds.get("sorgCode");
		$("cnName").value = ds.get("cnName");
	});
}
//------------------负责人处理------------------------------
var dutyId='';
//增加负责人按钮
function add(){
	updateRecord='';
	if(!isOnly){
		L5.Msg.alert("提示","只能新增一位分支机构负责人!");
		return;
	}
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomDutyCmd");
	command.afterExecute=function(){
		dutyId = command.getReturn('dutyId');
		somDutyInsertDataSet.removeAll();
		somDutyInsertDataSet.newRecord({"dutyId":dutyId,"ifLegal":"0","sorgType":"S","regStatus":"1","taskCode":taskCode});
		var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
		//把负责人任职时间回填页面上的成立时间
		somDutyInsertDataSet.set("startDate",_$("startDate"));
		somPeopleElectronicDataSet_load(fileCode,dutyId);//同步负责人法律要件
		somResumeInsertDataSet.removeAll();
		var win=L5.getCmp("peopleWin");
		win.show();
	}
	command.execute('getDutyId');
}

//点击更新一条负责人
var updateRecord;
function update(){
	var grid=L5.getCmp("peopleGrid");
	updateRecord=grid.getSelectionModel().getSelected();
	if(!updateRecord){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	dutyId=updateRecord.get('dutyId');
	somDutyInsertDataSet.removeAll();
	somDutyInsertDataSet.insert(0,updateRecord.copy());

	//处理个人简历
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeInsertDataSet.removeAll();
	var j=0;
	for(var i=somResumeDataSet.getCount()-1;i>=0;i--){
		var somResumeRecord =somResumeDataSet.getAt(i);
		if(updateRecord.get('dutyId')==somResumeRecord.get('dutyId')){
			somResumeInsertDataSet.insert(j,somResumeRecord);
			j++;
		}
	}
	//处理个人简历完成
	somPeopleElectronicDataSet_load(fileCode,dutyId);//同步负责人法律要件
	var win = L5.getCmp("peopleWin");
	win.show();
	$("age").innerHTML = getAgeByCode(updateRecord.get('idCard'));
}
var isOnly = true;//判断是否已经添加了负责人
var peopleId=0;
var resumeCount=0;
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
			isOnly = true;
		}
		else return;
	}
	);
		}else{
			L5.Msg.alert("提示","请选择一条记录！");
		}
}

///点击确定 保存一条负责人信息
function confirm(){
	var somDutyInsertDataSet = L5.DatasetMgr.lookup("somDutyInsertDataSet");
	//校验
	var somDutyInsertValidate = somDutyInsertDataSet.isValidate();
	if(somDutyInsertValidate != true){
		L5.Msg.alert("提示",somDutyInsertValidate);
		return false;
	}
	var record=somDutyInsertDataSet.getCurrent();
	//邮编
	var postCode=record.get("postCode");
	if(postCode!=""&&_isPostCode(postCode) != true){
		L5.Msg.alert("提示","校验未通过："+"邮编格式不正确");
		return;
	}
	record.set("ifServe","1");
	record.set("promiseOrgan",document.getElementById('promiseOrgan_add').value);
	record.set("promiseCode",document.getElementById('promiseCode_add').value);
	if(updateRecord != ""){
		somDutyDataSet.remove(updateRecord);
	}
	somDutyDataSet.insert(somDutyDataSet.getCount(),record);
	somDutyDataSet.commitChanges();
	//处理个人简历
	var somResumeDataSet = L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeInsertDataSet = L5.DatasetMgr.lookup("somResumeInsertDataSet");
	for(var i=somResumeInsertDataSet.getCount()-1;i>=0;i--){
		var somResumeInsertRecord =somResumeInsertDataSet.getAt(i);
		if(somResumeDataSet.indexOf(somResumeInsertRecord)==-1){
			somResumeDataSet.insert(resumeCount,somResumeInsertRecord);
			resumeCount++;
		    somResumeDataSet.commitChanges();
		}
	}
	//处理个人简历完成
	var win=L5.getCmp("peopleWin");
	win.hide();
	updateRecord='';
	isOnly = false;
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
	var newRecord = somDutyInsertDataSet.getCurrent();
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
	var win = L5.getCmp("win_peopleValidate");
	win.hide();

}
//关闭窗口
function closeItem(){
	var win = L5.getCmp("win_peopleValidate");
	win.hide();
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
//负责人窗户关闭
function winClosePeople(){
	var win = L5.getCmp("peopleWin");
	win.hide();
}
// 增加个人简历
function addResume(){
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	somResumeInsertDataSet.newRecord({"dutyId":dutyId});
}
// 删除个人简历
function delResume(){
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var record=somResumeInsertDataSet.getCurrent();
	if(record!=null){
		somResumeInsertDataSet.remove(record);
		somResumeDataSet.remove(record);
	}
}
function renderDate(value) {
	if(value.length>8){
		L5.Msg.alert("提示","日期不要超过8位,请检查！");
		return value;
	}
	return value;
}
function closePeopleWIn(){
	var win = L5.getCmp("peopleWin");
	win.hide();
}
//保存
function saveApply(){
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	if(somApplyDataSetIsValidate != true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tab").setActiveTab("2");
		return false;
	}
	//业务意见
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupBranchBuildCmd");
	var somApplyRecord = somApplyDataSet.getCurrent();
	if(act=="watch"){
		somApplyRecord.set("prospectAttendPeople",_$("prospectAttendPeople"));
		somApplyRecord.set("prospectPlace",_$("prospectPlace"));
		somApplyRecord.set("prospectDate",_$("prospectDate"));
	}
	command.setParameter("somApplyRecord",somApplyRecord);
	//保存
	command.execute("updateApply");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			goBack();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//保存并提交
function send(){
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	if(somApplyDataSetIsValidate != true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tab").setActiveTab("2");
		return false;
	}
	if(act=="issue"){
		if(fetchPeople=='' || fetchDate==''||fetchPhone==''){
			L5.Msg.alert("提示","请先填写领证信息！");
			return false;
		}
	}
	//业务意见
	var command = new L5.Command("com.inspur.cams.sorg.apply.group.cmd.GroupBranchBuildCmd");
	var somApplyRecord = somApplyDataSet.getCurrent();
	if(act=="watch"){
		somApplyRecord.set("prospectAttendPeople",_$("prospectAttendPeople"));
		somApplyRecord.set("prospectPlace",_$("prospectPlace"));
		somApplyRecord.set("prospectDate",_$("prospectDate"));
	}
	command.setParameter("fetchPeople", fetchPeople);
	command.setParameter("fetchDate", fetchDate);
	command.setParameter("fetchPhone", fetchPhone);
	command.setParameter("somApplyRecord",somApplyRecord);
	//保存并提交
	command.execute("send");
	if (!command.error) {
		if(act=='issue' || end){//是发证环节流程结束
			L5.Msg.alert("提示","成功结束流程!",function(){
				goBack();
			});
		}else{
			L5.Msg.alert("提示","成功提交至下一环节!",function(){
			if(act == 'audit'){
			if(somApplyRecord.get("curOpinionId")=="1"){ //同意-批准通过-根据taskCode更改外网业务状态
				updateOnlineStatusPass(somApplyRecord.get("taskCode"));
			}
			if(somApplyRecord.get("curOpinionId")=="0"){ //不同意-批准不通过-根据taskCode更改外网业务状态
				updateOnlineStatusNoPass(somApplyRecord.get("taskCode"));
			}
		}

				goBack();
			});
		}
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
//校验登记证号是否重复
function sorgCodeUK(){
	if(_$("branchSorgCode").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("sorgCode",_$("branchSorgCode"));
		command.setParameter("sorgType","S");
		command.execute("sorgCodeUK");
		sorgCodeNum = command.getReturn("sorgCodeNum");
		if(sorgCodeNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的分支/代表机构登记证号已存在");
			return;
		}
	}
}
//打印名称核准通知书
function printInform(){

}