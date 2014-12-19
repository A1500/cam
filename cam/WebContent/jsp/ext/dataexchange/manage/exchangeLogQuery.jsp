<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<html>
<head>
<title>日志查询</title>
<script type="text/javascript">
	var _dateTemp = (new Date()).valueOf();
</script>
<next:ScriptManager />
<script type="text/javascript" src="exchangeLogQuery.js"></script>
<script type="text/javascript" src="exCommon.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
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
	<!-- 数据类型 -->
	<model:dataset id="businessCategoryDataSet" enumName="DATA.BUSINESS_CATEGORY" autoLoad="true" global="true">
	</model:dataset>
	<!--	数据交互信息	-->
	<model:dataset id="ds"
		cmd="com.inspur.cams.dataexchange.log.DataExChangeLogQueryCmd" global="true"
		pageSize="10" sortField="queryDate" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.dataexchange.log.DataExChangeLog"></model:record>
	</model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form   class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel" style="width:20%">查询单位:</td>
				<td class="FieldInput" style="width:20%">
					<input type="text"   title="查询单位" id="unitNameID" style="width: 90%;"/>
				</td>
				<td class="FieldLabel"style="width:20%">数据类型:</td>
				<td class="FieldInput"style="width:20%">
					<select id="businessCategoryID" title="数据类型">
						<option dataset="businessCategoryDataSet"></option>
					</select>
				</td>
				<td class="FieldLabel"style="width:20%">
				<button onclick="query()">查 询</button>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">查询时间:</td>
				<td class="FieldInput" colspan="3">
					<input type="text" id="queryDate"  format="Y-m-d"  readonly="readonly" onclick="showQueryDate(this)"/>
				</td>
				<td class="FieldLabel">
				<button type="reset">重 置</button>
				</td>
			</tr> 
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel"  width="100%"
	stripeRows="true" height="100%" dataset="ds" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem id="qrToolbar" text="查询结果"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="导出为Excel" iconCls="detail" handler="exportExcel"/>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem symbol=""></next:ToolBarItem>
		<next:ToolBarItem symbol=""></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column  header="查询单位" field="unitName" width="220" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column   header="查询时间" field="queryDate" width="150" sortable="true">
			<next:TextField />
		</next:Column>
		
		<next:Column header="数据类型" field="businessCategory" dataset="businessCategoryDataSet" width="150" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column   header="查询条件" field="queryCondition" width="75">
			<next:TextField />
		</next:Column>
		
		<next:Column   header="查询信息条数" field="queryResultCount" width="150" sortable="true">
			<next:TextField />
		</next:Column>
		<next:Column   header="身份证件号码男" field="certMan" width="150" sortable="true">
			<next:TextField />
		</next:Column>
		<next:Column   header="身份证件号码女" field="certWoman" width="150" sortable="true">
			<next:TextField />
		</next:Column>
		<next:Column   header="殡葬用身份证件号码" field="fisIdCard" width="150" sortable="true">
			<next:TextField />
		</next:Column>

	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
