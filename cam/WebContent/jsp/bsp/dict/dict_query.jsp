<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
	<title><%=res.get("DICT_TITLE")%></title>
	<next:ScriptManager></next:ScriptManager>
	<script type="text/javascript" src="dict_query.js"></script>
	<script language="javascript">
		var MSG_NOCHANGE='<%=res.get("MSG.NOCHANGE")%>';
		var ASK_DELETE='<%=res.get("ASK.DELETE")%>';
		var MSG_SEL_ONE_RECORD='<%=res.get("MSG.SEL_ONE_RECORD")%>';
		var MSG_SEL_DEL_RECORD='<%=res.get("MSG.SEL_DEL_RECORD")%>';
		var CAPTION_DICT_ITEM='<%=res.get("MSG.UNKOWN_CMD")%>';
	</script>
</head>
<body>
<model:datasets>
	<model:dataset id="dictDs" cmd="org.loushang.bsp.dict.DictQueryCommand" global="true" pageSize="20">
		<model:record fromBean="org.loushang.bsp.dict.Dict"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:EditGridPanel id="dictPanel" name="dictGrid" dataset="dictDs" stripeRows="true" width="100%" height="100%">
	<next:ExtendConfig>
						tbar:[
						{text: '<%=res.get("DICT_CODE")%>:',id: 'dictCode_label' },
						{xtype: 'textfield',id: 'dictCode_text',style:'width:90px;'},
						{text: '<%=res.get("DICT_NAME")%>:',id: 'dictName_label' },
						{xtype: 'textfield',id: 'dictName_text',style:'width:90px;'},
                    	{iconCls:'query',text:'<%=res.get("LABLE_QUERY")%>',handler:query_name},
                    	{iconCls:'undo',text:'重置',handler:reset},
                    	'->',
						{iconCls:'detail',text:'<%=res.get("BUT.ITEM")%>',handler:itemquery},
						{iconCls:'add',text:'<%=res.get("BUT.ADD")%>',handler:insert},
						{iconCls:'save',text:'<%=res.get("BUT.SAVE")%>',handler:save},
						{iconCls:'remove',text:'<%=res.get("BUT.REMOVE")%>',handler:del}
						]
		</next:ExtendConfig>

	<next:Columns>
		<next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column header='<%=res.get("DICT_CODE")%>' width="200" field="dictCode" >
			<next:TextField allowBlank="false" editable="disableEdit"/>
		</next:Column>
		<next:Column header='<%=res.get("DICT_NAME")%>' width="200" field="dictName">
					<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column header='<%=res.get("DICT_NOTE")%>' width="160" field="note">
					<next:TextField allowBlank="true"/>
		</next:Column>
		<next:Column header='<%=res.get("DICT_SETMAN")%>' width="150" field="setMan"/>
		<next:Column header='<%=res.get("DICT_SETTIME")%>' width="150" field="setTime"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="dictDs"></next:PagingToolBar>
	</next:BottomBar>
</next:EditGridPanel>
</next:ViewPort>
</body>
</html>
