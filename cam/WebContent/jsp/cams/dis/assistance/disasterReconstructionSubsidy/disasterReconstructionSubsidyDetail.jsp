<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<html>
<head>
<title>灾区民房恢复重建补助明细</title>
<next:ScriptManager />
<script>
	var organName = '<%=BspUtil.getOrganName()%>';
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var cx_infoId = '<%=request.getParameter("cx_infoId")%>';
	var cx_recordId = '<%=request.getParameter("cx_recordId")%>';
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="disasterReconstructionSubsidyDetail.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="familyDs" cmd="com.inspur.cams.dis.base.cmd.DisBaseFamilyRecordQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisBaseFamilyRecord">
			<model:field name="organName" type="string"></model:field>
		</model:record>
	</model:dataset>
	<model:dataset id="reliefDs" cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefInfo">
		</model:record>
	</model:dataset>
	<model:dataset id="photoDs" cmd="com.inspur.cams.dis.base.cmd.DisPhotoQueryCommand"  global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisPhoto">
		</model:record>
	</model:dataset>
	<!-- 家庭类型 -->
	<model:dataset id="DisFamilyType" enumName="DIS.FAMILY_TYPE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 灾害种类 -->
	<model:dataset id="DisDisasterType" enumName="DIS.DISASTER_TYPE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 房屋结构 -->
	<model:dataset id="DisHouseStructure" enumName="DIS.HOUSE_STRUCTURE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 资金发放类型 -->
	<model:dataset id="DisAllocationType" enumName="DIS.INFO_ALLOCATION_TYPE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 户口所在地 -->
	<model:dataset id="DisFamilyRegister" enumName="DIS.FAMILY_REGISTER" autoLoad="true" global="true">
	</model:dataset>
	<!-- 发放部门  -->
	<model:dataset id="DisGrantType" enumName="DIS.GRANT_TYPE" autoLoad="true" global="true">
	</model:dataset>
