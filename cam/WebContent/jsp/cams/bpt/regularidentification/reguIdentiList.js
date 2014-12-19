function init() {
	
	var date=new Date();
	var year=""+date.getFullYear();
	document.getElementById("year").value = year;
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	
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
		
		if(ageBegin != null && ageBegin != "") {
			if(parseInt(ageEnd) <= parseInt(ageBegin)) {
				L5.Msg.alert("提示","截止年龄不能小于起始年龄");
				return false;
			}
		}
	}  
	
	var domicileCode = getParam("domicileCode");
	var name = getParam("name");
	var idCard = getParam("idCard");
	//var ageBegin = getParam("ageBegin");
	//var ageEnd = getParam("ageEnd");
	var year = getParam("year");
	var objectState = getParam("objectState");
	var objectType = getParam("objectType");
	var identiFlag = getParam("identiFlag");
	
	RegularIdentificationDataset.setParameter("ageBegin", ageBegin);
	RegularIdentificationDataset.setParameter("ageEnd",ageEnd);
	RegularIdentificationDataset.setParameter("domicileCode",domicileCode);
	RegularIdentificationDataset.setParameter("name",name);
	RegularIdentificationDataset.setParameter("idCard",idCard);
	//BPTObjectInfoDataSet.setParameter("ageBegin",ageBegin);
	//BPTObjectInfoDataSet.setParameter("ageEnd",ageEnd);
	RegularIdentificationDataset.setParameter("objectState",objectState);
	RegularIdentificationDataset.setParameter("objectType",objectType);
	RegularIdentificationDataset.setParameter("year",year);
	RegularIdentificationDataset.setParameter("identiFlag",identiFlag);
	RegularIdentificationDataset.setParameter("organCode",organCode);
	RegularIdentificationDataset.load();
	noReclick(RegularIdentificationDataset,"queryButton");
}

function reset(){
	document.getElementById("domicileName").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("year").value = "";
	//document.getElementById("ageBegin").value = "";
	//document.getElementById("ageEnd").value = "";
	document.getElementById("objectState").value = "";
	document.getElementById("objectType").value = "";
	document.getElementById("identiFlag").value = "";
}

function identification(){
	var editGrid=L5.getCmp('RegulaIdentiGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要认证的记录!");
		return false;
	}
	var year = document.getElementById("year").value;
	
	for(var i=0;i<selected.length;i++){
		var name = selected[i].get("NAME");
		var peopleId = selected[i].get("PEOPLE_ID");
	//在此重新检索，目的在于获取最新的值	
		var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptRegularIdentificationCommand");
		command.setParameter("peopleId",peopleId);
		command.execute("whetherIdentification");
		
		var identiFlag = command.getReturn("identiFlag");
//		var identiFlag = selected[i].get("IDENTI_FLAG");
		if(identiFlag=='1'){
			L5.Msg.alert('提示',name+"在"+year+"年已验证！");
			return false;
		}
	}
	L5.MessageBox.confirm('确定', '确定要认证选中的记录吗?',function(state){
		if(state=="yes"){
			var  peopleId=[];
			for(var i=0;i<selected.length;i++){
				peopleId[i]=selected[i].get("PEOPLE_ID");
				/*var identiFlag = selected[i].get("IDENTI_FLAG");
				var name = selected[i].get("NAME");
				if(identiFlag=='1'){
					L5.Msg.alert('提示',name+"在"+year+"年已验证！");
					return false;
				}*/
			}
			var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptRegularIdentificationCommand");
			command.setParameter("peopleId", peopleId);
			command.execute("batchIdenti");
			if (!command.error) {
				L5.MessageBox.confirm('确定',' 认证成功！ 是否进行状态变更？',function(sta){
					if(sta=='yes'){
						var peopleId = selected[0].get("PEOPLE_ID");
						var objectState = selected[0].get("OBJECT_STATE");
						var objecType = selected[0].get("OBJECT_TYPE");
						var data = new L5.Map();
						data.put("peopleId",peopleId);
						data.put("objectState",objectState);
						data.put("objectType",objecType);
						var url = "jsp/cams/bpt/peopleBasicInfo/stateChangeInsert.jsp";
				//		var url = "jsp/cams/bpt/stateChangeManage/stateChangeInsert.jsp";
						var text = "状态变更";
						L5.forward(url,text,data);
					}else{
						return false;
					}
				});
			}else{
				L5.Msg.alert('提示'," 认证时出现错误！"+command.error);
				return false;
			}
		}else{
			return false;
		}
	});
}

//查看人员基本信息
function peopleDetail(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:openDetail(\'' + record.data["PEOPLE_ID"] + '\',\''+record.data["NAME"]+'\',\''+record.data["ID_CARD"]+'\',\''+record.data["OBJECT_TYPE"]+'\')">' + value + '</a>';
}

function openDetail(peopleId,username,idCard,objectType){
	var command = new L5.Command("com.inspur.cams.bpt.bptrecuperate.cmd.BptRecuperateCommand");
	command.setParameter("PEOPLE_ID", peopleId)
	command.execute("queryPeopleIdByFamilyId");
	var familyId = command.getReturn("familyId");
	var url = L5.webPath+"/jsp/cams/bpt/basicInfoView/basicInfoDetail.jsp?peopleId="+peopleId+"&familyId="+familyId+"&username="+name+"&idCard="+idCard+"&objectState=2&objectType="+objectType;
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if (win==null) {
		return;
	}
}

/**
 * 属地行政区划窗口
 */
function forHelp(){
		if (organCode != null && organCode != "") {
			var command = new L5.Command("com.inspur.cams.comm.diccity.cmd.DicCityCommand");
			command.setParameter("ID", organCode);
			command.execute("findOrganName");
			var fullName = command.getReturn("organName");
			if (fullName != null && fullName != "") {
				organName = fullName;
			}
		}
		//var revalue=window.showModalDialog("../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=1&organType=1&isExact=0&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		var revalue = window.showModalDialog(L5.webPath+ "/jsp/cams/comm/diccity/dicCity.jsp?organCode="+ organCode + "&radioMaxlevel=0&organName="+ escape(encodeURIComponent(organName)), "","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
		}
}
