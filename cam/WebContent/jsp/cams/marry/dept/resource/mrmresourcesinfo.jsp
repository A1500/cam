
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>

<html>
	<head>
		<title>资源信息表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="mrmresourcesinfo.js"></script>
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
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmResourcesInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.dao.MrmResourcesInfo"></model:record>
	</model:dataset>
</model:datasets>
	

<next:EditGridPanel id="editGridPanel" name="mrmresourcesinfoGrid" width="100%" stripeRows="true" height="400" dataset="ds" title="资源信息表">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
			<next:ToolBarItem  iconCls="add" text="增加" handler="insert"  />
			<next:ToolBarItem  iconCls="remove" text="删除" handler="del"  />
			<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
			<next:ToolBarItem iconCls="undo"  text="取消" handler="reset"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="resourceId" header="资源ID" field="resourceId" width="95" >			
			<next:NumberField allowBlank="false" />
		</next:Column>
	
		<next:Column id="organId" header="登记机关ID" field="organId" width="95" >			
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="resourceName" header="资源名称" field="resourceName" width="95" >			
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="resourceNum" header="数量" field="resourceNum" width="95" >			
			<next:NumberField allowBlank="false" />
		</next:Column>
			
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>
