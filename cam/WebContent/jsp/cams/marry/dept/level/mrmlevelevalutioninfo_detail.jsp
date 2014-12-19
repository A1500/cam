
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>等级评定信息表明细</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="mrmlevelevalutioninfo_detail.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmLevelEvalutionInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmLevelEvalutionInfo"></model:record>
		<model:params>
			<model:param name="EVALU_ID" value='<%=request.getParameter("evaluId")%>'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel  title="等级评定信息表">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	    <next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td  class="FieldLabel" >等级评定ID</td>
				<td class="FieldInput"><label field="evaluId" /> </td>
			
				<td  class="FieldLabel" >登记机关ID</td>
				<td class="FieldInput"><label field="organId" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >等级</td>
				<td class="FieldInput"><label field="evaluLevel" /> </td>
			
				<td  class="FieldLabel" >评定时间</td>
				<td class="FieldInput"><label field="evaluTime" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >复核时间</td>
				<td class="FieldInput"><label field="reviewTime" /> </td>
			
				<td  class="FieldLabel" >整改合格时间</td>
				<td class="FieldInput"><label field="rectificPassTime" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >不合格撤销登记时间</td>
				<td class="FieldInput"><label field="revokeTime" /> </td>
			
				<td  class="FieldLabel" >主动申请取消等级时间</td>
				<td class="FieldInput"><label field="cancelLevelTime" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >是否首次评定</td>
				<td class="FieldInput"><label field="firstEvalu" /> </td>
			
				<td  class="FieldLabel" >不合格降级时间</td>
				<td class="FieldInput"><label field="nhgjjTime" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >不合格降级原等级</td>
				<td class="FieldInput"><label field="nhgjjBlevel" /> </td>
			
				<td  class="FieldLabel" >不合格降级现等级</td>
				<td class="FieldInput"><label field="nhgjjNlevel" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >主动申请降级时间</td>
				<td class="FieldInput"><label field="zdsqjjTime" /> </td>
			
				<td  class="FieldLabel" >主动申请降级原等级</td>
				<td class="FieldInput"><label field="zdsqjjBlevel" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >主动申请降级现等级</td>
				<td class="FieldInput"><label field="zdsqjjNlevel" /> </td>
					</tr>			
		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
