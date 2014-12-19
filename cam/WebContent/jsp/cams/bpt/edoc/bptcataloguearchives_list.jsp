<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>优抚信息列表</title>
<next:ScriptManager />
<script type="text/javascript" src="comm.js"></script>
<script type="text/javascript" src="bptcataloguearchives_list.js"></script>
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
			 var struId = '<%=BspUtil.getStruId()%>';
             var organCode = '<%=BspUtil.getOrganCode()%>';
             var organType='<%=BspUtil.getOrganType()%>';
</script>
</head>

<body>
<!-- 县民政局信息 -->
<model:datasets>
   <model:dataset id="dsOrgan" cmd="com.inspur.cams.bpt.manage.cmd.BptCatalogueArchivesQueryCommand" method="queryOrgan" global="true">
   </model:dataset>
</model:datasets>
<next:Panel name="form" width="100%" border="0" autoScroll="true"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox">
		<legend class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"onclick="collapse(this)"/></legend>
		<div>
		 <form style="width: 100%; height: 100%;" class="L5form">
		 <table border="1" width="100%">
			<tr>
				<td class="FieldLabel" nowrap>所属机构：</td>
				<td class="FieldInput">
				    <input type="hidden" id="domicileCode" class="TextEditor" title="属地行政区划"/>
				    <input type="text" id="domicileName" class="TextEditor" title="属地行政区划" onclick="help()" />
				</td>
				<td class="FieldInput" colspan="2">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button onclick="query()">查 询</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button onclick="reset()">重 置</button> 
			    </td>
			</tr>
		</table>
	   </form>
	  </div>
	 </fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" dataset="dsOrgan" name="baseinfopeopleGrid" width="100%" stripeRows="true" height="100%" notSelectFirstRow="true" title="档案制定机构">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem text="增加" iconCls="add" handler="add"/>
					<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
					<next:ToolBarItem text="查看" iconCls="detail" handler="detail"/>
				</next:TopBar>
				<next:Columns>
				    <next:RowNumberColumn header="序号" width="45"/>
				    <next:RadioBoxColumn></next:RadioBoxColumn>
				    		
					<next:Column id="ORGAN_CODE" header="" field="ORGAN_CODE" hidden="true">
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="ORGAN_NAME" header="档案机构" field="ORGAN_NAME" width="140">
						<next:TextField allowBlank="false" />
					</next:Column>
			    </next:Columns>
		<next:BottomBar>
					<next:PagingToolBar dataset="dsOrgan"/>
				</next:BottomBar>
</next:GridPanel>
</body>
</html>
