<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta http-equiv="x-ua-compatible" content="ie=7" />
<link href="css/style.css" rel="stylesheet" type="text/css" />

<title>行政许可查询</title>
</head>
<script src="js/iframe_auto_size.js" ></script>
<script language="javascript">

	
	function onSubmit(){
		gongshiFrame.window.location.reload(true);
	}

	function showHidden(index)
	{
		for (var i=1;i<=6;i++)
		{
			document.getElementById ("mr"+i).className ="bsli-2"; //document.getElementById ("mn"+i).style.display="none";
		}
		document.getElementById ("mr"+index).className ="bsli-1"; //document.getElementById ("mn"+index).style.display="block";
	}
	function changeIframe(path){
		document.getElementById("gongshiFrame").src = path;
	}
</script>
<script> 
	function SetWinHeight(obj)
{
	
    var win=obj;
    if (document.getElementById)
    {
        if (win && !window.opera)
        {
            if (win.contentDocument && win.contentDocument.body.offsetHeight) 

                win.height = win.contentDocument.body.offsetHeight; 
            else if(win.Document && win.Document.body.scrollHeight)
                win.height = win.Document.body.scrollHeight;
        }
    }
}
</script>
<body>


<div id="html_1"><iframe align="center" width="998" height="195" src="http://www.sdmz.gov.cn/mgj/channels/ch00266/" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no"></iframe></div>
<div style=" width:998px;margin:0 auto;">
	
	<div class="f-div" style="margin:0 auto;">
		<div class="bscx-div-1">
		<div class="bscx-div-2">
		<img src="images/bscw-1.jpg" width="220" height="30" />
		
		<form name="myform" method="post" >
		<table width="630" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="mar-top">
		  <tr>
		  	<td colspan="4"  bgcolor="#FFFFFF" align="center">
		  		<span style="">查询系统测试运行阶段，信息仅供参考，相关信息以社会组织登记档案记载为准。</span>
		  	</td>
		  </tr>
		  <tr>
		    <td width="115" height="35" align="right" bgcolor="#FFFFFF">社会组织名称：</td>
		    <td colspan="3" bgcolor="#FFFFFF">&nbsp;<input type="text" name="cnName"  value="" class="bscx-input"/></td>
		    </tr>
		 
		  <tr>
		    <td height="35" align="right" bgcolor="#FFFFFF">登记证号：</td>
		    <td width="214" bgcolor="#FFFFFF">&nbsp;<input type="text" name="sorgCode" value="" class="bscx-input"/></td>
		    <td width="105" align="right" bgcolor="#FFFFFF">&nbsp;</td>
		    <td width="191" bgcolor="#FFFFFF">&nbsp;</td>
		  </tr>
		</table>
		</form>
		<div class="bscx-div-3"><a href="#"><img src="images/bscw-2.jpg" width="48" height="20" border="0" onClick="onSubmit()" /></a></div>
		
		<div  class="bscx-div-4">
		<div  class="bscx-div-5-1"><a href='allQuery.jsp' target="_parent">社会组织查询结果</a></div>
		<div  class="bscx-div-6-1 word-29">行政许可</div>
		<div  class="bscx-div-6"><a href='allQueryCheck.jsp' target="_parent">年检结果</a></div>
		
		</div>
		
		<div class="bscx-div-7">
		<ul>
		<li class="bsli-1" id="mr1" onClick="showHidden(1);changeIframe('apply/buildQuery.jsp')">成立公示</li>
		<li class="bsli-2" id="mr2" onClick="showHidden(2);changeIframe('apply/changeQuery.jsp')">变更公示</li>
		<li class="bsli-2" id="mr3" onClick="showHidden(3);changeIframe('apply/cancelQuery.jsp')">注销公示</li>
		<li class="bsli-2" id="mr4" onClick="showHidden(4);changeIframe('apply/branchBuildQuery.jsp')">分支成立公示</li>
		<li class="bsli-2" id="mr5" onClick="showHidden(5);changeIframe('apply/branchChangeQuery.jsp')">分支变更公告</li>
		<li class="bsli-2" id="mr6" onClick="showHidden(6);changeIframe('apply/branchCancelQuery.jsp')">分支注销公告</li>
		</ul>
		
		<iframe id="gongshiFrame" frameborder="0" onload="IFrameReSizeWidth('gongshiFrame');" src="apply/buildQuery.jsp" width="100%" height="1000px"  scrolling="no"></iframe>
		
		              
		</div>
		
		</div>
</div>
</body>
</html>
