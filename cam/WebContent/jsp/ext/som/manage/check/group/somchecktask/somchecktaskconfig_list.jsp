
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>年检任务配置列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="somchecktaskconfig_list.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.check.checktask.cmd.SomCheckTaskQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checktask.data.SomCheckTask"></model:record>
	</model:dataset>
	<model:dataset id="sorgTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
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
								<td class="FieldLabel">任务名称:</td>
								<td class="FieldInput"><input type="text"  id="taskName" class="TextEditor" title="任务名称"  /></td>	
								<td class="FieldLabel">批次:</td>
								<td class="FieldInput"><input type="text"  id="batch" class="TextEditor" title="批次"  /></td>	
								<td class="FieldLabel">批次年份:</td>
								<td class="FieldInput"><input type="text"  id="batchYear" class="TextEditor" title="批次年份"  /></td>	
								<td class="FieldLabel">是否有效:</td>
								<td class="FieldInput"><select id="ifValid"
									field="ifValid" name='是否有效'>
									<option dataset="comm_yesorno"></option>
								</select></td>	
								<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="somchecktaskGrid" width="100%" stripeRows="true" height="400" dataset="ds" title="年检任务配置" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="sorgType" header="社会组织类型" field="sorgType" width="90" >
			<next:ComboBox dataset="sorgTypeSelect"/>
		</next:Column>
	
		<next:Column id="taskName" header="任务名称" field="taskName" width="250" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="batch" header="批次" field="batch" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="batchYear" header="批次年份" field="batchYear" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="validDate" header="有效期至" field="validDate" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="ifValid" header="是否有效" field="ifValid" width="90" >
			<next:ComboBox dataset="comm_yesorno"/>
		</next:Column>
	
		<next:Column id="addDate" header="添加日期" field="addDate" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="addPersonn" header="添加人名称" field="addPersonn" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="addOrgan" header="添加单位名称" field="addOrgan" width="150" >
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
