function init() {
	//Fun_DisConnect();//断开连接
	Fun_Connect();// 打开连接
	//Ts_disConnect();
	TsConnect();
	BaseinfoPeopleDataSet.baseParams["PEOPLE_ID@="] = peopleId;
	BaseinfoPeopleDataSet.load();
	L5.QuickTips.init();
	var pirntcertTabPanel = L5.getCmp("pirntcertTabPanel");
	pirntcertTabPanel.on("activate",function () {
		if(changeContent!=""){//判定是否证件变更调用的页面 
			change();
		}else{//打印证书
			openPrint(peopleId);
		}
		
	});		
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
		if(result[0] == "0"){
			//document.getElementById("TaShow").value += "初始化信息失败\n";
		}else{
			
			document.getElementById("TbTid").value = result[1];
			//document.getElementById("TaShow").value += "初始化信息成功\n";
			//Fun_WriteEpcWithCipher();
		}
	}catch(e){
		alert("异常"+e.Message);
	}
}

function Fun_WriteEpcWithCipher(){
	try{
		Fun_ReadTid();
		var idcardStr = document.getElementById("idCard").value;
		var nameStr = document.getElementById("name").value;
		var iResult = demo.FunWriteEpcWithCipher(idcardStr, nameStr);
		var result = iResult.split("|");
		if(result[0] == "0"){
			document.getElementById("TaShow").value += "写EPC失败\n";
		}else{
			document.getElementById("TaShow").value += "写EPC成功\n";
			Fun_Verify();
			//if(renewalFlag!="no"){//判定是否换证列表调用的页面 renewalFlag=="no"时 不为换证页面不调用生成证书编号方法
				chengeCert();//
			//}
			
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
			
			document.getElementById("TaShow").value += "验证失败\n";
		}else{
			document.getElementById("TaShow").value += "身份证号:"+result[2]+"\n";
			document.getElementById("TaShow").value += "姓名:"+result[3]+"\n";
		}
			
	}catch(e){
		alert("异常"+e.Message);
	}
	
}
function openPrint(peopleId) {
	var docpath = "jsp/cams/bpt/peopleBasicInfo/table/disabilityJR_apptable.doc";
	document.getElementById("docpath").value=docpath;
	var ements = document.getElementsByName("printQuery");
	for(var i=0;i<ements.length;i++) {
		var obj = ements[i];
		if(obj.getAttribute("queryData") == "queryData") {
			var idValue = obj.getAttribute("id");
			if(idValue == "peopleId") {
				obj.value = peopleId;
			} else if(idValue == "objectType") {
				obj.value = '11';
			}
		}
	}
	document.getElementById("bptQueryPathServiceType").value='11';
	
	var url="../../comm/print/jspcommonprint.jsp?";
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	//window.close();
}
function replaceAll(s0,s1,s2) { 
    return s0.replace(new RegExp(s1,"gm"),s2); 
}
//证件变更时的打印页面
function change() {
	
	var path = "jsp/cams/bpt/flow/disability/exchacertidisa/print/disleft.doc";
	var date=new Date();
	var year=""+date.getFullYear();
	var month=date.getMonth()+1;
	if(month<10){
		month="0"+month;
	}
	//changeContent = decodeURI(changeContent);
	changeContent=replaceAll(changeContent,"<br/>","\r\n");
	changeContent=replaceAll(changeContent,"<br>","\r\n");
	changeContent=replaceAll(changeContent,"&nbsp;"," ");
	
	document.getElementById("docPath").value = path;
	document.getElementById("printYear").value = year;
	document.getElementById("printMonth").value = month;
	document.getElementById("changeContent").value = changeContent ;

	document.getElementById("bptQueryPathServiceType").value = "68";
	
	var url="../../../cams/comm/print/print_noDataSet.jsp";
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}
function chengeCert() {
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptPeopleDisabilityCommand");
	command.setParameter("chipId", document.getElementById("TbTid").value);
	command.setParameter("peopleId", peopleId);
	command.setParameter("domicileCode", BaseinfoPeopleDataSet.get("domicileCode"));
	command.execute("renewalCert");
	var no = command.getReturn("no");
	if (!command.error) {
		if(no!=""){
			document.getElementById("TaShow").value += "生成新证书编号成功:"+no+"\n";
		}
		
		//L5.Msg.alert('提示','生成成功！');
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
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
		
		
	}
   
}

/*function SelectCard()
{
	var ret="";
	var ret1="";

	
	try{
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
	}catche(e){
		
	}
	
}*/

function ReadCard()
{
	var ret="";
	var ret1="";

	/*document.getElementById("tlTbTid").value="";
	document.getElementById("tlname").value="";
	document.getElementById("tlidCard").value="";*/
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
			
			/*document.getElementById("tlTbTid").value=substr1(ret,1,16);
			document.getElementById("tlidCard").value=substr1(ret,17,18);
			document.getElementById("tlname").value=substr1(ret,35,22);*/

			//document.getElementById("tlTaShow").value +="读卡成功\n";
		}
	}catch(e){
		
	}
	

	
}

function WriteCard()
{
 
	var ret="";
	var ret1="";
	try{
		var abName=document.getElementById("tlname").value;
		var abSfzh=document.getElementById("tlidCard").value;

		ret=KsTag.KH_WriteData(com,baud,abName,abSfzh);

		ret1=substr1(ret,0,1);
		document.getElementById("tlTbTid").value=ret;
		if (ret1!="1")
		{
			if (ret1=='0') {
				document.getElementById("tlTaShow").value +="联机失败！\n";
			} else if (ret1=='2') {
				document.getElementById("tlTaShow").value +="寻卡失败！\n";
			} else if (ret1=='3') {
				document.getElementById("tlTaShow").value +="该卡不属于伤残军人证！\n";
			} else if (ret1=='8') {
				document.getElementById("tlTaShow").value +="写入的身份证号及姓名效验失败！\n";
	        } else if (ret1=='9') {
	        	document.getElementById("tlTaShow").value +="非法卡，写卡失败！\n";
	        }
			 else {
				 document.getElementById("tlTaShow").value +="写卡失败("+ret1+")！(可能由于卡没有放好或者卡已经被损坏)\n";
			}
			return;
		}else{
			document.getElementById("tlTbTid").value=substr1(ret,1,16);
			document.getElementById("tlTaShow").value +="写卡成功。\n";
			ReadCard();
		}
	}catch(e){
		
	}
	
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
