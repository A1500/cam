<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");  
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");  
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
	response.setHeader("Pragma", "no-cache");  
%>
<script type="text/javascript">
	var organCode = '<%=request.getParameter("organCode")%>' ;
	var currentOrganCode = '<%=BspUtil.getOrganCode()%>' ;
</script>
<html>
<head>
	<title>农村退役士兵补助标准列表</title>
	<next:ScriptManager/>
	<script language="javascript">
	 	 //查询条件打开合并函数
		 function collapse(element){
			var fieldsetParent=L5.get(element).findParent("fieldset");
			if(element.expand==null||element.expand==true){
				fieldsetParent.getElementsByTagName("div")[0].style.display="none";
				element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
				element.expand=false;
			}else{
				fieldsetParent.getElementsByTagName("div")[0].style.display="";
				element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
				element.expand =true;
			}
		}
	</script>
		<script type="text/javascript" src="../common/comm.js"></script>
		<script type="text/javascript" src="retiredStaList.js">
	</script>
</head>

<body>
<model:datasets>
	<model:dataset id="retStaDs" cmd="com.inspur.cams.bpt.manage.cmd.BptCapitalRetStaQueryCommand" sortField="START_DATE" sortDirection="DESC" global="true">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BptCapitalRetMarSta"></model:record>
	</model:dataset>
</model:datasets>

<next:GridPanel id="editGridPanel" name="bptcapitalretstaGrid" width="100%" stripeRows="true" height="100%" clickToSelectedForChkSM="true" dataset="retStaDs" title="农村退役士兵补助标准列表">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	    <next:ToolBarItem symbol="-" ></next:ToolBarItem>
	    <next:ToolBarItem  iconCls="add" text="增加" id="insert" handler="insert"/>
	    <next:ToolBarItem iconCls="edit" text="修改" id="update" handler="update"></next:ToolBarItem>
	    <next:ToolBarItem  iconCls="delete" text="删除" id="delete" handler="del"/>
		<next:ToolBarItem  iconCls="detail" text="查看" id="detail" handler="detail"/>
	</next:TopBar>

	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="startDate" header="生效日期起" field="startDate" align="center" width="95" >			
			<next:TextField/>
		</next:Column>
		<next:Column id="endDate" header="生效日期止" field="endDate" align="center" width="95" >			
			<next:TextField/>
		</next:Column>
		<next:Column id="regTime" header="录入时间" field="regTime" align="center" width="95" >			
			<next:TextField/>
		</next:Column>
	</next:Columns>
			
	<next:BottomBar>
		<next:PagingToolBar dataset="retStaDs"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
