var stype;
var abcardflag;//判定用的那个读卡器 
var GT_IDCard;
function objfun(){
 /*var ooo='<div style="display:none"><OBJECT classid="clsid:10946843-7507-44FE-ACE8-2B3483D179B7" '+
 		 'CODEBASE="'+L5.webPath+'/jsp/cams/bpt/comm/GTIdrOcx.cab#version=1,0,0,5" '+
 		 'id="GT_IDCard" name="GT_IDCard" width=0 height=0> '+
 		'</object></div>';
 document.write(ooo);*/
	var bb='<OBJECT classid="clsid:10946843-7507-44FE-ACE8-2B3483D179B7" '+
 '	CODEBASE="'+L5.webPath+'/jsp/cams/bpt/comm/GT_IdrOcx.dll#version=1,0,0,5" '+
       ' id="GT_IDCardb" name="GT_IDCardb" width=0 height=0>'+
'</OBJECT>';
	
 		document.writeln(bb);
}
objfun();
var docEle = function() {
    return document.getElementById(arguments[0]) || false;
 }

function Mask(message) {
     var m = "mask";
     if (docEle(message.id)) document.body.removeChild(docEle(message.id));
     if (docEle(m)) document.body.removeChild(docEle(m));

      //mask遮罩层
      this.newMask = document.createElement("div");
      this.newMask.id = m;
      this.newMask.style.position = "absolute";
      this.newMask.style.zIndex = "1";
      _scrollWidth = Math.max(document.body.scrollWidth, document.documentElement.scrollWidth);
      _scrollHeight = Math.max(document.body.scrollHeight, document.documentElement.scrollHeight);
      this.newMask.style.width = _scrollWidth + "px";
      this.newMask.style.height = _scrollHeight + "px";
      this.newMask.style.top = "0px";
      this.newMask.style.left = "0px";
      this.newMask.style.background = "#33393C";
      this.newMask.style.filter = "alpha(opacity=10)";
      this.newMask.style.opacity = "0.20";
      document.body.appendChild(this.newMask);

      //新弹出层
      this.newDiv = document.createElement("div");
      this.newDiv.id = message.id;
      this.newDiv.style.position = "absolute";
      this.newDiv.style.zIndex = "9999";
      newDivWidth = 400;
      newDivHeight = 200;
      this.newDiv.style.width = newDivWidth + "px";
      this.newDiv.style.height = newDivHeight + "px";
      this.newDiv.style.top = (document.body.scrollTop + document.body.clientHeight / 2 - newDivHeight / 2) + "px";
      this.newDiv.style.left = (document.body.scrollLeft + document.body.clientWidth / 2 - newDivWidth / 2) + "px";
      this.newDiv.style.background = "#EFEFEF";
      this.newDiv.style.border = "1px solid #860001";
      this.newDiv.style.padding = "60px";
      this.newDiv.style.textAlign	="center"	;
      this.newDiv.style.ma	="center"	;
     
      this.newDiv.innerHTML = "请放入第二代身份证!";
      document.body.appendChild(this.newDiv);
      //弹出层滚动居中

      var newDivCenter =function() {
         document.getElementById(message.id).style.top = (document.body.scrollTop + document.body.clientHeight / 2 - this.newDivHeight / 2) + "px";
         document.getElementById(message.id).style.left = (document.body.scrollLeft + document.body.clientWidth / 2 - this.newDivWidth / 2) + "px";
      }
      if (document.all) {
          window.attachEvent("onscroll", newDivCenter);
      }
      else {
          window.addEventListener('scroll', newDivCenter, false);
      }
  		 //关闭新图层和mask遮罩层
	  this.maskClose=function() {
	        if (document.all) {
	            window.detachEvent("onscroll", newDivCenter);
	        }
	        else {
	            window.removeEventListener('scroll', newDivCenter, false);
	        }
	        if(docEle(message.id)){
	        	document.body.removeChild(docEle(message.id));
	        document.body.removeChild(docEle(m));
	        }
	        clearInterval(timeoutr);
	        clearInterval(timer);
	        return false; 
      }
       this.newA = document.createElement("a");
       this.newA.href = "#";
       this.newA.innerHTML = "关闭";
       this.newA.onclick =  this.maskClose;
       this.newDiv.appendChild( this.newA);    
}
            
/*********************************设置mask End*********************************************************/			
var pName=""; 
var pSex="";
var pNation="";
var pBorn="";
var pAddress="";
var pCardNo="";
var pPolice="";
var pActivityLFrom=""; 
var pActivityLTo=""; 
var pPhotoBuffer=""; 
var pPrintPhotoBuffer="";  
           
