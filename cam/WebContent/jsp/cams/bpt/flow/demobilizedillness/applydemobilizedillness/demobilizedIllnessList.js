function init() {
BaseinfoPeopleDataSet.setParameter("organCode",organCode);		
	BaseinfoPeopleDataSet.load();
	hideButton("editGridPanel",[10,11,12,13],[],[2,3,4,5,8,9,10,11,12,13],[2,3,4,5,8,9,10,11,12,13]);
}
//根据区划级别隐藏按钮
function hideButton( grid,jbuts,qbuts,citybuts,sbuts){//街道,区县,市,省
	if(organType=='14'){//街道
		for(var i=0;i<jbuts.length;i++){
			L5.getCmp(grid).getTopToolbar().items.items[jbuts[i]].hide();
		}
	}else if(organType=='13'){//区县
		for(var i=0;i<qbuts.length;i++){
			L5.getCmp(grid).getTopToolbar().items.items[qbuts[i]].hide();
		}
	}else if(organType=='12'){//市
		for(var i=0;i<citybuts.length;i++){
			L5.getCmp(grid).getTopToolbar().items.items[citybuts[i]].hide();
		}
	}else if(organType=='11'){//省
		for(var i=0;i<sbuts.length;i++){
			L5.getCmp(grid).getTopToolbar().items.items[sbuts[i]].hide();
		}
	}
}

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	var domicileCode = getParam("domicileCode");
	var name = getParam("name");
	var idCard = getParam("idCard");
	var isWar = getParam("isWar");
	var isInnuclear = getParam("isInnuclear");
	var objectState = getParam("objectState");
	var domicileType = getParam("domicileType");
	var note = getParam("note");
	
	BaseinfoPeopleDataSet.setParameter("domicileCode",domicileCode);
	BaseinfoPeopleDataSet.setParameter("name",name);
	BaseinfoPeopleDataSet.setParameter("idCard",idCard);	
	BaseinfoPeopleDataSet.setParameter("isWar",isWar);	
	BaseinfoPeopleDataSet.setParameter("isInnuclear",isInnuclear);	
	BaseinfoPeopleDataSet.setParameter("objectState",objectState);	
	BaseinfoPeopleDataSet.setParameter("domicileType",domicileType);
	BaseinfoPeopleDataSet.setParameter("organCode",organCode);
	BaseinfoPeopleDataSet.setParameter("note",note);		
	BaseinfoPeopleDataSet.load();
}

function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("domicileName").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("isWar").value = "";
	document.getElementById("isInnuclear").value = "";
	document.getElementById("objectState").value = "";
	document.getElementById("domicileType").value = "";
	document.getElementById("note").value = "";
}
function insert() {
	var url="demobilizedIllnessInsert.jsp?method=INSERT";
	var width = screen.width-100;
    var height = screen.height-140;
 	var returnValue = window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
 	if(returnValue!=""&returnValue!=undefined){
 		var list = returnValue.split(";");
 		var peopleId = list[0];
 		var familyId = list[1];
 		var applyId = list[2];
 		var url2="demobilizedIllnessUpdateManage.jsp?familyId="+familyId+"&peopleId="+peopleId+"&applyId="+applyId;
		var win = window.showModalDialog (url2,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		init();
		if (win==null) {
			return;
		} else if (win=="createSend") {
		casById(applyId,peopleId);
		}
 	}

}

function update(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
//	var data = new L5.Map();
//	data.put("method","UPDATE");
//	data.put("familyId",selected[0].get('FAMILY_ID'));
//	data.put("peopleId",selected[0].get('PEOPLE_ID'));
//	var url='jsp/cams/bpt/dataCollection/demobilizedIllness/demobilizedIllnessUpdateManage.jsp';
//	var text = '修改基础信息_人员信息';
//	L5.forward(url,text,data);
	var familyId = selected[0].get('FAMILY_ID');
	var peopleId = selected[0].get('PEOPLE_ID');
	var applyId = selected[0].get('APPLY_ID');
	var url="demobilizedIllnessUpdateManage.jsp?familyId="+familyId+"&peopleId="+peopleId+"&applyId="+applyId;
	var width = screen.width-100;
    var height = screen.height-140;
	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	init();
	if (win=="createSend") {
		createAndSend();
	}else{
		return;
	}
}

function del(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDemobilizedCommand");
			command.setParameter("record", selected);
			command.execute("deleteDemobilizedIll");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	BaseinfoPeopleDataSet.remove(selected[i]);
				}
				BaseinfoPeopleDataSet.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}
