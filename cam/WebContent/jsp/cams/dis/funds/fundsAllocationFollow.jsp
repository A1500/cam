<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<head>
<title>资金拨付进度追踪</title>
<next:ScriptManager />
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript">
	var nowYear='<%= DateUtil.getYear()%>';
	var organCode='<%=BspUtil.getOrganCode()%>';
	var organName='<%=BspUtil.getOrganName()%>';
	var organType='<%=BspUtil.getOrganType()%>';
	var uu32='<%=IdHelp.getUUID32()%>';
	var method = '<%=request.getParameter("method")%>';
	var batchId = '<%=request.getParameter("batchId")%>';
	var organNameTitleCode='<%=java.net.URLDecoder.decode(request.getParameter("organNameTitleCode"),"UTF-8")%>';
	document.title = organNameTitleCode + " 资金拨付进度追踪"; 
</script>
<script type="text/javascript" src="fundsComm.js"></script>
<script type="text/javascript" src="../comm/disComm.js"></script>
<script type="text/javascript" src="fundsAllocationFollow.js"></script>
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
	<!--批次-->
	<model:dataset id="disFundsBatchDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsBatchQueryCmd">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsBatch">
			<model:field name="disYear" type="string" rule="require"></model:field>
			<model:field name="upAllocationNum" type="string" rule="require"></model:field>
			<model:field name="upAllocationType" type="string" rule="require"></model:field>
			<model:field name="allocationTime" type="string" rule="require"></model:field>
			<model:field name="amount" type="float" rule="require"></model:field>
		</model:record>
	</model:dataset>

	<!--拨付-->
	<model:dataset id="disFundsSourceDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd" method="queryFundsFollow"
		pageAble="false" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>
	<!--拨付使用资金关系表-->
	<model:dataset id="disFundsBatchSourceDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd"
		method="queryFundsBatchSource">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>
	
	<!--附件-->
	<model:dataset id="disAccessoriesDs"
		cmd="com.inspur.cams.dis.base.cmd.DisAccessoriesQueryCmd"
		pageAble="false" global="true" sortDirection="UPLOAD_TIME DESC,ACCESSORIES_ID">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisAccessories"></model:record>
	</model:dataset>
	
	<!--资金拨付追踪-->
	<model:dataset id="disFundsSourceAlloDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd" method="queryFundsFollowAllo"
		pageAble="false" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>
	<!--物资折款追踪-->
	<model:dataset id="disFundsSourceSwapDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd" method="queryFundsFollowSwap"
		pageAble="false" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>
	
	<!--直属单位-->
	<model:dataset id="disDirectManageUnitDs"
		cmd="com.inspur.cams.dis.base.cmd.DisDirectManageUnitQueryCmd"
		method="queryAllUnit" global="true" pageAble="false">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisDirectManageUnit"></model:record>
	</model:dataset>

	<!-- 资金来源类型 -->
	<model:dataset id="disSourceTypeDs" enumName="DIS.SOURCE_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="commYesOrNoDS" enumName="COMM.YESORNO"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 采购方式 -->
	<model:dataset id="disSwapTypeDs" enumName="DIS.SWAP_TYPE"
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

