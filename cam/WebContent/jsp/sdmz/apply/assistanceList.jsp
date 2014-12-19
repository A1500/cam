<%@ page contentType="text/html; charset=UTF-8"  import="com.inspur.sdmz.comm.util.*"%>
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
<title>明细查询列表</title>
<next:ScriptManager />
<script type="text/javascript" src="assistanceList.js"></script>
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
	<model:dataset id="hfDataset" cmd="com.inspur.sdmz.apply.cmd.SamApplyCmd" autoLoad="true"
		method="initInsertJsp" global="true">
		<model:record fromBean="com.inspur.sdmz.apply.data.SamApply"></model:record>
	</model:dataset>
	<model:dataset id="ConsultDataSet" enumName="APPLY_WAY.TYPE" autoLoad="true"
		global="true"></model:dataset>
	<model:dataset id="BanliDataSet" enumName="HANDLE_SIGN.TYPE" autoLoad="true"
		global="true"></model:dataset>
	<model:dataset id="HuifangDataSet" enumName="RETURN_VISIT.TYPE" autoLoad="true"
		global="true"></model:dataset>
	<model:dataset id="mydDataset" enumName="SATIS_DEGREE.TYPE" autoLoad="true"
		global="true"></model:dataset>
   <model:dataset id="ds" cmd="com.inspur.sdmz.apply.cmd.SamApplyQueryCmd" method="detail" >
		<model:record fromBean="com.inspur.sdmz.apply.data.SamApply"></model:record>
		<model:params>
			<model:param name="APPLY_TYPE" value='1'></model:param>
		</model:params>
	</model:dataset>
	  <model:dataset id="ds1" cmd="com.inspur.sdmz.apply.cmd.SamApplyQueryCmd" method="detail" >
		<model:record fromBean="com.inspur.sdmz.apply.data.SamApply"></model:record>
		<model:params>
			<model:param name="APPLY_TYPE" value='1'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" title="->  您的位置 : 业务管理 >> 救助业务明细">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 100%;" class="L5form">
		<table border="1" style="width:100%;table-layout:fixed;" >
			<tr>
				<td class="FieldLabel" nowrap="nowrap" width=10%>申请人:</td> 
				<td class="FieldInput"  width=20%><input type="text" id="qapplyPeople"
					class="TextEditor" title="申请人" /></td>
				<td class="FieldLabel" nowrap="nowrap" width=10%>申请起始日期:</td>
				<td class="FieldInput" width=20%><input type="text" id="qapplyDate" format="Y-m-d" name="applyDate"  onclick="LoushangDate(this)"/> 
				</td>
				<td class="FieldLabel" nowrap="nowrap" width=10%>申请结束日期:</td>
				<td class="FieldInput" width=20%><input type="text" id="qapplypeopleqend" format="Y-m-d" name="applypeopleqend"  onclick="LoushangDate(this)"/> 
				</td>
				<td class="FieldButton" nowrap="nowrap" width=10%>
				<button onclick="query()">查 询</button>
				</td>
				
			</tr>
			<tr>
				<td class="FieldLabel" width=10% nowrap="nowrap">申请方式:</td>
				<td class="FieldInput" width=20%><select name="qapplyWay" 
					class="TextEditor" title="申请方式" />
					<option dataset="ConsultDataSet"></option>
				</select></td>
				<td class="FieldLabel" width=10% nowrap="nowrap">办结状态:</td>
				<td class="FieldInput" width=20%><select name="qhandleSign" 
					class="TextEditor" title="办结状态" />
					<option dataset="BanliDataSet"></option>
				</select></td>
				<td class="FieldLabel" width=10% nowrap="nowrap">回访状态:</td>
				<td class="FieldInput" width=20%><select id="qReturnVisit" 
					class="TextEditor" title="回访状态" />
					<option dataset="HuifangDataSet"></option>
				</select></td>
				<td class="FieldButton" width=10% nowrap="nowrap">
				<button type="reset">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel"  width="100%" notSelectFirstRow="true" disableSelection="true"
	stripeRows="true" height="330" dataset="ds"   title="明细查询">
<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="查询全部明细内容" iconCls="detail" handler="mingxiWin" ></next:ToolBarItem>
		<next:ToolBarItem text="查询受理历史" iconCls="detail" handler="ywlsQuery" ></next:ToolBarItem>
		<next:ToolBarItem text="回访" iconCls="detail" handler="hfwin" ></next:ToolBarItem>
