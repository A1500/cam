
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>FIS_CREMATION_RATE_CONFIG列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="fiscremationrateconfig_list.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.fis.cremationRate.cmd.FisCremationRateConfigQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.fis.cremationRate.dao.FisCremationRateConfig"></model:record>
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
								<td class="FieldLabel">NAME:</td>
								<td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="NAME"  /></td>	
								<td class="FieldLabel">SUM_YEAR:</td>
								<td class="FieldInput"><input type="text"  id="sumYear" class="TextEditor" title="SUM_YEAR"  /></td>	
								<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="fiscremationrateconfigGrid" width="100%" stripeRows="true" height="400" dataset="ds" title="FIS_CREMATION_RATE_CONFIG">
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
	
		<next:Column id="id" header="ID" field="id" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="name" header="NAME" field="name" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="leve" header="LEVE" field="leve" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="ups" header="UPS" field="ups" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="flag" header="FLAG" field="flag" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="fullName" header="FULL_NAME" field="fullName" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="isSelf" header="IS_SELF" field="isSelf" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="sumYear" header="SUM_YEAR" field="sumYear" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="totalNum" header="TOTAL_NUM" field="totalNum" width="90" >
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="deadRate" header="DEAD_RATE" field="deadRate" width="90" >
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="deadNum" header="DEAD_NUM" field="deadNum" width="90" >
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="cremationNum" header="CREMATION_NUM" field="cremationNum" width="90" >
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="cremationRate" header="CREMATION_RATE" field="cremationRate" width="90" >
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="sumTime" header="SUM_TIME" field="sumTime" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="sumPeople" header="SUM_PEOPLE" field="sumPeople" width="90" >
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
