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
				var somCheckBusinessActivityDataSet = L5.DatasetMgr.lookup("somCheckBusinessActivityDataSet");
				somCheckBusinessActivityDataSet.setParameter("TASK_CODE@=", taskCode);
				somCheckBusinessActivityDataSet.load();
				somCheckBusinessActivityDataSet.on('load',function(){
					var count = somCheckBusinessActivityDataSet.getCount();
					if(count == 0){
						somCheckBusinessActivityDataSet.newRecord({"taskCode":taskCode});
					}
					somCheckDataSet.setParameter("TASK_CODE", taskCode);
					somCheckDataSet.load();
					somCheckDataSet.on("load",function(){
						somCheckBusinessActivityDataSet.set("organizationUnit",somCheckDataSet.get("cnName"));
					});
				});
				//创建页面导航下拉框
				createGroupEditSelect();
			}
			function save(){
				var somCheckBusinessActivityDataSetIsValidate = somCheckBusinessActivityDataSet.isValidate();
				if(somCheckBusinessActivityDataSetIsValidate!=true){
					L5.Msg.alert("提示",somCheckBusinessActivityDataSetIsValidate);
					return "break";
				}
				var record=somCheckBusinessActivityDataSet.getCurrent();
				var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
				command.setParameter("record", record);
				command.setParameter("taskCode", taskCode);
				command.execute("savePage6");
				if (!command.error) {
					alert("保存成功！");
				}else{
					L5.Msg.alert('提示',"保存时出现错误！"+command.error);
				}
			}
			function saveNoCheck(){
				var record=somCheckBusinessActivityDataSet.getCurrent();
				var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
				command.setParameter("record", record);
				command.setParameter("taskCode", taskCode);
				command.execute("savePage6");
				if (!command.error) {
					alert("保存成功！");
				}else{
					L5.Msg.alert('提示',"保存时出现错误！"+command.error);
				}
			}
