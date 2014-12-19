
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>电子档案目录列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="wealelectronicfile_list.js"></script>
		<script language="javascript">
		 var organCode='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
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
	<model:dataset id="ds" cmd="com.inspur.cams.welfare.base.cmd.WealElectronicfileCatalogQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealElectronicfileCatalog"></model:record>
	</model:dataset>
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
								<td class="FieldLabel">电子档案目录名称:</td>
								<td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="经济性质"  /></td>	
								<td class="FieldButton"><button onclick="query()">查 询</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:EditGridPanel id="editGridPanel" name="wealdiceconomicnatureGrid" width="100%" stripeRows="true" height="477" dataset="ds" title="电子档案目录">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="取消" iconCls="add" handler="reset" />
		<next:ToolBarItem text="保存" iconCls="edit" handler="save"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="catalogSn" header="电子档案目录序号" field="catalogSn" width="120" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="catalogName" header="电子档案目录名称" field="catalogName" width="120" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="catalogNote" header="电子档案目录说明" field="catalogNote" width="120" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="ifValid" header="是否有效" field="ifValid" width="120" >
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>
