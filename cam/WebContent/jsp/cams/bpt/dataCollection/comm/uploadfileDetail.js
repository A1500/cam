var row_index=0;
var Id ="";
function init() {
	//电子档案信息
	bptElectronic.setParameter("PEOPLE_ID",peopleId);
	//bptElectronic.setParameter("DOMICILE_CODE",organCode);
	bptElectronic.setParameter("SERVICE_TYPE",serviceType);
	bptElectronic.load();
	bptElectronic.on("load",function(){
		var records=bptElectronic.getAllRecords();
		if(records.length<1){
			//为新增记录时，初始化
			bptElectronic.newRecord();
		}else{
			//当为更新时，先从ContentNumMaintainDataset中取得contentNumId，通过contentNumId在ContentNumMaintainDataset中
			//中查询相关记录，逐个set入ContentNumMaintainDataset中
			var ContentNumMaintainDataset = L5.DatasetMgr.lookup("ContentNumMaintainDataset");
			var contentNumId = records[0].get("contentNumId");
			ContentNumMaintainDataset.setParameter("CONTENT_NUM_ID",contentNumId);
			ContentNumMaintainDataset.load();
			ContentNumMaintainDataset.on("load",function(){
				var ContentNumMaintainRecords = ContentNumMaintainDataset.getAllRecords();
					var contentNumName = ContentNumMaintainRecords[0].get("contentNumName");
					bptElectronic.set("contentNumName",contentNumName);
					if(ContentNumMaintainRecords[0].get("fileCabinetName") != null){
						var fileCabinetName = ContentNumMaintainRecords[0].get("fileCabinetName");
						bptElectronic.set("fileCabinetName",fileCabinetName);
					}
					if(ContentNumMaintainRecords[0].get("layerNum") != null){
						var layerNum = ContentNumMaintainRecords[0].get("layerNum");
						bptElectronic.set("layerNum",layerNum);
					}
					if(ContentNumMaintainRecords[0].get("boxNum") != null){
						var boxNum = ContentNumMaintainRecords[0].get("boxNum");
						bptElectronic.set("boxNum",boxNum);
					}
					if(ContentNumMaintainRecords[0].get("contentYear") != null){
						var contentYear = ContentNumMaintainRecords[0].get("contentYear");
						bptElectronic.set("contentYear",contentYear);
					}
					if(ContentNumMaintainRecords[0].get("plaitDate") != null){
						var plaitDate = ContentNumMaintainRecords[0].get("plaitDate");
						bptElectronic.set("plaitDate",plaitDate);
					}
					if(bptElectronic.get("archiveNo") != null){
						var archiveNo = bptElectronic.get("archiveNo");
						bptElectronic.set("ARCHIVE_NO",archiveNo);
					}
			});
		}
	});
	//附件信息
	ds.setParameter("PEOPLE_ID",peopleId);
	ds.setParameter("SERVICE_TYPE",serviceType);
	ds.setParameter("ORGAN_ID", organCode);
	ds.load();
	ds.on("load",function(){
	var records=ds.getAllRecords();
		if(records.length>=1){
			var electCount = records.length;
			for(var i=0;i<electCount;i++){
				Id+=records[i].get("electronicId")+":";
			}
		}
	});
}

  /*
   * 解析fileName字段，分别加链接
   */
  /*
   * 解析fileName字段，分别加链接
   */
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
			//Id+=record.get("electronicId")+":";
			var returnfile="<a href='#' style='color:blue;text-decoration:none' onclick='uploadfiles(\""+electronicId+"\")'>查看</a>";
			//alert(returnfile);
			//record[i].set("fileName",returnfile);
			return returnfile;
		}else{
			return "";
		}
 	}
  //查看所有电子档案
function checkElectronic() {
  	var url=L5.webPath+"/jsp/cams/bpt/comm/checkFileview.jsp?Id="+Id+"&serviceType="+serviceType+"&peopleId="+peopleId;
  	var electronic = window.open(url);
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