<next:ViewPort>
	<next:Panel name="allocationPanel" width="100%">
		<next:TopBar>
			<next:ToolBarItem text="资金拨付基本信息"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="upload" text="附件管理" handler="onStuffer"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="返回" handler="onCancel"></next:ToolBarItem>
		</next:TopBar>
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="disFundsBatchDs">
			<table border="0" width="100%">
				<tr>
					<td class="FieldLabel" width="10%">年度:</td>
					<td class="FieldInput" width="23%"><label field="disYear" /></td>
					<td class="FieldLabel" width="10%">拨款类型:</td>
					<td class="FieldInput" width="23%"><label field="allocationTime"
						dataset="disAllocationTypeDs" /></td>
					<td class="FieldLabel" width="10%" rowspan="4">资金用途:</td>
					<td class="FieldInput" rowspan="4" width="23%"><input type="checkbox"
						name="upAllocationPurpose" value="DC" field="upAllocationPurpose"
						label="冬春生活救助" disabled="disabled" />冬春生活救助 <br />
					<input type="checkbox" name="upAllocationPurpose" value="YJ"
						field="upAllocationPurpose" label="应急生活救助" disabled="disabled" />应急生活救助
					<br />
					<input type="checkbox" name="upAllocationPurpose" value="CJ"
						field="upAllocationPurpose" label="灾区民房恢复重建补助 "
						disabled="disabled" />灾区民房恢复重建补助 <br />
					<input type="checkbox" name="upAllocationPurpose" value="GD"
						field="upAllocationPurpose" label="过渡性生活补助" disabled="disabled" />过渡性生活补助
					<br />
					<input type="checkbox" name="upAllocationPurpose" value="SW"
						field="upAllocationPurpose" label="遇难人员家属抚慰"
						disabled="disabled" />遇难人员家属抚慰</td>
				</tr>
				<tr>
					<td class="FieldLabel" width="10%">拨款日期:</td>
					<td class="FieldInput"><label field="allocationTime" /></td>
					<td class="FieldLabel" width="10%">下拨文号:</td>
					<td class="FieldInput"><label field="upAllocationNum"
						style="width: 80%" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" width="10%" rowspan="3">拨款金额:</td>
					<td class="FieldInput" rowspan="3"><label field="amount"></label>&nbsp;万元<br /><br />
					<button onclick="onDetails()">使用资金明细</button>
					</td>
					<td class="FieldLabel" width="10%">其中，上级下拨:</td>
					<td class="FieldInput"><label id="amountUp"></label>&nbsp;万元</td>
				</tr>
				<tr>
					<td class="FieldLabel" width="10%">其中，本级投入:</td>
					<td class="FieldInput"><label id="amountSelf"></label>&nbsp;万元</td>
				</tr>
				<tr>
					<td class="FieldLabel" width="10%">其中，社会捐赠:</td>
					<td class="FieldInput"><label id="amountCon"></label>&nbsp;万元</td>
					<td class="FieldLabel" width="10%">备注:</td>
					<td class="FieldInput"><label field="note" style="width: 80%" /></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:GridPanel id="allocationAllGrid" dataset="disFundsSourceDs"
		height="100%" width="100%" hasSum="true" stripeRows="true"
		notSelectFirstRow="true">
		<next:TopBar>
			<next:ToolBarItem text="拨付资金明细(单位：万元)"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn width="45" />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column id="SOURCE_ID" header="来源表ID" field="SOURCE_ID"
				align="center" hidden="true">
				<next:TextField allowBlank="false" />
			</next:Column>

			<next:Column id="NAME" header="接收单位名称"
				field="NAME" align="center" width="120">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			
			<next:Column id="AMOUNT" header="总计" field="AMOUNT" align="right"
				width="100" renderer="formatMoneyForDis" summaryType="sum">
				<next:ExtendConfig>
			                    summaryRenderer : formatMoneyForDis
			                </next:ExtendConfig>
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="AMOUNT_CENTRAL" header="中央财政" field="AMOUNT_CENTRAL"
				align="right" width="100" renderer="formatMoneyForDis"
				summaryType="sum">
				<next:ExtendConfig>
			                    summaryRenderer : formatMoneyForDis
			                </next:ExtendConfig>
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="AMOUNT_DEPARTMENT" header="省财政"
				field="AMOUNT_DEPARTMENT" align="right" width="100"
				renderer="formatMoneyForDis" summaryType="sum">
				<next:ExtendConfig>
			                    summaryRenderer : formatMoneyForDis
			                </next:ExtendConfig>
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="AMOUNT_CITY" header="市财政" field="AMOUNT_CITY"
				align="right" width="100" renderer="formatMoneyForDis"
				summaryType="sum" hidden="true">
				<next:ExtendConfig>
			                    summaryRenderer : formatMoneyForDis
			                </next:ExtendConfig>
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="AMOUNT_COUNTY" header="县财政" field="AMOUNT_COUNTY"
				align="right" width="100" renderer="formatMoneyForDis"
				summaryType="sum" hidden="true">
				<next:ExtendConfig>
			                    summaryRenderer : formatMoneyForDis
			                </next:ExtendConfig>
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="AMOUNT_BF" header="<b>已拨付</b>" field="AMOUNT_BF"
				align="right" width="100" renderer="amountBfRenderer" summaryType="sum">
				<next:ExtendConfig>
			                    summaryRenderer : formatMoneyForDis
			                </next:ExtendConfig>
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>

			<next:Column id="AMOUNT_WZ" header="<b>已物资折款</b>" field="AMOUNT_WZ"
				align="right" width="100" renderer="amountWzRenderer" summaryType="sum">
				<next:ExtendConfig>
			                    summaryRenderer : formatMoneyForDis
			                </next:ExtendConfig>
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="AMOUNT_BF" header="<b>已发放</b>" field="AMOUNT_FF"
				align="right" width="100" renderer="formatMoneyForDis" summaryType="sum">
				<next:ExtendConfig>
			                    summaryRenderer : formatMoneyForDis
			                </next:ExtendConfig>
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			
			<next:Column id="AMOUNT_BALANCE" header="结余" field="AMOUNT_BALANCE"
				align="right" width="100" summaryType="sum" renderer="formatMoneyForDis">
				<next:ExtendConfig>
			                    summaryRenderer : formatMoneyForDis
			                </next:ExtendConfig>
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>

			<next:Column id="note" header="备注" field="note" align="left"
				width="250">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
		</next:Columns>
	</next:GridPanel>
</next:ViewPort>
</body>
</html>

