function init(){

	var DemobilizedIllnessDataset = L5.DatasetMgr.lookup("DemobilizedIllnessDataset");
	DemobilizedIllnessDataset.newRecord();
	//DemobilizedIllnessDataset.load();
//	DemobilizedIllnessDataset.on("load",queryByIdCard);
	document.getElementById("idCard").value=idCard;
	DemobilizedIllnessDataset.set("idCard",idCard);
	document.getElementById("applyId").value=applyId;
	queryByIdCard();
}

function save(){

	var DemobilizedIllnessDataset = L5.DatasetMgr.lookup("DemobilizedIllnessDataset");
	var DemobilizedIllnessRecord=DemobilizedIllnessDataset.getCurrent();
		DemobilizedIllnessRecord.set("peopleId",document.getElementById("peopleId").value);
	//迁入地民政局是否为空

	var ingoingAddress = _$("ingoingAddress");
	if(ingoingAddress==''){
		L5.Msg.alert('提示',"/迁入地民政局不能为空!");
		return false;
	}
		//在乡复员抚恤金已发至是否为空

	var allowanceMonth = _$("allowanceMonth");
	if(allowanceMonth==''){
		L5.Msg.alert('提示',"带病回乡抚恤金已发至!");
		return false;
	}
	if(allowanceMonth!=''&&!validateDateFormat(allowanceMonth+'-01')){
		L5.Msg.alert("提示","在乡复员抚恤金已发至格式不正确！");
		return false;
	}
	var isValidate = DemobilizedIllnessDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationCommand");
	command.setParameter("record", DemobilizedIllnessRecord);
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
		var peopleId = DemobilizedIllnessDataset.getCurrent().get("peopleId");
		var familyId = DemobilizedIllnessDataset.getCurrent().get("familyId");
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
	var revalue =  window.showModalDialog("../comm/idCardSelect.jsp","","dialogHeight:400px;dialogWidth:878px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var idCard = revalue;
		document.getElementById("idCard").value = idCard;
		
		DemobilizedIllnessDataset.getCurrent().set("idCard",idCard);
		queryByIdCard();
	}
}

