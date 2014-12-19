var familyId;
function init(){
	var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
	DisabilityApproveDataset.newRecord();
	L5.QuickTips.init();
}

function save(){
	var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
	var DisabilityApproveRecord=DisabilityApproveDataset.getCurrent();
	DisabilityApproveRecord.set("peopleId",document.getElementById("peopleId").value);
	
	//校验身份证号是否为空
	var idCard = document.getElementById("idCard");
	if(idCard.value==''){
		L5.Msg.alert('提示',"身份证号不能为空!");
		return false;
	}
	
	if(!checkIDCard(idCard)){
	    L5.Msg.alert("提示", "身份证格式不正确!");
	    return false;
	}
	
	//校验换证、补证原因是否为空
	var exchangeReason = _$("exchangeReason");
	if(exchangeReason==''){
		L5.Msg.alert('提示',"换证、补证或证件变更原因不能为空!");
		return false;
	}
	
	var isValidate = DisabilityApproveDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	var disabilityDate = DisabilityApproveRecord.get("disabilityDate");
	if(disabilityDate!=''&&!validateDateFormat(disabilityDate)){
		L5.Msg.alert("提示","致残时间格式不正确！");
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
	command.setParameter("record", DisabilityApproveRecord);
	command.execute("addExchaCertiDisa");
	var applyId = command.getReturn("applyId");
	if (!command.error) {
		 window.returnValue=document.getElementById("peopleId").value+";"+familyId+";"+applyId;
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
		var peopleId = DisabilityApproveDataset.getCurrent().get("peopleId");
		var familyId = DisabilityApproveDataset.getCurrent().get("familyId");
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
	var url = L5.webPath+"/jsp/cams/bpt/flow/disability/common/idCardSelect.jsp";
	var width = screen.width-100;
    var height = screen.height-140;
 	var revalue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		var idCard = list[0];
		var peopleId = list[1];
		familyId = list[2];
		document.getElementById("idCard").value = idCard;
		document.getElementById("peopleId").value = idCard;
		DisabilityApproveDataset.getCurrent().set("idCard",idCard);
		DisabilityApproveDataset.getCurrent().set("peopleId",peopleId);
		queryByPeopleId();
	}
}

//根据人员ID查询人员信息和伤残信息
function queryByPeopleId(){
	var peopleId = document.getElementById("peopleId").value;
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
	command.setParameter("PEOPLE_ID", peopleId);
	command.execute("queryDataSetByPeopleId");
	
		DisabilityApproveDataset.set("conscriptDate",command.getReturn("conscriptDate"));
		DisabilityApproveDataset.set("name",command.getReturn("name"));
		DisabilityApproveDataset.set("familyId",command.getReturn("familyId"));
		document.getElementById("familyId").value = command.getReturn("familyId");
		DisabilityApproveDataset.set("sex",command.getReturn("sex"));
		DisabilityApproveDataset.set("nation",command.getReturn("nation"));
		DisabilityApproveDataset.set("birthday",command.getReturn("birthday"));
		
			if(command.getReturn("address") !=undefined){
				DisabilityApproveDataset.set("address",command.getReturn("address"));
			}
			if(command.getReturn("apanageName") !=undefined){
				DisabilityApproveDataset.set("apanageName",command.getReturn("apanageName"));
			}
			if(command.getReturn("domicileAddress") !=undefined){
				DisabilityApproveDataset.set("domicileAddress",command.getReturn("domicileAddress"));
			}
			if(command.getReturn("domicileName") !=undefined){
				DisabilityApproveDataset.set("domicileName",command.getReturn("domicileName"));
			}
			if(command.getReturn("veteransDate") !=undefined){
				DisabilityApproveDataset.set("veteransDate",command.getReturn("veteransDate"));
			}
			if(command.getReturn("disabilityGenusCode") !=undefined){
				DisabilityApproveDataset.set("disabilityGenusCode",command.getReturn("disabilityGenusCode"));
			}
			if(command.getReturn("disabilityWarCode") !=undefined){
				DisabilityApproveDataset.set("disabilityWarCode",command.getReturn("disabilityWarCode"));
			}
			if(command.getReturn("uinitOfDisability") !=undefined){
				DisabilityApproveDataset.set("uinitOfDisability",command.getReturn("uinitOfDisability"));
			}
			if(command.getReturn("disabilityCaseCode") !=undefined){
				DisabilityApproveDataset.set("disabilityCaseCode",command.getReturn("disabilityCaseCode"));
			}
			if(command.getReturn("disabilityLevelCode") !=undefined){
				DisabilityApproveDataset.set("disabilityLevelCode",command.getReturn("disabilityLevelCode"));
			}
			if(command.getReturn("approveDate") !=undefined){
				DisabilityApproveDataset.set("approveDate",command.getReturn("approveDate"));
			}
			if(command.getReturn("retiredDate") !=undefined){
				DisabilityApproveDataset.set("retiredDate",command.getReturn("retiredDate"));
			}
			if(command.getReturn("disabilityNo") !=undefined){
				DisabilityApproveDataset.set("disabilityNo",command.getReturn("disabilityNo"));
			}
			if(command.getReturn("disabilityDate") !=undefined){
				DisabilityApproveDataset.set("disabilityDate",command.getReturn("disabilityDate"));
			}
			if(command.getReturn("disabilityAdd") !=undefined){
				DisabilityApproveDataset.set("disabilityAdd",command.getReturn("disabilityAdd"));
			}
			if(command.getReturn("disabilityBody") !=undefined){
				DisabilityApproveDataset.set("disabilityBody",command.getReturn("disabilityBody"));
			}
			if(command.getReturn("disabilityReason") !=undefined){
				DisabilityApproveDataset.set("disabilityReason",command.getReturn("disabilityReason"));
			}
			
}