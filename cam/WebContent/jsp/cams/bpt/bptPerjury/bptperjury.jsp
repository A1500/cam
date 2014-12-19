
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<script type="text/javascript">
   var organCode='<%=BspUtil.getOrganCode()%>';
   var organType = '<%=BspUtil.getOrganType()%>';
   var method='<%=request.getParameter("method")%>';
   var perjuryId='<%=request.getParameter("perjuryId")%>';
</script>
<html>
	<head>
		<title>黑名单</title>
		<next:ScriptManager/>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="bptperjury.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptPerjuryQueryCommand" method="queryPerjury" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPerjury">
			<model:field name="perjuryId" type="string" mapping="PERJURY_ID"/>
			<model:field name="domicileCode" type="string" mapping="DOMICILE_CODE"/>
			<model:field name="domicileName" type="string" mapping="DOMICILE_NAME"/>
			<model:field name="name" type="string" mapping="NAME"/>
			<model:field name="idCard" type="string" mapping="ID_CARD"/>
			<model:field name="serviceType" type="string" mapping="SERVICE_TYPE"/>
			<model:field name="addDate" type="string" mapping="ADD_DATE"/>
			<model:field name="addPerson" type="string" mapping="ADD_PERSON"/>
		</model:record>
	</model:dataset>
	<!-- 业务类型 -->
	<model:dataset id="serverTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_SERVICE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
</model:datasets>

<next:Panel  title="人员信息" height="150" >
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	    <next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="保存" iconCls="save" handler="save" />
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" class="L5form" >
		<table border="1"  width="100%" >
		
	   		<tr>
				<td  class="FieldLabel" >所属行政区划</td>
				<td class="FieldInput" >
					<input type="text" name="domicileName" field="domicileName"  class="TextEditor" onclick="forHelp(this,true)" style="width:300"/><input type="hidden" id="domicileCode"  field="domicileCode" />
				</td>
			
				<td  class="FieldLabel" >身份证号</td>
				<td class="FieldInput"><input type="text" name="idCard" field="idCard"  style="width:300" onchange="checkDoublePerson(this)"/><font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >姓名</td>
				<td class="FieldInput"><input type="text" name="name" field="name"  /> </td>
			
				<td  class="FieldLabel" >业务类型</td>
				<td class="FieldInput">
				<select name="serviceType" field="serviceType" style="width:300">
					<option dataset="serverTypeDataset" ></option>
				</select>
				
				</td>
			
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
