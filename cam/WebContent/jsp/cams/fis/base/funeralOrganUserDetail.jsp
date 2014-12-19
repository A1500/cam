<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>殡仪馆信息编辑</title>
<next:ScriptManager />
<script type="text/javascript" src="funeralOrganUserDetail.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="../funeral/PublicTimeControl.js"></script>
<script type="text/javascript">
	var method = "<%=request.getParameter("method")%>";
	var unitId = "<%=request.getParameter("unitId")%>";
	var organCode = "<%=request.getParameter("organCode")%>";
</script>
</head>
<body>

<model:datasets>
	<!-- 殡仪馆信息 -->
	<model:dataset id="ds"
		cmd="com.inspur.cams.fis.base.cmd.FisFuneralOrganManageQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.fis.base.data.FisFuneralOrganManage"></model:record>
	</model:dataset>
	<!--殡仪馆建筑面积信息-->
	<model:dataset id="FisFuneralOrganBuildareaDs"
		cmd="com.inspur.cams.fis.base.cmd.FisFuneralOrganBuildareaQueryCmd"
		global="true" pageAble="false">
		<model:record
			fromBean="com.inspur.cams.fis.base.data.FisFuneralOrganBuildarea"></model:record>
	</model:dataset>
	<!--设备-->
	<model:dataset id="fisEquipmentInfoDS"
		cmd="com.inspur.cams.fis.base.cmd.FisEquipmentInfoQueryCmd"
		sortField="RESOURCE_TYPE">
		<model:record
			fromBean="com.inspur.cams.fis.base.data.FisEquipmentInfo"></model:record>
	</model:dataset>
	<!--设备明细编辑-->
	<model:dataset id="fisEquipmentInfoEditDS"
		cmd="com.inspur.cams.fis.base.cmd.FisEquipmentInfoQueryCmd">
		<model:record
			fromBean="com.inspur.cams.fis.base.data.FisEquipmentInfo">
			<model:field name="equipmentCode" type="string" rule="require" />
			<model:field name="equipmentName" type="string" rule="require" />
			<model:field name="status" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!--设施-->
	<model:dataset id="fisFacilitiesInfoDS"
		cmd="com.inspur.cams.fis.base.cmd.FisFacilitiesInfoQueryCmd"
		sortField="RESOURCE_TYPE">
		<model:record
			fromBean="com.inspur.cams.fis.base.data.FisFacilitiesInfo"></model:record>
	</model:dataset>
	<!--设施明细编辑-->
	<model:dataset id="fisFacilitiesInfoEditDS"
		cmd="com.inspur.cams.fis.base.cmd.FisFacilitiesInfoQueryCmd">
		<model:record
			fromBean="com.inspur.cams.fis.base.data.FisFacilitiesInfo">
			<model:field name="facilitiesCode" type="string" rule="require" />
			<model:field name="facilitiesName" type="string" rule="require" />
			<model:field name="useDate" type="string" rule="require" />
			<model:field name="area" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!--设备类型-->
	<model:dataset id="fisResourceTypeDS"
		cmd="com.inspur.cams.fis.base.cmd.FisResourceTypeQueryCmd"
		pageSize="-1" global="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisResourceType">
			<model:field name="value" mapping="resourceType" type="string" />
			<model:field name="text" mapping="typeName" type="string" />
		</model:record>
	</model:dataset>
	<!--设施设备使用状态-->
	<model:dataset id="statusDS" enumName="FIS.STATUS" autoLoad="true"
		global="true"></model:dataset>
	<!-- 性质 -->
	<model:dataset id="propertiesDataSet"
		enumName="FIS.FUNERALHOME.PROPERTIES" autoLoad="true" global="true"></model:dataset>
	<!-- 级别 -->
	<model:dataset id="titleDataSet" enumName="FIS.FUNERALHOME.TITLE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 殡葬改革示范单位 -->
	<model:dataset id="demonUnitDataSet"
		enumName="FIS.FUNERALHOME.DEMONUNIT" autoLoad="true" global="true"></model:dataset>
	<!-- 等级 -->
	<model:dataset id="gradeDataSet" enumName="FIS.FUNERALHOME.GRADE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 建筑区域 -->
	<model:dataset id="buildAreaDataSet"
		enumName="FIS.FUNERALHOME.BUILDAREA" autoLoad="true" global="true"></model:dataset>

</model:datasets>

