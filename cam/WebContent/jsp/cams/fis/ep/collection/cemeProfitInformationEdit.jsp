<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>经营性公墓信息</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script>
		var idField='<%=request.getParameter("dataBean")%>';
		var method='<%=request.getParameter("method")%>';
		var prop = "2";	//标识：此页面默认的公墓性质为经营性公墓
</script>
<script type="text/javascript" src="../ep.js"></script>
<script type="text/javascript" src="cemeProfitInformationEdit.js"></script>
</head>
<body>

<model:datasets>
	<!--公墓基本信息-->
	<model:dataset id="ds"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.fis.ep.base.data.FisCeme">
			<model:field name="cemeId" type="string" rule="require" />
			<model:field name="cemeName" type="string" rule="require" />
			<model:field name="manaLevel" type="string" rule="require" />
			<model:field name="manaLevelId" type="string" rule="require" />
			<model:field name="areaLevel" type="string" rule="require" />
			<model:field name="areaLevelId" type="string" rule="require" />
			<model:field name="directorMobile" type="string" rule="require" />
			<model:field name="gestionTime" type="string" rule="require" />
			<model:field name="totalArea" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!--公墓审批事项-->
	<model:dataset id="itemDs"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeItemsCmd" global="true"
		pageSize="-1">
		<model:record fromBean="com.inspur.cams.fis.ep.base.data.FisCemeItems">
			<model:field name="itemId" type="string" rule="require" />
			<model:field name="itemTime" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!--政府部门批准文号-->
	<model:dataset id="govAppDs"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeGovApprovalCmd"
		global="true" pageSize="-1">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeGovApproval">
			<model:field name="itemId" type="string" rule="require" />
			<model:field name="deptId" type="string" rule="require" />
			<model:field name="deptNum" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!--土地证-->
	<model:dataset id="landcardDs"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeLandcardCmd" global="true"
		pageSize="-1">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeLandcard">
			<model:field name="landNum" type="string" rule="require" />
			<model:field name="itemId" type="string" rule="require" />
			<model:field name="landArea" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!--公墓审批事项类型-->
	<model:dataset id="itemTypeDs" enumName="FIS.CEME.ITEMS"
		autoLoad="true" global="true"></model:dataset>
	<!--公墓建立时需要审批的政府部门-->
	<model:dataset id="govDeptDs" enumName="FIS.CEME.GOV.DEPARTMENT"
		autoLoad="true" global="true"></model:dataset>
	<!--单位性质-->
	<model:dataset id="unitPropertiesDataSet"
		enumName="FIS.CEME.UNITPROPERTIES" autoLoad="true" global="true"></model:dataset>
	<!--公墓性质-->
	<model:dataset id="propDataSet" enumName="FIS.CEME.PROP"
		autoLoad="true" global="true"></model:dataset>
	<!--计量单位-->
	<model:dataset id="AreaUnitsDataSet" enumName="FIS.CEME.AREAUNITS"
		autoLoad="true" global="true"></model:dataset>
	<!--土地证-占地性质-->
	<model:dataset id="landPropDataSet" enumName="FIS.CEME.LANDPROP"
		autoLoad="true" global="true"></model:dataset>
	<!--土地证-土地用途-->
	<model:dataset id="landUseDataSet" enumName="FIS.CEME.LANDUSE"
		autoLoad="true" global="true"></model:dataset>
	<!--土地证-土地使用形式-->
	<model:dataset id="landUseFormDataSet" enumName="FIS.CEME.LANDUSEFORM"
		autoLoad="true" global="true"></model:dataset>
	<!--管辖级别-->
	<model:dataset id="cemeDominationDataSet" enumName="FIS.CEME.DOMINATION" 
		autoLoad="true" global="true"></model:dataset>			
</model:datasets>

