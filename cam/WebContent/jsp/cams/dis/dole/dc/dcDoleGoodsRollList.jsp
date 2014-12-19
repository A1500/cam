<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
<head>
<title>物资发放</title>
<%
	String ifDetail = request.getParameter("ifDetail");
%>
<next:ScriptManager />
<script language="javascript">
	 var organCode = '<%=BspUtil.getOrganCode()%>';
	 var organName = '<%=BspUtil.getOrganName()%>';
     var organType = '<%=BspUtil.getOrganType()%>';
     var ifDetail = '<%=request.getParameter("ifDetail")%>';
     var batchId = '<%=request.getParameter("batchId")%>';
     var batchDetailId = '<%=request.getParameter("batchDetailId")%>';
     var doleId = '<%=request.getParameter("doleId")%>';
     var uu32='<%=IdHelp.getUUID32()%>';
     var ifDetail='<%=ifDetail%>';
     
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
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript" src="../../comm/disComm.js"></script>
<script type="text/javascript" src="dcDoleGoodsRollList.js"></script>
</head>
<body>
<model:datasets>
	<!-- 档案信息 -->
	<model:dataset id="infoDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCmd"
		method="queryReliefInfo" global="true" pageAble="false">
	</model:dataset>
	<!-- 发放流水信息 -->
	<model:dataset id="doleDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefDoleQueryCmd" global="true"
		pageAble="false">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefDole">
			<model:field name="fillPeopleName" type="string" rule="require"></model:field>
			<model:field name="fillTime" type="string" rule="require"></model:field>
		</model:record>
	</model:dataset>
	<!-- 发放物资类型-虚拟列使用 -->
	<model:dataset id="doleMeteTypeDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefDoleQueryCmd"
		method="queryDoleMeteType" global="true" pageAble="false">
	</model:dataset>
	<!--批次-->
	<model:dataset id="batchds"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchQueryCmd"
		global="true" pageAble="false">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefBatch">
		</model:record>
	</model:dataset>
	<!--当前单位可用物资-->
	<model:dataset id="disDetailBatchSourceDs"
		cmd="com.inspur.cams.dis.base.cmd.DisDetailBatchSourceQueryCmd"
		method="queryDisDetailBatchSource" pageAble="false" global="true">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisDetailBatchSource"></model:record>
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
	<!-- 提交状态 -->
	<model:dataset id="ReliefinfoWorkflowState"
		enumName="DIS.RELIEFINFO_WORKFLOW_STATE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 户口类型 -->
	<model:dataset id="DisFamilyRegister" enumName="DIS.FAMILY_REGISTER"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 家庭类型 -->
	<model:dataset id="DisFamilyType" enumName="DIS.FAMILY_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 物资来源类型 -->
	<model:dataset id="disSourceTypeDicDs" enumName="DIS.SOURCE_TYPE_DIC"
		autoLoad="true" global="true">
	</model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0" autoHeight="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem id="btnSave" text="保存" iconCls="add" handler="save" />
		<next:ToolBarItem id="btnConfirm" text="确认" iconCls="edit"
			handler="inConfirm" />
		<next:ToolBarItem text="导出Excel" iconCls="export" handler="forExcel"/>
		<next:ToolBarItem text="打印救助卡" iconCls="print" />
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"
			dataset="doleDs">
		<table border="0" width="100%">
			<tr>
				<td class="FieldLabel">发放人:</td>
				<td class="FieldInput"><input type="text" id="fillPeopleName"
					field="fillPeopleName" class="TextEditor" title="发放人" /><font
					color="red">*</font></td>
				<td class="FieldLabel">发放日期:</td>
				<td class="FieldInput"><input type="text" id="fillTime"
					field="fillTime" title="发放日期" format="Y-m-d" style="width: 100px;"
					maxlength="10" onpropertychange="changeDateStyle(this)" /><img
					id="timeImg" src="../../../../../skins/images/default/rl.gif"
					align="middle" onclick="getTimes(this);" /><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel">备注:</td>
				<td class="FieldInput" colspan="3"><input type="text" id="note"
					field="note" class="TextEditor" title="备注" style="width: 80%" /></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>

