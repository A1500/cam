<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ include file="/jsp/public/resources_jspdir.jsp" %>
<%
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	//System.out.println(request.getAttributeNames());
	//System.out.println(request.getAttribute("organTypeList"));
%>
<html>
	<head>
		<title>PUB_STRU_RULE列表</title>
		<script type="text/javascript">
			//ORGANTYPE.messType=确定
			var messType='<%=res.get("ORGAN.messType")%>';
			var messTypePrompt='<%=res.get("ORGAN.messTypePrompt")%>';
			//ORGANTYPE.Save.NoDataMess=没有需要保存的数据!
			var saveNoDataMess='<%=res.get("ORGAN.Save.NoDataMess")%>';
			var saveValidateMess='<%=res.get("ORGAN.Save.ValidateMess")%>';
			var RES_PROMPT='<%=res.get("MSG.PROMOT")%>';
			var RES_DELETE='<%=res.get("ASK.DELETE")%>';

			var saveValidateMessInputBigen='<%=res.get("ORGAN.Save.ValidateMessInputBigen")%>';
			var saveValidateMessInputEnd='<%=res.get("ORGAN.Save.ValidateMessInputEnd")%>';
			//ORGANTYPE.Save.SuccessMess="数据保存成功!
			var saveSuccessMess='<%=res.get("ORGAN.Save.SuccessMess")%>';
			//ORGANTYPE.Delete.PleaseSelectData=请选择要删除的记录！
			var deletePleaseSelectData='<%=res.get("ORGAN.Delete.PleaseSelectData")%>';
			//ORGANTYPE.Delete.SelectDataMess=你确定要删除吗？
			var deleteSelectDataMess='<%=res.get("ORGAN.Delete.SelectDataMess")%>';
			//
			var saveRepeatMess='<%=res.get("StruRule.saveRepeatMess")%>';

		</script>
		<next:ScriptManager/>
		<script type="text/javascript" src="pubstrurule_listform.js"></script>
		 <script language="javascript">
	 	 //查询条件打开合并函数
		 function collapse(element){
			var fieldsetParent=L5.get(element).findParent("fieldset");
			if(element.expand==null||element.expand==true){
				fieldsetParent.getElementsByTagName("div")[0].style.display="none";
				element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';
				element.expand=false;
			}else{
				fieldsetParent.getElementsByTagName("div")[0].style.display="";
				element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";
				element.expand =true;
			}
		}
	</script>
	</head>

<body>
<model:datasets>
	<model:dataset id="organTypeDs" cmd="org.loushang.bsp.organization.cmd.OrganTypeQueryCommand" global="true" sortField="organType" pageSize="-1">
		<model:record>
			<model:field name="value" mapping="organType" type="string"/>
			<model:field name="text" mapping="typeName" type="string"/>
		</model:record>
	</model:dataset>
	<model:dataset id="organTypeDsNew" cmd="org.loushang.bsp.organization.cmd.OrganTypeQueryCommand" global="true"  sortField="organType" pageSize="-1">
		<model:record>
			<model:field name="value" mapping="organType" type="string"/>
			<model:field name="text" mapping="typeName" type="string"/>
		</model:record>
	</model:dataset>
	<model:dataset id="ds" cmd="org.loushang.bsp.organization.cmd.PubStruRuleQueryCommand" global="true" sortField="stru_Type">
		<model:record fromBean="org.loushang.bsp.organization.data.PubStruRule"></model:record>
	</model:dataset>
	<model:dataset id="struTypeDs" cmd="org.loushang.bsp.organization.cmd.PubStruTypeQueryCommand" sortField="struType">
		<model:record>
			<model:field name="value" mapping="struType" type="string"/>
			<model:field name="text" mapping="typeName" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort><next:AnchorLayout>
<next:Panel  name="form"  border="false"  anchor="100% 15%" autoScroll="true">
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox" >
		<legend class="GroupBoxTitle">查询条件
		<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)"/>	</legend>
		<div>
		<form class="L5form">
				<table  width="100%" >
					<tr >
						<td class="FieldLabel"><%=res.get("StruRule.struType") %></td>
						<td class="FieldInput">
							<select name="struType" id="struType0" field="struType" >
								<option dataset="struTypeDs"></option>
							</select>
						</td>
						<td class="FieldLabel"><%=res.get("StruRule.srcRef") %></td>
						<td class="FieldInput">
							<select name="srcRef" id="srcRef0" field="srcRef" >
								<option dataset="organTypeDs"></option>
							</select>
						</td>
						<td class="FieldLabel"><%=res.get("StruRule.targetRef") %></td>
						<td class="FieldInput">
							<select name="targetRef" id="targetRef0" field="targetRef" >
								<option dataset="organTypeDs"></option>
							</select>
						</td>
						<td class="FieldLabel"><button  type="button" onclick="query()"><%=res.get("StruRule.query") %></button> </td>
						<td class="FieldLabel"><button  type="button" onclick="reset()">重置</button> </td>
					</tr>
				</table>
			</form></div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:EditGridPanel id="editGridPanel" name="pubstruruleGrid"  border="false" stripeRows="true" anchor="100% 80%" autoScroll="false"
		dataset="ds"  collapsible="true" >
	<next:TopBar>
		<next:ToolBarItem symbol='<%=res.get("StruRule.gridTitle") %>' ></next:ToolBarItem>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem  iconCls="add" text='<%=res.get("BUT.ADD") %>' handler="insert"  />
		<next:ToolBarItem  iconCls="remove" text='<%=res.get("BUT.REMOVE") %>' handler="del"  />
		<next:ToolBarItem iconCls="save"  text='<%=res.get("BUT.SAVE") %>' handler="save"/>
		<next:ToolBarItem iconCls="undo"  text='<%=res.get("BUT.UNDO") %>' handler="reset"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="ruleId" header="RULE_ID" field="ruleId" width="200" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="struType" header='<%=res.get("StruRule.struType") %>' field="struType" width="160" >
			<next:ComboBox dataset="struTypeDs" typeAble="false"/>
		</next:Column>


		<next:Column id="srcRefName" header='<%=res.get("StruRule.srcRefName") %>' field="srcRef" width="160" >
			<next:ComboBox dataset="organTypeDs" typeAble="false"/>
		</next:Column>

		<next:Column id="targetRef" header='<%=res.get("StruRule.targetRef") %>'  field="targetRef" width="380" renderer="render_targetRef">
			<next:TriggerField onTriggerClick="openTargetRefWin" readOnly="true">
			</next:TriggerField>
		</next:Column>
		<next:Column id="ruleNote" header='<%=res.get("StruRule.node") %>' field="ruleNote" width="200" hidden="true">
			<next:TextField  />
		</next:Column>

	</next:Columns>

</next:EditGridPanel>
</next:AnchorLayout></next:ViewPort>
<next:Window id="targetRefWin" title='<%=res.get("StruRule.targetRef")%>' resizable="false" width="500" height="300" lazyRender="false" closable="false">
	<next:FitLayout>
		<next:Panel  id="extend" border="false">
		<next:Html>
			<form  onsubmit="return false" dataset="ds" class="L5form">
				<input type="hidden" systype="itemselector"  id="targetRefId"  field="targetRef">
				<div id="favordiv" ></div>
			</form>
	    </next:Html>
		</next:Panel>
	</next:FitLayout>
	<next:Buttons>
		<next:ToolButton text="确定" handler="win_sure"></next:ToolButton>
		<next:ToolButton text="关闭" handler="win_close"></next:ToolButton>
	</next:Buttons>
</next:Window>
</body>
</html>
