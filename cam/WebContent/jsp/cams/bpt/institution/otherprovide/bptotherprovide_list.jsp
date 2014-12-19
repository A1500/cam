<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>其他供养情况列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="bptotherprovide_list.js"></script>
		<script type="text/javascript">
		var organCode ='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
		</script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.bptinstitution.cmd.BptOtherprovideQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.bptinstitution.data.BptOtherprovide"></model:record>
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
								<td class="FieldLabel" width="10%">年度:</td>
								<td class="FieldInput" width="15%"><input type="text"  id="years" class="TextEditor" title="年度" style="width:80%" /></td>	
								<td class="FieldLabel" width="10%">所属行政区划:</td>
								<td class="FieldInput" width="15%"><input type="text"  id="domicilename" class="TextEditor" title="所属行政区划" style="width:80%" onclick="func_ForDomicileSelect1()" readonly="readonly" />
								<input type="hidden"  id="domicileCode"  title="行政区划"  /></td>									
								<td class="FieldButton" width="10%"><button id="queryButton" onclick="query()">查询</button>&nbsp;&nbsp;<button type="reset">重置</button></td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="bptotherprovideGrid" width="100%" clickToSelectedForChkSM="true" stripeRows="true" height="100%" dataset="ds" title="其他供养情况列表">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
		<next:ToolBarItem iconCls="detail"  text="明细" handler="detail"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="id" header="ID" field="id" width="90" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="years" header="年度" field="years" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="area" header="单位名称" field="area" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="gloryroom" header="光荣间（间）" field="gloryroom" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="specialassistance" header="孤老优抚对象（人）" field="specialassistance" width="120" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="domicilename" header="所属行政区划" field="domicilename" width="200" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="domicilecode" header="所属行政区划CODE" field="domicilecode" width="10" hidden="true">
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
