
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>社会组织评估列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="somassess_list.js"></script>
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
			var organCode = '<%= BspUtil.getOrganCode().substring(0,6)%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.assess.assesstask.cmd.SomAssessTaskQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.assess.assesstask.data.SomAssessTask"></model:record>
		<model:params>
			<model:param name="IF_END" value='1'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="assessTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='som_assess_type'></model:param>
			<model:param name="value" value='TYPE'></model:param>
			<model:param name="text" value='TYPE_DESC'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 100%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel"style="width:20%">社会组织登记证号:</td>
								<td class="FieldInput"style="width:20%"><input type="text"  id="sorgCode" class="TextEditor" title="请输入社会组织登记证号"  style="width:80%"/></td>	
								<td class="FieldLabel"style="width:20%">社会组织类型:</td>
								<td class="FieldInput"style="width:20%">
								<select id="sorgType" field="sorgType" style="width:80%">
									<option dataset="sorgTypeSelect"></option>
								</select>
								</td>	
								<td class="FieldButton"style="width:20%"><button onclick="query()">查 询</button></td>
							</tr>
							<tr>
								<td class="FieldLabel">社会组织名称:</td>
								<td class="FieldInput"><input type="text"  id="sorgName" class="TextEditor" title="请输入社会组织名称"  style="width:80%"/></td>	
								<td class="FieldLabel">评估类型:</td>
								<td class="FieldInput">
								<select id="assessType" field="assessType" blank="false"style="width:80%">
									<option dataset="assessTypeSelect"></option>
								</select>
								</td>	
								<td class="FieldButton"><button type="reset">重 置</button></td>	
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="somassesstaskGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="社会组织评估列表">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="进行评估" iconCls="edit" handler="assess" />
		<next:ToolBarItem text="查看评估状态" iconCls="edit" handler="assessDetail" />
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
	     
		<next:Column id="taskId" header="任务编号" field="taskId" width="90"  hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="assessType" header="评估类型" field="assessType" width="200" >
			<next:TextField  /><next:ComboBox dataset="assessTypeSelect"/>
		</next:Column>
	
		<next:Column id="sorgCode" header="社会组织登记证号" field="sorgCode" width="200" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="sorgType" header="社会组织类型" field="sorgType" width="90" >
			<next:TextField  /><next:ComboBox dataset="sorgTypeSelect"/>
		</next:Column>
	
		<next:Column id="sorgName" header="社会组织名称" field="sorgName" width="200" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="organName" header="录入单位" field="organName" width="200" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="organAreaCode" header="录入单位区划" field="organAreaCode" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="startDate" header="启用时间" field="startDate" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="ifEnd" header="任务状态" field="ifEnd" width="90" >
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
