<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>当前业务动态</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript">
	var organCode='<%=BspUtil.getOrganCode()%>';
	var organName='<%=BspUtil.getOrganName()%>';
	var organType='<%=BspUtil.getOrganType()%>';
</script>
<script type="text/javascript" src="../comm/disComm.js"></script>
<script type="text/javascript" src="reliefMainTown.js"></script>
</head>
<body>
<model:datasets>
	<!--审批-->
	<model:dataset id="disShenqingDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchQueryCmd"
		method="queryShenqing" global="true">
	</model:dataset>
	
	<!--发放-->
	<model:dataset id="disFafangDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchQueryCmd"
		method="queryFafang" global="true">
	</model:dataset>
	
	<!--批次明细-以乡镇为单位(单条)-->
	<model:dataset id="reliefInfoDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchQueryCmd"
		method="queryInfoSum" global="true">
	</model:dataset>
	<!--批次明细-以乡镇为单位(多条)-->
	<model:dataset id="reliefInfoColumnDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchQueryCmd"
		method="queryInfoSums" global="true">
	</model:dataset>
</model:datasets>
<next:Panel height="100%" autoScroll="true">
	<next:Panel height="220" width="99%">
		<next:ColumnLayout>
			<next:Panel id="panel1" title="申请" columnWidth=".5">
			<next:Html>
				<form method="post" onsubmit="return false" class="L5form" dataset="disShenqingDs">
				<table border="0" width="100%" height="50%">
					<tr height="50">
						<td class="FieldLabel" width="150">合计:</td>
						<td class="FieldInput" colspan="2"><label
							field="SUM_NUM" renderer="sumNumRenderer"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="180">其中：冬春生活救助:</td>
						<td class="FieldInput"><label
							field="DC_NUM" renderer="dcNumRenderer"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="180">其中：应急救助:</td>
						<td class="FieldInput"><label
							field="YJ_NUM" renderer="yjNumRenderer"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="180">其中：过渡性生活补助:</td>
						<td class="FieldInput"><label
							field="GD_NUM" renderer="gdNumRenderer"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="180">其中：灾区民房恢复重建:</td>
						<td class="FieldInput"><label
							field="CJ_NUM" renderer="cjNumRenderer"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="180">其中：遇难人员家属抚慰:</td>
						<td class="FieldInput"><label
							field="SW_NUM" renderer="swNumRenderer"></label></td>
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
	<next:Panel id="panel2" columnWidth=".5">
	<next:Html>
		<fieldset>
		<form id="sumForm" method="post" dataset="reliefInfoDs"
			onsubmit="return false" class="L5form">
		<table border="0" width="100%" cellspacing="0" cellpadding="0">
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>救助总户数:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="FAMILYS" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>救助家庭人口数量:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="FAMILY_NUM" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>核准救助口粮（公斤）:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="APPROVAL_FOOD" renderer="formatMoneyForDis" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>人均核准救助口粮（公斤）:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="APPROVAL_FOOD_AVG" renderer="formatMoneyForDis" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>核准救助衣被（件）:</td>
				<td class="FieldInput" style="width: 35%"><label field="APPROVAL_CLOTHES" 
				renderer="formatMoneyForDis"/></td>
				<td class="FieldLabel" style="width: 15%" nowrap>人均核准救助衣被（件）:</td>
				<td class="FieldInput" style="width: 35%"><label field="APPROVAL_CLOTHES_AVG" 
				renderer="formatMoneyForDis"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>总核准救助饮水（元）:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="APPROVAL_WATER" renderer="formatMoneyForDis" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>人均核准救助饮水（元）:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="APPROVAL_WATER_AVG" renderer="formatMoneyForDis" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>总核准重建间数（间）:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="APPROVAL_REBUILED_HOUSE" renderer="formatMoneyForDis" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>人均核准重建间数（间）:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="APPROVAL_REBUILED_HOUSE_AVG" renderer="formatMoneyForDis" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>总核准修缮间数（间）:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="APPROVAL_REPAIRED_HOUSE" renderer="formatMoneyForDis"/></td>
				<td class="FieldLabel" style="width: 15%" nowrap>人均核准修缮间数（间）:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="APPROVAL_REPAIRED_HOUSE_AVG" renderer="formatMoneyForDis"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>总核准救助资金（元）:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="APPROVAL_MONEY" renderer="formatMoneyForDis" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>人均核准救助资金（元）:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="APPROVAL_MONEY_AVG" renderer="formatMoneyForDis" /></td>
			</tr>
		</table>
		</form>
		</fieldset>
	</next:Html>
