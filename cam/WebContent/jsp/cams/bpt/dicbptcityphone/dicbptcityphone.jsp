
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>

<html>
	<head>
		<title>公示书所需电话字典</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="dicbptcityphone.js"></script>
		<script language="javascript">
		 	 //查询条件打开合并函数
		 	var getorganCode = '<%=BspUtil.getOrganCode()%>';
  			 var getorganName = '<%=BspUtil.getOrganName()%>';
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
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.DicBptCityPhoneQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.DicBptCityPhone"></model:record>
	</model:dataset>

		<model:dataset id="serviceTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_SERVICE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
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
						<!-- <td class="FieldLabel">县市区编码:</td>
						<td class="FieldInput"><input type="text"  id="organCode" class="TextEditor" title="县市区编码"  /></td>		
						-->	
						<td class="FieldLabel">县市区名称:</td>
						<td class="FieldInput"><input type="text"  id="organName" class="TextEditor" title="属地行政区划"/>
							 <input type="hidden"  id="organName" class="TextEditor" title="属地行政区划"  /></td>	
						
						<!--<input type="text"  id="organName" class="TextEditor" title="县市区名称"  /></td>		
						<td class="FieldLabel">业务类型:</td>
						<td class="FieldInput"><input type="text"  id="serviceType" class="TextEditor" title="业务类型"  /></td>			
						-->
						<td class="FieldLabel">电话:</td>
						<td class="FieldInput"><input type="text"  id="phone" class="TextEditor" title="电话"  /></td>	
						<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
					</tr>								
				</table>
				</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>	

<next:EditGridPanel id="editGridPanel" name="dicbptcityphoneGrid" width="100%" stripeRows="true" height="400" dataset="ds" title="公示书所需电话字典">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
			<next:ToolBarItem  iconCls="add" text="增加" handler="insert"  />
			<next:ToolBarItem  iconCls="remove" text="删除" handler="del"  />
			<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
			<next:ToolBarItem iconCls="undo"  text="取消" handler="reset"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="id" header="ID" field="id" width="95" hidden="true" >			
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="organCode" header="县市区编码" field="organCode" width="95" hidden="true">			
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="organName" header="县市区名称" field="organName" width="140"  renderer="editDicDetails" >			
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="serviceType" header="业务类型" field="serviceType" width="170" hidden="true" >
			<next:ComboBox  dataset="serviceTypeDataset"  displayField="text" valueField="value"  id="serviceType"/>
		</next:Column>
		
		<next:Column id="phone" header="电话" field="phone" width="95" >			
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="address" header="民政局来信来访地址" field="address" width="300" >			
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>
						