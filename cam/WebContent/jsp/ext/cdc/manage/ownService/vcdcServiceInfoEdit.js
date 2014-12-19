var  orgCode ;
function init(){
	var OrgCodeDataset = L5.DatasetMgr.lookup("OrgCodeDataset");
	var infoDataSet=L5.DatasetMgr.lookup("infoDataSet");
	if(method=="insert"){
	OrgCodeDataset.setParameter("filterSql","user_id = '"+organCode+"'");
	OrgCodeDataset.load();
	OrgCodeDataset.on("load",function() {
		orgCode = OrgCodeDataset.get("text");
		
		if(organLevel=='JD'){
			organCode= orgCode.substring(0,9)+"000";
		}
		var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
			if(organLevel=='JD'){
				infoDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N"});
				reportWorkDataSet.setParameter("organCode", organCode);
			}else{
				infoDataSet.newRecord({"organCode":orgCode,"organName":organName,"parentCode":organCode,"reportType":"N"});
				reportWorkDataSet.setParameter("organCode", orgCode);
			}
			reportWorkDataSet.load();
			});
		}else{
			$("reportDate").disabled=true;
			document.getElementById("backInsert").style.display = "none";
			infoDataSet.setParameter("MODE_ID@=",recordId);
			infoDataSet.load();
			reportWorkDataSet.load();
		}
}
function forInsert(){
	var infoDataSet=L5.DatasetMgr.lookup("infoDataSet");
	infoDataSet.removeAll();
	if(organLevel=='JD'){
		infoDataSet.setParameter("ORGAN_CODE@=", organCode);
	}else{
		infoDataSet.setParameter("ORGAN_CODE@=", orgCode);
	}
	infoDataSet.setParameter("sort","CREATE_TIME");	
	infoDataSet.setParameter("dir","desc");
	infoDataSet.load();
	infoDataSet.on("load",function(){
		if (infoDataSet.getCount()>0){
		
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				if(organLevel=='JD'){
					infoDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N"});
					reportWorkDataSet.setParameter("organCode", organCode);
				}else{
					infoDataSet.newRecord({"organCode":orgCode,"organName":organName,"parentCode":organCode,"reportType":"N"});
					reportWorkDataSet.setParameter("organCode", orgCode);
				}
			});
		}
	});
	
}
function save(){
	var phoneReg = /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?/;
	if(document.getElementById('publicContent').value == ''){
	 	L5.Msg.alert("提示","公共服务内容不能为空!");
	 	return false;
	}
	if(document.getElementById('publicPeopleNum').value == ''){
	 	L5.Msg.alert("提示","公共服务人数不能为空!");
	 	return false;
	}
	if(document.getElementById('voluntContent').value == ''){
	 	L5.Msg.alert("提示","志愿服务内容不能为空!");
	 	return false;
	}
	if(document.getElementById('voluntPeopleNum').value == ''){
	 	L5.Msg.alert("提示","志愿服务人数不能为空!");
	 	return false;
	}
	if(document.getElementById('commerceName').value == ''){
	 	L5.Msg.alert("提示","商业服务名称不能为空!");
	 	return false;
	}
	if(document.getElementById('commerceContent').value == ''){
	 	L5.Msg.alert("提示","商业服务内容不能为空!");
	 	return false;
	}
	if(document.getElementById('commerceAddress').value == ''){
	 	L5.Msg.alert("提示","商业服务地址不能为空!");
	 	return false;
	}
	if(document.getElementById('ifService').value == ''){
	 	L5.Msg.alert("提示","是否提供全程代办代理服务不能为空!");
	 	return false;
	}
	if(document.getElementById('servicePhone').value == ''){
	 	L5.Msg.alert("提示","社区电话服务热线不能为空!");
	 	return false;
	}
	if(!phoneReg.test(document.getElementById('servicePhone').value)){
		L5.Msg.alert("提示","社区电话服务热线格式不正确!");
	 	return false;
	}
	if(document.getElementById('serviceWeb').value == ''){
	 	L5.Msg.alert("提示","社区网络服务平台不能为空!");
	 	return false;
	}
	var infoDataSet=L5.DatasetMgr.lookup("infoDataSet");
	var isValidate = infoDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var record=infoDataSet.getCurrent();
	if(record.get("reportDate")==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcServiceModeCmd");
	command.setParameter("record",record);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			var url="jsp/ext/cdc/manage/ownService/vcdcServiceInfoList.jsp";
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
			var url="jsp/ext/cdc/manage/ownService/vcdcServiceInfoList.jsp";
			L5.forward(url,'',null);
		}
	});
}