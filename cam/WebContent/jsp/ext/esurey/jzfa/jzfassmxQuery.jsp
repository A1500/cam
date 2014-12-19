<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>明细查询列表</title>
<next:ScriptManager />
<script type="text/javascript">
<%
	String planId=new String(request.getParameter("planId").getBytes("ISO-8859-1"), "UTF-8");
	String organType = ExtBspInfo.getUserInfo(request).getOrganType();
	%>
	var planId = '<%=planId %>';
	var organType = "<%=organType%>";
</script>
<script type="text/javascript" src="jzfassmxQuery.js"></script>
<script type="text/javascript" src="../jtxx/IDCard.js"></script>
<script type="text/javascript" src="../jtxx/jtxxComm.js"></script>
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
	<model:dataset id="jzfaInsertDataset" cmd="com.inspur.sdmz.jzfa.cmd.DetailQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Detail"></model:record>
	</model:dataset>
	<model:dataset id="jzfaUpdateDataset" cmd="com.inspur.sdmz.jzfa.cmd.DetailQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Detail"></model:record>
	</model:dataset>
	<model:dataset id="sjtjDataset" cmd="com.inspur.sdmz.jzfa.cmd.DetailQueryCmd" method="sjtjmx" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Detail"></model:record>
		<model:params>
			<model:param name="PLAN_ID" value='<%=request.getParameter("planId")%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="jzfamxDataset" cmd="com.inspur.sdmz.jzfa.cmd.DetailQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Detail"></model:record>
		<model:params>
			<model:param name="PLAN_ID" value='<%=request.getParameter("planId")%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="szdxlxDataset" enumName="SZDXLX.TYPE"  autoLoad="true" global="true"></model:dataset>
	<model:dataset id="DmJzfxDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_SIDE'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset  id="jtxxDataset" cmd="com.inspur.sdmz.jtxx.cmd.YgjzJtxxQueryCommand" autoLoad="true" >
		<model:record fromBean="com.inspur.sdmz.jtxx.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 残疾类型 -->
	<model:dataset id="DmCjlxDataSet"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISABILITY_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 残疾等级 -->
	<model:dataset id="DmCjdjDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HANDICAP_LEVEL'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel name="form" width="98%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" title="->  您的位置 : 已实施救助方案查询 >> 救助方案明细">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox">
			<legend class="GroupBoxTitle">查询条件<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>" onclick="collapse(this)" /></legend>
		<div>
		<form style="width: 95%; height: 100%;" class="L5form">
		<table border="1" width="98%">
			<tr>
				<td class="FieldLabel">受助人/单位名称:</td>
				<td class="FieldInput"><input type="text" id="assistedName" name="assistedname" class="TextEditor" title="受助人"  /></td>
				<td class="FieldLabel">类型:</td>
				<td class="FieldInput"><select name="assistedtype" field="assistedType"><option dataset="szdxlxDataset"></option></select></td>
				<td class="FieldLabel" width="10%">身份证:</td>
				<td class="FieldInput" width="19%"><input type="text" style="width:90%" id="sfzhquery" name="sfzhquery" maxlength="18"  class="TextEditor" title="户主身份证" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">开始日期:</td>
				<td class="FieldInput"><input type="text" id="planBegin" format="Y-m-d" name="planbegin" style="width:70" field="planBegin" onclick="LoushangDate(this)" readonly="readonly"/> 
				-----<input type="text" id="planEnd" format="Y-m-d" name="planend" style="width:70" field="planEnd" onclick="LoushangDate(this)" readonly="readonly"/></td>
				<td class="FieldLabel" width="10%" nowrap="nowrap" >录入日期：</td>
				<td class="FieldInput" colspan="1"><input type="text" id="lrrqQ" format="Y-m-d" style="width:70" name="lrrqQ" field="regTime" onclick="LoushangDate(this)" readonly="readonly"/> -----
				<input type="text" id="lrrqZ" format="Y-m-d" name="lrrqZ" field="regTime" style="width:70" onclick="LoushangDate(this)" readonly="readonly"/></td>
				<td class="FieldLabel"></td>
				<td  class="FieldInput"><center>
				<button onclick="query()">查 询</button>
				<button type="reset">重 置</button></center></td>
			</tr>
		<%if(("100".equals(organType))){ %>
			<tr>
				<td class="FieldLabel">残疾类型:</td>
				<td class="FieldInput">
					<select name="disabilityType" id="disabilityType" field="disabilityType">
						<option dataset="DmCjlxDataSet"></option>
					</select></td>
				<td class="FieldLabel">残疾等级:</td>
				<td class="FieldInput">
					<select name="disabilityLevel" id="disabilityLevel" field="disabilityLevel">
						<option dataset="DmCjdjDataSet"></option>
					</select>
					</td>
				<td class="FieldLabel" width="10%">残疾证号:</td>
				<td class="FieldInput" width="19%"><input type="text" style="width:90%" id="cjzhquery" name="cjzhquery" class="TextEditor" title="残疾证号" /></td>
			</tr>
		<%} %>
		</table>
		<input type="hidden" name="planId" value='<%=request.getParameter("planId")%>'>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="editGridPanel" width="98%" stripeRows="true" height="260" dataset="jzfamxDataset" notSelectFirstRow="true" title="明细查询">
