var Id = "";
function init(){
		
		var dsPro = L5.DatasetMgr.lookup("dsPro");
		dsPro.setParameter("PEOPLE_ID",peopleId);
//		dsPro.setParameter("ORGAN_ID",organCode);
		dsPro.load();
		ds.setParameter("PEOPLE_ID",peopleId);
		ds.setParameter("SERVICE_TYPE",service);
		ds.setParameter("ORGAN_ID", organCode);
		ds.load();
		L5.QuickTips.init();
		dsPro.on("load",function(){
			var peopleInfoTabPanel = L5.getCmp("peopleInfoTabPanel");
			var tabPanelId = L5.getCmp("tabPanelId");
			var tablePanel = L5.getCmp("tablePanel");
			var panelall = L5.getCmp("panelall");
			//如果是数据采集和其他,去掉电子文书peopleInfoTabPanel
				if(ywName=='1') {
					 panelall.remove(peopleInfoTabPanel);
				}
				
				var url = "";
				var serviceFirst = service.substring(0,1);
				if(serviceFirst == "1") {
					url="/jsp/cams/bpt/peopleBasicInfo/documentdoc/disability.jsp";
				} else if(serviceFirst == "2") {
					url = "/jsp/cams/bpt/peopleBasicInfo/documentdoc/depdent.jsp";
				} else if(serviceFirst == "4") {
					url = "/jsp/cams/bpt/peopleBasicInfo/documentdoc/democile.jsp";
				} else if(serviceFirst == "5" || serviceFirst == "6") {
					url = "/jsp/cams/bpt/peopleBasicInfo/documentdoc/warandTested.jsp";
				} else if(serviceFirst == "8" || serviceFirst == "B") {
					url = "/jsp/cams/bpt/peopleBasicInfo/documentdoc/soldierAndMarty.jsp";
				} 
				url = L5.webPath + url + "?peopleId=" + peopleId +  "&applyId="+applyId
				+"&serviceType="+service;
			peopleInfoTabPanel.on("activate",function() {
				//如果审批表没有数据则去掉审批表
				//var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
				///DisabilityApproveDataset.setParameter("APPLY_ID",applyId);
				//DisabilityApproveDataset.load();
				//DisabilityApproveDataset.on("load",function removeApprove() {
				//var getrecord = DisabilityApproveDataset.getAllRecords();
				//var name;
				//alert(getrecord[0].get("name"));
				//for(var i=0;i<getrecord.length;i++){
				//	name = getrecord[i].get("name");
				//	alert(name);
				//}
				/*var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
	
				command.setParameter("APPLY_ID",applyId);
				command.execute("queryCount");
				var count = command.getReturn("count");
				if(count=="0"){
				 tabPanelId.remove(L5.getCmp("approvetablePanel"));
				}
				//});
				if(serviceType!='11'&&serviceType!='12'&&serviceType!='13'&&serviceType!='14'&&serviceType!='15'&&serviceType!='16'&&serviceType!='17'&&serviceType!='18'&&serviceType!='19') {
					tabPanelId.remove(L5.getCmp("disabilityIdentiTabPanel"));
				}*/
				
				var obj = document.getElementById("iframesrc").src=url;
				
			});
		});
		ds.on("load",function(){
		var records=ds.getAllRecords();
		if(records.length>=1){
			upload_detail();
		}
	});
}


  /*
   * 解析fileName字段，分别加链接
   */
function upload_detail(){
 	var record=ds.getAllRecords();
 	var fileName="";
 	var fileId="";
 	var electronicId="";
 	Id="";
 	for(var i=0;i<record.length;i++){
 		fileName =record[i].get("fileName");
 		electronicId=record[i].get("electronicId");
 		//alert("electronicId"+electronicId);
 		fileId=record[i].get("fileId");
		//var allFileName=fileName.split(",");
		//var allFileId=fileId.split(",");
		//alert(fileName);
		if(fileName!="")
		{
			Id+=record[i].get("electronicId")+":";
			//var returnfile="<a href='#' style='color:blue;text-decoration:none' onclick='uploadfiles(\""+electronicId+"\")'>查看</a>";
			//alert(returnfile);
			//record[i].set("fileName",returnfile);
		}
 	}
  }
  
  function fileNameFormat(value,cellmeta,record) {
	if(value!="") {
		var eId = record.get("electronicId");
		return "<a href='#' style='color:blue;text-decoration:none' onclick='uploadfiles(\""+eId+"\")'>查看</a>";
	} else {
		return value;
	}
}
  
  //查看所有电子文档
   function checkElectronic() {
    var record=ds.getAllRecords();
    var stypes="";
    var Id="";
    for(var i=0;i<record.length;i++){
   	 Id+=record[i].get("electronicId")+":";
   	 stypes+=record[i].get("serviceType")+":";
    }
  	var url=L5.webPath+"/jsp/cams/bpt/comm/checkFileview.jsp?Id="+Id+"&peopleId="+peopleId+"&serviceType="+stypes;
  	var param = window.dialogArguments;
  	var electronic = param.window.open(url);
  
  }
 /*
   * 调用文件下载方法
   */
 function uploadfiles(electronicId){
	var url=L5.webPath+"/jsp/cams/bpt/comm/fileview.jsp?electronicId="+electronicId;
 	//var url=L5.webPath+"/jsp/cams/bpt/comm/fileview.jsp?peopleId='"+peopleId+"'&serviceType='"+serviceType+"'";
	var hPopup=window.open(url,"fielview","location=1,status=1,toolbar=1,directories=1,menubar=1,scrollbars=1,resizable=1,top=0,left=0");
	//hPopup.blur();
    hPopup.resizeTo(screen.availWidth,screen.availHeight);
  }
