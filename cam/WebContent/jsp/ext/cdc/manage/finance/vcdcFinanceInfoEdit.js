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
			infoDataSet.setParameter("FINANCEID@=",recordId);
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
	if(document.getElementById("reportDate").value==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
	if(document.getElementById("yearly").value==""){
		L5.Msg.alert("提示","年度不能为空！");
		return;
	}
	if(document.getElementById("gdpMon").value==""){
		L5.Msg.alert("提示","生产总值不能为空！");
		return;
	}
	if(document.getElementById("agricultureMon").value==""){
		L5.Msg.alert("提示","农业产值不能为空！");
		return;
	}
	if(document.getElementById("personMon").value==""){
		L5.Msg.alert("提示","人均收入不能为空！");
		return;
	}
	if(document.getElementById("financeMon").value==""){
		L5.Msg.alert("提示","财政收入不能为空！");
		return;
	}
	var infoDataSet=L5.DatasetMgr.lookup("infoDataSet");

	var infoDataSet=L5.DatasetMgr.lookup("infoDataSet");
	var isValidate = infoDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var record = infoDataSet.getCurrent();
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcFinanceInfoCmd");
	command.setParameter("record",record);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			var url="jsp/ext/cdc/manage/finance/vcdcFinanceInfoList.jsp";
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
			var url="jsp/ext/cdc/manage/finance/vcdcFinanceInfoList.jsp";
			L5.forward(url,'',null);
		}
	});
}