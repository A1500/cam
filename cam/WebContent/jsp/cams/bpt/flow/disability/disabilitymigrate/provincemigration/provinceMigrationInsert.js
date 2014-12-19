var idCardvalue;
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
	
	var ProvinceMigrationDataSet = L5.DatasetMgr.lookup("ProvinceMigrationDataSet");
	var ProvinceMigratRecord=ProvinceMigrationDataSet.getCurrent();
	ProvinceMigratRecord.set("peopleId",document.getElementById("peopleId").value);
	var disabilityTypeCode = _$("disabilityTypeCode");
	ProvinceMigratRecord.set("serviceType","16");
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
	command.setParameter("record", ProvinceMigratRecord);
	command.execute("insert");
	var applyId = command.getReturn("applyId");
	var peopleId = document.getElementById("peopleId").value;
	var familyId = document.getElementById("familyId").value;
	if (!command.error) {
		var approveForm = L5.get("approveForm");
		approveForm.dom.reset();
		document.getElementById("name").innerHTML='';
		document.getElementById("sex").innerHTML='';
		document.getElementById("disabilityTypeCode").innerHTML='';
		document.getElementById("disabilityCaseCode").innerHTML='';
		document.getElementById("disabilityLevelCode").innerHTML='';
		document.getElementById("disabilityNo").innerHTML='';
	var width = screen.width-100;
    var height = screen.height-140;
	//var url = "provinceMigrationUpdate.jsp?peopleId="+peopleId+"&familyId="+familyId+"&applyId="+applyId;
 	//window.showModalDialog(url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	init();
	window.returnValue=applyId+";"+peopleId+";"+familyId+";16";
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
	var width = screen.width -100;
	var height = screen.height-140;
	var url = L5.webPath + "/jsp/cams/bpt/flow/disability/common/idCardSelect.jsp";
	var revalue =  window.showModalDialog(url,"","dialogHeight:"+height+"px;dialogWidth:"+width+"px;resizable:no;scroll:yes;");
	if(revalue!=";;;;;;;"&&revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		var idCard = list[0];
		var peopleId = list[1];
		document.getElementById("idCard").value = idCard;
		document.getElementById("peopleId").value = peopleId;
		ProvinceMigrationDataSet.getCurrent().set("idCard",idCard);
		ProvinceMigrationDataSet.getCurrent().set("peopleId",peopleId);
		queryByPeopleId();
	}else if(revalue==";;;;;;;"){
		ProvinceMigrationDataSet.removeAll();
		ProvinceMigrationDataSet.newRecord();
		document.getElementById("sex").innerHTML="";
		document.getElementById("disabilityTypeCode").innerHTML="";
		document.getElementById("disabilityCaseCode").innerHTML="";
		document.getElementById("disabilityLevelCode").innerHTML="";
	}
}

//根据人员ID查询人员信息和伤残信息
function queryByPeopleId(){
	var peopleId = document.getElementById("peopleId").value;
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
	command.setParameter("PEOPLE_ID", peopleId);
	command.execute("queryDataSetByPeopleId");
		ProvinceMigrationDataSet.set("disabilityLevelCode",command.getReturn("disabilityLevelCode"));
		ProvinceMigrationDataSet.set("name",command.getReturn("name"));
		ProvinceMigrationDataSet.set("familyId",command.getReturn("familyId"));
		document.getElementById("familyId").value = command.getReturn("familyId");
		ProvinceMigrationDataSet.set("disabilityTypeCode",command.getReturn("disabilityTypeCode"));
		document.getElementById("disabilityTypeCode").value = command.getReturn("disabilityTypeCode");
			if(command.getReturn("sex") !=undefined){
				ProvinceMigrationDataSet.set("sex",command.getReturn("sex"));
			}
			if(command.getReturn("disabilityCaseCode") !=undefined){
				ProvinceMigrationDataSet.set("disabilityCaseCode",command.getReturn("disabilityCaseCode"));
			}
			if(command.getReturn("disabilityNo") !=undefined){
				ProvinceMigrationDataSet.set("disabilityNo",command.getReturn("disabilityNo"));
			}
}


/**
* 根据idcard查询伤残详细信息
**/
function queryDisbilityByIdCardPro(obj) { 
	if(obj.value==""){
		return;
	}else{
		if(idCardvalue==obj.value){
			return;
		}else{
			idCardvalue = obj.value;
			var DisabilityApproveDataset = L5.DatasetMgr.lookup("ProvinceMigrationDataSet");
			if(!checkIDCard(obj)){
			    L5.Msg.alert("提示", "身份证格式不正确!");
			    return false;
			}
			DisabilityApproveDataset.setParameter("idCard",obj.value);
			DisabilityApproveDataset.load();
			DisabilityApproveDataset.on("load",function func() {
				if(DisabilityApproveDataset.getCount() == 0) {
					DisabilityApproveDataset.newRecord();
					L5.Msg.alert("提示", "该人员不是伤残人员!");
				} else {
					DisabilityApproveDataset.set("domicileName","");
					DisabilityApproveDataset.set("apanageName","")
				}
			});
		}
	}
}
 
