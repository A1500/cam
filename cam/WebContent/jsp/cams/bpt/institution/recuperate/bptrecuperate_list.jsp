<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>轮养休养列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="bptrecuperate_list.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.bptrecuperate.cmd.BptRecuperateQueryCommand" method="query" global="true" pageSize="500">
		<model:record fromBean="com.inspur.cams.bpt.bptrecuperate.data.BptRecuperate"></model:record>
	</model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>" onclick="collapse(this)"/> </legend>
				<div>
					<form style="width: 95%; height: 100%;" class="L5form">
				<table border="1" width="100%">
					<tr>
						<td class="FieldLabel" width="10%">年度:</td>
						<td class="FieldInput" width="15%"><input type="text" id="year" class="TextEditor" title="年度" style="width:80%"/></td>	
						<td class="FieldLabel" width="10%">所属行政区划:</td>
						<td class="FieldInput" width="15%">
						<input type="text" id="domicileName" class="TextEditor" title="所属行政区划" style="width:80%" onclick="func_ForDomicileSelect1()" readonly="readonly"/>
						<input type="hidden" id="domicileCode" />
						</td>	
						<td class="FieldButton" width="10%"><button id="queryButton" onclick="query()">查询</button>&nbsp;&nbsp;<button type="reset">重置</button></td>
					</tr>
				</table>
				</form>
				</div>
	   </fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="bptrecuperateGrid" width="100%" clickToSelectedForChkSM="true" notSelectFirstRow="true"  stripeRows="true" height="100%" dataset="ds" title="轮养休养批次列表">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	    <next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="增加批次" iconCls="add" handler="insert" />
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="修改批次"  iconCls="edit" handler="update"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="删除批次"  iconCls="remove" handler="del"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="增加名单"  iconCls="view" handler="addList"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="修改名单"  iconCls="upload" handler="updateList"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="查看名单"  iconCls="detail" handler="detailList"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	     <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column header="ID" field="id" width="90" hidden="true" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column header="年度" field="year" width="100" >
			<next:TextField  />
		</next:Column>
		
		<next:Column header="批次" field="batchName" width="150" >
			<next:TextField  />
		</next:Column>
	
		<next:Column header="编制单位" field="domicileName" width="150" >
			<next:TextField  />
		</next:Column>
	
		<next:Column header="编制时间" field="createTime" width="80" >
			<next:TextField  />
		</next:Column>
	
		<next:Column header="人数" field="peopleCount" width="50" align="right" >
			<next:NumberField  />
		</next:Column>
		
		<next:Column header="开始时间" field="beginTime" width="90" >
			<next:TextField  />
		</next:Column>
		<next:Column header="结束时间" field="endTime" width="90" >
			<next:TextField  />
		</next:Column>
		<next:Column header="备注" field="note" width="90" >
			<next:TextField  />
		</next:Column>
	</next:Columns>
	</next:GridPanel>
</body>
</html>
