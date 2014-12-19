<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>社会团体账户备案</title> 
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="groupAccount.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
	var sorgId='<%=request.getParameter("sorgId")%>';
	var cnName=decodeURIComponent('<%=request.getParameter("cnName")%>');
	var sorgCode='<%=request.getParameter("sorgCode")%>';
	var searchCnName=decodeURIComponent('<%=request.getParameter("searchCnName")%>');
	var searchSorgCode='<%=request.getParameter("searchSorgCode")%>';	
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somAccountDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomAccountQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAccount"/>
	</model:dataset>
</model:datasets>

<next:Panel width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<fieldset style="overflow:visible;">
		<legend>社会团体信息</legend>
		<form id="form2" onsubmit="return false" class="L5form">
			<input type="hidden" id="sorgId"/>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:17%">社团名称：</td>
					<td class="FieldInput" style="width:49%"><label id="cnName"/></td>
					<td class="FieldLabel" style="width:17%">登记证号：</td>
					<td class="FieldInput" style="width:17%"><label id="sorgCode"/></td>
				</tr>
			</table>
		</form>
		</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="somAccountDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="账户信息"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="备案" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
		<next:ToolBarItem iconCls="remove" text="删除" handler="del"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="查看" handler="detail"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column header="账户名称" id="name" field="name" resizable="true" width="15%"></next:Column>
		<next:Column header="开户银行账户" field="accountCode" resizable="true" width="20%"></next:Column>
		<next:Column header="开户银行" field="bank" resizable="true" width="15%"></next:Column>
		<next:Column header="开户时间" field="accountDate" width="15%"></next:Column>
		<next:Column header="备案人" field="regPeople" width="15%"></next:Column>
		<next:Column header="备案日期" field="regDate" width="10%"></next:Column>
		<next:Column header="账户ID" field="id" hidden="true"></next:Column>
		<next:Column header="业务编号" field="taskCode" hidden="true"></next:Column>		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="somAccountDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>