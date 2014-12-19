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
   var organCode = '<%=BspUtil.getOrganCode()%>';
   var organName = '<%=BspUtil.getOrganName()%>';
</script>

<html>
	<head>
		<title>目录号信息维护</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="contentNumMaintain.js"></script>
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
	<!-- 目录号 -->
	<model:dataset id="ContentNumMaintainDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptContentNumMaintainQueryCommand" global="true" sortField="contentNumName">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptContentNumMaintain"></model:record>
	</model:dataset>
	<!-- 全宗号 -->
	<model:dataset id="ArchivalFondsDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptArchivalFondsNumberQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptArchivalFondsNumber"></model:record>
	</model:dataset>
</model:datasets>
<next:EditGridPanel id="editGridPanel" name="bptcontentnummaintainGrid" width="100%" stripeRows="true" height="100%" dataset="ContentNumMaintainDataset" title="目录号维护">
	<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
	        <next:ToolBarItem symbol="-"></next:ToolBarItem>
			<next:ToolBarItem iconCls="add" text="增加" handler="insert"  />
			<next:ToolBarItem iconCls="remove" text="删除" handler="del"  />
			<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
			<next:ToolBarItem iconCls="undo"  text="取消" handler="reset"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="contentNumName" header="目录号" field="contentNumName" width="95" >			
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="fileCabinetName" header="档案柜" field="fileCabinetName" width="95" >			
			<next:TextField  />
		</next:Column>
		<next:Column id="layerNum" header="层数" field="layerNum" width="95" >			
			<next:TextField  />
		</next:Column>
		<next:Column id="boxNum" header="盒" field="boxNum" width="95" >			
			<next:TextField  />
		</next:Column>
		<next:Column id="contentYear" header="年度" field="contentYear" width="95" >			
			<next:TextField  />
		</next:Column>
		<next:Column id="plaitDate" header="编制日期" field="plaitDate" width="95" >			
			<next:DateField format="Y-m-d"/>
		</next:Column>
		<next:Column id="note" header="情况说明" field="note" width="120" >			
			<next:TextField/>
		</next:Column>
		<next:Column id="conditionExplain" header="名称" field="conditionExplain" width="120" >			
			<next:TextField/>
		</next:Column>
		<next:Column id="collator" header="整理人" field="collator" width="95" >			
			<next:TextField  />
		</next:Column>
		<next:Column id="examiner" header="检查人" field="examiner" width="95" >			
			<next:TextField  />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ContentNumMaintainDataset"/>
	</next:BottomBar>
</next:EditGridPanel>

</body>
</html>