function detail(){
    var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	var data = new L5.Map();
	
	var peopleId = selected[0].get('PEOPLE_ID');
	var familyId = selected[0].get('FAMILY_ID');
	var applyId = selected[0].get('APPLY_ID');
	var url='demobilizedIllnessDetail.jsp?peopleId='+peopleId+'&familyId='+familyId+'&applyId='+applyId;
	var width = screen.width-100;
    var height = screen.height-140;
	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
}


function forHelp(){
   var revalue=window.showModalDialog("../../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=11,12,13&organType=0&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
   if(revalue!=""&&revalue!=undefined){
      var list = revalue.split(";");
      document.getElementById("domicileCode").value = list[0];
      document.getElementById("domicileName").value = list[1];
    }
}
//发起单个流程
function createAndSend(){
	   		var editGrid=L5.getCmp('editGridPanel');
			var selected=editGrid.getSelectionModel().getSelections();
			if(selected.length!=1){
				L5.Msg.alert("提示","请选择一个人员进行提交！");
				return false;
			}
	   	L5.getCmp("submitButton").setDisabled(true);
	   	var PeopleDemobilizedRecord = selected[0];
	   	var applyId= PeopleDemobilizedRecord.get('APPLY_ID');
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDemobilizedCommand");
		command.setParameter("APPLY_ID",applyId);
		command.execute("queryApplyInfo");
		var trialName=command.getReturn("trialName");
		var townFlag = command.getReturn("townFlag");
		var townReport = command.getReturn("townReport");
		if(trialName!=null){
			if(townFlag == '0') {  //同意审批
				operation("pass",PeopleDemobilizedRecord);
			} else if(townFlag == '1') { //不予认定
				if(townReport == '1') { // 上报
					operation("pass",PeopleDemobilizedRecord);
				} else if(townReport == '0') { // 不上报
					var commandValidate = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptDecisionLetterCommand");
					commandValidate.setParameter("applyId",applyId);
					commandValidate.execute("ifHave");
					var flag = commandValidate.getReturn("ifhave");
					if(flag) {
						operation("end",PeopleDemobilizedRecord);
					} else {
						L5.getCmp("submitButton").setDisabled(false);
						L5.Msg.alert("提示","请填写不予评定决定书");
						return false;
					}	
				}
			}
		}else{
			L5.getCmp("submitButton").setDisabled(false);
			L5.Msg.alert("提示","请在修改页面保存县级审批信息!");
		}
}
function operation(value,record){
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedCommand");
	command.setParameter("record", record);
	var url;
	if(value=='pass'){
		command.execute("createAndSend1");
		url = "jsp/cams/bpt/flow/queryyiban_bpt.jsp";
	}else if(value == "end") {
		command.execute("createAndSendOver1");
		url = "jsp/cams/bpt/flow/queryend_bpt.jsp";
	}      
	if(!command.error){
		alert("流程发起并发送成功!");
	   //跳转到已办任务页面
		L5.forward(url,"已办任务页面");
	}else{
		L5.getCmp("submitButton").setDisabled(false);
		alert(command.error + "    流程发起失败！");
	}
}
//不予认定并结束
function createAndSendOver(){
			
	   		var editGrid=L5.getCmp('editGridPanel');
			
			var selected=editGrid.getSelectionModel().getSelections();
	
			if(selected.length!=1){
				L5.Msg.alert("提示","请选择一个人员进行提交！");
				return false;
			}
	   	  
	   	  var PeopleDemobilizedRecord = selected[0];
	   	  var peopleId = selected[0].get('PEOPLE_ID');
	   	  var familyId = selected[0].get('FAMILY_ID');
	   	  var applyId = selected[0].get('APPLY_ID');
	   	  //判断是否填写公示书
	   	  var commandifHave=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptDecisionLetterCommand");
	   	  commandifHave.setParameter("applyId",applyId);
	   	  commandifHave.execute("ifHave");
	   	  var ifhave = commandifHave.getReturn("ifhave");
	   	  if(!ifhave){
	   	  	alert("请先填写不予评定决定书");
	   	  	var url='demobilizedIllnessUpdateManage.jsp?method=UPDATE&peopleId='+peopleId+'&familyId='+familyId+'&applyId='+applyId;
			var width = screen.width-100;
		    var height = screen.height-140;
			var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	 		return false;
	  }
	      var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedCommand");
	      command.setParameter("record", PeopleDemobilizedRecord);	      
	      command.execute("createAndSendOver1");
	      if(!command.error){
		   alert("流程发起并发送成功!");
		   //跳转到已办任务页面
		   var url = "jsp/cams/bpt/flow/queryyiban_bpt.jsp";
		   L5.forward(url,"已办任务页面");
	     }else{
	      alert(command.error + "    流程发起失败！");
	     }
}
//批量发起流程
function batchSend(){
	var name;
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择记录提交!");   
		return false;
	}
	L5.getCmp("bthSmtBtn").setDisabled(true);
	for(var i=0;i<selected.length;i++){
		var applyId = selected[i].get("APPLY_ID");
			name = selected[i].get("NAME");
		var PeopleDemobilizedRecord = selected[i];
		var applyId = selected[i].get('APPLY_ID');
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDemobilizedCommand");
		command.setParameter("APPLY_ID",applyId);
		command.execute("queryApplyInfo");
		var trialName=command.getReturn("trialName");
		var townFlag = command.getReturn("townFlag");
		var townReport = command.getReturn("townReport");
		if(trialName!=null){
			if(townFlag == '0') {  //同意审批
				batchOperation("pass",PeopleDemobilizedRecord);
			} else if(townFlag == '1') { //不予认定
				if(townReport == '1') { // 上报
					batchOperation("pass",PeopleDemobilizedRecord);
				} else if(townReport == '0') { // 不上报
					var commandValidate = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptDecisionLetterCommand");
					commandValidate.setParameter("applyId",applyId);
					commandValidate.execute("ifHave");
					var flag = commandValidate.getReturn("ifhave");
					if(flag) {
						batchOperation("end",PeopleDemobilizedRecord);
					} else {
						L5.getCmp("bthSmtBtn").setDisabled(false);
						L5.Msg.alert("提示","请填写【"+name+"】不予评定决定书");
						return false;
					}	
				}
			}
		}else{
			L5.getCmp("bthSmtBtn").setDisabled(false);
			L5.Msg.alert("提示","请先保存【"+name+"】县级审批信息!");
			return false;
		}
			if(selected.length==i+1) {
				alert("批量发起并发送成功!");
				 //跳转到已办任务页面
				   var url = "jsp/cams/bpt/flow/queryyiban_bpt.jsp";
				   L5.forward(url,"已办任务页面");
			}
	}
}

