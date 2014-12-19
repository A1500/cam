function init(){
	var jcmPeopleInfoDataSet=L5.DatasetMgr.lookup("jcmPeopleInfoDataSet");
	var jcmPeopleResumeDataSet=L5.DatasetMgr.lookup("jcmPeopleResumeDataSet");
	var jcmPeopleCompanyDataSet=L5.DatasetMgr.lookup("jcmPeopleCompanyDataSet");
	var jcmPeopleExamDataSet=L5.DatasetMgr.lookup("jcmPeopleExamDataSet");
	if(method=="insert"){
		jcmPeopleInfoDataSet.newRecord({"peopleId":peopleId,"companyId":companyId});
	}else{
		jcmPeopleInfoDataSet.setParameter("PEOPLE_ID@=",peopleId);
		jcmPeopleInfoDataSet.load();
		jcmPeopleResumeDataSet.setParameter("PEOPLE_ID@=",peopleId);
		jcmPeopleResumeDataSet.load();
		jcmPeopleCompanyDataSet.setParameter("PEOPLE_ID@=",peopleId);
		jcmPeopleCompanyDataSet.load();
		jcmPeopleExamDataSet.setParameter("PEOPLE_ID@=",peopleId);
		jcmPeopleExamDataSet.load();
	}
}
function save(){
	var jcmPeopleInfoDataSet=L5.DatasetMgr.lookup("jcmPeopleInfoDataSet");
	var resumeDs=L5.DatasetMgr.lookup("jcmPeopleResumeDataSet");
	var companyDs=L5.DatasetMgr.lookup("jcmPeopleCompanyDataSet");
	var examDs=L5.DatasetMgr.lookup("jcmPeopleExamDataSet");
	
	
	var valid=jcmPeopleInfoDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	
	var record=jcmPeopleInfoDataSet.getCurrent();
	var resumeRecords = resumeDs.getAllChangedRecords();
	var companyRecords = companyDs.getAllChangedRecords();
	var examRecords = examDs.getAllChangedRecords();
	
	var command=new L5.Command("com.inspur.cams.jcm.cmd.JcmPeopleInfoCmd");
	command.setParameter("record",record);
	command.setParameter("resumeRecords",resumeRecords);
	command.setParameter("companyRecords",companyRecords);
	command.setParameter("examRecords",examRecords);
	command.execute("save");
	if (!command.error){
		var parentWin = window.parent.window;
		var tree = parentWin.L5.getCmp("companytree");
		if(method == "insert"){
			var node = tree.getNodeByRecordId(companyId, "cityRecord");
			var rec = new parentWin.L5.tree.TreeRecord.recordTypes["userRecord"](jcmPeopleInfoDataSet.getCurrent().data, jcmPeopleInfoDataSet.getCurrent().get("peopleId"));
			node.record.insert(rec);
		}else{
			var node = tree.getNodeByRecordId(jcmPeopleInfoDataSet.getCurrent().get("peopleId"), "userRecord");
			node.record.set("peopleName", jcmPeopleInfoDataSet.getCurrent().get("peopleName"));
			node.record.commit();
		}
		L5.Msg.alert("提示","保存成功！",function(){
			//returnBack();
		});
	}else{
		L5.Msg.alert("提示","保存出错！"+command.error);
	}
}

function query(){
	var jcmPeopleExamDataSet=L5.DatasetMgr.lookup("jcmPeopleExamDataSet");
	
	jcmPeopleExamDataSet.load();
}

/********************人员简历信息********************/
function insertResume(){
	var resumeDs=L5.DatasetMgr.lookup("jcmPeopleResumeDataSet");
	var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
	command.setParameter("IdHelp","Id32");
	command.execute("execute");
	var resumeId = command.getReturn("id");
	resumeDs.newRecord({"resumeId":resumeId,"peopleId":peopleId});
}

function delResume(){
	var grid=L5.getCmp("resumeGrid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var jcmPeopleResumeDataSet=L5.DatasetMgr.lookup("jcmPeopleResumeDataSet");
	jcmPeopleResumeDataSet.remove(records[0]);
}
/********************人员工作单位信息********************/
function insertCompany(){
//	var companyDs=L5.DatasetMgr.lookup("jcmPeopleCompanyDataSet");
//	var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
//	command.setParameter("IdHelp","Id32");
//	command.execute("execute");
//	var companyId = command.getReturn("id");
//	companyDs.newRecord({"peopleCompanyId":companyId,"peopleId":peopleId});

	var url = "jcmPeopleCompanyEdit.jsp?method=insert&peopleCompanyId="+peopleId;
	var width = screen.availWidth;
    var height = screen.availHeight;
	var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
	if(true || returnValue) {
		//reQuery();
	}
}

function delCompany(){
	var grid=L5.getCmp("companyGrid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var jcmPeopleCompanyDataSet=L5.DatasetMgr.lookup("jcmPeopleCompanyDataSet");
	jcmPeopleCompanyDataSet.remove(records[0]);
}

/********************人员培训信息********************/
function insertExam(){
	var examDs=L5.DatasetMgr.lookup("jcmPeopleExamDataSet");
	var command=new L5.Command("com.inspur.cams.comm.util.IdHelpCmd");
	command.setParameter("IdHelp","Id32");
	command.execute("execute");
	var examId = command.getReturn("id");
	examDs.newRecord({"peopleExamId":examId,"peopleId":peopleId});
}

function delExam(){
	var grid=L5.getCmp("examGrid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var examDs=L5.DatasetMgr.lookup("jcmPeopleExamDataSet");
	examDs.remove(records[0]);
}

//选中上传图片
function selectImg() {
	document.getElementById("img").src = document.getElementById("idFile").value;
}
function floatFile() {
	document.getElementById("idFile").style.posTop = event.srcElement.offsetTop;
	document.getElementById("idFile").style.posLeft = event.x - document.getElementById("idFile").offsetWidth / 2;
} 

function returnBack(){
	history.go(-1);
}