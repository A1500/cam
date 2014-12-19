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
	var ingoingName = _$("ingoingName");
	if(ingoingName==''){
		L5.Msg.alert('提示',"迁入地民政局不能为空!");
		return false;
	}
	//校验抚恤金已发至是否为空
	var allowanceMonth = _$("allowanceMonth");
	if(allowanceMonth==''){
		L5.Msg.alert('提示',"抚恤金已发至不能为空!");
		return false;
	}
	if(allowanceMonth!=''&&!validateDateFormat(allowanceMonth+'-01')){
		L5.Msg.alert("提示","抚恤金已发至不正确！");
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
	
	var ProvinceMigrationDataSet = L5.DatasetMgr.lookup("ProvinceMigrationDataSet");
	var ProvinceMigratRecord=ProvinceMigrationDataSet.getCurrent();
	ProvinceMigratRecord.set("peopleId",document.getElementById("peopleId").value);
	ProvinceMigratRecord.set("serviceType","53");
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
	command.setParameter("record", ProvinceMigratRecord);
	command.execute("insert");
	var peopleId = document.getElementById("peopleId").value;
	var familyId = document.getElementById("familyId").value;
	if (!command.error) {
		L5.Msg.alert('提示',"数据保存成功!");
		var approveForm = L5.get("approveForm");
		approveForm.dom.reset();
		document.getElementById("name").innerHTML='';
		document.getElementById("sex").innerHTML='';
		document.getElementById("warTypeCode").innerHTML='';
		document.getElementById("forcesNo").innerHTML='';
		document.getElementById("position").innerHTML='';
		document.getElementById("asdpNo").innerHTML='';
		var width = screen.width-100;;
		var height = screen.height-120;
		var applyId = command.getReturn("applyId");
		//var url = "provinceUpdateManage.jsp?peopleId="+peopleId+"&familyId="+familyId+"&applyId="+applyId;
	 	//	window.showModalDialog(url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		window.returnValue=applyId+";"+peopleId+";"+familyId+";53"; 
		window.close();
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

//通过伤残人员查询窗口取得IdCard&查询相关信息
function getIdCard(){
	var width = screen.width-100;
    var height = screen.height-140;
	var url = L5.webPath + "/jsp/cams/bpt/flow/war/migrate/provincialmigration/idCardSelect.jsp";
	var revalue =  window.showModalDialog(url,"","dialogHeight:"+height+"px;dialogWidth:"+width+"px;resizable:no;scroll:yes;");
	if(revalue==";;;;;;;"){
		ProvinceMigrationDataSet.removeAll();
		ProvinceMigrationDataSet.newRecord();
		document.getElementById("warTypeCode").innerHTML="";
		document.getElementById("sex").innerHTML="";
	}else if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(":");
		var idCard = list[0];
		var peopleId = list[1];
		document.getElementById("idCard").value = idCard;
		ProvinceMigrationDataSet.getCurrent().set("idCard",idCard);
		queryByIdCard(peopleId);
	}
}

//根据身份证号查询人员信息和伤残信息
function queryByIdCard(peopleId){
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
	command.setParameter("peopleId", peopleId);
	command.execute("queryWarMigrateAddPeopleId");
	if(command.getReturn("name") !=undefined){
		
		ProvinceMigrationDataSet.set("name",command.getReturn("name"));
		ProvinceMigrationDataSet.set("peopleId",command.getReturn("peopleId"));
		ProvinceMigrationDataSet.set("familyId",command.getReturn("familyId"));
		document.getElementById("peopleId").value = command.getReturn("peopleId");
		document.getElementById("familyId").value = command.getReturn("familyId");
		ProvinceMigrationDataSet.set("warTypeCode",command.getReturn("warTypeCode"));
		ProvinceMigrationDataSet.set("forcesNo",command.getReturn("forcesNo"));
		
		if(command.getReturn("sex") !=undefined){
			ProvinceMigrationDataSet.set("sex",command.getReturn("sex"));
		}
		if(command.getReturn("position") !=undefined){
			ProvinceMigrationDataSet.set("position",command.getReturn("position"));
		}
		if(command.getReturn("asdpNo") !=undefined){
			ProvinceMigrationDataSet.set("asdpNo",command.getReturn("asdpNo"));
		}
	}else{
		L5.Msg.alert('提示','该人员非参战退役军人！');
		document.getElementById("idCard").value = '';
		return false;
	}
}
