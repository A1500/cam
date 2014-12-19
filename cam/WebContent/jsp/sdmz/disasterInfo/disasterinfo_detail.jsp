
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>灾情信息明细</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="disasterinfo_detail.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.sdmz.disasterInfo.cmd.DisasterInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.sdmz.disasterInfo.dao.DisasterInfo"></model:record>
		<model:params>
			<model:param name="DISASTER_ID" value='<%=request.getParameter("disasterId")%>'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel  title="灾情信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	    <next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td  class="FieldLabel" >业务编号</td>
				<td class="FieldInput"><label field="disasterId" /> </td>
			
				<td  class="FieldLabel" >灾情标题</td>
				<td class="FieldInput"><label field="disasterTitle" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >灾情发生时间</td>
				<td class="FieldInput"><label field="disasterTime" /> </td>
			
				<td  class="FieldLabel" >灾情发生地点</td>
				<td class="FieldInput"><label field="disasterAdd" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >灾情情况</td>
				<td class="FieldInput"><label field="disasterSituation" /> </td>
			
				<td  class="FieldLabel" >上报人</td>
				<td class="FieldInput"><label field="regPeople" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >上报人ID</td>
				<td class="FieldInput"><label field="regPeopleId" /> </td>
			
				<td  class="FieldLabel" >上报单位</td>
				<td class="FieldInput"><label field="regOrgan" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >上报单位ID</td>
				<td class="FieldInput"><label field="regOrganId" /> </td>
			
				<td  class="FieldLabel" >上报单位区划</td>
				<td class="FieldInput"><label field="regOrganArea" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >上报时间</td>
				<td class="FieldInput"><label field="regTime" /> </td>
			
				<td  class="FieldLabel" >修改人</td>
				<td class="FieldInput"><label field="modPeople" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >修改人ID</td>
				<td class="FieldInput"><label field="modPeopleId" /> </td>
			
				<td  class="FieldLabel" >修改单位</td>
				<td class="FieldInput"><label field="modOegan" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >修改单位ID</td>
				<td class="FieldInput"><label field="modOrganId" /> </td>
			
				<td  class="FieldLabel" >修改单位区划</td>
				<td class="FieldInput"><label field="modOrganArea" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >修改时间</td>
				<td class="FieldInput"><label field="modTime" /> </td>
					</tr>			
		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
