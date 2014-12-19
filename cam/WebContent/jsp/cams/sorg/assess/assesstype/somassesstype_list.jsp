
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>社会组织评估类型配置列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="somassesstype_list.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.assess.assesstype.cmd.SomAssessTypeQueryCommand" global="true" sortField="type">
		<model:record fromBean="com.inspur.cams.sorg.assess.assesstype.dao.SomAssessType"></model:record>
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
					<form style="width: 100%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel" style='width:20%'>评估类型:</td>
								<td class="FieldInput"style='width:20%'><input type="text"  id="type" class="TextEditor" title="TYPE"  style='width:80%'/></td>	
								<td class="FieldLabel"style='width:20%'>评估类型描述:</td>
								<td class="FieldInput"style='width:20%'><input type="text"  id="typeDesc" class="TextEditor" title="TYPE_DESC"  style='width:80%'/></td>	
								<td class="FieldButton"style='width:20%'><button onclick="query()">查 询</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="somassesstypeGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="社会组织评估类型配置列表">
	<next:TopBar>
		<next:ToolBarItem text="维护评估内容" iconCls="edit" handler="assess" />
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="id" header="ID" field="id" width="90"  hidden="true">
		</next:Column>
	
		<next:Column id="type" header="评估类型" field="type" width="15%" >
		</next:Column>
	
		<next:Column id="sorgType" header="评估社会组织类型" field="sorgType" width="15%" >
		</next:Column>
	
		<next:Column id="typeDesc" header="评估类型描述" field="typeDesc" width="45%" >
		</next:Column>
	
		<next:Column id="status" header="状态" field="status" width="15%" >
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
