function init() {
	var disabiltyTemp = L5.DatasetMgr.lookup("disabiltyTemp");
	disabiltyTemp.setParameter("ID",id); //伤残
	disabiltyTemp.load();
	L5.QuickTips.init();
};

function getParam(ElementId) {
	var value = document.getElementById(ElementId).value;
	if (value == "")
		value = undefined;
	return value;
}


function save() {
	var records = disabiltyTemp.getCurrent();
	var command = new L5.Command("com.inspur.cams.bpt.capital.excel.command.ImpExcelCapitalCommand");
	var idCard = document.getElementById("idCard").value;
	
	if(idCard == null || idCard == "") {
		L5.Msg.alert("提示","身份证不能为空");
		return false;
	}
	
	if(!checkIDCard(document.getElementById("idCard"))){
	    L5.Msg.alert("提示", "身份证格式不正确!");
	    return false;
	}
	
	
	command.setParameter("ID_CARD",idCard);
	command.setParameter("REGISTER_TYPE","11");
	command.execute("updateValidateIdcard");
	var validate = command.getReturn("validate");
	if(!validate) {
		L5.Msg.alert("提示","该人员非伤残人员");
		return false;
	} else {
		command.execute("ifRepeat");
		if(command.getReturn("ifRepeat")) {
			L5.Msg.alert("提示","已存在该人员资金发放信息");
			return false;
		}
	}
	
	command.setParameter("record", records);
	command.execute("update");
	if (!command.error) {
		disabiltyTemp.commitChanges();
		L5.Msg.alert('提示', "数据保存成功!");
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}



//校验是否是浮点型数字
function checkIfFload(element){
	var tempValue = element.value;
	if(tempValue != null && tempValue != "") {
		if(!isFloat(element.value)){
			L5.Msg.alert('提示','金额格式不正确');
			disabiltyTemp.getCurrent().set(element.id,"");
			document.getElementById(element.id).value = "";
			return false;
		} else {
			
			var num = tempValue.indexOf(".");
			if(num != -1) {
				num++;
			} else {
				num = tempValue.length;
			}
			if(num >13) {
				L5.Msg.alert('提示','金额过大');
				return false;
			}
		}
	}
}

 

//计算总金额
function computeSumMon(){
	//发放金额
	var grantMon = $("grantMon").innerHTML==''?"0.00":$("grantMon").innerHTML;
	//护理费
	var nursingMon = _$("nursingMon")==''?"0.00":_$("nursingMon");
	//地方补贴小计
	var increaseMechanism = _$("increaseMechanism")==''?"0.00":_$("increaseMechanism");//自然增长机制
	var grainOilMon = _$("grainOilMon")==''?"0.00":_$("grainOilMon");//粮油增发
	var coalSubsidyMon = _$("coalSubsidyMon")==''?"0.00":_$("coalSubsidyMon");//煤补增发
	var antiJapaneseMon = _$("antiJapaneseMon")==''?"0.00":_$("antiJapaneseMon");//抗日增发
	var oldLonelyMon = _$("oldLonelyMon")==''?"0.00":_$("oldLonelyMon");//孤老增发
	var otherSubsidyOne = _$("otherSubsidyOne")==''?"0.00":_$("otherSubsidyOne");//其他补助1
	var otherSubsidyTwo = _$("otherSubsidyTwo")==''?"0.00":_$("otherSubsidyTwo");//其他补助2
	var otherSubsidyThree = _$("otherSubsidyThree")==''?"0.00":_$("otherSubsidyThree");//其他补助3
	var otherSubsidyFour = _$("otherSubsidyFour")==''?"0.00":_$("otherSubsidyFour");//其他补助4
	var otherSubsidyFive = _$("otherSubsidyFive")==''?"0.00":_$("otherSubsidyFive");//其他补助5
	
	var subTotal = Math.ceil((parseFloat(increaseMechanism)+parseFloat(grainOilMon)+parseFloat(coalSubsidyMon)+parseFloat(antiJapaneseMon)+parseFloat(oldLonelyMon)
	+parseFloat(otherSubsidyOne)+parseFloat(otherSubsidyTwo)+parseFloat(otherSubsidyThree)+parseFloat(otherSubsidyFour)+parseFloat(otherSubsidyFive))*100)/100;
	 disabiltyTemp.getCurrent().set("subTotal",subTotal);
	//计算总额
	var grantMonSum = parseFloat(grantMon)+parseFloat(nursingMon)+parseFloat(subTotal);
	disabiltyTemp.getCurrent().set("grantMonSum",grantMonSum);
}

function func_Close() {
	window.close();
}

//通过伤残人员查询窗口取得IdCard&查询相关信息
function getIdCard(){
	var width = screen.width - 100;
	var height = screen.height - 140;
	var url = L5.webPath+'/jsp/cams/bpt/capital/writeregister/disabilitygrant/peopleSelect.jsp';
	var revalue =  window.showModalDialog(url,"","dialogHeight:"+height+"px;dialogWidth:"+width+"px;resizable:no;scroll:yes;");
	if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		var idCard = list[0];
		var name = list[3];
		document.getElementById("idCard").value = idCard;
		disabiltyTemp.getCurrent().set("idCard",idCard);
		document.getElementById("name").value = name;
		disabiltyTemp.getCurrent().set("name",name)
	}
}
