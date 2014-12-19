<%@page import="com.inspur.cams.comm.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>火化率相关配置</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="fiscremationrateconfig.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
		<script type="text/javascript">
	    var organCode ='<%=BspUtil.getOrganCode()%>';
		var organName ='<%=BspUtil.getOrganName()%>';
		</script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.fis.cremationRate.cmd.FisCremationRateConfigQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.fis.cremationRate.data.FisCremationRateConfig"></model:record>
	</model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 95%; height: 100%;" class="L5form">
				<table  border="1" width="100%" >
					<tr >					
						<td class="FieldLabel">统计年度:</td>
						<td class="FieldInput"><input type="text"  id="sumYear" class="TextEditor" title="SUM_YEAR"  /></td>	
						<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
					</tr>								
				</table>
				</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>	

<next:EditGridPanel id="editGridPanel" name="fiscremationrateconfigGrid" width="100%" stripeRows="true" height="400" dataset="ds" title="火化率相关配置">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
			<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
			<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>     
		<next:Column id="name" header="名称" field="name" renderer="detailRender" width="95" >			
		</next:Column>	
		<next:Column id="sumYear" header="统计年度" field="sumYear" width="95" >			
		</next:Column>
		<next:Column id="totalNum" header="总人口数" field="totalNum" width="95" >			
			<next:NumberField  />
		</next:Column>	
		<next:Column id="deadRate" header="死亡率" field="deadRate" width="95" >			
			<next:NumberField  />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>
