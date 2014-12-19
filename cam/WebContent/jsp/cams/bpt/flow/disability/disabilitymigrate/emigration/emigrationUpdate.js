function init(){
	var DisabilityEmigratDataset = L5.DatasetMgr.lookup("DisabilityEmigratDataset");
	DisabilityEmigratDataset.setParameter("PEOPLE_ID",peopleId);
 	DisabilityEmigratDataset.setParameter("APPLY_ID",applyId);
 	DisabilityEmigratDataset.load();
	L5.QuickTips.init();
}

function save(){
	var DisabilityEmigratDataset = L5.DatasetMgr.lookup("DisabilityEmigratDataset");
	var DisabilityEmigratRecord=DisabilityEmigratDataset.getCurrent();
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
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationCommand");
	command.setParameter("record", DisabilityEmigratRecord);
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

/*function detail(value){
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
}*/


 function getCodeAndName(){
		var ingoingCode = _$("ingoingCode");
		var ingoingAddress = _$("ingoingAddress");
		var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicPubCant.jsp?organCode=CN&organName=中国","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
			 DisabilityEmigratDataset.getCurrent().set("ingoingCode",list[0]);
			 DisabilityEmigratDataset.getCurrent().set("ingoingAddress",list[1]);
		}
}