<next:ViewPort>
	<next:Panel width="100%" height="100%">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="print" text="打印" hidden="true"/>
			<next:ToolBarItem iconCls="return" text="返回" handler="goBack"  hidden="true"/>
		</next:TopBar>
		<next:TabPanel width="100%" height="100%" id="tab">
			<next:Tabs>
				<next:Panel height="100%" width="100%" autoScroll="true"
					title="基本信息">
					<next:Html>
						<form id="editForm" dataset="ds" onsubmit="return false"
							class="L5form">
						<table border="1" width="100%" height="100%">

							<tr>
								<td class="FieldLabel" width="135">用户名</td>
								<td class="FieldInput"><label name="用户名" field="organCode" /></td>

								<td class="FieldLabel" width="135">殡仪馆编号</td>
								<td class="FieldInput"><label name="殡仪馆编号" field="unitId" /></td>
							</tr>
							<tr>
								<td class="FieldLabel" width="135">殡仪馆名称</td>
								<td class="FieldInput"><label name="殡仪馆名称" field="unitName" /></td>

								<td class="FieldLabel" width="135">组织机构代码</td>
								<td class="FieldInput"><label name="组织机构代码"
									field="unitCode" /></td>
							</tr>
							<tr>
								<td class="FieldLabel" width="135">主管单位</td>
								<td class="FieldInput"><label id="parentOrganName"
									name="主管单位名称" field="parentOrganName" /></td>

								<td class="FieldLabel" width="135">所属行政区</td>
								<td class="FieldInput"><label id="areaName" name="所属行政区"
									field="areaName" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">性质</td>
								<td class="FieldInput"><label name="properties"
									field="properties" dataset="propertiesDataSet" /></td>

								<td class="FieldLabel">法人代表</td>
								<td class="FieldInput"><label name="legalPeople"
									field="legalPeople" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">编制人数(人)</td>
								<td class="FieldInput"><label id="numberOf" name="numberOf"
									style="text-align: right" field="numberOf" /></td>

								<td class="FieldLabel">实有人数(人)</td>
								<td class="FieldInput"><label id="numberReal" name="实有人数"
									style="text-align: right" field="numberReal" /></td>


							</tr>
							<tr>
								<td class="FieldLabel">占地面积(㎡)</td>
								<td class="FieldInput"><label name="占地面积" id="builtArea"
									style="text-align: right" field="builtArea" /></td>
								<td class="FieldLabel">建筑面积(㎡)</td>
								<td class="FieldInput"><label name="建筑面积"
									id="builtTotalArea" style="text-align: right"
									field="builtTotalArea" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">成立时间</td>
								<td class="FieldInput"><label id="qStartTime" name="成立时间"
									field="gestionTime" /></td>
								<td class="FieldLabel">级别</td>
								<td class="FieldInput"><label name="title" field="title"
									dataset="titleDataSet" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">所在地址</td>
								<td class="FieldInput"><label name="address"
									maxlength="100" field="address" /></td>

								<td class="FieldLabel">邮政编码</td>
								<td class="FieldInput"><label name="portCode" maxlength="6"
									field="portCode" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">服务电话</td>
								<td class="FieldInput"><label name="servicePhone"
									maxlength="16" field="servicePhone" /></td>

								<td class="FieldLabel">网站网址</td>
								<td class="FieldInput"><label name="web" maxlength="50"
									field="web" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">电子邮件地址</td>
								<td class="FieldInput"><label name="email" maxlength="50"
									field="email" /></td>

								<td class="FieldLabel">QQ群</td>
								<td class="FieldInput"><label name="qq" field="qq"
									maxlength="15" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">殡葬改革示范单位</td>
								<td class="FieldInput"><label name="demonUnit"
									field="demonUnit" dataset="demonUnitDataSet" /></td>
								<td class="FieldLabel">等级</td>
								<td class="FieldInput"><label name="grade" field="grade"
									dataset="gradeDataSet" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">服务内容</td>
								<td class="FieldInput"><input type="checkbox"
									name="serviceScope" value="1" field="serviceScope" label="殡仪服务"
									disabled="disabled" />殡仪服务 <br />
								<input type="checkbox" name="serviceScope" value="2"
									field="serviceScope" label="骨灰寄存" disabled="disabled" />骨灰寄存 <br />
								<input type="checkbox" name="serviceScope" value="3"
									field="serviceScope" label="殡葬用品销售 " disabled="disabled" />殡葬用品销售
								<br />
								<input type="checkbox" name="serviceScope" value="4"
									field="serviceScope" label="骨灰安葬" disabled="disabled" />骨灰安葬 <br />
								<input type="checkbox" name="serviceScope" value="5"
									field="serviceScope" label="国际运尸" disabled="disabled" />国际运尸</td>
								<td class="FieldLabel">固定资产（万元）</td>
								<td class="FieldInput"><label name="fixedAssets"
									id="fixedAssets" maxlength="9" style="text-align: right"
									field="fixedAssets" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">受表彰情况</td>
								<td class="FieldInput" colspan="3"><textarea rows="5"
									name="受表彰情况" style="width: 80%" field="honours"
									readonly="readonly" disabled="disabled"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel">备注</td>
								<td class="FieldInput" colspan="3"><textarea name="备注"
									field="note" style="width: 80%" readonly="readonly"
									disabled="disabled" /> </td>
							</tr>
						</table>
						</form>
					</next:Html>
				</next:Panel>
				
				<next:GridPanel id="chargedetailPanel"
					dataset="FisFuneralOrganBuildareaDs" notSelectFirstRow="true"
					name="chargedetailGrid" width="100%" autoScroll="true"
					hasSum="true" stripeRows="true" height="100%" title="建设情况">
					<next:TopBar>
						<next:ToolBarItem symbol="建设情况"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="45"></next:RowNumberColumn>
						<next:Column id="areaId" header="名称" field="areaId" width="140"
							dataset="buildAreaDataSet">
							<next:TextField allowBlank="false" editable="false" />
						</next:Column>
						<next:Column id="areaNum" header="面积(㎡)" field="areaNum"
							width="120" align="right" summaryType="sum"
							renderer="getMoneyFormat">
							<next:ExtendConfig>
			                    summaryRenderer : getMoneyFormat
			                  </next:ExtendConfig>
							<next:TextField allowBlank="false" />
						</next:Column>
					</next:Columns>
				</next:GridPanel>

				<next:Panel height="100%" width="100%" title="设备信息">
					<next:Html>
						<next:GridPanel id="editGridPanelEqu" name="editGridPanelEqu"
							height="100%" stripeRows="true" dataset="fisEquipmentInfoDS"
							notSelectFirstRow="true" autoScroll="true">
							<next:TopBar>
								<next:ToolBarItem symbol="设备信息列表"></next:ToolBarItem>
								<next:ToolBarItem symbol="->"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn width="30" />
								<next:Column id="resourceType" header='设备类型'
									field="resourceType" width="100" dataset="fisResourceTypeDS"
									align="center">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="equipmentName" header='设备名称'
									field="equipmentName" width="100"
									renderer="equipmentDetailHref">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="equipmentCode" header='设备编号'
									field="equipmentCode" width="120">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="manufacturer" header='设备厂商'
									field="manufacturer" width="120">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="phone" header='厂商联系电话' field="phone"
									width="100">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="purchaseMoney" header='采购价格(元)'
									field="purchaseMoney" align="right" width="100">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="purchaseDate" header='采购日期'
									field="purchaseDate" width="80">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="useDate" header='投入使用时间' field="useDate"
									width="80">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="status" header='状态' field="status" width="80"
									dataset="statusDS">
									<next:TextField />
								</next:Column>
							</next:Columns>
							<next:BottomBar>
								<next:PagingToolBar dataset="fisEquipmentInfoDS"></next:PagingToolBar>
							</next:BottomBar>
						</next:GridPanel>
					</next:Html>
				</next:Panel>

				<next:Panel height="100%" width="100%" title="设施信息">
					<next:Html>
						<next:GridPanel id="editGridPanelFac" name="editGridPanelFac"
							height="100%" stripeRows="true" dataset="fisFacilitiesInfoDS"
							notSelectFirstRow="true" autoScroll="true">
							<next:TopBar>
								<next:ToolBarItem symbol="设施信息列表"></next:ToolBarItem>
								<next:ToolBarItem symbol="->"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn width="30" />
								<next:Column id="resourceType" header='设施类型'
									field="resourceType" width="100" dataset="fisResourceTypeDS"
									align="center">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="facilitiesName" header='设施名称'
									field="facilitiesName" width="100"
									renderer="facilitiesDetailHref">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="facilitiesCode" header='设施编号'
									field="facilitiesCode" width="120">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="useDate" header='投入使用时间' field="useDate"
									width="90">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="area" header='占地面积(㎡)' field="area" width="80"
									align="right">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="facilitiesDesc" header='描述'
									field="facilitiesDesc" width="80">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="status" header='状态' field="status"
									dataset="statusDS" width="80">
									<next:TextField allowBlank="false" />
								</next:Column>
							</next:Columns>
							<next:BottomBar>
								<next:PagingToolBar dataset="fisFacilitiesInfoDS"></next:PagingToolBar>
							</next:BottomBar>
						</next:GridPanel>
					</next:Html>
				</next:Panel>
			</next:Tabs>
		</next:TabPanel>
	</next:Panel>
