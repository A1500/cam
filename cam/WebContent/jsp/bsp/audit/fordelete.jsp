<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>批量删除</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="fordelete.js"></script>
	</head>
<body>


<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	
		<table  border="1" width="50%" title="时间范围设定" >
			<tr>
				<td class="FieldLabel" width="30%">开始时间:</td>
				<td class="FieldInput">
							<input id="pmStartTime_id" type="text"  format="Ymd H:i:s"/>
							<img  src="<%=SkinUtils.getImage(request,"default/shared/calendar.gif")%>"
							 height="20" onclick="LoushangDatetime('pmStartTime_id')" />
							</td>
			</tr>
			<tr>
				<td class="FieldLabel">结束时间:</td>
				<td class="FieldInput">
				<input id="pmEndTime_id" type="text" 	format="Ymd H:i:s" />
				<img  src="<%=SkinUtils.getImage(request,"default/shared/calendar.gif")%>"
				 height="20" onclick="LoushangDatetime('pmEndTime_id')" />
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" width="30%" ><button onclick="del()">批量删除</button> </td>
				<td class="FieldLabel" width="10%" ><button onclick="back()">返回查询页面</button> </td>
			</tr>
		</table>
	</next:Html>
</next:Panel>

</body>
</html>
