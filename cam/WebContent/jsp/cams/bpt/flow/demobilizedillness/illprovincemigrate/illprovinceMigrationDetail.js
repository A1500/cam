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
	var ingoingAddress = _$("ingoingAddress");
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

	var IllEmigratDataset = L5.DatasetMgr.lookup("ProvinceMigrationDataSet");
	var IllEmigratRecord=IllEmigratDataset.getCurrent();
	IllEmigratRecord.set("peopleId",document.getElementById("peopleId").value);
	IllEmigratRecord.set("serviceType","47");
	IllEmigratRecord.set("applyId",document.getElementById("applyId").value);
 
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

//通过伤残人员查询窗口取得IdCard&查询相关信息
function getIdCard(){
	var revalue =  window.showModalDialog("../comm/idCardSelect.jsp","","dialogHeight:400px;dialogWidth:878px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var idCard = revalue;
		document.getElementById("idCard").value = idCard;
		
		ProvinceMigrationDataSet.getCurrent().set("idCard",idCard);
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
	command.execute("updateIllprovinceByIdCard");
	
	if(command.getReturn("name") !=undefined){
		
		if(command.getReturn("conscriptDate") !=undefined){
				ProvinceMigrationDataSet.set("conscriptDate",command.getReturn("conscriptDate"));
		}else{
			L5.Msg.alert('提示','该人员并非带病回乡人员！');
		}

		ProvinceMigrationDataSet.set("name",command.getReturn("name"));
		ProvinceMigrationDataSet.set("peopleId",command.getReturn("peopleId"));
		ProvinceMigrationDataSet.set("familyId",command.getReturn("familyId"));
		document.getElementById("peopleId").value = command.getReturn("peopleId");
		document.getElementById("familyId").value = command.getReturn("familyId");
		ProvinceMigrationDataSet.set("disabilityTypeCode",command.getReturn("disabilityTypeCode"));
		ProvinceMigrationDataSet.set("dependantTypeCode",command.getReturn("dependantTypeCode"));
		ProvinceMigrationDataSet.set("bank",command.getReturn("bank"));
		ProvinceMigrationDataSet.set("workAbilityCode",command.getReturn("workAbilityCode"));
		ProvinceMigrationDataSet.set("viabilityCode",command.getReturn("viabilityCode"));
		ProvinceMigrationDataSet.set("oldLonelyFlag",command.getReturn("oldLonelyFlag"));
		ProvinceMigrationDataSet.set("orphanFlag",command.getReturn("orphanFlag"));
		ProvinceMigrationDataSet.set("accountName",command.getReturn("accountName"));
		ProvinceMigrationDataSet.set("supportPattern",command.getReturn("supportPattern"));
		ProvinceMigrationDataSet.set("accountCode",command.getReturn("accountCode"));
		ProvinceMigrationDataSet.set("insanityFlag",command.getReturn("insanityFlag"));
		ProvinceMigrationDataSet.set("physiclalStatus",command.getReturn("physiclalStatus"));
		ProvinceMigrationDataSet.set("demobilizedStateCode",command.getReturn("demobilizedStateCode"));
		ProvinceMigrationDataSet.set("demobilizedStateCode",command.getReturn("demobilizedStateCode"));
		ProvinceMigrationDataSet.set("ingoingName",command.getReturn("ingoingName"));
		ProvinceMigrationDataSet.set("allowanceMonth",command.getReturn("allowanceMonth"));
			if(command.getReturn("outTownCheckPhone") !=undefined){
					ProvinceMigrationDataSet.set("outTownCheckPhone",command.getReturn("outTownCheckPhone"));
				}		
			if(command.getReturn("ingoingName") !=undefined){
					ProvinceMigrationDataSet.set("ingoingName",command.getReturn("ingoingName"));
				}
			if(command.getReturn("townCheckPhone") !=undefined){
					ProvinceMigrationDataSet.set("allowanceMonth",command.getReturn("allowanceMonth"));
				}
			if(command.getReturn("sex") !=undefined){
				ProvinceMigrationDataSet.set("sex",command.getReturn("sex"));
			}
			if(command.getReturn("nation") !=undefined){
				ProvinceMigrationDataSet.set("nation",command.getReturn("nation"));
			}
			if(command.getReturn("birthday") !=undefined){
				ProvinceMigrationDataSet.set("birthday",command.getReturn("birthday"));
			}
			if(command.getReturn("address") !=undefined){
				ProvinceMigrationDataSet.set("address",command.getReturn("address"));
			}
			if(command.getReturn("apanageName") !=undefined){
				ProvinceMigrationDataSet.set("apanageName",command.getReturn("apanageName"));
			}
			if(command.getReturn("veteransDate") !=undefined){
				ProvinceMigrationDataSet.set("veteransDate",command.getReturn("veteransDate"));
			}
			
			if(command.getReturn("demobilizedNo") !=undefined){
				ProvinceMigrationDataSet.set("demobilizedNo",command.getReturn("demobilizedNo"));
				}
			if(command.getReturn("decruitmentDate") !=undefined){
				ProvinceMigrationDataSet.set("decruitmentDate",command.getReturn("decruitmentDate"));
					}		
			if(command.getReturn("illessInfo") !=undefined){
				ProvinceMigrationDataSet.set("illessInfo",command.getReturn("illessInfo"));
					}	
			if(command.getReturn("isWar") !=undefined){
				ProvinceMigrationDataSet.set("isWar",command.getReturn("isWar"));
					}
			if(command.getReturn("approvalDate") !=undefined){
				ProvinceMigrationDataSet.set("approvalDate",command.getReturn("approvalDate"));
					}
			if(command.getReturn("decruitmentDate") !=undefined){
				ProvinceMigrationDataSet.set("decruitmentDate",command.getReturn("decruitmentDate"));
					}	
			if(command.getReturn("isInnuclear") !=undefined){
				ProvinceMigrationDataSet.set("isInnuclear",command.getReturn("isInnuclear"));
					}	
			if(command.getReturn("asdpNo") !=undefined){
				ProvinceMigrationDataSet.set("asdpNo",command.getReturn("asdpNo"));
					}	
					
			if(command.getReturn("domicileName") !=undefined){
				ProvinceMigrationDataSet.set("domicileName",command.getReturn("domicileName"));
			}	
			if(command.getReturn("apanageName") !=undefined){
				ProvinceMigrationDataSet.set("apanageName",command.getReturn("apanageName"));
			}	
			if(command.getReturn("inDomicileAddress") !=undefined){
				ProvinceMigrationDataSet.set("inDomicileAddress",command.getReturn("inDomicileAddress"));
			}
			if(command.getReturn("inApanageAddress") !=undefined){
				ProvinceMigrationDataSet.set("inApanageAddress",command.getReturn("inApanageAddress"));			
			}
			if(command.getReturn("inDomicileCode") !=undefined){
				ProvinceMigrationDataSet.set("inDomicileCode",command.getReturn("inDomicileCode"));
			}
			if(command.getReturn("inApanageCode") !=undefined){
				ProvinceMigrationDataSet.set("inApanageCode",command.getReturn("inApanageCode"));
			}		
			
	}else{
		L5.Msg.alert('提示','该人员未录入系统！');
		document.getElementById("idCard").value = "";
		return false;
	}
}
 