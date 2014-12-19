<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<head>
<next:ScriptManager />
<title></title>
<%
String areaCode=BspUtil.getOrganCode();
if(areaCode.endsWith("0000000000")){//省370000000000
	areaCode= areaCode.substring(0,2);
} else if (areaCode.endsWith("00000000")){//市370100000000
	areaCode=  areaCode.substring(0,4);
} else if (areaCode.endsWith("000000")){//县370104000000
	areaCode= areaCode.substring(0,6);
} else if (areaCode.endsWith("000")){//乡370104003000
	areaCode=  areaCode.substring(0,9);
}
%>
<script type="text/javascript">

	codeLength='<%=areaCode.length()%>';
</script>
<script type="text/javascript" src="suspectDrelReport.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="suspectds" cmd="com.inspur.cams.drel.ensureInfo.cmd.EnsureToClientQueryCmd" method="querySuspectInfo" global="true" >
	</model:dataset>
	<model:dataset id="applyTypeDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"  autoLoad="true">
			<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
			<model:params>
				<model:param name="dic" value='DIC_SAM_APPLY_TYPE'></model:param>
				<model:param name="value" value='CODE'></model:param>
				<model:param name="text" value='NAME'></model:param>
			</model:params>
	</model:dataset>
</model:datasets>
<next:GridPanel id="countryGrid" clickToSelectedForChkSM="true" stripeRows="true" notSelectFirstRow="true" dataset="suspectds" title="疑似信息"
	width="100%" height="50%"  >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail"  text="明细" handler="detail"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:Column field="FEEDBACK_TIME" header="反馈时间"  width="15%" sortable="false"/>
		<next:Column field="APPLY_TYPE" header="救助类别" width="15%" dataset="applyTypeDs" align="center"/>
		<next:Column field="FAMILY_NAME" header="户主姓名" width="15%" align="center"/>
		<next:Column field="FAMILY_ID_CARD" header="户主身份证号" width="15%" align="center"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="suspectds" />
	</next:BottomBar>
</next:GridPanel>
<next:GridPanel id="cityGrid" clickToSelectedForChkSM="true" stripeRows="true" notSelectFirstRow="true" dataset="suspectds" title="疑似信息"
	width="100%" height="50%"  >
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:Column field="FEEDBACK_TIME" header="反馈时间"  width="15%" sortable="false"/>
		<next:Column field="NAME" header="单位名称" width="15%" align="center"/>
		<next:Column field="APPLY_TYPE" header="救助类别" width="15%" dataset="applyTypeDs" align="center"/>
		<next:Column field="USE_NUM" header="已使用" width="15%" align="center"/>
		<next:Column field="NOT_USE_NUM" header="未使用" width="15%" align="center"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="suspectds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