<next:TopBar>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="detail" text="导出Excel" handler="exportJzfamxExcel"/>
		<next:ToolBarItem iconCls="undo" text="返回" handler="retuenPage"/>
		
</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:Column id="assistedName" header="受助人/单位名称" field="assistedName" width="120" sortable="true">
			<next:TextField />
		</next:Column>
		<%if(("100".equals(organType))){ %>
		<next:Column id="idCard" header="救助对象身份证号" field="idCard" width="150" sortable="true">
			<next:TextField />
		</next:Column>
		<next:Column id="handicapNum" header="救助对象残疾证号" field="handicapNum" width="120" sortable="true" >
			<next:TextField />
		</next:Column>
		<%} %>
		<next:Column id="assistedType" header="类型" field="assistedType" width="120" sortable="true" dataset="szdxlxDataset">
			<next:TextField />
		</next:Column>

		<next:Column id="assitanceDate" header="受助日期" field="assitanceDate" width="120" align="center" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="captial" header="救助资金现金金额" field="captial" width="120" align="right" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="goodsName" header="救助物品名称" field="goodsName" width="120" sortable="true">
			<next:TextField />
		</next:Column>
		<next:Column id="goodsNum" header="救助物品数量" field="goodsNum" width="120" align="right" sortable="true">
			<next:TextField />
		</next:Column>
		
		<next:Column id="goodsNums" header="救助物品折价金额" field="goodsNums" width="120" align="right" sortable="true">
			<next:TextField />
		</next:Column>
		
		<next:Column id="totalFund" header="合计金额" field="totalFund" width="120" align="right" sortable="true">
			<next:TextField />
		</next:Column>
		
		<next:Column id="assistedSide" header="救助方向" field="assistedSide" width="120"  sortable="true" dataset="DmJzfxDataset">
			<next:TextField />
		</next:Column>
		
		<next:Column id="regOrgName" header="录入单位名称" field="regOrgName" width="120"  sortable="true">
			<next:TextField />
		</next:Column>
		
		<next:Column id="regTime" header="录入日期" field="regTime" width="120"  sortable="true">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jzfamxDataset" />
	</next:BottomBar>
</next:GridPanel>
<next:Panel width="98%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;">
			<next:Html>
				<fieldset style="overflow:visible;" class="GroupBox">
					<legend class="GroupBoxTitle">数据统计</legend>
					<div>
						<form onsubmit="return false;" dataset="sjtjDataset">
							<table border="0" width="99%">
									<tr>
									<td class="FieldLabel">救助人数</td>
									<td class="FieldInput"><input type="text" id="peopleSum" field="PEOPLESUM" class="TextEditor" readonly="readonly"/></td>
									<td class="FieldLabel">救助资金</td>
									<td class="FieldInput"><input type="text" id="moneySum" field="MONEYSUM" class="TextEditor" readonly="readonly"/></td>
									<td class="FieldLabel">物品折款</td>
									<td class="FieldInput"><input type="text" id="goodsSum" field="GOODSSUM" class="TextEditor" readonly="readonly"/></td>
									<td class="FieldLabel">合计</td>
									<td class="FieldInput"><input type="text" id="totalSum" field="TOTALSUM" class="TextEditor" readonly="readonly"/></td>
								</tr>
							</table>
						</form>
					</div>
				</fieldset>
			</next:Html>
		</next:Panel>
