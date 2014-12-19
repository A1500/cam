function init(){
	var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	BaseinfoPeopleDataSet.newRecord();
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
	var ingoingAddress = _$("ingoingAddress");
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
		L5.Msg.alert("提示","残疾抚恤金已发至格式不正确！");
		return false;
	}
	var record=BaseinfoPeopleDataSet.getCurrent();
	record.set("peopleId",document.getElementById("peopleId").value);
	record.set("serviceType","65");
	
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationCommand");
	command.setParameter("record", record);
	command.execute("insert");
	if (!command.error) {
		init();
		document.getElementById("sex").innerHTML="";
		document.getElementById("testedType").innerHTML="";
		var peopleId=record.get("peopleId");
		var familyId=record.get("familyId");
		var applyId=command.getReturn("applyId");
	/*	var url="emigrationUpdateManage.jsp?applyId=" + applyId+"&peopleId="+peopleId+"&familyId="+familyId;
		var width = screen.width-100;
	 	var height = screen.height-120;
	 	var returnValue = window.showModalDialog(url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	*/
	window.returnValue=applyId+";"+peopleId+";"+familyId+";65";
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
	var url = L5.webPath + "/jsp/cams/bpt/flow/tested/comm/idCardSelect.jsp";
	var revalue =  window.showModalDialog(url,"","dialogHeight:"+height+"px;dialogWidth:"+width+"px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(":");
		var idCard = list[0];
		var peopleId = list[1];
		BaseinfoPeopleDataSet.getCurrent().set("idCard",idCard);
		queryByIdCard(peopleId);
	}else{
		$("idCard").value="";
		$("peopleId").value="";
		$("familyId").value="";
		var a= document.getElementsByTagName('label');
		for(var i=0;i<a.length;i++){
			document.getElementsByTagName('label')[i].innerHTML='';
		}
	}
	
}

//根据身份证号查询人员信息和伤残信息
function queryByIdCard(peopleId){
	var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
	BaseinfoPeopleDataSet.setParameter("PEOPLE_ID",peopleId);
	BaseinfoPeopleDataSet.load();
	BaseinfoPeopleDataSet.on("datachanged",func);
}

function func(BaseinfoPeopleDataSet) {
	if(BaseinfoPeopleDataSet.getAllRecords().length == 0) {
		L5.Msg.alert('提示','该人员并非参试人员，请在【参试人员身份认定】中录入其信息！');
		$("idCard").value="";
		$("peopleId").value="";
		$("familyId").value="";
		var a= document.getElementsByTagName('label');
		for(var i=0;i<a.length;i++){
			document.getElementsByTagName('label')[i].innerHTML='';
		}
		BaseinfoPeopleDataSet.newRecord();
	} else {
		document.getElementById("peopleId").value=BaseinfoPeopleDataSet.get("peopleId");
	}
}
  function getCodeAndName(){
		var ingoingCode = _$("ingoingCode");
		var ingoingAddress = _$("ingoingAddress");
		var escapeorganName = escape(encodeURIComponent('中国'));
		var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicPubCant.jsp?organCode=CN&organName="+escapeorganName,"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
			 BaseinfoPeopleDataSet.getCurrent().set("ingoingCode",list[0]);
			 BaseinfoPeopleDataSet.getCurrent().set("ingoingAddress",list[1]);
		}
}