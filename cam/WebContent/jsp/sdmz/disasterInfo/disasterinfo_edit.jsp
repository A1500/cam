<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.sdmz.comm.util.BspUtil"%>
<%@page import="com.inspur.sdmz.comm.util.DateUtil"%>
<%
String disasterId=IdHelp.getUUID32();
%>
<html>
	<head>
		<title>灾情信息编辑</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
			var disasterId='<%=disasterId%>';
			var regPeopleName='<%=BspUtil.getEmpOrgan().getOrganName()%>';
			var regOrganName ='<%=BspUtil.getCorpOrgan().getOrganName()%>';
		    var regTime ='<%=DateUtil.getNewTime()%>';
		</script>
		<script type="text/javascript" src="disasterinfo_edit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.sdmz.disasterInfo.cmd.DisasterInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.sdmz.disasterInfo.dao.DisasterInfo"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="灾情信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm" dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table  width="98%" >
	   		<tr>
	   		    <input type="hidden" name="disasterId" field="disasterId"  />
				<td class="FieldLabel" >灾情标题:</td>
				<td class="FieldInput" colspan="5"><input type="text" name="disasterTitle" field="disasterTitle" maxlength="25" style="width:440"/> </td>
			</tr>
	   		<tr>
			    <td class="FieldLabel"><label>灾情发生时间：</label></td>
				<td class="FieldInput"><input type="text" name="disasterTime"  field="disasterTime" id="disasterTime"  style="width:100" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/></td>
				<td  colspan="2"></td>
				<td  class="FieldLabel">灾情发生地点:</td>
				<td class="FieldInput"><input type="text" name="disasterAdd" field="disasterAdd" maxlength="12" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >灾情情况:</td>
				<td class="FieldInput" colspan="5"><textarea name="disasterSituation" rows="10" wrap=PHYSICAL style="width:90%"  field="disasterSituation"></textarea> 
		    </tr>
	   		<tr>
				<td  class="FieldLabel" >上报人:</td>
				<td  class="FieldInput"><label name="regPeople" field="regPeople"> </td>
				
				<td  class="FieldLabel" >上报单位:</td>
				<td class="FieldInput"><label name="regOrgan" field="regOrgan"> </td>
		 
				<td class="FieldLabel">上报时间:</td>
				<td class="FieldInput"><label name="regTime" field="regTime"></td>
		     </tr>
				 <input type="hidden" name="regPeopleId" field="regPeopleId"  />
				 <input type="hidden" name="regOrganId" field="regOrganId"  />
				 <input type="hidden" name="regOrganArea" field="regOrganArea"  /> 
	   		     <input type="hidden" name="modPeople" field="modPeople"/>
				 <input type="hidden" name="modPeopleId" field="modPeopleId"/>
			     <input type="hidden" name="modOrgan" field="modOrgan"/> 
			     <input type="hidden" name="modOrganId" field="modOrganId"/>  
			     <input type="hidden" name="modTime" field="modTime"/>
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
