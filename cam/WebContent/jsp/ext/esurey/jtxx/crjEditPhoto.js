/*****************************************************
*
*           主要功能:  采集证件扫描照片
*           作者：      王德强
*           版本：      V2.0
******************************************************/
//根据对象的ID获取对象
function $ID(_sId){
	return document.getElementById(_sId);
}

//根据对象的Name获取对象
function $Name(_sId){
	return document.getElementsByName(_sId);
}

//根据对象的Name，判断对象是否存在
function exist(_sName){
	return document.getElementsByName(_sName)[0] != null;
}

//根据对象的ID，判断对象是否存在
function existId(_sId){
	return document.getElementById(_sId) != null;
}

//将字符串输出到浏览器页面
function dw(_sStr){
	document.write(_sStr);
}
//清除选择的照片
function clearSelect(_sId){
	$ID("filePath1").value  = "";
	var t = $ID("fileKey" + _sId).value;
	$Name(t)[0].value= "";
	$ID("picShow" + _sId).innerHTML = "<span style='color:#7f7f7f'>请扫描申请人照片</span>";
}

//显示选择的照片
function initUpload(_oObj, _sId, _sImgName){
	$Name(_sImgName)[0].src = "file://localhost/" + _oObj.value;
	PreviewPhoto(_sImgName);
}

//解决ie7不能正常显示照片方法
function PreviewPhoto(imgName)
{
	var imgObj=document.getElementsByName(imgName)[0];
	var imgDiv=document.getElementById(imgName+"_DIV");

	if(imgDiv!=null){
		imgDiv.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod = scale)";
		imgDiv.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgObj.src;
	}else{
		imgDiv=document.createElement("DIV");
		imgDiv.id=imgName+"_DIV";
		imgDiv.name=imgName+"_DIV";
		imgDiv.style.width = imgObj.width;
		imgDiv.style.height = imgObj.height;
		imgDiv.ondblclick=imgObj.ondblclick;
		imgObj.parentElement.insertBefore(imgDiv, imgObj);
		imgDiv.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod = scale)";
		imgDiv.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgObj.src;
		imgObj.style.display="none";
	}
}

//显示选择的照片
function showPhoto(photoID, _sId,_sImgName){
	$Name(_sImgName)[0].src = "downloadPhoto?primaryKey=" + photoID;
}

//提示选择图片格式不对
function picError(_oObj, _oParent) {
	_oParent.innerHTML = "<font color='red'><b>非法图片</b></font>";
}

