<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<style type="text/css">
a:link,a:visited{
 text-decoration:none;  /*超链接无下划线*/
 color:red;
}
</style>
</head>
<body>
<next:ViewPort>
		<next:Panel  name="form" anchor="100% 100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" >
			<next:Html>
				<form>
				<table align="center" style="margin-top:50px;line-height:55px" >
					<tr>
							<td width="150"><span id="fangzheng" style="font-size:18;font-family:方正小标宋简体; color:blue; ">方正小标宋简体</span></td>
							<td id="fangzhengA" style="display:none"><a  href="fzxbsjt.ttf" >未安装，点此下载字体</a></td>
							<td id="fangzhengS" style="display:none"><span  style="font-size:18; color:blue; ">已安装该字体</span></td>
					</tr>
					<tr>
							<td width="150"><span id="fs_gb2312" style="font-size:18;font-family:仿宋_GB2312; color:blue; ">仿宋_GB2312</span></td>
							<td id="fs_gb2312A" style="display:none"><a href="fs_GB2312.ttf" >未安装，点此下载字体</a></td>
							<td id="fs_gb2312S" style="display:none"><span  style="font-size:18; color:blue; ">已安装该字体</span></td>
					</tr>
					<tr>
							<td width="150"><span id="fs_gb2312" style="font-size:18;font-family:楷体_GB2312; color:blue; ">楷体_GB2312</span></td>
							<td id="kt_gb2312A" style="display:none"><a href="kt_GB2312.ttf" >未安装，点此下载字体</a></td>
							<td id="kt_gb2312S" style="display:none"><span  style="font-size:18; color:blue; ">已安装该字体</span></td>
					</tr>
				</table>
				<object id="fontobj" classid="clsid:3050f819-98b5-11cf-bb82-00aa00bdce0b"></object>
				</form>
			</next:Html>
	  </next:Panel>
</next:ViewPort>
<script type="text/javascript">
function fontGo(pageElement,font)
{
        try{
		 	var fb = getSystemFonts();
		 	var fd = false;
	        for (i=0;i<fb.length;i++){
	                if(fb[i]==font){
	                        fd = true;
	                        break;
	                }
	        }
	        if(fd === true){
	                document.getElementById(pageElement+"S").style.display="";
	        }else{
	                document.getElementById(pageElement+"A").style.display="";
	        }
		 }catch(err){
		 	
		 }
}
function getSystemFonts()
{
//刚进页面时候取不到控件，必须刷新才能取到，用trycatch处理一下
 try{
 	var fArray = new Array();
	 for (i = 1;i <= $("fontobj").fonts.count;i++){
	  fArray[i] = $("fontobj").fonts(i);
	 }
	 return fArray;
 }catch(err){
 	document.URL=location.href;
 	return;
 }
 
}
function init(){
	fontGo( "fangzheng","方正小标宋简体");
	fontGo( "fs_gb2312","仿宋_GB2312");
	fontGo( "kt_gb2312","楷体_GB2312");
	
}
</script>
</body>
</html>