<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>回执信息列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="informresponse.js"></script>
		<script>
			var informId='<%=request.getParameter("informId")	%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="responseDataset" cmd="com.inspur.cams.comm.inform.response.InformResponseQueryCommand" autoLoad="false">
		<model:record>
			<model:field name="id" type="string"/>
			<model:field name="receiveman" type="string"/>
			<model:field name="receivetime" type="date" dateFormat="Y-m-d H:i:s"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:GridPanel id="gridPanel"   notSelectFirstRow="true"   title="回执信息列表"  width="100%" height="400" dataset="responseDataset" frame="true" >
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:Column header="接收人" field="receiveman" width="250" >
			<next:TextField />
		</next:Column>
		<next:Column header="接收时间" field="receivetime" width="250" >
			<next:DateField />
		</next:Column>
	</next:Columns>
	<next:ExtendConfig>
					tbar:[
						{text: '接收人:'},
                    	{xtype: 'textfield',id: 'filter'},
						{iconCls:'common-query',text:'查询',handler:search},
						{iconCls:'undo',text:'返回',handler:click_back}

						]
				</next:ExtendConfig>
	<next:BottomBar>
		<next:PagingToolBar dataset="responseDataset"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>

