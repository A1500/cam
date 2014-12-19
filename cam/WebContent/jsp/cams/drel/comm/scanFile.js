var video_mode;

function init(){
	filesScanDataset.newRecord({"applyId":applyId});
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
 	
	var filesScanDatasetValidate = filesScanDataset.isValidate();
	if(filesScanDatasetValidate != true){
		L5.Msg.alert("提示",filesScanDatasetValidate);
		return false;
	}		
 	/*if(document.getElementById("catalogName").value=="")
 	{
 		alert("请先选择档案目录再拍照上传！");
 		return false;
 	}*/
 	if(grabFlag=="2")//横向，需要变为竖向
 	{
 		Stop(); 
 		Start();
 		grabFlag="1";//竖向
 	} 	
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
	 	i++;
	 	fileName=document.getElementById("fileType").value;
	 	if(document.file.ModeGroup1[0].checked)//多易拍
	 	{
		 	document.getElementById("VideoChannel").ColorMode = 1;
		    document.getElementById("VideoChannel").AutoFit = false;
		    document.getElementById("VideoChannel").NISetProperty("EnableTargetDPI", "YES");//是否启用DPI       
		    document.getElementById("VideoChannel").EnablePreview = false;
			document.getElementById("VideoChannel").DoGrabAndEdit();	
		    document.getElementById("VideoChannel").SaveToFile(filePath+"/"+fileName+"."+fileType);
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
    	document.getElementById("filecode").value=s;
    	
		
 }  
 function fileUpload()
 {
 	if(document.getElementById("filecode").value=="")
 	{
 		alert("请先拍照后再上传！");
 		return false;
 	}
 	fileName=document.getElementById("fileType").value;;
	var command = new L5.Command("com.inspur.cams.drel.sam.cmd.SamApplyFilesCmd");
	filesScanDataset.set('fileName',fileName+"."+fileType);
	command.setParameter("scanRd",filesScanDataset.getCurrent());
	command.setParameter("fileMess",document.getElementById("filecode").value);
	command.execute("saveScan");
	if(!command.error){
		saveSuccessAlert();
	}else{
	    L5.Msg.alert("提示",(command.error+'').replace("出现系统异常",""),{});
    }
 }
//扫描成功的提示信息
function saveSuccessAlert(){
	L5.MessageBox.confirm('提示','上传附件成功！是否继续上传申请证明材料？',function(state){
		if(state=="yes"){		
			//继续添加
			filesScanDataset.newRecord({'applyId':applyId});
			i='';
			fileName='';
			grabFlag='1';
			document.getElementById("filecode").value=="";
		}else{
			//关闭窗口
			closeScan();
		}
	});
}
//关闭窗口
function closeScan(){
	var parent=window.dialogArguments;
	var filesListDataset=parent.filesListDataset;
	filesListDataset.setParameter("APPLY_ID",applyId);
    filesListDataset.setParameter("FILE_TYPE@IN","101,102,201,202,203,204,205,206,207,208,209,210,301,001,000");
	filesListDataset.load();
	window.close();
}
 
 function thStartPlay()
	{
		document.getElementById("VideoTh").AutoRemoveBorder = false; <!--自动检测纸张大小,需要使用黑背景-->
		document.getElementById("VideoTh").Ratio = 38;  		<!--图像缩放百分比,可控制最终图像大小-->
		document.getElementById("VideoTh").JPEG_QT = 75;		<!--JPEG压缩质量,可控制最终图像大小-->
		document.getElementById("VideoTh").VideoRotate = 90;	<!--视频旋转角度-->
		document.getElementById("VideoTh").ImageRotate = 0;		<!--抓取图像的旋转角度-->
		document.getElementById("VideoTh").DPI = 75;		<!--图像保存时的分辨率-->

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

 