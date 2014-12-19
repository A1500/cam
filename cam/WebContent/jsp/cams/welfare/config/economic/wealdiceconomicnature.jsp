
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>

<html>
	<head>
		<title>经济性质</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="wealdiceconomicnature.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.welfare.config.economic.cmd.WealDicEconomicnatureQueryCommand" global="true" autoLoad="true" >
		<model:record fromBean="com.inspur.cams.welfare.config.economic.dao.WealDicEconomicnature">
			<model:field name="code" type="string" rule="require|length{2}" />
		</model:record>
	</model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" autoHeight="true" >
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
						<td class="FieldLabel">编号:</td>
						<td class="FieldInput"><input type="text"  id="code" class="TextEditor" title="编号"  /></td>			
						<td class="FieldLabel">经济性质:</td>
						<td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="经济性质"  /></td>			
						<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
					</tr>
					<tr>
						<td class="FieldLabel">类型:</td>
						<td class="FieldInput"><input type="text"  id="type" class="TextEditor" title="类型"  /></td>
						<td class="FieldLabel"></td>
						<td class="FieldInput"></td>
						<td class="FieldLabel"><button onclick="reset()">重 置</button> </td>
					</tr>								
				</table>
				</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>	

<next:EditGridPanel id="editGridPanel" name="wealdiceconomicnatureGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="经济性质">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
			<next:ToolBarItem  iconCls="add" text="增加" handler="insert"  />
			<next:ToolBarItem  iconCls="remove" text="删除" handler="del"  />
			<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
			<next:ToolBarItem iconCls="undo"  text="取消" handler="reset"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="code"  header="编号"  field="code" width="95" >			
			<next:TextField   />
		</next:Column>
	
		<next:Column id="name" header="经济性质" field="name" width="140" >			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="type" header="类型" field="type" width="95" hidden="true">			
			<next:TextField  />
		</next:Column>
			
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>
