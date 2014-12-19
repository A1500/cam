<%@ page contentType="text/html; charset=utf-8"  import="java.util.*"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<html>
<head>
<title>救助活动分析</title>

<script type="text/javascript">
<%
	String planIds = request.getParameter("jzfaids");

	String planIds1=planIds.substring(0,planIds.length()-1);
   %>
    var arr2='<%=planIds %>';
	var arr='<%=planIds1 %>';
</script>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jzfafxAnalyze.js"></script>
<script language="javascript">
			
			
			
			function getDataUrl(){
				var dataUrl = L5.webPath+"/command/dispatcher/org.loushang.demo.draw.DemoPieCommand";
				return dataUrl;
			}
			function getData(){
				var ds=L5.DatasetMgr.lookup("jzfaDataset");
				
				var records=ds.getAllRecords();
				
				
				var arrName=[];
				for(var i=0;i<records.length;i++){
					arrName[i]=records[i].get("ORGANNAME");
				}
				var arrValue=[];
				for(var i=0;i<records.length;i++){
					arrValue[i]=records[i].get("FUND");
				}
				var chartData=[];
				for(var i=0;i<records.length;i++){
						chartData[i]={name:arrName[i],value:arrValue[i]};
				}
				return chartData;
			}
			function initPiePros(){
				return {
				labelPosition:"inside",
				showDataTips:true,
				isPureColor:true
				//stroke:{color:"ffffff"}
				};			
			}
		</script>
</head>
<body style="width:90%">
<model:datasets>
	<model:dataset id="jzfaDataset" cmd="com.inspur.sdmz.jzfa.cmd.PlanQueryCmd" method="analyzeJzfa" global="true"  pageSize="10">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Plan"></model:record>
	</model:dataset>
	<model:dataset id="sjtjfxDataset" cmd="com.inspur.sdmz.jzfa.cmd.PlanQueryCmd" method="sjtjfxAnalyze" global="true" pageSize="10">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Plan"></model:record>
	</model:dataset>
	<model:dataset id="repeatDataset" cmd="com.inspur.sdmz.jzfa.cmd.RePlanCmd" global="true">
	</model:dataset>
	
</model:datasets>


	<next:Panel width="98%">
		<next:TabPanel id="tabPanels" height="1100" width="100%" activeTab="0">
		<next:Tabs>
		<next:Panel title="概要信息">
		<next:GridPanel id="jzfaGrid" name="grid" notSelectFirstRow="true"
			 width="98%" stripeRows="true" height="300" dataset="jzfaDataset" >
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="detail" text="按资金投入统计" handler="zjtrtj"/>
				<next:ToolBarItem iconCls="detail" text="按救助户数统计" handler="jzhstj"/>
				<next:ToolBarItem iconCls="detail" text="按救助人数统计" handler="jzrstj"/>
				<next:ToolBarItem iconCls="undo" text="返回" handler="undo"/>
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn width="30"/>
				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column header="救助单位" field="ORGANNAME" width="200"/>
				<next:Column header="救助活动次数" field="PLANCOUNT" id="jzhdcs" align="right" width="150" />
				<next:Column header="资金总投入" field="FUND" align="right" width="100"/>
				<next:Column header="救助总户数" field="FAMILYNUM" align="right" width="100"/>
				<next:Column header="救助总人数" field="PEOPLENUM" align="right" width="100"/>
			</next:Columns>
			<next:BottomBar><next:PagingToolBar dataset="jzfaDataset"/></next:BottomBar>
		</next:GridPanel>
		
		
		<next:Panel width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;">
			<next:Html>
				<fieldset style="overflow:visible;" class="GroupBox">
					<legend class="GroupBoxTitle">数据统计</legend>
					<div>
						<form onsubmit="return false;" dataset="sjtjfxDataset">
							<table border="0" width="100%">
								<tr>
									<td class="FieldLabel">救助户数</td>
									<td class="FieldInput"><input type="text" id="familySum" field="FAMILYSUM" class="TextEditor" readonly="readonly"/></td>
									<td class="FieldLabel">救助人数</td>
									<td class="FieldInput"><input type="text" id="peopleSum" field="PEOPLESUM" class="TextEditor" readonly="readonly"/></td>
									<td class="FieldLabel">投入资金</td>
									<td class="FieldInput"><input type="text" id="moneySum" field="MONEYSUM" class="TextEditor" readonly="readonly"/></td>
								</tr>
							</table>
						</form>
					</div>
				</fieldset>
			</next:Html>
		</next:Panel>
		<next:Panel width="98%" name="tabpanel-div" height="500">
			<next:Html>
				<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" id="PieChart" width="100%" height="100%">
					<param name="movie" value="PieChart.swf" />
					<param name="flashvars" value="setData=getData"/>
					<embed src="PieChart.swf">
					</embed>
				</object>
			</next:Html>
		</next:Panel>
		</next:Panel>
		<next:Panel title="重复救助">
		<next:GridPanel id="cfjzGril" name="cfjzGril" notSelectFirstRow="true"
			 width="98%" stripeRows="true" height="300" dataset="repeatDataset" >
			<next:TopBar>
			    <next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="undo" text="返回" handler="undo"/>
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn width="30"/>
				<next:Column id="PLAN_ID" header="救助方案ID" field="PLAN_ID" width="150" hidden="true">
								<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column id="FAMILY_ID" header="家庭ID" field="FAMILY_ID" width="150" hidden="true">
								<next:TextField allowBlank="false" />
				</next:Column>
				<next:Column header="救助方案名称"  id="planName"  width="100" field="JZFAMC"/>
				<next:Column header="户主"  id="familyName"  width="100" field="FAMILY_NAME"/>
				<next:Column header="家庭成员"  id="jtcy" width="200" field="JTCY"/>
				<next:Column header="重复救助次数" id="cfjzcsh"  width="80" align="right" field="NUM"/>
				<next:Column header="受助情况（受助人-受助单位）"  width="200" id="JZQK" field="JZQK" renderer="jtxxDetailHref"/>
			</next:Columns>
			<next:BottomBar><next:PagingToolBar dataset="repeatDataset"/></next:BottomBar>
		</next:GridPanel>
		
		
		</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>

</body>
</html>