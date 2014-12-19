function init(){
	var economyDataSet=L5.DatasetMgr.lookup("economyDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	if(method=="insert"){
		document.getElementById("backInsert").style.display = "block";
		economyDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N","communityNum":"1"});
		reportWorkDataSet.setParameter("organCode", organCode);
		reportWorkDataSet.load();
	}else{
		document.getElementById("backInsert").style.display = "none";
		$("reportDate").disabled=true;
		economyDataSet.setParameter("RECORD_ID@=",recordId);
		economyDataSet.load();
		reportWorkDataSet.load();
	}
}
function forInsert(){
	var economyDataSet=L5.DatasetMgr.lookup("economyDataSet");
	economyDataSet.removeAll();
	economyDataSet.setParameter("ORGAN_CODE@=", organCode);
	economyDataSet.setParameter("sort","CREATE_TIME");	
	economyDataSet.setParameter("dir","desc");
	economyDataSet.load();
	economyDataSet.on("load",function(){
		if (economyDataSet.getCount()>0){
		var record=economyDataSet.getCurrent();
	var ifNegative = Number(document.getElementById("incomeMon").value)+Number(document.getElementById("claimMon").value)
	-Number(document.getElementById("debtMon").value);
	if(ifNegative<0){
		record.set("ifNegative","1");
	}else{
		record.set("ifNegative","0");
	}
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				economyDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"communityNum":"1","reportType":"N"});
			});
		}
	});
	
}
function save(){
	if(document.getElementById("gdpMon").value==""){
		L5.Msg.alert("提示","生产总值不能为空！");
		return;
	}
	if(document.getElementById("agricultureMon").value==""){
		L5.Msg.alert("提示","农业产值不能为空！");
		return;
	}
	if(document.getElementById("personMon").value==""){
		L5.Msg.alert("提示","人均纯收入不能为空！");
		return;
	}
	if(document.getElementById("incomeMon").value==""){
		L5.Msg.alert("提示","收入总额不能为空！");
		return;
	}
	if(document.getElementById("claimMon").value==""){
		L5.Msg.alert("提示","债权总额不能为空！");
		return;
	}
	if(document.getElementById("debtMon").value==""){
		L5.Msg.alert("提示","债务总额不能为空！");
		return;
	}
	if(document.getElementById("fixedMon").value==""){
		L5.Msg.alert("提示","固定资产总值不能为空！");
		return;
	}
	var economyDataSet=L5.DatasetMgr.lookup("economyDataSet");
	var record=economyDataSet.getCurrent();
	ifNegative();
	if(record.get("reportDate")==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
	var isValidate = economyDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcEconomyInfoCmd");
	command.setParameter("record",record);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			var url="jsp/ext/cdc/manage/economy/vcdcEconomyInfoList.jsp";
			L5.forward(url,'',null);
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function returnBack(){
	L5.MessageBox.confirm("提示", "是否保存数据？",function(sta){
		if(sta=="yes"){
			save();
		}else{
			var url="jsp/ext/cdc/manage/economy/vcdcEconomyInfoList.jsp";
			L5.forward(url,'',null);
		}
	});
}
function ifNegative(){
	if(document.getElementById("incomeMon").value==""){
		return;
	}
	if(document.getElementById("claimMon").value==""){
		return;
	}
	if(document.getElementById("debtMon").value==""){
		return;
	}
	var economyDataSet=L5.DatasetMgr.lookup("economyDataSet");
	var record=economyDataSet.getCurrent();
	var ifNegative = Number(document.getElementById("incomeMon").value)+Number(document.getElementById("claimMon").value)
	-Number(document.getElementById("debtMon").value);
	if(ifNegative<0){
		record.set("ifNegative","1");
	}else{
		record.set("ifNegative","0");
	}
}


//如是小数，保留到两位
function fordecimalcheck(item){
	var offOtherMon=item.value;
	if (offOtherMon > ""){ 
	   var reg=/^\d+(\.\d{0,2})?$/; 
	  /* var strP = /^\d/;
	   if(!strP.test(offOtherMon)){
	   		L5.Msg.alert("提示","请输入数字！");
	   		return;
	   }else*/
	   if ((offOtherMon.match(reg)== null)){ 
	    L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
	    item.focus();
	    }); 
	    item.value="";
	  
	    return ; 
	 	}
	}
}

//如是小数，保留到两位
function fornegcheck(item){
	var offOtherMon=item.value;
	if (offOtherMon > ""){ 
	   var reg=/^\d+(\.\d{0,2})?$/; 
	   /*var strP = /^\d/;
	   if(!strP.test(offOtherMon)){
	   		L5.Msg.alert("提示","请输入数字！");
	   		return;
	   }else*/
	   if ((offOtherMon.match(reg)== null)){ 
	    L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
	    item.focus();
	    }); 
	    item.value="";
	    return ; 
	 	}else{
	 		ifNegative();
	 	}
	}
}