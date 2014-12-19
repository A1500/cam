
<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<%@page import="org.loushang.next.skin.SkinUtils"%><html>
<html>
<head>
<title><%=res.get("LABLE_WORKPLACE")%></title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
	var res = {};
	res.prompts = '<%=res.get("MSG.PROMOT")%>';
	res.nochange = '<%=res.get("MSG_NOCHANGE")%>';
	res.saveOK = '<%=res.get("MSG.SAVE")%>';
	res.askRemove = '<%=res.get("ASK.DELETE")%>';
	res.noselected = '<%=res.get("MSG_NOSELECTED")%>';
	res.removeOk = '<%=res.get("MSG.DELETE")%>';
	res.selectOne = '<%=res.get("MSG.SELECTONE")%>';

</script>
<script type="text/javascript" src="workplace.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="wp_ds" pageSize="10" global="true"
		cmd="org.loushang.bsp.ext.location.cmd.WorkplaceQueryCmd">
		<model:record fromBean="org.loushang.bsp.ext.location.data.Workplace">
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort id="cards">
			<next:CardLayout >

				<next:EditGridPanel id="wp_panel" stripeRows="true"
				dataset="wp_ds" height="100%" autoScroll="true" width="100%">
				<next:ExtendConfig>
						tbar:[
						{text: '<%=res.get("COL_WP_NAME")%>',id: 'query_name_label' },
                    	{xtype: 'textfield',id: 'wp_name',style:'width:90px;'},
                    	{iconCls:'query',text:'<%=res.get("LABLE_QUERY")%>',handler:query_name},
                    	{iconCls:'undo',text:'重置',handler:reset},
                    	'->',
						{iconCls:'add',text:'<%=res.get("LABLE_ADD")%>',handler:add_wp_info},
						{iconCls:'save',text:'<%=res.get("LABLE_SAVE")%>',handler:save_wp_info},
						{iconCls:'edit',text:'<%=res.get("LABLE_EDIT")%>',handler:edit_wp_info},
						{iconCls:'remove',text:'<%=res.get("LABLE_REMOVE")%>',handler:remove_wp_info},
						{iconCls:'undo',text:'<%=res.get("LABLE_RESET")%>',handler:reset_wp_info}
						]
				</next:ExtendConfig>
				<next:Columns>
				   <next:RowNumberColumn width="30"/>
					<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column header='<%=res.get("COL_WP_CODE")%>' field="workplaceCode" width="100">
						<next:TextField allowBlank="false"></next:TextField>
					</next:Column>
					<next:Column header='<%=res.get("COL_WP_NAME")%>' field="workplaceName" width="300">
						<next:TextField allowBlank="false"></next:TextField>
					</next:Column>
					<next:Column header='<%=res.get("COL_WP_SHORT_NAME")%>' field="shortName" width="300">
						<next:TextField allowBlank="false"></next:TextField>
					</next:Column>
					<next:Column header='<%=res.get("COL_CANT_NAME")%>' field="cantName" width="300">

					</next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="wp_ds"></next:PagingToolBar>
				</next:BottomBar>
			</next:EditGridPanel>
			<next:Panel height="100%"  width="100%" autoScroll="true">
				<next:ExtendConfig>
						tbar:[
                    	'->',
						{iconCls:'save',text:'保存',handler:save_wp_info_single},
						{iconCls:'undo',text:'<%=res.get("LABLE_RETURN")%>',handler:back2list}
						]
				</next:ExtendConfig>
			<next:Html>
					<form  class="L5form" dataset="wp_ds">
					<table border="1" width="100%">
						<tr>
							<td class="FieldLabel"><%=res.get("COL_WP_CODE") %></td>
							<td class="FieldInput">
							<input id="workplaceCode_id" type="text" size="60"
							field="workplaceCode" />
							<font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel"><%=res.get("COL_WP_NAME") %></td>
							<td class="FieldInput">
							<input id="workplaceName_id" type="text" size="60"
							 field="workplaceName" />
							<font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel"><%=res.get("COL_WP_SHORT_NAME") %></td>
							<td class="FieldInput">
							<input id="shortName_id" type="text" size="60" field="shortName" />
							</td>
						</tr>

						<tr>
							<td class="FieldLabel"><%=res.get("COL_CANT_NAME") %></td>
							<td class="FieldInput">
							<input id="cantName_id" type="text" size="60" field="cantName"  disabled="disabled"/>

							<img id="cant_code_img" style="cursor:hand"
							src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
							onclick="pop_cant(this)"></img>
							<font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel"><%=res.get("COL_WP_LINKMAN") %></td>
							<td class="FieldInput">
							<input id="linman_id" type="text" size="60" field="linkman" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel"><%=res.get("COL_WP_TEL") %></td>
							<td class="FieldInput">
							<input id="tel_id" type="text" size="60" field="tel" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel"><%=res.get("COL_WP_FAX") %></td>
							<td class="FieldInput">
							<input id="fax_id" type="text" size="60" field="fax" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel"><%=res.get("COL_WP_EMAIL") %></td>
							<td class="FieldInput">
							<input id="email_id" type="text" size="60" field="email" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel"><%=res.get("COL_WP_WWW") %></td>
							<td class="FieldInput">
							<input id="www_id" type="text" size="60" field="www" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel"><%=res.get("COL_WP_POST") %></td>
							<td class="FieldInput">
							<input id="postCode_id" type="text" size="60" field="postCode" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel"><%=res.get("COL_WP_ADDRESS") %></td>
							<td class="FieldInput">
							<input id="postAddress_id" type="text" size="60" field="postAddress" />
						</tr>
						<tr>
							<td class="FieldLabel"><%=res.get("COL_WP_ENG_ADDRESS") %></td>
							<td class="FieldInput">
							<input id="englishAddress_id" type="text" size="60" field="englishAddress" />
						</tr>
						<tr>
							<td class="FieldLabel"><%=res.get("COL_WP_AM_START") %></td>
							<td class="FieldInput">
							<input id="amStartTime_id" type="text" size="8"
							field="amStartTime"  format="H:i:s"/>
							<img  height="20" onclick="LoushangDatetime('amStartTime_id')"
							src="<%=SkinUtils.getImage(request,"default/shared/calendar.gif")%>"
							  ></img>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel"><%=res.get("COL_WP_AM_END") %></td>
							<td class="FieldInput">
							<input id="amEndTime_id" type="text" size="8" field="amEndTime"
							format="H:i:s"  />
						<img  src="<%=SkinUtils.getImage(request,"default/shared/calendar.gif")%>"
							 height="20" onclick="LoushangDatetime('amEndTime_id')" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel"><%=res.get("COL_WP_PM_START") %></td>
							<td class="FieldInput">
							<input id="pmStartTime_id" type="text" size="8" field="pmStartTime"
							format="H:i:s"/>
							<img  src="<%=SkinUtils.getImage(request,"default/shared/calendar.gif")%>"
							 height="20" onclick="LoushangDatetime('pmStartTime_id')" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel"><%=res.get("COL_WP_PM_END") %></td>
							<td class="FieldInput">
							<input id="pmEndTime_id" type="text" size="8" field="pmEndTime"
							format="H:i:s" />
							<img  src="<%=SkinUtils.getImage(request,"default/shared/calendar.gif")%>"
							 height="20" onclick="LoushangDatetime('pmEndTime_id')" />
							</td>
						</tr>
					</table>
					</form>
			</next:Html>
			</next:Panel>
			</next:CardLayout>

</next:ViewPort>
<next:Window id="cant_win" width="300" height="180" closeAction="hide">
	<next:Html>
		<iframe id="poped_cant_iframe" height="50" width="100" location="poped_cant.jsp"></iframe>
	</next:Html>

</next:Window>

</body>

</html>