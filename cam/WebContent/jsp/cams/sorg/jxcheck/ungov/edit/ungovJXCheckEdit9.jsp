<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
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
	createUngovEditSelect();
}
function save(){
	var somJxCheckBusinessActivityDataSetIsValidate = somJxCheckBusinessActivityDataSet.isValidate();
	if(somJxCheckBusinessActivityDataSetIsValidate!=true){
		L5.Msg.alert("提示",somJxCheckBusinessActivityDataSetIsValidate);
		return;
	}
	var businessActivityRecord=somJxCheckBusinessActivityDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("businessActivityRecord", businessActivityRecord);
	command.setParameter("taskCode", taskCode);
	command.execute("savePage9");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function setSumMoney(){
	somJxCheckBusinessActivityDataSet.set("donationIncomePySum",(setParseFloat("捐赠收入1")+setParseFloat("捐赠收入2")).toFixed(2));
	somJxCheckBusinessActivityDataSet.set("donationIncomeTySum",(setParseFloat("捐赠收入3")+setParseFloat("捐赠收入4")).toFixed(2));
	somJxCheckBusinessActivityDataSet.set("duesIncomePySum",(setParseFloat("会费收入1")+setParseFloat("会费收入2")).toFixed(2));	
	somJxCheckBusinessActivityDataSet.set("duesIncomeTySum",(setParseFloat("会费收入3")+setParseFloat("会费收入4")).toFixed(2));		
	somJxCheckBusinessActivityDataSet.set("serviceIncomePySum",(setParseFloat("提供服务收入1")+setParseFloat("提供服务收入2")).toFixed(2));		
	somJxCheckBusinessActivityDataSet.set("serviceIncomeTySum",(setParseFloat("提供服务收入3")+setParseFloat("提供服务收入4")).toFixed(2));				
	somJxCheckBusinessActivityDataSet.set("govBuyPySum",(setParseFloat("政府购买服务收入1")+setParseFloat("政府购买服务收入2")).toFixed(2));						
	somJxCheckBusinessActivityDataSet.set("govBuyTySum",(setParseFloat("政府购买服务收入2")+setParseFloat("政府购买服务收入3")).toFixed(2));								
	somJxCheckBusinessActivityDataSet.set("productIncomePySum",(setParseFloat("商品销售收入1")+setParseFloat("商品销售收入2")).toFixed(2));										
	somJxCheckBusinessActivityDataSet.set("productIncomeTySum",(setParseFloat("商品销售收入3")+setParseFloat("商品销售收入4")).toFixed(2));										
	somJxCheckBusinessActivityDataSet.set("govGrantsPySum",(setParseFloat("政府补助收入1")+setParseFloat("政府补助收入2")).toFixed(2));
	somJxCheckBusinessActivityDataSet.set("govGrantsTySum",(setParseFloat("政府补助收入3")+setParseFloat("政府补助收入4")).toFixed(2));
	somJxCheckBusinessActivityDataSet.set("invIncomePySum",(setParseFloat("投资收益1")+setParseFloat("投资收益2")).toFixed(2));	
	somJxCheckBusinessActivityDataSet.set("invIncomeTySum",(setParseFloat("投资收益3")+setParseFloat("投资收益4")).toFixed(2));		
	somJxCheckBusinessActivityDataSet.set("otherIncomePySum",(setParseFloat("其他收入1")+setParseFloat("其他收入2")).toFixed(2));			
	somJxCheckBusinessActivityDataSet.set("otherIncomeTySum",(setParseFloat("其他收入3")+setParseFloat("其他收入4")).toFixed(2));				
			
	somJxCheckBusinessActivityDataSet.set("incomeSumPyUnlimit",(setParseFloat("捐赠收入1")+setParseFloat("会费收入1")+setParseFloat("提供服务收入1")+setParseFloat("政府购买服务收入1")+setParseFloat("商品销售收入1")+setParseFloat("政府补助收入1")+setParseFloat("投资收益1")+setParseFloat("其他收入1")).toFixed(2));
	somJxCheckBusinessActivityDataSet.set("incomeSumPyLimit",(setParseFloat("捐赠收入2")+setParseFloat("会费收入2")+setParseFloat("提供服务收入2")+setParseFloat("政府购买服务收入2")+setParseFloat("商品销售收入2")+setParseFloat("政府补助收入2")+setParseFloat("投资收益2")+setParseFloat("其他收入2")).toFixed(2));
	somJxCheckBusinessActivityDataSet.set("incomeSumPySum",(somJxCheckBusinessActivityDataSet.get("incomeSumPyUnlimit")+somJxCheckBusinessActivityDataSet.get("incomeSumPyLimit")).toFixed(2));
	somJxCheckBusinessActivityDataSet.set("incomeSumTyUnlimit",(setParseFloat("捐赠收入3")+setParseFloat("会费收入3")+setParseFloat("提供服务收入3")+setParseFloat("政府购买服务收入3")+setParseFloat("商品销售收入3")+setParseFloat("政府补助收入3")+setParseFloat("投资收益3")+setParseFloat("其他收入3")).toFixed(2));
	somJxCheckBusinessActivityDataSet.set("incomeSumTyLimit",(setParseFloat("捐赠收入4")+setParseFloat("会费收入4")+setParseFloat("提供服务收入4")+setParseFloat("政府购买服务收入4")+setParseFloat("商品销售收入4")+setParseFloat("政府补助收入4")+setParseFloat("投资收益4")+setParseFloat("其他收入4")).toFixed(2));
	somJxCheckBusinessActivityDataSet.set("incomeSumTySum",(somJxCheckBusinessActivityDataSet.get("incomeSumTyUnlimit")+somJxCheckBusinessActivityDataSet.get("incomeSumTyLimit")).toFixed(2));
	
	somJxCheckBusinessActivityDataSet.set("staffCostPySum",(setParseFloat("人员费用1")+setParseFloat("人员费用2")).toFixed(2));
	somJxCheckBusinessActivityDataSet.set("staffCostTySum",(setParseFloat("人员费用3")+setParseFloat("人员费用4")).toFixed(2));
	somJxCheckBusinessActivityDataSet.set("runningCostPySum",(setParseFloat("日常费用1")+setParseFloat("日常费用2")).toFixed(2));
	somJxCheckBusinessActivityDataSet.set("runningCostTySum",(setParseFloat("日常费用3")+setParseFloat("日常费用4")).toFixed(2));	
	somJxCheckBusinessActivityDataSet.set("depreciationAssetsPySum",(setParseFloat("固定资产折旧1")+setParseFloat("固定资产折旧2")).toFixed(2));		
	somJxCheckBusinessActivityDataSet.set("depreciationAssetsTySum",(setParseFloat("固定资产折旧3")+setParseFloat("固定资产折旧4")).toFixed(2));		
	somJxCheckBusinessActivityDataSet.set("taxesPySum",(setParseFloat("税费1")+setParseFloat("税费2")).toFixed(2));		
	somJxCheckBusinessActivityDataSet.set("taxesTySum",(setParseFloat("税费3")+setParseFloat("税费4")).toFixed(2));	
	
	somJxCheckBusinessActivityDataSet.set("businessCostPyUnlimit",(setParseFloat("人员费用1")+setParseFloat("日常费用1")+setParseFloat("固定资产折旧1")+setParseFloat("税费1")).toFixed(2));		
	somJxCheckBusinessActivityDataSet.set("businessCostPyLimit",(setParseFloat("人员费用2")+setParseFloat("日常费用2")+setParseFloat("固定资产折旧2")+setParseFloat("税费2")).toFixed(2));		
	somJxCheckBusinessActivityDataSet.set("businessCostPySun",(somJxCheckBusinessActivityDataSet.get("businessCostPyUnlimit")+somJxCheckBusinessActivityDataSet.get("businessCostPyLimit")).toFixed(2));
	somJxCheckBusinessActivityDataSet.set("businessCostTyUnlimit",(setParseFloat("人员费用3")+setParseFloat("日常费用3")+setParseFloat("固定资产折旧3")+setParseFloat("税费3")).toFixed(2));		
	somJxCheckBusinessActivityDataSet.set("businessCostTyLimit",(setParseFloat("人员费用4")+setParseFloat("日常费用4")+setParseFloat("固定资产折旧4")+setParseFloat("税费4")).toFixed(2));		
	somJxCheckBusinessActivityDataSet.set("businessCostTySum",(somJxCheckBusinessActivityDataSet.get("businessCostTyUnlimit")+somJxCheckBusinessActivityDataSet.get("businessCostTyLimit")).toFixed(2));
	
	somJxCheckBusinessActivityDataSet.set("manageCostPySum",(setParseFloat("管理费用1")+setParseFloat("管理费用2")).toFixed(2));
	somJxCheckBusinessActivityDataSet.set("manageCostTySum",(setParseFloat("管理费用3")+setParseFloat("管理费用4")).toFixed(2));
	somJxCheckBusinessActivityDataSet.set("raisingCostPySum",(setParseFloat("筹资费用1")+setParseFloat("筹资费用2")).toFixed(2));	
	somJxCheckBusinessActivityDataSet.set("raisingCostTySum",(setParseFloat("筹资费用3")+setParseFloat("筹资费用4")).toFixed(2));	
	somJxCheckBusinessActivityDataSet.set("otherCostPySum",(setParseFloat("其他费用1")+setParseFloat("其他费用2")).toFixed(2));	
	somJxCheckBusinessActivityDataSet.set("otherCostTySum",(setParseFloat("其他费用3")+setParseFloat("其他费用4")).toFixed(2));	
	
	somJxCheckBusinessActivityDataSet.set("costSumPyUnlimit",(somJxCheckBusinessActivityDataSet.get("businessCostPyUnlimit")+setParseFloat("管理费用1")+setParseFloat("筹资费用1")+setParseFloat("其他费用1")).toFixed(2));		
	somJxCheckBusinessActivityDataSet.set("costSumPyLimit",(somJxCheckBusinessActivityDataSet.get("businessCostPyLimit")+setParseFloat("管理费用2")+setParseFloat("筹资费用2")+setParseFloat("其他费用2")).toFixed(2));		
	somJxCheckBusinessActivityDataSet.set("costSumPySum",(somJxCheckBusinessActivityDataSet.get("businessCostPySun")+somJxCheckBusinessActivityDataSet.get("manageCostPySum")+somJxCheckBusinessActivityDataSet.get("raisingCostPySum")+somJxCheckBusinessActivityDataSet.get("otherCostPySum")).toFixed(2));
	somJxCheckBusinessActivityDataSet.set("costSumTyUnlimit",(somJxCheckBusinessActivityDataSet.get("businessCostTyUnlimit")+setParseFloat("管理费用3")+setParseFloat("筹资费用3")+setParseFloat("其他费用3")).toFixed(2));		
	somJxCheckBusinessActivityDataSet.set("costSumTyLimit",(somJxCheckBusinessActivityDataSet.get("businessCostTyLimit")+setParseFloat("管理费用4")+setParseFloat("筹资费用4")+setParseFloat("其他费用4")).toFixed(2));		
	somJxCheckBusinessActivityDataSet.set("costSumTySum",(somJxCheckBusinessActivityDataSet.get("businessCostTySum")+somJxCheckBusinessActivityDataSet.get("manageCostTySum")+somJxCheckBusinessActivityDataSet.get("raisingCostTySum")+somJxCheckBusinessActivityDataSet.get("otherCostTySum")).toFixed(2));
	
	somJxCheckBusinessActivityDataSet.set("limitToUnlimitPySum",(setParseFloat("限定性净资产转为非限定性净资产1")+setParseFloat("限定性净资产转为非限定性净资产2")).toFixed(2));
	somJxCheckBusinessActivityDataSet.set("limitToUnlimitTySum",(setParseFloat("限定性净资产转为非限定性净资产3")+setParseFloat("限定性净资产转为非限定性净资产4")).toFixed(2));
	somJxCheckBusinessActivityDataSet.set("assetsChangePySum",(setParseFloat("净资产变动额1")+setParseFloat("净资产变动额2")).toFixed(2));
	somJxCheckBusinessActivityDataSet.set("assetsChangeTySum",(setParseFloat("净资产变动额3")+setParseFloat("净资产变动额4")).toFixed(2));
}
function setParseFloat(id){
	var value = document.getElementById(id).value;
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
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckbusinessactivity.dao.SomJxCheckBusinessActivity"></model:record>
	</model:dataset>
</model:datasets>
<div id="float">
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageM('8')"/>
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageM('10')"/>
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="backM();"/>	
</div>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center
	style='margin-left: 0cm; text-align: center; text-indent: 0cm; line-height: 150%; mso-list: l0 level1 lfo1'><![if !supportLists]><b
	style='mso-bidi-font-weight: normal'><span lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; line-height: 150%; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312; mso-bidi-font-family: 仿宋_GB2312'><span
	style='mso-list: Ignore'></span></span></b><![endif]><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; line-height: 150%; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>2.业务活动表<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal align=right
	style='text-align: center; line-height: 150%'><span lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; line-height: 150%; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
	style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; line-height: 150%; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>单位：元<span
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
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>项<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>目<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38 rowspan=2
			style='width: 1.0cm; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>行次<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=189 colspan=3
			style='width: 5.0cm; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>上年累计数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=197 colspan=3
			style='width: 147.9pt; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: none; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>本年累计数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 1'>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>非限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=57
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=57
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=76
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>非限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=66
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=55
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 2'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>一、收<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 3'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>其中：捐赠收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>1<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="donationIncomePyUnlimit" id="捐赠收入1" name='"其中：捐赠收入"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="donationIncomePyLimit" id="捐赠收入2" name='"其中：捐赠收入"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="donationIncomePySum" name='"其中：捐赠收入"' style="width:98%" maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="donationIncomeTyUnlimit" id="捐赠收入3" name='"其中：捐赠收入"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="donationIncomeTyLimit" id="捐赠收入4" name='"其中：捐赠收入"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="donationIncomeTySum" name='"其中：捐赠收入"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 4'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>会费收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>2<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="duesIncomePyUnlimit" id="会费收入1" name='"会费收入"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="duesIncomePyLimit" id="会费收入2" name='"会费收入"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="duesIncomePySum" name='"会费收入"' style="width:98%" maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="duesIncomeTyUnlimit" id="会费收入3" name='"会费收入"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="duesIncomeTyLimit" id="会费收入4" name='"会费收入"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="duesIncomeTySum" name='"会费收入"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 5'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>提供服务收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>3<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="serviceIncomePyUnlimit" id="提供服务收入1" name='"提供服务收入"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="serviceIncomePyLimit" id="提供服务收入2" name='"提供服务收入"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="serviceIncomePySum" name='"提供服务收入"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="serviceIncomeTyUnlimit" id="提供服务收入3" name='"提供服务收入"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="serviceIncomeTyLimit" id="提供服务收入4" name='"提供服务收入"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="serviceIncomeTySum" name='"提供服务收入"' style="width:98%"  maxlength="8" style='text-align:right'></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 6'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
			style='mso-spacerun: yes'>&nbsp; </span></span><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>其中：政府购买服务收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>3.1<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="govBuyPyUnlimit" id="政府购买服务收入1" name='"其中：政府购买服务收入"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="govBuyPyLimit" id="政府购买服务收入2" name='"其中：政府购买服务收入"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="govBuyPySum" name='"其中：政府购买服务收入"' style="width:98%" maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="govBuyTyUnlimit" id="政府购买服务收入3" name='"其中：政府购买服务收入"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="govBuyTyLimit" id="政府购买服务收入4" name='"其中：政府购买服务收入"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="govBuyTySum" name='"其中：政府购买服务收入"' style="width:98%" maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 7'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>商品销售收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>4<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="productIncomePyUnlimit" id="商品销售收入1" name='"商品销售收入"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="productIncomePyLimit" id="商品销售收入2" name='"商品销售收入"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="productIncomePySum" name='"商品销售收入"' style="width:98%" maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="productIncomeTyUnlimit" id="商品销售收入3" name='"商品销售收入"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="productIncomeTyLimit" id="商品销售收入4" name='"商品销售收入"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="productIncomeTySum" name='"商品销售收入"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 8'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>政府补助收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>5<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="govGrantsPyUnlimit" id="政府补助收入1" name='"政府补助收入"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="govGrantsPyLimit" id="政府补助收入2" name='"政府补助收入"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="govGrantsPySum" name='"政府补助收入"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="govGrantsTyUnlimit" id="政府补助收入3" name='"政府补助收入"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="govGrantsTyLimit" id="政府补助收入4" name='"政府补助收入"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="govGrantsTySum" name='"政府补助收入"' style="width:98%" maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 9'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>投资收益<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>6<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="invIncomePyUnlimit" id="投资收益1" name='"投资收益"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="invIncomePyLimit" id="投资收益2" name='"投资收益"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="invIncomePySum" name='"投资收益"' style="width:98%" maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="invIncomeTyUnlimit" id="投资收益3" name='"投资收益"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="invIncomeTyLimit" id="投资收益4" name='"投资收益"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="invIncomeTySum" name='"投资收益"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 10'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>其他收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>9<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="otherIncomePyUnlimit" id="其他收入1" name='"其他收入"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="otherIncomePyLimit" id="其他收入2" name='"其他收入"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="otherIncomePySum" name='"其他收入"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="otherIncomeTyUnlimit" id="其他收入3" name='"其他收入"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="otherIncomeTyLimit" id="其他收入4" name='"其他收入"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="otherIncomeTySum" name='"其他收入"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 11'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 28.0pt; mso-char-indent-count: 2.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>收入合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>11<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="incomeSumPyUnlimit" name='"收入合计"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="incomeSumPyLimit" name='"收入合计"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="incomeSumPySum" name='"收入合计"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="incomeSumTyUnlimit" name='"收入合计"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="incomeSumTyLimit" name='"收入合计"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="incomeSumTySum" name='"收入合计"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 12'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>二、费<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 13'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>（一）业务活动成本<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>12<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="businessCostPyUnlimit" name='"业务活动成本"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="businessCostPyLimit" name='"业务活动成本"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="businessCostPySun" name='"业务活动成本"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="businessCostTyUnlimit" name='"业务活动成本"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="businessCostTyLimit" name='"业务活动成本"' style="width:98%" maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="businessCostTySum" name='"业务活动成本"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p> 
		</td>
	</tr>
	<tr style='mso-yfti-irow: 14'>
		<td width=223 valign=top
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>其中：人员费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>13<o:p></o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="staffCostPyUnlimit" id="人员费用1" name='"人员费用"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="staffCostPyLimit" id="人员费用2" name='"人员费用"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="staffCostPySum" name='"人员费用"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="staffCostTyUnlimit" id="人员费用3" name='"人员费用"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 valign=top
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="staffCostTyLimit" id="人员费用4" name='"人员费用"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 valign=top
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="staffCostTySum" name='"人员费用"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 15'>
		<td width=223 valign=top
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>日常费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>14<o:p></o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="runningCostPyUnlimit" id="日常费用1" name='"日常费用"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="runningCostPyLimit" id="日常费用2" name='"日常费用"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="runningCostPySum" name='"日常费用"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="runningCostTyUnlimit" id="日常费用3" name='"日常费用"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 valign=top
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="runningCostTyLimit" id="日常费用4" name='"日常费用"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 valign=top
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="runningCostTySum" name='"日常费用"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 16'>
		<td width=223 valign=top
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>固定资产折旧<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>15<o:p></o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="depreciationAssetsPyUnlimit" id="固定资产折旧1" name='"固定资产折旧"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="depreciationAssetsPyLimit" id="固定资产折旧2" name='"固定资产折旧"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="depreciationAssetsPySum" id="" name='"固定资产折旧"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="depreciationAssetsTyUnlimit" id="固定资产折旧3" name='"固定资产折旧"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 valign=top
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="depreciationAssetsTyLimit" id="固定资产折旧4" name='"固定资产折旧"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 valign=top
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="depreciationAssetsTySum" name='"固定资产折旧"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 17'>
		<td width=223 valign=top
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>税费<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>16<o:p></o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="taxesPyUnlimit" id="税费1" name='"税费"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
		</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="taxesPyLimit" id="税费2" name='"税费"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 valign=top
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="taxesPySum" id="" name='"税费"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=76 valign=top
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="taxesTyUnlimit" id="税费3" name='"税费"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 valign=top
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="taxesTyLimit" id="税费4" name='"税费"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 valign=top
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="taxesTySum" id="" name='"税费"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 18'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>（二）管理费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>21<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="manageCostPyUnlimit" id="管理费用1" name='"管理费用"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="manageCostPyLimit" id="管理费用2" name='"管理费用"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="manageCostPySum" name='"管理费用"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="manageCostTyUnlimit" id="管理费用3" name='"管理费用"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="manageCostTyLimit" id="管理费用4" name='"管理费用"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="manageCostTySum" name='"管理费用"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 19'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>（三）筹资费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>24<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="raisingCostPyUnlimit" id="筹资费用1" name='"筹资费用"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="raisingCostPyLimit" id="筹资费用2" name='"筹资费用"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="raisingCostPySum" name='"筹资费用"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="raisingCostTyUnlimit" id="筹资费用3" name='"筹资费用"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="raisingCostTyLimit" id="筹资费用4" name='"筹资费用"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="raisingCostTySum" name='"筹资费用"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 20'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>（四）其他费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>28<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="otherCostPyUnlimit" id="其他费用1" name='"其他费用"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="otherCostPyLimit" id="其他费用2" name='"其他费用"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="otherCostPySum" name='"其他费用"' style="width:98%;text-align:right"  ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="otherCostTyUnlimit" id="其他费用3" name='"其他费用"' style="width:98%;text-align:right" onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="otherCostTyLimit" id="其他费用4" name='"其他费用"' style="width:98%;text-align:right"  onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="otherCostTySum" name='"其他费用"' style="width:98%;text-align:right"  ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 21'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='text-indent: 28.0pt; mso-char-indent-count: 2.0; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>费用合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>35<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="costSumPyUnlimit" name='"费用合计"' style="width:98%;text-align:right"  ></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="costSumPyLimit" name='"费用合计"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " ></label>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="costSumPySum"  name='"费用合计"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="costSumTyUnlimit"  name='"费用合计"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="costSumTyLimit"  name='"费用合计"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p> 
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="costSumTySum"  name='"费用合计"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 22'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>三、限定性净资产转为非限定性净资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>40<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="limitToUnlimitPyUnlimt" id="限定性净资产转为非限定性净资产1" name='"限定性净资产转为非限定性净资产"' style="width:98%" maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() " />
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="limitToUnlimitPyLimit" id="限定性净资产转为非限定性净资产2" name='"限定性净资产转为非限定性净资产"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="limitToUnlimitPySum" name='"限定性净资产转为非限定性净资产"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="limitToUnlimitTyUnlimit" id="限定性净资产转为非限定性净资产3" name='"限定性净资产转为非限定性净资产"' style="width:98%;text-align:right"  onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="limitToUnlimitTyLimit" id="限定性净资产转为非限定性净资产4" name='"限定性净资产转为非限定性净资产"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="limitToUnlimitTySum" name='"限定性净资产转为非限定性净资产"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
	</tr>
	<tr style='mso-yfti-irow: 23; mso-yfti-lastrow: yes'>
		<td width=223 
			style='width: 167.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; mso-border-right-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>四、净资产变动额</span><tt><span
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>（若为净资产减少额，以“<span
			lang=EN-US>-</span>”号填列）</span></tt><span lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p></o:p></span></p>
		</td>
		<td width=38
			style='width: 1.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>45<o:p></o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="assetsChangePyUnlimit" id="净资产变动额1" name='"净资产变动额"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.5pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="assetsChangePyLimit" id="净资产变动额2" name='"净资产变动额"' style="width:98%"  maxlength="8" style='text-align:right' onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=57 
			style='width: 42.55pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="assetsChangePySum" name='"净资产变动额"' style="width:98%"  maxlength="8" style='text-align:right' ></label>
			</o:p></span></p>
		</td>
		<td width=76 
			style='width: 2.0cm; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="assetsChangeTyUnlimit" id="净资产变动额3" name='"净资产变动额"' style="width:98%" maxlength="8" style='text-align:right'  onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=66 
			style='width: 49.6pt; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<input field="assetsChangeTyLimit" id="净资产变动额4" name='"净资产变动额"' style="width:98%" maxlength="8" style='text-align:right' style='text-align:right'  onkeyup="value=value.replace(/[^\d.]/g,'');setSumMoney() "/>
			</o:p></span></p>
		</td>
		<td width=55 
			style='width: 41.6pt; border: none; border-bottom: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt'>
		<p class=MsoNormal
			style='line-height: 22.0pt; mso-line-height-rule: exactly'><span
			lang=EN-US
			style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><o:p>
			<label field="assetsChangeTySum" name='"净资产变动额"' style="width:98%" maxlength="8" style='text-align:right'  ></label>
			</o:p></span></p>
		</td>
	</tr>
</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>
