

function save(){

	var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
	var DisabilityApproveRecord=DisabilityApproveDataset.getCurrent();
	DisabilityApproveRecord.set("peopleId",document.getElementById("peopleId").value);
	//迁入地民政局是否为空

	var ingoingAddress = _$("ingoingAddress");
	if(ingoingAddress==''){
		L5.Msg.alert('提示',"/迁入地民政局不能为空!");
		return false;
	}
		//在乡复员抚恤金已发至是否为空

	var allowanceMonth = _$("allowanceMonth");
	if(allowanceMonth==''){
		L5.Msg.alert('提示',"在乡复员抚恤金已发至不能为空!");
		return false;
	}
	if(allowanceMonth!=''&&!validateDateFormat(allowanceMonth+"-01")){
		L5.Msg.alert("提示","在乡复员抚恤金已发至格式不正确！");
		return false;
	}
	var isValidate = DisabilityApproveDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationCommand");
	command.setParameter("record", DisabilityApproveRecord);
	command.setParameter("applyId",applyId);
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
	var revalue =  window.showModalDialog("idCardSelect.jsp","","dialogHeight:400px;dialogWidth:878px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var idCard = revalue;
		document.getElementById("idCard").value = idCard;
		
		DisabilityApproveDataset.getCurrent().set("idCard",idCard);
		queryByIdCard();
	}
}

//根据身份证号查询人员信息和伤残信息
function queryByIdCard(){
	var idCard = document.getElementById("idCard").value;
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDemobilizedCommand");
	command.setParameter("ID_CARD", idCard);
	command.execute("queryByIdCard");
	
	if(command.getReturn("name") !=undefined){
		
		if(command.getReturn("conscriptDate") !=undefined){
				DisabilityApproveDataset.set("conscriptDate",command.getReturn("conscriptDate"));
		}else{
			L5.Msg.alert('提示','该人员并在乡复员人员！');
		}
		
		DisabilityApproveDataset.set("name",command.getReturn("name"));
		DisabilityApproveDataset.set("peopleId",command.getReturn("peopleId"));
		DisabilityApproveDataset.set("familyId",command.getReturn("familyId"));
		document.getElementById("peopleId").value = command.getReturn("peopleId");
		document.getElementById("familyId").value = command.getReturn("familyId");
		
			if(command.getReturn("sex") !=undefined){
				DisabilityApproveDataset.set("sex",command.getReturn("sex"));
			}
			if(command.getReturn("nation") !=undefined){
				DisabilityApproveDataset.set("nation",command.getReturn("nation"));
			}
			if(command.getReturn("birthday") !=undefined){
				DisabilityApproveDataset.set("birthday",command.getReturn("birthday"));
			}
			if(command.getReturn("address") !=undefined){
				DisabilityApproveDataset.set("address",command.getReturn("address"));
			}
			if(command.getReturn("apanageName") !=undefined){
				DisabilityApproveDataset.set("apanageName",command.getReturn("apanageName"));
			}
			if(command.getReturn("veteransDate") !=undefined){
				DisabilityApproveDataset.set("veteransDate",command.getReturn("veteransDate"));
			}
			
			if(command.getReturn("demobilizedNo") !=undefined){
				DisabilityApproveDataset.set("demobilizedNo",command.getReturn("demobilizedNo"));
				}
		    if(command.getReturn("isKoeanwar") !=undefined){
				DisabilityApproveDataset.set("isKoeanwar",command.getReturn("isKoeanwar"));
				}			
			if(command.getReturn("decruitmentDate") !=undefined){
				DisabilityApproveDataset.set("decruitmentDate",command.getReturn("decruitmentDate"));
					}		
			if(command.getReturn("position") !=undefined){
				DisabilityApproveDataset.set("position",command.getReturn("position"));
					}		
			if(command.getReturn("belongDate") !=undefined){
				DisabilityApproveDataset.set("belongDate",command.getReturn("belongDate"));
				}
			
	}else{
		L5.Msg.alert('提示','该人员未录入系统！');
		document.getElementById("idCard").value = "";
		return false;
	}
}
function getCodeAndName(){
		var ingoingCode = _$("ingoingCode");
		var ingoingAddress = _$("ingoingAddress");
		var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicPubCant.jsp?organCode=CN&organName=中国","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
			 DisabilityApproveDataset.getCurrent().set("ingoingCode",list[0]);
			 DisabilityApproveDataset.getCurrent().set("ingoingAddress",list[1]);
		}
}