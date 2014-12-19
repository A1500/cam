function init() {
	var peopleInfoDS=L5.DatasetMgr.lookup("peopleInfoDS");
	peopleInfoDS.baseParams["PEOPLE_ID@="]=peopleId;
	peopleInfoDS.load();
	var dutyInfoDS=L5.DatasetMgr.lookup("dutyInfoDS");
	dutyInfoDS.baseParams["PEOPLE_ID@="]=peopleId;
	dutyInfoDS.load();
	//判断是否显示离岗时间、离岗原因
	peopleInfoDS.on("load",function(){
			var ifCancel=peopleInfoDS.getCurrent().get("ifCancel");
			if(ifCancel==1){
			document.getElementById("cancelInfo").style.display = "";
			}else{
			document.getElementById("cancelInfo").style.display = "none";
			}
		}
	);
	L5.QuickTips.init();
	
}
function back(){     
	var url='jsp/cams/fis/base/peopleManageList.jsp';
	var text = '工作人员信息';
	L5.forward(url,text);
}