<next:Window id="jzfamxWin" title="" resizable="false" width="550"  closeAction="hide" >
	<next:Html>
		<form  id="form1" dataset="jzfaInsertDataset">
			<table id="gao" cellspacing="10" cellpadding="10" border="0"
			width="100%"  >
			<colgroup>
			<col width="100"/>
			<col width="100%"/>
			</colgroup>
			<tbody>
				<tr>
					<td width="30%" align="right"><label class="FieldLabel" >受助对象名称</label></td>
					<td width="20%" align="left"><input type="text"  field="assistedName" name="assistedname"  onchange="checkCN('assistedname','idcard','申请人');"/><font color="red">*</font></td>
					<td width="30%" align="right"><label class="FieldLabel" >受助对象类型</label></td>
					<td width="20%" align="left"><select name="assistedtype0" field="assistedType"><option dataset="szdxlxDataset"></option></select><font color="red">*</font></td>
				</tr>
				<tr>
					<td width="30%" align="right"><label class="FieldLabel" >受助对象身份证号</label></td>
					<td width="20%" align="left"><input type="text" name="idcard" field="idCard" maxlength="18" onchange="checkIDCard('idcard','身份证');"/><font color="red">*</font></td>
					<td width="30%" align="right"><label class="FieldLabel">受助日期</label></td>
					<td width="20%" align="left"><input type="text" name="assitancedate" field="assitanceDate" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/><font color="red">*</font></td>
				</tr>
				<tr>
					<td width="30%" align="right"><label class="FieldLabel">救助资金现金金额</label></td>
					<td width="20%" align="left"><input type="text" id="captial" field="captial"  name="captial"  onkeyup="countMoney();"/><font color="red">*</font></td>
					<td width="30%" align="right"><label class="FieldLabel" >救助物品名称</label></td>
					<td width="20%" align="left" ><input type="text"  field="goodsName"  name="goodsname" /><font color="red">*</font></td>
				</tr>
				<tr>
					<td width="30%" align="right"><label class="FieldLabel">救助物品数量</label></td>
					<td width="20%" align="left"><input type="text"  field="goodsNum" name="goodsnum"  onkeyup="judge()"/><font color="red">*</font></td>
					<td width="30%" align="right"><label class="FieldLabel">救助物品折价金额</label></td>
					<td width="20%" align="left"><input type="text" field="goodsNums" name="goodsnums" onkeyup="countMoney()" /><font color="red">*</font></td>
				</tr>
				<tr>
					<td width="30%" align="right"><label class="FieldLabel">救助资金合计金额</label></td>
					<td width="20%" align="left"><input type="text" id="totalFund" name="totalfund" field="totalFund" readonly="readonly" /></td>
					<td width="30%" align="right"><label class="FieldLabel">救助方向</label></td>
					<td width="20%" align="left"><select name="assistedside" field="assistedSide"><option dataset="DmJzfxDataset"></option></select></td>
				</tr>
			</tbody>
			</table>
		</form>        
	</next:Html>
		<next:Buttons>
		   		<next:ToolButton  text="确定"  handler="jzfamxInsert"></next:ToolButton>
		   		<next:ToolButton  text="返回" handler="hide"></next:ToolButton>
		   		<next:ToolButton  text="查询基本信息" handler="forItemHelp"></next:ToolButton>
		    </next:Buttons>
</next:Window>

