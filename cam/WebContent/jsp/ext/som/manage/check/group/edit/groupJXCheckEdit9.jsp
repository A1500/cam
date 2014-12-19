<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
 <%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
//初始化

function init(){
	var somJxCheckBusinessActivityDataSet = L5.DatasetMgr.lookup("somJxCheckBusinessActivityDataSet");
	somJxCheckBusinessActivityDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxCheckBusinessActivityDataSet.load();
	somJxCheckBusinessActivityDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somJxCheckBusinessActivityDataSet.newRecord();
		}
	});
	//创建页面导航下拉框
	createGroupEditSelect();
}
function save(){
	var somJxCheckBusinessActivityDataSetIsValidate = somJxCheckBusinessActivityDataSet.isValidate();
	if(somJxCheckBusinessActivityDataSetIsValidate!=true){
		L5.Msg.alert("提示",somJxCheckBusinessActivityDataSetIsValidate);
		return "break";
	}
	var businessActivityRecord=somJxCheckBusinessActivityDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("businessActivityRecord", businessActivityRecord);
	command.setParameter("taskCode", taskCode);
	command.execute("savePage9");
	if (!command.error) {
		alert("保存成功！");		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function setSumMoney(){
	somJxCheckBusinessActivityDataSet.set("donationIncomePySum",(setParseFloat("捐赠收入1")+setParseFloat("捐赠收入2")).toFixed(6)*1);
	somJxCheckBusinessActivityDataSet.set("donationIncomeTySum",(setParseFloat("捐赠收入3")+setParseFloat("捐赠收入4")).toFixed(6)*1);
	somJxCheckBusinessActivityDataSet.set("duesIncomePySum",(setParseFloat("会费收入1")+setParseFloat("会费收入2")).toFixed(6)*1);	
	somJxCheckBusinessActivityDataSet.set("duesIncomeTySum",(setParseFloat("会费收入3")+setParseFloat("会费收入4")).toFixed(6)*1);		
	somJxCheckBusinessActivityDataSet.set("serviceIncomePySum",(setParseFloat("提供服务收入1")+setParseFloat("提供服务收入2")).toFixed(6)*1);		
	somJxCheckBusinessActivityDataSet.set("serviceIncomeTySum",(setParseFloat("提供服务收入3")+setParseFloat("提供服务收入4")).toFixed(6)*1);				
	somJxCheckBusinessActivityDataSet.set("govBuyPySum",(setParseFloat("政府购买服务收入1")+setParseFloat("政府购买服务收入2")).toFixed(6)*1);						
	somJxCheckBusinessActivityDataSet.set("govBuyTySum",(setParseFloat("政府购买服务收入2")+setParseFloat("政府购买服务收入3")).toFixed(6)*1);								
	somJxCheckBusinessActivityDataSet.set("productIncomePySum",(setParseFloat("商品销售收入1")+setParseFloat("商品销售收入2")).toFixed(6)*1);										
	somJxCheckBusinessActivityDataSet.set("productIncomeTySum",(setParseFloat("商品销售收入3")+setParseFloat("商品销售收入4")).toFixed(6)*1);										
	somJxCheckBusinessActivityDataSet.set("govGrantsPySum",(setParseFloat("政府补助收入1")+setParseFloat("政府补助收入2")).toFixed(6)*1);
	somJxCheckBusinessActivityDataSet.set("govGrantsTySum",(setParseFloat("政府补助收入3")+setParseFloat("政府补助收入4")).toFixed(6)*1);
	somJxCheckBusinessActivityDataSet.set("invIncomePySum",(setParseFloat("投资收益1")+setParseFloat("投资收益2")).toFixed(6)*1);	
	somJxCheckBusinessActivityDataSet.set("invIncomeTySum",(setParseFloat("投资收益3")+setParseFloat("投资收益4")).toFixed(6)*1);		
	somJxCheckBusinessActivityDataSet.set("otherIncomePySum",(setParseFloat("其他收入1")+setParseFloat("其他收入2")).toFixed(6)*1);			
	somJxCheckBusinessActivityDataSet.set("otherIncomeTySum",(setParseFloat("其他收入3")+setParseFloat("其他收入4")).toFixed(6)*1);				
			
	somJxCheckBusinessActivityDataSet.set("incomeSumPyUnlimit",(setParseFloat("捐赠收入1")+setParseFloat("会费收入1")+setParseFloat("提供服务收入1")+setParseFloat("政府购买服务收入1")+setParseFloat("商品销售收入1")+setParseFloat("政府补助收入1")+setParseFloat("投资收益1")+setParseFloat("其他收入1")).toFixed(6)*1);
	somJxCheckBusinessActivityDataSet.set("incomeSumPyLimit",(setParseFloat("捐赠收入2")+setParseFloat("会费收入2")+setParseFloat("提供服务收入2")+setParseFloat("政府购买服务收入2")+setParseFloat("商品销售收入2")+setParseFloat("政府补助收入2")+setParseFloat("投资收益2")+setParseFloat("其他收入2")).toFixed(6)*1);
	somJxCheckBusinessActivityDataSet.set("incomeSumPySum",(getParseFloat(somJxCheckBusinessActivityDataSet.get("incomeSumPyUnlimit"))+getParseFloat(somJxCheckBusinessActivityDataSet.get("incomeSumPyLimit"))).toFixed(6)*1);
	somJxCheckBusinessActivityDataSet.set("incomeSumTyUnlimit",(setParseFloat("捐赠收入3")+setParseFloat("会费收入3")+setParseFloat("提供服务收入3")+setParseFloat("政府购买服务收入3")+setParseFloat("商品销售收入3")+setParseFloat("政府补助收入3")+setParseFloat("投资收益3")+setParseFloat("其他收入3")).toFixed(6)*1);
	somJxCheckBusinessActivityDataSet.set("incomeSumTyLimit",(setParseFloat("捐赠收入4")+setParseFloat("会费收入4")+setParseFloat("提供服务收入4")+setParseFloat("政府购买服务收入4")+setParseFloat("商品销售收入4")+setParseFloat("政府补助收入4")+setParseFloat("投资收益4")+setParseFloat("其他收入4")).toFixed(6)*1);
	somJxCheckBusinessActivityDataSet.set("incomeSumTySum",(getParseFloat(somJxCheckBusinessActivityDataSet.get("incomeSumTyUnlimit"))+getParseFloat(somJxCheckBusinessActivityDataSet.get("incomeSumTyLimit"))).toFixed(6)*1);
	
	somJxCheckBusinessActivityDataSet.set("staffCostPySum",(setParseFloat("人员费用1")+setParseFloat("人员费用2")).toFixed(6)*1);
	somJxCheckBusinessActivityDataSet.set("staffCostTySum",(setParseFloat("人员费用3")+setParseFloat("人员费用4")).toFixed(6)*1);
	somJxCheckBusinessActivityDataSet.set("runningCostPySum",(setParseFloat("日常费用1")+setParseFloat("日常费用2")).toFixed(6)*1);
	somJxCheckBusinessActivityDataSet.set("runningCostTySum",(setParseFloat("日常费用3")+setParseFloat("日常费用4")).toFixed(6)*1);	
	somJxCheckBusinessActivityDataSet.set("depreciationAssetsPySum",(setParseFloat("固定资产折旧1")+setParseFloat("固定资产折旧2")).toFixed(6)*1);		
	somJxCheckBusinessActivityDataSet.set("depreciationAssetsTySum",(setParseFloat("固定资产折旧3")+setParseFloat("固定资产折旧4")).toFixed(6)*1);		
	somJxCheckBusinessActivityDataSet.set("taxesPySum",(setParseFloat("税费1")+setParseFloat("税费2")).toFixed(6)*1);		
	somJxCheckBusinessActivityDataSet.set("taxesTySum",(setParseFloat("税费3")+setParseFloat("税费4")).toFixed(6)*1);	
	
	somJxCheckBusinessActivityDataSet.set("businessCostPyUnlimit",(setParseFloat("人员费用1")+setParseFloat("日常费用1")+setParseFloat("固定资产折旧1")+setParseFloat("税费1")).toFixed(6)*1);		
	somJxCheckBusinessActivityDataSet.set("businessCostPyLimit",(setParseFloat("人员费用2")+setParseFloat("日常费用2")+setParseFloat("固定资产折旧2")+setParseFloat("税费2")).toFixed(6)*1);		
	somJxCheckBusinessActivityDataSet.set("businessCostPySun",(getParseFloat(somJxCheckBusinessActivityDataSet.get("businessCostPyUnlimit"))+getParseFloat(somJxCheckBusinessActivityDataSet.get("businessCostPyLimit"))).toFixed(6)*1);
	somJxCheckBusinessActivityDataSet.set("businessCostTyUnlimit",(setParseFloat("人员费用3")+setParseFloat("日常费用3")+setParseFloat("固定资产折旧3")+setParseFloat("税费3")).toFixed(6)*1);		
	somJxCheckBusinessActivityDataSet.set("businessCostTyLimit",(setParseFloat("人员费用4")+setParseFloat("日常费用4")+setParseFloat("固定资产折旧4")+setParseFloat("税费4")).toFixed(6)*1);		
	somJxCheckBusinessActivityDataSet.set("businessCostTySum",(getParseFloat(somJxCheckBusinessActivityDataSet.get("businessCostTyUnlimit"))+getParseFloat(somJxCheckBusinessActivityDataSet.get("businessCostTyLimit"))).toFixed(6)*1);
	
	somJxCheckBusinessActivityDataSet.set("manageCostPySum",(setParseFloat("管理费用1")+setParseFloat("管理费用2")).toFixed(6)*1);
	somJxCheckBusinessActivityDataSet.set("manageCostTySum",(setParseFloat("管理费用3")+setParseFloat("管理费用4")).toFixed(6)*1);
	somJxCheckBusinessActivityDataSet.set("raisingCostPySum",(setParseFloat("筹资费用1")+setParseFloat("筹资费用2")).toFixed(6)*1);	
	somJxCheckBusinessActivityDataSet.set("raisingCostTySum",(setParseFloat("筹资费用3")+setParseFloat("筹资费用4")).toFixed(6)*1);	
	somJxCheckBusinessActivityDataSet.set("otherCostPySum",(setParseFloat("其他费用1")+setParseFloat("其他费用2")).toFixed(6)*1);	
	somJxCheckBusinessActivityDataSet.set("otherCostTySum",(setParseFloat("其他费用3")+setParseFloat("其他费用4")).toFixed(6)*1);	
	
	somJxCheckBusinessActivityDataSet.set("costSumPyUnlimit",(getParseFloat(somJxCheckBusinessActivityDataSet.get("businessCostPyUnlimit"))+setParseFloat("管理费用1")+setParseFloat("筹资费用1")+setParseFloat("其他费用1")).toFixed(6)*1);		
	somJxCheckBusinessActivityDataSet.set("costSumPyLimit",(getParseFloat(somJxCheckBusinessActivityDataSet.get("businessCostPyLimit"))+setParseFloat("管理费用2")+setParseFloat("筹资费用2")+setParseFloat("其他费用2")).toFixed(6)*1);		
	somJxCheckBusinessActivityDataSet.set("costSumPySum",(getParseFloat(somJxCheckBusinessActivityDataSet.get("businessCostPySun"))+getParseFloat(somJxCheckBusinessActivityDataSet.get("manageCostPySum"))+getParseFloat(somJxCheckBusinessActivityDataSet.get("raisingCostPySum"))+getParseFloat(somJxCheckBusinessActivityDataSet.get("otherCostPySum"))).toFixed(6)*1);
	somJxCheckBusinessActivityDataSet.set("costSumTyUnlimit",(getParseFloat(somJxCheckBusinessActivityDataSet.get("businessCostTyUnlimit"))+setParseFloat("管理费用3")+setParseFloat("筹资费用3")+setParseFloat("其他费用3")).toFixed(6)*1);		
	somJxCheckBusinessActivityDataSet.set("costSumTyLimit",(getParseFloat(somJxCheckBusinessActivityDataSet.get("businessCostTyLimit"))+setParseFloat("管理费用4")+setParseFloat("筹资费用4")+setParseFloat("其他费用4")).toFixed(6)*1);		
	somJxCheckBusinessActivityDataSet.set("costSumTySum",(getParseFloat(somJxCheckBusinessActivityDataSet.get("businessCostTySum"))+getParseFloat(somJxCheckBusinessActivityDataSet.get("manageCostTySum"))+getParseFloat(somJxCheckBusinessActivityDataSet.get("raisingCostTySum"))+getParseFloat(somJxCheckBusinessActivityDataSet.get("otherCostTySum"))).toFixed(6)*1);
	
	somJxCheckBusinessActivityDataSet.set("limitToUnlimitPySum",(setParseFloat("限定性净资产转为非限定性净资产1")+setParseFloat("限定性净资产转为非限定性净资产2")).toFixed(6)*1);
	somJxCheckBusinessActivityDataSet.set("limitToUnlimitTySum",(setParseFloat("限定性净资产转为非限定性净资产3")+setParseFloat("限定性净资产转为非限定性净资产4")).toFixed(6)*1);
	
	somJxCheckBusinessActivityDataSet.set("assetsChangePyUnlimit",(getParseFloat($("incomeSumPyUnlimit").innerHTML)+getParseFloat(_$("限定性净资产转为非限定性净资产1"))-getParseFloat($("costSumPyUnlimit").innerHTML)).toFixed(6)*1);
	somJxCheckBusinessActivityDataSet.set("assetsChangePyLimit",(getParseFloat($("incomeSumPyLimit").innerHTML)+getParseFloat(_$("限定性净资产转为非限定性净资产2"))-getParseFloat($("costSumPyLimit").innerHTML)).toFixed(6)*1);
	somJxCheckBusinessActivityDataSet.set("assetsChangePySum",(getParseFloat(somJxCheckBusinessActivityDataSet.get("assetsChangePyUnlimit"))+getParseFloat(somJxCheckBusinessActivityDataSet.get("assetsChangePyLimit"))).toFixed(6)*1);
	somJxCheckBusinessActivityDataSet.set("assetsChangeTyUnlimit",(getParseFloat($("incomeSumTyUnlimit").innerHTML)+getParseFloat(_$("限定性净资产转为非限定性净资产3"))-getParseFloat($("costSumTyUnlimit").innerHTML)).toFixed(6)*1);
	somJxCheckBusinessActivityDataSet.set("assetsChangeTyLimit",(getParseFloat($("incomeSumTyLimit").innerHTML)+getParseFloat(_$("限定性净资产转为非限定性净资产4"))-getParseFloat($("costSumTyLimit").innerHTML)).toFixed(6)*1);
	somJxCheckBusinessActivityDataSet.set("assetsChangeTySum",(getParseFloat(somJxCheckBusinessActivityDataSet.get("assetsChangeTyUnlimit"))+getParseFloat(somJxCheckBusinessActivityDataSet.get("assetsChangeTyLimit"))).toFixed(6)*1);
}
function setParseFloat(id){
	var value = document.getElementById(id).value;
	if(!value){
		return 0;
	}else{
		return parseFloat(value);
	}
}
function getParseFloat(value){
	if(!value){
		return 0;
	}else{
		return parseFloat(value);
	}
}
</script>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxCheckBusinessActivityDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckbusinessactivity.cmd.SomJxCheckBusinessActivityQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckbusinessactivity.dao.SomJxCheckBusinessActivity">
			<model:field name="donationIncomeTyUnlimit" type="string" rule="require" />
			<model:field name="donationIncomeTyLimit" type="string" rule="require" />
			<model:field name="donationIncomeTySum" type="string" rule="require" />
			<model:field name="duesIncomeTyUnlimit" type="string" rule="require" />
			<model:field name="duesIncomeTyLimit" type="string" rule="require" />
			<model:field name="duesIncomeTySum" type="string" rule="require" />
			<model:field name="serviceIncomeTyUnlimit" type="string" rule="require" />
			<model:field name="serviceIncomeTyLimit" type="string" rule="require" />
			<model:field name="serviceIncomeTySum" type="string" rule="require" />
			<model:field name="govBuyTyUnlimit" type="string" rule="require" />
			<model:field name="govBuyTyLimit" type="string" rule="require" />
			<model:field name="govBuyTySum" type="string" rule="require" />
			<model:field name="productIncomeTyUnlimit" type="string" rule="require" />
			<model:field name="productIncomeTyLimit" type="string" rule="require" />
			<model:field name="productIncomeTySum" type="string" rule="require" />
			<model:field name="govGrantsTyUnlimit" type="string" rule="require" />
			<model:field name="govGrantsTyLimit" type="string" rule="require" />
			<model:field name="govGrantsTySum" type="string" rule="require" />
			<model:field name="invIncomeTyUnlimit" type="string" rule="require" />
			<model:field name="invIncomeTyLimit" type="string" rule="require" />
			<model:field name="invIncomeTySum" type="string" rule="require" />
			<model:field name="otherIncomeTyUnlimit" type="string" rule="require" />
			<model:field name="otherIncomeTyLimit" type="string" rule="require" />
			<model:field name="otherIncomeTySum" type="string" rule="require" />
			<model:field name="incomeSumTyUnlimit" type="string" rule="require" />
			<model:field name="incomeSumTySum" type="string" rule="require" />
			<model:field name="businessCostTyUnlimit" type="string" rule="require" />
			<model:field name="businessCostTyLimit" type="string" rule="require" />
			<model:field name="businessCostTySum" type="string" rule="require" />
			<model:field name="staffCostTyUnlimit" type="string" rule="require" />
			<model:field name="staffCostTyLimit" type="string" rule="require" />
			<model:field name="staffCostTySum" type="string" rule="require" />
			<model:field name="runningCostTyUnlimit" type="string" rule="require" />
			<model:field name="runningCostTyLimit" type="string" rule="require" />
			<model:field name="runningCostTySum" type="string" rule="require" />
			<model:field name="depreciationAssetsTyUnlimit" type="string" rule="require" />
			<model:field name="depreciationAssetsTyLimit" type="string" rule="require" />
			<model:field name="depreciationAssetsTySum" type="string" rule="require" />
			<model:field name="taxesTyUnlimit" type="string" rule="require" />
			<model:field name="taxesTyLimit" type="string" rule="require" />
			<model:field name="taxesTySum" type="string" rule="require" />
			<model:field name="manageCostTyUnlimit" type="string" rule="require" />
			<model:field name="manageCostTyLimit" type="string" rule="require" />
			<model:field name="raisingCostTyUnlimit" type="string" rule="require" />
			<model:field name="raisingCostTyLimit" type="string" rule="require" />
			<model:field name="raisingCostTySum" type="string" rule="require" />
			<model:field name="otherCostTyUnlimit" type="string" rule="require" />
			<model:field name="otherCostTyLimit" type="string" rule="require" />
			<model:field name="otherCostTySum" type="string" rule="require" />
			<model:field name="costSumTyUnlimit" type="string" rule="require" />
			<model:field name="costSumTyLimit" type="string" rule="require" />
			<model:field name="costSumTySum" type="string" rule="require" />
			<model:field name="limitToUnlimitTyUnlimit" type="string" rule="require" />
			<model:field name="limitToUnlimitTyLimit" type="string" rule="require" />
			<model:field name="limitToUnlimitTySum" type="string" rule="require" />
			<model:field name="assetsChangeTyUnlimit" type="string" rule="require" />
			<model:field name="assetsChangeTyLimit" type="string" rule="require" />
			<model:field name="assetsChangeTySum" type="string" rule="require" />
		</model:record>
	</model:dataset>
</model:datasets>
<div id="float">
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPage('10')"/>
		<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPage('8')"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="back();"/>	
</div>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center
	style='margin-left: 0cm; text-align: center; text-indent: 0cm; line-height: 150%; mso-list: l0 level1 lfo1'><![if !supportLists]><b
	style='mso-bidi-font-weight: normal'><span lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; line-height: 150%; font-family: 仿宋; mso-hansi-font-family: 仿宋; mso-bidi-font-family: 仿宋'><span
	style='mso-list: Ignore'></span></span></b><![endif]><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; line-height: 150%; font-family: 仿宋; mso-hansi-font-family: 仿宋'>2.业务活动表<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal align=right
	style='text-align: center; line-height: 150%'><span lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; line-height: 150%; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
	style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; line-height: 150%; font-family: 仿宋; mso-hansi-font-family: 仿宋'>单位：元<span
	lang=EN-US><o:p></o:p></span></span></p>

<div align=center>
<form method="post" dataset="somJxCheckBusinessActivityDataSet" onsubmit="return false">
<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
	style='border-collapse: collapse; border: none; mso-border-top-alt: solid windowtext 1.5pt; mso-border-bottom-alt: solid windowtext 1.5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext'>
	<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes'>
		<td width=223 rowspan=2
			style='width: 167.6pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>项<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>目<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 rowspan=2
			style='width: 1.0cm; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>行次<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=189 colspan=3
			style='width: 5.0cm; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>上年累计数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=197 colspan=3
			style='width: 147.9pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: none; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>本年累计数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 1'>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>非限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=57
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=57
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>非限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=66
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=55
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 2'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>一、收<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 3'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>其中：捐赠收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>1<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="donationIncomePyUnlimit" id="捐赠收入1" name='"其中：捐赠收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="donationIncomePyLimit" id="捐赠收入2" name='"其中：捐赠收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="donationIncomePySum" name='"其中：捐赠收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="donationIncomeTyUnlimit" id="捐赠收入3" name='"其中：捐赠收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="donationIncomeTyLimit" id="捐赠收入4" name='"其中：捐赠收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="donationIncomeTySum" name='"其中：捐赠收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 4'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>会费收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>2<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="duesIncomePyUnlimit" id="会费收入1" name='"会费收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="duesIncomePyLimit" id="会费收入2" name='"会费收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="duesIncomePySum" name='"会费收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="duesIncomeTyUnlimit" id="会费收入3" name='"会费收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="duesIncomeTyLimit" id="会费收入4" name='"会费收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="duesIncomeTySum" name='"会费收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 5'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>提供服务收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>3<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="serviceIncomePyUnlimit" id="提供服务收入1" name='"提供服务收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="serviceIncomePyLimit" id="提供服务收入2" name='"提供服务收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="serviceIncomePySum" name='"提供服务收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="serviceIncomeTyUnlimit" id="提供服务收入3" name='"提供服务收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="serviceIncomeTyLimit" id="提供服务收入4" name='"提供服务收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="serviceIncomeTySum" name='"提供服务收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 6'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>其中：政府购买服务收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>3.1<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="govBuyPyUnlimit" id="政府购买服务收入1" name='"其中：政府购买服务收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="govBuyPyLimit" id="政府购买服务收入2" name='"其中：政府购买服务收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="govBuyPySum" name='"其中：政府购买服务收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="govBuyTyUnlimit" id="政府购买服务收入3" name='"其中：政府购买服务收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="govBuyTyLimit" id="政府购买服务收入4" name='"其中：政府购买服务收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="govBuyTySum" name='"其中：政府购买服务收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 7'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>商品销售收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>4<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="productIncomePyUnlimit" id="商品销售收入1" name='"商品销售收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="productIncomePyLimit" id="商品销售收入2" name='"商品销售收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="productIncomePySum" name='"商品销售收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="productIncomeTyUnlimit" id="商品销售收入3" name='"商品销售收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="productIncomeTyLimit" id="商品销售收入4" name='"商品销售收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="productIncomeTySum" name='"商品销售收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 8'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>政府补助收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>5<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="govGrantsPyUnlimit" id="政府补助收入1" name='"政府补助收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="govGrantsPyLimit" id="政府补助收入2" name='"政府补助收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="govGrantsPySum" name='"政府补助收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="govGrantsTyUnlimit" id="政府补助收入3" name='"政府补助收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="govGrantsTyLimit" id="政府补助收入4" name='"政府补助收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="govGrantsTySum" name='"政府补助收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 9'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>投资收益<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>6<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="invIncomePyUnlimit" id="投资收益1" name='"投资收益"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="invIncomePyLimit" id="投资收益2" name='"投资收益"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="invIncomePySum" name='"投资收益"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="invIncomeTyUnlimit" id="投资收益3" name='"投资收益"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="invIncomeTyLimit" id="投资收益4" name='"投资收益"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="invIncomeTySum" name='"投资收益"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 10'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>其他收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>9<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="otherIncomePyUnlimit" id="其他收入1" name='"其他收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="otherIncomePyLimit" id="其他收入2" name='"其他收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="otherIncomePySum" name='"其他收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="otherIncomeTyUnlimit" id="其他收入3" name='"其他收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="otherIncomeTyLimit" id="其他收入4" name='"其他收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="otherIncomeTySum" name='"其他收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 11'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 28.0pt; mso-char-indent-count: 2.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>收入合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>11<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="incomeSumPyUnlimit"  id="incomeSumPyUnlimit" name='"收入合计"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="incomeSumPyLimit" id="incomeSumPyLimit" name='"收入合计"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="incomeSumPySum" name='"收入合计"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="incomeSumTyUnlimit" id="incomeSumTyUnlimit" name='"收入合计"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="incomeSumTyLimit" id="incomeSumTyLimit" name='"收入合计"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="incomeSumTySum" name='"收入合计"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 12'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>二、费<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 13'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>（一）业务活动成本<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>12<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="businessCostPyUnlimit" name='"业务活动成本"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="businessCostPyLimit" name='"业务活动成本"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="businessCostPySun" name='"业务活动成本"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="businessCostTyUnlimit" name='"业务活动成本"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="businessCostTyLimit" name='"业务活动成本"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="businessCostTySum" name='"业务活动成本"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p> 
		</td>
	</tr>
	<tr style='mso-yfti-irow: 14'>
		<td width=223 valign=top
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>其中：人员费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>13<o:p></o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="staffCostPyUnlimit" id="人员费用1" name='"人员费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="staffCostPyLimit" id="人员费用2" name='"人员费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="staffCostPySum" name='"人员费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="staffCostTyUnlimit" id="人员费用3" name='"人员费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 valign=top
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="staffCostTyLimit" id="人员费用4" name='"人员费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 valign=top
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="staffCostTySum" name='"人员费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 15'>
		<td width=223 valign=top
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>日常费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>14<o:p></o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="runningCostPyUnlimit" id="日常费用1" name='"日常费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="runningCostPyLimit" id="日常费用2" name='"日常费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="runningCostPySum" name='"日常费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="runningCostTyUnlimit" id="日常费用3" name='"日常费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 valign=top
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="runningCostTyLimit" id="日常费用4" name='"日常费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 valign=top
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="runningCostTySum" name='"日常费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 16'>
		<td width=223 valign=top
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>固定资产折旧<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>15<o:p></o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="depreciationAssetsPyUnlimit" id="固定资产折旧1" name='"固定资产折旧"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="depreciationAssetsPyLimit" id="固定资产折旧2" name='"固定资产折旧"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="depreciationAssetsPySum" id="" name='"固定资产折旧"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="depreciationAssetsTyUnlimit" id="固定资产折旧3" name='"固定资产折旧"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 valign=top
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="depreciationAssetsTyLimit" id="固定资产折旧4" name='"固定资产折旧"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 valign=top
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="depreciationAssetsTySum" name='"固定资产折旧"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 17'>
		<td width=223 valign=top
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>税费<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>16<o:p></o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="taxesPyUnlimit" id="税费1" name='"税费"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="taxesPyLimit" id="税费2" name='"税费"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="taxesPySum" id="" name='"税费"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="taxesTyUnlimit" id="税费3" name='"税费"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 valign=top
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="taxesTyLimit" id="税费4" name='"税费"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 valign=top
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="taxesTySum" id="" name='"税费"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 18'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>（二）管理费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>21<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="manageCostPyUnlimit" id="管理费用1" name='"管理费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="manageCostPyLimit" id="管理费用2" name='"管理费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="manageCostPySum" name='"管理费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="manageCostTyUnlimit" id="管理费用3" name='"管理费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="manageCostTyLimit" id="管理费用4" name='"管理费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="manageCostTySum" name='"管理费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 19'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>（三）筹资费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>24<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="raisingCostPyUnlimit" id="筹资费用1" name='"筹资费用"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="raisingCostPyLimit" id="筹资费用2" name='"筹资费用"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="raisingCostPySum" name='"筹资费用"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="raisingCostTyUnlimit" id="筹资费用3" name='"筹资费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="raisingCostTyLimit" id="筹资费用4" name='"筹资费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="raisingCostTySum" name='"筹资费用"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 20'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>（四）其他费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>28<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="otherCostPyUnlimit" id="其他费用1" name='"其他费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="otherCostPyLimit" id="其他费用2" name='"其他费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="otherCostPySum" name='"其他费用"' style="width:98%;text-align:right;padding-right:2px;"  ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="otherCostTyUnlimit" id="其他费用3" name='"其他费用"' style="width:98%;text-align:right;padding-right:2px;" onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="otherCostTyLimit" id="其他费用4" name='"其他费用"' style="width:98%;text-align:right;padding-right:2px;"  onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="otherCostTySum" name='"其他费用"' style="width:98%;text-align:right;padding-right:2px;"  ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 21'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 28.0pt; mso-char-indent-count: 2.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>费用合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>35<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="costSumPyUnlimit" id="costSumPyUnlimit" name='"费用合计"' style="width:98%;text-align:right;padding-right:2px;"  ></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="costSumPyLimit" id="costSumPyLimit" name='"费用合计"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " ></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="costSumPySum"  name='"费用合计"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() " ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="costSumTyUnlimit"  id="costSumTyUnlimit" name='"费用合计"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="costSumTyLimit" id="costSumTyLimit" name='"费用合计"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p> 
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="costSumTySum"  name='"费用合计"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 22'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>三、限定性净资产转为非限定性净资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>40<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="limitToUnlimitPyUnlimt" id="限定性净资产转为非限定性净资产1" name='"限定性净资产转为非限定性净资产"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='setSumMoney();' onkeyup="value=value.replace(/[^\d.-]/g,'') " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="limitToUnlimitPyLimit" id="限定性净资产转为非限定性净资产2" name='"限定性净资产转为非限定性净资产"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="limitToUnlimitPySum" name='"限定性净资产转为非限定性净资产"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="limitToUnlimitTyUnlimit" id="限定性净资产转为非限定性净资产3" name='"限定性净资产转为非限定性净资产"' style="width:98%;text-align:right;padding-right:2px;"  onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<input field="limitToUnlimitTyLimit" id="限定性净资产转为非限定性净资产4" name='"限定性净资产转为非限定性净资产"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="limitToUnlimitTySum" name='"限定性净资产转为非限定性净资产"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 23; mso-yfti-lastrow: yes'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>四、净资产变动额</span><tt><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>（若为净资产减少额，以“<span
			lang=EN-US>-</span>”号填列）</span></tt><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p></o:p></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>45<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="assetsChangePyUnlimit" id="assetsChangePyUnlimit" name='"净资产变动额"' style="width:98%"  style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="assetsChangePyLimit" id="assetsChangePyLimit" name='"净资产变动额"' style="width:98%" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="assetsChangePySum" name='"净资产变动额"' style="width:98%"  style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="assetsChangeTyUnlimit" id="assetsChangeTyUnlimit" name='"净资产变动额"' style="width:98%" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="assetsChangeTyLimit" id="assetsChangeTyLimit" name='"净资产变动额"' style="width:98%" style='text-align:right;padding-right:2px;' ></label>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p>
			<label field="assetsChangeTySum" name='"净资产变动额"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;'  ></label>
			</o:p></span></p>
		</td>
	</tr>
</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>