var b=false;
var timer=null;
var timeoutr=null;
function ReadIDCard(method) {
 	/*if(!document.getElementById("GT_IDCard")){
 		var obj =document.createElement("OBJECT");
	 	obj.classid="clsid:10946843-7507-44FE-ACE8-2B3483D179B7";
	 	obj.CODEBASE="GTIdrOcx.cab#version=1,0,0,6";
	 	obj.id="GT_IDCard";
	 	obj.name="GT_IDCard";
	 	document.body.appendChild(obj);
 	
	}*/
   // clearForm();
	/*
	if(!document.getElementById("GT_IDCarda")){
		var aa='<OBJECT classid="clsid:8BA7B7FB-733E-498D-8612-93373E028B5F" '+
	    ' id="GT_IDCarda" name="GT_IDCarda" width=0 height=0>'+
	'</OBJECT>';
		document.getElementsByName("RELATIONER_PHOTOC_IMG")[1].parentNode.innerHTML=aa;
		document.getElementById("GT_IDCarda").width='338';
		document.getElementById("GT_IDCarda").height='472';
		L5.getCmp("imgshow").setHeight(500);
		
	}*/

	var ret="";
	try{
		ret= GT_IDCardb.HidReadCard();
	}catch (e) 
	{ 
		if(e.message=='对象不支持此属性或方法'){
			alert("请设置信用站点后,下载读卡器控件[GT_Idr0cx.dll]!");
			return ;
		}
		
	} 
	
	
	if (ret == "未找到设备"){
		if(!document.getElementById("GT_IDCarda")){
			var aa='<OBJECT classid="clsid:8BA7B7FB-733E-498D-8612-93373E028B5F" '+
		    ' id="GT_IDCarda" name="GT_IDCarda" width=0 height=0>'+
		'</OBJECT>';
			if(document.getElementsByName("RELATIONER_PHOTOC_IMG")[1]){
				document.getElementsByName("RELATIONER_PHOTOC_IMG")[1].parentNode.innerHTML+=aa;
				document.getElementById("GT_IDCarda").width='338';
				document.getElementById("GT_IDCarda").height='472';
				document.getElementsByName("RELATIONER_PHOTOC_IMG")[1].style.display='none';
				L5.getCmp("imgshow").setHeight(500);
			}else{
				document.getElementsByName("RELATIONER_PHOTOC_IMG")[0].parentNode.innerHTML+=aa;
			}
		}
		
		GT_IDCard=document.getElementById("GT_IDCarda");
		abcardflag='a';
	}else {
		GT_IDCard=document.getElementById("GT_IDCardb");
		abcardflag='b';
	}
	var message={
		id:"dddd"
	};
	var mask= new Mask(message);
	 timer=setInterval(function(){
   	 GT_IDCard.PhotoPath = "c:\\1";
   	
	   var ret = GT_IDCard.HidReadCard();
	   if(ret==''){
		   createfilepath();//创建文件夹
	   }
	   if (ret == "0"){
	   	  mask.maskClose();
	   	  b=true;
	      getMessage();
	      scan(method);
	      if(b){
	      	clearInterval(timeoutr);
	 		clearInterval(timer);
	 		b=false;
	 	  }
	      return;
   	   }else if(ret=="未找到设备"||ret == "未找到读卡器"){
   	 		mask.maskClose();	
   	 		clearInterval(timeoutr);
   	 		clearInterval(timer);
		 		b=false;
		 		if(abcardflag=='b'){
		 			alert(ret);
		 		}else{
		 			alert(ret+"或未正确安装驱动程序!");
		 		}
		 		
   	 	}},500) ;
  timeoutr=setInterval(function(){
	 	
	 	mask.maskClose();
	 		clearInterval(timer);
	 		clearInterval(timeoutr);
		 		alert("等待读卡超时!");
		},1000*60*1) ;
}
 
