function init(){
	var fisPriceGoodsServiceDS=L5.DatasetMgr.lookup("fisPriceGoodsServiceDS");
	if(method=="insert"){
		fisPriceGoodsServiceDS.newRecord();
		//获取序号
		var numcommand=new L5.Command("com.inspur.cams.fis.ex.cmd.FisPriceGoodsServiceCommand");
		numcommand.setParameter("feeID",feeID);
		numcommand.execute("getNumber");
		var num = numcommand.getReturn("maxNum");
		if(num==0){
			num=parseInt(num)+1;
		}else{
			num=parseInt(num)+5;
		}
		document.getElementById("scq").value=num;
	}else if(method == "update"){
		document.getElementById("conBtn").style.display = 'none';
		fisPriceGoodsServiceDS.setParameter("WORK_ID@=",workId);//服务项目ID
		fisPriceGoodsServiceDS.load(true);
		var priceType=fisPriceGoodsServiceDS.getCurrent().get("priceType");
		if(priceType=="0"){
			document.getElementById("a1").style.display = '';
			document.getElementById("a2").style.display = '';
		}else if(priceType=="1"){
			document.getElementById("a3").style.display = '';
		}
		var workType=fisPriceGoodsServiceDS.getCurrent().get("workType");
		var feeType=fisPriceGoodsServiceDS.getCurrent().get("feeType");
		if(workType=="0"){
			document.getElementById("feeType1").style.display = '';
			document.getElementById("feeType1").value=feeType;
		}else if(workType=="1"){
			document.getElementById("feeType2").style.display = '';
			document.getElementById("feeType2").value=feeType;
		}
		document.getElementById("priceType").style.display='';
		if(feeType=="01"){
			document.getElementById("a5").style.display='';
			document.getElementById("a6").style.display='';
			document.getElementById("a7").style.display='';
			document.getElementById("priceType").style.display='none';
		}
		if(feeType=="03"){
			document.getElementById("a1").style.display='';
			document.getElementById("a2").style.display='';
			document.getElementById("a8").style.display='';
			document.getElementById("range").value="";
		}
		document.getElementById("a4").style.display='';
		if(document.getElementById("remiss").checked){
			document.getElementById("remissShow").style.display="";
		}
		document.getElementById("workType").disabled="disabled"
		document.getElementById("feeType1").disabled="disabled"
		document.getElementById("feeType2").disabled="disabled"
	}else if(method == "detail"){
		fisPriceGoodsServiceDS.setParameter("WORK_ID@=",workId);//服务项目ID
		fisPriceGoodsServiceDS.load(true);
		var record = fisPriceGoodsServiceDS.getCurrent();
		var feeType = record.get("feeType");
		var priceType=record.get("priceType");
		if(feeType=="01"){
			document.getElementById("a5").style.display='';
			document.getElementById("a6").style.display='';
			document.getElementById("a7").style.display='';
		}else if(feeType=="03"){
			document.getElementById("a1").style.display='';
			document.getElementById("a2").style.display='';
			document.getElementById("a8").style.display='';
		}else{
			document.getElementById("a9").style.display='';
		}
		document.getElementById("a4").style.display='';
		if(priceType=="0"){
			document.getElementById("a1").style.display = '';
			document.getElementById("a2").style.display = '';
		}else if(priceType=="1"){
			document.getElementById("a3").style.display = '';
		}
	}else if(method == "check"){
		fisPriceGoodsServiceDS.setParameter("WORK_ID@=",workId);//服务项目ID
		fisPriceGoodsServiceDS.load(true);
		var record = fisPriceGoodsServiceDS.getCurrent();
		var feeType = record.get("feeType");
		var priceType=record.get("priceType");
		if(feeType=="01"){
			document.getElementById("a5").style.display='';
			document.getElementById("a6").style.display='';
			document.getElementById("a7").style.display='';
		}else if(feeType=="03"){
			document.getElementById("a8").style.display='';
		}else{
			document.getElementById("a4").style.display='';
			document.getElementById("a9").style.display='';
		}
	}
}
function save(){
	var fisPriceGoodsServiceDS=L5.DatasetMgr.lookup("fisPriceGoodsServiceDS");
	var record=fisPriceGoodsServiceDS.getCurrent();
	var valid=fisPriceGoodsServiceDS.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	if(document.getElementById("serviceName").value==""){
		L5.Msg.alert("提示","项目名称不能为空！");
		return;
	}
	if(document.getElementById("range").value>30){
		L5.Msg.alert("提示","浮动区间不能大于30%！");
		return;
	}
	var workType = document.getElementById("workType").value;
	var feeType1 = document.getElementById("feeType1").value;
	var feeType2 = document.getElementById("feeType2").value;
	var note = document.getElementById("note").value;
	var command=new L5.Command("com.inspur.cams.fis.ex.cmd.FisPriceGoodsServiceCommand");
	if(method == "insert"){
		record.set("workId",newWorkId);//新增服务项目
		record.set("workType",workType);
		if(workType=="0"){
			record.set("feeType",feeType1);
		}else if(workType=="1"){
			record.set("feeType",feeType2);
		}
		var feeType=record.get("feeType");
		if(feeType=="03"){
			record.set("range",document.getElementById("range1").value);
		}else{
			record.set("range",document.getElementById("range").value);
		}
		record.set("remissionDesc",document.getElementById("remissionDesc").innerHTML);
		record.set("funeralCode",funeralCode);//殡仪馆编号
		record.set("funeralName",funeralName);//殡仪馆名称
		record.set("feeItemId",feeID);//业务批次编号
		record.set("createOrgan",organCode);//登记单位编号
		record.set("createOrganName",organName);//登记单位名称
		record.set("inUse","1");//1：可用，0：不可用
		record.set("scq",document.getElementById("scq").value);//序号
		if(document.getElementById("invoiceCodeType0").checked==true){
			record.set("invoiceCodeType","0");//收费性质
		}else if(document.getElementById("invoiceCodeType1").checked==true){
			record.set("invoiceCodeType","1");//收费性质
		}
		record.set("createTime",time);
		record.set("price",document.getElementById("price").value);
		record.set("priceDesc",document.getElementById("priceDesc").innerHTML);
		record.set("units",document.getElementById("units").value);
		command.setParameter("record",record);
		command.execute("insert");
		if (!command.error){
			L5.Msg.alert("提示","保存成功！",function(){
			returnBack();
			});
		}else{
			L5.Msg.alert("提示","保存出错！"+command.error);
		}
	}else if(method == "update"){
		record.set("workType",workType);
		if(workType=="0"){
			record.set("feeType",feeType1);
		}else if(workType=="1"){
			record.set("feeType",feeType2);
		}
		var feeType=record.get("feeType");
		if(feeType=="03"){
			record.set("range",document.getElementById("range1").value);
		}else{
			record.set("range",document.getElementById("range").value);
		}
		record.set("price",document.getElementById("price").value);
		record.set("priceDesc",document.getElementById("priceDesc").innerHTML);
		record.set("units",document.getElementById("units").value);
		record.set("scq",document.getElementById("scq").value);//序号
		if(document.getElementById("invoiceCodeType0").checked==true){
			record.set("invoiceCodeType","0");//收费性质
		}else if(document.getElementById("invoiceCodeType1").checked==true){
			record.set("invoiceCodeType","1");//收费性质
		}
		record.set("remissionDesc",document.getElementById("remissionDesc").innerHTML);
		command.setParameter("record",record);
		command.execute("update");
		if (!command.error){
			L5.Msg.alert("提示","保存成功！",function(){
			returnBack();
			});
		}else{
			L5.Msg.alert("提示","保存出错！"+command.error);
		}
	}
}
function saveClickContinue() {
	var fisPriceGoodsServiceDS=L5.DatasetMgr.lookup("fisPriceGoodsServiceDS");
	var record=fisPriceGoodsServiceDS.getCurrent();
	var valid=fisPriceGoodsServiceDS.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	if(document.getElementById("serviceName").value==""){
		L5.Msg.alert("提示","项目名称不能为空");
		return;
	}
	if(document.getElementById("range").value>30){
		L5.Msg.alert("提示","浮动区间不能大于30%！");
		return;
	}
	var workType = document.getElementById("workType").value;
	var feeType1 = document.getElementById("feeType1").value;
	var feeType2 = document.getElementById("feeType2").value;
	var note = document.getElementById("note").value;
	if(workType=="0"&&(feeType1=="01"||feeType1=="03")&&note==""){
		L5.Msg.alert("提示","接运或火化费用备注为必填项");
		return;
	}
	if(workType=="1"&&(feeType2=="01"||feeType2=="03")&&note==""){
		L5.Msg.alert("提示","接运或火化费用备注为必填项");
		return;
	}
	var command=new L5.Command("com.inspur.cams.fis.ex.cmd.FisPriceGoodsServiceCommand");
	if(method == "insert"){
		var workType = document.getElementById("workType").value;
		record.set("workId",newWorkId);//新增服务项目
		record.set("workType",workType);
		if(workType=="0"){
			record.set("feeType",document.getElementById("feeType1").value);
		}else if(workType=="1"){
			record.set("feeType",document.getElementById("feeType2").value);
		}else if(workType=="2"){
			record.set("feeType",document.getElementById("feeType3").value);
		}
		record.set("remissionDesc",document.getElementById("remissionDesc").innerHTML);
		record.set("funeralCode",funeralCode);//殡仪馆编号
		record.set("funeralName",funeralName);//殡仪馆名称
		record.set("feeItemId",feeID);//业务批次编号
		record.set("createOrgan",organCode);//登记单位编号
		record.set("createOrganName",organName);//登记单位名称
		record.set("inUse","1");//1：可用，0：不可用
		record.set("scq",document.getElementById("scq").value);//序号
		if(document.getElementById("invoiceCodeType0").checked==true){
			record.set("invoiceCodeType","0");//收费性质
		}else if(document.getElementById("invoiceCodeType1").checked==true){
			record.set("invoiceCodeType","1");//收费性质
		}
		record.set("createTime",time);
		record.set("price",document.getElementById("price").value);
		record.set("priceDesc",document.getElementById("priceDesc").innerHTML);
		record.set("units",document.getElementById("units").value);
		record.set("range",document.getElementById("range").value);
		command.setParameter("record",record);
		command.execute("insert");
		if (!command.error){
			L5.Msg.alert("提示","保存成功！",function(){
				var data=new L5.Map();
				data.put("method","insert");
				data.put("feeID",feeID);//业务批次ID
				data.put("funeralCode",funeralCode);//馆编号
				data.put("funeralName",encodeURIComponent(encodeURIComponent(funeralName)));//馆名称
				var url="jsp/cams/fis/ex/fisDetailsList.jsp";
				L5.forward(url,'',data);
			});
		}else{
			L5.Msg.alert("提示","保存出错！"+command.error);
		}
	}
}
function returnBack(){
	history.go(-1);
}
function selectFeeType(value){
	if(value=="0"){
		document.getElementById("feeType1").style.display = '';
		document.getElementById("feeType2").style.display = 'none';
		//document.getElementById("feeType3").style.display = 'none';
		document.getElementById("invoiceCodeType0").checked=true;
		document.getElementById("invoiceCodeType0").disabled='disabled';
		document.getElementById("invoiceCodeType1").disabled='disabled';
	}else if(value=="1"){
		document.getElementById("feeType2").style.display = '';
		document.getElementById("feeType1").style.display = 'none';
		document.getElementById("invoiceCodeType0").checked=false;
		document.getElementById("invoiceCodeType0").disabled='';
		document.getElementById("invoiceCodeType1").disabled='';
	}
}

