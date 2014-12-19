var peopleId1;
var objectType;
function init() {
	var ds = L5.DatasetMgr.lookup("ds");
	ds.newRecord();
	L5.QuickTips.init(); 
}
//通过伤残人员查询窗口取得IdCard&查询相关信息
function getIdCard(){
	var width = screen.width-100;
    var height = screen.height-140;
    var type = document.getElementById("serviceType").value;
    if(type == "23") { //三属
		url = L5.webPath + "/jsp/cams/bpt/flow/dependant/comm/idCardSelect.jsp";
	} else if(type == "16") {//伤残
		url = L5.webPath + "/jsp/cams/bpt/flow/disability/common/idCardSelect.jsp";
	} else if(type == "43") {//在乡复员
		url = L5.webPath +"/jsp/cams/bpt/flow/demobilized/comm/idCardSelect.jsp";
	} else if(type == "47") {//带病回乡
		url = L5.webPath + "/jsp/cams/bpt/flow/demobilizedillness/comm/idCardSelect.jsp";
	} else if(type == "53") {//参战
		url = L5.webPath + "/jsp/cams/bpt/flow/war/migrate/provincialmigration/idCardSelect.jsp";
	} else if(type == "63") {//参试
		url = L5.webPath + "/jsp/cams/bpt/flow/tested/comm/idCardSelect.jsp";
	} else if(type == "83") {//参试
		url = L5.webPath + "/jsp/cams/bpt/flow/countretiredsoldier/comm/idCardSelect.jsp";
	} else if(type == "B3") {//参试
		url = L5.webPath + "/jsp/cams/bpt/flow/martyroffspring/comm/idCardSelect.jsp";
	}
	var returnValue =  window.showModalDialog(url,"","dialogHeight:"+height+"px;dialogWidth:"+width+"px;resizable:no;scroll:yes;");
	if(returnValue==""||returnValue==";;;;;;;"){
		var editForm = L5.get("editForm");
		editForm.dom.reset();
		ds.removeAll();
		ds.newRecord();
		document.getElementById("sex").innerHTML="";
		document.getElementById("age").innerHTML="";
		document.getElementById("nation").innerHTML="";
		document.getElementById("objectType").innerHTML="";
		document.getElementById("familyNum").innerHTML="";
		document.getElementById("idCard").innerHTML="";
		document.getElementById("address").innerHTML="";
	}else if(returnValue!=""&&returnValue!=undefined){
		if(type == "16")
			var list = returnValue.split(";");
		else
			var list = returnValue.split(":");
		var peopleId = list[1];
		peopleId1 = peopleId;
		queryByPeopleId(peopleId);
	}
}
function queryByPeopleId(peopleId){
	var ds = L5.DatasetMgr.lookup("ds");
	ds.setParameter("peopleId",peopleId);
	ds.load();
	ds.on("load",function(){
		objectType = ds.get("objectType");
	});
}
function save(){
	var dsUpdateTemporaryHelp  = L5.DatasetMgr.lookup("ds");
	var record = dsUpdateTemporaryHelp.getCurrent();
	var name = record.get("name");
	if(name==''){
		L5.Msg.alert("提示","请添加人员后保存！");
		return false;
	}
	//校验
	var helpType = record.get("helpType");
	if(helpType==''){
		L5.Msg.alert("提示","救助类别不能为空！");
		return false;
	}
	var applySubject = record.get("applySubject");
	if(applySubject==''){
		L5.Msg.alert("提示","申请事由不能为空！");
		return false;
	}
    var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptTemporaryHelpCommand"); 
	command.setParameter("record",record);
	command.execute("save");	
	var familyId = command.getReturn("familyId");
		var applyId = command.getReturn("applyId");
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!",function(){
			window.returnValue=peopleId1+";"+familyId+";"+applyId+";"+objectType;
			window.close();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function fun_close(){
	window.close();
}