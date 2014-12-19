
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>

<html>
	<head>
	<%
		String domicileCode = BspUtil.getCorpOrgan().getOrganCode();
	%>
		<title> 电子档案目录</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="wealElectronicFileCatalog.js"></script>
		<script language="javascript">
		var domicileCode='<%=domicileCode%>';
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
	<model:dataset id="ds" cmd="com.inspur.cams.welfare.base.cmd.WealElectronicfileCatalogQueryCommand" global="true" pageSize="20"  sortField="CATALOG_TYPE,CATALOG_SN"  autoLoad="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealElectronicfileCatalog">
			<model:field name="catalogSn" type="string" rule="require" />
			<model:field name="catalogName" type="string" rule="require" />
			<model:field name="catalogType" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 是否-->
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 电子档案目录类别 -->
	<model:dataset id="catalog_type" enumName="WEAL.CATALOG_TYPE" autoLoad="true" global="true"></model:dataset>
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
						<td class="FieldLabel">电子档案目录序号:</td>
						<td class="FieldInput"><input type="text"  id="catalogSn" class="TextEditor" title="电子档案目录序号"  /></td>			
						<td class="FieldLabel">电子档案目录名称:</td>
						<td class="FieldInput"><input type="text"  id="catalogName" class="TextEditor" title="电子档案目录名称"  /></td>
						<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
					</tr>
					<tr>
						<td class="FieldLabel">企业类别:</td>
						<td class="FieldInput"><select  id="companyType"  class="TextEditor" title="企业类型类型" >
							<option value="0">请选择......</option>
							<option value="1">假肢企业</option>
							<option value="2">福利企业</option>
						</select></td>	
						<td class="FieldLabel">电子档案目录类别:</td>
						<td class="FieldInput"><select  id="catalogType"  class="TextEditor" title="电子档案目录类型" >
							<option dataset="catalog_type"></option>
						</select></td>
						<td class="FieldLabel"><button onclick="reset()">重 置</button> </td>
					</tr>								
				</table>
				</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>	

<next:EditGridPanel id="editGridPanel" name="wealCatalogGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title=" 电子档案目录">
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
	     
		<next:Column id="catalogId" header="电子档案目录ID" field="catalogId" hidden="true" width="15%" >			
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="catalogSn" header="电子档案目录序号" field="catalogSn" width="15%" >			
			<next:TextField  />
		</next:Column>
		
		<next:Column id="catalogName" header="电子档案目录名称" field="catalogName" width="15%" >			
			<next:TextField  />
		</next:Column>
		
		<next:Column id="catalogType" header="电子档案目录类型" field="catalogType" width="15%" >			
			<next:ComboBox triggerAction="all"  valueField="value" displayField="text"  dataset="catalog_type"/>
		</next:Column>
		
		<next:Column id="catalogNote" header="电子档案目录说明" field="catalogNote" width="15%" >			
			<next:TextField  />
		</next:Column>
		
		<next:Column id="ifValid" header="是否有效" field="ifValid" width="15%" >			
			<next:ComboBox triggerAction="all"  valueField="value" displayField="text"  dataset="comm_yesorno"/>
		</next:Column>
			
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>
