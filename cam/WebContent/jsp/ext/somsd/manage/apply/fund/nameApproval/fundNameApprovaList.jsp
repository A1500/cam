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
<title>基金会申请名称核准列表</title>
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
<script type="text/javascript" src="fundNameApprovaList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgOnline.js")%>'></script>
<script type="text/javascript">
	var morgArea='<%=organArea%>';
	var searchCnName='<%=searchCnName%>';
	var searchSorgCode='<%=searchSorgCode%>';
	var userId='<%=userId%>';
	var applyType='<%=ApplyType.SOM_FUND_NAME_APPROVAL%>';
</script>
</head>
<body>

<model:datasets>
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
			<next:ToolBarItem iconCls="print" text="打印" handler="printWord"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="新增" handler="forAccept"></next:ToolBarItem>
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
<next:Window id="winSorg" closeAction="hide" title="基金会类别" width="200"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="enter"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeWinSorg"></next:ToolBarItem>	
	</next:TopBar>
	<next:Html>
		<table width="100%">
			<tr>
				<td align="center"><label >请选择基金会类别：</label></td>
			</tr>
			<tr>
				<td align="center"><select id="sorgType">
					<option value="1">基金会主体</option>
					<option value="2">分支机构</option>
					<option value="3">代表机构</option>
				</select></td>
			</tr>
		</table>
	</next:Html>
</next:Window>
</body>
</html>