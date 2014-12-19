 <%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta http-equiv="x-ua-compatible" content="ie=7" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />

<title>社会组织查询</title>
<next:ScriptManager></next:ScriptManager>
</head>
<script language="javascript">
	function init(){
		somCheckDataSet.setParameter("FILL_PEOPLE_AREA@=","370000000000");
		somCheckDataSet.setParameter("STATUS@=","8");
		somCheckDataSet.load(true);
		if(somCheckDataSet.getCount()>7){
			StartRollV();
		}
	}
	// 滚动脚本
var rollspeed=30
var myInter;
function MarqueeV(){
	var ooRollV=document.getElementById("oRollV0");
	var ooRollV1=document.getElementById("oRollV10");
	var ooRollV2=document.getElementById("oRollV20");
	if(ooRollV2.offsetTop-ooRollV.scrollTop<=0) {
		ooRollV.scrollTop-=ooRollV1.offsetHeight;
	}else{
		ooRollV.scrollTop++;
	}
}
function StartRollV() {
	var ooRollV=document.getElementById("oRollV0");
	var ooRollV1=document.getElementById("oRollV10");
	var ooRollV2=document.getElementById("oRollV20");
	if (ooRollV) {
		if (parseInt(ooRollV.style.height)>=ooRollV2.offsetTop) {

			ooRollV.style.height = ooRollV2.offsetTop;
			return;
		}
		ooRollV2.innerHTML=ooRollV1.innerHTML;
		myInter=setInterval(MarqueeV,rollspeed);
		ooRollV.onmouseover=function() {clearInterval(myInter)};
		ooRollV.onmouseout=function() {myInter=setInterval(MarqueeV,rollspeed)};
	}
}
</script>
<body>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand"  global="true" pageSize="1000" sortField="CHECK_TIME" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck"></model:record>
	</model:dataset>
	<model:dataset id="checkResultSelect" enumName="SOM.CHECK_RESULT" autoLoad="true" global="true"></model:dataset>
</model:datasets>

  <table width="100%" border="0" cellpadding="0" cellspacing="0" >
  <tr>
    <td align="right" valign="top">
    	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#cfcfcf" >
			<tr style="font-size:12px;">
			  <td width="55%" height="25" align="center" valign="middle" bgcolor="#ededed">社会组织名称</td>
			  <td width="25%" align="center" valign="middle" bgcolor="#ededed">年度</td>
			  <td width="20%" align="center" valign="middle" bgcolor="#ededed">年检结果</td>
			</tr>
		</table>
		 <DIV id=oRollV0 style="MARGIN: 0px; OVERFLOW: hidden; HEIGHT: 180px">
			 <DIV id=oRollV10>
				 <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#E6E7E8" class="text1"  dataset="somCheckDataSet">
					<tr style="font-size:12px;"  repeat="true">
						 <td height="25" width="55%" align="left" bgcolor="#FFFFFF"><label field="cnName"/></td>
						 <td width="25%" align="center" bgcolor="#FFFFFF"><label field="batchYear"/></td>
						 <td width="20%" align="center" bgcolor="#FFFFFF"><label field="checkResult" dataset="checkResultSelect"/></td>
					</tr>
				 </table>
		     </DIV>
			 <DIV id=oRollV20></DIV>
		 </DIV>
    </td>
  </tr>
</table>

</marquee>
</body>
</html>