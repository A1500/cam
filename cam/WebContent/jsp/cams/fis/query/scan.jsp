<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<HTML>
<title>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>
<style type="text/css">
<!--
.STYLE1 {
	font-family: "方正宋体-人口信息";
}
-->
</style>
<center>
<body bgcolor="DFE8F7">
<table align="center" height="100%"><tr><td align="center"><font color="red" size="3" style="">请刷卡……</font></td></tr></table>
<P><OBJECT classid="clsid:F1317711-6BDE-4658-ABAA-39E31D3704D3"
	codebase="SDRdCard.cab#version=1,3,3,0" width=330 height=360
	align=center hspace=0 vspace=0 id=idcard name=rdcard style="display:none"> </OBJECT>
<form name=tcard style="display:none">
<TD width="12%" rowSpan=4><IMG height=126 alt="" width=102 border=0
	name=photo></TD>
<p>卡信息<input type="text" name="tCardInfo" size="100" class="STYLE1"></p>
<p>设备安全模块号<input type="text" name="tsNum" size="62"></p>
<p>读卡是否成功<input type="text" name="tOK" size="62"></p>
<p>提示信息<input type="text" name="tResult" size="62"></p>
<p>姓名name<input type="text" name="tName" size="68" class="STYLE1" ></p>
<p>姓名nameL<input type="text" name="tNameL" size="68" class="STYLE1"></p>
<p>性别sex<input type="text" name="tSex" size="68"></p>
<p>性别sexL<input type="text" name="tSexL" size="68"></p>
<p>民族nation<input type="text" name="tFolk" size="68"></p>
<p>民族nationL<input type="text" name="tFolkL" size="68"
	class="STYLE1"></p>
<p>出生Born<input type="text" name="tBirth" size="68"></p>
<p>出生BornL<input type="text" name="tBirthL" size="68"></p>
<p>公民身份号码<input type="text" name="tcardID" size="56"></p>
<p>住址<input type="text" name="tAddr" size="68" class="STYLE1"></p>
<p>最新住址<input type="text" name="tnewAddr" size="68" class="STYLE1"></p>
<p>签发机关<input type="text" name="tIssue" size="62" class="STYLE1"></p>
<p>有效期限Activity<input type="text" name="tBeginEnd" size="62"></p>
<p>有效期限ActivityL<input type="text" name="tBeginEndL" size="62"></p>
<p>头像JPGbufferBase64<input type="text" name="jbuff" size="62"></p>
<p>头像BMPbufferBase64<input type="text" name="bbuff" size="62"></p>
<p>头像WLTbufferBase64<input type="text" name="wbuff" size="62"></p>
<p>头像JPGroot<input type="text" name="jroot" size="62"></p>
<p>头像BMProot<input type="text" name="broot" size="62"></p>
<p>头像WLTroot<input type="text" name="wroot" size="62"></p>
</form>
</body>
<script language="vbscript">

sub hideocx_onclick()
	rdcard.visible=false
end sub



sub handread_onclick()

