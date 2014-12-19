<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.*"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.comm.util.*"%>

<html>
	<head>
		<title>资金拨付页面</title>
		<%
			String organType = BspUtil.getOrganType();
		%>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var organType = <%= organType%>;
			var date = '<%=DateUtil.getDay()%>';
		</script>
		<script type="text/javascript" src="allocation.js"></script>
		<script type="text/javascript" src="../../../comm/dicm/autoComplete.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>
	<model:dataset id="detailListDs" cmd="com.inspur.cams.dis.base.cmd.DisFundsAllocationDetailQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsAllocationDetail"></model:record>
	</model:dataset>
	<model:dataset id="detailDs" cmd="com.inspur.cams.dis.base.cmd.DisFundsAllocationDetailQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsAllocationDetail"></model:record>
	</model:dataset>
	<model:dataset id="allocationStatusSelect" enumName="DIS.ALLOCATION_STATUS" autoLoad="true" global="true"></model:dataset>	
	<model:dataset id="allocationTypeSelect" enumName="DIS.ALLOCATION_TYPE" autoLoad="true" global="true"></model:dataset>	
	<model:dataset id="allocationPurposeSelect" enumName="DIS.ALLOCATION_PURPOSE" autoLoad="true" global="true"></model:dataset>	
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="资金拨付页面" autoScroll="true" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Panel  autoScroll="true">
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<fieldset>
		<legend>资金信息</legend>
		<table border="1"  width="100%" >
		
	   		<tr>
				<td class="FieldLabel" style="width:15%">年度</td>
				<td class="FieldInput" style="width:20%"><label field="disYear"/></td>
				<td class="FieldLabel" style="width:15%">拨付状态</td>
				<td class="FieldInput" style="width:20%">
				<label field="allocationStatus" dataset="allocationStatusSelect"/>
				</td>
				<td  class="FieldLabel" style="width:15%">上级下拨文号</td>
				<td class="FieldInput" style="width:20%"><label field="upAllocationNum"/></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >上级下拨资金类型</td>
				<td class="FieldInput">
				<label field="upAllocationType" dataset="allocationTypeSelect"/>
				</td>
				<td  class="FieldLabel" >上级下拨资金总额</td>
				<td class="FieldInput"><label field="upAllocationTotalCount"/></td>
				<td  class="FieldLabel"></td>
				<td class="FieldInput"></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >上级下拨资金用途</td>
				<td class="FieldInput" colspan="5">
				<label id="upAllocationPurposeName"/>
				</td>
			</tr>
		</table>
		</fieldset>
			<div id="ZY" style="display: none">
				<fieldset>
				<legend>中央下拨信息</legend>
					<table border="1"  width="100%" >
				   		<tr>
							<td class="FieldLabel" style="width:15%">中央下拨文号</td>
							<td class="FieldInput" style="width:20%"><label field="zyAllocationNum"/></td>
							<td  class="FieldLabel" style="width:15%">中央拨款总额</td>
							<td class="FieldInput" style="width:20%"><label field="zyAllocationTotal"/></td>
							<td  class="FieldLabel" style="width:15%">中央拨款类型</td>
							<td class="FieldInput" style="width:20%">
							<label field="zyAllocationType" dataset="allocationTypeSelect"/>
							</td>
						</tr>
				   		<tr>
							<td  class="FieldLabel" >上级下拨资金用途</td>
							<td class="FieldInput" colspan="5">
							<label id="zyAllocationPurposeName"/>
							</td>
						</tr>
					</table>
				</fieldset>
			</div>
			<div id="ST" style="display: none">
				<fieldset>
				<legend>省下拨信息</legend>
					<table border="1"  width="100%" >
				   		<tr>
							<td class="FieldLabel" style="width:15%">省下拨文号</td>
							<td class="FieldInput" style="width:20%"><label field="stAllocationNum"/></td>
							<td  class="FieldLabel" style="width:15%">省拨款总额</td>
							<td class="FieldInput" style="width:20%"><label field="stAllocationTotal"/></td>
							<td  class="FieldLabel" style="width:15%">省拨款类型</td>
							<td class="FieldInput" style="width:20%">
							<label field="stAllocationType" dataset="allocationTypeSelect"/>
							</td>
						</tr>
				   		<tr>
							<td  class="FieldLabel" >省下拨资金用途</td>
							<td class="FieldInput" colspan="5">
							<label id="stAllocationPurposeName"/>
							</td>
						</tr>
					</table>
				</fieldset>
			</div>
			<div id="CS" style="display: none">
				<fieldset>
				<legend>市下拨信息</legend>
					<table border="1"  width="100%" >
				   		<tr>
							<td class="FieldLabel" style="width:15%">市下拨文号</td>
							<td class="FieldInput" style="width:20%"><label field="csAllocationNum"/></td>
							<td  class="FieldLabel" style="width:15%">市拨款总额</td>
							<td class="FieldInput" style="width:20%"><label field="csAllocationTotal"/></td>
							<td  class="FieldLabel" style="width:15%">市拨款类型</td>
							<td class="FieldInput" style="width:20%">
							<label field="csAllocationType" dataset="allocationTypeSelect"/>
							</td>
						</tr>
				   		<tr>
							<td  class="FieldLabel" >市下拨资金用途</td>
							<td class="FieldInput" colspan="5">
							<label id="csAllocationPurposeName"/>
							</td>
						</tr>
					</table>
				</fieldset>
			</div>
			<div id="QX" style="display:none">
				<fieldset>
				<legend>县下拨信息</legend>
					<table border="1"  width="100%" >
				   		<tr>
							<td class="FieldLabel" style="width:15%">县下拨文号</td>
							<td class="FieldInput" style="width:20%"><label field="qxAllocationNum"/></td>
							<td  class="FieldLabel" style="width:15%">县拨款总额</td>
							<td class="FieldInput" style="width:20%"><label field="qxAllocationTotal"/></td>
							<td  class="FieldLabel" style="width:15%">县拨款类型</td>
							<td class="FieldInput" style="width:20%">
							<label field="qxAllocationType" dataset="allocationTypeSelect"/>
							</td>
						</tr>
				   		<tr>
							<td  class="FieldLabel" >县下拨资金用途</td>
							<td class="FieldInput" colspan="5">
							<label id="qxAllocationPurposeName"/>
							</td>
						</tr>
					</table>
				</fieldset>
			</div>
		</form>
   </next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" name="disfundsallocationdetailGrid" width="100%" stripeRows="true" height="400" dataset="detailListDs" title="资金发放明细">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insertDetail" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="updateDetail"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="delDetail"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
	     
		<next:Column id="id" header="ID" field="id" width="90" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="allocateOrganName" header="拨付单位名称" field="allocateOrganName" width="15%" >
			<next:TextField  />
		</next:Column>
		<next:Column id="allocationNum" header="拨款资金文号" field="allocationNum" width="8%" >
			<next:TextField  />
		</next:Column>
		<next:Column id="allocationDate" header="拨款日期" field="allocationDate" width="8%" >
			<next:TextField  />
		</next:Column>
		<next:Column id="allocationTotal" header="拨款总额" field="allocationTotal" width="8%">
			<next:NumberField  />
		</next:Column>
		<next:Column id="allocationType" header="拨款类型" field="allocationType" width="8%" >
			<next:TextField  /><next:ComboBox dataset="allocationTypeSelect"/>
		</next:Column>
		<next:Column id="allocationPurpose" header="资金用途" field="allocationPurpose" width="25%"  renderer="fillPurposeName">
			<next:TextField  />
		</next:Column>
		<next:Column id="allocateOrganCode" header="拨付单位区划" field="allocateOrganCode" width="10%" >
			<next:TextField  />
		</next:Column>
		<next:Column id="allocationAmount" header="拨款数额" field="allocationAmount" width="10%" >
			<next:NumberField  />
		</next:Column>
		<next:Column id="note" header="备注" field="note" width="10%" >
			<next:TextField  />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="detailListDs"/>
	</next:BottomBar>
