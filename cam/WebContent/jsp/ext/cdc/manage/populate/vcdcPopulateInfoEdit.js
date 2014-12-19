function init(){
	var populateDataSet=L5.DatasetMgr.lookup("populateDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	if(method=="insert"){
		document.getElementById("backInsert").style.display = "block";
	
		populateDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"communityNum":"1","reportType":"N"});
		reportWorkDataSet.setParameter("organCode", organCode);
		reportWorkDataSet.load();
	}else{
		document.getElementById("backInsert").style.display = "none";
	
		$("reportDate").disabled=true;
		populateDataSet.setParameter("RECORD_ID@=",recordId);
		populateDataSet.load();
		reportWorkDataSet.load();
	}
}
function forInsert(){
	var populateDataSet=L5.DatasetMgr.lookup("populateDataSet");
	populateDataSet.removeAll();
	populateDataSet.setParameter("ORGAN_CODE@=", organCode);
	populateDataSet.setParameter("sort","CREATE_TIME");	
	populateDataSet.setParameter("dir","desc");
	populateDataSet.load();
	populateDataSet.on("load",function(){
		if (populateDataSet.getCount()>0){
		
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				populateDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"communityNum":"1","reportType":"N"});
			});
		}
	});
	
}
function save(){
	var populateDataSet=L5.DatasetMgr.lookup("populateDataSet");
	var record=populateDataSet.getCurrent();
	if(record.get("reportDate")==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
	var isValidate = populateDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcPopulateInfoCmd");
	command.setParameter("record",record);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			var url="jsp/ext/cdc/manage/populate/vcdcPopulateInfoList.jsp";
			L5.forward(url,'',null);
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
//判断是否是整数
function forcheck(item){
	var offOtherMon=item.value;
	if (offOtherMon > ""){ 
	 //  var reg=/^\d+(\.\d{2})?$/; 
	   var reg=/[^\d]/g;
	   if ((offOtherMon.match(reg)!= null)){ 
	    L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
	    item.focus();
	    }); 
	    item.value="";
	    return ; 
	 	}
	}
}
function returnBack(){
	
	L5.MessageBox.confirm("提示", "是否保存数据？",function(sta){
		if(sta=="yes"){
			save();
		}else{
			var url="jsp/ext/cdc/manage/populate/vcdcPopulateInfoList.jsp";
			L5.forward(url,'',null);
		}
	});
}