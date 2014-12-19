function init(){
	var emigratDataSet = L5.DatasetMgr.lookup("emigratDataSet");
	emigratDataSet.setParameter("PEOPLE_ID",peopleId);
 	emigratDataSet.setParameter("APPLY_ID",applyId);
 	emigratDataSet.load();
	L5.QuickTips.init();
}

function save(){
	var emigratDataSet = L5.DatasetMgr.lookup("emigratDataSet");
	var ProvinceEmigratRecord=emigratDataSet.getCurrent();
	//校验迁入地民政局是否为空
	var ingoingName = _$("ingoingAddress");
	if(ingoingName==''){
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
		L5.Msg.alert("提示","抚恤金已发至格式不正确！");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationCommand");
	command.setParameter("record", ProvinceEmigratRecord);
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
/*
function func_ForDomicileSelect(){
		var ingoingCode = _$("ingoingCode");
		var ingoingName = _$("ingoingName");
		var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCity.jsp?organCode=370000000000&organName=山东省","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
			 ProvinceMigratDataSet.getCurrent().set("ingoingCode",list[0]);
			 ProvinceMigratDataSet.getCurrent().set("ingoingName",list[1]);
		}
}

function detail(value){
	if(value!=''){
		var peopleId = ProvinceMigratDataSet.getCurrent().get("peopleId");
		var familyId = ProvinceMigratDataSet.getCurrent().get("familyId");
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
			 emigratDataSet.getCurrent().set("ingoingCode",list[0]);
			 emigratDataSet.getCurrent().set("ingoingAddress",list[1]);
		}
}