dim i
    
    i = rdcard.ReadCard()

    if  i=0  then
        tcard.tCardInfo.value=cstr(rdcard.szCardInfo)
        tcard.tOK.value="0"
	tcard.tName.value=cstr(rdcard.NameS)
	tcard.tNameL.value=cstr(rdcard.NameL)
	tcard.tSex.value=cstr(rdcard.Sex)
	tcard.tSexL.value=cstr(rdcard.SexL)
	tcard.tFolk.value=cstr(rdcard.Nation)
	tcard.tFolkL.value=cstr(rdcard.NationL)
	tcard.tBirth.value=cstr(rdcard.Born)
	tcard.tBirthL.value=cstr(rdcard.BornL)
	tCard.tcardID.value=cstr(rdcard.CardNo)
    	tcard.tAddr.value=cstr(rdcard.Address)
        tcard.tnewAddr.value=cstr(rdcard.newAddress)
	tCard.tIssue.value =cstr(rdcard.Police)		
    	tcard.tBeginEnd.value=cstr(rdcard.Activity)     
    	tcard.tBeginEndL.value=cstr(rdcard.ActivityL)  
    	tcard.jroot.value=cstr(rdcard.PhotoPath) 
    	tcard.broot.value=cstr(rdcard.PathOfBMP)
    	tcard.wroot.value=cstr(rdcard.WLTRoot)
    	tcard.jbuff.value=cstr(rdcard.JPGBuffer)
    	tcard.bbuff.value=cstr(rdcard.BMPBuffer)
    	tcard.wbuff.value=cstr(rdcard.WLTBuffer)     
        tcard.photo.src = "file:///C|/null.JPEG"       
    	if rdcard.PhotoPath = "" then  
        	tcard.photo.src = "file:///C|/null.JPEG"  
    	else 	
        	tcard.photo.src = "file:///"+cstr(rdcard.PhotoPath)
    	end if

        tCard.tResult.value=cstr(rdcard.sResultMsg)
  else 
        tcard.tCardInfo.value=""
	tcard.tName.value=""
	tcard.tNameL.value=""
	tcard.tSex.value=""
	tcard.tSexL.value=""
	tcard.tFolk.value=""
	tcard.tFolkL.value=""
	tcard.tBirth.value=""
	tcard.tBirthL.value=""
	tCard.tcardID.value=""
    	tcard.tAddr.value=""
        tcard.tnewAddr.value=""
	tCard.tIssue.value =""
    	tcard.tBeginEnd.value="" 
    	tcard.tBeginEndL.value=""
    	tcard.jroot.value=""
    	tcard.broot.value=""
    	tcard.wroot.value=""
    	tcard.jbuff.value=""
    	tcard.bbuff.value=""
    	tcard.wbuff.value="" 
        tcard.photo.src = "file:///C|/null.JPEG"  
	tCard.tResult.value=cstr(rdcard.sResultMsg)
        tcard.tCardInfo.value=""
        tcard.tOK.value=cstr(i) 
  end if

end sub

sub savepath_onclick()

	rdcard.strSavePath= "c:\\aa"

end Sub

sub showocx_onclick()
	rdcard.visible=true
end sub

sub startAuto_onclick()
    rdcard.AutoReadCard=1
end sub

sub startHand_onclick()
    rdcard.AutoReadCard=0
end sub

sub ReadsNum_onclick()
    if rdcard.ReadSecurityNum()=0 then
	tcard.tsNum.value=cstr(rdcard.SecurityNum)	
    end if 
    tCard.tResult.value=cstr(rdcard.sResultMsg)
end sub

sub SaveCard_onclick()
    rdcard.SaveCardPic "C:\cardh.jpg","C:\cards.jpg",3 
end sub

sub beginread_onclick()

	call typeinfo_onclick()	

	if rdcard.readcard2()=0 then

		tcard.tCardInfo.value=cstr(rdcard.szCardInfo)
		tcard.tName.value=cstr(rdcard.NameS)
		tcard.tNameL.value=cstr(rdcard.NameL)
		tcard.tSex.value=cstr(rdcard.Sex)
		tcard.tSexL.value=cstr(rdcard.SexL)
		tcard.tFolk.value=cstr(rdcard.Nation)
		tcard.tFolkL.value=cstr(rdcard.NationL)
		tcard.tBirth.value=cstr(rdcard.Born)
		tcard.tBirthL.value=cstr(rdcard.BornL)
		tCard.tcardID.value=cstr(rdcard.CardNo)
    	tcard.tAddr.value=cstr(rdcard.Address)
        tcard.tnewAddr.value=cstr(rdcard.newAddress)
		tCard.tIssue.value =cstr(rdcard.Police)		
    	tcard.tBeginEnd.value=cstr(rdcard.Activity)     
    	tcard.tBeginEndL.value=cstr(rdcard.ActivityL)  

    	tcard.jroot.value=cstr(rdcard.PhotoPath) 
    	tcard.broot.value=cstr(rdcard.PathOfBMP)
    	tcard.wroot.value=cstr(rdcard.WLTRoot)
    	tcard.jbuff.value=cstr(rdcard.JPGBuffer)
    	tcard.bbuff.value=cstr(rdcard.BMPBuffer)
    	tcard.wbuff.value=cstr(rdcard.WLTBuffer)     
        tcard.photo.src = "file:///C|/null.JPEG"       
    	if rdcard.PhotoPath = "" then  
        	tcard.photo.src = "file:///C|/null.JPEG"  
    	else 	
        	tcard.photo.src = "file:///"+cstr(rdcard.PhotoPath)
    	end if

        tCard.tResult.value=cstr(rdcard.sResultMsg)
    end if 
	if rdcard.bHaveCard then
	   tcard.tOK.value="1"
        else
	   tcard.tOK.value="0"	
	end if	
