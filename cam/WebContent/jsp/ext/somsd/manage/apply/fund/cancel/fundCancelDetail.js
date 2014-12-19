var sorgId="";
var applyType="203";
function init() {
	somOrganDataSet.setParameter("SORG_ID",sorgId);
	somOrganDataSet.load();
	somOrganDataSet.on('load',function (){
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
	somApplyDataSet.setParameter("TASK_CODE", taskCode);
	somApplyDataSet.load();
	//加载社会组织清算组织人员信息
	somLiqpeopleDataSet.setParameter("SORG_ID@=",sorgId);
	somLiqpeopleDataSet.load();
	//加载电子档案
	somElectronicDataSet_load();
	
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	win.on("hide",function(el){
		somElectronicDataSet_load();
	});	
	L5.QuickTips.init();
}
//根据登记证号加载社会组织信息
function loadSorg(){
	if(method=="INSERT"){
		if(""!=_$("sorgCode")){
			somOrganDataSet.setParameter("SORG_CODE",_$("sorgCode"));
			somOrganDataSet.setParameter("SORG_TYPE","J");
			somOrganDataSet.setParameter("IF_BRANCH","0");
			somOrganDataSet.load();
			somOrganDataSet.on("load",function(){
				if(somOrganDataSet.getCount()<1){
					somOrganDataSet.removeAll();
					somOrganDataSet.newRecord();
					L5.Msg.alert("提示","登记证号不存在!");
					return;
				}else{
					sorgId=somOrganDataSet.get('sorgId');
					somLiqpeopleDataSet.setParameter("SORG_ID@=",sorgId);
					somLiqpeopleDataSet.load();
					//加载电子档案
					somElectronicDataSet_load();
				}	
			});	
		}
	}	
}

//返回
function goBack(){
	window.history.go(-1);
}