<next:EditGridPanel id="dcGrid" name="dcGrid" width="100%"
	stripeRows="true" height="100%" dataset="infoDs"
	notSelectFirstRow="true" hasSum="true">
	<next:TopBar>
		<next:ToolBarItem text="救助名册列表信息" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="40" header="序号" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="NAME" header="户主姓名" field="NAME" width="90"></next:Column>
		<next:Column id="ID_CARD" header="身份证号码" field="ID_CARD" width="135"></next:Column>
		<next:Column id="ACCEPT_AREA_NAME" header="行政村（社区）"
			field="ACCEPT_AREA_NAME" width="170"></next:Column>

		<next:Column id="APPROVAL_FOOD" header="核准口粮救助(公斤)"
			field="APPROVAL_FOOD" width="130" align="right" summaryType="sum"
			editable="false">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
		</next:Column>
		<next:Column id="APPROVAL_CLOTHES" header="核准衣被救助(件)"
			field="APPROVAL_CLOTHES" width="130" align="right" summaryType="sum"
			editable="false">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
		</next:Column>

		<next:Column id="T01" header="T01" field="T01" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T02" header="T02" field="T02" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T03" header="T03" field="T03" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T04" header="T04" field="T04" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T05" header="T05" field="T05" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T06" header="T06" field="T06" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T07" header="T07" field="T07" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T08" header="T08" field="T08" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T09" header="T09" field="T09" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T10" header="T10" field="T10" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T11" header="T11" field="T11" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T12" header="T12" field="T12" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T13" header="T13" field="T13" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T14" header="T14" field="T14" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T15" header="T15" field="T15" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T16" header="T16" field="T16" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T17" header="T17" field="T17" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T18" header="T18" field="T18" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T19" header="T19" field="T19" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T20" header="T20" field="T20" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T21" header="T21" field="T21" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T22" header="T22" field="T22" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T23" header="T23" field="T23" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T24" header="T24" field="T24" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="T25" header="T25" field="T25" width="100"
			align="right" summaryType="sum" hidden="true">
			<next:ExtendConfig>
               	summaryRenderer : formatMoneyForDis
           	</next:ExtendConfig>
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
</next:EditGridPanel>
</body>
</html>

<!--使用物资选择窗口-->
<next:Window id="goodsWin" width="850" height="550" collapsible="false"
	closable="close" resizable="false" modal="true" title="发放确认划拨物资维护">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存确认" handler="onSaveConfirm"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="取消确认" handler="onCancel"></next:ToolBarItem>
	</next:TopBar>
	<next:Panel width="100%" height="100%">
		<next:Panel>
			<next:Html>
				<form method="post" onsubmit="return false" class="L5form">
				<table border="0" width="100%">
					<tr>
						<td class="FieldLabel" width="15%">发放物资总和:</td>
						<td class="FieldInput"><label id="doleGoods" /></td>
						<td class="FieldLabel" width="15%">发放记录数:</td>
						<td class="FieldInput"><label id="doleNums" /></td>
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
		<next:EditGridPanel id="useGrid" width="98%" height="430"
			dataset="disDetailBatchSourceDs">
			<next:TopBar>
				<next:ToolBarItem text="使用物资明细(明细实际使用总和与发放物资总和绑定)"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn></next:RowNumberColumn>
				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column header="物资来源" field="allocationType" align="center"
					width="80" dataset="disSourceTypeDicDs">
					<next:TextField editable="false" />
				</next:Column>
				<next:Column header='物资类型' field="meterialType"
					renderer="meterialTypeRenderer" width="130">
					<next:TextField editable="false" />
				</next:Column>
				<next:Column header="物资单位" field="meterialUnit" align="center"
					width="80">
					<next:TextField editable="false" />
				</next:Column>
				<next:Column header="单位关系" field="meterialUnitprice" align="center"
					width="80" hidden="true">
					<next:TextField editable="false" />
				</next:Column>
				<next:Column header="物资数量" field="meterialNumBalance" align="right"
					width="120" renderer="meterialNumBalanceRenderer">
					<next:TextField editable="false" />
				</next:Column>
				<next:Column header="物资数量(转单位使用)" field="meterialNumBalanceTotal"
					align="right" width="120" hidden="true">
					<next:TextField editable="false" />
				</next:Column>
				<next:Column id="meterialNumPay" header="<b>实际使用数量</b>"
					field="meterialNumPay" width="120" align="right"
					renderer="meterialNumPayRenderer">
					<next:TextField />
				</next:Column>
				<next:Column header="物资金额合计(元)" field="meterialAccountBalanceTotal"
					align="right" summaryType="sum" width="120">
					<next:TextField editable="false" />
				</next:Column>
				<next:Column header="使用物资金额合计(元)" field="meterialAccountPay"
					align="right" summaryType="sum" width="140">
					<next:TextField editable="false" />
				</next:Column>
			</next:Columns>
		</next:EditGridPanel>
	</next:Panel>
</next:Window>