function setSumMoney(){
	somCheckBusinessActivityDataSet.set("donationIncomePySum",(setParseFloat("捐赠收入1")+setParseFloat("捐赠收入2")).toFixed(2)*1);
	somCheckBusinessActivityDataSet.set("donationIncomeTySum",(setParseFloat("捐赠收入3")+setParseFloat("捐赠收入4")).toFixed(2)*1);
	somCheckBusinessActivityDataSet.set("duesIncomePySum",(setParseFloat("会费收入1")+setParseFloat("会费收入2")).toFixed(2)*1);	
	somCheckBusinessActivityDataSet.set("duesIncomeTySum",(setParseFloat("会费收入3")+setParseFloat("会费收入4")).toFixed(2)*1);		
	somCheckBusinessActivityDataSet.set("serviceIncomePySum",(setParseFloat("提供服务收入1")+setParseFloat("提供服务收入2")).toFixed(2)*1);		
	somCheckBusinessActivityDataSet.set("serviceIncomeTySum",(setParseFloat("提供服务收入3")+setParseFloat("提供服务收入4")).toFixed(2)*1);				
	//somCheckBusinessActivityDataSet.set("govBuyPySum",(setParseFloat("政府购买服务收入1")+setParseFloat("政府购买服务收入2")).toFixed(2)*1);						
	//somCheckBusinessActivityDataSet.set("govBuyTySum",(setParseFloat("政府购买服务收入2")+setParseFloat("政府购买服务收入3")).toFixed(2)*1);								
	somCheckBusinessActivityDataSet.set("productIncomePySum",(setParseFloat("商品销售收入1")+setParseFloat("商品销售收入2")).toFixed(2)*1);										
	somCheckBusinessActivityDataSet.set("productIncomeTySum",(setParseFloat("商品销售收入3")+setParseFloat("商品销售收入4")).toFixed(2)*1);										
	somCheckBusinessActivityDataSet.set("govGrantsPySum",(setParseFloat("政府补助收入1")+setParseFloat("政府补助收入2")).toFixed(2)*1);
	somCheckBusinessActivityDataSet.set("govGrantsTySum",(setParseFloat("政府补助收入3")+setParseFloat("政府补助收入4")).toFixed(2)*1);
	somCheckBusinessActivityDataSet.set("invIncomePySum",(setParseFloat("投资收益1")+setParseFloat("投资收益2")).toFixed(2)*1);	
	somCheckBusinessActivityDataSet.set("invIncomeTySum",(setParseFloat("投资收益3")+setParseFloat("投资收益4")).toFixed(2)*1);		
	somCheckBusinessActivityDataSet.set("otherIncomePySum",(setParseFloat("其他收入1")+setParseFloat("其他收入2")).toFixed(2)*1);			
	somCheckBusinessActivityDataSet.set("otherIncomeTySum",(setParseFloat("其他收入3")+setParseFloat("其他收入4")).toFixed(2)*1);				
			
	somCheckBusinessActivityDataSet.set("incomeSumPyUnlimit",(setParseFloat("捐赠收入1")+setParseFloat("会费收入1")+setParseFloat("提供服务收入1")+setParseFloat("商品销售收入1")+setParseFloat("政府补助收入1")+setParseFloat("投资收益1")+setParseFloat("其他收入1")).toFixed(2)*1);
	somCheckBusinessActivityDataSet.set("incomeSumPyLimit",(setParseFloat("捐赠收入2")+setParseFloat("会费收入2")+setParseFloat("提供服务收入2")+setParseFloat("商品销售收入2")+setParseFloat("政府补助收入2")+setParseFloat("投资收益2")+setParseFloat("其他收入2")).toFixed(2)*1);
	somCheckBusinessActivityDataSet.set("incomeSumPySum",(getParseFloat(somCheckBusinessActivityDataSet.get("incomeSumPyUnlimit"))+getParseFloat(somCheckBusinessActivityDataSet.get("incomeSumPyLimit"))).toFixed(2)*1);
	somCheckBusinessActivityDataSet.set("incomeSumTyUnlimit",(setParseFloat("捐赠收入3")+setParseFloat("会费收入3")+setParseFloat("提供服务收入3")+setParseFloat("商品销售收入3")+setParseFloat("政府补助收入3")+setParseFloat("投资收益3")+setParseFloat("其他收入3")).toFixed(2)*1);
	somCheckBusinessActivityDataSet.set("incomeSumTyLimit",(setParseFloat("捐赠收入4")+setParseFloat("会费收入4")+setParseFloat("提供服务收入4")+setParseFloat("商品销售收入4")+setParseFloat("政府补助收入4")+setParseFloat("投资收益4")+setParseFloat("其他收入4")).toFixed(2)*1);
	somCheckBusinessActivityDataSet.set("incomeSumTySum",(getParseFloat(somCheckBusinessActivityDataSet.get("incomeSumTyUnlimit"))+getParseFloat(somCheckBusinessActivityDataSet.get("incomeSumTyLimit"))).toFixed(2)*1);
	
	somCheckBusinessActivityDataSet.set("staffCostPySum",(setParseFloat("人员费用1")+setParseFloat("人员费用2")).toFixed(2)*1);
	somCheckBusinessActivityDataSet.set("staffCostTySum",(setParseFloat("人员费用3")+setParseFloat("人员费用4")).toFixed(2)*1);
	somCheckBusinessActivityDataSet.set("runningCostPySum",(setParseFloat("日常费用1")+setParseFloat("日常费用2")).toFixed(2)*1);
	somCheckBusinessActivityDataSet.set("runningCostTySum",(setParseFloat("日常费用3")+setParseFloat("日常费用4")).toFixed(2)*1);	
	somCheckBusinessActivityDataSet.set("depreciationAssetsPySum",(setParseFloat("固定资产折旧1")+setParseFloat("固定资产折旧2")).toFixed(2)*1);		
	somCheckBusinessActivityDataSet.set("depreciationAssetsTySum",(setParseFloat("固定资产折旧3")+setParseFloat("固定资产折旧4")).toFixed(2)*1);		
	somCheckBusinessActivityDataSet.set("taxesPySum",(setParseFloat("税费1")+setParseFloat("税费2")).toFixed(2)*1);		
	somCheckBusinessActivityDataSet.set("taxesTySum",(setParseFloat("税费3")+setParseFloat("税费4")).toFixed(2)*1);	
	
	somCheckBusinessActivityDataSet.set("businessCostPyUnlimit",(setParseFloat("人员费用1")+setParseFloat("日常费用1")+setParseFloat("固定资产折旧1")+setParseFloat("税费1")).toFixed(2)*1);		
	somCheckBusinessActivityDataSet.set("businessCostPyLimit",(setParseFloat("人员费用2")+setParseFloat("日常费用2")+setParseFloat("固定资产折旧2")+setParseFloat("税费2")).toFixed(2)*1);		
	somCheckBusinessActivityDataSet.set("businessCostPySum",(getParseFloat(somCheckBusinessActivityDataSet.get("businessCostPyUnlimit"))+getParseFloat(somCheckBusinessActivityDataSet.get("businessCostPyLimit"))).toFixed(2)*1);
	somCheckBusinessActivityDataSet.set("businessCostTyUnlimit",(setParseFloat("人员费用3")+setParseFloat("日常费用3")+setParseFloat("固定资产折旧3")+setParseFloat("税费3")).toFixed(2)*1);		
	somCheckBusinessActivityDataSet.set("businessCostTyLimit",(setParseFloat("人员费用4")+setParseFloat("日常费用4")+setParseFloat("固定资产折旧4")+setParseFloat("税费4")).toFixed(2)*1);		
	somCheckBusinessActivityDataSet.set("businessCostTySum",(getParseFloat(somCheckBusinessActivityDataSet.get("businessCostTyUnlimit"))+getParseFloat(somCheckBusinessActivityDataSet.get("businessCostTyLimit"))).toFixed(2)*1);
	
	somCheckBusinessActivityDataSet.set("manageCostPySum",(setParseFloat("管理费用1")+setParseFloat("管理费用2")).toFixed(2)*1);
	somCheckBusinessActivityDataSet.set("manageCostTySum",(setParseFloat("管理费用3")+setParseFloat("管理费用4")).toFixed(2)*1);
	somCheckBusinessActivityDataSet.set("raisingCostPySum",(setParseFloat("筹资费用1")+setParseFloat("筹资费用2")).toFixed(2)*1);	
	somCheckBusinessActivityDataSet.set("raisingCostTySum",(setParseFloat("筹资费用3")+setParseFloat("筹资费用4")).toFixed(2)*1);	
	somCheckBusinessActivityDataSet.set("otherCostPySum",(setParseFloat("其他费用1")+setParseFloat("其他费用2")).toFixed(2)*1);	
	somCheckBusinessActivityDataSet.set("otherCostTySum",(setParseFloat("其他费用3")+setParseFloat("其他费用4")).toFixed(2)*1);	
	
	somCheckBusinessActivityDataSet.set("costSumPyUnlimit",(getParseFloat(somCheckBusinessActivityDataSet.get("businessCostPyUnlimit"))+setParseFloat("管理费用1")+setParseFloat("筹资费用1")+setParseFloat("其他费用1")).toFixed(2)*1);		
	somCheckBusinessActivityDataSet.set("costSumPyLimit",(getParseFloat(somCheckBusinessActivityDataSet.get("businessCostPyLimit"))+setParseFloat("管理费用2")+setParseFloat("筹资费用2")+setParseFloat("其他费用2")).toFixed(2)*1);		
	somCheckBusinessActivityDataSet.set("costSumPySum",(getParseFloat(somCheckBusinessActivityDataSet.get("businessCostPySum"))+getParseFloat(somCheckBusinessActivityDataSet.get("manageCostPySum"))+getParseFloat(somCheckBusinessActivityDataSet.get("raisingCostPySum"))+getParseFloat(somCheckBusinessActivityDataSet.get("otherCostPySum"))).toFixed(2)*1);
	somCheckBusinessActivityDataSet.set("costSumTyUnlimit",(getParseFloat(somCheckBusinessActivityDataSet.get("businessCostTyUnlimit"))+setParseFloat("管理费用3")+setParseFloat("筹资费用3")+setParseFloat("其他费用3")).toFixed(2)*1);		
	somCheckBusinessActivityDataSet.set("costSumTyLimit",(getParseFloat(somCheckBusinessActivityDataSet.get("businessCostTyLimit"))+setParseFloat("管理费用4")+setParseFloat("筹资费用4")+setParseFloat("其他费用4")).toFixed(2)*1);		
	somCheckBusinessActivityDataSet.set("costSumTySum",(getParseFloat(somCheckBusinessActivityDataSet.get("businessCostTySum"))+getParseFloat(somCheckBusinessActivityDataSet.get("manageCostTySum"))+getParseFloat(somCheckBusinessActivityDataSet.get("raisingCostTySum"))+getParseFloat(somCheckBusinessActivityDataSet.get("otherCostTySum"))).toFixed(2)*1);
	
	somCheckBusinessActivityDataSet.set("limitToUnlimitPySum",(setParseFloat("限定性净资产转为非限定性净资产1")+setParseFloat("限定性净资产转为非限定性净资产2")).toFixed(2)*1);
	somCheckBusinessActivityDataSet.set("limitToUnlimitTySum",(setParseFloat("限定性净资产转为非限定性净资产3")+setParseFloat("限定性净资产转为非限定性净资产4")).toFixed(2)*1);
	
	somCheckBusinessActivityDataSet.set("assetsChangePyUnlimit",(getParseFloat(somCheckBusinessActivityDataSet.get("incomeSumPyUnlimit"))-getParseFloat(somCheckBusinessActivityDataSet.get("costSumPyUnlimit"))).toFixed(2)*1);
	somCheckBusinessActivityDataSet.set("assetsChangePyLimit",(getParseFloat(somCheckBusinessActivityDataSet.get("incomeSumPyLimit"))-getParseFloat(somCheckBusinessActivityDataSet.get("costSumPyLimit"))).toFixed(2)*1);
	somCheckBusinessActivityDataSet.set("assetsChangePySum",(getParseFloat(somCheckBusinessActivityDataSet.get("assetsChangePyUnlimit"))+getParseFloat(somCheckBusinessActivityDataSet.get("assetsChangePyLimit"))).toFixed(2)*1);
	somCheckBusinessActivityDataSet.set("assetsChangeTyUnlimit",(getParseFloat(somCheckBusinessActivityDataSet.get("incomeSumTyUnlimit"))-getParseFloat(somCheckBusinessActivityDataSet.get("costSumTyUnlimit"))).toFixed(2)*1);
	somCheckBusinessActivityDataSet.set("assetsChangeTyLimit",(getParseFloat(somCheckBusinessActivityDataSet.get("incomeSumTyLimit"))-getParseFloat(somCheckBusinessActivityDataSet.get("costSumTyLimit"))).toFixed(2)*1);
	somCheckBusinessActivityDataSet.set("assetsChangeTySum",(getParseFloat(somCheckBusinessActivityDataSet.get("assetsChangeTyUnlimit"))+getParseFloat(somCheckBusinessActivityDataSet.get("assetsChangeTyLimit"))).toFixed(2)*1);
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
	<model:dataset id="somCheckBusinessActivityDataSet"
		cmd="com.inspur.cams.sorg.check.businessactivity.cmd.SomCheckBusinessActivityQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.sorg.check.businessactivity.data.SomCheckBusinessActivity">
			<model:field name="organizationUnit" type="string" rule="require" />
			<model:field name="donationIncomePyUnlimit" type="string" rule="require" />
			<model:field name="donationIncomePyLimit" type="string" rule="require" />			
			<model:field name="donationIncomeTyUnlimit" type="string" rule="require" />
			<model:field name="donationIncomeTyLimit" type="string" rule="require" />			
			<model:field name="duesIncomePyUnlimit" type="string" rule="require" />
			<model:field name="duesIncomePyLimit" type="string" rule="require" />			
			<model:field name="duesIncomeTyUnlimit" type="string" rule="require" />
			<model:field name="duesIncomeTyLimit" type="string" rule="require" />			
			<model:field name="serviceIncomePyUnlimit" type="string" rule="require" />
			<model:field name="serviceIncomePyLimit" type="string" rule="require" />			
			<model:field name="serviceIncomeTyUnlimit" type="string" rule="require" />
			<model:field name="serviceIncomeTyLimit" type="string" rule="require" />			
			<model:field name="productIncomePyUnlimit" type="string" rule="require" />
			<model:field name="productIncomePyLimit" type="string" rule="require" />			
			<model:field name="productIncomeTyUnlimit" type="string" rule="require" />
			<model:field name="productIncomeTyLimit" type="string" rule="require" />			
			<model:field name="govGrantsPyUnlimit" type="string" rule="require" />
			<model:field name="govGrantsPyLimit" type="string" rule="require" />			
			<model:field name="govGrantsTyUnlimit" type="string" rule="require" />
			<model:field name="govGrantsTyLimit" type="string" rule="require" />			
			<model:field name="invIncomePyUnlimit" type="string" rule="require" />
			<model:field name="invIncomePyLimit" type="string" rule="require" />
			<model:field name="invIncomeTyUnlimit" type="string" rule="require" />
			<model:field name="invIncomeTyLimit" type="string" rule="require" />
			<model:field name="otherIncomePyUnlimit" type="string" rule="require" />
			<model:field name="otherIncomePyLimit" type="string" rule="require" />
			<model:field name="otherIncomeTyUnlimit" type="string" rule="require" />
			<model:field name="otherIncomeTyLimit" type="string" rule="require" />			
			<model:field name="staffCostPyUnlimit" type="string" rule="require" />
			<model:field name="staffCostPyLimit" type="string" rule="require" />
			<model:field name="staffCostTyUnlimit" type="string" rule="require" />
			<model:field name="staffCostTyLimit" type="string" rule="require" />
			<model:field name="runningCostPyUnlimit" type="string" rule="require" />
			<model:field name="runningCostPyLimit" type="string" rule="require" />
			<model:field name="runningCostTyUnlimit" type="string" rule="require" />
			<model:field name="runningCostTyLimit" type="string" rule="require" />
			<model:field name="depreciationAssetsPyUnlimit" type="string" rule="require" />
			<model:field name="depreciationAssetsPyLimit" type="string" rule="require" />
			<model:field name="depreciationAssetsTyUnlimit" type="string" rule="require" />
			<model:field name="depreciationAssetsTyLimit" type="string" rule="require" />
			<model:field name="taxesPyUnlimit" type="string" rule="require" />
			<model:field name="taxesPyLimit" type="string" rule="require" />
			<model:field name="taxesTyUnlimit" type="string" rule="require" />
			<model:field name="taxesTyLimit" type="string" rule="require" />
			<model:field name="manageCostPyUnlimit" type="string" rule="require" />
			<model:field name="manageCostPyLimit" type="string" rule="require" />
			<model:field name="manageCostTyUnlimit" type="string" rule="require" />
			<model:field name="manageCostTyLimit" type="string" rule="require" />
			<model:field name="raisingCostPyUnlimit" type="string" rule="require" />
			<model:field name="raisingCostPyLimit" type="string" rule="require" />
			<model:field name="raisingCostTyUnlimit" type="string" rule="require" />
			<model:field name="raisingCostTyLimit" type="string" rule="require" />
			<model:field name="otherCostPyUnlimit" type="string" rule="require" />
			<model:field name="otherCostPyLimit" type="string" rule="require" />
			<model:field name="otherCostTyUnlimit" type="string" rule="require" />
			<model:field name="otherCostTyLimit" type="string" rule="require" />
			<model:field name="limitToUnlimitPyUnlimt" type="string" rule="require" />
			<model:field name="limitToUnlimitPyLimit" type="string" rule="require" />
			<model:field name="limitToUnlimitTyUnlimit" type="string" rule="require" />
			<model:field name="limitToUnlimitTyLimit" type="string" rule="require" />
			<model:field name="remainingBalanceTy" type="string" rule="require" />
			</model:record>
	</model:dataset>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck">
		</model:record>
	</model:dataset>
</model:datasets>
<div id="float"><!--[if lte IE 7]><div></div><![endif]--> 
<input
	type="button" value="上一页"
	style="height: 25px; width: 80px; position: absolute; margin-left: 20px;"
	onclick="lastPage('5')" />
<input
	type="button" value="下一页"
	style="height: 25px; width: 80px; position: absolute; margin-left: 120px;"
	onclick="nextPage('7')" /> <!--[if lte IE 7]><div></div><![endif]--> <input
	type="button" value="保存"
	style="height: 25px; width: 80px; position: absolute; margin-left: 220px;"
	onclick="saveNoCheck();" /> <!--[if lte IE 7]><div></div><![endif]--> <input
	type="button" value="返回"
	style="height: 25px; width: 80px; position: absolute; margin-left: 320px;"
	onclick="back();" />
	<!--[if lte IE 7]><div></div><![endif]-->
	<span style="height:25px;width:80px;position:absolute;margin-left:420px;">当前页数：8</span>
	</div>
<div align=center width="800">
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=center
	style='text-align: center; line-height: 21.0pt; mso-line-height-rule: exactly'><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 16.0pt; font-family: 宋体; color: black'>（二）业务活动表<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal align=center
	style='text-align: center; line-height: 21.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 16.0pt; font-family: 宋体; color: black'>（截止到本年度12月31日）<span
	lang=EN-US></span><span lang=EN-US></span><span lang=EN-US><o:p></o:p></span></span></p>

<form method="post" dataset="somCheckBusinessActivityDataSet" onsubmit="return false">
<p style='margin: 0 auto; line-height: 20.0pt;'><span
	style='font-size: 14.0pt; font-family: 宋体; color: black'>编制单位： 
	<input type="text" name='编制单位' field="organizationUnit" style="width: 240" maxlength="250" /> 
	<span lang=EN-US><span
	style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span>
单位：元<span lang=EN-US><o:p></o:p></span></span></p>
<table border=1 cellspacing=0 cellpadding=0 width="800"
	style='border-collapse: collapse; border: none; mso-border-top-alt: solid windowtext 1.5pt; mso-border-bottom-alt: solid windowtext 1.5pt; mso-yfti-tbllook: 480; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext'>
	<tr style='page-break-inside: avoid; height: 20.35pt'>
		<td width="28%" rowspan=2
			style='width: 28.84%; border-top: 1.5pt; border-left: 1.5pt; border-bottom: 1.0pt; border-right: 1.0pt; border-color: windowtext; border-style: solid; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 20.35pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>项<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>目<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="35%" colspan=3
			style='width: 35.58%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 20.35pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>上年度年末数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="35%" colspan=3
			style='width: 35.58%; border-top: solid windowtext 1.5pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: 1.5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 20.35pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>本年度累计数<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='page-break-inside: avoid; height: 22.3pt'>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 1.4pt 0cm 1.4pt; height: 22.3pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>非限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 22.3pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 22.3pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 1.4pt 0cm 1.4pt; height: 22.3pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>非限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 22.3pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>限定性<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 22.3pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>一、收<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>其中：捐赠收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<input field="donationIncomePyUnlimit" id="捐赠收入1" name='"其中：捐赠收入"' 
		style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<input field="donationIncomePyLimit" id="捐赠收入2" name='"其中：捐赠收入"' 
		style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label field="donationIncomePySum" name='"其中：捐赠收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<input field="donationIncomeTyUnlimit" id="捐赠收入3" name='"其中：捐赠收入"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
		<input field="donationIncomeTyLimit" id="捐赠收入4" name='"其中：捐赠收入"' 
		style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label field="donationIncomeTySum" name='"其中：捐赠收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</p>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal
			style='text-indent: 36.0pt; mso-char-indent-count: 3.0'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>会费收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
		<input field="duesIncomePyUnlimit" id="会费收入1" name='"会费收入"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<input field="duesIncomePyLimit" id="会费收入2" name='"会费收入"' 
		style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label field="duesIncomePySum" name='"会费收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<input field="duesIncomeTyUnlimit" id="会费收入3" name='"会费收入"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<input field="duesIncomeTyLimit" id="会费收入4" name='"会费收入"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label field="duesIncomeTySum" name='"会费收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</p>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal
			style='text-indent: 36.0pt; mso-char-indent-count: 3.0'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>提供服务收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<input field="serviceIncomePyUnlimit" id="提供服务收入1" name='"提供服务收入"' 
		style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<input field="serviceIncomePyLimit" id="提供服务收入2" name='"提供服务收入"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<label field="serviceIncomePySum" name='"提供服务收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
		<input field="serviceIncomeTyUnlimit" id="提供服务收入3" name='"提供服务收入"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
			<input field="serviceIncomeTyLimit" id="提供服务收入4" name='"提供服务收入"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
		<label field="serviceIncomeTySum" name='"提供服务收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;'></label>
		</p>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal
			style='text-indent: 36.0pt; mso-char-indent-count: 3.0'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>商品销售收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
		<input field="productIncomePyUnlimit" id="商品销售收入1" name='"商品销售收入"' 
		style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
		<input field="productIncomePyLimit" id="商品销售收入2" name='"商品销售收入"' 
		style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
		<label field="productIncomePySum" name='"商品销售收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
		<input field="productIncomeTyUnlimit" id="商品销售收入3" name='"商品销售收入"' 
		style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
		<input field="productIncomeTyLimit" id="商品销售收入4" name='"商品销售收入"' 
		style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
		<label field="productIncomeTySum" name='"商品销售收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</p>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal
			style='text-indent: 36.0pt; mso-char-indent-count: 3.0'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>政府补助收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
		<input field="govGrantsPyUnlimit" id="政府补助收入1" name='"政府补助收入"' 
		style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
		<input field="govGrantsPyLimit" id="政府补助收入2" name='"政府补助收入"' 
		style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
		<label field="govGrantsPySum" name='"政府补助收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
		<input field="govGrantsTyUnlimit" id="政府补助收入3" name='"政府补助收入"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
		<input field="govGrantsTyLimit" id="政府补助收入4" name='"政府补助收入"' 
		style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
		<label field="govGrantsTySum" name='"政府补助收入"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</p>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal
			style='text-indent: 36.0pt; mso-char-indent-count: 3.0'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>投资收益<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
		<input field="invIncomePyUnlimit" id="投资收益1" name='"投资收益"' 
		style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
		<input field="invIncomePyLimit" id="投资收益2" name='"投资收益"' 
		style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
		<label field="invIncomePySum" name='"投资收益"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
		<input field="invIncomeTyUnlimit" id="投资收益3" name='"投资收益"' 
		style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal>
		<input field="invIncomeTyLimit" id="投资收益4" name='"投资收益"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="invIncomeTySum" name='"投资收益"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal
			style='text-indent: 36.0pt; mso-char-indent-count: 3.0'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>其他收入<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
			<input field="otherIncomePyUnlimit" id="其他收入1" name='"其他收入"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="otherIncomePyLimit" id="其他收入2" name='"其他收入"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="otherIncomePySum" name='"其他收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="otherIncomeTyUnlimit" id="其他收入3" name='"其他收入"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="otherIncomeTyLimit" id="其他收入4" name='"其他收入"' 
		style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="otherIncomeTySum" name='"其他收入"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal
			style='text-indent: 24.0pt; mso-char-indent-count: 2.0'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>收入合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="incomeSumPyUnlimit" name='"收入合计"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="incomeSumPyLimit" name='"收入合计"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="incomeSumPySum" name='"收入合计"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="incomeSumTyUnlimit" name='"收入合计"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="incomeSumTyLimit" name='"收入合计"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="incomeSumTySum" name='"收入合计"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>二、费<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p>&nbsp;</o:p></span></p>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>（一）业务活动成本<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="businessCostPyUnlimit" name='"业务活动成本"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="businessCostPyLimit" name='"业务活动成本"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
	<label field="businessCostPySum" name='"业务活动成本"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="businessCostTyUnlimit" name='"业务活动成本"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="businessCostTyLimit" name='"业务活动成本"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="businessCostTySum" name='"业务活动成本"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体'>其中：人员费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="staffCostPyUnlimit" id="人员费用1" name='"人员费用"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="staffCostPyLimit" id="人员费用2" name='"人员费用"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="staffCostPySum" name='"人员费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="staffCostTyUnlimit" id="人员费用3" name='"人员费用"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="staffCostTyLimit" id="人员费用4" name='"人员费用"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="staffCostTySum" name='"人员费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-indent: 36.0pt; mso-char-indent-count: 3.0'><span
			style='font-size: 12.0pt; font-family: 宋体'>日常费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="runningCostPyUnlimit" id="日常费用1" name='"日常费用"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="runningCostPyLimit" id="日常费用2" name='"日常费用"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="runningCostPySum" name='"日常费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="runningCostTyUnlimit" id="日常费用3" name='"日常费用"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="runningCostTyLimit" id="日常费用4" name='"日常费用"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="runningCostTySum" name='"日常费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-indent: 24.0pt; mso-char-indent-count: 2.0'><span
			style='font-size: 12.0pt; font-family: 宋体'>固定资产折旧<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="depreciationAssetsPyUnlimit" id="固定资产折旧1" name='"固定资产折旧"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="depreciationAssetsPyLimit" id="固定资产折旧2" name='"固定资产折旧"'
		 style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="depreciationAssetsPySum" id="" name='"固定资产折旧"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="depreciationAssetsTyUnlimit" id="固定资产折旧3" name='"固定资产折旧"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="depreciationAssetsTyLimit" id="固定资产折旧4" name='"固定资产折旧"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="depreciationAssetsTySum" name='"固定资产折旧"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-indent: 48.0pt; mso-char-indent-count: 4.0'><span
			style='font-size: 12.0pt; font-family: 宋体'>税费<span lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="taxesPyUnlimit" id="税费1" name='"税费"' style="width:98%"  
		maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="taxesPyLimit" id="税费2" name='"税费"' style="width:98%"  
		maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>			
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="taxesPySum" id="" name='"税费"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="taxesTyUnlimit" id="税费3" name='"税费"' style="width:98%"  
		maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="taxesTyLimit" id="税费4" name='"税费"' style="width:98%"  
		maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="taxesTySum" id="" name='"税费"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>（二）管理费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="manageCostPyUnlimit" id="管理费用1" name='"管理费用"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="manageCostPyLimit" id="管理费用2" name='"管理费用"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="manageCostPySum" name='"管理费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="manageCostTyUnlimit" id="管理费用3" name='"管理费用"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="manageCostTyLimit" id="管理费用4" name='"管理费用"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="manageCostTySum" name='"管理费用"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>（三）筹资费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="raisingCostPyUnlimit" id="筹资费用1" name='"筹资费用"' 
		style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="raisingCostPyLimit" id="筹资费用2" name='"筹资费用"' 
		style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="raisingCostPySum" name='"筹资费用"' style="width:98%" 
		maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="raisingCostTyUnlimit" id="筹资费用3" name='"筹资费用"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="raisingCostTyLimit" id="筹资费用4" name='"筹资费用"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="raisingCostTySum" name='"筹资费用"' style="width:98%" 
		maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " ></label>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>（四）其他费用<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="otherCostPyUnlimit" id="其他费用1" name='"其他费用"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="otherCostPyLimit" id="其他费用2" name='"其他费用"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="otherCostPySum" name='"其他费用"' style="width:98%;text-align:right;padding-right:2px;"  ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="otherCostTyUnlimit" id="其他费用3" name='"其他费用"' 
		style="width:98%;text-align:right;padding-right:2px;" onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<input field="otherCostTyLimit" id="其他费用4" name='"其他费用"' 
		style="width:98%;text-align:right;padding-right:2px;"  onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="otherCostTySum" name='"其他费用"' style="width:98%;text-align:right;padding-right:2px;"  ></label>
		</td>
	</tr>
	<tr style='height: 21.25pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<p class=MsoNormal align=center
			style='text-align: center; text-indent: 24.0pt; mso-char-indent-count: 2.0'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>费用合计<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="costSumPyUnlimit" name='"费用合计"' style="width:98%;text-align:right;padding-right:2px;"  ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="costSumPyLimit" name='"费用合计"' style="width:98%" maxlength="15" 
		style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="costSumPySum"  name='"费用合计"' style="width:98%" maxlength="15" 
		style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="costSumTyUnlimit"  name='"费用合计"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="costSumTyLimit"  name='"费用合计"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%"
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 21.25pt'>
		<label field="costSumTySum"  name='"费用合计"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
	</tr>
	<tr style='height: 34.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
		<p class=MsoNormal><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>三、限定性净资产转为非限定性净资产<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
		<input field="limitToUnlimitPyUnlimt" id="限定性净资产转为非限定性净资产1" name='"限定性净资产转为非限定性净资产"' 
		style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() " />
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
		<input field="limitToUnlimitPyLimit" id="限定性净资产转为非限定性净资产2" name='"限定性净资产转为非限定性净资产"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
		<label field="limitToUnlimitPySum" name='"限定性净资产转为非限定性净资产"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
		<input field="limitToUnlimitTyUnlimit" id="限定性净资产转为非限定性净资产3" name='"限定性净资产转为非限定性净资产"' 
		style="width:98%;text-align:right;padding-right:2px;"  onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
		<input field="limitToUnlimitTyLimit" id="限定性净资产转为非限定性净资产4" name='"限定性净资产转为非限定性净资产"' 
		style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onchange="value=value.replace(/[^\d.-]/g,'');setSumMoney() "/>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
		<label field="limitToUnlimitTySum" name='"限定性净资产转为非限定性净资产"' style="width:98%"  maxlength="15" style='text-align:right;padding-right:2px;' ></label>
		</td>
	</tr>
	<tr style='height: 51.05pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 51.05pt'>
		<p class=MsoNormal><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>四、净资产变动额</span><tt><span
			style='font-size: 12.0pt; color: black'>（若为净资产减少额，以<span
			lang=EN-US>“-”</span>号填列）</span></tt><span lang=EN-US
			style='font-size: 12.0pt; font-family: 宋体; color: black'><o:p></o:p></span></p>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 51.05pt'>
		<label field="assetsChangePyUnlimit" name='"净资产变动额"' style="width:98%"  style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 51.05pt'>
		<label field="assetsChangePyLimit" name='"净资产变动额"' style="width:98%" style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 51.05pt'>
		<label field="assetsChangePySum" name='"净资产变动额"' style="width:98%"  style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 51.05pt'>
		<label field="assetsChangeTyUnlimit" name='"净资产变动额"' style="width:98%" style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 51.05pt'>
		<label field="assetsChangeTyLimit" name='"净资产变动额"' style="width:98%" style='text-align:right;padding-right:2px;' ></label>
		</td>
		<td width="11%" valign=middle
			style='width: 11.86%; border-top: none; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-right-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 51.05pt'>
	<label field="assetsChangeTySum" name='"净资产变动额"' style="width:98%" maxlength="15" style='text-align:right;padding-right:2px;'  ></label>
		</td>
	</tr>
	<tr style='mso-yfti-lastrow: yes; height: 34.0pt'>
		<td width="28%"
			style='width: 28.84%; border-top: none; border-left: solid windowtext 1.5pt; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.0pt; mso-border-top-alt: solid windowtext .5pt; mso-border-top-alt: .5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: 1.5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>本年度年末资金余额<span
			lang=EN-US><o:p></o:p></span></span></p>
		<p class=MsoNormal align=center style='text-align: center'><span
			style='font-size: 12.0pt; font-family: 宋体; color: black'>（万元）<span
			lang=EN-US><o:p></o:p></span></span></p>
		</td>
		<td width="71%" colspan=6 valign=middle
			style='width: 71.16%; border-top: none; border-left: none; border-bottom: solid windowtext 1.5pt; border-right: solid windowtext 1.5pt; mso-border-top-alt: solid windowtext .5pt; mso-border-left-alt: solid windowtext .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 34.0pt'>
		<input type="text" name='本年度年末资金余额' field="remainingBalanceTy" style="width: 98%; text-align: center" maxlength="10" />
		</td>
	</tr>
</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>

</body>

</html>
