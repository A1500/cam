var Id = '';
var serviceType1;
function init(){
	var dsPro = L5.DatasetMgr.lookup("dsPro");
	dsPro.setParameter("PEOPLE_ID",peopleId);
	dsPro.setParameter("serviceType",serviceType);
	dsPro.load();
	var ds = L5.DatasetMgr.lookup("ds");
	ds.on("load",function(){
		Id = "";
		var records=ds.getAllRecords();
		if(records.length>=1){
			upload_detail();
		}
	});
}

//选择不同的业务类型，显示具体电子档案信息
function selectService(a,b,record) {
	serviceType = record.get("SERVICE_TYPE");
	serviceType1 = serviceType;
	ds.setParameter("PEOPLE_ID",peopleId);
	ds.setParameter("serviceType",serviceType);
	ds.setParameter("ORGAN_ID", organCode);
	ds.load();
}

//关闭窗口
function func_Close(){
	window.close();
}

//渲染电子档案链接
function fileNameFormat(value,cellmeta,record) {
	if(value!="") {
		var eId = record.get("electronicId");
		return "<a href='#' style='color:blue;text-decoration:none' onclick='uploadfiles(\""+eId+"\")'>查看</a>";
	} else {
		return value;
	}
}

//查看电子档案链接
function uploadfiles(electronicId){
	var url=L5.webPath+"/jsp/cams/bpt/comm/fileview.jsp?electronicId="+electronicId;
	var hPopup=window.open(url,"fielview","location=1,status=1,toolbar=1,directories=1,menubar=1,scrollbars=1,resizable=1,top=0,left=0");
    hPopup.resizeTo(screen.availWidth,screen.availHeight);
}

// 解析fileName字段，分别加链接
function upload_detail(){
 	var record=ds.getAllRecords();
 	var fileName="";
 	var fileId="";
 	var electronicId="";
 	for(var i=0;i<record.length;i++){
 		fileName =record[i].get("fileName");
 		electronicId=record[i].get("electronicId");
 		fileId=record[i].get("fileId");
		if(fileName!=""){
			Id+=record[i].get("electronicId")+":";
		}
 	}
}

//查看全部电子档案
function viewAll(){
   var url=L5.webPath+"/jsp/cams/bpt/comm/checkFileview.jsp?Id="+Id+"&serviceType="+serviceType1+"&peopleId="+peopleId;
   var param = window.dialogArguments;
   var electronic = param.window.open(url);
}
