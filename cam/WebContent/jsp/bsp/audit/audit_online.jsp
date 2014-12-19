<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>

<html>
	<head>
		<title>在线查询</title>
		<next:ScriptManager />
		<script type="text/javascript" src="audit_online.js"></script>
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
	<model:dataset id="onlineDataset" cmd="org.loushang.bsp.security.audit.online.cmd.OnlineQueryCommand" global="true" autoLoad="true" pageSize="15">
		<model:record fromBean="org.loushang.bsp.security.audit.online.data.Online">
		<model:field name="corpName" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>

<next:Panel  name="form" title="条件查询" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">	
	<next:Html>	
	<fieldset style="overflow: visible;" class="GroupBox">
		<legend class="GroupBoxTitle">查询条件
			<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)"/>
		</legend>
			<div>
				<form id="queryForm" class="L5form" >
					<table  width="70%">
						<tr >
							<td class="FieldLabel">用户帐号:</td>
							<td class="FieldInput"><input type="text"  id="userId" value=""/></td>
							<td class="FieldLabel">用户名称:</td>
							<td class="FieldInput"><input type="text"  id="userName" value=""/></td>
							<td class="FieldLabel"><button type="button" onclick="query()">查询</button> </td>
							<td class="FieldLabel"><button type="button" onclick="reset()">重置</button> </td>
						</tr>								
					</table>
				</form>
			</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="onlineUserPanel" name="OnlineGrid" width="100%" height="100%" dataset="onlineDataset" frame="true" notSelectFirstRow="true">
    <!—定义功能按钮组件-->
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="button"  text=''/>
	</next:TopBar>
    <!—定义列，其中field属性用来绑定数据集中对应的属性名，该名称与实体Bean中的域名称相同-->
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="acount" header='用户帐号' field="USER_ID" width="180" sortable="false">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="chname" header='用户名称' field="USER_NAME" width="180" sortable="false">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="corporationId" header='所属公司' field="CORP_NAME" width="180" sortable="false">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="loginTime" header='登录时间' field="LOGIN_TIME" width="200" sortable="false">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="logoutTime" header='离开时间' field="LOGOUT_TIME" width="150" hidden='true' sortable="false">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="remoteAddr" header="客户端" field="REMOTEADDR" width="180" sortable="false">
			<next:TextField allowBlank="false"/>
		</next:Column>
	</next:Columns>
	<!—定义翻页标签，其中dataset 属性用来绑定数据来源dataset -->
	<next:BottomBar>
		<next:PagingToolBar dataset="onlineDataset"/>
	</next:BottomBar>
 </next:GridPanel>
</body>
</html>