//根据身份证号查询人员信息和伤残信息
function queryByIdCard(){

	var idCard = document.getElementById("idCard").value;
	var applyId = document.getElementById("applyId").value;
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDemobilizedCommand");
	command.setParameter("ID_CARD", idCard);
	command.setParameter("APPLY_ID", applyId);
	command.execute("updateIllnessByIdCard");
	
	if(command.getReturn("name") !=undefined){
		
		if(command.getReturn("conscriptDate") !=undefined){
				DemobilizedIllnessDataset.set("conscriptDate",command.getReturn("conscriptDate"));
		}else{
			L5.Msg.alert('提示','该人员并非带病回乡人员！');
		}

		DemobilizedIllnessDataset.set("name",command.getReturn("name"));
		DemobilizedIllnessDataset.set("peopleId",command.getReturn("peopleId"));
		DemobilizedIllnessDataset.set("familyId",command.getReturn("familyId"));
		document.getElementById("peopleId").value = command.getReturn("peopleId");
		document.getElementById("familyId").value = command.getReturn("familyId");
		DemobilizedIllnessDataset.set("disabilityTypeCode",command.getReturn("disabilityTypeCode"));
		DemobilizedIllnessDataset.set("dependantTypeCode",command.getReturn("dependantTypeCode"));
		DemobilizedIllnessDataset.set("bank",command.getReturn("bank"));
		DemobilizedIllnessDataset.set("workAbilityCode",command.getReturn("workAbilityCode"));
		DemobilizedIllnessDataset.set("viabilityCode",command.getReturn("viabilityCode"));
		DemobilizedIllnessDataset.set("oldLonelyFlag",command.getReturn("oldLonelyFlag"));
		DemobilizedIllnessDataset.set("orphanFlag",command.getReturn("orphanFlag"));
		DemobilizedIllnessDataset.set("accountName",command.getReturn("accountName"));
		DemobilizedIllnessDataset.set("supportPattern",command.getReturn("supportPattern"));
		DemobilizedIllnessDataset.set("accountCode",command.getReturn("accountCode"));
		DemobilizedIllnessDataset.set("insanityFlag",command.getReturn("insanityFlag"));
		DemobilizedIllnessDataset.set("physiclalStatus",command.getReturn("physiclalStatus"));
		DemobilizedIllnessDataset.set("demobilizedStateCode",command.getReturn("demobilizedStateCode"));
		DemobilizedIllnessDataset.set("demobilizedStateCode",command.getReturn("demobilizedStateCode"));
		DemobilizedIllnessDataset.set("ingoingAddress",command.getReturn("ingoingAddress"));
		DemobilizedIllnessDataset.set("allowanceMonth",command.getReturn("allowanceMonth"));
			if(command.getReturn("townCheckPhone") !=undefined){
					DemobilizedIllnessDataset.set("townCheckPhone",command.getReturn("townCheckPhone"));
				}		
			if(command.getReturn("ingoingAddress") !=undefined){
					DemobilizedIllnessDataset.set("ingoingAddress",command.getReturn("ingoingAddress"));
				}
			if(command.getReturn("townCheckPhone") !=undefined){
					DemobilizedIllnessDataset.set("allowanceMonth",command.getReturn("allowanceMonth"));
				}
			if(command.getReturn("sex") !=undefined){
				DemobilizedIllnessDataset.set("sex",command.getReturn("sex"));
			}
			if(command.getReturn("nation") !=undefined){
				DemobilizedIllnessDataset.set("nation",command.getReturn("nation"));
			}
			if(command.getReturn("birthday") !=undefined){
				DemobilizedIllnessDataset.set("birthday",command.getReturn("birthday"));
			}
			if(command.getReturn("address") !=undefined){
				DemobilizedIllnessDataset.set("address",command.getReturn("address"));
			}
			if(command.getReturn("apanageName") !=undefined){
				DemobilizedIllnessDataset.set("apanageName",command.getReturn("apanageName"));
			}
			if(command.getReturn("veteransDate") !=undefined){
				DemobilizedIllnessDataset.set("veteransDate",command.getReturn("veteransDate"));
			}
			
			if(command.getReturn("demobilizedNo") !=undefined){
				DemobilizedIllnessDataset.set("demobilizedNo",command.getReturn("demobilizedNo"));
				}
			if(command.getReturn("decruitmentDate") !=undefined){
				DemobilizedIllnessDataset.set("decruitmentDate",command.getReturn("decruitmentDate"));
					}		
			if(command.getReturn("illessInfo") !=undefined){
				DemobilizedIllnessDataset.set("illessInfo",command.getReturn("illessInfo"));
					}	
			if(command.getReturn("isWar") !=undefined){
				DemobilizedIllnessDataset.set("isWar",command.getReturn("isWar"));
					}
			if(command.getReturn("approvalDate") !=undefined){
				DemobilizedIllnessDataset.set("approvalDate",command.getReturn("approvalDate"));
					}
			if(command.getReturn("decruitmentDate") !=undefined){
				DemobilizedIllnessDataset.set("decruitmentDate",command.getReturn("decruitmentDate"));
					}	
			if(command.getReturn("isInnuclear") !=undefined){
				DemobilizedIllnessDataset.set("isInnuclear",command.getReturn("isInnuclear"));
					}	
			if(command.getReturn("asdpNo") !=undefined){
				DemobilizedIllnessDataset.set("asdpNo",command.getReturn("asdpNo"));
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
			 DemobilizedIllnessDataset.getCurrent().set("ingoingCode",list[0]);
			 DemobilizedIllnessDataset.getCurrent().set("ingoingAddress",list[1]);
		}
}