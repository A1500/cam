
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script type="text/javascript">
     var Id = '<%=request.getParameter("dataBean")%>';
</script>
<html>
	<head>
		<title>义务兵家庭基本信息明细</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="bptcompulsory_detail.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptCompulsoryQueryCommand" global="true" method="queryUpdateCompulsory">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptCompulsory">
		<model:field name="domicileName" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 是否进藏、进疆 -->
	<model:dataset id="composedPort" enumName="COMM.YESORNO" 
	global="true" autoLoad="true">
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
	<!-- 开户银行 -->
	<model:dataset id="bank" enumName="BANK.CODE" 
	global="true" autoLoad="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel width="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	    <next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="99%" >
		
	   		<tr>
				<td class="FieldLabel" nowrap style="width:16%">姓名：</td>
				<td class="FieldInput" style="width:16%"><label field="name" /> </td>
			
				<td class="FieldLabel" nowrap style="width:16%">性别：</td>
				<td class="FieldInput" style="width:16%"><label field="sex" dataset="SexDataset" /> </td>
			
				<td class="FieldLabel" nowrap style="width:16%">身份证号：</td>
				<td class="FieldInput" style="width:16%"><label field="idCard" /></td>
			</tr>
	   		<tr>
				<td class="FieldLabel" nowrap >出生日期：</td>
				<td class="FieldInput" ><label field="birthday" /> </td>
			
				<td class="FieldLabel" nowrap >民族：</td>
				<td class="FieldInput" ><label field="nation" dataset="NationDataset" /> </td>
			
				<td class="FieldLabel" nowrap >优待安置证编号：</td>
				<td class="FieldInput" ><label field="specialSettingNo" /> </td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel" nowrap>入伍时间：</td>
				<td class="FieldInput"><label name="conscriptDate" field="conscriptDate"/></td>
				<td class="FieldLabel" nowrap>进藏 进疆：</td>
				<td class="FieldInput"><label field="composedPortrait" dataset="composedPort"/></td>
				<td class="FieldLabel">户籍类别：</td>
				<td class="FieldInput"><label name="domicileType" field="domicileType" id="domicileType" dataset="DomicileDataset"/></td>
			</tr>
	   		<tr>		
				<td class="FieldLabel" nowrap >联系方式：</td>
				<td class="FieldInput" ><label field="telContact"/></td>
				<td class="FieldLabel" nowrap >邮编：</td>
				<td class="FieldInput" colspan="3"><label field="postcode"/></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" nowrap >家庭所属行政区划：</td>
				<td class="FieldInput" ><label field="domicileName"/></td>
				<td  class="FieldLabel" nowrap >住址：</td>
				<td class="FieldInput" colspan="3" ><label field="address"/></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" nowrap >父亲姓名：</td>
				<td class="FieldInput" ><label field="fatherName" /> </td>
				<td  class="FieldLabel" nowrap >父亲单位：</td>
				<td class="FieldInput" ><label field="fatherUnit" /> </td>
				<td  class="FieldLabel" nowrap >父亲联系方式：</td>
				<td class="FieldInput" ><label field="fatherContact" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" nowrap >母亲姓名：</td>
				<td class="FieldInput" ><label field="motherName" /> </td>
				<td  class="FieldLabel" nowrap >母亲单位：</td>
				<td class="FieldInput" ><label field="motherUnit" /> </td>
				<td  class="FieldLabel" nowrap  >母亲联系方式：</td>
				<td class="FieldInput"  ><label field="motherContact" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" nowrap >开户银行：</td>
				<td class="FieldInput" ><label field="bank" dataset="bank" /> </td>
				<td  class="FieldLabel" nowrap >开户账号：</td>
				<td class="FieldInput"  colspan="3"><label field="accountCode" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" nowrap >备注：</td>
				<td  class="FieldInput"  colspan="5"><label field="note" /> </td>
			</tr>			
		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
