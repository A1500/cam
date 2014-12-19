
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>人员信息</title>
<next:ScriptManager />
<style type="text/css">
			.x-grid-record-red {background:red}
			.x-grid-record-blue {background:blue}
			.x-grid-record-green {background:green}
</style>
<script type="text/javascript">
		//当前登录单位OrganId
		var areaName = decodeURIComponent('<%= request.getParameter("areaName") %>');
		var feedbackTime ='<%=request.getParameter("feedbackTime")%>';
</script>
<script type="text/javascript" src="commPeopleInfoDetail.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="peopleInfoDs" cmd="com.inspur.cams.drel.info.cmd.D204a01QueryCmd" method="queryPeopleInfo" pageSize="200"   global="true">
		<model:record fromBean = "com.inspur.cams.drel.info.data.D204a01"></model:record>
	</model:dataset>
 <!-- 性别 -->
    <model:dataset id="sexDs" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
 <!-- 与主申请人关系 -->
  <model:dataset id="applicantRelationShipDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
			<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
			<model:params>
				<model:param name="dic" value='DM_YJTSQRGX'></model:param><!--字典表名-->
				<model:param name="value" value='CODE'></model:param><!--生成数据源的映射关系-->
				<model:param name="text" value='NAMES'></model:param><!--生成数据源的映射关系-->
			</model:params>
		</model:dataset>
		
		
		
</model:datasets>
<next:GridPanel clickToSelectedForChkSM="true" id="ensureCommissionGridPanel" dataset="peopleInfoDs"
	width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail"  text="明细" handler="detail"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		
	    <next:Column field="D204A010001" align="center" header="姓名" width="15%"  />
	    <next:Column field="D204A010002" align="center" header="性别" width="15%" dataset="sexDs"/>
		<next:Column field="D204A010005" align="center" header="身份证号" width="15%" />
		<next:Column field="FAMILY_NAME" align="center" header="户主姓名" width="15%" />
		<next:Column field="FAMILY_ID_CARD" align="center" header="户主身份证号" width="15%" />
		<next:Column field="D204A010023" align="center" header="与户主关系"   width="15%" dataset="applicantRelationShipDs"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="peopleInfoDs" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
