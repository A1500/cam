<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<head>
<title>救灾物资采购</title>
<next:ScriptManager />
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript">
	var organCode='<%=BspUtil.getOrganCode()%>';
	var organName='<%=BspUtil.getOrganName()%>';
	var organType='<%=BspUtil.getOrganType()%>';
	var uu32='<%=IdHelp.getUUID32()%>';
	var uu32De='<%=IdHelp.getUUID32()%>';
	var method = '<%=request.getParameter("method")%>';
	var batchId = '<%=request.getParameter("batchId")%>';
	var nowYear='<%=DateUtil.getYear()%>';
</script>
<script type="text/javascript" src="fundsComm.js"></script>
<script type="text/javascript" src="../comm/disComm.js"></script>
<script type="text/javascript" src="fundsGoodSwapEdit.js"></script>
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
	<model:dataset id="disDetailBatchDs"
		cmd="com.inspur.cams.dis.base.cmd.DisDetailBatchQueryCmd">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisDetailBatch">
			<model:field name="disYear" type="string" rule="require"></model:field>
			<model:field name="upAllocationType" type="string" rule="require"></model:field>
			<model:field name="receiveTime" type="string" rule="require"></model:field>
			<model:field name="amount" type="float" rule="require"></model:field>
		</model:record>
	</model:dataset>
	<!--拨付-->
	<model:dataset id="disDetailSourceDs"
		cmd="com.inspur.cams.dis.base.cmd.DisDetailSourceQueryCmd" pageAble="false">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisDetailSource"></model:record>
	</model:dataset>
	<!--拨付明细-->
	<model:dataset id="disDetailBatchSourceDs"
		cmd="com.inspur.cams.dis.base.cmd.DisDetailBatchSourceQueryCmd" method="queryDisDetailBatchSource">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisDetailBatchSource"></model:record>
	</model:dataset>
	<!--拨付使用资金关系表-->
	<model:dataset id="disDetailBatchFundsSourceDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd" method="queryFundsBatchSourceDe">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>
	
	<!--附件-->
	<model:dataset id="disAccessoriesDs"
		cmd="com.inspur.cams.dis.base.cmd.DisAccessoriesQueryCmd"
		pageAble="false" global="true" sortDirection="UPLOAD_TIME DESC,ACCESSORIES_ID">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisAccessories"></model:record>
	</model:dataset>
	
	<!-- 发放物资类型-->
	<model:dataset id="dmDisMaterialTypeDs"
		cmd="com.inspur.cams.dis.base.cmd.DicDisMaterialTypeQueryCmd" autoLoad="true" 
		pageAble="false" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DicDisMaterialType">
	 		<model:field name="value" mapping="code" type="string" />
			<model:field name="text" mapping="name" type="string" />
		</model:record>
	</model:dataset>

	<!-- 资金来源类型 -->
	<model:dataset id="disSourceTypeDs" enumName="DIS.SOURCE_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 采购方式 -->
	<model:dataset id="disSwapTypeDs" enumName="DIS.SWAP_TYPE"
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