</next:GridPanel>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
<next:Window title="资金发放明细维护" id="detailEditWin" height="300" width="600"	closeAction="hide" modal="true" hidden="true">
	<next:Panel>
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="确定" iconCls="select" handler="saveDetal"></next:ToolBarItem>
			<next:ToolBarItem text="关闭" iconCls="return" handler="colseDetailEditWin"></next:ToolBarItem>
		</next:TopBar>
		<next:Html>
			<form id="editForm"   dataset="detailDs" onsubmit="return false" style="padding: 5px;" class="L5form">
			<table border="1"  width="100%" >
			
		   		<tr>
					<td  class="FieldLabel" >拨款日期</td>
					<td class="FieldInput"><input type="text" name="allocationDate" field="allocationDate"  /> </td>
				
					<td  class="FieldLabel" >拨款资金文号</td>
					<td class="FieldInput"><input type="text" name="allocationNum" field="allocationNum"  /> </td>
				</tr>
		   		<tr>
					<td  class="FieldLabel" >拨款总额</td>
					<td class="FieldInput">
					<label id="allocationTotal" filed="allocationTotal"/>
					 </td>
				
					<td  class="FieldLabel" >拨款类型</td>
					<td class="FieldInput">
					<select field="allocationType" id="allocationType" name='"拨款类型"'>
						<option dataset="allocationTypeSelect"></option>
					</select>
					</td>
				</tr>
		   		<tr>
					<td  class="FieldLabel" >资金用途</td>
					<td class="FieldInput" colspan="3">
					<input type="text"  id='allocationPurposeName' style="width:85.8%" readOnly="true" />
					<img src="<%=SkinUtils.getImage(request, "l5/help.gif")%>" style="cursor:hand" onclick="openTypeWin()"/>
					<input type="hidden" field="allocationPurpose" id='allocationPurpose'>
					</td>
				</tr>
		   		<tr>
					<td  class="FieldLabel" >拨付单位</td>
					<td class="FieldInput">
					<input type="text"  id="allocateOrganName"  field="allocateOrganName" class="TextEditor" title="拨付单位"  readonly="readonly" onclick="selectOrganNoDs()"/>
					<input type="hidden"  id="allocateOrganCode"  field="allocateOrganCode" class="TextEditor"/></td>
					<td  class="FieldLabel" >拨款数额</td>
					<td class="FieldInput"><input type="text" name="allocationAmount" field="allocationAmount"  /> </td>
				</tr>
		   		<tr>
					<td  class="FieldLabel" >备注</td>
					<td class="FieldInput" colspan="3">
					<textarea rows="5" name='备注' field="note" style="width:98%"></textarea>
					</td>
				
				</tr>
			</table>
			</form>
	   </next:Html>
	</next:Panel>
</next:Window>	
<jsp:include page="../../comm/purposeWin.jsp" flush="true"/>   
</body>
</html>
