function init(){
    PeopleDemobilizedDataset.setParameter("peopleId",peopleId);
    PeopleDemobilizedDataset.load();
}
function saveClick(){
    var ds=L5.DatasetMgr.lookup("PeopleDemobilizedDataset");
	var PeopleDemobilizedRecord = ds.getCurrent();
	
	var conscriptDate = PeopleDemobilizedRecord.get("conscriptDate");
	if(conscriptDate!=''&&!validateDateFormat(conscriptDate)){
		L5.Msg.alert('提示', '入伍时间格式不正确！');
		return false;
	}
	
	var decruitmentDate = PeopleDemobilizedRecord.get("decruitmentDate");
	if(decruitmentDate!=''&&!validateDateFormat(decruitmentDate)){
		L5.Msg.alert('提示', '复员时间格式不正确！');
		return false;
	}
	
	
	
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedCommand");
	var Record= ds.getCurrent();
	//Record.set("approvalDate","10");
	command.setParameter("PeopleDemobilizedRecord",Record);
	command.execute("update");	
	var valid = ds.isValidate(true);
	if(valid !== true){
		alert("校验未通过，不能保存！"+valid);
		return false;
	}
   if (!command.error) {
		L5.Msg.alert('提示', '保存成功！');
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}

function func_BelongDate(){
  var conscriptDate = PeopleDemobilizedDataset.get("conscriptDate");
  if(conscriptDate !=''){
     if(conscriptDate>='1937-07-07'&&conscriptDate<='1945-09-02'){
         PeopleDemobilizedDataset.set("belongDate",1);
     }else if(conscriptDate>='1945-09-03'&&conscriptDate<='1949-09-30'){
         PeopleDemobilizedDataset.set("belongDate",2);
     }else{
         PeopleDemobilizedDataset.set("belongDate",3);
     }
  }
}
function check_conscriptDate(){
	 var conscriptDate = document.getElementById("conscriptDate").value;
	 if(conscriptDate>='1954-10-31'){
	 	L5.Msg.alert('提示', '入伍时间必须为1954年10月31日前！');
	 	document.getElementById("conscriptDate").value="";
	 }
}
function returnClick(){
   history.go(-1);
}
function closeWindow(){
 	window.close();
}

function KoreaWar(k){

	if(k.value==3){
		document.getElementById("k1").style.display='';
		document.getElementById("k2").style.display='';
		document.getElementById("k3").style.display='none';
		document.getElementById("k4").style.display='none';
	}else{
		document.getElementById("k1").style.display='none';
		document.getElementById("k2").style.display='none';
		document.getElementById("k3").style.display='';
		document.getElementById("k4").style.display='';
		document.getElementById("isKoeanwar").value="";
	}
}