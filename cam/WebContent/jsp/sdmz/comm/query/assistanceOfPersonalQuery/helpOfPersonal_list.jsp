<%@ page contentType="text/html; charset=UTF-8" import="com.inspur.sdmz.comm.util.*"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%
	//String organArea = BspUtil.getCorpOrgan().getCorpOrganId();
	String organArea = BspUtil.getCorpOrgan().getOrganCode();
	
	
%>
<script language="javascript">
	var organArea = "<%=organArea%>";
</script>
<html>
	<head>
		<title>个人受助信息列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ygms/MultiSimpleGridHelp.js"></script>
		<script type="text/javascript" src="helpOfPersonal_list.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.sdmz.jzfa.cmd.DetailQueryCmd" global="true" autoLoad="false" pageSize="15">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Detail"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)" /> </legend>
		<div>
			<form style="width: 100%; height: 100%;" class="L5form">
				<table style="width:100%;table-layout:fixed;" >
					<tr>
						<td class="FieldLabel" nowrap="nowrap" width="12%">受助人/单位群体:</td>
						<td class="FieldInput" width="20%" >
							<input type="text" id="szdxmc">
						</td>	
						<td class="FieldLabel" nowrap="nowrap" width="10%">救助时间 从:</td>
						<td class="FieldInput"  width="38%"><input type="text" id="szrqStartQuery" format="Y-m-d" onclick="LoushangDate(this)"/>
						&nbsp;至:&nbsp;<input type="text" id="jzrqEdnQuery" format="Y-m-d" onclick="LoushangDate(this)"/>
						</td>
						
						<td  nowrap="nowrap" colspan="4" class="FieldInput" width="20%">
						<button onclick="query()">查 询</button>&nbsp;&nbsp;<button type="reset">重 置</button>
						
						</td>
					</tr>
					
				</table>
			</form>
		</div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" hasSum="true" name="szfamxGrid" width="100%" stripeRows="true" height="95%" dataset="ds" title="个人/单位救助信息">

<next:TopBar> 
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		
		<next:ToolBarItem text="导出excel" iconCls="add" handler="exportExcel"></next:ToolBarItem>
		
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="45"/>
		<next:Column id="jzfamxid" header="救助方案明细ID" field="detailId" hidden="true" align="center" width="10" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="szdxmc" header="受助人/单位" field="assistedName" width="100" align="center" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="lrdwmc" header="救助部门" field="regOrgName" width="90" align="center">
		<next:TextField  />
		</next:Column>
		<next:Column id="jzrq" header="救助日期" field="assitanceDate" width="80" align="center">
			<next:TextField  />
		</next:Column>
		
		<next:Column id="jzzjxjJe" header="救助资金金额" field="captial" width="90" align="center">
			<next:TextField  />
		</next:Column>
		<next:Column id="jzwpmc" header="救助物品" field="goodsName"  width="100" align="center">
			<next:TextField  />
		</next:Column>
		<next:Column id="jzwpsl" header="救助物品数量" field="goodsNum"  summaryType="sum"  width="90" align="center">
			<next:TextField  />
		</next:Column>
		<next:Column id="jzwpzjJe" header="折款" field="goodsNums"  summaryType="sum" width="90"  align="center">
			<next:TextField  />
		</next:Column>
		<next:Column id="jzzjhjJe" header="合计" field="totalFund"  summaryType="sum" width="90"  align="center">
			<next:TextField  />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"></next:PagingToolBar>
	</next:BottomBar>
</next:GridPanel>
</next:ViewPort>
</body>
</html>