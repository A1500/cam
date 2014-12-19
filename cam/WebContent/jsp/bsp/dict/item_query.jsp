<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.utils.RequestUtils"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
	<title><%=res.get("ITEM_TITLE")%></title>
	<next:ScriptManager></next:ScriptManager>
	<script type="text/javascript" src="item_query.js"></script>
	<script type="text/javascript">
		var dictCode="<%=RequestUtils.getParameter(request,"DICT_CODE")%>";
		
	</script>
	<script language="javascript">
		var MSG_NOCHANGE='<%=res.get("MSG.NOCHANGE")%>';
		var ASK_DELETE='<%=res.get("ASK.DELETE")%>';
		var MSG_SEL_ONE_RECORD='<%=res.get("MSG.SEL_ONE_RECORD")%>';
		var MSG_SEL_DEL_RECORD='<%=res.get("MSG.SEL_DEL_RECORD")%>';
		var MSG_NO_PARENT='<%=res.get("MSG.NO_PARENT")%>';
	</script>
</head>
<body>
<model:datasets>
	<model:dataset id="dictItemDs" cmd="org.loushang.bsp.dict.DictItemQueryCommand" global="true">
		<model:record fromBean="org.loushang.bsp.dict.DictItem"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:EditGridPanel id="dictItemPanel" name="dictItemGrid" dataset="dictItemDs" stripeRows="true" width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text='<%=res.get("BUT.ADD")%>' iconCls="add" handler="insert" ></next:ToolBarItem>
		<next:ToolBarItem text='<%=res.get("BUT.SAVE")%>' iconCls="save" handler="save"></next:ToolBarItem>
		<next:ToolBarItem text='<%=res.get("BUT.REMOVE")%>' iconCls="remove" handler="del"></next:ToolBarItem>
		<next:ToolBarItem text='<%=res.get("BUT.CHILD")%>' iconCls="detail" handler="childquery" ></next:ToolBarItem>
		<next:ToolBarItem text='<%=res.get("BUT.PARENT")%>' iconCls="detail" handler="parentquery" id="parentQuery_button"></next:ToolBarItem>
		<next:ToolBarItem text='<%=res.get("BUT.BACK")%>' iconCls="return" handler="backquery" id="back_button"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column header='<%=res.get("ITEM_CODE")%>'  width="100" field="itemCode" >
		<next:TextField allowBlank="false" editable="disableEdit" />
		</next:Column>
		<next:Column header='<%=res.get("ITEM_NAME")%>'  width="120" field="itemValue">
				<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column header='<%=res.get("ITEM_XH")%>'  width="100" field="xh">
				<next:NumberField  allowBlank="false"  />
		</next:Column>
		<next:Column header='<%=res.get("ITEM_NOTE")%>' width="200" field="note">
				<next:TextField allowBlank="true"/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="dictItemDs"></next:PagingToolBar>
	</next:BottomBar>
</next:EditGridPanel>
</next:ViewPort>
</body>
</html>
