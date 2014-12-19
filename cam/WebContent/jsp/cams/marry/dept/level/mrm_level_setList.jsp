<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>等级评定标准</title>
<next:ScriptManager/>
<script type="text/javascript" src="mrm_level_setList.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmLevelEvalutionInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmLevelEvalutionInfo"></model:record>
	</model:dataset>
	<!-- 等级 -->
	<model:dataset id="EvaluLevelDataset" enumName="MRM.EVALULEVEL.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:GridPanel id="gridPanel" width="100%" stripeRows="true" height="100%" dataset="ds" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
	</next:TopBar>
	<next:Columns>	
		<next:RadioBoxColumn/>
		<next:Column header="等级" field="evaluLevel" width="200" renderer="renderEvaluLevel"/>	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
