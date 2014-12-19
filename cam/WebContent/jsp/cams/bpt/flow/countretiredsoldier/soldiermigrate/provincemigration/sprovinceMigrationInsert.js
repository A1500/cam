function init(){
	var ProvinceMigrationDataSet = L5.DatasetMgr.lookup("ProvinceMigrationDataSet");
	ProvinceMigrationDataSet.newRecord();
	L5.QuickTips.init();
}

function save(){
	//校验身份证号是否为空
	var idCard = document.getElementById("idCard");
	if(idCard.value ==''){
		L5.Msg.alert('提示',"身份证号不能为空!");
		return false;
	}
   if(!checkIDCard(idCard)){
	    L5.Msg.alert("提示", "身份证格式不正确!");
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
		L5.Msg.alert('提示',"残疾抚恤金已发至不能为空!");
		return false;
	}
	if(allowanceMonth!=''&&!validateDateFormat(allowanceMonth+'-01')){
		L5.Msg.alert("提示","抚恤金已发至格式不正确！");
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
	
	var record=ProvinceMigrationDataSet.getCurrent();
		record.set("peopleId",document.getElementById("peopleId").value);
		record.set("serviceType","83");
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
		command.setParameter("record", record);
		command.execute("insert");
	var peopleId1 = document.getElementById("peopleId").value;
	var familyId1 = document.getElementById("familyId").value;
	if (!command.error) {
			L5.Msg.alert('提示',"数据保存成功!");
			init();
			document.getElementById("sex").innerHTML="";
		var width = screen.width-100;
		var height = screen.height-120;
		var applyId = command.getReturn("applyId");
		//var url="provinceUpdateManage.jsp?applyId=" + applyId+"&peopleId="+peopleId1+"&familyId="+familyId1;
		//var returnValue = window.showModalDialog(url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		window.returnValue=applyId+";"+peopleId1+";"+familyId1+";83";
		window.close();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function func_Close(){
	window.close();
}


//通过伤残人员查询窗口取得IdCard&查询相关信息
function getIdCard(){
	var width = screen.width-100;
	var height= screen.height-140;
	var url = L5.webPath + "/jsp/cams/bpt/flow/countretiredsoldier/comm/idCardSelect.jsp";
	var revalue =  window.showModalDialog(url,"","dialogHeight:"+height+"px;dialogWidth:"+width+"px;resizable:no;scroll:yes;");
	if(revalue==";;;;;;;"){
		ProvinceMigrationDataSet.removeAll();
		ProvinceMigrationDataSet.newRecord();
		document.getElementById("sex").innerHTML="";
	}else if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(":");
		var idCard = list[0];
		var peopleId = list[1];
		ProvinceMigrationDataSet.getCurrent().set("idCard",idCard);
		queryByIdCard(peopleId);
	}
}

//根据身份证号查询人员信息和伤残信息
function queryByIdCard(peopleId){
	var ProvinceMigrationDataSet = L5.DatasetMgr.lookup("ProvinceMigrationDataSet");
	ProvinceMigrationDataSet.setParameter("PEOPLE_ID",peopleId);
	ProvinceMigrationDataSet.load();
	ProvinceMigrationDataSet.on("datachanged",func);
}

function func(ProvinceMigrationDataSet) {
	if(ProvinceMigrationDataSet.getAllRecords().length == 0) {
		L5.Msg.alert('提示','请录入其信息！');
		ProvinceMigrationDataSet.newRecord();
	} else {
		document.getElementById("peopleId").value=ProvinceMigrationDataSet.get("peopleId");
		ProvinceMigrationDataSet.set("domicileName","");
		ProvinceMigrationDataSet.set("apanageName","");
	}
}

