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
		somApplyDataSet.setParameter("IF_FINISH","1");
		somApplyDataSet.setParameter("AUDIT_OPINION_ID","1");
		somApplyDataSet.setParameter("ACCEPT_AREA","370000000000");
		somApplyDataSet.load();
		somApplyDataSet.on("load",function(){
			if(somApplyDataSet.getCount()>7){
				StartRollV();
			}
		});
		
	}
	// 滚动脚本
var rollspeed=30
var myInter;
function MarqueeV(){
	var ooRollV=document.getElementById("oRollV");
	var ooRollV1=document.getElementById("oRollV1");
	var ooRollV2=document.getElementById("oRollV2");
	if(ooRollV2.offsetTop-ooRollV.scrollTop<=0) {
		ooRollV.scrollTop-=ooRollV1.offsetHeight;
	}else{
		ooRollV.scrollTop++;
	}
}
function StartRollV() {
	var ooRollV=document.getElementById("oRollV");
	var ooRollV1=document.getElementById("oRollV1");
	var ooRollV2=document.getElementById("oRollV2");
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
</SCRIPT>
<body>
<model:datasets>
	<%--流程处理--%>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineQueryCommand" global="true" pageSize="50" sortField="AUDIT_TIME" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
		</model:record>
	</model:dataset>
	<model:dataset id="applyTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_APPLY_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>	


 <table width="100%" border="0" cellpadding="0" cellspacing="0" >
  <tr> 
    <td align="right" valign="top">
    	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#cfcfcf" >
			<tr style="font-size:12px;">
			  <td width="55%" height="25" align="center" valign="middle" bgcolor="#ededed">社会组织名称</td>
			  <td width="25%" align="center" valign="middle" bgcolor="#ededed">许可事项</td>
			  <td width="20%" align="center" valign="middle" bgcolor="#ededed">结果</td>
			</tr>
		</table>
		 <DIV id=oRollV style="MARGIN: 0px; OVERFLOW: hidden; HEIGHT: 180px">
			 <DIV id=oRollV1>
				 <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#E6E7E8" class="text1"  dataset="somApplyDataSet">
					<tr style="font-size:12px;"  repeat="true"> 
					  <td height="25" bgcolor="#FFFFFF" align="left" class="t12Black" width="55%"><label field="sorgName" /></td>
					  <td align="center" bgcolor="#FFFFFF" class="t12Black" width="25%"><label field="applyType" dataset="applyTypeSelect"/></td>
					  <td align="center" bgcolor="#FFFFFF" class="t12Black" width="20%">准予</td>
					</tr> 
				 </table>
		     </DIV>
			 <DIV id=oRollV2></DIV>
		 </DIV>
    </td>
  </tr>
</table>
</body>
</html>