<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>义务兵优待金标准列表</title>
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
			 var organCode = '<%=request.getParameter("organCode")%>';
			 var currentOrganCode = '<%=BspUtil.getOrganCode()%>';
		</script>
		<script type="text/javascript" src="../../common/comm.js"></script>
		<script type="text/javascript" src="compulsoryStaList.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptCapitalstaQueryCommand" global="true" method="queryCompulsory">
		<model:record fromBean="com.inspur.cams.bpt.capital.data.BptCapitalsta"></model:record>
	</model:dataset>
</model:datasets>
<next:EditGridPanel id="editGridPanel" name="bptcapitalstageneraGrid" width="100%" stripeRows="true" height="100%" dataset="ds">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
	        <next:ToolBarItem  iconCls="add"    text="增加" handler="insert" id="insert"/>
	        <next:ToolBarItem  iconCls="edit"   text="修改" handler="update" id="update"/>
	        <next:ToolBarItem  iconCls="remove" text="删除" handler="del"    id="delete"/>
	        <next:ToolBarItem  iconCls="detail" text="查看" handler="detail" id="detail"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="40" header="序号"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="STANDARDS_CODE" header="所属机构" field="STANDARDS_CODE" hidden="true">			
		</next:Column>
	    <next:Column id="STANDARDS_COUNTIES" header="所属机构" field="STANDARDS_COUNTIES" width="95">			
		</next:Column>
	
		<next:Column id="startDae" header="生效日期（起）" field="START_DATE" width="95" >			
			
		</next:Column>
	
		<next:Column id="endDate" header="生效日期(止)" field="END_DATE" width="95" >			
			
		</next:Column>
	
		<next:Column id="regId" header="录入ID" field="REG_ID" width="95" >			
			
		</next:Column>
	
		<next:Column id="regTime" header="录入时间" field="REG_TIME" width="95" >			
			
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>
