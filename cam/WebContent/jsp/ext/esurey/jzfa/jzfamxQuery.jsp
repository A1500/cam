<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>

<%
	String organArea = ExtBspInfo.getUserInfo(request).getAreaCode();
	String organType = ExtBspInfo.getUserInfo(request).getOrganType();
%>
<script language="javascript">
	var organArea = "<%=organArea%>";
	var organName = "<%=ExtBspInfo.getUserInfo(request).getOrganName()%>";
	var organId = "<%=ExtBspInfo.getUserInfo(request).getOrganId()%>";
	var organType = "<%=organType%>";
</script>
<html>
<head>
<title>明细查询列表</title>
<next:ScriptManager />
<%
	String planId=new String(request.getParameter("planId").getBytes("ISO-8859-1"), "UTF-8");
	String returnJsp=new String(request.getParameter("returnJsp"));
	String planBegin=new String(request.getParameter("planBegin"));
	String planEnd=new String(request.getParameter("planEnd"));
	%>
<script type="text/javascript">

	var planId = '<%=planId %>';
	var returnJsp = '<%=returnJsp %>'; 
	var jzrqQ = '<%=planBegin%>';
	var jzrqZ = '<%=planEnd%>'; 
</script>
<script type="text/javascript" src="jzfamxQuery.js"></script>
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
	<model:dataset id="sjtjDataset" cmd="com.inspur.sdmz.jzfa.cmd.DetailQueryCmd" method="sjtjmx" global="true" >
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Detail"></model:record>
		<model:params>
			<model:param name="PLAN_ID" value='<%=request.getParameter("planId")%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="jzfamxDataset" cmd="com.inspur.sdmz.jzfa.cmd.DetailQueryCmd"  global="true" autoLoad="true">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Detail"></model:record>
		<model:params>
			<model:param name="PLAN_ID" value='<%=request.getParameter("planId")%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="jzfamxDatasetWin" cmd="com.inspur.sdmz.jzfa.cmd.DetailQueryCmd" global="true" autoLoad="true" method="queryOtherAssisted">
		<model:record fromBean="com.inspur.sdmz.jzfa.data.Detail"></model:record>
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
	<model:dataset id="szdxlxDataset" enumName="SZDXLX.TYPE"  autoLoad="true" global="true"></model:dataset>
	<model:dataset id="szdxlxDatasetInsert" enumName="SZDXLX.TYPE"  autoLoad="true" global="true"></model:dataset>
	<model:dataset id="szdxlxDatasetUpdate" enumName="SZDXLX.TYPE"  autoLoad="true" global="true"></model:dataset>
	<model:dataset id="DmJzfxDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_SIDE'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset  id="jtcyDataset" cmd="com.inspur.sdmz.jtxx.cmd.YgjzJtxxCyxxCommand" method="itemQuery"  pageSize="15">
		<model:record fromBean="com.inspur.sdmz.jtxx.data.BaseinfoPeople"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel autoScroll="true" autoWidth="true">
