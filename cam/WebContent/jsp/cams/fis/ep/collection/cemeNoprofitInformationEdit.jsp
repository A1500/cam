<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>公益性公墓信息编辑</title>
<next:ScriptManager></next:ScriptManager>
<script>
	var idField='<%=request.getParameter("dataBean")%>';
	var method='<%=request.getParameter("method")%>';
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var prop = "1";	//标识：此页面默认的公墓性质为公益性公墓
</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="../ep.js"></script>
<script type="text/javascript" src="cemeNoprofitInformationEdit.js"></script>
</head>
<body>

<model:datasets>
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
		</model:record>
	</model:dataset>

	<!--政府部门批准文号-->
	<model:dataset id="govAppDs"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeGovApprovalCmd"
		global="true" pageSize="-1">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeGovApproval">
			<model:field name="deptId" type="string" rule="require" />
			<model:field name="deptNum" type="string" rule="require" />
		</model:record>
	</model:dataset>

	<!--单位性质-->
	<model:dataset id="unitPropertiesDataSet"
		enumName="FIS.CEME.UNITPROPERTIES" autoLoad="true" global="true"></model:dataset>
	<!--管辖级别-->
	<model:dataset id="cemeDominationDataSet"
		enumName="FIS.CEME.DOMINATION" autoLoad="true" global="true"></model:dataset>		
	<model:dataset id="propDataSet" enumName="FIS.CEME.PROP"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="AreaUnitsDataSet" enumName="FIS.CEME.AREAUNITS"
		autoLoad="true" global="true"></model:dataset>
	
</model:datasets>

