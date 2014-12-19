
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>过渡性生活救助编辑</title>
<next:ScriptManager />
<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
			var infoId='<%=request.getParameter("infoId")%>';
			var batchDetailId='<%=request.getParameter("batchDetailId")%>';
			 var organCode = '<%=BspUtil.getOrganCode()%>';
		   	 var organName = '<%=BspUtil.getOrganName()%>';
		</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="../../comm/disComm.js"><</script>
<script type="text/javascript" src="gd_info_edit.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="infoDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCommand"
		global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefInfo"></model:record>
	</model:dataset>

	<model:dataset id="grantTypeDs" enumName="DIS.GRANT_TYPE" global="true"
		autoLoad="true">
	</model:dataset>
</model:datasets>
<next:Panel width="100%" height="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save" />
		<next:ToolBarItem id="conBtn" iconCls="save" text="保存并继续" handler="saveClickContinue" />
		<%-- 		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/> --%>
	</next:TopBar>
	<next:Panel id="infoGrid" name="infoGrid" width="100%"
		autoHeight="100%" title="救助信息">
		<next:Html>
			<form id="editForm" dataset="infoDs" onsubmit="return false"
				style="padding: 5px;" class="L5form">
			<table border="1" width="100%">
				<tr>

					<td class="FieldLabel">需口粮救助（公斤）</td>
					<td class="FieldInput"><input type="text"
						name="requiredForFood" title="需口粮救助（公斤）" field="requiredForFood" onblur="appFood(this)"/>

					</td>

					<td class="FieldLabel">需衣被救助（件）</td>
					<td class="FieldInput"><input type="text"
						name="requiredForClothes" title="需衣被救助（件）"
						field="requiredForClothes" onblur="appClothes(this)"/></td>
				</tr>

				<tr>
					<td class="FieldLabel">需取暖救助（元）</td>
					<td class="FieldInput"><input type="text"
						name="requiredForHeat" title="需取暖救助（元）" field="requiredForHeat" onblur="appMon()"/>

					</td>
					<td class="FieldLabel">需伤病救助（元）</td>
					<td class="FieldInput"><input type="text"
						name="requiredForDisease" title="需伤病救助（元）"
						field="requiredForDisease" onblur="appMon()"/></td>

				</tr>

				<tr>
					<td class="FieldLabel">需其他救助（元）</td>
					<td class="FieldInput"><input type="text"
						name="requiredForOthers" title="需其他救助（元）"
						field="requiredForOthers" onblur="appMon()"/></td>
					<td class="FieldLabel"></td>
					<td class="FieldInput"></td>
				</tr>
				<tr>
					<td class="FieldLabel">核准救助人口</td>
					<td class="FieldInput"><input type="text"
						name="approvalFamilyNum" title="核准救助人口" field="approvalFamilyNum" />

					</td>

					<td class="FieldLabel">核准救助粮食（公斤）</td>
					<td class="FieldInput"><input type="text" name="approvalFood"
						title="核准救助粮食（公斤）" field="approvalFood" /></td>

				</tr>
				<tr>
					<td class="FieldLabel">核准救助衣被（件）</td>
					<td class="FieldInput"><input type="text"
						name="approvalClothes" title="核准救助衣被（件）" field="approvalClothes" />

					</td>

					<td class="FieldLabel">核准救助资金（元）</td>
					<td class="FieldInput" ><input type="text"
						name="approvalMonry" title="核准救助资金（元）" field="approvalMonry" />

					</td>
				</tr>
				<tr>
					<td class="FieldLabel">村级名称</td>
					<td class="FieldInput"><input type="text"
						name="acceptAreaName" id="acceptAreaName" title="村级行政区划名称"
						field="acceptAreaName" /> <img
						src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
						style="cursor: hand"
						onclick="forOrganSelect('acceptAreaName','acceptAreaCode')" /><font color=red>*</font></td>

					<td class="FieldLabel" style="display: none">村级行政区划</td>
					<td class="FieldInput" style="display: none"><input
						type="text" name="acceptAreaCode" id="acceptAreaCode"
						title="村级行政区划" field="acceptAreaCode" /></td>

					<td class="FieldLabel">村级填报人姓名</td>
					<td class="FieldInput"><input type="text"
						name="acceptPeopleName" title="村级填报人姓名" field="acceptPeopleName" />

					</td>
				</tr>
				<tr>
					<td class="FieldLabel">村级填报日期</td>
					<td class="FieldInput"><input type="text" name="acceptDate"
						title="村级填报日期" field="acceptDate" format="Y-m-d" maxlength="10"
						onclick="changeDateStyle(this)" /><img
						src="../../../../../skins/images/default/rl.gif" align="middle"
						onclick="getTimes(this)" /></td>

					<td class="FieldLabel"></td>
					<td class="FieldInput"></td>
				</tr>

				<tr>
					<td class="FieldLabel">发放单位类型</td>
					<td class="FieldInput"><select name="grantType" id="grantType"
						field="grantType">
						<option dataset="grantTypeDs" />
					</select><font color=red>*</font></td>

					<td class="FieldLabel"></td>
					<td class="FieldInput"></td>
				</tr>
				<!-- 
				   		<tr>
							<td  class="FieldLabel">乡镇（街道）名称</td>
							<td class="FieldInput">
							
							<input type="text" name="checkOrganName" id="checkOrganName"  title="乡镇（街道）名称"  field="checkOrganName"  /> 
							<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand"  onclick="forOrganSelect('checkOrganName', 'checkOrganCode')"/>
							</td>
						
							<td  class="FieldLabel" style="display:none">乡镇（街道）区划</td>
							<td class="FieldInput" style="display:none">
							
							<input type="text" name="checkOrganCode" id="checkOrganCode" title="乡镇（街道）区划"  field="checkOrganCode"  /> 
							
							</td>
							
							<td  class="FieldLabel">乡镇（街道）审核人名称</td>
							<td class="FieldInput">
							
							<input type="text" name="checkPeopleName"  title="乡镇（街道）审核人名称"  field="checkPeopleName"  /> 
							
							</td>
						</tr>
				   		<tr>
							
						
							<td  class="FieldLabel">审核日期</td>
							<td class="FieldInput">
							
							<input type="text" name="checkDate"  title="审核日期"  field="checkDate"  format="Y-m-d" maxlength="10" onclick="changeDateStyle(this)" /><img  
							src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" /> 
							
							</td>
							
							<td  class="FieldLabel"></td>
							<td class="FieldInput"></td>
						</tr>
						 -->
				<!-- 
				   		<tr>
							<td  class="FieldLabel">县级名称</td>
							<td class="FieldInput">
							
							<input type="text" name="auditOrganName"  title="县级名称"  field="auditOrganName"  /> 
							
							</td>
						
							<td  class="FieldLabel">县区划</td>
							<td class="FieldInput">
							
							<input type="text" name="auditOrganCode"  title="县区划"  field="auditOrganCode"  /> 
							
							</td>
						</tr>
				   		<tr>
							<td  class="FieldLabel">县级批准人名称</td>
							<td class="FieldInput">
							
							<input type="text" name="auditPeopleName"  title="县级批准人名称"  field="auditPeopleName"  /> 
							
							</td>
						
							<td  class="FieldLabel">批准日期</td>
							<td class="FieldInput">
							
							<input type="text" name="auditDate"  title="批准日期"  field="auditDate"  /> 
							
							</td>
						</tr>
				   		<tr>
							<td  class="FieldLabel">发放单位名称</td>
							<td class="FieldInput">
							
							<input type="text" name="grantOrganName"  title="发放单位名称"  field="grantOrganName"  /> 
							
							</td>
						
							<td  class="FieldLabel">发放单位区划</td>
							<td class="FieldInput">
							
							<input type="text" name="grantOrganCode"  title="发放单位区划"  field="grantOrganCode"  /> 
							
							</td>
						</tr>
				   		<tr>
							<td  class="FieldLabel">发放人名称</td>
							<td class="FieldInput">
							
							<input type="text" name="grantPeopleName"  title="发放人名称"  field="grantPeopleName"  /> 
							
							</td>
						
							<td  class="FieldLabel">发放日期</td>
							<td class="FieldInput">
							
							<input type="text" name="grantTime"  title="发放日期"  field="grantTime"  /> 
							
							</td>
						</tr>
						 -->
				<tr>
					<td class="FieldLabel">备注</td>
					<td class="FieldInput" colspan="3"><textarea name="note"
						title="备注" field="note" rows="8" cols="130" />
							
							</td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
</next:Panel>

</body>
</html>
