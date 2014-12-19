var sumTotal=0.0; //总金额-部分
function init() {
	var disFundsSourceDs = L5.DatasetMgr.lookup("disFundsSourceDs");
	disFundsSourceDs.setParameter("SOURCE_ID", sourceId);
	disFundsSourceDs.events['load'] = true;
	disFundsSourceDs.on('load',function(){
		if(disFundsSourceDs.getCount()>0) {
			document.getElementById("amountLbl").innerHTML = formatNum(disFundsSourceDs.getAt(0).get("amountTotal"));
			document.getElementById("amountLblCd").innerHTML = formatNum(disFundsSourceDs.getAt(0).get("amountTotalCentral")+0+disFundsSourceDs.getAt(0).get("amountTotalDepartment"));
			document.getElementById("amountLblCity").innerHTML = formatNum(disFundsSourceDs.getAt(0).get("amountTotalCity"));
		}
	});
	disFundsSourceDs.load();
	
	var disFundsSourceCityDs = L5.DatasetMgr.lookup("disFundsSourceCityDs");
	disFundsSourceCityDs.setParameter("receiveOrganCode", organCode);
	disFundsSourceCityDs.setParameter("sourceId", sourceId);
	disFundsSourceCityDs.setParameter("fundsType", "2");
	disFundsSourceCityDs.setParameter("sourceType", "1,2,3");
	disFundsSourceCityDs.load();
}
//进入拨付维护页面
function onEdit() {
	var editGrid = L5.getCmp("cityGrid");
	var selections = editGrid.getSelectionModel().getSelections();
	if(selections.length != 1) {
		L5.Msg.alert("提示", "请选中一条记录");
		return;
	}
	url = 'fundsAllocationEdit2CityLiveDetails.jsp?sourceId='+selections[0].get("sourceId")+
		'&currentSourceId='+sourceId+'&batchId='+batchId+'&inRef='+selections[0].get("inAlreadyUse")+'&fundsType=2&actionFundsType=2';
	//actionFundsType：标志拨付款项的等级(仅县级)：市款为2，县款为3
		//	alert(url)
	var width = screen.availWidth-200;
    var height = screen.availHeight-100;
	var returnValue = window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:0");
	if(returnValue || returnValue==undefined){
		init();
	}
}
//返回
function onCancel() {
	window.returnValue = "T";
	window.close();
}
//计算和值
function computeSum() {
	sumTotal = 0.0;
	var disFundsSourceCityDs = L5.DatasetMgr.lookup("disFundsSourceCityDs");
	for(var i=0;i<disFundsSourceCityDs.getCount();i++) {
		var rec = disFundsSourceCityDs.getAt(i);
		if(!isNaN(rec.get("amountExtReal")) && rec.get("amountExtReal")!="") {
			sumTotal += (rec.get("amountExtReal")+0.0);
		}
	}
	document.getElementById("amountLblCity").innerHTML = formatNum(sumTotal+"");
	var cd = document.getElementById("amountLblCd").innerHTML;
	if(!isNaN(cd) && cd!='') {
		var at = 0;
		try{
			at = parseFloat(cd);
		}catch(e){}
		document.getElementById("amountLbl").innerHTML = formatNum(sumTotal+at);
	}else {
		document.getElementById("amountLbl").innerHTML = formatNum(sumTotal+"");
	}
}