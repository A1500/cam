<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.marry.util.CheckStatus"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>等级评定整改</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
var DJC_BC = '<%=CheckStatus.DJC_BC%>';
var DJC_SB = '<%=CheckStatus.DJC_SB%>';
var QX_TG = '<%=CheckStatus.QX_TG%>';
var QX_WTG = '<%=CheckStatus.QX_WTG%>';
var DS_TG = '<%=CheckStatus.DS_TG%>';
var DS_WTG = '<%=CheckStatus.DS_WTG%>';
var S_TG = '<%=CheckStatus.S_TG%>';
var S_WTG = '<%=CheckStatus.S_WTG%>';
var B_TG = '<%=CheckStatus.B_TG%>';
var B_WTG = '<%=CheckStatus.B_WTG%>';
var organCode ='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
var organType = '<%=BspUtil.getOrganType()%>';
//查询条件面板打开合并函数
function collapse(element){
	var fieldsetParent=L5.get(element).findParent("fieldset");
	if(element.expand==null||element.expand==true){	
		fieldsetParent.getElementsByTagName("div")[0].style.display="none";
		element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';
		element.expand=false;
	}else{
		fieldsetParent.getElementsByTagName("div")[0].style.display="";
		element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";
		element.expand =true;
	}
}
</script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js") %>"></script>
<script type="text/javascript" src="mrmLevelCancelList.js"></script>
</head>
<body>
<model:datasets>
	<!-- 业务信息 -->
	<model:dataset id="organDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoQueryCommand" global="true" method="queryLevelOrgan">
	</model:dataset>
	
	<model:dataset id="applyDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmOrganStandardApplyQueryCommand" global="true" 
	sortField="APPLY_TIME" sortDirection="desc">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmOrganStandardApply">
		</model:record>
	</model:dataset>
	
	<model:dataset id="applyEndDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmOrganStandardApplyQueryCommand" global="true" 
		sortField="APPLY_TIME" sortDirection="desc">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmOrganStandardApply">
		</model:record>
	</model:dataset>
	
	<model:dataset id="applyQueryDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmOrganStandardApplyQueryCommand">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmOrganStandardApply">
		</model:record>
	</model:dataset>
	<!-- 等级 -->
	<model:dataset id="evaluLevelDataSet" enumName="MRM.EVALULEVEL.TYPE" global="true" autoLoad="true" />
	<!-- 机构状态 -->
	<model:dataset id="validDs" enumName="MRM.VALIDFLAG" autoLoad="true"></model:dataset>
	<model:dataset id="checkStatusDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='MRM_CHECK_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:TabPanel width="100%" height="100%" id="tab">
	<next:Tabs>
		<next:Panel title="婚姻登记机关列表" width="100%" height="100%">
			<next:GridPanel id="gridanel" title="婚姻登记机关列表"
				dataset="organDataSet" stripeRows="true" notSelectFirstRow="true"
				height="100%">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="detail" text="填写整改报告" handler="newRect" />
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn />
					<next:RadioBoxColumn />
					<next:Column header="婚姻登记机关单位名称" field="NAME" width="200"
						renderer="childRegsion"></next:Column>
					<next:Column header="等级" field="SKIN_VALUE" width="120"
						dataset="evaluLevelDataSet"></next:Column>
					<next:Column header="代码" field="DEPT_CODE" width="150"></next:Column>
					<next:Column header="服务电话" field="DEPT_TEL" width="150"></next:Column>
					<next:Column header="状态" field="VALID_FLAG" width="100"
						hidden="true" dataset="validDs"></next:Column>
					<next:Column header="地址" field="DEPT_ADDRESS" width="200"></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="organDataSet" />
				</next:BottomBar>
			</next:GridPanel>
		</next:Panel>
		
