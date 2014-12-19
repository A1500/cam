var flag=0;//0:刚加载 不启动下拉框onchage事件; 1:启动

function init() {
		var StateChangeDataset = L5.DatasetMgr.lookup("StateChangeDataset");
		StateChangeDataset.setParameter("BPT_STATE_CHANGE.PEOPLE_ID@=",peopleId);
		StateChangeDataset.load();
		StateChangeDataset.on("load",function(){
		ondisplay();})
		var grid= L5.getCmp("GridPanel");
		grid.on("rowclick",lastfunc);
		
}
function lastfunc(grid, rowIndex ,e){
	var record = grid.getDataset().getAt(rowIndex);  // 返回Record对象 Get the Record
	var f =StateChangeDataset.isLast(record);
	ondisplay();
	if(!f){
		document.getElementById("changeStateSuf").disabled="disabled";
		document.getElementById("note").disabled="disabled";
		document.getElementById("deathDate").disabled="disabled";
		document.getElementById("allowanceMonth").disabled="disabled";
	}else{
		document.getElementById("changeStateSuf").disabled="";
		document.getElementById("note").disabled="";
		document.getElementById("deathDate").disabled="";
		document.getElementById("allowanceMonth").disabled="";
	}
 }
function ondisplay(){
	if(document.getElementById("changeStateSuf").value == 2){
		document.getElementById("deathAlllowance").style.display = "none";
		document.getElementById("deathAlllowancetd").style.display = "none";
		document.getElementById("allowanceMonthtitle").style.display = "none";
		document.getElementById("allowanceMonthtd").style.display = "none";
	}else if(document.getElementById("changeStateSuf").value == 7){
		document.getElementById("deathAlllowance").style.display = "";
		document.getElementById("deathAlllowancetd").style.display = "";
		document.getElementById("deathAlllowancetd").colspan = 1;
		document.getElementById("allowanceMonthtitle").style.display = "";
		document.getElementById("allowanceMonthtd").style.display = "";
	}else{
		document.getElementById("allowanceMonthtd").style.display = "";
		document.getElementById("allowanceMonthtitle").style.display = "";
		document.getElementById("allowanceMonthtd").colspan = 3;
		document.getElementById("allowanceMonthimg").style.display = "";
		document.getElementById("deathAlllowance").style.display = "none";
		document.getElementById("deathAlllowancetd").style.display = "none";
	}
	/*if(document.getElementById("changeStateSuf").value != 7){
		document.getElementById("deathAlllowance").style.display = "none";
		document.getElementById("deathAlllowancetd").style.display = "none";
		document.getElementById("allowanceMonthtd").colspan = 3;
		document.getElementById("allowanceMonthimg").style.display = "none";
	}else{
		document.getElementById("deathAlllowance").style.display = "";
		document.getElementById("deathAlllowancetd").style.display = "";
		document.getElementById("allowanceMonthtd").colspan = 1;
		document.getElementById("allowanceMonthimg").style.display = "";
	}*/
	
}
function onChangeState(){
	
	if(document.getElementById("changeStateSuf").value == 5&&flag==1){
		alert("迁移不能直接变更，请发起流程！");
		document.getElementById("changeStateSuf").value='';
	}
	flag=1;
}

function insert(){
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptStateChangeCommand");
	command.setParameter("peopleId", peopleId);
	command.execute("queryPeopleInfo");
	var name = command.getReturn("name");
	var idCard = command.getReturn("idCard");
	var StateChangeDataset = L5.DatasetMgr.lookup("StateChangeDataset");
	StateChangeDataset.newRecord({name:name,idCard:idCard,changeStatePre:changeStatePre});
    document.getElementById("name").value = name;
	document.getElementById("idCard").value = idCard;
	document.getElementById("changeStatePre").value = changeStatePre;
	document.getElementById("changeStateSuf").disabled="";
	document.getElementById("note").disabled="";
	document.getElementById("deathDate").disabled="";
	document.getElementById("allowanceMonth").disabled="";
}

