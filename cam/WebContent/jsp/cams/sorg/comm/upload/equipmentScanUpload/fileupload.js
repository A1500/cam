var video_mode;

function init(){

}

 function Video_Source()
 {
        document.getElementById("VideoChannel").DoCameraConfiguration();
 }

 function Video_Process()
 {
        document.getElementById("VideoChannel").VideoProcessing();
 }


 function Start()
 {
 	try
 	{
	 	var _obj= document.getElementById("delbase64");
	 	_obj.direxist(filePath);
		var vdevice=_obj.devicetype;
		if(vdevice=='0')
		{
			alert("请选择文拍仪设备！");
			return false;

		}else
		{
			if(vdevice=="dyp")
			{
				document.file.ModeGroup1[0].checked="true";
				document.getElementById("td_th").style.display="none";
	 			document.getElementById("td_dyp").style.display="";
	 			video_mode="dyp";

			}else
			{
				document.file.ModeGroup1[1].checked="true";
				document.getElementById("td_th").style.display="";
	 			document.getElementById("td_dyp").style.display="none";
	 			video_mode="th";
			}
		}

 	}catch(err)
 	{
 		return false;
 	}
 }

 function Stop()
 {
 	try
 	{
 		if(video_mode=="dyp")
 		{
	  		document.getElementById("VideoChannel").NISetProperty("Do", "DestroyFilterGraph");  //销毁过滤图
			document.getElementById("VideoChannel").StopPlay();
		}else
		{
			document.getElementById("VideoTh").StopPlay();
		}
	}catch(err)
	{
		//alert("--");
	}
 }

 function format(dushu)
 {
 	try
 	{
		if(document.file.ModeGroup1[0].checked){
			var dyp=document.getElementById("VideoChannel");
			//alert(dyp);
		 	dyp.NISetProperty("Do", "DestroyFilterGraph"); //销毁过滤图
			dyp.NISetProperty("InputMode", "3");
			dyp.NISetProperty("SourceFilterName", "NewImage DocCam");//设置视频拍摄仪AF540
			dyp.NISetProperty("SamplerEnable", "YES");
			dyp.NISetProperty("SealMaskEnable", "YES");
			dyp.NISetProperty("KeepVideoAspectEnable", "YES");//保持长宽比的视频流
			dyp.NISetProperty("CameraFOVHeight", "25.95");//设定视场范围长、宽
			dyp.NISetProperty("CameraFOVWidth", "34.6");
			dyp.AllowContextMenu = false;
			dyp.NISetProperty("EnableTargetDPI", "YES");//是否启用DPI
			//document.getElementById("VideoChannel").NISetProperty("TargetDPIMono", "200");//设置黑白DPI
			dyp.NISetProperty("TargetDPIColor", "85");//设置彩色DPI
			dyp.NISetProperty("WarpingEffectEnable", "YES");//几何变化
			dyp.NISetProperty("Do", "CreateAllFilters");//完成所有视频和音频源的相关参数
			dyp.NISetProperty("VideoRotating", dushu);//视频旋转，须开启几何变化
			dyp.NISetProperty("SelectSourceFormat", "1200 1000");//

			document.getElementById("VideoChannel").StartPlay();

		}else
		{
			//泰和
			//alert("th");
	 		document.getElementById("td_th").style.display="";
	 		document.getElementById("td_dyp").style.display="none";
	 		video_mode="th";
	 		document.getElementById("VideoTh").AutoRemoveBorder = false;
			document.getElementById("VideoTh").Ratio = 38;
			document.getElementById("VideoTh").JPEG_QT = 75;
			//alert(grabFlag);
			if(grabFlag=='1')
			{
				document.getElementById("VideoTh").VideoRotate = 90;
			}else
			{
				document.getElementById("VideoTh").VideoRotate = 0;
			}
			document.getElementById("VideoTh").ImageRotate = 0;
			document.getElementById("VideoTh").DPI = 75;
			document.getElementById("VideoTh").StartPlay();
		}
	}catch(err)
    {
    	alert("选择的设备不存在，或者没有安装驱动程序");
    	return false;
    }

 }
 function paizhao()
 {
 	if(grabFlag=="2")//横向，需要变为竖向
 	{
 		Stop();
 		Start();
 		grabFlag="1";//竖向
 	}
  if(document.getElementById("fileName").value=="")
   	{
  	alert("请先输入文件名称再上传！"); document.getElementById("fileName").focus(); return;
  	}
 //	beforeUploadCheck();
 	fileName=document.getElementById("fileName").value;
 //	alert(0);
 	//beforeUploadCheck();
 	//alert(filePath+","+fileName+","+fileType);
 	grab(filePath,fileName,fileType);
 }
 function paizhao1()
 {
 	if(grabFlag=="1")//横向，需要变为竖向
 	{
 		Stop();
 		grabFlag="2";
 		format("0 0");
 	}
 	  if(document.getElementById("fileName").value=="")
   	{
  	alert("请先输入文件名称再上传！"); document.getElementById("fileName").focus(); return;
  	}
  	fileName=document.getElementById("fileName").value;
 	grabFlag="2";
 	grab(filePath,fileName,fileType);

 }
 function grab(filePath,fileName,fileType)
 {
 	try
 	{
		var _obj= document.getElementById("delbase64");
		_obj.direxist(filePath);//判断客户端文件夹是否存在，如果不存在创建文件夹
		s=_obj.direxistflag;
	 //	i++;
	 	//fileName=i;
	 	if(document.file.ModeGroup1[0].checked)//多易拍
	 	{
		 	document.getElementById("VideoChannel").ColorMode = 1;
		    document.getElementById("VideoChannel").AutoFit = false;
		    document.getElementById("VideoChannel").NISetProperty("EnableTargetDPI", "YES");//是否启用DPI
		    document.getElementById("VideoChannel").EnablePreview = false;
			document.getElementById("VideoChannel").DoGrabAndEdit();
		    document.getElementById("VideoChannel").SaveToFile(filePath+"/"+fileName+"."+fileType);
		    // var file_obj=  document.getElementById("files");
		  //  var path=filePath+"/"+fileName+"."+fileType;
		   // file_obj.outerHTML=file_obj.outerHTML.replace(/(path=\").+\"/i,"$1\"");
		   //  file_obj.focus();
		  //   var wshshell=new ActiveXObject("WScript.Shell");
		  //  wshshell.SendKeys("{Tab}");
		 //  wshshell.SendKeys("{}");
		   // wshshell.SendKeys("path");
		     // wshshell.SendKeys("{Enter}");
	    }else
	    {
	   		 document.getElementById("VideoTh").Save(2, filePath+"/"+fileName+"."+fileType);
	    }
	 	getFileBase64(filePath,fileName,fileType);
    }catch(err)
    {
    	//alert(err+"加载控件出错");
    	return false;
    }
    fileUpload();
 }

 function getFileBase64(filePath,fileName,fileType)
 {
 		var _obj= document.getElementById("delbase64");
 		_obj.encodebase(filePath+"/"+fileName+"."+fileType);
    	var s = _obj.basestr;
    	// alert("js:"+s);
    	document.getElementById("filecode").value=s;


 }
 function fileUpload()
 {
 	if(type=="normal"){
 		fileUploadNormal();
 	}
 	if(type=="people"){
 		fileUploadPeople();
 	}
 	if(type=="legalPeople"){
 		fileUploadLegalPeople();
 	}
 }

 function beforeUploadCheck(){
 	if(document.getElementById("filecode").value=="")
 	{
 		alert("请先拍照后再上传！");
 		return  ;
 	}
 	if(document.getElementById("fileName").value=="")
 	{
 		alert("请先输入文件名称再上传！");
 		document.getElementById("fileName").focus();
 		return  ;
 	}
 }
 //法律要件列表、归档列表上传
 function fileUploadNormal()
 {

 //	beforeUploadCheck();
	var command=new L5.Command("com.inspur.cams.sorg.upload.cmd.SomElectronicCmd");
	command.setParameter("filecode",document.getElementById("filecode").value);
   	command.setForm("form_content");
	command.setParameter("uploadRd",window.opener.getUploadRecord());
	command.setParameter("fileName",document.getElementById("fileName").value+".JPG");
	command.execute("uploadSaveByEquipment");
	//包含有大字段的异常判断
	if(!command.error){
		L5.Msg.alert("提示","上传附件成功!",function(){
			window.opener.uploadWinHide();
		});
		window.opener.winElectronicDataSetload();
	}
	else{
        L5.Msg.alert("提示",(''+command.error).replace("出现系统异常",""),{});
    }
 }

 //负责人上传
 function fileUploadPeople()
 {
 	beforeUploadCheck();
	var command=new L5.Command("com.inspur.cams.sorg.upload.cmd.SomElectronicCmd");
	command.setParameter("filecode",document.getElementById("filecode").value);
	command.setParameter("uploadRd",window.opener.getUploadRecord());
	command.setParameter("fileName",document.getElementById("fileName").value+".JPG");
	command.execute("uploadSaveByEquipment");
	//包含有大字段的异常判断
	if(!command.error){
		L5.Msg.alert("提示","上传附件成功!",function(){
			//window.opener.uploadWinHide();
		});
		window.opener.winPeopleElectronicDataSetload();
	}
	else{
        L5.Msg.alert("提示",(''+command.error).replace("出现系统异常",""),{});
    }
 }

 //法定代表人上传
 function fileUploadLegalPeople()
 {
 	beforeUploadCheck();
	var command=new L5.Command("com.inspur.cams.sorg.upload.cmd.SomElectronicCmd");
	command.setParameter("filecode",document.getElementById("filecode").value);
	command.setParameter("uploadRd",window.opener.getUploadRecord());
	command.setParameter("fileName",document.getElementById("fileName").value+".JPG");
	command.execute("uploadSaveByEquipment");
	//包含有大字段的异常判断
	if(!command.error){
		L5.Msg.alert("提示","上传附件成功!",function(){
			//window.opener.uploadWinHide();
		});
		window.opener.winLegalPeopleElectronicDataSetload();
	}
	else{
        L5.Msg.alert("提示",(''+command.error).replace("出现系统异常",""),{});
    }
 }

 function thStartPlay()
	{
		document.getElementById("VideoTh").AutoRemoveBorder = false; //自动检测纸张大小,需要使用黑背景-->
		document.getElementById("VideoTh").Ratio = 38;  		//图像缩放百分比,可控制最终图像大小-->
		document.getElementById("VideoTh").JPEG_QT = 75;		//JPEG压缩质量,可控制最终图像大小-->
		document.getElementById("VideoTh").VideoRotate = 90;	//视频旋转角度-->
		document.getElementById("VideoTh").ImageRotate = 0;		//抓取图像的旋转角度-->
		document.getElementById("VideoTh").DPI = 75;		//图像保存时的分辨率-->

		document.getElementById("VideoTh").StartPlay();
	}

function changeModel()
{
	try{
		if(document.file.ModeGroup1[0].checked){
	 		video_mode="dyp";
	 	}else
	 	{
	 		video_mode="th";
	 	}
	 	//alert("2"+video_mode);
	 	var _obj= document.getElementById("delbase64");
		_obj.direxist(filePath);//判断客户端文件夹是否存在，如果不存在创建文件夹
		_obj.devicetype=video_mode;
		_obj.direxist(filePath);
	}
	catch(err)
	{
		//alert(err);
	}
	Stop();
	Start();
	window.setTimeout("format('0 -90')",500);
}