<!--资金来源明细-->
<next:Window id="detailsWin" closeAction="hide" title="拨付金额使用资金明细" width="866"
	height="430" autoScroll="true" modal="true" closable="false">
	<next:EditGridPanel id="winGrid2" dataset="disFundsBatchSourceDs"
		height="150" width="850" height="395" hasSum="true" stripeRows="true"
		notSelectFirstRow="true">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="onCloseDetails"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn width="45" />
			<next:Column id="sourceId" header="来源表ID" field="sourceId"
				align="center" hidden="true">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:Column id="disYear" header="年度" field="disYear" align="center"
				width="60">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="sourceType" header="来源类型" field="sourceType"
				align="center" width="80" dataset="disSourceTypeDs">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="allocationTime" header="拨款日期" field="allocationTime"
				align="center" width="80">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="upAllocationNum" header="拨款文号"
				field="upAllocationNum" align="left" width="80">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="upAllocationType" header="拨款类型"
				field="upAllocationType" align="center" width="80"
				dataset="disAllocationTypeDs">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>

			<next:Column id="amountPay" header="<b>支出金额</b>" field="amountPay"
				align="right" width="80" renderer="formatMoneyForDis" summaryType="sum">
				<next:ExtendConfig>
				                    	summaryRenderer : formatMoneyForDis
				                	</next:ExtendConfig>
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>

			<next:Column id="upAllocationPurpose" header="资金用途"
				field="upAllocationPurpose" align="left" width="100"
				renderer="upAllocationPurposeRenderer">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="note" header="备注" field="note" align="left"
				width="90">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
		</next:Columns>
	</next:EditGridPanel>
</next:Window>

<!--附件管理-->
<next:Window id="stufferWin" closeAction="hide" title="附件管理"
	width="666" height="330" autoScroll="true" modal="true"
	closable="false">
	<next:GridPanel id="uploadListGrid" width="98%" stripeRows="true"
		height="88%" dataset="disAccessoriesDs">
		<next:TopBar>
			<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="onCloseStuffer"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column id="accessoriesName" header="文件名称"
				field="accessoriesName" align="left" width="170"
				renderer="downloadUploadFile">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="note" header="描述" field="note" align="left"
				width="200">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="uploadTime" header="上传时间" field="uploadTime"
				align="left" width="125">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
		</next:Columns>
	</next:GridPanel>
</next:Window>

<!--资金拨付追踪-->
<next:Window id="FollowAlloWin" closeAction="hide" title="资金拨付追踪"
	width="800" height="330" autoScroll="true" modal="true"
	closable="false">
	<next:GridPanel id="followAlloGrid" width="98%" stripeRows="true"
		height="88%" dataset="disFundsSourceAlloDs">
		<next:TopBar>
			<next:ToolBarItem symbol="资金拨付追踪列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="yes" text="查看" handler="onFollowAlloDetail"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="onCloseFollowAlloWin"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column id="DIS_YEAR" header="年度" field="DIS_YEAR" align="left"
				width="60">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="ALLOCATION_TIME" header="拨款日期" field="ALLOCATION_TIME" align="left"
				width="80">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="UP_ALLOCATION_NUM" header="拨款文号" field="UP_ALLOCATION_NUM" align="left"
				width="120">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="FILL_ORGAN_NAME" header="填报单位" field="FILL_ORGAN_NAME" align="left"
				width="100">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="AMOUNT" header="拨款金额(万元)" field="AMOUNT" align="right"
				width="100">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="IN_CONFIRM" header="是否下拨" field="IN_CONFIRM" align="center"
				width="70" dataset="commYesOrNoDS">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="NOTE" header="备注" field="NOTE" align="left"
				width="150">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
		</next:Columns>
	</next:GridPanel>
</next:Window>

<!--物资折款追踪-->
<next:Window id="FollowSwapWin" closeAction="hide" title="物资折款追踪"
	width="800" height="330" autoScroll="true" modal="true"
	closable="false">
	<next:GridPanel id="followSwapGrid" width="98%" stripeRows="true"
		height="88%" dataset="disFundsSourceSwapDs">
		<next:TopBar>
			<next:ToolBarItem symbol="物资折款追踪列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="yes" text="查看" handler="onFollowSwapDetail"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="onCloseFollowSwapWin"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column id="DIS_YEAR" header="年度" field="DIS_YEAR" align="left"
				width="60">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="RECEIVE_TIME" header="采购日期" field="RECEIVE_TIME" align="left"
				width="80">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="UP_ALLOCATION_TYPE" header="采购方式" field="UP_ALLOCATION_TYPE" align="center"
				width="80" dataset="disSwapTypeDs">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="FILL_ORGAN_NAME" header="采购单位" field="FILL_ORGAN_NAME" align="left"
				width="100">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="AMOUNT" header="采购金额(万元)" field="AMOUNT" align="right"
				width="100">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="IN_CONFIRM" header="是否使用" field="IN_CONFIRM" align="center"
				width="70" dataset="commYesOrNoDS">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
			<next:Column id="NOTE" header="备注" field="NOTE" align="left"
				width="100">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
		</next:Columns>
	</next:GridPanel>
</next:Window>