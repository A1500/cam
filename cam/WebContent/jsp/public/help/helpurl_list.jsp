<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ include file="/jsp/public/resources_jspdir.jsp" %>
<html>
	<head>
		<title><%=res.get("HELP.LIST_TITLE") %></title>
		<next:ScriptManager/>
		<script type="text/javascript" src="helpurl_list.js"></script>
		<script language="javascript">
			/*Javascript文件中的消息：用于国际化处理*/
			var alerttitle='<%=res.get("MSG.PROMOT")%>';//提示
			var selectone='<%=res.get("MSG.SEL_ONE_RECORD")%>';//请选择一条记录!
			var selectdel='<%=res.get("MSG.SEL_DEL_RECORD")%>';//请选择要删除的记录!
			var confirm='<%=res.get("ASK.DELETE")%>';//确定要删除选中的记录吗?
			var addLocalText = '<%=res.get("HELP.ADDLOCAL") %>';
			var addRemoteText = '<%=res.get("HELP.ADDREMOTE") %>';
			var	updatetext = '<%=res.get("HELP.MODIFY") %>';
			var yesText = '<%=res.get("HELP.YES_TEXT") %>';
			var noText = '<%=res.get("HELP.NO_TEXT") %>';
		</script>
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
	<model:dataset id="useStatusDs" enumName="CMHELP.BOOL"  autoLoad="true" global="true" ></model:dataset>
	<model:dataset id="helpModuleDs" cmd="org.loushang.util.help.cmd.HelpModuleQueryCommand" global="true" pageSize="-1">
		<model:record fromBean="org.loushang.util.help.data.HelpModule"></model:record>
	</model:dataset>
	<model:dataset id="helpUrlDs" cmd="org.loushang.util.help.cmd.HelpUrlQueryCommand" global="true" pageSize="10">
		<model:record fromBean="org.loushang.util.help.data.HelpUrl"></model:record>
	</model:dataset>
</model:datasets>

<next:Panel>	
	<next:Html>
	<form id="queryForm" class="L5form" >
	<fieldset style="width: 100%">
		<legend><%=res.get("HELP.QUERY") %>
			<img class="GroupBoxExpandButton" src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%> onclick="collapse(this);"/>	
		</legend>
		<div>
		<table width="100%">
			<tr>
				<td class="FieldLabel"><label><%=res.get("HELP.MODULE_NAME") %></label></td>
				<td class="FieldInput">
					<input type="text"  id="moduleName" />
				</td>
				<td class="FieldLabel"><label><%=res.get("HELP.MODULE_ISLOCAL") %></label></td>
				<td class="FieldInput">
					<select id="isLocal" >
						<option dataset="useStatusDs"></option>
					</select>
				</td>
				<td class="FieldButton"><button onclick="query()" type="button"><%=res.get("BUT.QUERY")%></button></td>
			</tr>
		</table>
		</div>
		</fieldset>
	</form>
	</next:Html>
</next:Panel>	
<next:GridPanel id="helpModuleGrid" notSelectFirstRow="true" stripeRows="true" height="200" dataset="helpModuleDs" >
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text='<%=res.get("HELP.ADDLOCAL")%>' iconCls="add" handler="addLocal" />
		<next:ToolBarItem text='<%=res.get("HELP.ADDREMOTE")%>' iconCls="add" handler="addRemote" />
		<next:ToolBarItem text='<%=res.get("BUT.EDIT") %>' iconCls="edit" handler="update"/>
		<next:ToolBarItem text='<%=res.get("BUT.REMOVE") %>' iconCls="remove" handler="del"/>
	</next:TopBar>
	<next:Columns onRowSelect="queryUrls">
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column header='<%=res.get("HELP.MODULE_NAME") %>' field="moduleName" width="100" >
		</next:Column>
		<next:Column  header='<%=res.get("HELP.MODULE_ISLOCAL") %>' field="isLocal" width="100" renderer="chengeText">
		</next:Column>
		<next:Column header='<%=res.get("HELP.MODULE_URI") %>' field="uri" width="300" >
		</next:Column>
		<next:Column  header='<%=res.get("HELP.MODULE_NOTE") %>' field="note" width="300" >
		</next:Column>
	</next:Columns>
</next:GridPanel>
<next:GridPanel title='<%=res.get("HELP.TITLE_URL")%>' id="helpUrlGrid" notSelectFirstRow="true" stripeRows="true" height="300"  dataset="helpUrlDs">
	<next:Columns>
		<next:Column header='<%=res.get("HELP.URL_CODE")%>' field="helpCode" width="100" >
		</next:Column>
		<next:Column header='<%=res.get("HELP.URL_NAME")%>' field="helpName" width="100" >
		</next:Column>
		<next:Column header='<%=res.get("HELP.URL_URL")%>' field="url" width="180" >
		</next:Column>
		<next:Column header='<%=res.get("HELP.URL_DESCRIPTION")%>' field="description" width="300" >
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="helpUrlDs"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
