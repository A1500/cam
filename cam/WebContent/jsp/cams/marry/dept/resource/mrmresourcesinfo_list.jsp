
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>资源信息表列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="mrmresourcesinfo_list.js"></script>
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
			var deptId ="";
			var deptName ="";
			var flg=true;
		</script>
	</head>
<body>
<model:datasets>
	<!--	资源	-->
	<model:dataset id="resourceNameDs"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HY_RESOURCE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!--	区域		-->
	<model:dataset id="areaNameDs"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HY_AREA'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmResourcesInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmResourcesInfo"></model:record>
	</model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html><center>
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
							<td class="FieldLabel" style="width:20%">资源名称:</td>
								<td class="FieldInput" style="width:30%">
								<select name="resourceName" field="resourceName" style="width:200">
									<option dataset="resourceNameDs"></option>
								</select></td>	
								<td class="FieldButton" style="width:50%"><button onclick="query()">查 询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="rest">重 置</button></td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</center></next:Html>
</next:Panel>

<next:EditGridPanel id="editGridPanel" name="mrmresourcesinfoGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="资源信息列表">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
	        <next:ToolBarItem  iconCls="add" text="增加" handler="insert"  />
			<next:ToolBarItem  iconCls="remove" text="删除" handler="del"  />
			<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
			<next:ToolBarItem iconCls="undo"  text="取消" handler="reset"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="50"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
	 
	
		<next:Column id="deptId" header="登记机关代码" field="deptId" width="90" hidden="true">
			<next:TextField />
		</next:Column>
		
		<next:Column id="deptName" header="登记机关" field="deptName" width="200"  hidden="true">
			<next:TextField />
		</next:Column>
	
		<next:Column id="resourceName" header="资源名称" field="resourceName" width="200" >
			<next:ComboBox dataset="resourceNameDs"></next:ComboBox>
		</next:Column>
	
		<next:Column id="resourceNum" header="数量" field="resourceNum" width="90" align="right">
			<next:NumberField allowBlank="false" />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>
