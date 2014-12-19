<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>

<html>
<head>
<title><%=res.get("LABLE_CANT")%></title>

<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
	var res = {};
	res.prompts = '<%=res.get("MSG.PROMOT")%>';
	res.nochange = '<%=res.get("MSG_NOCHANGE")%>';
	res.saveOK = '<%=res.get("MSG.SAVE")%>';
	res.askRemove = '<%=res.get("ASK.DELETE")%>';
	res.noselected = '<%=res.get("MSG_NOSELECTED")%>';
	res.removeOk = '<%=res.get("MSG.DELETE")%>';
	res.position = '<%=res.get("LABLE_POSITION")%>';
	res.onusing = '<%=res.get("MSG.ONUSING")%>';
	res.hasSubCant = '<%=res.get("MSG.HAS_SUBCANT")%>';
</script>
<script type="text/javascript" src="cant.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="cant_ds" pageSize="15" global="true"
		cmd="org.loushang.bsp.ext.location.cmd.CantQueryCmd">
		<model:record fromBean="org.loushang.bsp.ext.location.data.Cant" >
		</model:record>
	</model:dataset>
	<model:dataset id="country_ds" autoLoad="true" pageSize="-1" global="true"
		cmd="org.loushang.bsp.ext.location.cmd.CountryQueryCmd">
		<model:record
			fromBean="org.loushang.bsp.ext.location.data.Country">
		</model:record>
	</model:dataset>
	<model:dataset id="cant_type_ds" pageSize="-1" global="true"
		cmd="org.loushang.bsp.ext.location.cmd.CantTypeQueryCmd">
		<model:record fromBean="org.loushang.bsp.ext.location.data.CantType"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
			<next:Panel>
			<next:Panel>
				<next:Html>
					<div id="location_link" style="font:12px arial,tahoma, helvetica, sans-serif">
					<%=res.get("LABLE_POSITION")%>
					</div>
				</next:Html>
			</next:Panel>
			<next:EditGridPanel id="cant_panel" stripeRows="true"
				dataset="cant_ds"  width="100%" height="100%" >
				 <next:ExtendConfig>
						tbar:[
						{text: '<%=res.get("LABLE_COUNTRY")%>:',id: 'country_label' },
						{xtype: 'combo',triggerAction:'all',mode:'local', lazyInit:false, lazyRender:false,
							id: 'country',displayField:'countryName',valueField:'countryCode',
							dataset:country_ds,handler:reloadCant},
						{text: '<%=res.get("COL_CANT_NAME")%>:',id: 'query_name_label' },
                    	{xtype: 'textfield',id: 'cant_name',style:'width:90px;'},
                    	{iconCls:'query',text:'<%=res.get("LABLE_QUERY")%>',handler:query_name},
                    	{iconCls:'undo',text:'重置',handler:reset},
                    	'->',
						{iconCls:'add',text:'<%=res.get("LABLE_ADD")%>',handler:add_cant_info},
						{iconCls:'save',text:'<%=res.get("LABLE_SAVE")%>',handler:save_cant_info},
						{iconCls:'remove',text:'<%=res.get("LABLE_REMOVE")%>',handler:remove_cant_info},
						{iconCls:'undo',text:'<%=res.get("LABLE_RESET")%>',handler:reset_cant_info}
						]
				</next:ExtendConfig>
				<next:Columns>
				    <next:RowNumberColumn width="30"/>
					<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column header='<%=res.get("COL_CANT_CODE")%>' field="cantCode" width="20%"
					 editable="isNew">
						<next:TextField allowBlank="false"></next:TextField>
					</next:Column>
					<next:Column header='<%=res.get("COL_CANT_NAME")%>' field="cantName" width="30%"
					 renderer="addLink">
						<next:TextField allowBlank="false"></next:TextField>
					</next:Column>
					<next:Column header='<%=res.get("COL_CANT_SHORT_NAME")%>' field="shortName" width="30%">
						<next:TextField allowBlank="false"></next:TextField>
					</next:Column>
					<next:Column header='<%=res.get("COL_CANTYPE_CODE")%>' field="cantType" renderer="renderName"
					width="20%" editable="isNew">
						<next:TextField allowBlank="false"></next:TextField>
					</next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="cant_ds"></next:PagingToolBar>
				</next:BottomBar>
			</next:EditGridPanel>
		</next:Panel>
</next:ViewPort>
</body>
</html>