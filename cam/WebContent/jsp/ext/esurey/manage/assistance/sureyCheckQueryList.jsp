<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<html>
<head>
<next:ScriptManager/>
<script type="text/javascript" src="sureyCheckQueryList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<style>
.table {
border-collapse:collapse;
}
.input {
background-color:#EAF4FD;
border-style: none;
text-align:center;
cursor: hand;
}
.input1 {
background-color:#EAF4FD;
border-style: none;
text-align:center;
}
.td {
border-style: solid;
border-color: #000000;
border-width: 1px;
}
.tdTitle {
border-style: solid;
border-color: #000000;
border-width: 1.5px;
font-weight: bold;
}
.tdIma {
background-image:url(line.bpm); 
background-repeat:no-repeat; 
} 
</style>
<script language="javascript">
	var organId = "<%=ExtBspInfo.getUserInfo(request).getOrganId()%>";
	var organArea = "<%=ExtBspInfo.getUserInfo(request).getAreaCode()%>";
	var organName = "<%=ExtBspInfo.getUserInfo(request).getOrganName()%>";
	var organType = "<%=ExtBspInfo.getUserInfo(request).getOrganType()%>";
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
	<model:dataset id="ds" cmd="com.inspur.cams.drel.surey.assistance.cmd.SamSureyReportCmd" method="extStatsReport" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.drel.surey.util.Report">
		</model:record>
	</model:dataset>
	<model:dataset id="assistanceTypeDS" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value="SURVEY_ASSISTANCE_TYPE"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="samSureyWfDataset" cmd="com.inspur.cams.drel.surey.comm.cmd.SamSureyWfQueryCmd" method="extStatsReport" global="true" pageSize="10">
	</model:dataset>
	<!--属地-->
	<model:dataset id="domicileDataset" autoLoad="false" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 核对结果 -->
	<model:dataset id="resultDS" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value="SURVEY_ASSISTANCE_TYPE"></model:param>
		</model:params>
	</model:dataset>		
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>		
</model:datasets>

<next:ViewPort>
	<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="25%" >
		<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)" /> </legend>
			<div>
				<form style="width: 95%; height: 100%;" class="L5form">
					<table border="1" width="100%">
						<tr>
							<td class="FieldLabel">申请日期:</td>						
							<td class="FieldInput">
								<input type="text" id="applyDateQ" format="Y-m-d" name="applyDateQ" field="applyDate" style="width: 70"	onclick="LoushangDate(this)" readonly="readonly" /> ----- 
								<input type="text" id="applyDateZ" format="Y-m-d" name="applyDateZ" field="applyDate" onclick="LoushangDate(this)" style="width: 70" readonly="readonly" />					
							</td>							
							<td class="FieldLabel">核对项目:</td>
							<td class="FieldInput">
								<select id="assistanceTypeQuery" name="assistanceType">
									<option dataset="assistanceTypeDS"></option>
								</select>
							</td>							
							<td class="FieldInput">
								<input type="hidden" id="ywblquery"><button onclick="query()">查 询</button>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button onclick="reset()">重 置</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</fieldset>
		</next:Html>
	</next:Panel>
	<next:Panel title="业务办理年统计报表" width="100%" border="0" bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;" height="100%" autoScroll="true" >
		<next:Html>
			<div align="center" id="reDiv" style="display:none">
				<table dataset="ds" width="80%" class="table">
					<tr height=25 align="center">
						<td class="tdTitle" colspan="13">低保低收入家庭核对统计报表</td>
					</tr>
					<tr>
						<td class="tdTitle" rowspan="2">
							<span>核对单位
							</span>
						</td>
						<td class="tdTitle" colspan="3" align="center">核对总人次</td>
						<td class="tdTitle" colspan="3" align="center">核对城市低保人次</td>
						<td class="tdTitle" colspan="3" align="center">核对农村低保人次</td>
						<td class="tdTitle" colspan="3" align="center">核对低收入家庭人次</td>						
					</tr>
					<tr>
						<td class="tdTitle" width="3%" align="center">总数</td>
						<td class="tdTitle" width="3%" align="center">已办结</td>
						<td class="tdTitle" width="3%" align="center">未办结</td>		
						<td class="tdTitle" width="3%" align="center">总数</td>
						<td class="tdTitle" width="3%" align="center">已办结</td>
						<td class="tdTitle" width="3%" align="center">未办结</td>	
						<td class="tdTitle" width="3%" align="center">总数</td>
						<td class="tdTitle" width="3%" align="center">已办结</td>
						<td class="tdTitle" width="3%" align="center">未办结</td>
						<td class="tdTitle" width="3%" align="center">总数</td>
						<td class="tdTitle" width="3%" align="center">已办结</td>
						<td class="tdTitle" width="3%" align="center">未办结</td>																							
					</tr>
					<tr repeat="true">
						<td align="center" class="td">
							<input type="text" field="name" readonly="true" class="input1"/>
						</td>
						<td align="center" class="td">
							<input type="hidden" field="type"/>
							<input type="hidden" field="id"/>
							<input type="text" field="Row1" size="6" readonly="true" class="input" onclick="showWinRow(this,null,'')" />
						</td>
						<td align="center" class="td">	
							<input type="hidden" field="type"/>
							<input type="hidden" field="id"/>						
							<input type="text" field="Row2" size="6" readonly="true" class="input" onclick="showWinRow(this,null,'1')" />
						</td>
						<td align="center" class="td">	
							<input type="hidden" field="type"/>
							<input type="hidden" field="id"/>						
							<input type="text" field="Row3" size="6" readonly="true" class="input" onclick="showWinRow(this,null,'0')" />							
						</td>
						<td align="center" class="td">
							<input type="hidden" field="type"/>
							<input type="hidden" field="id"/>
							<input type="text" field="Row4" size="6" readonly="true" class="input" onclick="showWinRow(this,'01','')"/>
						</td>
						<td align="center" class="td">
							<input type="hidden" field="type"/>
							<input type="hidden" field="id"/>							
							<input type="text" field="Row5" size="6" readonly="true" class="input" onclick="showWinRow(this,'01','1')"/>
						</td>
						<td align="center" class="td">	
							<input type="hidden" field="type"/>
							<input type="hidden" field="id"/>						
							<input type="text" field="Row6" size="6" readonly="true" class="input" onclick="showWinRow(this,'01','0')"/>
						</td>						
						<td align="center" class="td">
							<input type="hidden" field="type"/>
							<input type="hidden" field="id"/>
							<input type="text" field="Row7" size="6" readonly="true" class="input" onclick="showWinRow(this,'02','')"/>
						</td>
						<td align="center" class="td">	
							<input type="hidden" field="type"/>
							<input type="hidden" field="id"/>						
							<input type="text" field="Row8" size="6" readonly="true" class="input" onclick="showWinRow(this,'02','1')"/>
						</td>
						<td align="center" class="td">	
							<input type="hidden" field="type"/>
							<input type="hidden" field="id"/>						
							<input type="text" field="Row9" size="6" readonly="true" class="input" onclick="showWinRow(this,'02','0')"/>
						</td>						
						<td align="center" class="td">
							<input type="hidden" field="type"/>
							<input type="hidden" field="id"/>
							<input type="text" field="Row10" size="6" readonly="true" class="input" onclick="showWinRow(this,'03','')"/>
						</td>
						<td align="center" class="td">	
							<input type="hidden" field="type"/>
							<input type="hidden" field="id"/>						
							<input type="text" field="Row11" size="6" readonly="true" class="input" onclick="showWinRow(this,'03','1')"/>
						</td>
						<td align="center" class="td">		
							<input type="hidden" field="type"/>
							<input type="hidden" field="id"/>					
							<input type="text" field="Row12" size="6" readonly="true" class="input" onclick="showWinRow(this,'03','0')"/>
						</td>					
					</tr>					
				</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>

