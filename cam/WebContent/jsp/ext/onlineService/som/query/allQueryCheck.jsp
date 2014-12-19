<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta http-equiv="x-ua-compatible" content="ie=7" />
<link href="css/style.css" rel="stylesheet" type="text/css" />

<title>年检结果查询</title>
<next:ScriptManager></next:ScriptManager>
</head>
<script language="javascript">
	function init(){
		somCheckDataSet.setParameter("FILL_PEOPLE_AREA@=","370000000000");
		somCheckDataSet.setParameter("STATUS@=","8");
		somCheckDataSet.load();
		somCheckDataSet.on("load",function(ds){
			document.getElementById("currentPageNum").innerHTML=ds.getPageIndex()+"/"+ds.getTotalPage()+"页";
		});
	}
	function turnNext(){
		somCheckDataSet.turnNext();
	}
	function turnPre(){
		somCheckDataSet.turnPrev();
	}
	function turnLast(){
		somCheckDataSet.turnLast();
	}
	function turnFirst(){
		somCheckDataSet.turnFirst();
	}
	function turnPage(){
		somCheckDataSet.turnPage(document.getElementById("to_page").value);
	}
	function onSubmit(){
		somCheckDataSet.setParameter("FILL_PEOPLE_AREA@=","370000000000");
		somCheckDataSet.setParameter("STATUS@=","8");
		somCheckDataSet.setParameter("CN_NAME@LIKE","%"+document.getElementsByName("cnName")[0].value+"%");
		somCheckDataSet.setParameter("SORG_CODE@=",document.getElementsByName("sorgCode")[0].value);
		somCheckDataSet.setParameter("SORG_TYPE@=",document.getElementsByName("sorgType")[0].value);
		somCheckDataSet.setParameter("CHECK_RESULT@=",document.getElementsByName("checkResult")[0].value);
		somCheckDataSet.setParameter("BATCH_YEAR@=",document.getElementsByName("batchYear")[0].value);
		somCheckDataSet.load();
		somCheckDataSet.on("load",function(ds){
			document.getElementById("currentPageNum").innerHTML=ds.getPageIndex()+"/"+ds.getTotalPage()+"页";
		});
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
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand"  global="true" pageSize="20" sortField="CHECK_TIME" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck"></model:record>
	</model:dataset>
	<model:dataset id="checkResultSelect" enumName="SOM.CHECK_RESULT" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<div id="html_1"><iframe align="center" width="998" height="195" src="http://www.sdmz.gov.cn/mgj/channels/ch00266/" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no"></iframe></div>
<div style=" width:998px;margin:0 auto;">
	<div class="f-div" style="margin:0 auto;">
		<div class="bscx-div-1">
		<div class="bscx-div-2">
		<img src="images/bscw-1.jpg" width="220" height="30" />
		                    <form name="myform" action="doListResult.do?action=resultList" method="post"  >
		<table width="730" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="mar-top">
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
		    <td height="35" align="right" bgcolor="#FFFFFF">社会组织类型：</td>
		    <td width="214" bgcolor="#FFFFFF">&nbsp;
			<select name="sorgType">
				<option value="" selected>全部</option>
				<option value="S">社会团体</option>
				<option value="M">民办非企业单位</option>
				<option value="J">基金会</option>
			</select>
			</td>
			<td height="35" align="right" bgcolor="#FFFFFF">登记证号：</td>
		    <td bgcolor="#FFFFFF">&nbsp;<input type="text" name="sorgCode" value="" class="bscx-input"/></td>
		  </tr>
		  <tr>
		    <td width="105" align="right" bgcolor="#FFFFFF">年检结果：</td>
		    <td width="191" bgcolor="#FFFFFF">&nbsp;
		    	<select name="checkResult">
					<option value="" selected>全部</option>
					<option value="1">合格</option>
					<option value="2">基本合格</option>
					<option value="0">不合格</option>
				</select>
			</td>
		    <td align="right" bgcolor="#FFFFFF">年份：</td>
		    <td bgcolor="#FFFFFF">&nbsp;
		    <input type="text" name="batchYear"  value="" />
			</td>
		  </tr>
		</table>
		</form>
		<div class="bscx-div-3"><a href="#"><img src="images/bscw-2.jpg" width="48" height="20" border="0" onClick="onSubmit()" /></a></div>
		
		<div  class="bscx-div-4">
		<div  class="bscx-div-5-1"><a href="allQuery.jsp" target="_parent">社会组织查询结果</a></div>
		<div  class="bscx-div-6"><a href="allQueryApply.jsp" target="_parent">行政许可</a></div>
		<div  class="bscx-div-6-1">年检结果</div>
		
		
		</div>
		
		<div class="bscx-div-10">
		
		<table width="730" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#abc3cd" class="mar-top">
		  <tr class="word-22">
		    <td width="60%"  height="35" align="center" valign="middle" bgcolor="#d5e4eb">名称</td>
		    <td width="12%"  align="center" valign="middle" bgcolor="#d5e4eb">登记证号</td>
		    <td width="11%"  align="center" valign="middle" bgcolor="#d5e4eb">年 份</td>
		    <td width="17%" align="center" valign="middle" bgcolor="#d5e4eb">年检结果</td>
		  </tr>
		</table>
		<table width="730" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#abc3cd"  dataset="somCheckDataSet">
		  <tr repeat="true">
		    <td width="60%"  height="35" align="center" valign="middle" bgcolor="#FFFFFF"><label field="cnName"/></td>
		    <td width="12%" align="center" valign="middle" bgcolor="#FFFFFF"><label field="sorgCode"/></td>
		    <td width="11%" align="center" valign="middle" bgcolor="#FFFFFF"><label field="batchYear"/></td>
		    <td width="17%"align="center" valign="middle" bgcolor="#FFFFFF">
		    <label field="checkResult" dataset="checkResultSelect"/>
		    </td>
		  </tr>
		</table>
		<div class="bscx-div-8">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr>
		    <td width="41%" height="40" align="left"></td>
		    <td width="59%" align="right">
		      	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="page">
					<tr>
						<form name="pageform" action="doListResult.do?action=resultList" method="post">
							<td align="left">
							<td align="right">
							&nbsp;<a href="#" onclick="turnFirst()">首页</a>&nbsp;|&nbsp;<a href="#" onclick="turnPre();">上页</a>&nbsp;|&nbsp;<a href="#" onclick="turnNext();">下页</a>&nbsp;|&nbsp;<a href="#" onclick="turnLast();">末页</a>&nbsp;&nbsp;第<label id="currentPageNum" />&nbsp;转到<input type="text" id="to_page" size="2">页<button onclick="turnPage();">-&gt;</button>
							</td>
							</td>
						</form>
					</tr>
				</table>
			</td>
		   </tr>
		</table>
		</div>
		</div>
		</div>
		</div>
</div>
</body>
</html>
