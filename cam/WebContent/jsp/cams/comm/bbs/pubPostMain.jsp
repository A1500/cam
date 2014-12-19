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
<script type="text/javascript" src="pubPostMain.js"></script>
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
<next:EditGridPanel id="grid" dataset="pubPostDataSet" width="100%"
	stripeRows="true" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="进入论坛" handler="inPost"></next:ToolBarItem>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="postId" header="帖子Id" sortable="false"
			hidden="true" />
		<next:Column field="subject" header="帖子标题" width="225"
			sortable="false" renderer="postDetailHref" />
		<next:Column field="postOrganname" header="发帖人" width="100"
			sortable="false" />
		<next:Column field="postTime" header="发帖时间" width="135"
			sortable="false" />
		<next:Column field="replyAmount" header="回复数量" width="70"
			sortable="false" />
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="pubPostDataSet" />
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>