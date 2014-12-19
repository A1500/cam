
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>机关场所</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="mrmregisarea_list.js"></script>
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
			var flg1=true;
			var flg2=true;
		</script>
	</head>
<body>
<model:datasets>

<model:dataset id="stationDs" enumName="MRM.AREA.STATION" autoLoad="true" pageSize="-1" ></model:dataset>
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
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmRegisAreaQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmRegisArea">
			<model:field  name="jianNum" />
			<model:field  name="areaStation" />
		</model:record>
	</model:dataset>
	<model:dataset id="resourceDs" cmd="com.inspur.cams.marry.base.cmd.MrmResourcesInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmResourcesInfo"></model:record>
	</model:dataset>
</model:datasets>
<%--  
<next:Panel height="100%" width="100%"   autoHeight="true" autoScroll="true" >
	<next:TabPanel>
		<next:Tabs>
		--%>
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
								<td class="FieldLabel" style="width:20%">机关场所:</td>
								<td class="FieldInput" style="width:30%">
								<select name="functionName" field="functionName" style="width:200">
									<option dataset="areaNameDs"></option>
								</select></td>	
								<td class="FieldButton" style="width:50%"><button onclick="query()">查 询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="rest">重 置</button></td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</center></next:Html>
</next:Panel>
<next:EditGridPanel id="editGridPanel" name="mrmregisareaGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="机关场所信息列表"
 enableHdMenu="true" enableColumnHide="true"   hasSum="true">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
	      	<next:ToolBarItem  iconCls="add" text="增加" handler="insert"/>
			<next:ToolBarItem  iconCls="remove" text="删除" handler="del"/>
			<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
			<next:ToolBarItem iconCls="undo"  text="取消" handler="reset"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="50"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="deptId" header="" field="deptId" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
		
		<next:Column header="登记机关" field="deptName" width="120" hidden="true">
			<next:TextField></next:TextField>
		</next:Column>
		
		<next:Column header="机关场所" field="functionName" width="120" sortable="true" summaryType="count">
			<next:ExtendConfig>
				summaryRenderer : countRender
			</next:ExtendConfig>
			<next:ComboBox dataset="areaNameDs"></next:ComboBox>
		</next:Column>
		
		<next:Column header="面积(平方米)" field="functionArea" width="90" sortable="true" summaryType="sum" align="right">
			<next:ExtendConfig>
				summaryRenderer : arRender
			</next:ExtendConfig>
			<next:NumberField></next:NumberField>
		</next:Column>
		
		<next:Column header="窗口(个)" field="windowNum" width="90" sortable="true" summaryType="sum" align="right">
			<next:ExtendConfig>
				summaryRenderer : wiRender
			</next:ExtendConfig>
			<next:NumberField></next:NumberField>
		</next:Column>
		
		<next:Column header="座椅(个)" field="chairNum" width="90" sortable="true" summaryType="sum" align="right">
			<next:ExtendConfig>
				summaryRenderer : chRender
			</next:ExtendConfig>
			<next:NumberField></next:NumberField>
		</next:Column>
		
		<next:Column header="计算机(台)" field="computerNum" width="90" sortable="true" summaryType="sum" align="right">
			<next:ExtendConfig>
				summaryRenderer : coRender
			</next:ExtendConfig>
			<next:NumberField></next:NumberField>
		</next:Column>
		
		<next:Column header="打印机(台)" field="printerNum" width="90" sortable="true" summaryType="sum" align="right">
			<next:ExtendConfig>
				summaryRenderer : prRender
			</next:ExtendConfig>
			<next:NumberField></next:NumberField>
		</next:Column>
		
		<next:Column header="读卡器(个)" field="cardreaderNum" width="90" sortable="true" summaryType="sum" align="right">
			<next:ExtendConfig>
				summaryRenderer : caRender
			</next:ExtendConfig>
			<next:NumberField></next:NumberField>
		</next:Column>
		
		<next:Column header="间(个)数" field="jianNum" width="90" sortable="true"   align="right">
			<next:NumberField></next:NumberField>
		</next:Column>
		
		<next:Column header="所在位置" field="areaStation" width="90" sortable="true"   align="right">
			<next:ComboBox dataset="stationDs"></next:ComboBox>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>

<%-- 
<next:Panel height="100%" width="90%"   autoHeight="true" autoScroll="true" title="其他资源信息表">

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
							<td class="FieldLabel">资源名称:</td>
								<td class="FieldInput">
								<select name="resourceName" field="resourceName"  >
									<option dataset="resourceNameDs"></option>
								</select></td>	
								<td class="FieldLabel"><button onclick="query1()">查 询</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="editGridPanel1" name="mrmresourcesinfoGrid" width="100%" stripeRows="true" height="370" dataset="resourceDs" >
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
	        <next:ToolBarItem  iconCls="add" text="增加" handler="insert1"  />
			<next:ToolBarItem  iconCls="remove" text="删除" handler="del1"  />
			<next:ToolBarItem iconCls="save"  text="保存" handler="save1"/>
			<next:ToolBarItem iconCls="undo"  text="取消" handler="reset1"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="50"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="deptId" header="登记机关代码" field="deptId" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
		
		<next:Column id="deptName" header="登记机关" field="deptName" width="200" hidden="true">
			<next:TextField  />
		</next:Column>
		
		
		<next:Column id="resourceName" header="资源名称" field="resourceName" width="200" >
			<next:ComboBox dataset="resourceNameDs"></next:ComboBox>
		</next:Column>
	
		<next:Column id="resourceNum" header="数量" field="resourceNum" width="90" align="right">
			<next:NumberField allowBlank="false" />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="resourceDs"/>
	</next:BottomBar>
</next:EditGridPanel>
</next:Panel>
--%>
</body>
</html>