<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel height="100%" width="100%" autoScroll="true">
			<next:Panel autoScroll="false">
				<next:TopBar>
					<next:ToolBarItem id="qrToolbar" text="公益性公墓信息"></next:ToolBarItem>
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
									name="公墓名称" field="cemeName" title="补录公墓的全称" style="width: 200px" maxlength="50"/></td>
			
								<td class="FieldLabel" style="width: 15%">公墓编号</td>
								<td class="FieldInput" style="width: 15%"><input type="text"
									id="cemeId" name="公墓编号" field="cemeId" 
									title="民政部门授予的全省唯一编码,自动生成，\n请按主管单位的批准时间录入公墓信息" maxlength="11" /></td>
								<td class="FieldLabel" style="width: 15%">性质</td>
								<td class="FieldInput" style="width: 15%"><label title="性质">公益性</label> <input
									type="hidden" name="prop" field="prop" title="公墓性质"></input></td>						
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
								<td class="FieldLabel">负责人</td>
								<td class="FieldInput"><input type="text" name="负责人"
									field="director" maxlength="20" /></td>				
								<td class="FieldLabel">联系电话</td>
								<td class="FieldInput" colspan="3"><input type="text" name="联系电话"
									id="directorMobile" field="directorMobile" style="width: 200px" maxlength="50"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">工作人员数</td>
								<td class="FieldInput"><input type="text" name="工作人员数" style="text-align: right" 
									id="totalStaff" field="totalStaff" maxlength="9"
									onchange="checkNum(this.id)" />人</td>				
								<td class="FieldLabel">业务培训人数</td>
								<td class="FieldInput" colspan="3"><input type="text" name="业务培训人数" style="text-align: right" 
									id="trainNum" field="trainNum" maxlength="9"	onchange="checkNum(this.id)" 
									title="参加民政部门业务培训人数" />人</td>							
							</tr>
							<tr>				
								<td class="FieldLabel">计算机管理员</td>
								<td class="FieldInput"><input type="text" name="计算机管理员"
									field="computerManager" maxlength="20" /></td>				
								<td class="FieldLabel" >联系电话</td>
								<td class="FieldInput"  colspan="3"><input type="text" name="联系电话"
									id="computerManagerPhone" field="computerManagerPhone" style="width: 200px" maxlength="50" /></td>
							</tr>		
							<tr>
								<td class="FieldLabel">计算机数量</td>
								<td class="FieldInput"><input type="text" name="计算机数量" id="computerNum" style="text-align: right" 
									field="computerNum" maxlength="3" onchange="checkNum(this.id)" />台</td>													
								<td class="FieldLabel">信息系统安装时间</td>
								<td class="FieldInput" colspan="3"><input type="text" name="信息系统安装时间"
									id="FIX_TIME" field="fixTime" maxlength="32" /></td>
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
								<td class="FieldLabel">正式使用时间</td>
								<td class="FieldInput"><input type="text" name="正式营业时间"
									field="gestionTime" format="Y-m-d" onclick="LoushangDate(this)"
									readonly="readonly" /></td>				
								<td class="FieldLabel">计划使用年限至</td>
								<td class="FieldInput"><input type="text" name="计划使用年限至"
									id="yearPlanto" style="text-align: right" field="yearPlanto" maxlength="4" title="计划哪年安葬满，格式：yyyy" />年</td>					
							</tr>							
							<tr>
								<td class="FieldLabel">占用土地性质</td>
								<td class="FieldInput" ><input type="text"
									name="占用土地性质" field="landProperties" style="width: 200px" maxlength="20" /></td>				
								<td class="FieldLabel">公墓占地面积</td>
								<td class="FieldInput" ><input type="text"
									style="text-align: right" name="公墓占地面积" field="totalArea"
									id="totalArea" onchange="checkAssMon(this.id)" maxlength="12" />亩<!--
								&nbsp; <select name="公墓占地面积计量单位" id="totalAreaUnits"
									field="totalAreaUnits" style="width: 60px">
									<option dataset="AreaUnitsDataSet"></option>
								</select>--></td>
								<td class="FieldLabel">建筑面积</td>
								<td class="FieldInput"><input type="text"
									style="text-align: right" name="建筑总面积" field="builtTotalArea"
									id="builtTotalArea" onchange="checkAssMon(this.id)" maxlength="12" />㎡</td>						
							</tr>				
							<tr>
								<td class="FieldLabel">绿地面积</td>
								<td class="FieldInput"><input type="text"
									style="text-align: right" name="绿地面积" field="greenArea"
									id="GREEN_AREA" onchange="checkAssMon(this.id)" maxlength="12" />㎡</td>	
								<td class="FieldLabel">绿化覆盖率</td>
								<td class="FieldInput" colspan="3"><input type="text"
									style="text-align: right" name="绿化覆盖率" field="greenRatio"
									id="GREEN_RATIO" onchange="checkAssMon(this.id)" maxlength="12" />%</td>							
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
												onchange="checkAssMon(this.id)" maxlength="12" ></label>万元
								</td>
								<td class="FieldLabel">其中财政拨款</td>
								<td class="FieldInput">
										<input type="text" name="其中财政拨款"
													style="text-align: right" field="fundFinance" id="fundFinance"
														onchange="getFundTotal(this)"  maxlength="12" />万元
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
												onchange="getFundTotal(this)"  maxlength="12" />	万元
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
								<td class="FieldLabel" style="width: 15%">维护管理办法</td>
								<td class="FieldInput" style="width: 75%" colspan="5">
								<select name='维护管理办法' field="manageStyle">
									<option value="">请选择......</option>
									<option value="收费">收费</option>
									<option value="免费">免费</option>
								</select>
							</tr>					
							<tr>
								<td class="FieldLabel" style="width: 15%">备注</td>
								<td class="FieldInput" style="width: 75%" colspan="5"><textarea
									onpropertychange="if(value.length>49) value=value.substr(0,49)"
									rows="3" maxlength="49" name='备注' field="NOTE"
									style="width: 90%"></textarea></textarea></td>
							</tr>									
						</table>
					</fieldset>
					</form>
				</next:Html>
			</next:Panel>
			<next:EditGridPanel title="政府部门批准文号" id="govAppGridPanel"
				name="govAppGridPanel" stripeRows="true" height="100%" width="99%"
				dataset="govAppDs" notSelectFirstRow="true">
				<next:Columns>
					<next:Column id="deptId" header="文号类型" field="deptId" width="160"
						sortable="false" editable="false">
						<next:TextField />
					</next:Column>
					<next:Column id="deptNum" header="文号" field="deptNum" width="220"
						sortable="false">
						<next:TextField />
					</next:Column>
					<next:Column id="deptTime" header="批准时间" field="deptTime"
						width="110" sortable="false">
						<next:DateField allowBlank="false" format="Y-m-d" />
					</next:Column>
				</next:Columns>
			</next:EditGridPanel>
		</next:Panel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