function getMessage() {   
  pName=GT_IDCard.Name; 
  pSex=GT_IDCard.Sex;
  pBorn=formatIdCardDate(GT_IDCard.Born);
  pAddress=GT_IDCard.Address;
  pCardNo=GT_IDCard.CardNo;
  pPolice=GT_IDCard.IssuedAt;
  pActivityLFrom=GT_IDCard.EffectedDate; 
  pActivityLTo=GT_IDCard.ExpiredDate; 
  pPhotoBuffer=GT_IDCard.Picture; 
  pPrintPhotoBuffer=GT_IDCard.Base64PrintJpg; 
  
  var nationCode=new Array("01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","68");
  var nationName=new Array("汉","蒙古","回","藏","维吾尔","苗","彝","壮","布依","朝鲜","满","侗","瑶","白","土家","哈尼","哈萨克","傣","黎","傈僳","佤","畲","高山","拉祜","水","东乡","纳西","景颇","柯尔克孜","土","达斡尔","仫佬","羌","布朗","撤拉","毛难","仡佬","锡伯","阿昌","普米","塔吉克","怒","乌孜别克","俄罗斯","鄂温克","崩龙","保安","裕固","京","塔塔尔","独龙","鄂伦春","赫哲","门巴","珞巴","基诺","其他","外国血统中国籍人士");

  for(var i=0;i<nationCode.length;i++){
  		if(nationName[i]==GT_IDCard.Nation)
  			pNation=nationCode[i];
  	}
 /* if(GT_IDCard.Nation<10) {
	 pNation="0"+GT_IDCard.Nation;
  }else{
	 pNation=GT_IDCard.Nation;
  }*/
}
 function formatIdCardDate(_date){
	if(_date){
		if(_date.indexOf("-")==-1&&_date.length==8){
			return _date.substr(0,4)+'-'+_date.substr(4,2)+'-'+_date.substr(6,2);
		}
	}
}
//解决ie7不能正常显示照片方法
function previewPhoto(p,psrc)
{
	var imgObj=document.getElementsByName("RELATIONER_PHOTOC_IMG")[p];
	var imgDiv=document.getElementById("RELATIONER_PHOTOC_IMG_DIV"+p);
	if(imgDiv!=null){
		imgDiv.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod = scale)";    
		imgDiv.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = psrc; 
	}else{
		imgDiv=document.createElement("DIV");
		imgDiv.id="RELATIONER_PHOTOC_IMG_DIV"+p;
		imgDiv.name="RELATIONER_PHOTOC_IMG_DIV";
		imgDiv.style.width = imgObj.width;
		imgDiv.style.height = imgObj.height;
		imgDiv.ondblclick=imgObj.ondblclick;
		imgObj.parentElement.insertBefore(imgDiv, imgObj);
		imgDiv.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod = scale)";    
		imgDiv.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = psrc;
		imgObj.style.display="none";
	}
}
//扫描界面和赋值
function scan(method){
	if(method){
		eval(method);
	}else{
		if(document.forms[0].stype){
			stype =document.forms[0].stype.value;
		}
		BaseinfoPeopleDataSet.setParameter("ID_CARD@=",pCardNo);
		BaseinfoPeopleDataSet.load();
		BaseinfoPeopleDataSet.on('load',funcCheck);
	}
	
}

