function init() {
	var retiredSoldierDataset=L5.DatasetMgr.lookup("retiredSoldierDataset");
	retiredSoldierDataset.setParameter("SOLDIERSID",idField);
	retiredSoldierDataset.load();
	
	retiredSoldierDataset.on("load",function(){
		var record = retiredSoldierDataset.getCurrent();
		if(record.get("ifReceive")=="0"){
			document.getElementById("receiveTimeL").style.display="none";
		 	document.getElementById("receiveTime").style.display="none";
		 	document.getElementById("noReceiveReasonL").style.display="";
		 	document.getElementById("noReceiveReason").style.display="";
		}else {
			 document.getElementById("receiveTimeL").style.display="";
			 document.getElementById("receiveTime").style.display="";
			 document.getElementById("noReceiveReasonL").style.display="none";
			document.getElementById("noReceiveReason").style.display="none";
		}
		//初始化服役时间
		var servicedTime = retiredSoldierDataset.get("servicedTime");
		var year = parseInt(servicedTime/12);
		var month = parseInt(servicedTime%12);
		retiredSoldierDataset.set("servicedTimeTrs",year+"年"+month+"个月");
	});
	L5.QuickTips.init();
}
 function back()
 {	
 	history.go(-1);
 }
 
  function print(){
 	
 	var url='../print/illPrint.jsp?soldierId='+idField+'&type='+'04';
	window.showModalDialog(url,window);
 }