function batchOperation(value,record){
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedCommand");
	command.setParameter("record", record);
	var url;
	if(value=='pass'){
		command.execute("createAndSend1");
		url = "jsp/cams/bpt/flow/queryyiban_bpt.jsp";
	}else if(value == "end") {
		command.execute("createAndSendOver1");
		url = "jsp/cams/bpt/flow/queryend_bpt.jsp";
	}      
	if(command.error){
		L5.getCmp("bthSmtBtn").setDisabled(false);	
		alert(command.error + "流程发起失败！");
	}
}

//插入信息时提交
function casById(applyId,peopleId){
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDemobilizedCommand");
		command.setParameter("APPLY_ID",applyId);
		command.execute("queryApplyInfo");
		var trialName=command.getReturn("trialName");
		var townFlag = command.getReturn("townFlag");
		var townReport = command.getReturn("townReport");
		if(trialName!=null){
			if(townFlag == '0') {  //同意审批
				operationById("pass",applyId,peopleId);
			} else if(townFlag == '1') { //不予认定
				if(townReport == '1') { // 上报
					operationById("pass",applyId,peopleId);
				} else if(townReport == '0') { // 不上报
					var commandValidate = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptDecisionLetterCommand");
					commandValidate.setParameter("applyId",applyId);
					commandValidate.execute("ifHave");
					var flag = commandValidate.getReturn("ifhave");
					if(flag) {
						operationById("end",applyId,peopleId);
					} else {
						L5.Msg.alert("提示","请填写不予评定决定书");
						return false;
					}	
				}
			}
		}else{
			L5.Msg.alert("提示","请在修改页面保存县级审批信息!");
		}
}
function operationById(value,applyId,peopleId){
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedCommand");
	command.setParameter("applyId", applyId);
	command.setParameter("peopleId", peopleId);
	var url;
	if(value=='pass'){
		command.execute("createAndSend1");
		url = "jsp/cams/bpt/flow/queryyiban_bpt.jsp";
	}else if(value == "end") {
		command.execute("createAndSendOver1");
		url = "jsp/cams/bpt/flow/queryend_bpt.jsp";
	}      
	if(!command.error){
		alert("流程发起并发送成功!");
	   //跳转到已办任务页面
		L5.forward(url,"已办任务页面");
	}else{
		alert(command.error + "    流程发起失败！");
	}
}