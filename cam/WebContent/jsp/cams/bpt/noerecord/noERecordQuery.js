function init() {
	L5.Ajax.timeout=300000;
	document.getElementById("objectState").value='2';
	L5.QuickTips.init();
	NoERecordDataset1.on("load",function(ds){
		fields1="B32,B2,B5,B4,B1,B29,B30";
		L5.dataset2excel(ds,"/jsp/cams/bpt/peopleBasicInfo/excel/bptPeople_excel.jsp?fields="+fields1);
	});
};

function getParam(ElementId){
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}

// 查询
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
	NoERecordDataset.setParameter("ageBegin", ageBegin);
	NoERecordDataset.setParameter("ageEnd",ageEnd);
	NoERecordDataset.setParameter("domicileCode",domicileCode);	
	NoERecordDataset.setParameter("name",getParam("name"));		
	NoERecordDataset.setParameter("idCard",getParam("idCard"));		
	NoERecordDataset.setParameter("objectType",getParam("objectType"));		
	NoERecordDataset.setParameter("objectState",getParam("objectState"));	
	NoERecordDataset.load();
	noReclick(NoERecordDataset,"queryButton");  
}



// 重置查询条件
function reset(){
	document.getElementById("domicileCode").value = "";
	document.getElementById("name").value = "";
	document.getElementById("idCard").value = "";
	document.getElementById("objectType").value = "";
	document.getElementById("objectState").value = "2";
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
	if(revalue==';;;;;;;'){
		document.getElementById("objectType").value = "";
		document.getElementById("objectTypeName").value = "";
	}else if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		var objectTypeList = list[0].split(",");
		var listLength = objectTypeList.length;
		var objectTypeEnd = ',';
		if(listLength>0){
			for(var i=0;i<listLength;i++){
				switch(objectTypeList[i]){
					case '1':
						objectTypeEnd = objectTypeEnd + "11,12,13,14,15,";
						break;
					case '2':
						objectTypeEnd = objectTypeEnd + "21,22,23,";
						break;
					case '5':
						objectTypeEnd = objectTypeEnd + "51,";
						break;
					case '6':
						objectTypeEnd = objectTypeEnd + "61,";
						break;
					case '8':
						objectTypeEnd = objectTypeEnd + "81,";
						break;
					default:
						objectTypeEnd = objectTypeEnd + objectTypeList[i]+",";
				}
			}
		}
		document.getElementById("objectType").value = objectTypeEnd;
		document.getElementById("objectTypeName").value = list[1];
	}
}

function empToExcel(){

}

function formatDate(value){
	if(value!=''){
		value = value.substr(0,10);
	}
	return value;
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
	var url = L5.webPath+"/jsp/cams/bpt/peopleBasicInfo/basicInfoUpdate.jsp?peopleId="+peopleId+"&familyId="+familyId+"&username="+username+"&idCard="+idCard+"&objectState=2&objectType="+objectType;
	var width = screen.width-60;
	var height = 580;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
	if (win==null) {
		return;
	}
}
function excel_imp(){
	var NoERecordDataset1=L5.DatasetMgr.lookup("NoERecordDataset1");
	var domicileCode = getParam("domicileCode");
	if(domicileCode==undefined){
		domicileCode = organCode;
	}
	NoERecordDataset1.setParameter("ageBegin", getParam("ageBegin"));
	NoERecordDataset1.setParameter("ageEnd",getParam("ageEnd"));
	NoERecordDataset1.setParameter("domicileCode",domicileCode);	
	NoERecordDataset1.setParameter("name",getParam("name"));		
	NoERecordDataset1.setParameter("idCard",getParam("idCard"));		
	NoERecordDataset1.setParameter("objectType",getParam("objectType"));		
	NoERecordDataset1.setParameter("objectState",getParam("objectState"));	
	NoERecordDataset1.setParameter("organCode",organCode);
	NoERecordDataset1.load();
	noReclick(NoERecordDataset1,"excelButton");
}
