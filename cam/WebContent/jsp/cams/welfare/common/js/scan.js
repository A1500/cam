//逝者信息
function scan(){
	try {
		var getreturn =window.showModalDialog(L5.webPath+"/jsp/cams/welfare/common/js/scan.jsp",window,"dialogWidth=0px;dialogHeight=0px;help:no;scroll:no;status:0");
		if(getreturn!=""&&getreturn!=undefined){
			var content = decodeURI(getreturn)
			var list = content.split(";");
			var workerDataSet = L5.DatasetMgr.lookup("workerDataSet");
			workerDataSet.getCurrent().set("name",list[0]);//姓名
			workerDataSet.getCurrent().set("sex",list[1]);//性别
			workerDataSet.getCurrent().set("idCard",list[2]);//证件号码
			//workerDataSet.getCurrent().set("birthday",formatIdCardDate(list[3]));//生日
			//workerDataSet.getCurrent().set("folk",list[4]);//民族
			workerDataSet.getCurrent().set("address",list[5]);//住址
			//document.getElementById("img").src=list[6];//照片路径
			//document.getElementById("photoTemp").value=list[7];//base64
			//PreviewPhoto();
		}
	}
	catch(e)
	{
		alert("错误");
	} 
}
function formatIdCardDate(_date){
	if(_date){
		if(_date.indexOf("-")==-1&&_date.length==8){
			return _date.substr(0,4)+'-'+_date.substr(4,2)+'-'+_date.substr(6,2);
		}
	}
}
//解决ie7不能正常显示照片方法
function PreviewPhoto()
{
	var imgObj=document.getElementsByName("RELATIONER_PHOTOC_IMG")[0];
	var imgDiv=document.getElementById("RELATIONER_PHOTOC_IMG_DIV");
	if(imgDiv!=null){
		imgDiv.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod = scale)";    
		imgDiv.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgObj.src; 
	}else{
		imgDiv=document.createElement("DIV");
		imgDiv.id="RELATIONER_PHOTOC_IMG_DIV";
		imgDiv.name="RELATIONER_PHOTOC_IMG_DIV";
		imgDiv.style.width = imgObj.width;
		imgDiv.style.height = imgObj.height;
		imgDiv.ondblclick=imgObj.ondblclick;
		imgObj.parentElement.insertBefore(imgDiv, imgObj);
		imgDiv.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod = scale)";    
		imgDiv.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgObj.src; 
		imgObj.style.display="none";
	}
}
//承办人信息
function fisPersonalscan(){

	var getreturn =window.showModalDialog(L5.webPath + "/jsp/cams/welfare/common/js/scan.jsp",window,"dialogWidth=0px;dialogHeight=0px;help:no;scroll:no;status:0");
	if(getreturn!=""&&getreturn!=undefined){
		var content = decodeURI(getreturn)
		var list = content.split(";");
		var fisPersonalCustomDS = L5.DatasetMgr.lookup("fisPersonalCustomDS");
		fisPersonalCustomDS.getCurrent().set("name",list[0]);//姓名
		fisPersonalCustomDS.getCurrent().set("sex",list[1]);//性别
		fisPersonalCustomDS.getCurrent().set("idCard",list[2]);//证件号码
		fisPersonalCustomDS.getCurrent().set("address",list[5]);//住址
	}
}