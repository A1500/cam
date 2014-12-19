
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>

<html>
	<head>
		<title>医保系统连接配置列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="samMConConfigList.js"></script>
		<script language="javascript">
		    var organCode = '<%=BspUtil.getOrganCode()%>';
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
	<model:dataset id="ds" cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalConConfigQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalConConfig">
		</model:record>
	</model:dataset>
	<!-- 连接方式 -->
	<model:dataset id="conModDs" enumName="SAM.CON.MOD" autoLoad="true">	</model:dataset>
	<!-- 连接类型 -->
	<model:dataset id="conTypeDs" enumName="SAM.CON.TYPE" autoLoad="true">	</model:dataset>
</model:datasets>
<next:Panel width="100%">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 100%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel" width="20%">连接区域：</td>
				<td width="10%">
				<input type="text"  id="conAreaName" readonly="readonly"  onclick="forHelp()" />
				<input type="hidden" id="conArea" />
				</td>
				<td class="FieldLabel">连接类型:</td>
				<td class="FieldInput"><select name="连接类型" id="qconType">
					<option dataset="conTypeDs"></option>
				</select></td>
				<td class="FieldButton">
				<button onclick="query()">查 询</button>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">连接方式:</td>
				<td class="FieldInput"><select name="连接方式" id="qconMod" >
					<option dataset="conModDs"></option>
				</select></td>
				<td class="FieldLabel"></td>
				<td class="FieldInput"></td>
				<td class="FieldButton">
				<button type="reset">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="sammedicalconconfigGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="医保系统连接配置">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     <next:Column id="conArea" header="连接区域" field="conArea" hidden="true" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="conAreaName" header="连接区域" field="conAreaName"  width="20%" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="conType" header="连接类型" field="conType"  dataset="conTypeDs" width="10%" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="conMod" header="连接方式" field="conMod"  dataset="conModDs" width="10%" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="conPort" header="端口" field="conPort" width="10%" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="conUser" header="用户名" field="conUser" width="10%" >
			<next:TextField  />
		</next:Column>
	
	
		<next:Column id="conUrl" header="URL" field="conUrl" width="30%" >
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>

</html>