function funcCheck(){
	if(BaseinfoPeopleDataSet.getCount()!=0){
	    if(stype=='01'){
	       if(BaseinfoPeopleDataSet.get("disabilityFlag")=='1' && BaseinfoPeopleDataSet.get("disabilityStateCode") != 6){
	           L5.Msg.alert("提示", "该人员已经是伤残人员!");
	           document.forms[0].reset();
	           return false;
	       }
       	}
       	if(stype=='10'){
	         if(BaseinfoPeopleDataSet.get("dependantFlag")=='1'&& BaseinfoPeopleDataSet.get("dependantStateCode") != 6){
	           L5.Msg.alert("提示", "该人员已经是三属人员!");
	           document.forms[0].reset();
	           return false;
	       }
       	}
       	if(stype=='13'||stype=='12'){
	       if(BaseinfoPeopleDataSet.get("demobilizedFlag")=='1'&& BaseinfoPeopleDataSet.get("demobilizedStateCode") != 6){
	           L5.Msg.alert("提示", "该人员已经是在乡复员军人!");
	           document.forms[0].reset();
	           return false;
	       }
       	}
       
       	if(stype=='14'){
	      if(BaseinfoPeopleDataSet.get("warFlag")=='1' && BaseinfoPeopleDataSet.get("warStateCode") != 6){
	           L5.Msg.alert("提示", "该人员已经是参战参试人员!");
	           document.forms[0].reset();
	           return false;
	       }
       	}
       	if(stype=='B1'){
	      if(BaseinfoPeopleDataSet.get("martyrOffspringFlag")=='1' && BaseinfoPeopleDataSet.get("martyrOffspringStateCode") != '6'){
	           L5.Msg.alert("提示", "该人员已经是部分烈士（错杀被平反人员）子女!");
	           document.forms[0].reset();
	           return false;
	       }
       	}
       	if(stype=='81'){
  	      if(BaseinfoPeopleDataSet.get("martyrOffspringFlag")=='1' && BaseinfoPeopleDataSet.get("martyrOffspringStateCode") != '6'){
  	           L5.Msg.alert("提示", "该人员已经是60周岁人员!");
  	           document.forms[0].reset();
  	           return false;
  	       }
         }
       	//alert("00000");
       	//document.forms[0].flag.value="";	
       // commShowPhoto(BaseinfoPeopleDataSet.get("photoTemp"));
       intomessage();
    }else{
    	
		//var ds = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
		BaseinfoPeopleDataSet.newRecord();
		
		
		if(document.forms[0].flag){
			document.forms[0].flag.value="1";	
		}
		intomessage();
    }
}
function intomessage(){
	var icard=BaseinfoPeopleDataSet.getCurrent().get("idCard");
	if(icard!=""&&icard!=pCardNo){
		if(!confirm("人员身份证号与扫描的身份证不符!是否继续?")){
			return ;
		} 
	}
	if (abcardflag=='a'){
		pSex=pSex=="男"?'1':'2';
	}
	BaseinfoPeopleDataSet.getCurrent().set("idCard",pCardNo);//证件号码
	BaseinfoPeopleDataSet.getCurrent().set("name",pName);//姓名
	BaseinfoPeopleDataSet.getCurrent().set("sex",pSex);//性别
	BaseinfoPeopleDataSet.getCurrent().set("birthday",pBorn);//生日
	BaseinfoPeopleDataSet.getCurrent().set("nation",pNation);//民族
	BaseinfoPeopleDataSet.getCurrent().set("domicileAddress",pAddress);//住址
	BaseinfoPeopleDataSet.getCurrent().set("address",pAddress);//住址
	if(document.getElementsByName("RELATIONER_PHOTOC_IMG")[0]){
		if(abcardflag=='b'){
			previewPhoto(0,"C:\\1\\zhaopian\\"+pCardNo+".jpg");
		}else if (abcardflag=='a'){
			previewPhoto(0,"C:\\1\\"+pName+"_"+pCardNo+".bmp");
		}
			//
			//document.getElementsByName("RELATIONER_PHOTOC_IMG")[0].src='data:image/jpeg;base64,' + pPhotoBuffer;
			document.getElementById("photoTemp").value=pPhotoBuffer;//base64
			if(document.getElementById("cardPhotoTemp")){
				document.getElementById("cardPhotoTemp").value=pPrintPhotoBuffer;//base64
				BaseinfoPeopleDataSet.getCurrent().set("cardPhotoTemp",pPrintPhotoBuffer);//住址
			}
	}
	
	if(document.getElementsByName("RELATIONER_PHOTOC_IMG")[1]){
		if(abcardflag=='b'){
			previewPhoto(1,"C:\\1\\fuyinjian\\"+pCardNo+".jpg");
		}
		
			if(document.getElementById("cardPhotoTemp")){
				document.getElementById("cardPhotoTemp").value=pPrintPhotoBuffer;//base64
				BaseinfoPeopleDataSet.getCurrent().set("cardPhotoTemp",pPrintPhotoBuffer);//住址
			}
	}
	BaseinfoPeopleDataSet.getCurrent().set("haveNewCard","1");
	if(!document.forms[0].flag){
		var isgo = document.getElementById("idCard").fireEvent("onchange");//调用idcar上的onchange事件
		
	}
	
	//previewPhoto();
}
function opneidcard(){
	var param = window.dialogArguments; 
	var url = L5.webPath+'/jsp/cams/bpt/comm/idCardDetail.jsp?peopleId='+peopleId;
	param.window.open(url,'身份证件','height=500,width=400,top=50,left=384,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no, status=no');
	//window.showModalDialog(url,window,"help:no;scroll:no;resizable:no;status:0;dialogWidth:420px;dialogHeight:500px;center:yes" );  

}
function createfilepath(){
	var strFolder = "c:\\1";
	var objFSO = new ActiveXObject("Scripting.FileSystemObject");
	// 检查文件夹是否存在
	if (!objFSO.FolderExists(strFolder)){
	   // 创建文件夹
	   var strFolderName = objFSO.CreateFolder(strFolder);
	   
	}
	// 检查文件夹是否存在
	/*if (objFSO.FolderExists(strFolder)){
	   document.write("文件夹: " + strFolder + "存在<br>");
	   // 删除文件夹
	   objFSO.DeleteFolder(strFolder, false);
	}else
	   document.write("文件夹不存在<br>");*/
}