function changeFeeType(value){
	var fisPriceGoodsServiceDS=L5.DatasetMgr.lookup("fisPriceGoodsServiceDS");
	if(value=="01"||value==""){
		document.getElementById("priceType").style.display='none';
		document.getElementById("a4").style.display='';
		document.getElementById("a1").style.display='none';
		document.getElementById("a2").style.display='none';
		document.getElementById("a3").style.display='none';
		document.getElementById("a8").style.display='none';
		document.getElementById("a5").style.display='';
		document.getElementById("a6").style.display='';
		document.getElementById("a7").style.display='';
		fisPriceGoodsServiceDS.set("priceType","");
		fisPriceGoodsServiceDS.set("price","");
		fisPriceGoodsServiceDS.set("units","");
		fisPriceGoodsServiceDS.set("range","");
	}else if(value=="03"){
		document.getElementById("priceType").style.display='';
		fisPriceGoodsServiceDS.set("priceType","0");
		document.getElementById("a1").style.display='';
		document.getElementById("a2").style.display='';
		document.getElementById("a4").style.display='';
		document.getElementById("a3").style.display='none';
		document.getElementById("a5").style.display='none';
		document.getElementById("a6").style.display='none';
		document.getElementById("a7").style.display='none';
		document.getElementById("a8").style.display='';
	}else if(value!="01"&&value!="03"&&value!=""){
		document.getElementById("priceType").style.display='';
		document.getElementById("a4").style.display='';
		document.getElementById("a5").style.display='none';
		document.getElementById("a6").style.display='none';
		document.getElementById("a7").style.display='none';
		document.getElementById("a8").style.display='none';
		fisPriceGoodsServiceDS.set("initiateMile","");
		fisPriceGoodsServiceDS.set("initiatePrice","");
		fisPriceGoodsServiceDS.set("overinitiatePrice","");
	}
	fisPriceGoodsServiceDS.set("priceDesc","");
	document.getElementById("priceDesc").innerHTML="";
}
function selectPriceType(){
	if(document.getElementById("priceType0").checked==true){
		document.getElementById("a1").style.display = '';
		document.getElementById("a2").style.display = '';
		document.getElementById("a3").style.display = 'none';
		document.getElementById("range").value = '';
		document.getElementById("priceDesc").innerHTML = '';
		var workType = document.getElementById("workType").value;
		if(workType=="0"){
			var feeType = document.getElementById("feeType1").value;
			if(feeType=="03"){
				document.getElementById("a8").style.display = '';
			}
		}
		if(workType=="1"){
			var feeType = document.getElementById("feeType2").value;
			if(feeType=="03"){
				document.getElementById("a8").style.display = '';
			}
		}
	}else if(document.getElementById("priceType1").checked==true){
		document.getElementById("a1").style.display = 'none';
		document.getElementById("a2").style.display = 'none';
		document.getElementById("a8").style.display = 'none';
		document.getElementById("a3").style.display = '';
		document.getElementById("price").value = '';
		document.getElementById("units").value = '';
		document.getElementById("priceDesc").innerHTML = '';
	}
}
//计算收费标准（定额）
function checkPriceDesc(){
	var price=document.getElementById("price").value;//定价金额
	var units=document.getElementById("units").value;//定价单位
	var priceMax=document.getElementById("priceMax").value;//浮动区间
	var priceMin=document.getElementById("priceMin").value;//浮动区间
	if(document.getElementById("a8").style.display=="none"){
		if(priceMin!=""&&priceMax!=""){
			document.getElementById("priceDesc").innerHTML="最低价格为"+priceMin+units+",最高价格为"+priceMax+units;
		}else{
			document.getElementById("priceDesc").innerHTML=price+units;
		}
		
	}
}
//计算收费标准（浮动）
function checkPriceDesc1(){
	var range=document.getElementById("range").value;//浮动区间
	if(range!=""){
		document.getElementById("priceDesc").innerHTML="加价幅度不超过实际购货价格的"+range+"%。";
		document.getElementById("a2").style.display="none";
		document.getElementById("priceMin").value="";
		document.getElementById("priceMax").value="";
	}
	
}