</next:ViewPort>
</body>

<!--设备明细window-->
<next:Window id="equipmentWindowDetail" title="设备维护" width="700"
	height="300" collapsible="false" closeAction="hide" resizable="false">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeEquDetail"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="cyjbxxForm" method="post" onsubmit="return false"
			dataset="fisEquipmentInfoEditDS" class="L5form">
		<table border="0" width="100%" height="100%">
			<tr>
				<td class="FieldLabel" width="12%">设备编号:</td>
				<td class="FieldInput" width="20%"><label field="equipmentCode"
					style="width: 90%"></label></td>
				<td class="FieldLabel" width="10%">设备名称:</td>
				<td class="FieldInput" width="20%"><label field="equipmentName"
					style="width: 90%"></label></td>
				<td class="FieldLabel" width="10%">设备厂商:</td>
				<td class="FieldInput" width="20%"><label field="manufacturer"
					style="width: 90%"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel">厂商联系电话:</td>
				<td class="FieldInput"><label field="phone" style="width: 90%"></label>
				</td>
				<td class="FieldLabel">规格型号:</td>
				<td class="FieldInput"><label field="equipmentFormat"
					style="width: 90%"></label></td>
				<td class="FieldLabel">签定文号:</td>
				<td class="FieldInput"><label field="fileCode"
					style="width: 90%"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel">采购价格:<br />
				(单位:元)</td>
				<td class="FieldInput"><label field="purchaseMoney"
					style="width: 90%"></label></td>
				<td class="FieldLabel">采购单位:</td>
				<td class="FieldInput"><label field="purchaseOrgan"
					style="width: 90%"></label></td>
				<td class="FieldLabel">采购日期:</td>
				<td class="FieldInput"><label field="purchaseDate"
					style="width: 90%"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel">投入使用日期:</td>
				<td class="FieldInput"><label field="useDate"
					style="width: 90%"></label></td>
				<td class="FieldLabel">报废日期:</td>
				<td class="FieldInput"><label field="scrapDate"
					style="width: 90%"></label></td>
				<td class="FieldLabel">设备状态:</td>
				<td class="FieldInput"><label field="status" style="width: 90%"
					dataset="statusDS"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel">描述:</td>
				<td class="FieldInput" colspan="5"><textArea
					field="equipmentDesc" rows="2" readonly="readonly"
					style="width: 95%"></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel">备注:</td>
				<td class="FieldInput" colspan="5"><textArea field="note"
					rows="2" readonly="readonly" style="width: 95%"></textArea></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Window>

