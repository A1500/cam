<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	String postOrgancode = BspUtil.getCorpOrgan().getOrganCode();
	String postOrganname = BspUtil.getCorpOrgan().getOrganName();
%>
<html>
<head>
<title>论坛首页</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="pubPostList.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var postOrgancode='<%=postOrgancode%>';
	var postOrganname='<%=postOrganname%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="pubPostDataSet"
		cmd="com.inspur.cams.comm.bbs.cmd.PubPostQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.comm.bbs.data.PubPost" />
	</model:dataset>
	<model:dataset id="postDS"
		cmd="com.inspur.cams.comm.bbs.cmd.PubPostQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.bbs.data.PubPost" />
	</model:dataset>
</model:datasets>
<next:Panel width="99%" border="0">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
		<table border="1" width="99%">
			<tr>
				<td class="FieldLabel" nowrap="nowrap" width="10%">帖子标题：</td>
				<td class="FieldInput"><input type="text" id="subjectquery"
					name="subjectquery" class="TextEditor" title="帖子标题"
					style="width: 75%" /></td>
				<td class="FieldButton" style="width: 20%">
				<button onclick="query()">查询</button>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="reset">重置</button>
				</td>
			</tr>
		</table>
		</form>
		</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="pubPostDataSet" width="99%"
	stripeRows="true" height="60%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<%
			if ("0000000000".equals(postOrgancode.substring(2, 12))) {
		%>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="置顶" handler="toTop"></next:ToolBarItem>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="取消置顶" handler="toNotTop"></next:ToolBarItem>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<%
			}
		%>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="postId" header="帖子Id" width="30%" sortable="false"
			hidden="true" />
		<next:Column field="subject" header="帖子标题" width="50%"
			sortable="false" renderer="postDetailHref" />
		<next:Column field="postOrganname" header="发帖人" width="10%"
			sortable="false" />
		<next:Column field="postTime" header="发帖时间" width="10%"
			sortable="false" />
		<next:Column field="replyAmount" header="回复数量" width="10%"
			sortable="false" />
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="pubPostDataSet" />
	</next:BottomBar>
</next:EditGridPanel>

<next:Panel title="发布新贴" width="99%" collapsible="false">
	<next:Html>
		<form id="form_content" method="post" onsubmit="return false"
			class="L5form" dataset="postDS">
		<table id="table1" border=1 width="100%">
			<tr>
				<td class="FieldLabel">标题：</td>
				<td><input type="text" field="subject" id="subject"
					maxlength="100" style="width: 300px"></td>
			</tr>
			<tr>
				<td class="FieldLabel">正文内容：</td>
				<td><textarea id="postContent" field="postContent"
					name="postContent" rows="5" cols="92">
				  		 </textarea></td>
			</tr>
			<tr>
				<td class="FieldLabel">附件</td>
				<td><input type="button" value="添加" onclick="add_row()"
					style="CURSOR: hand"> &nbsp;<span id="span"></span>
				<table id="table2">
				</table>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel"></td>
				<td>
				<button onclick="toSubmit()">提交</button>
				</td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>
</body>
</html>