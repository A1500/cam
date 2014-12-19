<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
<head>
<title>省级资金拨付</title>
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
	var batchId = '<%=request.getParameter("batchId")%>';
</script>
<script type="text/javascript" src="fundsComm.js"></script>
<script type="text/javascript" src="fundsAllocationEdit2Department.js"></script>
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
	<!--拨付-->
	<model:dataset id="disFundsSourceDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd"
		pageAble="false">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>
	
	<!--拨付-中央-->
	<model:dataset id="disFundsSourceCentralDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd" method="queryFunds"
		pageAble="false">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>
	<!--拨付-省-->
	<model:dataset id="disFundsSourceDepartmentDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd" method="queryFunds"
		pageAble="false">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>

	<!-- 资金来源类型 -->
	<model:dataset id="disSourceTypeDs" enumName="DIS.SOURCE_TYPE"
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

<next:Panel name="allocationPanel" width="99%">
	<next:TopBar>
		<next:ToolBarItem text="资金拨付"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="onSave"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="onCancel"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"
			dataset="disFundsSourceDs">
		<table border="0" width="100%">
			<tr>
				<td class="FieldLabel" width="10%">年度:</td>
				<td class="FieldInput"><label field="disYear"></td>
				<td class="FieldLabel" width="10%">下拨文号:</td>
				<td class="FieldInput"><label field="upAllocationNum"/></td>

				<td class="FieldLabel" width="10%" rowspan="3">资金用途:</td>
				<td class="FieldInput" rowspan="3"><input type="checkbox"
					name="upAllocationPurpose" value="DC" field="upAllocationPurpose"
					label="冬春生活救助" disabled="disabled"/>冬春生活救助 <br />
				<input type="checkbox" name="upAllocationPurpose" value="YJ"
					field="upAllocationPurpose" label="应急生活救助" disabled="disabled"/>应急生活救助 <br />
				<input type="checkbox" name="upAllocationPurpose" value="CJ"
					field="upAllocationPurpose" label="灾区民房恢复重建补助" disabled="disabled"/>灾区民房恢复重建补助 <br />
				<input type="checkbox" name="upAllocationPurpose" value="GD"
					field="upAllocationPurpose" label="过渡性生活补助" disabled="disabled"/>过渡性生活补助 <br />
				<input type="checkbox" name="upAllocationPurpose" value="SW"
					field="upAllocationPurpose" label="因灾死亡人员家庭抚慰金发放" disabled="disabled"/>因灾死亡人员家庭抚慰金发放
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" width="10%">拨款类型:</td>
				<td class="FieldInput">
					<label field="upAllocationType" dataset="disAllocationTypeDs"/>
				</td>
				<td class="FieldLabel" width="10%">接收单位:</td>
				<td class="FieldInput">
					<label field="receiveOrganName"/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" width="10%">拨款金额:</td>
				<td class="FieldInput" colspan="3">
					<label id="amountLbl" field="amount" style="color: red"/>
				</td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>


<next:Panel name="detailPanel" width="99%" height="100%" title="资金拨付明细" autoScroll="true">
<!--中央款-->
	<next:EditGridPanel id="centralGrid" dataset="disFundsSourceCentralDs"
		height="300" width="98%" hasSum="true" stripeRows="true"
		notSelectFirstRow="true">
		<next:TopBar>
			<next:ToolBarItem text="中央款拨付资金明细(请维护“拨款资金金额”列)"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn width="45" />
			<next:Column id="sourceId" header="来源表ID" field="sourceId"
				align="center" hidden="true">
				<next:TextField allowBlank="false" />
			</next:Column>
	
			<next:Column id="disYear" header="年度"
				field="disYear" align="center" width="70">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="upAllocationNum" header="上级拨款资金文号"
				field="upAllocationNum" align="center" width="110">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			
			<next:Column id="upAllocationType" header="拨款类型"
				field="upAllocationType" align="center" width="70" dataset="disAllocationTypeDs">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			
			<next:Column id="amount" header="原拨款资金金额" field="amount"
				align="right" width="100" renderer="formatNum" summaryType="sum">
				<next:ExtendConfig>
	                    summaryRenderer : formatNum
	                </next:ExtendConfig>
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="amountExtTotal" header="原拨款资金金额结余" field="amountExtTotal"
				align="right" width="120" renderer="formatNum" summaryType="sum">
				<next:ExtendConfig>
	                    summaryRenderer : formatNum
	                </next:ExtendConfig>
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="amountExtReal" header="<b>拨款资金金额</b>" field="amountExtReal" align="right"
				width="100" renderer="formatNum" summaryType="sum">
				<next:ExtendConfig>
	                    summaryRenderer : formatNum
	                </next:ExtendConfig>
				<next:TextField allowBlank="false" />
			</next:Column>
			
			<next:Column id="upAllocationPurpose" header="资金用途"
				field="upAllocationPurpose" align="left" width="290" renderer="upAllocationPurposeRenderer">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="fillTime" header="拨付时间"
				field="fillTime" align="center" width="125">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
		</next:Columns>
	</next:EditGridPanel>
<!--省级款-->
	<next:EditGridPanel id="departmentGrid" dataset="disFundsSourceDepartmentDs"
		height="300" width="98%" hasSum="true" stripeRows="true"
		notSelectFirstRow="true">
		<next:TopBar>
			<next:ToolBarItem text="省级款拨付资金明细(请维护“拨款资金金额”列)"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
		</next:TopBar>
		
		<next:Columns>
			<next:RowNumberColumn width="45" />
			<next:Column id="sourceId" header="来源表ID" field="sourceId"
				align="center" hidden="true">
				<next:TextField allowBlank="false" />
			</next:Column>
	
			<next:Column id="disYear" header="年度"
				field="disYear" align="center" width="70">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="sourceType" header="资金来源类型"
				field="sourceType" align="center" width="90" dataset="disSourceTypeDs">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			
			<next:Column id="upAllocationType" header="拨款类型"
				field="upAllocationType" align="center" width="70" dataset="disAllocationTypeDs">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			
			<next:Column id="amount" header="原拨款资金金额" field="amount"
				align="right" width="100" renderer="formatNum" summaryType="sum">
				<next:ExtendConfig>
	                    summaryRenderer : formatNum
	                </next:ExtendConfig>
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="amountExtTotal" header="原拨款资金金额结余" field="amountExtTotal"
				align="right" width="120" renderer="formatNum" summaryType="sum">
				<next:ExtendConfig>
	                    summaryRenderer : formatNum
	                </next:ExtendConfig>
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="amountExtReal" header="<b>拨款资金金额</b>" field="amountExtReal" align="right"
				width="100" renderer="formatNum" summaryType="sum">
				<next:ExtendConfig>
	                    summaryRenderer : formatNum
	                </next:ExtendConfig>
				<next:TextField allowBlank="false" />
			</next:Column>
			
			<next:Column id="upAllocationPurpose" header="资金用途"
				field="upAllocationPurpose" align="left" width="290" renderer="upAllocationPurposeRenderer">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="fillTime" header="拨付时间"
				field="fillTime" align="center" width="125">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
		</next:Columns>
	</next:EditGridPanel>
</next:Panel>
</body>
</html>