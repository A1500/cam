<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
</script>
<html>
	<head>
		<title>目录号查询</title>
		<next:ScriptManager/>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="contentNum_list.js"></script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
		<script type="text/javascript" src="../comm/bptComm.js"></script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js") %>"></script>
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
	<model:dataset id="dsProPrint"
		cmd="com.inspur.cams.bpt.manage.cmd.BptElectronicQueryCommand"
		method="queryElectronicPrintCover" global="true" pageSize="30">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptContentNumMaintain">
			<model:field name="CONTENT_NUM_NAME" type="string"/>
			<model:field name="BOX_HAVE" type="string"/>
			<model:field name="CONTENT_YEAR" type="string"/>
			<model:field name="ARCHIVAL_FONDS_NAME" type="string"/>
			<model:field name="PLAIT_DATE" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" autoHeight="true">
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
					<tr>		
						<td class="FieldLabel">目录号名称:</td>
						<td class="FieldInput"><input type="text"  id="contentNumName" class="TextEditor" title="目录号名称"/></td>			
						<td class="FieldLabel">档案柜名称:</td>
						<td class="FieldInput"><input type="text"  id="fileCabinetName" class="TextEditor" title="档案柜名称"/></td>			
						<td class="FieldLabel">年度:</td>
						<td class="FieldInput"><input type="text"  id="contentYear" class="TextEditor" title="年度"/></td>
						<td class="FieldLabel"><button id="queryButton" onclick="query()">查 询</button> </td>
					</tr>
					<tr>				
						<td class="FieldLabel">编制日期:</td>
						<td class="FieldInput"><input type="text"  id="plaitDate" class="TextEditor" title="编制日期"/></td>			
						<td class="FieldLabel">整理人:</td>
						<td class="FieldInput"><input type="text"  id="collator" class="TextEditor" title="整理人"/></td>			
						<td class="FieldLabel">检查人:</td>
						<td class="FieldInput"><input type="text"  id="examiner" class="TextEditor" title="检查人"/></td>	
						<td class="FieldLabel"><button onclick="reset()">重 置</button> </td>
					</tr>								
				</table>
				</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>	

<next:GridPanel id="gridPanel" name="bptcontentnummaintainGrid" clickToSelectedForChkSM="true" width="100%" stripeRows="true" height="100%" dataset="ContentNumMaintainDataset" >
	<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
	        <next:ToolBarItem symbol="-"></next:ToolBarItem>
			<next:ToolBarItem iconCls="detail" text="查看" handler="detail()"  />
			<next:ToolBarItem iconCls="detail" text="打印" handler="printFront" />
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	
		<next:Column id="contentNumName" header="目录号名称" field="contentNumName" width="95" >			
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
</next:GridPanel>
</body>
</html>