</next:Panel>
		</next:ColumnLayout>
	</next:Panel>
	<next:Panel height="220" width="99%">
		<next:ColumnLayout>
			<next:Panel id="panel3" title="发放" columnWidth=".5">
			<next:Html>
				<form method="post" onsubmit="return false" class="L5form" dataset="disFafangDs">
				<table border="0" width="100%" height="50%">
					<tr height="50">
						<td class="FieldLabel" width="150">合计:</td>
						<td class="FieldInput" colspan="2"><label
							field="SUM_NUM" renderer="sumFafangNumRenderer"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="180">其中：冬春生活救助:</td>
						<td class="FieldInput"><label
							field="DC_NUM" renderer="dcFafangNumRenderer"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="180">其中：应急救助:</td>
						<td class="FieldInput"><label
							field="YJ_NUM" renderer="yjFafangNumRenderer"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="180">其中：过渡性生活补助:</td>
						<td class="FieldInput"><label
							field="GD_NUM" renderer="gdFafangNumRenderer"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="180">其中：灾区民房恢复重建:</td>
						<td class="FieldInput"><label
							field="CJ_NUM" renderer="cjFafangNumRenderer"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="180">其中：遇难人员家属抚慰:</td>
						<td class="FieldInput"><label
							field="SW_NUM" renderer="swFafangNumRenderer"></label></td>
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
	<next:GridPanel id="sumsGrid" name="sumsGrid" columnWidth=".5"
	clickToSelectedForChkSM="true" stripeRows="true" height="210"
	dataset="reliefInfoColumnDs" notSelectFirstRow="true" hasSum="true">
	<next:Columns>
		<next:RowNumberColumn width="40" header="序号" />
		<next:Column id="ORGAN_NAME" header="单位"
			field="ORGAN_NAME" width="160"></next:Column>
		<next:Column id="FAMILYS" header="救助总户数" field="FAMILYS"
			width="90" align="right"></next:Column>
		<next:Column id="FAMILY_NUM" header="救助家庭人口数量(人)" field="FAMILY_NUM"
			width="90" align="right"></next:Column>
		<next:Column id="APPROVAL_FOOD" header="核准救助口粮（公斤）"
			field="APPROVAL_FOOD" width="130" align="right" renderer="formatMoneyForDis"
			summaryType="sum">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField />
		</next:Column>
		<next:Column id="APPROVAL_FOOD_AVG" header="人均核准救助口粮（公斤）"
			field="APPROVAL_FOOD_AVG" width="130" align="right" renderer="formatMoneyForDis">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField />
		</next:Column>
		<next:Column id="APPROVAL_CLOTHES" header="核准救助衣被（件）"
			field="APPROVAL_CLOTHES" width="130" align="right" renderer="formatMoneyForDis"
			summaryType="sum">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField />
		</next:Column>
		<next:Column id="APPROVAL_CLOTHES_AVG" header="人均核准救助衣被（件）"
			field="APPROVAL_CLOTHES_AVG" width="130" align="right" renderer="formatMoneyForDis">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField />
		</next:Column>
		<next:Column id="APPROVAL_WATER" header="总核准救助饮水（元）"
			field="APPROVAL_WATER" width="130" align="right" renderer="formatMoneyForDis"
			summaryType="sum">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField />
		</next:Column>
		<next:Column id="APPROVAL_WATER_AVG" header="人均核准救助饮水（元）"
			field="APPROVAL_WATER_AVG" width="130" align="right" renderer="formatMoneyForDis">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField />
		</next:Column>
		<next:Column id="APPROVAL_REBUILED_HOUSE" header="总核准重建间数（间）"
			field="APPROVAL_REBUILED_HOUSE" width="130" align="right" renderer="formatMoneyForDis"
			summaryType="sum">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField />
		</next:Column>
		<next:Column id="APPROVAL_REBUILED_HOUSE_AVG" header="人均核准重建间数（间）"
			field="APPROVAL_REBUILED_HOUSE_AVG" width="140" align="right"
			renderer="formatMoneyForDis">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField />
		</next:Column>

		<next:Column id="APPROVAL_REPAIRED_HOUSE" header="总核准修缮间数（间）"
			field="APPROVAL_REPAIRED_HOUSE" width="130" align="right" summaryType="sum"
			renderer="formatMoneyForDis">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField />
		</next:Column>
		<next:Column id="APPROVAL_REPAIRED_HOUSE_AVG" header="人均核准修缮间数（间）"
			field="APPROVAL_REPAIRED_HOUSE_AVG" width="140" align="right"
			renderer="formatMoneyForDis">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField />
		</next:Column>

		<next:Column id="APPROVAL_MONEY" header="总核准救助资金（元）"
			field="APPROVAL_MONEY" width="120" align="right" renderer="formatMoneyForDis"
			summaryType="sum">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField />
		</next:Column>
		<next:Column id="APPROVAL_MONEY_AVG" header="人均核准救助资金（元）"
			field="APPROVAL_MONEY_AVG" width="150" align="right"
			renderer="formatMoneyForDis">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField />
		</next:Column>
	</next:Columns>
</next:GridPanel>
		</next:ColumnLayout>
	</next:Panel>
</next:Panel>
</body>
</html>