<next:Panel autoHeight="true" autoScroll="true">
	<next:Panel autoHeight="true" autoWidth="true" autoScroll="false">
		<next:TopBar>
			<next:ToolBarItem id="qrToolbar" text="经营性公墓信息"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="save" text="保存" handler="save" />
			<next:ToolBarItem iconCls="return" text="返回" handler="back"
				id="return" />
			<next:ToolBarItem iconCls="detail" text="补录说明" handler="detail"
				hidden="true" />
		</next:TopBar>
		<next:Html>
			<form id="editForm" method="post" dataset="ds"
				onsubmit="return false" class="L5form">
			<fieldset><legend>单位信息</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 15%">公墓名称</td>
					<td class="FieldInput" style="width: 15%"><input type="text" id="cemeName"
						style="width: 200px" name="公墓名称" field="cemeName" title="补录公墓的全称" maxlength="25"/></td>

					<td class="FieldLabel" style="width: 15%">公墓编号</td>
					<td class="FieldInput" style="width: 15%"><input type="text"
						id="cemeId" name="公墓编号" field="cemeId" 
						title="民政部门授予的全省唯一编码,自动生成，\n请按主管单位的批准时间录入公墓信息" maxlength="11" /></td>
					<td class="FieldLabel" style="width: 15%">性质</td>
					<td class="FieldInput" style="width: 15%"><label title="性质">经营性</label> <input
						type="hidden" name="prop" field="prop" title="公墓性质"></input></td>						
					
				</tr>
				<tr>
					<td class="FieldLabel">单位性质</td>
					<td class="FieldInput"><select name="单位性质" id="unitProperties"
						field="unitProperties">
						<option dataset="unitPropertiesDataSet"></option>
					</select></td>	
					<td class="FieldLabel">组织机构代码</td>
					<td class="FieldInput" colspan="3"><input type="text" name="组织机构代码"
						field="organCode" maxlength="25" style="width: 200px;" /></td>
					
				</tr>
				<tr>
					<td class="FieldLabel">管辖级别</td>
					<td class="FieldInput"><select name="管辖级别" id="domination"
						field="domination">	<option dataset="cemeDominationDataSet"></option></select></td>
					<td class="FieldLabel">主管单位</td>
					<td class="FieldInput" colspan="3"><input type="text" name="主管单位"
						id="manaLevel" field="manaLevel" readonly="readonly"/> <input
						type="text" id="manaLevelId" field="manaLevelId"
						style="display: none;"/> 
						<button  style="cursor: hand" onclick="selectOrgan()">选择</button></td>	
				</tr>			
				<tr>
					<td class="FieldLabel">主办单位</td>
					<td class="FieldInput"><input type="text" name="主办单位"
						field="organizer" maxlength="25" style="width: 200px;" /></td>
					<td class="FieldLabel">主办单位性质</td>
					<td class="FieldInput" colspan="3"><input type="text" name="主办单位性质" 
					    field="organizerProperties" maxlength="25" style="width: 200px;" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">联办单位</td>
					<td class="FieldInput"><input type="text" name="联办单位"
						field="coOrganizer" maxlength="25" style="width: 200px;" /></td>
					<td class="FieldLabel">联办单位性质</td>
					<td class="FieldInput" colspan="3"><input type="text" name="联办单位性质" 
					    field="coOrganizerProperties" maxlength="25" style="width: 200px;" /></td>
				</tr>	

				<tr>														
					<td class="FieldLabel">所属行政区</td>
					<td class="FieldInput"><input type="text" name="所属行政区"
						id="areaLevel" field="areaLevel" readonly="readonly" /> <input
						type="text" id="areaLevelId" field="areaLevelId"
						style="display: none;" /> <button  style="cursor: hand" onclick="selectArea()">选择</button></td>
					<td class="FieldLabel" >所在位置</td>
					<td class="FieldInput" ><input type="text"
						name="公墓所在位置" field="address" style="width: 200px" maxlength="100" /></td>
					<td class="FieldLabel">邮编</td>
					<td class="FieldInput"><input type="text" name="邮政编码"
						field="postalcode" id="postalcode" maxlength="6"
						onchange="checkPostCode(this.id)" /></td>							
				</tr>
				<tr>
					<td class="FieldLabel">法人代表</td>
					<td class="FieldInput"><input type="text" name="法人代表"
						field="legalPerson" maxlength="20" /></td>
					<td class="FieldLabel">联系电话</td>
					<td class="FieldInput" colspan="3"><input type="text" name="联系电话"
						field="officePhone" style="width: 200px" id="officePhone" maxlength="50"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">负责人</td>
					<td class="FieldInput"><input type="text" name="负责人"
						field="director" maxlength="20" /></td>				
					<td class="FieldLabel">联系电话</td>
					<td class="FieldInput" colspan="3"><input type="text" name="联系电话"
						id="directorMobile" style="width: 200px" field="directorMobile" maxlength="50"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">编制人数</td>
					<td class="FieldInput"><input type="text" name="编制人数"
						id="numberOf" field="numberOf" maxlength="9" style="text-align: right" 
						onchange="checkNum(this.id)" />人</td>
					<td class="FieldLabel">职工总数</td>
					<td class="FieldInput"><input type="text" name="职工总数"
						id="totalStaff" field="totalStaff" maxlength="9" style="text-align: right" 
						onchange="checkNum(this.id)" />人</td>
					<td class="FieldLabel">业务培训人数</td>
					<td class="FieldInput"><input type="text" name="业务培训人数" style="text-align: right" 
						id="trainNum" field="trainNum" maxlength="9"	onchange="checkNum(this.id)" 
						title="参加民政部门业务培训人数" />人</td>						
				</tr>					
				<tr>
					<td class="FieldLabel">计算机管理员</td>
					<td class="FieldInput"><input type="text" name="计算机管理员" style="text-align: right" 
						field="computerManager" maxlength="20" /></td>				
					<td class="FieldLabel">联系电话</td>
					<td class="FieldInput" colspan="3"><input type="text" name="联系电话"
						id="computerManagerPone" style="width: 200px" field="computerManagerPhone" maxlength="50" /></td>
				</tr>		
				<tr>
					<td class="FieldLabel">计算机数量</td>
					<td class="FieldInput"><input type="text" name="计算机数量" id="computerNum" style="text-align: right" 
						field="computerNum" maxlength="3" onchange="checkNum(this.id)" />台</td>				
					<td class="FieldLabel">信息系统安装时间</td>
					<td class="FieldInput" colspan="3"><input type="text" name="信息系统安装时间"
						id="FIX_TIME" field="fixTime" format="Y-m-d" onclick="LoushangDate(this)"/></td>
				</tr>							
				<tr>
					<td class="FieldLabel">网址</td>
					<td class="FieldInput"><input type="text"
						name="网址" field="web" style="width: 200px" maxlength="100" /></td>
					<td class="FieldLabel">电子邮件地址</td>
					<td class="FieldInput"><input type="text"
						name="电子邮件地址" field="email" style="width: 200px" maxlength="100" /></td>
				<td class="FieldLabel">服务电话</td>
				<td class="FieldInput"><input type="text" name="服务电话" maxlength="16"
					field="servicePhone" /></td>
				</tr>	
				<tr>
					<td class="FieldLabel">批准建设时间</td>
					<td class="FieldInput"><input type="text" name="批准建设时间"
						field="approveTime" format="Y-m-d" onclick="LoushangDate(this)"
						readonly="readonly" /></td>
					<td class="FieldLabel">正式营业时间</td>
					<td class="FieldInput"><input type="text" name="正式营业时间"
						field="gestionTime" format="Y-m-d" onclick="LoushangDate(this)"
						readonly="readonly" /></td>				
					<td class="FieldLabel">计划使用年限至</td>
					<td class="FieldInput"><input type="text" name="计划使用年限至"
						id="yearPlanto" style="text-align: right" field="yearPlanto" maxlength="4" title="计划墓穴哪年安葬满，格式：yyyy" />年</td>					
				</tr>							
				<tr>
					<td class="FieldLabel">占用土地性质</td>
					<td class="FieldInput" ><input type="text"
						name="占用土地性质" field="landProperties" style="width: 200px" maxlength="20" /></td>				
					<td class="FieldLabel">公墓占地面积</td>
					<td class="FieldInput"><input type="text"
						style="text-align: right" name="公墓占地面积" field="totalArea"
						id="totalArea" onchange="checkAssMon(this.id)" maxlength="12" />亩<!--
					&nbsp; <select name="公墓占地面积计量单位" id="totalAreaUnits"
						field="totalAreaUnits" style="width: 60px">
						<option dataset="AreaUnitsDataSet"></option>
					</select>--></td>
					<td class="FieldLabel">墓区建成面积</td>
					<td class="FieldInput"><input type="text"
						style="text-align: right" name="墓区建成面积" field="builtArea"
						id="builtArea" onchange="checkAssMon(this.id)" maxlength="12" />亩<!--
					&nbsp; <select name="墓区建成面积计量单位" id="builtAreaUnits"
						field="builtAreaUnits" style="width: 60px">
						<option dataset="AreaUnitsDataSet"></option>
					</select>
					--></td>					
				</tr>				
				<tr>
					<td class="FieldLabel">建筑面积</td>
					<td class="FieldInput"><input type="text"
						style="text-align: right" name="建筑总面积" field="builtTotalArea"
						id="builtTotalArea" onchange="checkAssMon(this.id)" maxlength="12" />㎡</td>							
					<td class="FieldLabel">营业室面积</td>
					<td class="FieldInput"><input type="text"
						style="text-align: right" name="营业室面积" field="businessArea"
						id="BUSINESS_AREA" onchange="checkAssMon(this.id)" maxlength="12" />㎡</td>	
					<td class="FieldLabel">档案室面积</td>
					<td class="FieldInput"><input type="text"
						style="text-align: right" name="档案室面积" field="filesroomArea"
						id="filesroomArea" onchange="checkAssMon(this.id)" maxlength="12" />㎡</td>							
				</tr>
				<tr>
					<td class="FieldLabel">办公室面积</td>
					<td class="FieldInput"><input type="text"
						style="text-align: right" name="办公室面积" field="officeromArea"
						id="officeromArea" onchange="checkAssMon(this.id)" maxlength="12" />㎡</td>							
					<td class="FieldLabel">绿地面积</td>
					<td class="FieldInput"><input type="text"
						style="text-align: right" name="绿地面积" field="greenArea"
						id="greenArea" onchange="checkAssMon(this.id)" maxlength="12" />㎡</td>	
					<td class="FieldLabel">绿化覆盖率</td>
					<td class="FieldInput"><input type="text"
						style="text-align: right" name="绿化覆盖率" field="greenRatio"
						id="greenRatio" onchange="checkAssMon(this.id)" maxlength="12" />%</td>							
				</tr>
				<tr>
					<td class="FieldLabel">总投资额</td>
					<td class="FieldInput"><input type="text" name="总投资额"
						style="text-align: right" field="totalInvestment"
						id="totalInvestment" onchange="checkAssMon(this.id)"
						maxlength="12" />万元</td>
					<td class="FieldLabel">固定资产</td>
					<td class="FieldInput" colspan="3"><input type="text" name="固定资产"
						style="text-align: right" field="fixeDassets" id="fixeDassets"
						onchange="checkAssMon(this.id)" maxlength="12" />万元</td>
				</tr>		
				<tr>
					<td class="FieldLabel">建设资金合计</td>
					<td class="FieldInput">
							<label name="建设资金合计"
								style="text-align: right" field="fundTotal" id="fundTotal"
									onchange="getFundTotal(this)"  maxlength="12" ></label>万元
					</td>
					<td class="FieldLabel">其中财政拨款</td>
					<td class="FieldInput">
							<input type="text" name="其中财政拨款"
										style="text-align: right" field="fundFinance" id="fundFinance"
											onchange="getFundTotal(this)"  maxlength="12" />
					</td>
					<td class="FieldLabel">其中上级部门拨款</td>											
					<td class="FieldInput">		
							<input type="text" name="上级部门拨款"
								style="text-align: right" field="fundHigher" id="fundHigher"
									onchange="getFundTotal(this)"  maxlength="12" />	万元
					</td>	
				</tr>	
				<tr>
					<td class="FieldLabel">其中自筹</td>
					<td class="FieldInput">	
							<input type="text" name="自筹"
								style="text-align: right" field="fundSelf" id="fundSelf"
									onchange="getFundTotal(this)"  maxlength="12" />万元
					</td>
					<td class="FieldLabel">其中福彩资助</td>
					<td class="FieldInput">						
							<input type="text" name="福彩资助"
								style="text-align: right" field="fundLottery" id="fundLottery"
									onchange="getFundTotal(this)"  maxlength="12" />万元	
					</td>
					<td class="FieldLabel">其中其他</td>
					<td class="FieldInput">						
									<input type="text" name="其他"
										style="text-align: right" field="fundOther" id="fundOther"
											onchange="getFundTotal(this)"  maxlength="12" />	万元																					
					</td>	
				</tr>					
				<tr>				
								<td class="FieldLabel" style="width: 15%">服务范围</td>
								<td class="FieldInput" colspan="5"><input type="checkbox" name="服务范围" value="1" 
					field="serviceScope" label="殡仪服务" />殡仪服务 <br />
				<input type="checkbox" name="serviceScope" value="2"
					field="serviceScope" label="骨灰寄存" />骨灰寄存 <br />
				<input type="checkbox" name="serviceScope" value="3"
					field="serviceScope" label="殡葬用品销售 " />殡葬用品销售 <br />
				<input type="checkbox" name="serviceScope" value="4"
					field="serviceScope" label="骨灰安葬" />骨灰安葬 <br/>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">经营管理方式</td>
					<td class="FieldInput" style="width: 75%" colspan="5"><textarea
						onpropertychange="if(value.length>49) value=value.substr(0,49)"
						rows="3" maxlength="49" name='经营管理方式' field="manageStyle"
						style="width: 90%"></textarea></td>
				</tr>					
				<tr>
					<td class="FieldLabel" style="width: 15%">备注</td>
					<td class="FieldInput" style="width: 75%" colspan="5"><textarea
						onpropertychange="if(value.length>49) value=value.substr(0,49)"
						rows="3" maxlength="49" name='备注' field="note"
						style="width: 90%"></textarea></textarea></td>
				</tr>				
			</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>
	<next:Panel autoWidth="true" height="300">
		<next:TabPanel id="tabpanel" name="tabpanel-div">
			<next:Tabs>
				<next:EditGridPanel title="历史记录" id="itemGridPanel"
					name="itemGridPanel" stripeRows="true" height="300" width="98%" 
					dataset="itemDs" notSelectFirstRow="true" autoExpandColumn="itemDesc">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem text="新增" iconCls="add" handler="addAppItem" />
						<next:ToolBarItem text="修改" iconCls="edit" handler="updateAppItem" />
						<next:ToolBarItem text="删除" iconCls="remove"
							handler="removeAppItem" />
						<next:ToolBarItem symbol=""></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="itemId" header="编号" field="itemId" sortable="false" hidden="true">
							<next:TextField />
						</next:Column>
						<next:Column id="itemDic" header="事项" field="itemDic" width="160"
							sortable="false">
							<next:ComboBox triggerAction="all" dataset="itemTypeDs"
								typeAble="false"></next:ComboBox>
						</next:Column>
						<next:Column id="itemTime" header="批准时间" field="itemTime"
							width="110" sortable="false">
							<next:DateField allowBlank="false" format="Y-m-d" />
						</next:Column>
						<next:Column id="itemDesc" header="详细描述" field="itemDesc" sortable="false">
							<next:TextField />
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>

				<next:EditGridPanel title="土地证信息" id="landcardPanel"
					name="landcardPanel" stripeRows="true" height="300" width="98%" 
					dataset="landcardDs" notSelectFirstRow="true">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem text="新增" iconCls="add" handler="addLandcard" />
						<next:ToolBarItem text="删除" iconCls="remove" handler="delLandcard" />
						<next:ToolBarItem symbol=""></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="itemId" header="事项" field="itemId" width="200"
							sortable="false" renderer="backValue">
							<next:ComboBox triggerAction="all" dataset="itemDs" mode="local"
								typeAble="false" displayField="itemLabel" valueField="itemId">
							</next:ComboBox>
						</next:Column>
						<next:Column id="landNum" header="土地证件号" field="landNum"
							width="180" sortable="false">
							<next:TextField />
						</next:Column>
						<next:Column id="landUse" header="土地用途" field="landUse"
							width="80" sortable="false">
							<next:ComboBox triggerAction="all" dataset="landUseDataSet"
								typeAble="false"></next:ComboBox>
						</next:Column>
						<next:Column id="landUseForm" header="土地使用形式" field="landUseForm"
							width="90" sortable="false">
							<next:ComboBox triggerAction="all" dataset="landUseFormDataSet"
								typeAble="false"></next:ComboBox>
						</next:Column>
						<next:Column id="landProp" header="土地使用权人" field="landProp"
							width="90" sortable="false">
							<next:ComboBox triggerAction="all" dataset="landPropDataSet"
								typeAble="false"></next:ComboBox>
						</next:Column>
						<next:Column id="landArea" header="土地面积(㎡)" field="landArea"
							width="90" sortable="false">
							<next:NumberField allowBlank="true" />
						</next:Column>
						<next:Column id="useAge" header="使用年限(年)" field="useAge"
							width="90" sortable="false">
							<next:NumberField allowBlank="true" />
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>

				<next:EditGridPanel title="政府部门批准文号" id="govAppGridPanel"
					name="govAppGridPanel" stripeRows="true" height="300" width="98%" 
					dataset="govAppDs" notSelectFirstRow="true">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem text="新增" iconCls="add" handler="addGovApp" />
						<next:ToolBarItem text="删除" iconCls="remove"
							handler="removeGovApp" />
						<next:ToolBarItem symbol=""></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="itemId" header="事项" field="itemId" width="200"
							sortable="false" renderer="backValue">
							<next:ComboBox triggerAction="all" dataset="itemDs" mode="local"
								typeAble="false" displayField="itemLabel" valueField="itemId">
							</next:ComboBox>
						</next:Column>
						<next:Column id="deptId" header="文号类型" field="deptId" width="160"
							sortable="false">
							<next:ComboBox triggerAction="all" dataset="govDeptDs"
								typeAble="false"></next:ComboBox>
						</next:Column>
						<next:Column id="deptNum" header="批准文号" field="deptNum"
							width="200" sortable="false">
							<next:TextField />
						</next:Column>
						<next:Column id="deptTime" header="批准时间" field="deptTime"
							width="110" sortable="false">
							<next:DateField allowBlank="false" format="Y-m-d" />
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
			</next:Tabs>
		</next:TabPanel>
	</next:Panel>