<next:Panel width="100%" height="100%"  title="待办业务列表">
	<next:Panel border="0">	
		<next:Html><center>		
			<fieldset  style="width:98%;overflow: visible;" class="GroupBox">
				<legend class="GroupBoxTitle">
					查询条件 <img class="GroupBoxExpandButton"
						src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
						onclick="collapse(this)" />
				</legend>
				<div>
					<form style="width: 98%; height: 100%;" class="L5form">
						<table  border="0" width="100%">
							<tr>
							 	<td class="FieldLabel" style="width:10%">整改单位名称</td>
				                <td class="FieldInput" style="width:20%"><input id="curOrganName1" style="width:80%"/></td>
				                 <td class="FieldLabel" style="width:10%">报告时间</td>
				                <td class="FieldInput" style="width:20%">
				                	<input type="text" id="creatDate"  format="Y-m-d"  
										  readonly="readonly" onclick="LoushangDate(this)"/> 
				                </td>
				                <td class="FieldButton" style="width:10%">
				                	<button onclick="query()">查询</button>&nbsp;&nbsp;<button type="reset">重置</button>
				                </td>
							</tr>
						</table>
					</form>
				</div>
			</fieldset>
		</center></next:Html>
	</next:Panel>
	<next:GridPanel id="gridPanel" title="等级评定整改申报列表" dataset="applyDataSet" stripeRows="true" notSelectFirstRow="true" height="100%">
		<next:TopBar>		
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="detail"  text="办理" handler="handle"/>
			<next:ToolBarItem iconCls="remove"  text="删除" handler="deleteApply"/>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn/>
		    <next:Column header="整改单位名称" field="organName" width="200"  ></next:Column>
		    <next:Column header="等级" field="applyLevel" width="120" dataset="evaluLevelDataSet"></next:Column>
			 <next:Column header="申报单位" field="cancelOrganName" width="200" ></next:Column>
			  <next:Column header="通知整改单位" field="correctOrgan" width="200" ></next:Column>
			<next:Column header="申报时间" field="applyTime" width="150" ></next:Column>
			<next:Column header="当前处理单位" field="curOrganName" width="200" ></next:Column>						
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="applyDataSet" />
		</next:BottomBar>
	</next:GridPanel>
</next:Panel>


<next:Panel width="100%" height="100%"  title="已办业务列表">
	<next:Panel border="0">	
		<next:Html><center>		
			<fieldset  style="width:98%;overflow: visible;" class="GroupBox">
				<legend class="GroupBoxTitle">
					查询条件 <img class="GroupBoxExpandButton"
						src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
						onclick="collapse(this)" />
				</legend>
				<div>
					<form style="width: 98%; height: 100%;" class="L5form">
						<table  border="0" width="100%">
							<tr>
							 	<td class="FieldLabel" style="width:10%">整改单位名称</td>
				                <td class="FieldInput" style="width:20%"><input id="curOrganName" style="width:80%"/></td>
				                <td class="FieldLabel" style="width:10%">审核状态</td>
				                <td class="FieldInput" style="width:20%">
				                	<select id="checkStatus" style="width:80%">
				                		<option value="">请选择...</option>
				                		<option value="11,21,31,32,41,42,52">在审</option>
				                		<option value="20,30,40,50">未通过</option>
				                		<option value="51">办结</option>
				                	</select>
				                </td>
				                <td class="FieldButton" style="width:10%">
				                	<button onclick="queryEnd()">查询</button>&nbsp;&nbsp;<button type="reset">重置</button>
				                </td>
							</tr>
						</table>
					</form>
				</div>
			</fieldset>
		</center></next:Html>
	</next:Panel>
	<next:GridPanel id="gridEndPanel" title="等级评定整改申报列表" dataset="applyEndDataSet" stripeRows="true" notSelectFirstRow="true" height="100%">
		<next:TopBar>		
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="detail"  text="查看" handler="handleEnd"/>
			<next:ToolBarItem iconCls="print"  text="打印" handler="printApply"/>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn/>
		    <next:Column header="整改单位名称" field="organName" width="200" ></next:Column>
		    <next:Column header="等级" field="applyLevel" width="80" dataset="evaluLevelDataSet"></next:Column>
			 <next:Column header="申报单位" field="cancelOrganName" width="200" ></next:Column>
			  <next:Column header="通知整改单位" field="correctOrgan" width="200" ></next:Column>
			<next:Column header="申报时间" field="applyTime" width="100" ></next:Column>
			<next:Column header="当前处理单位" field="curOrganName" width="200" ></next:Column>					
			<next:Column header="审核状态" field="checkStatus" width="100" dataset="checkStatusDataset"></next:Column>				
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="applyEndDataSet" />
		</next:BottomBar>
	</next:GridPanel>
</next:Panel>
	</next:Tabs>
</next:TabPanel>
</body>
</html>