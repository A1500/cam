<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<html>
<head>
<title>冬春生活救助</title>
<next:ScriptManager />
<script>
	var organName = '<%=BspUtil.getOrganName()%>';
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var cx_infoId = '<%=request.getParameter("cx_infoId")%>';
	var cx_recordId = '<%=request.getParameter("cx_recordId")%>';
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="approveLifeAssistanceWinterSpringDetail.js"></script>
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
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel id="tabPanel">
		<next:Tabs>
			<next:Panel id="familyInfo" title="家庭信息" width="100%" height="100%">
				<next:Html>
					<fieldset>
					<form id="lifeAssistanceWinterSpringFamilyForm" method="post"
						dataset="familyDs" onsubmit="return false" class="L5form">
					<table border="0" width="100%">
						<input type="hidden" name="recordId" field="recordId" />
						<input type="hidden" name="organCode" field="organCode" />
						<input type="hidden" name="townCode" field="townCode" />
						<input type="hidden" id="villiageCode" name="villiageCode" field="villiageCode" title="行政村" />
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>户主姓名:</td>
							<td class="FieldInput" style="width: 35%">
								<label id="name" name="name" field="name" title="户主姓名" />
								<font color="red">*</font>
							</td>
							<td class="FieldLabel" style="width: 15%" nowrap>身份证号码:</td>
							<td class="FieldInput" style="width: 35%">
								<label name="idCard" field="idCard" title="身份证号码" />
								<font color="red">*</font>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>家庭人口（人）:</td>
							<td class="FieldInput" style="width: 35%">
								<label id="familyNum" name="familyNum" field="familyNum" title="家庭人口（人）" />
								<font color="red">*</font>
							</td>
							<td class="FieldLabel" style="width: 15%" nowrap>家庭类型:</td>
							<td class="FieldInput" style="width: 35%">
								<label name="familyType" field="familyType" title="家庭类型" dataset="DisFamilyType"/>
								<font color="red">*</font>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>户口所在地:</td>
							<td class="FieldInput" style="width: 35%" colspan="3">
								<label name="familyRegister" id="familyRegister" field="familyRegister" title="户口所在地" dataset="DisFamilyRegister" />
								<font color="red">*</font>
							</td>
						</tr>
					</table>
					</form>
				</fieldset>
			</next:Html>
		</next:Panel>
			
		<next:Panel id="reliefInfo"  title="救助信息" width="100%" height="100%" autoScroll="true" >
		<next:Html>
			<fieldset>
			<form id="lifeAssistanceWinterSpringReliefForm" method="post"
					dataset="reliefDs" onsubmit="return false" class="L5form">
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
						<td class="FieldLabel" style="width: 15%" nowrap>需口粮救助（公斤）:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="requiredForFood" field="requiredForFood" title="需口粮救助（公斤）" />
						</td>
						<td class="FieldLabel" style="width: 15%" nowrap>需取暖救助（元）:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="requiredForHeat" field="requiredForHeat" title="需取暖救助（元）" />
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%" nowrap>需衣被救助（件）:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="requiredForClothes" field="requiredForClothes" title="需衣被救助（件）" />
						</td>
						<td class="FieldLabel" style="width: 15%" nowrap>需伤病救助（元）:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="requiredForDisease" field="requiredForDisease" title="需伤病救助（元）" />
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%" nowrap>需其他救助（元）:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="requiredForOthers" field="requiredForOthers" title="需其他救助（元）" />
						</td>
						<td class="FieldLabel" style="width: 15%" nowrap>核准救助时段:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="approvalTimes" field="approvalTimes" title="核准救助时段" />
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%" nowrap>核准救助口粮（公斤）:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="approvalFood" field="approvalFood" title="核准救助口粮（公斤）" />
						</td>
						<td class="FieldLabel" style="width: 15%" nowrap>核准救助衣被（件）:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="approvalClothes" field="approvalClothes" title="核准救助衣被（件）" />
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%" nowrap>核准救助金额（元）:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="approvalMonry" field="approvalMonry" title="核准救助金额（元）" />
						</td>
						<td class="FieldLabel" style="width: 15%" nowrap>资金发放类型:</td>	
						<td class="FieldInput" style="width: 35%">
							<label name="allocationType" field="allocationType" title="资金发放类型" dataset="DisAllocationType" />
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%" nowrap>发放部门:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="grantType" field="grantType" title="发放部门" dataset="DisGrantType" />
						</td>
						<td class="FieldLabel" style="width: 15%" nowrap>开户银行:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="bank" field="bank" title="开户银行" />
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%" nowrap>开户银行帐号:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="accountCode" field="accountCode" title="开户银行帐号" />
						</td>
						<td class="FieldLabel" style="width: 15%" nowrap>开户银行地址:</td>
						<td class="FieldInput" style="width: 35%">
							<label name="bankAdds" field="bankAdds" title="开户银行地址" />
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:15%" nowrap>村级填报人姓名:</td>
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
	<next:Panel  title="审批信息" width="100%">
			<next:Html>
				<form id="editForm3"   dataset="reliefDs" onsubmit="return false" class="L5form">
				<table border="1"  width="100%" >
					<tr>
						<td  class="FieldLabel" >填报单位名称</td>
						<td class="FieldInput" colspan="3"><label name="organName" field="organName"  /> </td>
					</tr>	
					<tr>
						<td  class="FieldLabel" >行政村名称</td>
						<td class="FieldInput" colspan="3"><label name="acceptAreaName" field="acceptAreaName"  /> </td>
					
					</tr>	
					<tr>
						<td  class="FieldLabel" >村级填报人</td>
						<td class="FieldInput" style="width:350"><label name="acceptPeopleName" field="acceptPeopleName"  /> </td>
						<td  class="FieldLabel" >填报日期</td>
						<td class="FieldInput" style="width:250"><label name="acceptDate" field="acceptDate"  /> </td>
					
						
					</tr>
					<tr>
						<td  class="FieldLabel" >乡镇（街道）名称</td>
						<td class="FieldInput" colspan="3"><label name="checkOrganName" field="checkOrganName"  /> </td>
					
					</tr>	
			   		<tr>
						<td  class="FieldLabel" >乡镇（街道）审核人</td>
						<td class="FieldInput"><label name="checkPeopleName" field="checkPeopleName"  /> </td>
					
						<td  class="FieldLabel" >审核日期</td>
						<td class="FieldInput"><label name="checkDate" field="checkDate"  /> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >县级名称</td>
						<td class="FieldInput" colspan="3"><label name="auditOrganName" field="auditOrganName"  /> </td>
					
					</tr>	
			   		<tr>
						
						<td  class="FieldLabel" >县级批准人名称</td>
						<td class="FieldInput"><label name="auditPeopleName" field="auditPeopleName"  /> </td>
						<td  class="FieldLabel" >批准日期</td>
						<td class="FieldInput"><label name="auditDate" field="auditDate"  /> </td>
					
						
					</tr>
					<tr>
						<td  class="FieldLabel" >发放单位名称</td>
						<td class="FieldInput" colspan="3"><label name="grantOrganName" field="grantOrganName"  /> </td>
					
					</tr>	
			   		<tr>
						<td  class="FieldLabel" >发放人名称</td>
						<td class="FieldInput"><label name="grantPeopleName" field="grantPeopleName"  /> </td>
					
						<td  class="FieldLabel" >发放日期</td>
						<td class="FieldInput" ><label name="grantTime" field="grantTime"  /> </td>
					</tr>
				</table>
				</form>
		   </next:Html>
		</next:Panel>
	
		</next:Tabs>
	</next:TabPanel>
</next:Panel>

</body>
</html>
