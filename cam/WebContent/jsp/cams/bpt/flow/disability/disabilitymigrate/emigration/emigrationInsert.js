function init(){
	var DisabilityEmigratDataset = L5.DatasetMgr.lookup("DisabilityEmigratDataset");
	DisabilityEmigratDataset.newRecord();
	L5.QuickTips.init();
}

function save(){
	//校验身份证号是否为空
	var idCard = _$("idCard");
	if(idCard ==''){
		L5.Msg.alert('提示',"身份证号不能为空!");
		return false;
	}
	if(!checkIDCard($("idCard"))){
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
	var DisabilityEmigratDataset = L5.DatasetMgr.lookup("DisabilityEmigratDataset");
	var DisabilityEmigratRecord=DisabilityEmigratDataset.getCurrent();
	DisabilityEmigratRecord.set("peopleId",document.getElementById("peopleId").value);
	var disabilityTypeCode = _$("disabilityTypeCode");
	DisabilityEmigratRecord.set("serviceType","19");
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationCommand");
	command.setParameter("record", DisabilityEmigratRecord);
	command.execute("insert");
	if (!command.error) {
		var applyId = command.getReturn("applyId");
	var peopleId = DisabilityEmigratRecord.get("peopleId");
	var familyId =DisabilityEmigratRecord.get("familyId");
	//var url="emigrationUpdate.jsp?applyId="  + applyId+"&peopleId="+peopleId+"&familyId="+familyId;
	//var width = screen.width-100;
	//var height = screen.height-120;
	//var returnValue = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	window.returnValue=applyId+";"+peopleId+";"+familyId+";19";
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
		var peopleId = DisabilityEmigratDataset.getCurrent().get("peopleId");
		var familyId = DisabilityEmigratDataset.getCurrent().get("familyId");
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
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		var idCard = list[0];
		var peopleId = list[1];
		if(idCard!=''&&peopleId!=''){
			document.getElementById("idCard").value = idCard;
			document.getElementById("peopleId").value = peopleId;
			DisabilityEmigratDataset.getCurrent().set("idCard",idCard);
			DisabilityEmigratDataset.getCurrent().set("peopleId",peopleId);
			queryByPeopleId();
		}else{ 
			$("idCard").value='';
			$("peopleId").value='';
			$("familyId").value='';
			document.getElementById("name").innerHTML='';
			document.getElementById("disabilityTypeCode").innerHTML='';
			document.getElementById("sex").innerHTML='';
			document.getElementById("disabilityCaseCode").innerHTML='';
			document.getElementById("disabilityLevelCode").innerHTML='';
			document.getElementById("disabilityNo").innerHTML='';
		}
	}
}

//根据人员ID查询人员信息和伤残信息
function queryByPeopleId(){
	var peopleId = document.getElementById("peopleId").value;
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
	command.setParameter("PEOPLE_ID", peopleId);
	command.execute("queryDataSetByPeopleId");
	
		DisabilityEmigratDataset.set("disabilityLevelCode",command.getReturn("disabilityLevelCode"));
		DisabilityEmigratDataset.set("name",command.getReturn("name"));
		DisabilityEmigratDataset.set("familyId",command.getReturn("familyId"));
		document.getElementById("familyId").value = command.getReturn("familyId");
		DisabilityEmigratDataset.set("disabilityTypeCode",command.getReturn("disabilityTypeCode"));
		document.getElementById("disabilityTypeCode").value = command.getReturn("disabilityTypeCode");
		DisabilityEmigratDataset.set("sex",command.getReturn("sex"));
			if(command.getReturn("disabilityCaseCode") !=undefined){
				DisabilityEmigratDataset.set("disabilityCaseCode",command.getReturn("disabilityCaseCode"));
			}
			if(command.getReturn("disabilityNo") !=undefined){
				DisabilityEmigratDataset.set("disabilityNo",command.getReturn("disabilityNo"));
			}
}
 function getCodeAndName(){
		var ingoingCode = _$("ingoingCode");
		var ingoingAddress = _$("ingoingAddress");
		var escapeorganName = escape(encodeURIComponent('中国'));
		var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicPubCant.jsp?organCode=CN&organName="+escapeorganName,"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
			 DisabilityEmigratDataset.getCurrent().set("ingoingCode",list[0]);
			 DisabilityEmigratDataset.getCurrent().set("ingoingAddress",list[1]);
		}
}

/**
* 根据idcard查询伤残详细信息
**/
function queryDisbilityByIdCard(obj) {
	var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityEmigratDataset");
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
		}
	});
}
 