</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column header="业务申请ID"  field="applyId" id="applyId" hidden="true"/>
		<next:Column id="applyPeople" header="申请人" field="applyPeople"  sortable="true"/>

		<next:Column id="familyMember" header="家庭成员" field="familyMember"  />
	
		<next:Column id="applyDate" header="申请日期" field="applyDate"  sortable="true"/>
		

		<next:Column id="applyWay" header="申请方式" field="applyWay"  dataset="ConsultDataSet" sortable="true"/>

		<next:Column id="acceptOrgName" header="受理单位名称" field="acceptOrgName"  sortable="true"/>
		<next:Column id="currentOrgName" header="当前办理单位" field="currentOrgName"   sortable="true"/>
	
		<next:Column id="handleSign" header="当前状态" field="handleSign"  dataset="BanliDataSet" sortable="true"/>
		<next:Column id="ReturnVisit" header="是否回访" field="returnVisit"  dataset="HuifangDataSet" sortable="true"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
<next:Window id="mingxi" title="" resizable="false" width="350"  closeAction="hide">
	<next:Html>
		<form dataset="ds" id="test1">
			<table id="gao" cellspacing="10" cellpadding="10" border="0" width="100%" style="table-layout: fixed;" >
			<colgroup>
			<col width="100"/>
			<col width="100%"/>
			</colgroup>
			<tbody>
				<tr>
					<td align="right">
						<label class="FieldLabel">申请人</label>
					</td>
					<td>
					<input type="text" style="width: 200px;" field="applyPeople" class="TextEditor"  disabled="disabled"/>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="FieldLabel">家庭成员</label>
					</td>
					<td class="InnerTableContentCell">
						<input type="text" style="width: 200px;" field="familyMember" class="TextEditor"  disabled="disabled" />
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="FieldLabel" title="">申请日期</label>
					</td>
					<td>
					<input type="text" style="width: 200px;" field="applyDate" class="TextEditor"  disabled="disabled" />
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="FieldLabel">申请方式</label>
					</td>
					<td class="InnerTableContentCell">
						<select name="applyWay" field="applyWay" disabled="disabled">
							<option dataset="ConsultDataSet"></option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="FieldLabel" title="">受理单位名称</label>
					</td>
					<td >
						<input type="text" style="width: 200px;" field="acceptOrgName" class="TextEditor"  disabled="disabled" />
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="FieldLabel">当前状态</label>
					</td>
					<td class="InnerTableContentCell">
						<select name="handleSign" field="handleSign" disabled="disabled">
							<option dataset="BanliDataSet"></option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="FieldLabel">是否回访</label>
					</td>
					<td class="InnerTableContentCell">
						<select name="ReturnVisit" field="returnVisit" disabled="disabled">
							<option dataset="HuifangDataSet"></option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="FieldLabel">回访结果</label>
					</td>
					<td class="InnerTableContentCell">
						 <textarea rows="5" cols="25" name="visitResult" field="visitResult" disabled="disabled"></textarea>
					</td>
				</tr>
			</tbody>
			</table>
		</form>        
	</next:Html>
</next:Window>
<next:Window id="huifang" title="" resizable="false" width="350"  closeAction="hide">
	<next:Html>
		<form dataset="hfDataset" id="test2">
			<table id="gao1" cellspacing="10" cellpadding="10" border="0" width="100%" style="table-layout: fixed;" >
			<colgroup>
			<col width="100"/>
			<col width="100%"/>
			</colgroup>
			<tbody>
				<tr>
					<td align="right">
						<label class="FieldLabel">回访人</label>
					</td>
					<td>
					<input type="text" style="width: 200px;" field="acceptPeople" class="TextEditor" disabled="disabled"/>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="FieldLabel">回访时间</label>
					</td>
					<td class="InnerTableContentCell">
						<input type="text" style="width: 200px;" field="applyDate" class="TextEditor" disabled="disabled" />
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="FieldLabel" title="">满意度</label>
					</td>
					<td>
					<select id="satisDegree" name="satisDegree" field="satisDegree" >
							<option dataset="mydDataset"></option>
						</select>
					
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="FieldLabel">回访结果</label>
					</td>
					<td class="InnerTableContentCell">
						<textarea rows="5" cols="25" field="visitResult" class="TextEditor" ></textarea>  
					</td>
				</tr>
				
			</tbody>
			</table>
		</form>        
	</next:Html>
	<next:Buttons>
		   		<next:ToolButton  text="确定"  handler="ywhf"></next:ToolButton>
		   		<next:ToolButton  text="返回" handler="hide"></next:ToolButton>
	</next:Buttons>
</next:Window>
</body>
</html>
