function init(){
	var tenementInfoDataSet=L5.DatasetMgr.lookup("tenementInfoDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	if(method=="insert"){
		tenementInfoDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode});
		reportWorkDataSet.setParameter("organCode", organCode);
		reportWorkDataSet.load();
	}else{
		document.getElementById("backInsert").style.display = "none";
		$("reportDate").disabled=true;
		tenementInfoDataSet.setParameter("RECORD_ID@=",recordId);
		tenementInfoDataSet.load();
		reportWorkDataSet.load();
	}
}
function save(){
	var tenementInfoDataSet=L5.DatasetMgr.lookup("tenementInfoDataSet");
	
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcTenementInfoCmd");
	var record = tenementInfoDataSet.getCurrent();
	command.setParameter("record",record);
	if(record.get("reportDate")==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			var url="jsp/ext/cdc/manage/tenement/cdcTenementInfoList.jsp";
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
			var url="jsp/ext/cdc/manage/tenement/cdcTenementInfoList.jsp";
			L5.forward(url,'',null);
		}
	});

}
function gRender(val){
	if(val!=""){
		return val+" 个";
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
//如是小数，保留到两位
function fordecimalcheck(item){
	var offOtherMon=item.value;
	if (offOtherMon > ""){ 
	   var reg=/^\d+(\.\d{0,2})?$/; 
	   if ((offOtherMon.match(reg)== null)){ 
	    L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
	    item.focus();
	    }); 
	    item.value="";
	    return ; 
	 	}
	}
}
function forInsert(){
	var tenementInfoDataSet=L5.DatasetMgr.lookup("tenementInfoDataSet");
	tenementInfoDataSet.removeAll();
	tenementInfoDataSet.setParameter("ORGAN_CODE@=", organCode);
	tenementInfoDataSet.setParameter("sort","CREATE_TIME");	
	tenementInfoDataSet.setParameter("dir","desc");
	tenementInfoDataSet.load();
	tenementInfoDataSet.on("load",function(){
		if (tenementInfoDataSet.getCount()>0){
		
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				tenementInfoDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode});
			});
		}
	});
}
