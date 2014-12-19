function init() {
		var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
		somApplyDataSet.setParameter("TASK_CODE@=", taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on('load', loadInfo);
		somElectronicDataSet_load();
	opinionDataSet.filterBy(function(record, id){
		if("1".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	
}

function loadInfo(){
	sorgId = somApplyDataSet.get('sorgId');
	taskCode=somApplyDataSet.get('taskCode');
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on("load",function(){
		if(typeof businessOrganSelectDic !="undefined"){
			var borgName = somOrganDataSet.get('borgName');
			var records = businessOrganSelectDic.query("value",borgName);
			if(records.length>0){
				var borgCode = records.items[0].get("text");
				document.getElementById("borgNameDispaly").innerHTML = borgCode;
			}
		}
	});
	var somHeldPeopleDataSet=L5.DatasetMgr.lookup("somHeldPeopleDataSet");
	somHeldPeopleDataSet.setParameter("SORG_ID@=", sorgId);
	var somHeldOrganDataSet=L5.DatasetMgr.lookup("somHeldOrganDataSet");
	somHeldOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somHeldPeopleDataSet.load();
	somHeldOrganDataSet.load();
	aspChiefDataset.setParameter("SORG_ID@=", sorgId);
	aspChiefDataset.load();
	aspChiefDataset.on('load',function(){
			if(aspChiefDataset.getCount()==0){
				aspChiefDataset.newRecord({"taskCode":taskCode,"sorgId":sorgId});
			}
		});
	somElectronicDataSet_load();
}

//返回
function returnClick(){
	history.go(-1);
}



//校验身份证号
function validIDCard(args){
	var val=args[0].toUpperCase();
	if(val=="") return true;
	if(val=="000000000000000000") return true;
	
	if(val.length==15){
		if(!is15IDCard(val)){
			return false;
		}
	}else if(val.length==18){
		if(!is18IDCard(val)){
			return false;
		}
	}else{
		return false;
	}
	return true;
}

function validDate(args){
	var val=args[0];
	if(val=="") return true;
	var objRegExp = /^(\d{4})\-(\d{2})$/ 
	if(!objRegExp.test(val)) {
		return "不符合YYYY-mm格式，请检查！"; 
	}
	return true;
}