<next:Panel name="form" width="99%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" title="->  您的位置 : 救助方案 >> 救助方案明细">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox">
			<legend class="GroupBoxTitle">查询条件<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>" onclick="collapse(this)" /></legend>
		<div>
		<form style="width:99%; height: 100%;" class="L5form">
		<table border="1"  style="width:99%;word-wrap:break-word;overflow:hidden;">
			<tr>
				<td class="FieldLabel">受助人/单位名称:</td>
				<td class="FieldInput"><input type="text" id="assistedName" name="szdxmc" class="TextEditor" title="受助人" maxlength="50" /></td>
				<td class="FieldLabel">类型:</td>
				<td class="FieldInput"><select name="szdxlxdm" id="assistedType" field="planType">
										<option dataset="szdxlxDataset"></option>
										</select></td>
				<td class="FieldLabel"></td>
				<td class="FieldInput"><center><button onclick="query()">查  询</button></center></td>
			</tr>
			<tr>
				<td class="FieldLabel">开始日期:</td>
				<td class="FieldInput"><input type="text" id="planBegin" format="Y-m-d" style="width:70" name="planbegin" field="planBegin" onclick="LoushangDate(this)" readonly="readonly"/> 
				-----<input type="text" id="planEnd" format="Y-m-d" name="planend" style="width:70" field="planEnd" onclick="LoushangDate(this)" readonly="readonly"/> 
				</td>
				<td class="FieldLabel" width="10%" nowrap="nowrap" >录入日期：</td>
				<td class="FieldInput" colspan="1"><input type="text" id="lrrqQ" style="width:70" format="Y-m-d" name="lrrqQ" field="regTime" onclick="LoushangDate(this)" readonly="readonly"/>-----
				<input type="text" id="lrrqZ" format="Y-m-d" name="lrrqZ" style="width:70" field="regTime" onclick="LoushangDate(this)" readonly="readonly"/></td>
				<td class="FieldLabel"></td>		
				<td class="FieldInput"><center><button type="reset">重  置</button></center></td>
			</tr>
		<%if(("100".equals(organType))){ %>
			<tr>
				<td class="FieldLabel">残疾类型:</td>
				<td class="FieldInput">
					<select name="disabilityType" field="disabilityType">
						<option dataset="DmCjlxDataSet"></option>
					</select></td>
				<td class="FieldLabel">残疾等级:</td>
				<td class="FieldInput">
					<select name="disabilityLevel" field="disabilityLevel">
						<option dataset="DmCjdjDataSet"></option>
					</select>
					</td>
				<td class="FieldLabel">残疾证号：</td>
				<td class="FieldInput"><input type="text" id="handicapNum" name="handicapNum" class="TextEditor" title="残疾证号"/></td>
			</tr>
		<%} %>
		</table>
		<input type="hidden" name="planId" value='<%=request.getParameter("planId")%>'>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="editGridPanel" width="99%" stripeRows="true" height="260" dataset="jzfamxDataset" notSelectFirstRow="true" title="明细查询">
<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="forInsert"/>
		<next:ToolBarItem iconCls="edit" text="修改" handler="forUpdate"/>
		<next:ToolBarItem iconCls="remove" text="删除" handler="forRemove"/>
		<next:ToolBarItem iconCls="detail" text="导出Excel" handler="exportJzfamxExcel"/>
		<next:ToolBarItem iconCls="detail" text="导入Excel" handler="forImportJzfamxExcel"/>
		<next:ToolBarItem iconCls="detail" text="导出Excel模板下载" handler="importJzfamxTemplate"/>
		<next:ToolBarItem iconCls="undo" text="返回" handler="retuenPage"/>
		
</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="assistedName" header="受助人/单位名称" field="assistedName" width="120" sortable="true" >
			<next:TextField />
		</next:Column>
		<%if(("100".equals(organType))){ %>
		<next:Column id="idCard" header="救助对象身份证号" field="idCard" width="150" sortable="true">
			<next:TextField />
		</next:Column>
		<next:Column id="handicapNum" header="救助对象残疾证号" field="handicapNum" width="120" sortable="true">
			<next:TextField />
		</next:Column>
		<%} %>
		<next:Column id="assistedtType" header="受助对象类型" field="assistedType" width="80" align="center" sortable="true" dataset="szdxlxDataset">
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
		<next:Column id="assistedSide" header="救助方向" field="assistedSide" width="120" sortable="true" dataset="DmJzfxDataset">
			<next:TextField />
		</next:Column>
		<next:Column id="ifAssisted" header="是否被救助" field="" width="120" sortable="true" renderer="ifAssisted">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jzfamxDataset" />
	</next:BottomBar>
