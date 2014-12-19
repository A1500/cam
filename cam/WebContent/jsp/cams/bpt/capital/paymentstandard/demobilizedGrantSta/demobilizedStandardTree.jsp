<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager />
<script type="text/javascript">
	var organCode = '370000000000';
	var organName = '山东省';
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>在乡复员军人定期定量补助标准树列表</title>
<script type="text/javascript" src="demobilizedStandardTree.js"></script>
<model:datasets>
	<model:dataset id="dicCity_detaildataset" global="true">
		<model:record fromBean="com.inspur.cams.comm.diccity.data.DicCity"></model:record>
	</model:dataset>
</model:datasets>
</head>
<body>

<next:ViewPort>
	<next:BorderLayout>
		<next:Left split="true" cmargins="5 0 0 0" margins="5 0 0 0">
			<next:Panel title="行政区划" collapsible="true" autoScroll="true"
				width="20%" anchor="100% 100%">
				<next:Html>
					<next:Tree name="dicCitytree" id="dicCitytree" collapsible="true"
						rootExpanded="true" autoScroll="true" height="100%" lines="true">
						<next:TreeDataSet dataset="dicCityDataSet" root="rootdata">
							<next:TreeLoader
								cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand"
								method="queryCityCounty">
								<next:treeRecord name="dicCityRecord" idField="id">
									<model:field name="id" type="string" />
									<model:field name="name" type="string" />
									<model:field name="leve" type="string" />
									<model:field name="ups" type="string" />
									<model:field name="flag" type="string" />
								</next:treeRecord>
								<next:TreeBaseparam name="UPS@=" value="getParent" />
							</next:TreeLoader>
						</next:TreeDataSet>
						<next:TreeNodemodel recordType="dicCityRecord">
							<next:TreeNodeAttribute name="id" mapping="id"></next:TreeNodeAttribute>
							<next:TreeNodeAttribute name="leve" mapping="leve"></next:TreeNodeAttribute>
							<next:TreeNodeAttribute name="text" mapping="name"></next:TreeNodeAttribute>
							<next:TreeNodeAttribute name="icon" handler="getIcon"></next:TreeNodeAttribute>
							<next:Listeners>
								<next:Listener eventName="selected" handler="selectedNode"></next:Listener>
							</next:Listeners>
						</next:TreeNodemodel>
					</next:Tree>
				</next:Html>
			</next:Panel>
		</next:Left>
		<next:Center floatable="true">
			<next:Panel>
				<next:Html>
					<iframe id="nodeFrame" name="nodeFrame" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
</html>
