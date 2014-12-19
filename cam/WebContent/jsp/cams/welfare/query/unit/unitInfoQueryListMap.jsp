<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>WEAL_UNIT_STATUS列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="unitInfoQueryListMap.js"></script>
		<script language="javascript">
			<%
				String organArea=BspUtil.getCorpOrgan().getOrganCode();
		    	String organName=BspUtil.getCorpOrgan().getOrganName();
		    %>
			var organArea='<%=organArea%>';
			var organName='<%=organName%>';
			var code ='<%=request.getParameter("code")%>';
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
	<model:dataset id="ds" cmd="com.inspur.cams.welfare.welfarecorp.query.cmd.UnitStatusAndInfoQueryCmd" method="queryStatusAndInfoList" pageSize="15" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitStatus"></model:record>
	</model:dataset>
	<!-- 经济性质字典表 -->
	<model:dataset id="ecoDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='WEAL_DIC_ECONOMICNATURE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 企业状态字典表 -->
	<model:dataset id="statusDataSet" enumName="WEAL.UNIT_STATUS"  autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel  name="form" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;"  width="100%" height="100%" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 95%; height: 100%;" id="queryForm" class="L5form">
						<table  border="1" width="100%" >
							<tr>
								<td class="FieldLabel">地区:</td>
									<td class="FieldInput"><input type="text"
							id="domicileName" name="domicileName" readonly="readonly"
							style="width: 150px" /><img
							src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
							style="cursor: hand" onclick="func_ForDomicileSelect()" /> <input
							type="text" id="domicileCode" name="domicileCode"
							style="display: none" /></td>
								<td class="FieldLabel">编号:</td>
								<td class="FieldInput"><input type="text" style="width:150px" id="serialNumQuery" class="TextEditor" title="编号"  /></td>	
								<td class="FieldLabel">企业名称:</td>
								<td class="FieldInput"><input type="text" style="width:150px" id="companyNameQuery" class="TextEditor" title="企业名称"  /></td>
								<td class="FieldLabel"><button onclick="query()">查 询</button></td>
								</tr>
							<tr>
								<td class="FieldLabel">经济性质:</td>
								<td class="FieldInput">
									<select style="width:150px" id=economicNatureCodeQuery class="TextEditor" title="经济性质" >
										<option dataset="ecoDataSet"></option>
									</select></td>
								<td class="FieldLabel">法人代表:</td>
								<td class="FieldInput"><input type="text" style="width:150px" id="legalPeopleQuery" class="TextEditor" title="法人代表"  /></td>
								<td class="FieldLabel">注册地址:</td>
								<td class="FieldInput"><input type="text" style="width:150px" id="addressQuery" class="TextEditor" title="注册地址"  /></td>
								<td class="FieldLabel"><button onclick="resetAll()">重 置</button></td>
							</tr>
							<tr>
								<td class="FieldLabel" >企业状态:</td>
									<td class="FieldInput" >
									<select style="width: 150px;" id="statusQuery" class="TextEditor" title="企业状态">
										<option dataset="statusDataSet"></option>
									</select></td>	
								<td class="FieldLabel">注册资金（万元）:</td>
								<td class="FieldInput">
									<input type="text" style="width:70px" id='regFundBeginQuery' class="TextEditor" title="注册资金区间" style="width:40%;" />~<input type="text" style="width:70px" id='regFundEndQuery' class="TextEditor" title="注册资金区间" style="width:40%;" />
								</td>			
								<td class="FieldLabel">成立起止时间:</td>
								<td class="FieldInput">
									<input type="text" style="width:70px" id='approveDateBeginQuery' class="TextEditor" title="成立起止时间" format="Y-m-d"
										onclick="LoushangDate(this)" readonly="readonly" style="width:40%;" />~<input type="text" style="width:70px" id='approveDateEndQuery' class="TextEditor" title="成立起止时间" format="Y-m-d"
										onclick="LoushangDate(this)" readonly="readonly" style="width:40%;" />
								</td>
								<td class="FieldLabel"></td>	
							</tr>
							<tr>
								<td class="FieldLabel">职工人数:</td>
								<td class="FieldInput">
									<input type="text" style="width:70px" id='workerNumBeginQuery' class="TextEditor" title="职工数量区间" style="width:40%;" />~<input type="text" style="width:70px" id='workerNumEndQuery' class="TextEditor" title="职工数量区间" style="width:40%;" />
								</td>
								<td class="FieldLabel">残疾职工人数:</td>
								<td class="FieldInput">
									<input type="text" style="width:70px" id='disNumBeginQuery' class="TextEditor" title="残疾职工数量区间" style="width:40%;" />~<input type="text" style="width:70px" id='disNumEndQuery' class="TextEditor" title="残疾职工数量区间" style="width:40%;" />
								</td>
								<td class="FieldLabel"></td>
								<td class="FieldInput"></td>
								<td class="FieldLabel"></td>	
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="wealunitstatusGrid" stripeRows="true" width="100%" height="100%" dataset="ds" title="基本信息查询">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="查看" iconCls="detail" handler="detail"/>
		<next:ToolBarItem text="导出Excel" iconCls="export"  handler="exportExcel"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="morgName" header="地区" field="MORG_NAME" width="110">
			<next:TextField  />
		</next:Column>
		
		<next:Column id="serialNum" header="编号" field="SERIAL_NUM" width="120" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="companyName" header="企业名称" field="COMPANY_NAME" width="150" >
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="address" header="注册地址" field="ADDRESS" width="150" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="legalPeople" header="法人代表" field="LEGAL_PEOPLE" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="economicNatureCode" header="经济性质" field="ECONOMIC_NATURE_CODE" width="110" dataset="ecoDataSet">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="regFund" header="注册资金（万元）" field="REG_FUND" width="110" >
			<next:NumberField  />
		</next:Column>
		
		<next:Column id="approveDate" header="成立时间" field="APPROVE_DATE" width="110" >
			<next:NumberField  />
		</next:Column>
		
		<next:Column id="workerNum" header="职工总数" field="WORKERS_ALL" width="110" >
			<next:NumberField  />
		</next:Column>
		
		<next:Column id="disNum" header="残疾职工数" field="WORKERS_DEFORM" width="110" >
			<next:NumberField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
