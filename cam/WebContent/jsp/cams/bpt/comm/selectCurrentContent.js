var Id = "";
function init() {
	ds.setParameter("PEOPLE_ID",peopleId);
	ds.setParameter("SERVICE_TYPE",serviceType);
	ds.setParameter("ORGAN_ID", organCode);
	ds.load();
//	ds.on("load",function(){
//	var records=ds.getAllRecords();
//		if(records.length>=1){
//			upload_detail();
//		}
//	});
}

function lookDetail(value,cellmeta,record,rowindex,colindex,dataset){
 	/*var record=ds.getAllRecords();
 	var fileName="";
 	var fileId="";
 	var electronicId="";
 	for(var i=0;i<record.length;i++){*/
 		fileName =record.get("fileName");
 		electronicId=record.get("electronicId");
 		//alert("electronicId"+electronicId);
 		fileId=record.get("fileId");
		//var allFileName=fileName.split(",");
		//var allFileId=fileId.split(",");
		//alert(fileName);
		if(fileName!=""&&fileName!="undefined")
		{
			Id+=record.get("electronicId")+":";
			var returnfile="<a href='#' style='color:blue;text-decoration:none' onclick='uploadfiles(\""+electronicId+"\")'>查看</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' style='color:blue;text-decoration:none' onclick='editfiles(\""+electronicId+"\")'>编辑</a>";
			//alert(returnfile);
			//record[i].set("fileName",returnfile);
			return returnfile;
		}else{
			return "";
		}
 	}
  //查看所有电子档案
    function checkElectronic() {
  	var url=L5.webPath+"/jsp/cams/bpt/comm/checkFileview.jsp?Id="+Id;
  	var electronic = window.open(url);
  }
  /*
   * 解析fileName字段，分别加链接
   */
function upload_detail(){
 	var record=ds.getAllRecords();
 	var fileName="";
 	var fileId="";
 	var electronicId="";
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
			var returnfile="<a href='#' style='color:blue;text-decoration:none' onclick='uploadfiles(\""+electronicId+"\")'>查看</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' style='color:blue;text-decoration:none' onclick='editfiles(\""+electronicId+"\")'>编辑</a>";
			//alert(returnfile);
			record[i].set("fileName",returnfile);
		}
 	}
}

function  confirmValue(){
	var editGrid=L5.getCmp('gridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	
	var electronicId = selected[0].get('electronicId');
	var catalogName = selected[0].get('catalogName');
	
	window.returnValue=electronicId+";"+catalogName;
	window.close();
}

function closew(){
	window.returnValue="";
	window.close();
}

function clears(){
   window.returnValue=";;;;;;;"
   window.close();
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
   /*
   * 调用文件下载方法
   */
function editfiles(electronicId){
	var url=L5.webPath+"/jsp/cams/bpt/comm/fileedit.jsp?electronicId="+electronicId;
	var hPopup=window.open(url,"fileedit","location=1,status=1,toolbar=1,directories=1,menubar=1,scrollbars=1,resizable=1,top=0,left=0");
	//hPopup.blur();
    hPopup.resizeTo(screen.availWidth,screen.availHeight);
}
