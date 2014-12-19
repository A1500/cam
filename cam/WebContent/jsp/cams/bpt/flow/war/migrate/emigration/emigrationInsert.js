function init(){
	var EMigratDataSet = L5.DatasetMgr.lookup("EMigratDataSet");
	EMigratDataSet.newRecord();
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
	var ingoingAddress = _$("ingoingAddress");
	if(ingoingAddress==''){
		L5.Msg.alert('提示',"迁入地民政局不能为空!");
		return false;
	}
	//校验抚恤金已发至是否为空
	var allowanceMonth = _$("allowanceMonth");
	if(allowanceMonth==''){
		L5.Msg.alert('提示',"抚恤金已发至不能为空!");
		return false;
	}
	if(allowanceMonth!=''&&!validateDateFormat(allowanceMonth+'-01')){
		L5.Msg.alert("提示","抚恤金已发至格式不正确！");
		return false;
	}
	var EMigratDataSet = L5.DatasetMgr.lookup("EMigratDataSet");
	var ProvinceMigratRecord=EMigratDataSet.getCurrent();
	ProvinceMigratRecord.set("peopleId",document.getElementById("peopleId").value);
	ProvinceMigratRecord.set("serviceType","55");
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationCommand");
	command.setParameter("record", ProvinceMigratRecord);
	command.execute("insert");
	if (!command.error) {
		var approveForm = L5.get("approveForm");
		approveForm.dom.reset();
		document.getElementById("name").innerHTML='';
		document.getElementById("sex").innerHTML='';
		document.getElementById("warTypeCode").innerHTML='';
		document.getElementById("forcesNo").innerHTML='';
		document.getElementById("position").innerHTML='';
		document.getElementById("asdpNo").innerHTML='';
	var peopleId = ProvinceMigratRecord.get("peopleId");
	var familyId = ProvinceMigratRecord.get("familyId");
	var applyId = command.getReturn("applyId");
/*	var url = "emigrationUpdateManage.jsp?peopleId="+peopleId+"&familyId="+familyId+"&applyId="+applyId;
	var width = screen.width-100;
	var height = screen.height-120;
 	window.showModalDialog(url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	*/
	window.returnValue=applyId+";"+peopleId+";"+familyId+";55";
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
		var peopleId = EMigratDataSet.getCurrent().get("peopleId");
		var familyId = EMigratDataSet.getCurrent().get("familyId");
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
	var width = screen.width-100;
    var height = screen.height-140;
	var url = L5.webPath + "/jsp/cams/bpt/flow/war/migrate/emigration/idCardSelect.jsp";
	var revalue =  window.showModalDialog(url,"","dialogHeight:"+height+"px;dialogWidth:"+width+"px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		if(revalue==";;;;;;;"){
			$("idCard").value="";
			$("peopleId").value="";
			$("familyId").value="";
			var a= document.getElementsByTagName('label');
			for(var i=0;i<a.length;i++){
				document.getElementsByTagName('label')[i].innerHTML='';
			}
		}else{
			var list = revalue.split(":");
			var idCard = list[0];
			var peopleId = list[1];
			
			document.getElementById("idCard").value = idCard;
			EMigratDataSet.getCurrent().set("idCard",idCard);
			queryByIdCard(peopleId);
		}
	}
}

//根据身份证号查询人员信息和伤残信息
function queryByIdCard(peopleId){
	var idCard = document.getElementById("idCard").value;
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateCommand");
	command.setParameter("peopleId", peopleId);
	command.execute("queryWarEProvinceByPeopleId");
	if(command.getReturn("name") !=undefined){
		
		EMigratDataSet.set("name",command.getReturn("name"));
		EMigratDataSet.set("peopleId",command.getReturn("peopleId"));
		EMigratDataSet.set("familyId",command.getReturn("familyId"));
		document.getElementById("peopleId").value = command.getReturn("peopleId");
		document.getElementById("familyId").value = command.getReturn("familyId");
		EMigratDataSet.set("warTypeCode",command.getReturn("warTypeCode"));
		EMigratDataSet.set("forcesNo",command.getReturn("forcesNo"));
		
		if(command.getReturn("sex") !=undefined){
			EMigratDataSet.set("sex",command.getReturn("sex"));
		}
		if(command.getReturn("position") !=undefined){
			EMigratDataSet.set("position",command.getReturn("position"));
		}
		if(command.getReturn("asdpNo") !=undefined){
			EMigratDataSet.set("asdpNo",command.getReturn("asdpNo"));
		}
	}else{
		L5.Msg.alert('提示','该人员非参战退役军人！');
		$("idCard").value="";
		$("peopleId").value="";
		$("familyId").value="";
		var a= document.getElementsByTagName('label');
		for(var i=0;i<a.length;i++){
			document.getElementsByTagName('label')[i].innerHTML='';
		}
		return false;
	}
}

/*function func_ForDomicileSelect(){
		var ingoingCode = _$("ingoingCode");
		var ingoingName = _$("ingoingName");
		var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicCity.jsp?organCode=370000000000&organName=山东省","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
			 EMigratDataSet.getCurrent().set("ingoingCode",list[0]);
			 EMigratDataSet.getCurrent().set("ingoingName",list[1]);
		}
}*/

   function getCodeAndName(){
		var ingoingCode = _$("ingoingCode");
		var ingoingAddress = _$("ingoingAddress");
		var escapeorganName = escape(encodeURIComponent('中国'));
		var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/comm/diccity/dicPubCant.jsp?organCode=CN&organName="+escapeorganName,"","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
			 EMigratDataSet.getCurrent().set("ingoingCode",list[0]);
			 EMigratDataSet.getCurrent().set("ingoingAddress",list[1]);
		}
}