function save(){
	//状态变更
	var StateChangeDataset = L5.DatasetMgr.lookup("StateChangeDataset");
	var StateChangeRecord = StateChangeDataset.getCurrent();
	var sChangeSuf = document.getElementById("changeStateSuf").value;
	if(sChangeSuf == 5){
		alert("迁移不能直接变更保存，请发起流程！");
		return false;
	}
	
	var changeStateSuf = StateChangeRecord.get("changeStateSuf");
	if(changeStateSuf=="7"){
		var deathDate = StateChangeRecord.get("deathDate");
		if(deathDate==""){
			L5.Msg.alert("提示","死亡日期不能为空！");
			return false;
		}
		if(deathDate!=''&&!validateDateFormat(deathDate)){
			L5.Msg.alert("提示","死亡日期格式不正确！");
			return false;
		}
		/*var allowanceMonth = StateChangeRecord.get("allowanceMonth");
		if(allowanceMonth==""){
			L5.Msg.alert("提示","抚恤金发放日期不能为空！");
			return false;
		}*/
	}
	if(changeStateSuf!="2"){
		var allowanceMonth = StateChangeRecord.get("allowanceMonth");
		if(allowanceMonth==""){
			L5.Msg.alert("提示","抚恤金发放至不能为空！");
			return false;
		}
		if(allowanceMonth!=''&&!validateDateFormat(allowanceMonth+'-01')){
			L5.Msg.alert("提示","抚恤金发放至格式不正确！");
			return false;
		}
	}
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptStateChangeCommand");
	var name = document.getElementById("name").value;
	var idCard = document.getElementById("idCard").value;
	var deathDate = document.getElementById("deathDate").value; 
	var allowanceMonth = document.getElementById("allowanceMonth").value;
	if((sChangeSuf!=changeStatePre)&&((sChangeSuf == 4 || sChangeSuf == 7 || sChangeSuf == 8 || sChangeSuf == 9)||(changeStatePre==4&&sChangeSuf == 2))){//停发、死亡、中止、取消可以直接进行变更
		var stateChangeId = StateChangeRecord.get("stateChangeId");
		if(stateChangeId != ""){//判断是保存还是修改
			command.setParameter("StateChangeRecord", StateChangeRecord);
			command.setParameter("stateChangeId",stateChangeId);
			command.setParameter("note",document.getElementById("note").value);
			command.setParameter("changeStatePre", changeStatePre);
			command.setParameter("objectType", objectType);
	//		alert(peopleId+"  "+document.getElementById("changeStateSuf").value);
			command.execute("update");
		}else{
			StateChangeRecord.set("peopleId",peopleId);
			StateChangeRecord.set("name",name);
			StateChangeRecord.set("idCard",idCard);
			StateChangeRecord.set("changeStatePre",changeStatePre);

			command.setParameter("StateChangeRecord", StateChangeRecord);
			command.setParameter("changeStatePre", changeStatePre);
			command.setParameter("objectType", objectType);
			command.execute("insert");
		}
	}else{
		alert("不能变更!");
		return false;
	}
	
	if (!command.error) {
		
		changeStatePre = document.getElementById("changeStateSuf").value;
		StateChangeDataset.commitChanges();
		L5.Msg.alert('提示','保存成功！');
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function statePreRender(value,cellmeta,record,rowindex,colindex,dataset){
	var dataType=record.data['changeStatePre'];
	if(dataType=="1")
		return "受理";
	else if(dataType=="2")
		return "享受待遇";
	else if(dataType=="3")
		return "身份认定不享受待遇";
	else if(dataType=="4")
		return "停发";
	else if(dataType=="5")
		return "迁移";
	else if(dataType=="6")
		return "不予认定";
	else if(dataType=="7")
		return "去世";
	else if(dataType=="8")
		return "取消";
	else if(dataType=="9")
		return "中止";
	else
		return "";
}

function stateSufRender(value,cellmeta,record,rowindex,colindex,dataset){
	var dataType=record.data['changeStateSuf'];
	if(dataType=="1")
		return "受理";
	else if(dataType=="2")
		return "享受待遇";
	else if(dataType=="3")
		return "身份认定不享受待遇";
	else if(dataType=="4")
		return "停发";
	else if(dataType=="5"){
		return "迁移";
		flag=0;
		}
	else if(dataType=="6")
		return "不予认定";
	else if(dataType=="7")
		return "去世";
	else if(dataType=="8")
		return "取消";
	else if(dataType=="9")
		return "中止";
	else
		return "";
}