</next:GridPanel>
<next:Panel width="99%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;">
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
					<td width="30%" align="right">
						<label class="FieldLabel" >受助对象名称</label>
					</td>
					<td width="20%" align="left">
					<input type="text"  field="assistedName" name="assistedname1" maxlength="50"  onchange="checkCN('assistedname1','idCard','申请人');"/><font color="red">*</font>
					</td>

					<td width="30%" align="right">
						<label class="FieldLabel" >受助对象类型</label>
					</td>
					<td width="20%" align="left">
						<select name="assistedType1" field="assistedType"  onchange="emptySfzh()">
							<option dataset="szdxlxDatasetInsert"></option>
						</select><font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td width="30%" align="right" >
						<label class="FieldLabel" >受助对象身份证号</label>
					</td>
					<td width="20%" align="left">
					<input type="text" id="idCard" name="idCard" field="idCard" maxlength="18" onchange="checkIDCardJzfa('idCard','身份证');"/><font color="red">*</font>
					</td>
				
					<td width="30%" align="right">
						<label class="FieldLabel">受助日期</label>
					</td>
					<td width="20%" align="left">
						<input readonly="true" type="text" name="assitancedate" field="assitanceDate" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/><font color="red">*</font>
					</td>
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
					<td width="30%" align="right" >
						<label class="FieldLabel">救助资金现金金额</label>
					</td>
					<td width="20%" align="left">
					<input type="text" id="jzzjxjJeInsert" field="captial"  name="captial" maxlength="14" onchange=" judgeJe('jzzjxjJeInsert')"  onkeyup="doZfloat('jzzjxjJeInsert');countMoney('jzzjxjJeInsert','jzwpzjJeInsert','jzzjhjJeInsert');"/><font color="red">*</font>
					</td>
				
					<td width="30%" align="right">
						<label class="FieldLabel" >救助物品名称</label>
					</td>
					<td width="20%" align="left" >
						<input id="jzwpmcInsert" type="text"  field="goodsName"  name="goodsname" maxlength="50"/><font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td width="30%" align="right">
						<label class="FieldLabel">救助物品数量</label>
					</td>
					<td width="20%" align="left">
					<input id="jzwpslInsert" type="text"  field="goodsNum" name="goodsnum" maxlength="15"  onchange="judge1()"/><font color="red">*</font>
					</td>
			
					<td width="30%" align="right">
						<label class="FieldLabel">救助物品折价金额</label>
					</td>
					<td width="20%" align="left">
					<input id="jzwpzjJeInsert" type="text" field="goodsNums" maxlength="14" name="goodsnums" onchange=" judgeJe('jzwpzjJeInsert')" onkeyup="doZfloat('jzwpzjJeInsert');countMoney('jzzjxjJeInsert','jzwpzjJeInsert','jzzjhjJeInsert');" /><font color="red">*</font>
					</td>
				</tr>
					
				<tr>
					<td width="30%" align="right">
						<label class="FieldLabel">救助资金合计金额</label>
					</td>
					<td width="20%" align="left">
					<input type="text" id="jzzjhjJeInsert" name="totalfund" field="totalFund" readonly="readonly" maxlength="16"/>
					</td>
					
					<td width="30%" align="right">
						<label class="FieldLabel">救助方向</label>
					</td>
					<td width="20%" align="left">
						<select name="assistedside" field="assistedSide">
							<option dataset="DmJzfxDataset"></option>
						</select><font color="red">*</font>
					</td>
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
					<td width="30%" align="right">
						<label class="FieldLabel" >受助对象名称</label>
					</td>
					<td width="20%" align="left">
					<input type="text"  field="assistedName" name="assistedname2" maxlength="50"  onchange="checkCN('assistedname2','idCard2','受助对象名称');"/><font color="red">*</font>
					</td>

					<td width="30%" align="right">
						<label class="FieldLabel" >受助对象类型</label>
					</td>
					<td width="20%" align="left">
						<select name="assistedType2" field="assistedType" onchange="emptySfzh1()">
							<option dataset="szdxlxDatasetUpdate"></option>
						</select><font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td width="30%" align="right">
						<label class="FieldLabel">受助对象身份证号</label>
					</td>
					<td width="20%" align="left">
					<input type="text" id="idCard2" name="idCard2" field="idCard" maxlength="18"  onchange="checkIDCardJzfa('idCard2','身份证');"/><font color="red">*</font>
					</td>
				
					<td width="30%" align="right">
						<label class="FieldLabel">受助日期</label>
					</td>
					<td width="20%" align="left">
						<input type="text" name="assitancedate" field="assitanceDate" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/><font color="red">*</font>
					</td>
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
					<td width="30%" align="right">
						<label class="FieldLabel">救助资金现金金额</label>
					</td>
					<td width="20%" align="left">
					<input type="text" id="jzzjxjJeUpdate" field="captial" maxlength="11" name="captial" onchange=" judgeJe('jzzjxjJeUpdate')"   onkeyup="doZfloat('jzzjxjJeUpdate');countMoney('jzzjxjJeUpdate','jzwpzjJeUpdate','jzzjhjJeUpdate');"/><font color="red">*</font>
					</td>
				
					<td width="30%" align="right">
						<label class="FieldLabel" >救助物品名称</label>
					</td>
					<td width="20%" align="left" >
						<input type="text"  field="goodsName"  name="goodsname"  maxlength="50"/><font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td width="30%" align="right">
						<label class="FieldLabel">救助物品数量</label>
					</td>
					<td width="20%" align="left">
					<input type="text" id="jzwpslUpdate"  field="goodsNum" name="goodsnum" maxlength="11" onkeyup="judge()"/><font color="red">*</font>
					</td>
			
					<td width="30%" align="right">
						<label class="FieldLabel">救助物品折价金额</label>
					</td>
					<td width="20%" align="left">
					<input id="jzwpzjJeUpdate" type="text" field="goodsNums" maxlength="11" name="goodsnums" onchange=" judgeJe('jzwpzjJeUpdate')"  onkeyup="doZfloat('jzwpzjJeUpdate');countMoney('jzzjxjJeUpdate','jzwpzjJeUpdate','jzzjhjJeUpdate');"  /><font color="red">*</font>
					</td>
				</tr>
					
				<tr>
					<td width="30%" align="right">
						<label class="FieldLabel">救助资金合计金额</label>
					</td>
					<td width="20%" align="left">
					<input type="text" id="jzzjhjJeUpdate" name="totalfund" field="totalFund" readonly="readonly" />
					</td>
					
					<td width="30%" align="right">
						<label class="FieldLabel">救助方向</label>
					</td>
					<td width="20%" align="left">
						<select name="assistedside" field="assistedSide">
							<option dataset="DmJzfxDataset"></option>
						</select><font color="red">*</font>
					</td>
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
<next:GridHelpWindow id="jtcy_help" dataset="jtcyDataset" > 
  <next:GridHelpColumns>
     <next:GridHelpColumn header="户主姓名" sortable="true" field="NAME"/>
     <next:GridHelpColumn header="身份证号" sortable="true" field="FAMILY_CARD_NO"/>
  </next:GridHelpColumns>
     <next:TextHelpField>
         <next:QueryHelpField  header="户主姓名"  field="NAME" ></next:QueryHelpField>
    </next:TextHelpField>