</next:Panel>
</body>
</html>

<next:Window id="itemWin" title="公墓历史记录" width="800" height="500"
	closeAction="hide" closable="false" modal="true" resizable="true" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol=""></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="yes" handler="itemCommit" />
		<next:ToolBarItem text="取消" iconCls="undo" handler="itemCancle" />
	</next:TopBar>
	<next:Panel  autoHeight="true">
		<next:Panel autoHeight="true">
			<next:Html>
				<form id="editForm" method="post" onsubmit="return false"
					class="L5form">
				<fieldset><legend>公墓事项</legend>
				<table width="98%" height="100%" dataset="itemDs">
					<tr>
						<td class="FieldLabel" width="100">事项</td>
						<td class="FieldInput"><select name="事项" id="itemDic"
							field="itemDic" onchange="onSelectItemChange()">
							<option dataset="itemTypeDs"></option>
						</select><font color="red">*</font></td>
						<td class="FieldLabel">批准时间</td>
						<td class="FieldInput"><input type="text" name="批准时间" id="itemTime"
							field="itemTime" format="Y-m-d" onclick="LoushangDate(this)"
							readonly="readonly" /><font color="red">*</font><input type="text" name="简述"
							field="itemLabel" id="itemLabel" maxlength="50" style="width: 90%" style="display:none;"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">详细描述</td>
						<td class="FieldInput" colspan="3"><textarea
							onpropertychange="if(value.length>150) value=value.substr(0,150)"
							rows="4" maxlength="150" name='详细描述' field="itemDesc"
							style="width: 99%"></textarea></td>
					</tr>
				</table>
				</fieldset>
				</form>
			</next:Html>
		</next:Panel>
		<next:EditGridPanel id="landcardPanel2"
			name="landcardPanel2" stripeRows="true" height="120"
			dataset="landcardDs" notSelectFirstRow="true">
			<next:TopBar>
				<next:ToolBarItem text="土地证信息" />
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem text="新增" iconCls="add" handler="addLandcard2" />
				<next:ToolBarItem text="删除" iconCls="remove" handler="delLandcard" />
				<next:ToolBarItem symbol=""></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column id="landNum" header="土地证件号" field="landNum"
					width="180" sortable="false">
					<next:TextField />
				</next:Column>
				<next:Column id="landUse" header="土地用途" field="landUse"
					width="80" sortable="false">
					<next:ComboBox triggerAction="all" dataset="landUseDataSet"
						typeAble="false"></next:ComboBox>
				</next:Column>
				<next:Column id="landUseForm" header="土地使用形式" field="landUseForm"
					width="90" sortable="false">
					<next:ComboBox triggerAction="all" dataset="landUseFormDataSet"
						typeAble="false"></next:ComboBox>
				</next:Column>
				<next:Column id="landProp" header="土地使用权人" field="landProp"
					width="90" sortable="false">
					<next:ComboBox triggerAction="all" dataset="landPropDataSet"
						typeAble="false"></next:ComboBox>
				</next:Column>
				<next:Column id="landArea" header="土地面积(㎡)" field="landArea"
					width="90" sortable="false">
					<next:NumberField allowBlank="true" />
				</next:Column>
				<next:Column id="useAge" header="使用年限(年)" field="useAge"
					width="90" sortable="false">
					<next:NumberField allowBlank="true" />
				</next:Column>
			</next:Columns>
		</next:EditGridPanel>
		<next:EditGridPanel id="govAppGridPanel2"
			name="govAppGridPanel2" stripeRows="true" height="250"
			dataset="govAppDs" notSelectFirstRow="true">
			<next:TopBar>
				<next:ToolBarItem text="政府部门批准文号" />
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem text="新增" iconCls="add" handler="addGovApp2" />
				<next:ToolBarItem text="删除" iconCls="remove"
					handler="removeGovApp" />
				<next:ToolBarItem symbol=""></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column id="deptId" header="文号类型" field="deptId" width="160"
					sortable="false">
					<next:ComboBox triggerAction="all" dataset="govDeptDs"
						typeAble="false"></next:ComboBox>
				</next:Column>
				<next:Column id="deptNum" header="批准文号" field="deptNum"
					width="200" sortable="false">
					<next:TextField />
				</next:Column>
				<next:Column id="deptTime" header="批准时间" field="deptTime"
					width="110" sortable="false">
					<next:DateField allowBlank="false" format="Y-m-d" />
				</next:Column>
			</next:Columns>
		</next:EditGridPanel>
	</next:Panel>
</next:Window>