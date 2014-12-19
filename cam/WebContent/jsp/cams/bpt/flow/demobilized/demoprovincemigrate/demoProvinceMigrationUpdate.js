

function save(){

	var ProvinceMigrationDataSet = L5.DatasetMgr.lookup("ProvinceMigrationDataSet");
	var DisabilityApproveRecord=ProvinceMigrationDataSet.getCurrent();
	DisabilityApproveRecord.set("peopleId",document.getElementById("peopleId").value);
	//迁入地民政局是否为空

	var ingoingAddress = _$("ingoingName");
	if(ingoingAddress==''){
		L5.Msg.alert('提示',"迁入地民政局不能为空!");
		return false;
	}
		//在乡复员抚恤金已发至是否为空

		var recordMigration = ProvinceMigrationDataSet.getCurrent();
			allowanceMonth = recordMigration.get("allowanceMonth");
	if(allowanceMonth==''){
		L5.Msg.alert('提示',"在乡复员抚恤金已发至!");
		return false;
	}
	if(allowanceMonth!=''&&!validateDateFormat(allowanceMonth+'-01')){
		L5.Msg.alert("提示","在乡复员抚恤金已发至格式不正确！");
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
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
	command.setParameter("record", DisabilityApproveRecord);
	command.setParameter("applyId",applyId);
	command.execute("update");

	if (!command.error) {
		L5.Msg.alert('提示','信息保存成功！');
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
        var width = screen.width-100;
    	var height = screen.height-140;
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
		
		ProvinceMigrationDataSet.getCurrent().set("idCard",idCard);
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
				ProvinceMigrationDataSet.set("conscriptDate",command.getReturn("conscriptDate"));
		}else{
			L5.Msg.alert('提示','该人员并在乡复员人员！');
		}
		
		ProvinceMigrationDataSet.set("name",command.getReturn("name"));
		ProvinceMigrationDataSet.set("peopleId",command.getReturn("peopleId"));
		ProvinceMigrationDataSet.set("familyId",command.getReturn("familyId"));
		document.getElementById("peopleId").value = command.getReturn("peopleId");
		document.getElementById("familyId").value = command.getReturn("familyId");
		
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
		    if(command.getReturn("isKoeanwar") !=undefined){
				ProvinceMigrationDataSet.set("isKoeanwar",command.getReturn("isKoeanwar"));
				}			
			if(command.getReturn("decruitmentDate") !=undefined){
				ProvinceMigrationDataSet.set("decruitmentDate",command.getReturn("decruitmentDate"));
					}		
			if(command.getReturn("position") !=undefined){
				ProvinceMigrationDataSet.set("position",command.getReturn("position"));
					}		
			if(command.getReturn("belongDate") !=undefined){
				ProvinceMigrationDataSet.set("belongDate",command.getReturn("belongDate"));
				}
			
	}else{
		L5.Msg.alert('提示','该人员未录入系统！');
		document.getElementById("idCard").value = "";
		return false;
	}
}

 


