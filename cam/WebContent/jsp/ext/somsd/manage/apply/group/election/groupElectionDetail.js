function init(){
		var somElectionDataSet=L5.DatasetMgr.lookup("somElectionDataSet");
		somElectionDataSet.setParameter("TASK_CODE@=",taskCode);
		somElectionDataSet.load();
		somElectionDataSet.on('load', function(){
			var record=somElectionDataSet.getCurrent();
			somAspchiefDataSet.setParameter("TASK_CODE",taskCode);
			somAspchiefDataSet.load();
			var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
			somApplyDataSet.setParameter("TASK_CODE",taskCode);
			somApplyDataSet.load();
			somApplyDataSet.on("load",function(){
				somOrganDataSet.setParameter("SORG_ID@=",somApplyDataSet.get("sorgId"));
				somOrganDataSet.load();
				somOrganDataSet.on("load",function(){
					$("cnName").innerHTML = somOrganDataSet.get("cnName");
					$("sorgCode").innerHTML = somOrganDataSet.get("sorgCode");
					//从organ表里取业务主管单位
					if(typeof businessOrganSelectDic !="undefined"){
						var borgName = somOrganDataSet.get('borgName');
						var records = businessOrganSelectDic.query("value",borgName);
						if(records.length>0){
							var borgCode = records.items[0].get("text");
							document.getElementById("borgNameDispaly").innerHTML = borgCode;
						}
					}
				});
			});
		});
	//电子档案
	somElectronicDataSet_load();	
	sexDataSet.on("load",function addBlank(){
		sexDataSet.un("load",addBlank);
		var record = sexDataSet.newRecord({"text":"请选择","value":""});
		var recordCopy = record.copy();
		sexDataSet.insert(0,recordCopy);
		sexDataSet.removeAt(sexDataSet.indexOf(record));
	});
	politicsSelect.on("load",function addBlank(){
		politicsSelect.un("load",addBlank);
		var record = politicsSelect.newRecord({"text":"请选择","value":""});
		var recordCopy = record.copy();
		politicsSelect.insert(0,recordCopy);
		politicsSelect.removeAt(politicsSelect.indexOf(record));
	});
	sorgDutiesDataSet.on("load",function addBlank(){
		sorgDutiesDataSet.un("load",addBlank);
		var record = sorgDutiesDataSet.newRecord({"text":"请选择","value":""});
		var recordCopy = record.copy();
		sorgDutiesDataSet.insert(0,recordCopy);
		sorgDutiesDataSet.removeAt(sorgDutiesDataSet.indexOf(record));
	});
}

function returnBack(){
	window.history.go(-1);	
}

function closePrintWin(){
	var win = L5.getCmp("printPartyWin");
	win.setVisible(false);
}

