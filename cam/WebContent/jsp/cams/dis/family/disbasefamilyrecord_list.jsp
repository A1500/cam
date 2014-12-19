
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>DIS_BASE_FAMILY_RECORD列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="disbasefamilyrecord_list.js"></script>
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
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.dis.base.cmd.DisBaseFamilyRecordQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.dao.support.DisBaseFamilyRecord"></model:record>
	</model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 95%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel">RECORD_ID:</td>
								<td class="FieldInput"><input type="text"  id="recordId" class="TextEditor" title="RECORD_ID"  /></td>	
								<td class="FieldLabel">ORGAN_CODE:</td>
								<td class="FieldInput"><input type="text"  id="organCode" class="TextEditor" title="ORGAN_CODE"  /></td>	
								<td class="FieldLabel">ORGAN_NAME:</td>
								<td class="FieldInput"><input type="text"  id="organName" class="TextEditor" title="ORGAN_NAME"  /></td>	
								<td class="FieldLabel">TOWN_CODE:</td>
								<td class="FieldInput"><input type="text"  id="townCode" class="TextEditor" title="TOWN_CODE"  /></td>	
								<td class="FieldLabel">VILLIAGE_CODE:</td>
								<td class="FieldInput"><input type="text"  id="villiageCode" class="TextEditor" title="VILLIAGE_CODE"  /></td>	
								<td class="FieldLabel">NAME:</td>
								<td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="NAME"  /></td>	
								<td class="FieldLabel">ID_CARD:</td>
								<td class="FieldInput"><input type="text"  id="idCard" class="TextEditor" title="ID_CARD"  /></td>	
								<td class="FieldLabel">FAMILY_NUM:</td>
								<td class="FieldInput"><input type="text"  id="familyNum" class="TextEditor" title="FAMILY_NUM"  /></td>	
								<td class="FieldLabel">FAMILY_TYPE:</td>
								<td class="FieldInput"><input type="text"  id="familyType" class="TextEditor" title="FAMILY_TYPE"  /></td>	
								<td class="FieldLabel">FAMILY_REGISTER:</td>
								<td class="FieldInput"><input type="text"  id="familyRegister" class="TextEditor" title="FAMILY_REGISTER"  /></td>	
								<td class="FieldLabel">HOUSE_COUNT:</td>
								<td class="FieldInput"><input type="text"  id="houseCount" class="TextEditor" title="HOUSE_COUNT"  /></td>	
								<td class="FieldLabel">HOUSE_STRUCTURE:</td>
								<td class="FieldInput"><input type="text"  id="houseStructure" class="TextEditor" title="HOUSE_STRUCTURE"  /></td>	
								<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="disbasefamilyrecordGrid" width="100%" stripeRows="true" height="400" dataset="ds" title="DIS_BASE_FAMILY_RECORD">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="recordId" header="RECORD_ID" field="recordId" width="90" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="organCode" header="ORGAN_CODE" field="organCode" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="organName" header="ORGAN_NAME" field="organName" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="townCode" header="TOWN_CODE" field="townCode" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="villiageCode" header="VILLIAGE_CODE" field="villiageCode" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="name" header="NAME" field="name" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="idCard" header="ID_CARD" field="idCard" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="familyNum" header="FAMILY_NUM" field="familyNum" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="familyType" header="FAMILY_TYPE" field="familyType" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="familyRegister" header="FAMILY_REGISTER" field="familyRegister" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="houseCount" header="HOUSE_COUNT" field="houseCount" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="houseStructure" header="HOUSE_STRUCTURE" field="houseStructure" width="90" >
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
