var  orgCode ;
function init(){
	var OrgCodeDataset = L5.DatasetMgr.lookup("OrgCodeDataset");
	var coordinateDataSet=L5.DatasetMgr.lookup("coordinateDataSet");
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
				coordinateDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N"});
				reportWorkDataSet.setParameter("organCode", organCode);
			}else{
				coordinateDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N"});
				reportWorkDataSet.setParameter("organCode", orgCode);
			}
			reportWorkDataSet.load();
			});
		}else{
			$("reportDate").disabled=true;
			document.getElementById("backInsert").style.display = "none";
			coordinateDataSet.setParameter("COORDINATE_ID@=",recordId);
			coordinateDataSet.load();
			reportWorkDataSet.load();
		}
}
function forInsert(){
	var coordinateDataSet=L5.DatasetMgr.lookup("coordinateDataSet");
	coordinateDataSet.removeAll();
	if(organLevel=='JD'){
		coordinateDataSet.setParameter("ORGAN_CODE@=", organCode);
	}else{
		coordinateDataSet.setParameter("ORGAN_CODE@=", orgCode);
	}
	coordinateDataSet.setParameter("sort","CREATE_TIME");	
	coordinateDataSet.setParameter("dir","desc");
	coordinateDataSet.load();
	coordinateDataSet.on("load",function(){
		if (coordinateDataSet.getCount()>0){
		
		}else{
			L5.Msg.alert("提示","没有填报历史！",function(){
				if(organLevel=='JD'){
					coordinateDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"reportType":"N"});
					reportWorkDataSet.setParameter("organCode", organCode);
				}else{
					coordinateDataSet.newRecord({"organCode":orgCode,"organName":organName,"parentCode":organCode,"reportType":"N"});
					reportWorkDataSet.setParameter("organCode", orgCode);
				}
			});
		}
	});
	
}

function save(){
	var ifFound =  document.getElementById('ifFound').value ;
	if(ifFound== ''){
	 	L5.Msg.alert("提示","是否成立领导协调机制不能为空!");
	 	return false;
	}
	var phoneReg = /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?/;
	if(ifFound=="1"){
		if(document.getElementById('name').value== ''){
	 		L5.Msg.alert("提示","名称不能为空!");
	 		return false;
		}
		if(document.getElementById('duty').value== ''){
	 		L5.Msg.alert("提示","职责不能为空!");
	 		return false;
		}
		if(document.getElementById('department').value== ''){
	 		L5.Msg.alert("提示","牵头部门不能为空!");
	 		return false;
		}
		if(document.getElementById('linkPeople').value== ''){
	 		L5.Msg.alert("提示","联系人姓名不能为空!");
	 		return false;
		}
		if(document.getElementById('phone').value== ''){
	 		L5.Msg.alert("提示","联系人电话不能为空!");
	 		return false;
		}
		if(document.getElementById('position').value== ''){
	 		L5.Msg.alert("提示","联系人职责不能为空!");
	 		return false;
		}
		if(document.getElementById('ifBudget').value== ''){
	 		L5.Msg.alert("提示","是否纳入财政预算不能为空!");
	 		return false;
		}
		if((document.getElementById('ifBudget').value== "1")&&(document.getElementById('criterion').value== '')){
	 		L5.Msg.alert("提示","财政标准不能为空!");
	 		return false;
		}
		
	}
	var coordinateDataSet=L5.DatasetMgr.lookup("coordinateDataSet");
	var isValidate = coordinateDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var record=coordinateDataSet.getCurrent();
	if(record.get("reportDate")==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcCoordinateInfoCmd");
	command.setParameter("record",record);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			var url="jsp/ext/cdc/manage/coordinate/vcdcCoordinateInfoList.jsp";
			L5.forward(url,'',null);
		});
	}else{
		L5.Msg.alert("提示","保存出错！"+command.error);
	}
}
function returnBack(){
	L5.MessageBox.confirm("提示", "是否保存数据？",function(sta){
		if(sta=="yes"){
			save();
		}else{
			var url="jsp/ext/cdc/manage/coordinate/vcdcCoordinateInfoList.jsp";
			L5.forward(url,'',null);
		}
	});
}
function ifFoundChanges(){
	var ifFound = document.getElementById("ifFound").value;
	if(ifFound == '0'){
		var coordinateDataSet=L5.DatasetMgr.lookup("coordinateDataSet");
		var record=coordinateDataSet.getCurrent();
		record.set("duty","");
		record.set("name","");
		record.set("department","");
		record.set("linkPeople","");
		record.set("phone","");
		record.set("position","");
		record.set("ifBudget","");
		record.set("criterion","");
		document.getElementById("duty").disabled =true;
		document.getElementById("name").disabled =true;
		document.getElementById("department").disabled =true;
		document.getElementById("linkPeople").disabled =true;
		document.getElementById("phone").disabled =true;
		document.getElementById("position").disabled =true;
		document.getElementById("ifBudget").disabled =true;
		document.getElementById("criterion").disabled =true;
	}else if(ifFound == '1'){
		document.getElementById("duty").disabled =false;
		document.getElementById("name").disabled =false;
		document.getElementById("department").disabled =false;
		document.getElementById("linkPeople").disabled =false;
		document.getElementById("phone").disabled =false;
		document.getElementById("position").disabled =false;
		document.getElementById("ifBudget").disabled =false;
		document.getElementById("criterion").disabled =false;
	}
}

function ifBudgetChanges(){
	var ifBudget = document.getElementById("ifBudget").value;
	if(ifBudget == '0'){
		var coordinateDataSet=L5.DatasetMgr.lookup("coordinateDataSet");
		var record=coordinateDataSet.getCurrent();
		record.set("criterion","");
		document.getElementById("criterion").disabled =true;
		document.getElementById("red").style.display = "none";
	}else{
		document.getElementById("criterion").disabled =false;
		document.getElementById("red").style.display = "";
	}
}