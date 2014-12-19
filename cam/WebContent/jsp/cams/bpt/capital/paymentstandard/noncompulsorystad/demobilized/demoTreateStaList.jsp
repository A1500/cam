<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
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
		<title>在乡复员军人优待金标准列表</title>
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
		<script type="text/javascript" src="demoTreateStaList.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptCapitalstaQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BptCapitalsta"></model:record>
	</model:dataset>
</model:datasets>
<next:EditGridPanel id="editGridPanel" name="bptcapitalstadisabilityGrid" width="100%" stripeRows="true" height="100%" dataset="ds">
	<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
	        <next:ToolBarItem  iconCls="add"    text="增加" id="insert" handler="insert"/>
	        <next:ToolBarItem  iconCls="edit"   text="修改" id="update" handler="update"/>
	        <next:ToolBarItem  iconCls="remove" text="删除" id="delete" handler="del"/>
			<next:ToolBarItem  iconCls="detail" text="查看" id="detail" handler="detail"/>
	</next:TopBar>
	<next:Columns>
	     <next:RowNumberColumn width="40" header="序号"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	    <next:Column id="STANDARDS_CODE" header="所属机构" field="STANDARDS_CODE" hidden="true">			
		</next:Column>
	    <next:Column id="STANDARDS_COUNTIES" header="所属机构" field="STANDARDS_COUNTIES" width="95">			
		</next:Column>
		<next:Column id="START_DATE" header="生效日期（起）" field="START_DATE" width="95">			
		</next:Column>
	    <next:Column id="END_DATE" header="生效日期（止）" field="END_DATE" width="95">			
		</next:Column>
	    <next:Column id="REG_ID" header="录入人" field="REG_ID" width="95" editable="false">			
		</next:Column>
	    <next:Column id="REG_TIME" header="录入时间" field="REG_TIME" width="95">			
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>
