<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>通知查看情况</title>
<next:ScriptManager />
<script type="text/javascript">
	var noticeId='<%=request.getParameter("noticeId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="cdcNoticeCheckDataset" cmd="com.inspur.cams.cdc.base.cmd.CdcNoticeCheckQueryCommand">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcNoticeCheck" />
	</model:dataset>
	
</model:datasets>
<next:GridPanel id="editGridPanel" name="editGridPanel" width="100%" stripeRows="true" height="98%" autoScroll="true"  
				dataset="cdcNoticeCheckDataset" title="通知通告查看情况" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
	</next:TopBar>
			
	<next:Columns>
		<next:RowNumberColumn header="序号" width="40"/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
				    		
		<next:Column id="organName" header="查看单位名称" field="organName" width="100"  >
			<next:TextField allowBlank="false" />
		</next:Column>
			
		<next:Column id="createTime" header="查看时间" field="createTime" width="100"  >
			<next:TextField allowBlank="false" />
		</next:Column>
		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar  dataset="cdcNoticeCheckDataset"/>
	</next:BottomBar>
</next:GridPanel>
<script>
	function init() {
		var cdcNoticeCheckDataset=L5.DatasetMgr.lookup("cdcNoticeCheckDataset");
		cdcNoticeCheckDataset.setParameter("NOTICE_ID@=",noticeId);
		cdcNoticeCheckDataset.load();
		L5.QuickTips.init();
	}
	function returnBack(){
		history.go(-1);
	}
</script>
</body>
</html>
