//查看人员信息
function getPeopleInfo(peopleId,applyId,assistanceType){
	var url;
	var win;
	if(peopleId == "" || peopleId == undefined){
		L5.Msg.alert("提示","人员信息不存在！");
		return;
	}
	if(assistanceType == "01"){
		url="../comm/samCityResidentsPeopleDetail.jsp?peopleId="+peopleId+'&applyId='+applyId;
		win=window.showModalDialog(url,window,"dialogHeight:636px;dialogWidth:1022px;resizable:no;scroll:yes;status:no;");
	}else if(assistanceType == "02"){
		url="../comm/samRuralResidentsPeopleDetail.jsp?peopleId="+peopleId+'&applyId='+applyId;
		win=window.showModalDialog(url,window,"dialogHeight:636px;dialogWidth:1022px;resizable:no;scroll:yes;status:no;");
	}else if(assistanceType == "03"){
		url="../comm/samRuralAreasPeopleDetail.jsp?peopleId="+peopleId+'&applyId='+applyId;
		win=window.showModalDialog(url,window,"dialogHeight:427px;dialogWidth:1022px;resizable:no;scroll:yes;status:no;");
	}
}

//查看家庭信息
function getFamilyInfo(treatmentId,assistanceType,applyId){
	var url;
	var win;
	if(treatmentId == "" || treatmentId == undefined){
		L5.Msg.alert("提示","家庭信息不存在！");
		return;
	}
	var width = screen.width-100;
    var height = screen.height-140;
	if(assistanceType == "01"){
		url="../comm/samCityResidentsFamilyDetail.jsp?treatmentId="+treatmentId+"&assistanceType="+assistanceType+"&applyId="+applyId;
	}else if(assistanceType == "02"){
		url="../comm/samRuralResidentsFamilyDetail.jsp?treatmentId="+treatmentId+"&assistanceType="+assistanceType+"&applyId="+applyId;
	}else if(assistanceType == "03"){
		url="../comm/samRuralAreasFamilyDetail.jsp?treatmentId="+treatmentId+"&assistanceType="+assistanceType+"&applyId="+applyId;
	}
	var win=window.showModalDialog(url,window,"dialogHeight:"+height+"px;dialogWidth:"+width+"px;resizable:no;scroll:yes;status:no;");
}