function init() {

	ds.baseParams["peopleId"]=peopleId;
	ds.baseParams["applyId"]=applyId;
	ds.load();
}
function save(){
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	
	ds.set("toOrganId",organCode);
    var record = ds.getCurrent();
    var hospital =record.get("hospital");
    if(hospital==''){
    	L5.Msg.alert('提示','送检医院不能为空!');
    	return;
    }
    var toCheckDate =record.get("toCheckDate");
    if(toCheckDate==''){
    	L5.Msg.alert('提示','送检日期不能为空!');
    	return;
    }
    if(toCheckDate!=''&&!validateDateFormat(toCheckDate)){
		L5.Msg.alert("提示","送检日期格式不正确！");
		return false;
	}
    var toCheckIllness =record.get("toCheckIllness");
    if(toCheckIllness==''){
    	L5.Msg.alert('提示','送检疾病不能为空!');
    	return;
    }
    var toOrganDate =record.get("toOrganDate");
    if(toOrganDate==''){
    	L5.Msg.alert('提示','送检到单位日期不能为空!');
    	return;
    }
    if(toOrganDate!=''&&!validateDateFormat(toOrganDate)){
		L5.Msg.alert("提示","送检到单位日期格式不正确！");
		return false;
	}
	var signDate =record.get("signDate");
	if(signDate!=''&&!validateDateFormat(signDate)){
		L5.Msg.alert("提示","签名日期格式不正确！");
		return false;
	}
    record.set("applyId",applyId);
	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptDemobilizedillCheckCommand"); 
	command.setParameter("record",record);
	command.execute("update");
	
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}


function hidden(value){
	if(value=='1'){	
		document.getElementById("hsystem").style.display='';
		document.getElementById("hill").style.display='';
	}else{
		document.getElementById("hsystem").style.display="none";
		document.getElementById("hill").style.display="none";
	}
}

