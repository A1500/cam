
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ include file="/jsp/public/resources_jspdir.jsp" %>
<html>
	<head>
		<title><%=res.get("ID.ID_TITLE") %></title>
		<next:ScriptManager/>
		<script type="text/javascript" src="pubidtable_list.js"></script>
		<script language="javascript">
			/*Javascript文件中的消息：用于国际化处理*/
			var addtext='<%=res.get("ID.ADDTITLE")%>';//增加业务流水号
			
			var updatetext='<%=res.get("ID.UPDATETITLE")%>';//修改业务流水号
			var alerttitle='<%=res.get("ID.ALERTTITLE")%>';//提示
			var selectone='<%=res.get("ID.SELECTONE")%>';//请选择一条记录修改!请选择要删除的记录!
			var selectdel='<%=res.get("ID.SELECTDEL")%>';//请选择要删除的记录!
			var sure='<%=res.get("ID.SURE")%>';//确定
			var confirm='<%=res.get("ID.CONFIRM")%>';//确定要删除选中的记录吗?
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
	<model:dataset id="useStatus" enumName="BSP.IN_USE"  autoLoad="true" global="true"></model:dataset>
	<model:dataset id="idTypes" enumName="ID.TYPE"  autoLoad="true" global="true"></model:dataset>
	<model:dataset id="ds" cmd="org.loushang.bsp.id.cmd.PubIdtableQueryCommand" global="true" pageSize="20">
		<model:record fromBean="org.loushang.bsp.id.data.PubIdtable"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>

<next:AnchorLayout>



<next:GridPanel id="editGridPanel" notSelectFirstRow="true" width="100%" stripeRows="true" anchor="100% 100%"  dataset="ds">
	<next:TopBar>
		<next:ToolBarItem  text='<%=res.get("ID.ID") %>' />
		<next:ToolBarItem  xtype="textfield" id="idId" />
		<next:ToolBarItem  text='<%=res.get("ID.NAME") %>' />
		<next:ToolBarItem  xtype="textfield" id="idName" />
		<next:ToolBarItem text='<%=res.get("ID.QUERY")%>' iconCls="query" handler="query" />&nbsp;
		<next:ToolBarItem text="重置" iconCls="undo" handler="reset" />
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text='<%=res.get("ID.ADD") %>' iconCls="add" handler="insert" />
		<next:ToolBarItem text='<%=res.get("ID.UPDATE") %>' iconCls="edit" handler="update"/>
		<next:ToolBarItem text='<%=res.get("ID.DELETE") %>' iconCls="remove" handler="del"/>
		
		<next:ToolBarItem text='选择导出' iconCls="export" handler="exportSelected"/>
		<next:ToolBarItem text='全部导出' iconCls="export" handler="exportAll"/>
		<next:ToolBarItem text='导入' iconCls="import" handler="importId"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="idId" header='<%=res.get("ID.ID") %>' field="idId" width="100" >
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="idName" header='<%=res.get("ID.NAME") %>' field="idName" width="100" >
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="idValue" header='<%=res.get("ID.VALUE") %>' field="idValue" width="80" >
			<next:NumberField allowBlank="false" />
		</next:Column>
		<next:Column id="idLength" header='<%=res.get("ID.LENGTH") %>' field="idLength" width="80" >
			<next:NumberField allowBlank="false" />
		</next:Column>

		<next:Column id="isPrefix" header='<%=res.get("ID.ISPREFIX") %>' field="isPrefix" dataset="useStatus" width="80" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="idPrefix" header='<%=res.get("ID.PREFIX") %>' field="idPrefix" width="80" >
			<next:TextField  />
		</next:Column>
		<next:Column id="isSuffix" header='<%=res.get("ID.ISSUFFIX") %>' field="isSuffix" dataset="useStatus" width="80" >
			<next:TextField  />
		</next:Column>
		<next:Column id="idSuffix" header='<%=res.get("ID.SUFFIX") %>' field="idSuffix" width="80" >
			<next:TextField  />
		</next:Column>
		<next:Column id="isGlobal" header='<%=res.get("ID.ISGLOBAL") %>' field="isGlobal" dataset="useStatus" width="80" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="organId" header='<%=res.get("ID.ORGANID") %>' field="organId" width="80" >
			<next:TextField  />
		</next:Column>
		<next:Column id="idType" header='<%=res.get("ID.IDTYPE") %>' field="idType" dataset="idTypes" width="80" >
			<next:TextField  />
		</next:Column>

	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar  dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
