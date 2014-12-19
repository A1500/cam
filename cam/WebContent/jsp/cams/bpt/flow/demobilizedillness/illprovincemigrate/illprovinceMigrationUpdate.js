function init(){ 
	var ProvinceMigrationDataSet = L5.DatasetMgr.lookup("ProvinceMigrationDataSet");
	ProvinceMigrationDataSet.setParameter("APPLY_ID",applyId);
	ProvinceMigrationDataSet.load();
	L5.QuickTips.init();
}

function save(){

	//校验身份证号是否为空
	var idCard = _$("idCard");
	if(idCard ==''){
		L5.Msg.alert('提示',"身份证号不能为空!");
		return false;
	}
	//校验迁入地民政局是否为空
	var ingoingAddress = _$("ingoingName");
	if(ingoingAddress==''){
		L5.Msg.alert('提示',"迁入地民政局不能为空!");
		return false;
	}
	//校验残疾抚恤金已发至是否为空
	var allowanceMonth = _$("allowanceMonth");
	if(allowanceMonth==''){
		L5.Msg.alert('提示',"带病回乡抚恤金已发至不能为空!");
		return false;
	}
	if(allowanceMonth!=''&&!validateDateFormat(allowanceMonth+'-01')){
		L5.Msg.alert("提示","带病回乡抚恤金已发至格式不正确！");
		return false;
	}
	var domicode = _$("domicileCode");
	if(domicode == '') {
		L5.Msg.alert('提示',"户口薄(行政区划)不能为空!");
		return false;
	}
	
	var apanageCode = _$("apanageCode");
	if(apanageCode == '') {
		L5.Msg.alert('提示',"实际居住(行政区划)不能为空!");
		return false;
	}

	var IllEmigratDataset = L5.DatasetMgr.lookup("ProvinceMigrationDataSet");
	var IllEmigratRecord=IllEmigratDataset.getCurrent();
	IllEmigratRecord.set("peopleId",document.getElementById("peopleId").value);
	IllEmigratRecord.set("serviceType","47");
	IllEmigratRecord.set("applyId",document.getElementById("applyId").value);
	IllEmigratRecord.set("allowanceMonth",document.getElementById("allowanceMonth").value);
	IllEmigratRecord.set("ingoingCode",document.getElementById("ingoingCode").value);
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
	command.setParameter("record", IllEmigratRecord);
	command.execute("update");
	if (!command.error) {
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function func_Close(){
	window.close();
}
function detail(value){
	if(value!=''){
		var peopleId = ProvinceMigrationDataSet.getCurrent().get("peopleId");
		var familyId = ProvinceMigrationDataSet.getCurrent().get("familyId");
		var url='../assessdisability/disabilityDetailManage.jsp?peopleId='+peopleId+'&familyId='+familyId;
		return "<a href='#' style='color:blue' onclick='openWindow(\""+url+"\")'>"+value+"</a>";
	}
}

function openWindow(url){
        var width = 800;
		var height = 500;
		var win =window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		if (win == null) {
			return;
		}
}