<next:Window id="win" title="人员信息窗口" resizable="false" width="750" height="100%" autoHeight="true" closeAction="hide" autoScroll="true">
	<next:GridPanel id="gridPanel" name="gridPanel" width="735" stripeRows="true" height="400" dataset="samSureyWfDataset" notSelectFirstRow="true" title="核对人员列表">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="delete" text="关闭" handler="winClose" />
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn width="30" />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="姓名" field="NAME" width="80">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:Column header="身份证件号码" field="ID_CARD" width="150">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:Column header="户籍县（市、区）地址" field="DOMICILE_CODE" dataset="domicileDataset" width="80">
				<next:TextField />
			</next:Column>
			<next:Column header="居住县（市、区）地址" field="APANAGE_CODE" dataset="domicileDataset" width="80">
				<next:TextField />
			</next:Column>
			<next:Column header="申请日期" field="APPLY_DATE" width="80">
				<next:TextField allowBlank="false" />
			</next:Column>		
			<next:Column header="核对项目" field="ASSISTANCE_TYPE" dataset="assistanceTypeDS" width="80">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:Column header="是否办结" field="IS_FINISH" dataset="comm_yesorno" width="80">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:Column header="核对结果" field="RESULT" dataset="resultDS" width="80">
				<next:TextField allowBlank="false" />
			</next:Column>	
			<next:Column header="核对单位" field="SURVEY_ORGAN_NAME" width="150">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:Column header="核对日期" field="SURVEY_DATE"  width="80">
				<next:TextField allowBlank="false" />
			</next:Column>	
			<next:Column header="低保证发证机关/低收入认定单位" field="SIGN_ORGAN" width="200">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:Column header="低保证发证时间/低收入认定时间" field="SIGN_DATE" width="200">
				<next:TextField allowBlank="false" />
			</next:Column>				
			<next:Column header="流程ID" field="FLOW_ID" hidden="true">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:Column header="核对流水ID" field="SURVEY_ID" hidden="true">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:Column header="人员ID" field="PEOPLE_ID" hidden="true">
				<next:TextField allowBlank="false" />
			</next:Column>	
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="samSureyWfDataset" />
		</next:BottomBar>
	</next:GridPanel>
</next:Window>

</body>
</html>