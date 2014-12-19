var video_mode;

function init(){
	if(organCode.substr(0,4)!="3702"){
		document.getElementById("wjsc").style.display="none";
	}
	ds.setParameter("ELECTRONIC_ID", electronicId);
	ds.load();
	ds.on("load",function(){
		var records=ds.getAllRecords();
		var electronicId = records[0].get("electronicId");
		var catalogName = records[0].get("catalogName");
		document.getElementById("electronicId").value = electronicId;
		document.getElementById("catalogName").value = catalogName;
	});	
	
}

 function Video_Source()          						           
 {    
        document.getElementById("VideoChannel").DoCameraConfiguration();       
 }  
 
 function Video_Process()          						           
 {    
        document.getElementById("VideoChannel").VideoProcessing();      
 } 
 
 //选择上传的档案目录
 function selectContent(){
 	var url = "selectCurrentContent.jsp?peopleId="+peopleId+"&serviceType="+serviceType+"&organCode="+organCode;
	var returnValue = window.showModalDialog(url,"","dialogHeight:400px;dialogWidth:678px;resizable:no;scroll:yes;");
	if(returnValue !=''&&returnValue!= undefined ){
		var list = returnValue.split(";");
		document.getElementById("electronicId").value = list[0];
		document.getElementById("catalogName").value = list[1];
	}
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
				document.getElementById("td_dyp360").style.display="none";
	 			document.getElementById("td_dyp").style.display=""; 
	 			video_mode="dyp"; 			
				
			}else if(vdevice=="th")
			{
				document.file.ModeGroup1[1].checked="true";
				document.getElementById("td_th").style.display="";
	 			document.getElementById("td_dyp").style.display="none"; 
	 			document.getElementById("td_dyp360").style.display="none";
	 			video_mode="th";
			}else
				{
				document.file.ModeGroup1[2].checked="true";
				document.getElementById("td_th").style.display="none";
	 			document.getElementById("td_dyp").style.display="none";
	 			document.getElementById("td_dyp360").style.display="";
	 			video_mode="dyp360";
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
		}else if(video_mode=="th")
		{
			document.getElementById("VideoTh").StopPlay();
		}else
		{
			document.getElementById("VideoChannel1").NISetProperty("Do", "DestroyFilterGraph");  //销毁过滤图     
			document.getElementById("VideoChannel1").StopPlay();  
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
			
		}else if(document.file.ModeGroup1[1].checked)
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
		}else
		{
			var dyp=document.getElementById("VideoChannel1");
			//alert(dyp);
		 	dyp.NISetProperty("Do", "DestroyFilterGraph"); //销毁过滤图
			dyp.NISetProperty("InputMode", "3");
			dyp.NISetProperty("SourceFilterName", "NewImage SuperCam");//设置视频拍摄仪AF360
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
			
			document.getElementById("VideoChannel1").StartPlay();
		}
	}catch(err)
    {
    	alert("选择的设备不存在，或者没有安装驱动程序");
    	return false;
    }
	
 }
 function paizhao()
 {	
 	if(document.getElementById("catalogName").value=="")
 	{
 		alert("请先选择档案目录再拍照上传！");
 		return false;
 	}
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
	 	fileName=i;
	 	if(document.file.ModeGroup1[0].checked)//多易拍540
	 	{
		 	document.getElementById("VideoChannel").ColorMode = 1;
		    document.getElementById("VideoChannel").AutoFit = false;
		    document.getElementById("VideoChannel").NISetProperty("EnableTargetDPI", "YES");//是否启用DPI       
		    document.getElementById("VideoChannel").EnablePreview = false;
			document.getElementById("VideoChannel").DoGrabAndEdit();	
		    document.getElementById("VideoChannel").SaveToFile(filePath+"/"+fileName+"."+fileType);
	    }else if(document.file.ModeGroup1[1].checked)
	    {
	   		 document.getElementById("VideoTh").Save(2, filePath+"/"+fileName+"."+fileType);
	    }else//多易拍360
	    {
	    	document.getElementById("VideoChannel1").ColorMode = 1;
		    document.getElementById("VideoChannel1").AutoFit = false;
		    document.getElementById("VideoChannel1").NISetProperty("EnableTargetDPI", "YES");//是否启用DPI       
		    document.getElementById("VideoChannel1").EnablePreview = false;
			document.getElementById("VideoChannel1").DoGrabAndEdit();	
		    document.getElementById("VideoChannel1").SaveToFile(filePath+"/"+fileName+"."+fileType);
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
    	//alert("js:"+s);    
    	document.getElementById("filecode").value=s;
    	
		
 }  
 function fileUpload()
 {
 	if(document.getElementById("filecode").value=="")
 	{
 		alert("请先拍照后再上传！");
 		return false;
 	}
 	fileName=i;
 	var command=new L5.Command("com.inspur.cams.bpt.bptelectronicfile.cmd.BptUploadfileCommand");
		
 	var electronicId = document.getElementById("electronicId").value;
	command.setParameter("electronicId",electronicId);
			command.setParameter("fileName",fileName+"."+fileType);
			//command.setParameter("fileMess",document.getElementById("filecode").value);
			command.setParameter("rangeFlag",grabFlag);//设置图片是横向，竖向排列
			command.setForm("fileform");
			//alert("2");
			command.execute("fileupload");
			//alert("3");
			//包含有大字段的异常判断
			command.afterExecute=function(){
				if(!command.error){
					L5.Msg.alert("提示","上传附件成功!");
				}else{
					if(command.error.message=="提交数据量超出系统限制"){
						L5.Msg.alert("提示","上传图片太大!");
					}else{
						L5.Msg.alert("提示",(command.error.message+'').replace("出现系统异常",""),{});
					}
				    
			    }
			}
			//L5.Msg.alert("提示","上传附件成功!");
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
	 	}else if(document.file.ModeGroup1[1].checked)
	 	{
	 		video_mode="th";
	 	}else
	 	{
	 		video_mode="dyp360";
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
function getPath(){
	var ufile = document.getElementById("ufile").value;
	
	var pos = ufile.lastIndexOf(".");
	var filetype = ufile.substr(pos +1);
	if(filetype!='jpg'&&filetype!='JPG'&&filetype!='JPEG'&&filetype!='jpeg'){
		alert("请选择jpg格式的档案材料!");
		return;
	}
	
	var _obj= document.getElementById("delbase64");		
		_obj.encodebase(ufile); 
	var s = _obj.basestr;   
	//alert("js:"+s);    
	//alert(s.length);
	document.getElementById("filecode").value=s;
	
}
 