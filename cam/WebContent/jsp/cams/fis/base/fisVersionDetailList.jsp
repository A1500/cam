<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>单位版本明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fisVersionDetailList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="cemeVerDs" cmd="com.inspur.cams.fis.base.cmd.FisVersionDetailQueryCmd" pageSize="15" method="cemeVerDetail">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisVersionDetail"/>
	</model:dataset>
	
	<model:dataset id="organVerDs" cmd="com.inspur.cams.fis.base.cmd.FisVersionDetailQueryCmd" pageSize="15" method="organVerDetail">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisVersionDetail"/>
	</model:dataset>
</model:datasets>

<next:TabPanel id="tab" activeTab="0" width="100%"  height="100%">
	<next:Tabs>
		<next:Panel title="公墓版本明细" width="100%" height="100%">

			<next:GridPanel id="cemeVersion" name="cemeVersion" width="100%" height="100%" dataset="cemeVerDs"  notSelectFirstRow="true">

				<next:Columns>
					<next:RowNumberColumn width="30"/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column field="ORGAN_ID" header="单位编号" width="10%" sortable="false" />
					<next:Column field="ORGAN_NAME" header="单位名称" width="15%" sortable="false"/>
					<next:Column field="VERSION" header="当前版本号" width="10%" sortable="false"/>
					<next:Column field="CREATE_TIME" header="上报时间" width="13%" sortable="false" />
					</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar  dataset="cemeVerDs"/>
				</next:BottomBar>
			</next:GridPanel>
		</next:Panel>
		
		<next:Panel title="殡仪馆版本明细" width="100%" height="100%">
		
			<next:GridPanel id="organVersion"  name="organVersion" width="100%" height="100%" dataset="organVerDs" notSelectFirstRow="true">
				<next:Columns>
					<next:RowNumberColumn width="30"/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column field="ORGAN_ID" header="单位编号" width="10%" sortable="false" />
					<next:Column field="ORGAN_NAME" header="单位名称" width="15%" sortable="false"/>
					<next:Column field="VERSION" header="当前版本号" width="10%" sortable="false"/>
					<next:Column field="CREATE_TIME" header="上报时间" width="13%" sortable="false" />
					</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar  dataset="organVerDs"/>
				</next:BottomBar>
			</next:GridPanel>
		</next:Panel>
			
	</next:Tabs>
</next:TabPanel>
</body>
</html>