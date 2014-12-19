var cnName='';
var sorgCode=''
function init() {
	L5.getCmp("tab").setActiveTab("0");
		loadInfo();
	//电子档案上传窗口关闭事件
	if(L5.getCmp("uploadList")){
		var win=L5.getCmp("uploadList");
		win.on("hide",function(el){
			somElectronicDataSet_load();
		});
	}
	somElectronicDataSet_load();
}
function loadInfo(){
		somOrganDataSet.setParameter("SORG_ID", sorgId);
		somOrganDataSet.load();
		somOrganDataSet.on('load',function(){
			cnName=somOrganDataSet.get("cnName");
			sorgCode=somOrganDataSet.get("sorgCode");
			
			if(typeof businessOrganSelectDic !="undefined"){
				var borgName = somOrganDataSet.get('borgName');
				var records = businessOrganSelectDic.query("value",borgName);
				if(records.length>0){
					var borgCode = records.items[0].get("text");
					document.getElementById("borgNameDispaly").innerHTML = borgCode;
				}
			}
		});
		somApplyDataSet.setParameter("TASK_CODE", taskCode);
		somApplyDataSet.load();
		somHeldPeopleDataSet.setParameter("SORG_ID@=", sorgId);
		somHeldPeopleDataSet.load();
		somHeldOrganDataSet.setParameter("SORG_ID@=", sorgId);
		somHeldOrganDataSet.load();
		somAspchiefDataSet.setParameter("TASK_CODE", taskCode);
		somAspchiefDataSet.load();
		//加载电子档案
		somElectronicDataSet_load();
}


//返回
function goBack(){
	history.go(-1);
}

