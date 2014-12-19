
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>

<html>
	<head>
		<title>设施设备信息</title>
		<%
			String taskCode = (String)request.getParameter("taskCode");
		%>
		<next:ScriptManager/>
		<script type="text/javascript" src="wealDevice.js"></script>
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
			var taskCode='<%=taskCode%>';
		</script>
	</head>
<body>
<model:datasets>
	<!-- 设施信息表 -->
	<model:dataset id="deviceDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitDeviceQueryCommand" global="true" >
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitDevice">
		<model:field name="deviceNum" type="string" rule="require" />
		</model:record>	
	</model:dataset>
	<!-- 设施信息表1 -->
	<model:dataset id="deviceDataSet1" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='WEAL_DIC_FITDEVICE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 设施信息表3 -->
	<model:dataset id="deviceDataSet2" cmd="com.inspur.cams.welfare.config.device.cmd.WealDicFitdeviceQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.welfare.config.device.dao.WealDicFitdevice"></model:record>
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
						<td class="FieldLabel">设施名称:</td>
						<td class="FieldInput"><input type="text"  id="deviceName" class="TextEditor" title="DEVICE_NAME"  /></td>			
						<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
					</tr>								
				</table>
				</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>	

<next:EditGridPanel id="editGridPanel" name="deviceGrid" width="100%" stripeRows="true" height="100%" dataset="deviceDataSet" title="设施信息列表">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
			<next:ToolBarItem  iconCls="add" text="增加" handler="insert"  />
			<next:ToolBarItem  iconCls="remove" text="删除" handler="del"  />
			<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
	</next:TopBar>
	    <next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="deviceCode" header="设施名称" field="deviceCode" width="15%" >			
			<next:ComboBox triggerAction="all" valueField="value" displayField="text"  id="name"  dataset="deviceDataSet1"/>
		</next:Column>
		<next:Column id="deviceNum" header="数量"  field="deviceNum" width="15%" >			
			<next:TextField />
		</next:Column>
	</next:Columns>
	
	<next:BottomBar>
		<next:PagingToolBar dataset="deviceDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>