<next:Window id="jzfamxUpdateWin" title="" resizable="false" width="550"  closeAction="hide" >
	<next:Html>
		<form  id="form2" dataset="jzfaUpdateDataset">
			<table id="gao1" cellspacing="10" cellpadding="10" border="0"
			width="100%"  >
			<colgroup>
			<col width="100"/>
			<col width="100%"/>
			</colgroup>
			<tbody>
				<tr>
					<td width="30%" align="right"><label class="FieldLabel" >受助对象名称</label></td>
					<td width="20%" align="left"><input type="text"  field="assistedName" name="assistedname2"  onchange="checkCN('assistedname2','idcard1','申请人');"/><font color="red">*</font></td>
					<td width="30%" align="right"><label class="FieldLabel" >受助对象类型</label></td>
					<td width="20%" align="left"><select name="assistedtype1" field="assistedType"><option dataset="szdxlxDataset"></option></select><font color="red">*</font></td>
				</tr>
				<tr>
					<td width="30%" align="right"><label class="FieldLabel" >受助对象身份证号</label></td>
					<td width="20%" align="left"><input type="text" name="idcard1" field="idCard" maxlength="18" onchange="checkIDCard('idcard1','身份证');"/><font color="red">*</font></td>
					<td width="30%" align="right"><label class="FieldLabel">受助日期</label></td>
					<td width="20%" align="left"><input type="text" name="assitancedate1" field="assitanceDate" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/><font color="red">*</font></td>
				</tr>
				<%if(("100".equals(organType))){ %>
				<tr>
					<td width="30%" align="right">
						<label class="FieldLabel">受助对象残疾证号</label>
					</td>
					<td width="20%" align="left">
					<input type="text" id="handicapNum" name="handicapNum" field="handicapNum"/>
					</td>
				
					<td width="30%" align="right">
						<label class="FieldLabel">年龄</label>
					</td>
					<td width="20%" align="left">
						<input type="text" name="age" field="age" maxlength="2"/>
					</td>
				</tr>
				
				<tr>
					<td width="30%" align="right">
						<label class="FieldLabel">残疾类型</label>
					</td>
					<td width="20%" align="left">
					<select name="disabilityType" field="disabilityType">
						<option dataset="DmCjlxDataSet"></option>
					</select></td>
				
					<td width="30%" align="right">
						<label class="FieldLabel">残疾等级</label>
					</td>
					<td width="20%" align="left">
					<select name="disabilityLevel" field="disabilityLevel">
						<option dataset="DmCjdjDataSet"></option>
					</select>
					</td>
				</tr>
			<%} %>
				<tr>
					<td width="30%" align="right"><label class="FieldLabel">救助资金现金金额</label></td>
					<td width="20%" align="left"><input type="text" id="captial" field="captial"  name="captial"  onkeyup="countMoney();"/><font color="red">*</font></td>
					<td width="30%" align="right"><label class="FieldLabel" >救助物品名称</label></td>
					<td width="20%" align="left" ><input type="text"  field="goodsName"  name="goodsname" /><font color="red">*</font></td>
				</tr>
				<tr>
					<td width="30%" align="right"><label class="FieldLabel">救助物品数量</label></td>
					<td width="20%" align="left"><input type="text"  field="goodsNum" name="goodsnum"  onkeyup="judge()"/><font color="red">*</font></td>
					<td width="30%" align="right"><label class="FieldLabel">救助物品折价金额</label></td>
					<td width="20%" align="left"><input type="text" field="goodsNums" name="jzwpzjJe" onkeyup="countMoney()" /><font color="red">*</font></td>
				</tr>
				<tr>
					<td width="30%" align="right"><label class="FieldLabel">救助资金合计金额</label></td>
					<td width="20%" align="left"><input type="text" id="totalFund" name="goodsfund" field="totalFund" readonly="readonly" /></td>
					<td width="30%" align="right"><label class="FieldLabel">救助方向</label></td>
					<td width="20%" align="left"><select name="assistedside" field="assistedSide"><option dataset="DmJzfxDataset"></option></select></td>
				</tr>
			</tbody>
			</table>
		</form>        
	</next:Html>
		<next:Buttons>
		   		<next:ToolButton  text="确定"  handler="jzfamxUpdate"></next:ToolButton>
		   		<next:ToolButton  text="返回" handler="hideUpdate"></next:ToolButton>
		    </next:Buttons>
</next:Window>
<next:GridHelpWindow id="jtxx_help" dataset="jtxxDataset" > 
  <next:GridHelpColumns>
  	 
     <next:GridHelpColumn header="户主姓名" sortable="true" field="familyName"/>
     <next:GridHelpColumn header="身份证号" sortable="true" field="familyCardNo"/>
  </next:GridHelpColumns>
     <next:TextHelpField>
         <next:QueryHelpField header="户主姓名" field="familyName"></next:QueryHelpField>
         <next:QueryHelpField header="身份证号" field="familyCardNo"></next:QueryHelpField>
    </next:TextHelpField></next:GridHelpWindow>
</body>
</html>
