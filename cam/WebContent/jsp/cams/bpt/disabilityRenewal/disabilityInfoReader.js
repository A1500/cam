function init() {
	Fun_Connect();// 打开连接
	
	TsConnect();
}
function Fun_Connect()
{
	try{
		Fun_DisConnect();
		var iResult = demo.ReaderConnect();
		if(iResult == 1)
			document.getElementById("TaShow").value += "连接成功,请放入证书\n";
		else
			document.getElementById("TaShow").value += "连接失败\n";
		
	}catch(e){
		alert("异常"+e.Message);
	}
}

function Fun_DisConnect()
{
	try{
		var iResult = demo.ReaderDisConnect();
		if(iResult == 1){
			//document.getElementById("TaShow").value += "断开成功\n";
		}else{
			document.getElementById("TaShow").value += "断开失败\n";
		}
	}catch(e){
		alert("异常"+e.Message);
	}
}
		 
function Fun_ReadTid()
{
	try{
		var iResult = demo.ReadDataFromSingleTag('00000000', 2, 0, 6);
		var result = iResult.split("|");
		if(result[0] == "0")
			document.getElementById("TaShow").value += "初始化信息失败\n";
		else{
			
			document.getElementById("TbTid").value = result[1];
			document.getElementById("TaShow").value += "初始化信息成功\n";
			Fun_WriteEpcWithCipher();
		}
	}catch(e){
		alert("异常"+e.Message);
	}
}

function Fun_Verify()
{
	try{
		var iResult = demo.FunVerify();
		var result = iResult.split("|");
		if(result[0] == "0"){
			
			document.getElementById("TaShow").value += "读取失败\n";
		}else{
			document.getElementById("idCard").value = result[2];
			document.getElementById("name").value = result[3];
			document.getElementById("TaShow").value += "读取成功\n";
		}
			
	}catch(e){
		alert("异常"+e.Message);
	}
	
}
//***********************************************************************************************

var com=100;
var baud=115200;



function TsConnect()
{
/*
	form1.selectCard1.disabled = true;
	form1.readData1.disabled = true;
	form1.writeData1.disabled = true;*/
	try{
		Ts_disConnect();
		var ret="";
		ret=KsTag.KH_TsConnect(com,baud);
		if (ret!="1"){
			document.getElementById("tlTaShow").value += "连接失败\n";
			return;
		} else {
			document.getElementById("tlTaShow").value += "连接成功,请放入证书\n";
			
	    }
	}catch(e){
		
	}
	
	/*form1.selectCard1.disabled = false;
	form1.readData1.disabled = false;
	form1.writeData1.disabled = false;*/
}

function Ts_disConnect()
{
	try{
		 var ret;
		   ret=KsTag.KH_disConnect();
		   if (ret=0){
			   document.getElementById("tlTaShow").value +="已断开设备连接！\n";
		   }else{
			   //document.getElementById("tlTaShow").value +="设备未连接！\n";
		   }
		
	}catch(e){
		//document.getElementById("tlTaShow").value +="请刷新页面,加载控件!\n";
		return;
	}
  
}

function SelectCard()
{
	var ret="";
	var ret1="";

	document.getElementById("tlTbTid").value="";

	ret=KsTag.KH_SelectCard(com,baud);

	ret1=substr1(ret,0,1);
	if (ret1!="1")
	{
		if (ret1=='0') {
			document.getElementById("tlTaShow").value +="联机失败！\n";
		} else {
			document.getElementById("tlTaShow").value +="寻卡失败("+ret1+")！(卡没放好 或者 卡已损坏)\n";
		}
		return;
	}

	document.getElementById("tlTbTid").value=substr1(ret,1,16);
	
	document.getElementById("tlTaShow").value +="寻卡成功\n";
	WriteCard();
}

function ReadCard()
{
	var ret="";
	var ret1="";
	try{
		ret=KsTag.KH_ReadData(com,baud);

		ret1=substr1(ret,0,1);
		if (ret1!="1")
		{
			if (ret1=='0') {
				document.getElementById("tlTaShow").value +="联机失败！\n";
			} else if (ret1=='2') {
				document.getElementById("tlTaShow").value +="寻卡失败！\n";
			} else if (ret1=='3') {
				document.getElementById("tlTaShow").value +="该卡不属于伤残军人证！\n";
			} else if (ret1=='9') {
				document.getElementById("tlTaShow").value +="非法卡，读卡失败！\n";
			}  else { 
				document.getElementById("tlTaShow").value +="读卡失败("+ret1+")！(可能由于卡没有放好或者卡已经被损坏)\n";
			}
			return;
		}else{
			document.getElementById("tlTaShow").value += "身份证号:"+substr1(ret,17,18)+"\n";
			document.getElementById("tlTaShow").value += "姓名:"+substr1(ret,35,22)+"\n";
			document.getElementById("tlidCard").value=substr1(ret,17,18);
			document.getElementById("tlname").value=substr1(ret,35,22);
			/*document.getElementById("tlTbTid").value=substr1(ret,1,16);
			document.getElementById("tlidCard").value=substr1(ret,17,18);
			document.getElementById("tlname").value=substr1(ret,35,22);*/

			//document.getElementById("tlTaShow").value +="读卡成功\n";
		}
	}catch(e){
		
	}
	/*document.getElementById("tlTbTid").value="";
	document.getElementById("tlname").value="";
	document.getElementById("tlidCard").value="";*/

	

	
}


//(串,长度,增加...) 
function substr1(str, len, hasDot) 
{ 
    var newLength = 0; 
    var newStr = ""; 
    var chineseRegex = /[^\x00-\xff]/g; 
    var singleChar = ""; 
    var strLength = str.replace(chineseRegex,"**").length; 
    for(var i = len;i <( hasDot+len);i++) 
    { 
        singleChar = str.charAt(i).toString(); 
        if(singleChar.match(chineseRegex) != null) 
        { 
            newLength += 2; 
        }     
        else 
        { 
            newLength++; 
        } 
	    if(newLength > hasDot) 
		{ 
			break; 
		} 
		newStr += singleChar; 
    } 

	chineseRegex = /(^\s*)|(\s*$)/g; 
	newStr = newStr.replace(chineseRegex,"");

    return newStr; 
} 

