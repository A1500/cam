<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	String replyOrgancode = BspUtil.getCorpOrgan().getOrganCode();
	String replyOrganname = BspUtil.getCorpOrgan().getOrganName();
	String subject = java.net.URLDecoder.decode(request.getParameter("subject"), "UTF-8");
%>
<html>
<head>
<title><%=subject%></title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="pubPostReply.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var postId='<%=request.getParameter("postId")%>';
	var subject='<%= subject%>';
	var replyOrgancode='<%=replyOrgancode%>';
	var replyOrganname='<%=replyOrganname%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="pubPostReplyDataSet"
		cmd="com.inspur.cams.comm.bbs.cmd.PubPostReplyQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.comm.bbs.data.PubPostReply" />
	</model:dataset>
	<model:dataset id="replyDS"
		cmd="com.inspur.cams.comm.bbs.cmd.PubPostReplyQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.bbs.data.PubPostReply" />
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
	<next:Panel width="100%" height="70%" autoScroll="true">
		<next:TopBar>
			<next:ToolBarItem symbol="->" />
			<next:ToolBarItem iconCls="return" text="返回" handler="returnBack" />
		</next:TopBar>
		<next:Html>
			<form id="form0" method="post" onsubmit="return false" class="L5form">
			<fieldset>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 50%; text-align: left"><font
						color="red"><label id="subject"></label></font></td>
					<td class="FieldInput" style="width: 50%; text-align: right">
					<div id="filename"></div>
					</td>
				</tr>
			</table>
			</fieldset>
			</form>
			<form id="form1" method="post" onsubmit="return false" class="L5form">
			<fieldset><legend>回复</legend>
			<table width="100%" dataset="pubPostReplyDataSet">
				<tr repeat="true">
					<td>
					<table>
						<tr>
							<td class="FieldLabel" style="width: 15%" rowspan="2"><label
								field="replyOrganname" id="replyOrganname"></label></td>
							<td class="FieldLabel" style="text-align: left"><label
								field="replyTime" id="replyTime"></label></td>
							<td class="FieldInput"><label field="replyNum" id="replyNum"
								renderer="formatNum"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 100%" colspan="2"><textarea
								id="postContent" field="replyContent" name="replyContent"
								cols="240" rows="5" readonly="readonly">
					</textarea></td>
						</tr>
						<tr>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>
	<next:Panel title="回复帖子" collapsible="false">
		<next:Html>
			<form id="form_content" method="post" onsubmit="return false"
				class="L5form" dataset="replyDS">
			<table id="table1" border=1 width="100%">
				<tr>
					<td class="FieldLabel">回复内容：</td>
					<td><textarea id="postContent" field="replyContent"
						name="replyContent" rows="5" cols="92">
				  		 </textarea></td>
				</tr>
				<tr>
					<td class="FieldLabel"></td>
					<td>
					<button onclick="toReply()">提交</button>
					</td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
</next:Panel>
</body>
</html>