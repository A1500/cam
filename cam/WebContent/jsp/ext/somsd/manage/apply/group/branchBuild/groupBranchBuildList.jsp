<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<%@ page import="com.inspur.cams.comm.extuser.data.ComExtUser"%>
<%@ page import="com.inspur.cams.sorg.online.extuser.util.SomExtBspInfo"%>
<html>
<head>
<title>社会团体注销登记列表</title>
<next:ScriptManager></next:ScriptManager>
<%	
	String searchCnName=(String)request.getParameter("searchCnName");
	if(searchCnName == null){
		searchCnName = "";
	}else{
		searchCnName = URLDecoder.decode((String)searchCnName, "UTF-8");
	}
	String searchSorgCode=request.getParameter("searchSorgCode");
	if(searchSorgCode == null){
		searchSorgCode = "";
	}
	ComExtUser comExtUser = (ComExtUser)SomExtBspInfo.getUserInfo(request).getComExtUser();
	String username = comExtUser.getUserName();
	String organArea = comExtUser.getAreaCode();//获取外部单位行政区划12位
	String organType = comExtUser.getOrganType();//获取外部单位的类型 ST:社团  MF:民非  JJ：基金会
	String userId = comExtUser.getUserId();
%>	
<script type="text/javascript" src="groupBranchBuildList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgOnline.js")%>'></script>
<script type="text/javascript">
	var morgArea='<%=organArea%>';
	var searchCnName='<%=searchCnName%>';
	var searchSorgCode='<%=searchSorgCode%>';
	var userId='<%=userId%>';
	var applyType='<%=ApplyType.SOM_GROUP_BRANCH_BUILD%>';
</script>
</head>
<body>

<model:datasets>
	<!-- 负责人信息 -->
	<model:dataset id="somDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 负责人录入窗口 -->
	<model:dataset id="somDutyInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty">
			<model:field name="idCard" type="string" rule="length{18}" />
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="aliasName" type="string" rule="length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
			<model:field name="sorgDuties" type="string" rule="require" />
			<model:field name="adds" type="string" rule="length{100}" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="postCode" type="string" rule="length{6}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{50}" />
			<model:field name="resume" type="string" rule="length{1000}" />
			<model:field name="workOpinion" type="string" rule="length{200}" />
			<model:field name="sorgOpinion" type="string" rule="length{200}" />
			<model:field name="promiseOrgan" type="string" rule="length{100}" />
			<model:field name="promiseCode" type="string" rule="length{100}" />
			<model:field name="otherDuties" type="string" rule="length{500}" />
			<model:field name="note" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"/>
	</model:dataset>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true"  sortField="CREATE_TIME" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply"></model:record>
	</model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="onlineStatusDataSet" enumName="SOM.ONLINE_STATUS" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:EditGridPanel id="grid" dataset="somApplyDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="print" text="打印" handler="printList"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="新增" handler="enter"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="查看" handler="detail"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="updateOnlineStatusDelW"></next:ToolBarItem>
		<next:ToolBarItem iconCls="upload" text="提交到民政相关部门" handler="updateOnlineStatus"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="taskCode" header="受理编号" width="15%" sortable="false"></next:Column>
		<next:Column field="sorgName" header="社会团体名称" width="15%" sortable="false"></next:Column>
		<next:Column field="onlineStatus" header="提交状态" width="15%" sortable="false"  dataset="onlineStatusDataSet"></next:Column>
		<next:Column field="acceptOpinion" header="退回原因" width="30%" sortable="false"></next:Column>
		<next:Column field="createPerson" header="创建人" width="15%" sortable="false"></next:Column>
		<next:Column field="createTime" header="创建时间" width="10%" sortable="false"></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="somApplyDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
<!-- 打印列表window -->
<next:Window id="printListWin" closeAction="hide" title="打印列表" width="800" height="350" autoScroll="true" modal="true">
	
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="print" text="打印" handler="printWord"></next:ToolBarItem>	
	</next:TopBar>
	<next:TabPanel  width="98%" height="84%">
		<next:Tabs>
			<next:Panel title="打印列表"  width="100%" height="100%" autoScroll="true">
				<next:Html>
					
						<table width="100%">
						<td class="FieldLabel" width="15%" rowspan="4">打印列表:</td>
						
					<td class="FieldInput" rowspan="4">
					<input type="radio"name="Word" 
						id="SQ" label="社团分支机构登记申请表" />社团分支机构成立登记表 <br />
					<input type="radio" name="Word"
						id="FZ" label="社团分支机构负责人备案表" />社团分支机构负责人备案表 <br />
					
					</td>
						
						</table>
					
				</next:Html>
			</next:Panel>
			</next:Tabs>
	</next:TabPanel>
</next:Window>
<!-- 打印负责人列表window -->
<next:Window id="printHeldWin" closeAction="hide" title="打印负责人" width="800" height="350" autoScroll="true" modal="true">
  <next:EditGridPanel id="heldGrid" dataset="somDutyInsertDataSet" width="95%" stripeRows="true" height="99.9%">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="print" text="打印" handler="printHeld"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="身份证号" field="idCard" width="20%" editable="false"><next:TextField/></next:Column>
					<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
					</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somDutyInsertDataSet" />
				</next:BottomBar>
			</next:EditGridPanel>
</next:Window>
</body>
</html>