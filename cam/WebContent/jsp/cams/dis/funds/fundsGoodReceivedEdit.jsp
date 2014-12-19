<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
<head>
<title>捐赠物资接收</title>
<next:ScriptManager />
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript">
	var organCode='<%=BspUtil.getOrganCode()%>';
	var organName='<%=BspUtil.getOrganName()%>';
	var organType='<%=BspUtil.getOrganType()%>';
	var uu32De='<%=IdHelp.getUUID32()%>';
	var method = '<%=request.getParameter("method")%>';
	var detailId = '<%=request.getParameter("detailId")%>';
</script>
<script type="text/javascript" src="fundsComm.js"></script>
<script type="text/javascript" src="../comm/disComm.js"></script>
<script type="text/javascript" src="fundsGoodReceivedEdit.js"></script>
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
	<model:dataset id="disDetailSourceDs"
		cmd="com.inspur.cams.dis.base.cmd.DisDetailSourceQueryCmd" pageAble="false">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisDetailSource">
			<model:field name="disYear" type="string" rule="require"></model:field>
			<model:field name="allocationTime" type="string" rule="require"></model:field>
		</model:record>
	</model:dataset>
	<!--拨付明细-->
	<model:dataset id="disDetailBatchSourceDs"
		cmd="com.inspur.cams.dis.base.cmd.DisDetailBatchSourceQueryCmd" pageAble="false">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisDetailBatchSource"></model:record>
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
			<next:ToolBarItem text="捐赠物资基本信息"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="upload" text="附件管理" handler="onStuffer"></next:ToolBarItem>
			<next:ToolBarItem id="btnAllo" iconCls="save" text="保存" handler="onSave"/>
			<next:ToolBarItem iconCls="return" text="返回" handler="onCancel"></next:ToolBarItem>
		</next:TopBar>
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="disDetailSourceDs">
			<table border="0" width="100%">
				<tr>
					<td class="FieldLabel" width="15%">年度:</td>
					<td class="FieldInput" width="50%"><input type="text" name="年度"
						maxlength="4" field="disYear"><font color="red">*</font></td>
					
					<td class="FieldLabel" width="10%" rowspan="3">物资用途:</td>
					<td class="FieldInput" rowspan="3"><input type="checkbox"
						name="upAllocationPurpose" value="DC" field="upAllocationPurpose"
						label="冬春生活救助" />冬春生活救助 <br />
					<input type="checkbox" name="upAllocationPurpose" value="YJ"
						field="upAllocationPurpose" label="应急生活救助" />应急生活救助
					<br />
					<input type="checkbox" name="upAllocationPurpose" value="CJ"
						field="upAllocationPurpose" label="灾区民房恢复重建补助 "/>灾区民房恢复重建补助 <br />
					<input type="checkbox" name="upAllocationPurpose" value="GD"
						field="upAllocationPurpose" label="过渡性生活补助"/>过渡性生活补助
					<br />
					<input type="checkbox" name="upAllocationPurpose" value="SW"
						field="upAllocationPurpose" label="遇难人员家属抚慰"/>遇难人员家属抚慰</td>
				</tr>
				<tr>
					<td class="FieldLabel" width="15%">捐赠日期:</td>
					<td class="FieldInput"><input type="text"
						field="allocationTime" name="捐赠日期" format="Y-m-d"
						style="width: 100px;" maxlength="10"
						onpropertychange="changeDateStyle(this)" /><img
						src="../../../../skins/images/default/rl.gif" align="middle"
						onclick="getTimes(this);" /><font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel" width="15%">备注:</td>
					<td class="FieldInput"><input type="text" name="备注"
						field="note" maxlength="200" style="width: 90%"/></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:EditGridPanel id="allocationAllGrid" dataset="disDetailBatchSourceDs"
		height="100%" width="100%" hasSum="true" stripeRows="true"
		notSelectFirstRow="true">
		<next:TopBar>
			<next:ToolBarItem text="捐赠物资明细(单位：万元)"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="add" text="新增" handler="addDetails"/>
			<next:ToolBarItem iconCls="remove" text="删除" handler="removeDetails"/>
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
			<next:Column header="备注" field="note" align="left" width="250">
				<next:TextField/>
			</next:Column>
		</next:Columns>
	</next:EditGridPanel>
</next:ViewPort>
</body>
</html>

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