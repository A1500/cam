function init(){
	var naturalReportDataSet=L5.DatasetMgr.lookup("naturalReportDataSet");
	var naturalDataSet=L5.DatasetMgr.lookup("naturalDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	if(method=="insert"){
		naturalDataSet.newRecord();
		naturalReportDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N"});
		reportWorkDataSet.setParameter("organCode", organCode);
		reportWorkDataSet.load();
	}else{
		$("reportDate").disabled=true;
		document.getElementById("backInsert").style.display = "none";
		naturalReportDataSet.setParameter("RECORD_ID@=",recordId);
		naturalReportDataSet.load();
		naturalDataSet.setParameter("RECORD_ID@=",recordId);
		naturalDataSet.load();
		reportWorkDataSet.load();
	}
}
function forInsert(){
	var naturalReportDataSet=L5.DatasetMgr.lookup("naturalReportDataSet");
	naturalReportDataSet.removeAll();
	naturalReportDataSet.setParameter("ORGAN_CODE@=", organCode);
	naturalReportDataSet.setParameter("sort","CREATE_TIME");	
	naturalReportDataSet.setParameter("dir","desc");
	naturalReportDataSet.load();
	naturalReportDataSet.on("load",function(){
		if (naturalReportDataSet.getCount()>0){
			var naturalDataSet=L5.DatasetMgr.lookup("naturalDataSet");
			naturalDataSet.setParameter("RECORD_ID@=",naturalReportDataSet.getAt(0).get("recordId"));
			naturalDataSet.load();
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				naturalReportDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N"});
			});
		}
	});
	
}
function save(){
	var reportTime = document.getElementById("reportDate").value;
	if(reportTime==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
		if(document.getElementById("villageNum").value==""){
		L5.Msg.alert("提示","自然村个数不能为空！");
		return;
	}
	if(document.getElementById("groupNum").value==""){
		L5.Msg.alert("提示","村民小组数不能为空！");
		return;
	}
	if(document.getElementById("totalArea").value==""){
		L5.Msg.alert("提示","辖区总面积不能为空！");
		return;
	}
	if(document.getElementById("ploughArea").value==""){
		L5.Msg.alert("提示","耕地面积不能为空！");
		return;
	}
	if(document.getElementById("resideStatus").value==""){
		L5.Msg.alert("提示","居住状况不能为空！");
		return;
	}
	if(document.getElementById("geographyStatus").value==""){
		L5.Msg.alert("提示","地理状况不能为空！");
		return;
	}
	var naturalDataSet=L5.DatasetMgr.lookup("naturalDataSet");
	var isValidate = naturalDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var record=naturalDataSet.getCurrent();
	//给上报数据赋值
	var naturalReportDataSet=L5.DatasetMgr.lookup("naturalReportDataSet");
	naturalReportDataSet.set("reportDate",reportTime);
	naturalReportDataSet.set("communityNum",1);
	naturalReportDataSet.set("villageNum",record.get("villageNum"));
	naturalReportDataSet.set("groupNum",record.get("groupNum"));
	naturalReportDataSet.set("totalArea",record.get("totalArea"));
	naturalReportDataSet.set("ploughArea",record.get("ploughArea"));
	naturalReportDataSet.set("houseArea",record.get("houseArea"));
	if(record.get("resideStatus")=='1'){
		naturalReportDataSet.set("collectNum",1);
		naturalReportDataSet.set("commonNum",0);
		naturalReportDataSet.set("disperseNum",0);
	}else if(record.get("ifRule")=='2'){
		naturalReportDataSet.set("collectNum",0);
		naturalReportDataSet.set("commonNum",1);
		naturalReportDataSet.set("disperseNum",0);
	}else{
		naturalReportDataSet.set("collectNum",0);
		naturalReportDataSet.set("commonNum",0);
		naturalReportDataSet.set("disperseNum",1);
	}
	
	if(record.get("geographyStatus")=='1'){
		naturalReportDataSet.set("mountainNum",1);
		naturalReportDataSet.set("helfMountainNum",0);
		naturalReportDataSet.set("campagnaNum",0);
	}else if(record.get("ifRule")=='2'){
		naturalReportDataSet.set("mountainNum",0);
		naturalReportDataSet.set("helfMountainNum",1);
		naturalReportDataSet.set("campagnaNum",0);
	}else{
		naturalReportDataSet.set("mountainNum",0);
		naturalReportDataSet.set("helfMountainNum",0);
		naturalReportDataSet.set("campagnaNum",1);
	}
	
	var reportRrecod = naturalReportDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcNatureReportCmd");
	command.setParameter("reportRrecod",reportRrecod);
	command.setParameter("record",record);
	
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}

	if (!command.error){ 
		L5.Msg.alert("提示","保存成功！",function(){
			var url="jsp/ext/cdc/manage/natural/vcdcNaturalList.jsp";
			L5.forward(url,'',null)
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}

}
//判断是否是整数
function forcheck(item){
	var offOtherMon=item.value;
	if (offOtherMon > ""){ 
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
function returnBack(){
	L5.MessageBox.confirm("提示", "是否保存数据？",function(sta){
		if(sta=="yes"){
			save();
		}else{
			var url="jsp/ext/cdc/manage/natural/vcdcNaturalList.jsp";
			L5.forward(url,'',null);
		}
	});
}