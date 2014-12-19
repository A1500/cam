<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
<head>
<title>市级资金拨付明细</title>
<next:ScriptManager />
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript">
	var organCode='<%=BspUtil.getOrganCode()%>';
	var organName='<%=BspUtil.getOrganName()%>';
	var organType='<%=BspUtil.getOrganType()%>';
	var sourceId = '<%=request.getParameter("sourceId")%>';
	var currentSourceId = '<%=request.getParameter("currentSourceId")%>';
	var batchId = '<%=request.getParameter("batchId")%>';
	var inRef = '<%=request.getParameter("inRef")%>';
	var fundsType = '<%=request.getParameter("fundsType")%>';
	var actionFundsType = '<%=request.getParameter("actionFundsType")%>'; //标志拨付款项的等级(仅县级)：市款为2，县款为3
</script>
<script type="text/javascript" src="fundsComm.js"></script>
<script type="text/javascript"
	src="fundsAllocationEdit2CityLiveDetails.js"></script>
<script language="javascript">
 	 //查询条件打开合并函数
	 function collapse(element){
		var fieldsetParent=L5.get(element).findParent("fieldset");
		if(element.expand==null||element.expand==true){
			fieldsetParent.getElementsByTagName("div")[0].style.display="none";
			element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
			element.expand=false;
		}else{
			fieldsetParent.getElementsByTagName("div")[0].style.display="";
			element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
			element.expand =true;
		}
	}
</script>
</head>
<body>

<model:datasets>
	<!--拨付-县款主记录-->
	<model:dataset id="disFundsSourceDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd" method="queryFundsSingle"
		pageAble="false">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>

	<!--拨付-明细-->
	<model:dataset id="disFundsSourceDetailDs" method="queryFundsDetails"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceDetailQueryCmd"
		pageAble="false">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisFundsSourceDetail"></model:record>
	</model:dataset>
	
	<!-- 发放物资类型-->
	<model:dataset id="dmDisMaterialTypeDs"
		cmd="com.inspur.cams.dis.base.cmd.DicDisMaterialTypeQueryCmd"
		autoLoad="true" pageAble="false" global="true">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DicDisMaterialType">
			<model:field name="value" mapping="code" type="string" />
			<model:field name="text" mapping="name" type="string" />
		</model:record>
	</model:dataset>
	<!-- 资金来源类型 -->
	<model:dataset id="disSourceTypeDs" enumName="DIS.SOURCE_TYPE_DIC"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="commYesOrNoDS" enumName="COMM.YESORNO"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 资金类型 -->
	<model:dataset id="disAllocationTypeDs" enumName="DIS.ALLOCATION_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="disAllocationPurposeDs"
		enumName="DIS.ALLOCATION_PURPOSE" autoLoad="true" global="true">
	</model:dataset>
</model:datasets>

<next:Panel name="allocationPanel" width="100%">
	<next:TopBar>
		<next:ToolBarItem text="选中的拨付资金"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="onSave"></next:ToolBarItem>
		<next:ToolBarItem iconCls="no" text="关闭" handler="onCancel"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"
			dataset="disFundsSourceDs">
		<table border="0" width="100%">
			<tr>
				<td class="FieldLabel" width="15%">年度:</td>
				<td class="FieldInput"><label field="disYear"></td>
				<td class="FieldLabel" width="15%">拨款类型:</td>
				<td class="FieldInput"><label field="upAllocationType"
					dataset="disAllocationTypeDs" /></td>

				<td class="FieldLabel" width="15%" rowspan="3">资金用途:</td>
				<td class="FieldInput" rowspan="3"><input type="checkbox"
					name="upAllocationPurpose" value="DC" field="upAllocationPurpose"
					label="冬春生活救助" disabled="disabled" />冬春生活救助 <br />
				<input type="checkbox" name="upAllocationPurpose" value="YJ"
					field="upAllocationPurpose" label="应急生活救助" disabled="disabled" />应急生活救助
				<br />
				<input type="checkbox" name="upAllocationPurpose" value="CJ"
					field="upAllocationPurpose" label="灾区民房恢复重建补助" disabled="disabled" />灾区民房恢复重建补助
				<br />
				<input type="checkbox" name="upAllocationPurpose" value="GD"
					field="upAllocationPurpose" label="过渡性生活补助" disabled="disabled" />过渡性生活补助
				<br />
				<input type="checkbox" name="upAllocationPurpose" value="SW"
					field="upAllocationPurpose" label="因灾死亡人员家庭抚慰金发放"
					disabled="disabled" />因灾死亡人员家庭抚慰金发放</td>
			</tr>
			<tr>
				<td class="FieldLabel" width="15%">原拨款总额:</td>
				<td class="FieldInput"><label id="amountTotalOld"/>
				</td>
				<td class="FieldLabel" width="15%">拨款总额:</td>
				<td class="FieldInput"><label id="amountTotalNew"
					style="color:  red"/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" width="15%">原拨款资金金额结余:</td>
				<td class="FieldInput"><label id="amountExtTotal" field="amountExtTotal"/></td>
				<td class="FieldLabel" width="15%">拨款资金金额:</td>
				<td class="FieldInput">
					<input type="text" name="拨款资金金额" id="amountExtReal"
						field="amountExtReal" onchange="checkAssMon(this.id)" onblur="computeSumEvent(this.id)"
						style="text-align: right;width: 100px;" />
				</td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="singleCityGrid" dataset="disFundsSourceDetailDs"
	height="100%" width="100%" hasSum="true">
	<next:TopBar>
		<next:ToolBarItem text="其中，发放物资"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="25" />
		<next:Column header='物资类型' field="meterialType" renderer="meterialTypeRenderer">
			<next:ComboBox dataset="dmDisMaterialTypeDs" typeAble="false"
				editable="false" />
		</next:Column>
		<next:Column header="物资单位" field="meterialUnit" align="left"
			width="80">
			<next:TextField editable="false" editable="false" />
		</next:Column>
		<next:Column header="原物资数量" field="meterialNum" align="right"
			width="110" renderer="formatNum">
			<next:TextField editable="false" />
		</next:Column>
		<next:Column header="原物资金额合计" field="meterialAccount"
			width="130" align="right" renderer="formatNum">
			<next:TextField editable="false" />
		</next:Column>
		
		<next:Column header="物资数量（结余）" field="realMeterialNumTotal" align="right"
			width="110" renderer="formatNum">
			<next:TextField editable="false" />
		</next:Column>
		<next:Column id="realMeterialNum" header="<b>实际下拨物资数量</b>" field="realMeterialNum"
			align="right" width="130" renderer="formatNum" summaryType="sum">
			<next:ExtendConfig>
                    summaryRenderer : formatNum
                </next:ExtendConfig>
			<next:TextField allowBlank="false"  />
		</next:Column>
			
		<next:Column header="物资金额合计（结余）" field="realMeterialAccountTotal"
			width="130" align="right" renderer="formatNum">
			<next:TextField editable="false" />
		</next:Column>
		<next:Column id="realMeterialAccount" header="<b>实际下拨物资金额合计</b>" field="realMeterialAccount"
			align="right" width="140" summaryType="sum" renderer="realMeterialAccountRenderer">
			<next:ExtendConfig>
                    summaryRenderer : formatNum
                </next:ExtendConfig>
			<next:TextField allowBlank="false"  />
		</next:Column>
	</next:Columns>
</next:EditGridPanel>
</body>
</html>