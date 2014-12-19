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
	
</script>
<script type="text/javascript" src="cant.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="cant_ds" pageSize="10" global="true"
		cmd="org.loushang.bsp.ext.location.cmd.CantQueryCmd">
		<model:record fromBean="org.loushang.bsp.ext.location.data.Cant">
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
					<div id="location_link">
					<%=res.get("LABLE_POSITION")%>
					</div>
				</next:Html>
			</next:Panel>
			<next:GridPanel id="cant_panel" stripeRows="true"
				dataset="cant_ds" height="100%">
				 <next:ExtendConfig>
						tbar:[
						{text: '<%=res.get("LABLE_COUNTRY")%>:',id: 'country_label' },
						{xtype: 'combo',triggerAction:'all',mode:'local', lazyInit:false, lazyRender:false,
							id: 'country',displayField:'countryName',valueField:'countryCode',
							dataset:country_ds,handler:reloadCant},
						{text: '<%=res.get("COL_CANT_NAME")%>:',id: 'query_name_label' },
                    	{xtype: 'textfield',id: 'cant_name',style:'width:90px;'},
                    	{iconCls:'query',text:'<%=res.get("LABLE_QUERY")%>',handler:query_name},
                    	'->',
                    	{iconCls:'save',text:'<%=res.get("LABLE_OK")%>',handler:chooseCant},
                    	{iconCls:'undo',text:'<%=res.get("LABLE_CANCEL")%>',handler:cancelChoose},
                    	{iconCls:'remove',text:'清除',handler:clearChoosed}
						]
				</next:ExtendConfig>
				<next:Columns>
					<next:NumberField></next:NumberField>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header='<%=res.get("COL_CANT_CODE")%>' field="cantCode" width="30%">
						
					</next:Column>
					<next:Column header='<%=res.get("COL_CANT_NAME")%>' field="cantName" width="69%"
					 renderer="addLink">
						
					</next:Column>
					
				
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="cant_ds"></next:PagingToolBar>
				</next:BottomBar>
			</next:GridPanel>
		</next:Panel>
</next:ViewPort>
</body>
<script type="text/javascript" src="poped_cant.js"></script>
</html>