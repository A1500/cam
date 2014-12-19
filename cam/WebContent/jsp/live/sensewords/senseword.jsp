
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>敏感词管理</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="senseword.js"></script>
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
	<model:dataset id="ds" cmd="org.loushang.live.sensewords.cmd.SenseWordQueryCmd" global="true" pageSize="20" >
		<model:record fromBean="org.loushang.live.sensewords.data.SenseWord">
		</model:record>
	</model:dataset>
	<model:dataset id="sensLevelDs" enumName="SENSWORD.SENSLEVEL" global="true"  autoLoad="true"></model:dataset>
	<model:dataset id="sensStatDs" enumName="SENSWORD.STAT" global="true" autoLoad="true"></model:dataset>
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
					<form  style="width: 95%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel">敏感词:</td>
								<td class="FieldInput"><input type="text"  id="sensWord" class="TextEditor" title="敏感词" /></td>	
								<td class="FieldLabel">敏感级别:</td>
								<td class="FieldInput"><select  id="sensLevel"  title="敏感级别" ><option dataset="sensLevelDs"></option></select></td>	
								<td class="FieldLabel">状态:</td>
								<td class="FieldInput"><select  id="querystat"  title="状态" ><option dataset="sensStatDs"></option></select></td>	
								<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="livesensewordGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="敏感词语列表" notSelectFirstRow="true" >
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insertshow" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="updateshow"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
	</next:TopBar>
	<next:Columns>
	   
       <next:RowNumberColumn header="列号"  />	 
          
	   <next:CheckBoxColumn >
	       	   </next:CheckBoxColumn>
	     
	
		
		<next:Column id="sensWord" header="敏感词" field="sensWord" width="50%" align="left"  >
			<next:TextField/>
		</next:Column>
	
	
		<next:Column id="sensLevel" header="敏感级别" field="sensLevel" width="20%" align="center" >
			<next:ComboBox dataset="sensLevelDs" triggerAction="all" displayField="text" 
			  valueField="value" lazyRender="true" />
		</next:Column>
	
		<next:Column id="columnStat" header="状态" field="stat" width="20%" align="center" >
			<next:ComboBox dataset="sensStatDs" triggerAction="all" displayField="text" 
			  valueField="value" lazyRender="true" />
		</next:Column>
		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>


<next:Window id="addwindow" name="addwindow" width="260" height="150" title="增加敏感词" closeAction="hide" autoHeight="" autoWidth="" >
	<next:Html>
	<form  name="addform"style="width: 100%; height: 100%;" >
	<table border=0>
		<tr><td><span style="" >敏感词</span></td>
			<td ><input type="text" id="sensewordinput" name="sensewordinput" style="width:140" onkeydown="insertEnter()" ></input></td>
			<td><div id="worddiv1" name="worddiv1" style="display: none"><span style="color:red" >必填项</span></div></td>
		</tr>
		<tr>
			<td><span  style="" >敏感级别</span></td>
			<td ><select id="levelselect" style="width:140" onkeydown="insertEnter()"><option dataset="sensLevelDs"></option></select></td>
			<td><div id="leveldiv1" name="leveldiv1" style="display: none"><span style="color:red" >必填项</span></div></td>
		</tr>
		<tr>
			<td><span  style="" >状态</span></td>
			<td ><select id="statselect"  style="width:140" onkeydown="insertEnter()"><option dataset="sensStatDs"></option></select></td>
			<td><div id="statdiv1" name="statdiv1" style="display: none"><span style="color:red" >必填项</span></div></td>
		</tr>
		<tr>
		</tr>
		<tr>
			<td colspan=3><input type="button" value="继续添加" style="width='60'" onclick="insertagain()"></input>
			<input  type="button" value="保 存" align="middle" style="width='60'" onclick="insert()"></input>
			<input type="button" value="取消" align="right" style="width='60'" onclick="quxiao('addwindow')"></input></td>
		</tr>
	</table>
	</form>
	</next:Html>
</next:Window>


<next:Window id="updatewindow" name="updatewindow"width="260" height="150" title="修改敏感词" closeAction="hide" autoHeight="" autoWidth="" >
	<next:Html>
	<form  name="upateform"style="width: 100%; height: 100%;"  >
	<table border=0>
		<tr>
			<td><span style="" >敏感词</span></td>
			<td ><input type="text" id="senseword" name="sensewordupinput"  style="width:140" onkeydown="updateEnter()"></input></td>
			<td><div id="worddiv" name="worddiv" style="display: none"><span style="color:red" >必填项</span></div></td>
		</tr>
		<tr>
			<td><span style="" >敏感级别</span></td>
			<td><select id="level" style="width:140" onkeydown="updateEnter()"><option dataset="sensLevelDs" ></option></select></td>
			<td><div id="leveldiv" name="leveldiv" style="display: none"><span style="color:red" >必填项</span></div></td>
		</tr>
		<tr>
			<td><span  style="" >状态</span></td>
			<td><select id="stat"  style="width:140" onkeydown="updateEnter()"><option dataset="sensStatDs" ></option></select></td>
			<td><div id="statdiv" name="statdiv" style="display: none"><span style="color:red" >必填项</span></div></td>
		</tr>
		<tr>
		</tr>
		<tr>
			<td colspan="3"><input  type="button" value="修改" align="middle" style="width='60'" onclick="update()"></input>
			<input type="button" value="取消" align="right" style="width='60'" onclick="quxiao('updatewindow')"></input></td>
			
		</tr>
	</table>
	</form>
	</next:Html>
</next:Window>
</body>
</html>
