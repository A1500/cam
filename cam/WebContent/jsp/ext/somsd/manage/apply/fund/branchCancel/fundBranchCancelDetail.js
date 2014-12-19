function init() {
		somOrganDataSet.setParameter("SORG_ID",sorgId);
		somOrganDataSet.load();
		somOrganDataSet.on('load',function(){
		if(somOrganDataSet.getCount() > 0 ){
			if(typeof businessOrganSelectDic !="undefined"){
				var borgName = somOrganDataSet.get('borgName');
				var records = businessOrganSelectDic.query("value",borgName);
				if(records.length>0){
					var borgCode = records.items[0].get("text");
					document.getElementById("borgNameDispaly").innerHTML = borgCode;
				}
			}
		}
		});
	
		somApplyDataSet.setParameter("TASK_CODE", taskCode);
		somApplyDataSet.load();
		//加载电子档案
		somElectronicDataSet_load();
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	win.on("hide",function(el){
		somElectronicDataSet_load();
	});	
	L5.QuickTips.init();
}


//返回
function goBack(){
	history.go(-1);
}

