
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>

<html>
	<head>
		<title>产品列表</title>
		<%
			String taskCode = (String)request.getParameter("taskCode");
		%>
		<next:ScriptManager/>
		<script type="text/javascript" src="wealProduct.js"></script>
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
			var taskCode='<%=taskCode%>';
		</script>
	</head>
<body>
<model:datasets>
	<!-- 生产能力信息 -->
	<model:dataset id="ds" cmd="com.inspur.cams.welfare.base.cmd.WealFitProductivepowerQueryCommand"  global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitProductivepower"></model:record>
	</model:dataset>
</model:datasets>


<next:EditGridPanel id="editGridPanel" name="wealworkerGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="产品列表">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
			<next:ToolBarItem  iconCls="add" text="增加" handler="insert"  />
			<next:ToolBarItem  iconCls="remove" text="删除" handler="del"  />
			<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
	</next:TopBar>
	    <next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="produceId" header="生产能力表ID" field="produceId" width="95" hidden="true" ></next:Column>
		<next:Column id="taskCode" header="业务编码" field="taskCode" width="95" hidden="true" ></next:Column>
	
		<next:Column id="productName" header="产品名称" field="productName" width="20%" >			
			<next:TextField  />
		</next:Column>
		<next:Column id="productNum" header="产品数量" field="productNum" width="20%" >			
			<<next:TextField />
		</next:Column>
	
		<next:Column id="productValue" header="产品产值（万元）" field="productValue" width="20%" >			
			<next:TextField />
		</next:Column>
			
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>