<next:ViewPort>
	<next:Panel name="allocationPanel" width="100%">
		<next:TopBar>
			<next:ToolBarItem text="资金拨付基本信息"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="upload" text="附件管理" handler="onStuffer"></next:ToolBarItem>
			<next:ToolBarItem iconCls="edit" text="编辑基本信息" handler="onEditBase"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="返回" handler="onCancel"></next:ToolBarItem>
		</next:TopBar>
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="disDetailBatchDs">
			<table border="0" width="100%">
				<tr>
					<td class="FieldLabel" width="10%">年度:</td>
					<td class="FieldInput"><label field="disYear" /></td>
					<td class="FieldLabel" width="10%">采购方式:</td>
					<td class="FieldInput">
						<label field="upAllocationType" dataset="disSwapTypeDs"/>
					</td>
					<td class="FieldLabel" width="10%">采购日期:</td>
					<td class="FieldInput">
						<label field="receiveTime" />
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" width="10%" rowspan="3">采购金额:</td>
					<td class="FieldInput" rowspan="3"><label field="amount"></label>&nbsp;万元</td>
					<td class="FieldLabel" width="10%">其中，上级下拨:</td>
					<td class="FieldInput"><label id="amountUp"></label>&nbsp;万元</td>
					<td class="FieldLabel" width="10%" rowspan="3">备注:</td>
					<td class="FieldInput" rowspan="3"><label field="note"
						style="width: 80%" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" width="10%">其中，本级投入:</td>
					<td class="FieldInput"><label id="amountSelf"></label>&nbsp;万元</td>
				</tr>
				<tr>
					<td class="FieldLabel" width="10%">其中，社会捐赠:</td>
					<td class="FieldInput"><label id="amountCon"></label>&nbsp;万元</td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:EditGridPanel id="allocationAllGrid" dataset="disDetailBatchSourceDs"
		height="100%" width="100%" hasSum="true" stripeRows="true"
		notSelectFirstRow="true">
		<next:TopBar>
			<next:ToolBarItem text="物资采购明细(单位：万元)"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="add" text="新增" handler="addDetails"/>
			<next:ToolBarItem iconCls="remove" text="删除" handler="removeDetails"/>
			<next:ToolBarItem id="btnAllo" iconCls="save" text="保存" handler="onSave"/>
			<next:ToolBarItem id="btnDepartment" iconCls="yes" text="确认" handler="onConfirm"/>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn width="45" />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header='物资类型' field="meterialType"
				renderer="meterialTypeRenderer" width="130">
				<next:ComboBox dataset="dmDisMaterialTypeDs" typeAble="false" />
			</next:Column>
			<next:Column header="物资单位" field="meterialUnit" align="center" width="80">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="物资数量" field="meterialNum" align="right"
				renderer="formatMoneyForDis" summaryType="sum" width="120">
				<next:ExtendConfig>
		                    summaryRenderer : formatMoneyForDis
		                </next:ExtendConfig>
				<next:TextField />
			</next:Column>
			<next:Column header="物资金额合计(万元)" field="meterialAccount" align="right"
				renderer="formatMoneyForDis" summaryType="sum" width="120">
				<next:ExtendConfig>
		                    summaryRenderer : formatMoneyForDis
		                </next:ExtendConfig>
				<next:TextField />
			</next:Column>
			<next:Column header="备注" field="note" align="left" width="280">
				<next:TextField/>
			</next:Column>
		</next:Columns>
	</next:EditGridPanel>
</next:ViewPort>
</body>
</html>

