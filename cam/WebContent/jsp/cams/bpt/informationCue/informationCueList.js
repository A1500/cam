function init() {
}

function getParam(ElementId){
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	var domicileCode = getParam("domicileCode");
	if(domicileCode==undefined){
		domicileCode = organCode;
	}
	var ageBegin = document.getElementById("ageBegin").value;
	var ageEnd = document.getElementById("ageEnd").value;
	var reg = /^\d+$/;
	if(ageBegin != null && ageBegin != "") {
		if(ageBegin.match(reg) == null) {
			L5.Msg.alert("提示","起始年龄只能为正整数");
			return false;
		}
	}
	if(ageEnd != null && ageEnd != "") {
		if(ageEnd.match(reg) == null) {
			L5.Msg.alert("提示","截止年龄只能为正整数");
			return false;
		}
		
		if(ageBegin != null && ageEnd != "") {
			if(parseInt(ageEnd) <= parseInt(ageBegin)) {
				L5.Msg.alert("提示","截止年龄不能小于起始年龄");
				return false;
			}
		}
	}  
	RegularInformationCueDataset.setParameter("ageBegin", ageBegin);
	RegularInformationCueDataset.setParameter("ageEnd",ageEnd);
	RegularInformationCueDataset.setParameter("domicileCode",domicileCode);	
	RegularInformationCueDataset.setParameter("name",getParam("name"));		
	RegularInformationCueDataset.setParameter("idCard",getParam("idCard"));		
	RegularInformationCueDataset.setParameter("objectType",getParam("objectType"));		
	//RegularInformationCueDataset.setParameter("cueDateBegin",getParam("cueDateBegin"));		
	//RegularInformationCueDataset.setParameter("cueDateEnd",getParam("cueDateEnd"));	
	RegularInformationCueDataset.setParameter("cueInfoType",getParam("cueInfoType"));		
	RegularInformationCueDataset.setParameter("confirmFlag",getParam("confirmFlag"));		
	RegularInformationCueDataset.load();
	noReclick(RegularInformationCueDataset,"queryButton");  
}


function update(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录确认!");
		return false;
	}
	var commitFlag = selected[0].get("CONFIRM_FLAG");
	var name = selected[0].get("NAME");
	if(commitFlag=='1'){
		L5.Msg.alert('提示',name+"已确认!");
		return false;
	}
	var peopleId = selected[0].get("PEOPLE_ID");
	var objectType = selected[0].get("OBJECT_TYPE");
	var objectState = selected[0].get("OBJECT_STATE");
	
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptRegularInformationCueCommand"); 
	command.setParameter("PEOPLE_ID",peopleId);
	command.setParameter("OBJECT_TYPE",objectType);
	command.execute("update");	
	if (!command.error) {
		L5.MessageBox.confirm('确定', '是否对优抚对象进行状态变更？',function(state){
			if(state=="yes"){
				var data = new L5.Map();
				data.put("peopleId",peopleId);
				data.put("objectState",objectState);
				data.put("objectType",objectType);
				var url='jsp/cams/bpt/stateChangeManage/stateChangeInsert.jsp';
				var text = '修改用户状态';
				L5.forward(url,text,data);
			}else{
				L5.Msg.alert("提示","确认成功！");
				return false;
			}
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
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
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("INFORMATION_CUE_ID");
			}
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptRegularInformationCueCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	RegularInformationCueDataset.remove(selected[i]);
				}
				RegularInformationCueDataset.commitChanges();
			}else{
				L5.Msg.alert('提示',"删除时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}

function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("objectType").value = "";
	document.getElementById("cueDateBegin").value = "";
	document.getElementById("cueDateEnd").value = "";
	document.getElementById("cueInfoType").value = "";
	document.getElementById("confirmFlag").value = "";
}

function forHelp() {
	var revalue = window.showModalDialog(L5.webPath
					+ "/jsp/cams/comm/diccity/dicCity.jsp?organCode="
					+ organCode + "&radioMaxlevel=0&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[4];
	}
}

function forHelpOT() {
	var revalue = window.showModalDialog(L5.webPath+"/jsp/cams/bpt/dicobjecttype/dicobjecttype.jsp");
	 
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		var listTypeId = list[0].split(",");
		document.getElementById("objectType").value = list[0];
		document.getElementById("objectTypeName").value = list[1];
	}
}

function formatDate(value){
	if(value!=''){
		value = value.substr(0,10);
	}
	return value;
}

//查看人员基本信息   openBptPeopleDetail:bptComm.js中
function peopleDetail(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:openBptPeopleDetail(\'' + record.data["PEOPLE_ID"] + '\',\''+record.data["NAME"]+'\',\''+record.data["ID_CARD"]+'\',\''+record.data["OBJECT_TYPE"]+'\')">' + value + '</a>';
}