</model:datasets>
<next:Panel width="100%" height="100%">
	<next:TabPanel id="tabPanel">
		<next:Tabs>
			<next:Panel id="familyInfo" title="家庭信息" width="100%" height="100%" >
				<next:Html>
					<fieldset>
					<form id="disasterDeathSolatiumFamilyForm" method="post"
						dataset="familyDs" onsubmit="return false"
						style="padding: 5px;" class="L5form">
					<table border="0" width="100%">
						<input type="hidden" name="recordId" field="recordId" />
						<input type="hidden" name="organCode" field="organCode" />
						<input type="hidden" name="townCode" field="townCode" />
						<input type="hidden" name="villiageCode" field="villiageCode" />
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>户主姓名:</td>
							<td class="FieldInput" style="width: 35%">
								<label id="name" name="name" field="name" title="户主姓名" />
							</td>
							<td class="FieldLabel" style="width: 15%" nowrap>身份证号码:</td>
							<td class="FieldInput" style="width: 35%">
								<label name="idCard" field="idCard" title="身份证号码" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>家庭人口（人）:</td>
							<td class="FieldInput" style="width: 35%">
								<label id="familyNum" name="familyNum" field="familyNum" title="家庭人口（人）" />
							</td>
							<td class="FieldLabel" style="width: 15%" nowrap>家庭类型:</td>
							<td class="FieldInput" style="width: 35%">
								<label name="familyType" field="familyType" title="家庭类型" dataset="DisFamilyType" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>户口所在地:</td>
							<td class="FieldInput" style="width: 35%" colspan="3">
								<label name="familyRegister" field="familyRegister" title="户口所在地" dataset="DisFamilyRegister" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>房屋间数（间）:</td>
							<td class="FieldInput" style="width: 35%">
								<label name="houseCount" field="houseCount" title="房屋间数（间）" />
							</td>
							<td class="FieldLabel" style="width: 15%" nowrap>房屋结构:</td>
							<td class="FieldInput" style="width: 35%">
								<label name="houseStructure" field="houseStructure" title="房屋结构" dataset="DisHouseStructure" />
							</td>
						</tr>
					</table>
					</form>
				</fieldset>
			</next:Html>
		</next:Panel>
			
		<next:Panel id="reliefInfo"  title="救助信息" width="100%" height="100%"  >
		<next:Html>
			<fieldset>
			<form id="disasterDeathSolatiumReliefForm" method="post"
					dataset="reliefDs" onsubmit="return false"
					style="padding: 5px;" class="L5form">
				<table border="0" width="100%" cellspacing="0" cellpadding="0">
					<input type="hidden" name="infoId" field="infoId" />
					<tr>
						<td class="FieldLabel" style="width: 15%" nowrap>行政村:</td>
						<td class="FieldInput" style="width: 35%" colspan="3">
							<label id="acceptAreaName" field="acceptAreaName" style="width:200" title="行政村" />
							<input type="hidden" id="acceptAreaCode" name="acceptAreaCode" field="acceptAreaCode" title="行政村" />
							<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="forOrganSelect()" />
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%" nowrap>受灾时间:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="damageTime" field="damageTime" title="受灾时间" />
							<font color="red">*</font>
						</td>
						<td class="FieldLabel" style="width: 15%" nowrap>灾害种类:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="disasterType" field="disasterType" title="灾害种类" dataset="DisDisasterType" />
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%" nowrap>倒塌房屋（间）:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="collapsedHouse" field="collapsedHouse" title="倒塌房屋（间）" />
						</td>
						<td class="FieldLabel" style="width: 15%" nowrap>严重损坏房屋（间）:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="seriousDamageHouse" field="seriousDamageHouse" title="严重损坏房屋（间）" />
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%" nowrap>一般损坏房屋（间）:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="generalDamageHouse" field="generalDamageHouse" title="一般损坏房屋（间）" />
						</td>
						<td class="FieldLabel" style="width: 15%" nowrap>需重建房屋（间）:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="rebuildHouse" field="rebuildHouse" title="需重建房屋（间）" />
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%" nowrap>需修缮房屋（间）:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="repairedHouse" field="repairedHouse" title="需修缮房屋（间）" />
						</td>
						<td class="FieldLabel" style="width: 15%" nowrap>核准重建间数（间）:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="approvalRebuiledHouse" field="approvalRebuiledHouse" title="核准重建间数（间）" />
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%" nowrap>核准修缮间数（间）:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="approvalRepairedHouse" field="approvalRepairedHouse" title="核准修缮间数（间）" />
						</td>
						<td class="FieldLabel" style="width: 15%" nowrap>核准补助资金（元）:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="approvalMonry" field="approvalMonry" title="核准补助资金（元）" />
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%" nowrap>资金发放类型:</td>	
						<td class="FieldInput" style="width: 35%">
							<label name="allocationType" field="allocationType" title="资金发放类型" dataset="DisAllocationType" />
							<font color="red">*</font>
						</td>
						<td class="FieldLabel" style="width: 15%" nowrap>开户银行:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="bank" field="bank" title="开户银行" />
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%" nowrap>发放部门:</td>	
						<td class="FieldInput" style="width: 35%">
							<label name="grantType" field="grantType" title="发放部门" dataset="DisGrantType"/>
						</td>
						<td class="FieldLabel" style="width: 15%" nowrap>开户银行帐号:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="accountCode" field="accountCode" title="开户银行帐号" />
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%" nowrap>开户银行地址:</td>
						<td class="FieldInput" style="width: 35%" colspan="3">
							<label name="bankAdds" field="bankAdds" title="开户银行地址" />
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%" nowrap>村级填报人姓名:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="acceptPeopleName" field="acceptPeopleName" title="村级填报人姓名" />
						</td>
						<td class="FieldLabel" style="width: 15%" nowrap>村级填报日期:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="acceptDate" field="acceptDate" title="村级填报日期" />
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%" nowrap>备注:</td>
						<td class="FieldInput" style="width: 35%" colspan="3" rowspan="2">
							<label name="note" field="note" title="备注" style="width: 85%" ></label>
						</td>
					</tr>
				</table>
			</form>
			</fieldset>
		</next:Html>
	</next:Panel>
	
	<next:Panel id="photoPanel" title="受灾图片" bodyStyle="width:100%;" autoHeight="true">
		<next:Html>
			<fieldset>
				<form id="photoForm"  onsubmit="return false" class="L5form">
					<table id="photoTable1" border="0" width="100%" height="100%">
						<tr>
							<td class="FieldInput" style="width:100%;border-style: solid; height: 30px; padding: 4px;">
								<table id="photoTable" width="100%" height="100%">
								</table>
							</td>
						</tr>
					</table>
				</form>
			</fieldset>
		</next:Html>
	</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>

</body>
</html>