<!--设施明细window-->
<next:Window id="facilitiesWindowDetail" title="设施维护" width="550"
	height="280" collapsible="false" closeAction="hide" resizable="false">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeFacDetail"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="cyjbxxForm" method="post" onsubmit="return false"
			dataset="fisFacilitiesInfoEditDS" class="L5form">
		<table border="0" width="100%">
			<tr>
				<td class="FieldLabel" width="10%">设施编号:</td>
				<td class="FieldInput" width="20%"><label
					field="facilitiesCode" style="width: 80%"></label></td>
				<td class="FieldLabel" width="10%">设施名称:</td>
				<td class="FieldInput" width="20%"><label id="facilitiesName"
					field="facilitiesName" style="width: 80%"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel" width="10%">投入使用日期:</td>
				<td class="FieldInput" width="20%"><label id="useDate"
					field="useDate" style="width: 80%"></label></td>
				<td class="FieldLabel">占地面积:<br />
				(单位:平方米)</td>
				<td class="FieldInput"><label id="area" field="area"
					style="width: 80%"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel">停用时间:</td>
				<td class="FieldInput"><label id="stopDate" field="stopDate"
					style="width: 80%"></label></td>
				<td class="FieldLabel">设施状态:</td>
				<td class="FieldInput"><label id="status" field="status"
					style="width: 80%" dataset="statusDS"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel">描述:</td>
				<td class="FieldInput" colspan="3"><textArea
					id="facilitiesDesc" field="facilitiesDesc" rows="2"
					readonly="readonly" style="width: 90%"></textArea></td>
			<tr />
			<tr>
				<td class="FieldLabel">备注:</td>
				<td class="FieldInput" colspan="3"><textArea id="note"
					field="note" rows="2" readonly="readonly" style="width: 90%"></textArea>
				</td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Window>