
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
<title><%=res.get("PUB_ORGAN_PARMS_TYPE.TITLE")%></title>
<next:ScriptManager />
<script language="javascript">

	 	 //查询条件打开合并函数
		 function collapse(element){
			var fieldsetParent=L5.get(element).findParent("fieldset");
			if(element.expand==null||element.expand==true){
				fieldsetParent.getElementsByTagName("div")[0].style.display="none";
				element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
				element.expand=false;
			}else{
				fieldsetParent.getElementsByTagName("div")[0].style.display="";
				element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
				element.expand =true;
			}
		}
		 var RES_PROMPT='<%=res.get("MSG.PROMOT")%>';
		 var RES_NOCHANGE='<%=res.get("MSG.NOCHANGE")%>';
		 var RES_SAVE='<%=res.get("MSG.SAVE")%>';
		 var RES_DELETE='<%=res.get("ASK.DELETE")%>';
		 var RES_UNVALIDATED='<%=res.get("MSG.UNVALIDATED")%>';
	</script>
<script type="text/javascript" src="puborganparmstype_listform.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="dataSourceDs" enumName="BSP.PARMSTYPE_DATASOURCE"
		global="true" />
	<model:dataset id="inUseDs" enumName="BSP.IN_USE" autoLoad="true"
		global="true" />
	<model:dataset id="ds" pageSize="-1"
		cmd="org.loushang.bsp.organization.cmd.PubOrganParmsTypeQueryCommand"
		global="true" >
		<model:record
			fromBean="org.loushang.bsp.organization.data.PubOrganParmsType"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel name="form" anchor="100% 15%" border="false" autoScroll="true">
			<next:Html>

				<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
				<form style="width: 70%; height: 100%;" class="L5form">

				<table width="100%">
					<tr>
						<td class="FieldLabel"><%=res
											.get("PUB_ORGAN_PARMS_TYPE.ORGAN_PARMS_NAME")%>:</td>
						<td class="FieldInput"><input type="text" id="organParmsName"
							class="TextEditor" title="组织参数名称" /></td>
						<td class="FieldLabel">
						<button type="button" onclick="queryit()"><%=res.get("BUT.QUERY")%></button>
						<button type="button" onclick="reset()">重置</button>
						</td>
					</tr>
				</table>
				</form></div>
				</fieldset>
			</next:Html>
		</next:Panel>
		<next:GridPanel id="editGridPanel" notSelectFirstRow="true" name="puborganparmstypeGrid"
			anchor="100% 40%" stripeRows="true" border="false" dataset="ds" autoScroll="true">
			<next:TopBar>
				<next:ToolBarItem symbol="->" />
				<next:ToolBarItem iconCls="add" text='<%=res.get("BUT.ADD")%>'
					handler="insert" />
				<next:ToolBarItem iconCls="remove" text='<%=res.get("BUT.REMOVE")%>'
					handler="del" />
				<next:ToolBarItem iconCls="save" text='<%=res.get("BUT.SAVE")%>'
					handler="save" />
				<next:ToolBarItem iconCls="undo" text='<%=res.get("BUT.UNDO")%>'
					handler="reset" />
			</next:TopBar>
			<next:Columns onRowSelect="RowSelect">
				<next:RowNumberColumn width="30" />
				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column id="organParmsNameColumn"
					header='<%=res.get("PUB_ORGAN_PARMS_TYPE.ORGAN_PARMS_NAME")%>'
					field="organParmsName" width="120">
					<next:TextField allowBlank="false" />
				</next:Column>

				<next:Column id="organParmsDes"
					header='<%=res.get("PUB_ORGAN_PARMS_TYPE.ORGAN_PARMS_DES")%>'
					field="organParmsDes" width="250">
					<next:TextField allowBlank="false" />
				</next:Column>

				<next:Column id="note"
					header='<%=res.get("PUB_ORGAN_PARMS_TYPE.NOTE")%>' field="note"
					width="300">
					<next:TextField />
				</next:Column>

			</next:Columns>

		</next:GridPanel>
		<next:Panel border="false" anchor="100% 49%" collapsible="true" autoScroll="true">
			<next:Html>
				<form id="editForm" dataset="ds" onsubmit="return false"
					class="L5form">
				<fieldset id="fieldset0"><legend><%=res.get("PUB_ORGAN_PARMS_TYPE.TITLE")%></legend>
				<table width="100%" >

					<tr>
						<td class="FieldLabel"><%=res
									.get("PUB_ORGAN_PARMS_TYPE.DATA_SOURCE")%></td>
						<td class="FieldInput"><select id="dataSource_select"
							name="dataSource" field="dataSource" onchange="displayTable()"
							>
							<option dataset="dataSourceDs"></option>
						</select><font color="red">*</font></td>
						<td class="FieldLabel"><%=res.get("PUB_ORGAN_PARMS_TYPE.ORGAN_PARMS_NAME")%></td>
						<td class="FieldInput"><input type="text" name="organParmsName" id="organParmName" disabled="disabled" "
							field="organParmsName"/><font color="red">*</font></td>

					</tr>
					<tr>
						<td class="FieldLabel"><%=res
											.get("PUB_ORGAN_PARMS_TYPE.ORGAN_PARMS_DES")%></td>
						<td class="FieldInput"><input type="text"
							name="organParmsDes" field="organParmsDes" /><font color="red">*</font></td>
						<td class="FieldLabel"><%=res.get("PUB_ORGAN_PARMS_TYPE.NOTE")%></td>
						<td class="FieldInput"><input type="text" name="note"
							id="note_default" field="note" /></td>
					</tr>
					<tr id="enum_only_tr" style="display:none">
						<td class="FieldLabel"><%=res
											.get("PUB_ORGAN_PARMS_TYPE.ENUM_NAME")%></td>
						<td class="FieldInput"><input type="text" name="enumName"
							field="enumName" /><font color="red">*</font></td>

						<td class="FieldLabel"><%=res.get("PUB_ORGAN_PARMS_TYPE.ENUM_DES")%></td>
						<td class="FieldInput"><input type="text" name="enumDes"
							field="enumDes" /></td>
					</tr>
					<tr id="src_table" style="display:none" >
						<td class="FieldLabel"><%=res
											.get("PUB_ORGAN_PARMS_TYPE.SOURCE_TABLE_NAME")%></td>
						<td class="FieldInput"><input type="text"
							name="sourceTableName" field="sourceTableName" /><font color="red">*</font></td>
						<td class="FieldLabel"><%=res
											.get("PUB_ORGAN_PARMS_TYPE.SOURCE_TABLE_DES")%></td>
						<td class="FieldInput"><input type="text"
							name="sourceTableDes" field="sourceTableDes" /></td>
					</tr>
					<tr id="select_column" style="display:none">
						<td class="FieldLabel"><%=res.get("PUB_ORGAN_PARMS_TYPE.SEL_COL")%></td>
						<td class="FieldInput"><input type="text" name="selCol"
							field="selCol" /><font color="red">*</font></td>
						<td class="FieldLabel"><%=res
									.get("PUB_ORGAN_PARMS_TYPE.SEL_COL_DES")%></td>
						<td class="FieldInput"><input type="text" name="selColDes"
							field="selColDes" /></td>

					</tr >
					<tr id="display_column" style="display:none">
						<td class="FieldLabel"><%=res.get("PUB_ORGAN_PARMS_TYPE.DISP_COL")%></td>
						<td class="FieldInput"><input type="text" name="dispCol"
							field="dispCol" /><font color="red">*</font></td>
						<td class="FieldLabel"><%=res.get("PUB_ORGAN_PARMS_TYPE.DISP_COL_DES")%></td>
						<td class="FieldInput"><input type="text" name="dispColDes"
							field="dispColDes" /></td>
					</tr>
					<tr id="where_condition" style="display:none" >
						<td class="FieldLabel"><%=res.get("PUB_ORGAN_PARMS_TYPE.IS_USE_WHERE")%>
						</td>
						<td  class="FieldInput">
						<input id="is_use_where_input" type="checkbox"  onclick="onchecked(this)"></input>
						<input type="text"  id="rely_on_checkbox" style="display:none" name="whereCondition"
							onchange="check_correct(this)" field="whereCondition" style="width:80%" />
						</td>
						<td class="FieldLabel"></td>
						<td class="FieldInput" ></td>
					</tr>
					</table>
					</fieldset>
				</form>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
