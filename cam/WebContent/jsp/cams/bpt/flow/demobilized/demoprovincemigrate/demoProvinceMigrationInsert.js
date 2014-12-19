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
		var ProvinceMigrationDataSet1 = L5.DatasetMgr.lookup("ProvinceMigrationDataSet");
		var recordMigration = ProvinceMigrationDataSet1.getCurrent();
			allowanceMonth = recordMigration.get("allowanceMonth");
	if(allowanceMonth==''){
		L5.Msg.alert('提示',"在乡复员抚恤金已发至不能为空!");
		return false;
	}
	if(allowanceMonth!=''&&!validateDateFormat(allowanceMonth+'-01')){
		L5.Msg.alert("提示","在乡复员抚恤金已发至格式不正确！");
		return false;
	}
	var ProvinceMigrationDataSet = L5.DatasetMgr.lookup("ProvinceMigrationDataSet");
	
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
	
	var DisabilityEmigratRecord=ProvinceMigrationDataSet.getCurrent();
	DisabilityEmigratRecord.set("peopleId",document.getElementById("peopleId").value);
	DisabilityEmigratRecord.set("serviceType","43");
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
	command.setParameter("record", DisabilityEmigratRecord);
	command.execute("insert");
	var familyId = document.getElementById("familyId").value;
	var peopleId = document.getElementById("peopleId").value;
	if (!command.error) {
		var width = screen.width-100;
	    var height = screen.height-140;
	   init();
		var applyId = command.getReturn("applyId");
		var url = 'demoProvinceMigrationUpdate.jsp?familyId=' + familyId + '&peopleId='
				+ peopleId + '&applyId=' + applyId;
		//var win = window.showModalDialog(url, window,
		//		"scroll:yes;status:no;dialogWidth:" + width + "px;dialogHeight:"
		//			+ height + "px;resizable:1");
		var approveForm = L5.get("approveForm");
			approveForm.dom.reset();
	//	var applyId = command.getReturn("applyId");
	//	var url = 'demoProvinceMigrationUpdate.jsp?familyId=' + familyId + '&peopleId='
	//			+ peopleId + '&applyId=' + applyId;
		window.returnValue=applyId+";"+peopleId+";"+familyId+";43";
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
		var width = screen.width-100;
		var height = screen.height-140;
		var win =window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		if (win == null) {
			return;
		}
}

//通过伤残人员查询窗口取得IdCard&查询相关信息
function getIdCard(){
	var width = screen.width-100;
	var height = screen.height-140;
	var revalue =  window.showModalDialog("../comm/idCardSelect.jsp","","dialogHeight:"+height+"x;dialogWidth:"+width+"px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=";;;;;;;"&&revalue!=undefined){
		var list = revalue.split(":");
		var idCard = list[0];
		var peopleId = list[1];
		
		document.getElementById("idCard").value = idCard;
		
		ProvinceMigrationDataSet.getCurrent().set("idCard",idCard);
		queryByIdCard(peopleId);
	}else if(revalue==";;;;;;;"){
		ProvinceMigrationDataSet.removeAll();
		ProvinceMigrationDataSet.newRecord();
		document.getElementById("nation").innerHTML="";
		document.getElementById("isKoeanwar").innerHTML="";
		document.getElementById("belongDate").innerHTML="";
	}
}

//根据身份证号查询人员信息和伤残信息
function queryByIdCard(peopleId){
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDemobilizedCommand");
	command.setParameter("PEOPLE_ID", peopleId);
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
 