<!--物资采购基本信息维护-->
<next:Window id="sourceUpWin" width="850" height="480"
	collapsible="false" closable="close" resizable="false" modal="true"
	title="物资采购基本信息维护">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="confirmSaveBase"></next:ToolBarItem>
		<next:ToolBarItem id="btnCancel" iconCls="no" text="取消"
			handler="cancelSaveBase"></next:ToolBarItem>
		<next:ToolBarItem id="btnReturn" iconCls="return" text="返回"
			handler="onCancel"></next:ToolBarItem>
	</next:TopBar>
	<next:Panel width="100%" height="100%">
		<next:Panel>
			<next:Html>
				<form method="post" onsubmit="return false" class="L5form"
					dataset="disDetailBatchDs">
				<table border="0" width="100%">
					<tr>
						<td class="FieldLabel" width="15%">年度:</td>
						<td class="FieldInput"><input type="text" name="年度"
							maxlength="4" field="disYear"><font color="red">*</font></td>
						<td class="FieldLabel" width="15%">采购方式:</td>
						<td class="FieldInput"><select name="采购方式"
							style="width: 68%;" field="upAllocationType" title="采购方式">
							<option dataset="disSwapTypeDs"></option>
						</select><font color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="15%">采购日期:</td>
						<td class="FieldInput"><input type="text"
							field="receiveTime" name="采购日期" format="Y-m-d"
							style="width: 100px;" maxlength="10"
							onpropertychange="changeDateStyle(this)" /><img
							src="../../../../skins/images/default/rl.gif" align="middle"
							onclick="getTimes(this);" /><font color="red">*</font></td>
						<td class="FieldLabel" width="15%">采购金额:</td>
						<td class="FieldInput"><input type="text" name="采购金额"
							field="amount" style="text-align: right;" maxlength="15" />万元<font
							color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="15%">备注:</td>
						<td class="FieldInput" colspan="3"><input type="text" name="备注"
							field="note" maxlength="200" style="width: 90%"/></td>
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
		<next:EditGridPanel id="winGrid" dataset="disDetailBatchFundsSourceDs"
			height="315" width="98%" hasSum="true" stripeRows="true"
			notSelectFirstRow="true">
			<next:TopBar>
				<next:ToolBarItem text="资金来源明细(明细支出金额总和与采购金额绑定)"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="detail" text="明细" />
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn width="45" />
				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column id="sourceId" header="来源表ID" field="sourceId"
					align="center" hidden="true">
					<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column id="disYear" header="年度"
					field="disYear" align="center" width="60">
					<next:TextField allowBlank="false" editable="false" />
				</next:Column>
				<next:Column id="sourceType" header="来源类型"
					field="sourceType" align="center" width="80" dataset="disSourceTypeDs">
					<next:TextField allowBlank="false" editable="false" />
				</next:Column>
				<next:Column id="allocationTime" header="拨款日期" field="allocationTime"
					align="center" width="80">
					<next:TextField allowBlank="false" editable="false"/>
				</next:Column>
				<next:Column id="upAllocationNum" header="拨款文号" field="upAllocationNum"
					align="left" width="80">
					<next:TextField allowBlank="false" editable="false"/>
				</next:Column>
				<next:Column id="upAllocationType" header="拨款类型" field="upAllocationType"
					align="center" width="80" dataset="disAllocationTypeDs">
					<next:TextField allowBlank="false" editable="false"/>
				</next:Column>
				
				<next:Column id="amountBalanceTotal" header="可用金额(万元)" field="amountBalanceTotal"
					align="right" width="90" renderer="formatMoneyForDis" summaryType="sum">
					<next:ExtendConfig>
	                    	summaryRenderer : formatMoneyForDis
	                	</next:ExtendConfig>
					<next:TextField allowBlank="false" editable="false" />
				</next:Column>
				<next:Column id="amountPay" header="<b>支出金额(万元)</b>" field="amountPay"
					align="right" width="95" renderer="formatMoneyForDis" summaryType="sum">
					<next:ExtendConfig>
	                    	summaryRenderer : formatMoneyForDis
	                	</next:ExtendConfig>
					<next:TextField allowBlank="false" />
				</next:Column>
				
				<next:Column id="upAllocationPurpose" header="资金用途" field="upAllocationPurpose"
					align="left" width="100" renderer="upAllocationPurposeRenderer">
					<next:TextField allowBlank="false" editable="false"/>
				</next:Column>
				<next:Column id="note" header="备注" field="note"
					align="left" width="90" renderer="noteRenderer">
					<next:TextField allowBlank="false" editable="false"/>
				</next:Column>
			</next:Columns>
		</next:EditGridPanel>
	</next:Panel>
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
			<next:ToolBarItem iconCls="upload" text="增加上传附件" handler="addUploadFile"></next:ToolBarItem>
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
			<next:Column header="操作" field="" align="left" width="80"
				renderer="delUploadFile">
				<next:TextField allowBlank="false" editable="false" />
			</next:Column>
		</next:Columns>
	</next:GridPanel>
</next:Window>


<!-- 上传附件窗口 -->
<next:Window id="uploadWin" closeAction="hide" title="上传附件" height="230"
	width="666" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="上传" handler="click_upload"></next:ToolBarItem>
		<next:ToolBarItem xtype="tbseparator" />
	</next:TopBar>
	<next:Html>
		<form id="form_content" onsubmit="return false" style="padding: 5px;"
			class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel">附件上传：</td>
				<td class="FieldInput" colspan="5"><input class="file"
					type="file" id="files" name="files" style="width: 95%; height: 40" /></br>
				<span style="color: red">上传文件最大不能超过5M</span></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 20%">附件描述</td>
				<td class="FieldInput" colspan="5" style="width: 80%"><textarea onpropertychange="if(value.length>49) value=value.substr(0,49)"  
					id="fileMess" rows="5" style="width: 95%"  ></textarea></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Window>