// 完成照片操作
var opring = false;
function editPhoto(_sId,fileContentName,_sImgName){
	if(!opring){
		if (exist(fileContentName)&&exist(_sImgName)){
			try{
				$ID("LangchaoCRJ").OprType = _sId;
				$ID("LangchaoCRJ").SrcFlag = fileContentName;
				$ID("LangchaoCRJ").QcSvr = getPathName();
				opring = true
				$ID("LangchaoCRJ").ShowEditPhoto();
				opring = false;
				if ($ID("LangchaoCRJ").PhotoText!=""){
					$Name(fileContentName)[0].value= $ID("LangchaoCRJ").PhotoText;
					$ID("filePath1").value=$ID("LangchaoCRJ").PhotoPath;
					initUpload($ID("filePath1"), _sId,_sImgName);
				}
			}
			catch(e){	//判断组件是否安装
				alert("无法完成您指定的操作！\n\n" +
					  "    可能原因：没有安装LangchaoCRJ组件，请参见相关说明解决！！\n" +
					  "    如果确认组件已经安装，请咨询系统管理人员解决！\n"+e.message+"\n"+e.name);
			}
		}else{
			alert('设置采集申请人照片参数有误！');
		}
	}
}
// 照片操作 通过对象保存返回值
function editPhotoByObj(_sId,tmpObj,imgObj){
	try{
		$ID("LangchaoCRJ").OprType = _sId;
		$ID("LangchaoCRJ").SrcFlag = "ralationPhotoT";
		$ID("LangchaoCRJ").ShowEditPhoto();
		if ($ID("LangchaoCRJ").PhotoText!=""){
			tmpObj.value = $ID("LangchaoCRJ").PhotoText;
			imgObj.src = "file://localhost/" + $ID("LangchaoCRJ").PhotoPath;
		}
	}
	catch(e){	//判断组件是否安装
		alert("无法完成您指定的操作！\n\n" +
			  "    可能原因：没有安装LangchaoCRJ组件，请参见相关说明解决！！\n" +
			  "    如果确认组件已经安装，请咨询系统管理人员解决！\n");
	}
}
// 采集照片并进行照片比对
var opringV = false;
function editVerifyPhoto(_sId,fileContentName,_sImgName){
	if(!opringV){
		if (exist(fileContentName)&&exist(_sImgName)){
			try{
				$ID("LangchaoCRJ").OprType = _sId;
				$ID("LangchaoCRJ").SrcFlag = fileContentName;
				$ID("LangchaoCRJ").QcSvr = getPathName();
				opringV = true
				$ID("LangchaoCRJ").ShowEditPhoto();
				opringV = false;
				if ($ID("LangchaoCRJ").PhotoText!=""){
					$Name(fileContentName)[0].value= $ID("LangchaoCRJ").PhotoText;
					$ID("filePath1").value=$ID("LangchaoCRJ").PhotoPath;
					initUpload($ID("filePath1"), _sId,_sImgName);
					comparePhoto(); //照片比对
				}
			}
			catch(e){	//判断组件是否安装
				alert("无法完成您指定的操作！\n\n" +
					  "    可能原因：没有安装LangchaoCRJ组件，请参见相关说明解决！！\n" +
					  "    如果确认组件已经安装，请咨询系统管理人员解决！\n"+e.message);
			}
		}else{
			alert('设置采集申请人照片参数有误！');
		}
	}
}
// 预采集照片模式
function priorEditPhoto(_sId,photoObj,imgObj){
	if (exist(fileContentName)&&exist(_sImgName)){
		try{
			$ID("LangchaoCRJ").OprType = _sId;
			$ID("LangchaoCRJ").SrcFlag = fileContentName;
			$ID("LangchaoCRJ").ShowEditPhoto();
		}catch(e){	//判断组件是否安装
			alert("无法完成您指定的操作！\n\n" +
				  "    可能原因：没有安装LangchaoCRJ组件，请参见相关说明解决！！\n" +
				  "    如果确认组件已经安装，请咨询系统管理人员解决！\n");
		}
		if ($ID("LangchaoCRJ").PhotoText!=""){
			var photoBase64 = $ID("LangchaoCRJ").PhotoText;
			var photoID = uploadPhoto(photoBase64);
			photoObj.value = photoID;
			imgObj.src = "downloadPhoto?primaryKey=" + photoID;
		}
	}else{
		alert('设置采集申请人照片参数有误！');
	}
}
// 完成组件初始化
function initForm(_sId,fileContentName,_sFlag){
	var sFileUpload = '\
	<div style="display:none">\
		<input name="filePath" type="text" id="filePath' + _sId + '">\
		<OBJECT\
		  classid="clsid:B5E53D86-656C-4A44-A1BB-00C80523F0D0"\
		  codebase="../jtxx/LangchaoCRJ.inf#version=3,9,5,3"\
		  width=239\
		  height=90\
		  align=center\
		  hspace=0\
		  vspace=0\
		  id="LangchaoCRJ"\
		>\
		</OBJECT>\
	</div>\
	';
	dw(sFileUpload);
	$ID("LangchaoCRJ").QcSvr = getQcSvr();
	$ID("LangchaoCRJ").CodingFlag="1";
	//alert($ID("LangchaoCRJ"));
}
function getQcSvr(){
	var url=window.location.href;
	var pos=url.lastIndexOf("\\");//如果是网上文件，路径分割符为"\\"
	if (pos==-1) pos=url.lastIndexOf("/");   //本地文件路径分割符为"/"
	var fileName=url.substring(0,pos+1);   //从url中获得路径
	//alert(fileName);
	return fileName;
}

function getPathName(){
	var url=window.location.href;
	var pos=url.lastIndexOf("\\");
	if(pos==-1) pos=url.lastIndexOf("/");
	var fileName=url.substring(0,pos+1);
	if (fileName.indexOf("https")!=-1) {
		fileName = fileName.replace("https","http");
		fileName = fileName.replace(":9444",":9080");
		fileName = fileName.replace(":9443","");
	}
	return fileName;
}
// 初始化组件到页面
initForm(1,'',1);