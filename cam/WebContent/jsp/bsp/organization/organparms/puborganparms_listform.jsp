
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
	<head>
		<title><%=res.get("PUB_ORGAN_PARMS.TITLE")%></title>
		<next:ScriptManager/>
		<script type="text/javascript" src="puborganparms_listform.js"></script>
		<script language="javascript">
			var organId='<%=request.getParameter("organId")%>';
			var RES_PROMOT='<%=res.get("MSG.PROMOT")%>';
			var RES_NOCHANGE='<%=res.get("MSG.NOCHANGE")%>';
			var RES_SAVE='<%=res.get("MSG.SAVE")%>';
			var RES_DELETE='<%=res.get("ASK.DELETE")%>';
			var RES_UNVALIDATED='<%=res.get("MSG.UNVALIDATED")%>';
		</script>

	</head>
<body>

<model:datasets>

	<model:dataset id="parmsTypeDs" autoLoad="true" global="true" cmd="org.loushang.bsp.organization.cmd.PubOrganParmsTypeQueryCommand" pageSize="-1">

		<model:record>
			<model:field name="value" mapping="organParmsName"/>
			<model:field name="text" mapping="organParmsName"/>
			<model:field name="organParmsName" mapping="organParmsName"/>
			<model:field name="dataSource" mapping="dataSource"/>
			<model:field name="enumName" mapping="enumName"/>
			<model:field name="sourceTableName" mapping="sourceTableName"/>
			<model:field name="whereCondition" mapping="whereCondition"/>
			<model:field name="selCol" mapping="selCol"/>
			<model:field name="dispCol" mapping="dispCol"/>
		</model:record>
	</model:dataset>

	<model:dataset id="parmsHelpDs" autoLoad="true" cmd="org.loushang.bsp.organization.cmd.PubOrganParmsHelpQueryCommand">
				<model:record>
					<model:field name="selcol" mapping="SELCOL"/>
					<model:field name="dispcol" mapping="DISPCOL"/>

				</model:record>
	</model:dataset>
	<model:dataset id="ds" cmd="org.loushang.bsp.organization.cmd.PubOrganParmsQueryCommand" global="true">
		<model:record fromBean="org.loushang.bsp.share.organization.bean.PubOrganParms"></model:record>
	</model:dataset>
</model:datasets>

<script type="text/javascript" src="parmhelp.js"></script>
<next:GridPanel id="editGridPanel" name="puborganparmsGrid" width="100%" stripeRows="true" height="320" dataset="ds" title="组织参数表">
	<next:TopBar>
		<next:ToolBarItem  symbol="->"  />
		<next:ToolBarItem  iconCls="add" text='<%=res.get("BUT.ADD")%>' handler="insert"  />
		<next:ToolBarItem  iconCls="remove" text='<%=res.get("BUT.REMOVE")%>' handler="del"  />
		<next:ToolBarItem iconCls="save"  text='<%=res.get("BUT.SAVE")%>' handler="save"/>
		<next:ToolBarItem iconCls="undo"  text='<%=res.get("BUT.UNDO")%>' handler="reset"/>
		<next:ToolBarItem iconCls="no"  text="关闭" handler="closed"/>
	</next:TopBar>
	<next:Columns  onRowSelect="RowSelect">
	    <next:RowNumberColumn  width="30"/>

		<next:Column id="parmsNameCol"  header='<%=res.get("PUB_ORGAN_PARMS.PARMS_NAME")%>'  field="parmsName" width="125" />

		<next:Column id="parmsValueCol" header='<%=res.get("PUB_ORGAN_PARMS.PARMS_VALUE")%>'  field="parmsValue" width="125" />

		<next:Column id="noteCol" header='<%=res.get("PUB_ORGAN_PARMS.NOTE")%>'  field="note" width="200" />

	</next:Columns>

</next:GridPanel>
<next:Panel  title="组织参数表">
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" class="L5form">
		<table border="1"  width="100%" >

	   		<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_ORGAN_PARMS.PARMS_NAME")%></td>
				<td class="FieldInput">
					<input type="text" id="parmsName" name="parmsName" field="parmsName" readonly="readonly" />
					<img id="parmsName" src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="selectOrganParms()" />

				</td>

				<td  class="FieldLabel" ><%=res.get("PUB_ORGAN_PARMS.PARMS_VALUE")%></td>
				<td class="FieldInput">
					<input type="text" id="parmsValueText" name="parmsValueText" field="parmsValue" readonly="readonly" />
					<img id="parmsValueImg" src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="forHelp(this)" />

				</td>

			</tr>
	   		<tr>
				<td  class="FieldLabel" ><%=res.get("PUB_ORGAN_PARMS.NOTE")%></td>
				<td class="FieldInput" colspan="3">
					<input type="text" id="noteText" name="note" field="note"  width="300" />
				</td>
			</tr>

		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
