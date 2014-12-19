<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<html>
<head>
<title>查看当前区划信息</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
	<%
	String organCode=BspUtil.getCorpOrgan().getOrganCode();
	String organName=BspUtil.getCorpOrgan().getOrganName();
	String userName=GetBspInfo.getBspInfo().getUserName();
	String areaCode=BspUtil.getCorpOrgan().getOrganCode();
	if(areaCode.endsWith("0000000000")){//省370000000000
		areaCode= areaCode.substring(0,2);
	} else if (areaCode.endsWith("00000000")){//市370100000000
		areaCode=  areaCode.substring(0,4);
	} else if (areaCode.endsWith("000000")){//县370104000000
		areaCode=  areaCode.substring(0,6);
	} else if (areaCode.endsWith("000")){//乡370104003000
		areaCode=  areaCode.substring(0,9);
	}
	%>
</script>
<script type="text/javascript">
	var organCode='<%=organCode%>';
	var userName='<%=userName%>';
	var organName='<%=organName%>';
	var areaCode='<%=areaCode%>';
	var radioType = "radiobox";// 按钮类型（默认为单选按钮）
</script>
<script type="text/javascript" src="dicCityView.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<!-- 区划代码 -->
	<model:dataset id="dicCityExportDataSet" cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.comm.diccity.data.DicCity"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:BorderLayout>
	<next:Left split="true" cmargins="5 0 0 0" margins="5 0 0 0">
		<next:Panel collapsible="true" autoScroll="true" width="100%" anchor="100% 100%">
			<next:Html>
				<next:Tree name="dicCitytree" id="dicCitytree" collapsible="true" rootExpanded="true" autoScroll="true" height="100%" lines="true">
				<next:TreeDataSet dataset="dicCityDataSet" root="rootdata">
					<next:TreeLoader cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand">
						<next:treeRecord name="dicCityRecord" idField="id">
		   					<model:field name="id" type="string"/>	
		   					<model:field name="name" type="string"/>	
		   					<model:field name="leve" type="string"/>	
		   					<model:field name="ups" type="string"/>
		   					<model:field name="fullName" type="string"/>		
		   					<model:field name="flag" type="string"/>	
						</next:treeRecord>
						<next:TreeBaseparam name="UPS@=" value="getParent"/>
					</next:TreeLoader>
				</next:TreeDataSet>
				<next:TreeNodemodel recordType="dicCityRecord">
					<next:TreeNodeAttribute name="text"  handler="getUserInfo"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="disabled" handler="getDicCitydisabled"></next:TreeNodeAttribute>
					<next:TreeNodeAttribute name="icon" handler="getIcon" ></next:TreeNodeAttribute>
	   				<next:RightmouseMenu menuId="cityMenu">
						<next:MenuItem text="导出成Excel" handler="exportExcel"></next:MenuItem>
					</next:RightmouseMenu>
				</next:TreeNodemodel>
			</next:Tree>
			</next:Html>
		</next:Panel>
	</next:Left>
	<next:Center floatable="true">
		<next:Panel width="98%" autoScroll="true">
		</next:Panel>
	</next:Center>
</next:BorderLayout>
</next:ViewPort>
</body>
</html>