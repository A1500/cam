function init(){
	var cdcOrganInfoDataSet=L5.DatasetMgr.lookup("cdcOrganInfoDataSet");
	if(method=="insert"){
		cdcOrganInfoDataSet.newRecord({"organCode":organCode,"organName":organName,"organType":"2"});
	}else{
		cdcOrganInfoDataSet.setParameter("ORGAN_ID@=",organId);
		cdcOrganInfoDataSet.load();
	}
}
function save(){
	var cdcOrganInfoDataSet=L5.DatasetMgr.lookup("cdcOrganInfoDataSet");
	var valid=cdcOrganInfoDataSet.isValidate(true);
	if(valid!=true){
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var record=cdcOrganInfoDataSet.getCurrent();
	if(record.get("corpName")==''){
		L5.Msg.alert("提示","单位名称不能为空！");
		return false;
	}
	if(record.get("organKind")==''){
		L5.Msg.alert("提示","单位性质不能为空！");
		return false;
	}
	if(record.get("legalPeople")==''){
		L5.Msg.alert("提示","法人代表不能为空！");
		return false;
	}
	if(record.get("organPhone")==''){
		L5.Msg.alert("提示","联系电话不能为空！");
		return false;
	}
	if(record.get("postCode")==''){
		L5.Msg.alert("提示","邮政编码不能为空！");
		return false;
	}
	if(document.getElementById("memberNum").value==""){
		L5.Msg.alert("提示","职工人数不能为空！");
		return false;
	}
	if(document.getElementById("floorArea").value==""){
		L5.Msg.alert("提示","办公场所面积不能为空！");
		return false;
	}
	if(record.get("morgName")==''){
		L5.Msg.alert("提示","主管单位不能为空！");
		return false;
	}
	if(record.get("organAdds")==''){
		L5.Msg.alert("提示","地址不能为空！");
		return false;
	}
	
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcOrganInfoCmd");
	command.setParameter("record",record);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			returnBack();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function returnBack(){
	history.go(-1);
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
