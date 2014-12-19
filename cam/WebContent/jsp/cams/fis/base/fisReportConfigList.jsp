<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>单位版本明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fisReportConfigList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="funeralOrganDs" cmd="com.inspur.cams.fis.base.cmd.FisFuneralOrganManageQueryCmd" pageSize="15" sortField="unitId">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisFuneralOrganManage"/>
	</model:dataset>
	<model:dataset id="fisYesOrNo" enumName="COMM.YESORNO" autoLoad="true"
		global="true"></model:dataset>
</model:datasets>
		<next:Panel title="殡仪馆版本明细" width="100%" height="100%">
		<next:TopBar>
		    <next:ToolBarItem symbol="->" ></next:ToolBarItem>
			<next:ToolBarItem iconCls="save"  text="保存" handler="saveOrgan"/>
		</next:TopBar>
			<next:EditGridPanel id="organVersion"  name="organVersion" width="100%" height="100%" dataset="funeralOrganDs"  clicksToEdit="1" notSelectFirstRow="true">
				<next:Columns>
					<next:RowNumberColumn width="30"/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column field="unitId" header="单位编号" width="100" sortable="false" />
					<next:Column field="unitName" header="单位名称" width="200" sortable="false"/>
					<next:Column field="allowReport" header="是否可上报" width="100" sortable="false">
					   <next:ComboBox dataset="fisYesOrNo" typeAble="false"/>
					</next:Column>
					<next:Column field="reason" header="停报原因" width="700" sortable="false">
					   <next:TextField  allowBlank="false" />
					   </next:Column>
					</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar  dataset="funeralOrganDs"/>
				</next:BottomBar>
			</next:EditGridPanel>
		</next:Panel>
</body>
</html>