//计算收费标准（浮动）
function checkPriceDesc3(){
	var price=document.getElementById("price").value;//定价金额
	var units=document.getElementById("units").value;//定价单位
	var range1 = document.getElementById("range1").value;//定价单位
	document.getElementById("priceDesc").innerHTML=price+units+",加收"+range1+"%";
	
}
//计算收费标准（浮动）
function checkPriceDesc2(){
	var priceMin=document.getElementById("priceMin").value;//浮动区间
	var priceMax=document.getElementById("priceMax").value;//浮动区间
	document.getElementById("range").value="";
	document.getElementById("a2").style.display="";
}

//计算政府减免标准
function checkRemissionDesc(){
	var remissionMoney=document.getElementById("remissionMoney").value;//减免金额
	var remissionUnits=document.getElementById("remissionUnits").value;//减免单位
	document.getElementById("remissionDesc").innerHTML=remissionMoney+remissionUnits;
}
function CheckTxt(ObjNum, ChnName) {
	var regExp = /^\d+(\.\d+)?$/;
	var elementTxt = document.getElementById(ObjNum);
	if(elementTxt.value!=""){
		if (regExp.test(elementTxt.value)) {
			return true;
		} else {
			L5.Msg.alert("提示","【"+ ChnName + "】请输入阿拉伯数字!");
			elementTxt.focus();
			elementTxt.value = "";
			return false;
		}
	}
	
}

//校验是否数字
function _isNum(s){
	if(s!=""){
		if(!/^[0-9]+$/.test(s)){
			alert("序号只能为数字!");
			document.getElementById("scq").value="";
			return;
		}
	}
}

function changeNote(){
	var initiateMile=document.getElementById("initiateMile").value;
	var initiatePrice=document.getElementById("initiatePrice").value;
	var overinitiatePrice=document.getElementById("overinitiatePrice").value;
	var fisPriceGoodsServiceDS=L5.DatasetMgr.lookup("fisPriceGoodsServiceDS");
	var note=initiateMile+"公里内，收费为"+initiatePrice+"元，超出部分，每公里加收"+overinitiatePrice+"元";
	fisPriceGoodsServiceDS.set("priceDesc",note);
}

function showRemiss(obj){
	if(obj.checked){
		document.getElementById("remissShow").style.display="";
	}else{
		document.getElementById("remissShow").style.display='none';
		var fisPriceGoodsServiceDS=L5.DatasetMgr.lookup("fisPriceGoodsServiceDS");
		fisPriceGoodsServiceDS.set("remissionDetail","");
	}
}