end sub

sub endread_onclick()
	rdcard.endread

end sub


sub xianshi()	
        tcard.tCardInfo.value=cstr(rdcard.szCardInfo)
		tcard.tName.value=cstr(rdcard.NameS)
		tcard.tNameL.value=cstr(rdcard.NameL)
		tcard.tSex.value=cstr(rdcard.Sex)
		tcard.tSexL.value=cstr(rdcard.SexL)
		tcard.tFolk.value=cstr(rdcard.Nation)
		tcard.tFolkL.value=cstr(rdcard.NationL)
		tcard.tBirth.value=cstr(rdcard.Born)
		tcard.tBirthL.value=cstr(rdcard.BornL)
		tCard.tcardID.value=cstr(rdcard.CardNo)
    	tcard.tAddr.value=cstr(rdcard.Address)
        tcard.tnewAddr.value=cstr(rdcard.newAddress)
    	tCard.tIssue.value =cstr(rdcard.Police)		
    	tcard.tBeginEnd.value=cstr(rdcard.Activity)     
    	tcard.tBeginEndL.value=cstr(rdcard.ActivityL)   
    	tcard.jroot.value=cstr(rdcard.PhotoPath) 
    	tcard.broot.value=cstr(rdcard.PathOfBMP)
    	tcard.wroot.value=cstr(rdcard.WLTRoot)
    	tcard.jbuff.value=cstr(rdcard.JPGBuffer)
    	tcard.bbuff.value=cstr(rdcard.BMPBuffer)
    	tcard.wbuff.value=cstr(rdcard.WLTBuffer)  
        tcard.photo.src = "file:///C|/null.JPEG"        
    	if rdcard.PhotoPath = "" then  
        	tcard.photo.src = "file:///C|/null.JPEG"  
    	else 	
        	tcard.photo.src = "file:///"+cstr(rdcard.PhotoPath)
    	end if

    	tCard.tResult.value=cstr(rdcard.sResultMsg)
	if rdcard.bHaveCard then
	   tcard.tOK.value="1"
        else
	   tcard.tOK.value="0"	
	end if	
end sub

sub typeinfo_onclick()
	call xianshi()
	settimeout "typeinfo_onclick",300
end sub

sub getstatus_onclick()
    tCard.tResult.value=cstr(rdcard.sResultMsg)
end sub


sub clear()
  rdcard.ClearAll()
end sub
</script>
<next:ScriptManager></next:ScriptManager>
<script language="javascript">
function init() {
	try {
		typeinfo_onclick();
		beginread_onclick();
		setInterval("fh()",1000); 
	}catch(e) {
		alert("未安装二代读卡器驱动！");
		window.close();
		return;
	} 
}
function fh() {
	if(document.getElementById("tName").value!=null&&document.getElementById("tName").value!=""){
		var name = document.getElementById("tName").value;//姓名
		var sex = document.getElementById("tSex").value;//性别
		var idCard = document.getElementById("tcardID").value;//身份证号
		var birth = document.getElementById("tBirth").value;//生日
		var nation = document.getElementById("tFolk").value;//民族
		var addr = document.getElementById("tAddr").value;//住址
		var jroot = document.getElementById("jroot").value;//照片路径
		var jbuff = document.getElementById("jbuff").value;//照片base64
		var fanhui =encodeURI(name+";"+sex+";"+idCard+";"+birth+";"+nation+";"+addr+";"+jroot+";"+jbuff);
		window.returnValue=fanhui;
		clear();
		window_onUnload();
		window.close();
	}
}

function window_onUnload() {
	try {
		rdcard.DeleteOutputFile();
  		rdcard.DeleteAllPicture();
	}catch(e) {
	}
}
</script>

</HTML>

