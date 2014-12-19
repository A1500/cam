var fileCode = "J046";
function init() {
	L5.getCmp("tab").setActiveTab("0");

	loadInfo();
	//社团职务过滤
	sorgDutiesSelect.filterBy(function(record, id){
		if("00002".indexOf(record.get('value'))>-1){
			return record;
		}
	});
	

}
function loadInfo(){
	somApplyDataSet.setParameter("TASK_CODE", taskCode);
	somApplyDataSet.load();
	
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID", sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on("load",function(ds){
			if(typeof businessOrganSelectDic !="undefined"){
				var borgName = somOrganDataSet.get('borgName');
				var records = businessOrganSelectDic.query("value",borgName);
				if(records.length>0){
					var borgCode = records.items[0].get("text");
					document.getElementById("borgName").value = borgName;
					document.getElementById("borgNameDispaly").innerHTML = borgCode;
				}
			}
		});
	somSessionDataSet.setParameter("TASK_CODE", taskCode);
	somSessionDataSet.load();
	
	
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeDataSet.setParameter("TASK_CODE", taskCode);
	somResumeDataSet.load();
	somResumeDataSet.on('load',function(){
		somDutyDataSet.setParameter("TASK_CODE", taskCode);
		somDutyDataSet.load();
		somDutyDataSet.on('load',function(){
			if(somDutyDataSet.getCount() > 0){
				isOnly = false;
			}
		});
	});
	somElectronicDataSet_load();
}

//返回
function goBack(){
	history.go(-1);
}
//------------------负责人处理------------------------------
var dutyId='';


//点击查看一条负责人
function detail(){
	var grid=L5.getCmp("peopleGrid");
	updateRecord=grid.getSelectionModel().getSelected();
	if(!updateRecord){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	dutyId=updateRecord.get('dutyId');
	somDutyInsertDataSet.removeAll();
	somDutyInsertDataSet.insert(0,updateRecord.copy());
	
	//处理个人简历
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	somResumeInsertDataSet.removeAll();
	var j=0;
	for(var i=somResumeDataSet.getCount()-1;i>=0;i--){
		var somResumeRecord =somResumeDataSet.getAt(i);
		if(updateRecord.get('dutyId')==somResumeRecord.get('dutyId')){
			somResumeInsertDataSet.insert(j,somResumeRecord);
			j++;
		}
	}
	//处理个人简历完成
	
	somPeopleElectronicDataSet_load(fileCode,dutyId);//同步负责人法律要件
	
	var win = L5.getCmp("peopleWin");
	win.show();
	if(typeof countrySelectDic !="undefined"){
		document.getElementById("nation").value = '';
		document.getElementById("nationDispaly").innerHTML = '';
		var nation = somDutyInsertDataSet.get('nation');
		var records = countrySelectDic.query("value",nation);
		if(records.length == 1){
			var nationCode = records.items[0].get("text");
			document.getElementById("nationDispaly").innerHTML = nationCode;
			document.getElementById("nation").value = nation;
		}
	}
	$("age").innerHTML = getAgeByCode(updateRecord.get('idCard'));
}


//负责人窗户关闭
function closePeopleWIn(){
	var win = L5.getCmp("peopleWin");
	win.hide();
}