</next:GridHelpWindow>

<next:Window id="otherAssistedWin" resizable="false" width="700" closeAction="hide">
	<next:GridPanel width="99%" stripeRows="true" height="260" dataset="jzfamxDatasetWin" notSelectFirstRow="true" >
		<next:Columns>
			<next:RowNumberColumn width="30" />
			<next:Column  header="受助人/单位名称" field="ASSISTED_NAME" width="120" sortable="true" >
				<next:TextField />
			</next:Column>
			<next:Column  header="救助单位名称" field="PLAN_ORGAN_NAME" width="120" sortable="true" >
				<next:TextField />
			</next:Column>
			<next:Column  header="救助日期" field="PLAN_BEGIN" width="120" sortable="true" >
				<next:TextField />
			</next:Column>
			<next:Column  header="救助资金金额" field="FUND" width="120" sortable="true" >
				<next:TextField />
			</next:Column>
			<next:Column  header="受助对象类型" field="ASSISTED_TYPE" width="80" align="center" sortable="true" dataset="szdxlxDataset">
				<next:TextField />
			</next:Column>
			<next:Column  header="受助日期" field="ASSITANCE_DATE" width="120" align="center" sortable="true">
				<next:TextField />
			</next:Column>
			<next:Column  header="救助资金现金金额" field="CAPTIAL" width="120" align="right" sortable="true">
				<next:TextField />
			</next:Column>
			<next:Column  header="救助物品名称" field="GOODS_NAME" width="120" sortable="true">
				<next:TextField />
			</next:Column>
			<next:Column  header="救助物品数量" field="GOODS_NUM" width="120" align="right" sortable="true">
				<next:TextField />
			</next:Column>
			<next:Column  header="救助物品折价金额" field="GOODS_NUMS" width="120" align="right" sortable="true">
				<next:TextField />
			</next:Column>
			<next:Column  header="合计金额" field="TOTAL_FUND" width="120" align="right" sortable="true">
				<next:TextField />
			</next:Column>
			<next:Column  header="救助方向" field="ASSISTED_SIDE" width="120" sortable="true" dataset="DmJzfxDataset">
				<next:TextField />
			</next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="jzfamxDatasetWin" />
		</next:BottomBar>
	</next:GridPanel>
</next:Window>
</body>
</html>
