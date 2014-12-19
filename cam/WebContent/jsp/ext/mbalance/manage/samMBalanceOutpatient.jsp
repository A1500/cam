<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@ page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
	<head>
		<title>优抚门规信息列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="samMBalanceOutpatient.js"></script>
<script type="text/javascript" src="samMBExtComm.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript">
			var hospitalId='<%=ExtBspInfo.getUserInfo(request).getOrganId()%>';
			var regId='<%=ExtBspInfo.getUserInfo(request).getUserId()%>';
			var regPeople='<%=ExtBspInfo.getUserInfo(request).getUserName()%>';
			var organCode='<%=ExtBspInfo.getUserInfo(request).getAreaCode()%>';
		</script>
		<script language="javascript">
	 	     //查询条件打开合并函数
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

	</head>
	
<body>
<model:datasets>
    <model:dataset id="ds" cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalClinicSpQueryCmd" method="queryBySql" pageSize="10">
	</model:dataset>
	<model:dataset id="ds2" cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalClinicSpQueryCmd">
      <model:record fromBean="com.inspur.cams.drel.mbalance.data.SamMedicalClinicSp">
      		<model:field name="dateBegin" type="string"  rule="require"/>
      		<model:field name="dateEnd" type="string"  rule="require"/>
      		<model:field name="totalExpense" type="string"  rule="require"/>
      		<model:field name="hospitalPay" type="string"  rule="require"/>
      		<model:field name="specialPay" type="string"  rule="require"/>
      		<model:field name="personalPay" type="string"  rule="require"/>
      		<model:field name="num" type="string"  rule="require|integer"/>
      		<model:field name="doctor" type="string"  rule="require"/>
      		<model:field name="diagnosis" type="string"  rule="require|length{500}"/>
      </model:record>
	</model:dataset>	
	<!-- 伤残等级 -->
	<model:dataset id="disbilityLevelDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISABILITY_LEVEL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ds3" cmd="com.inspur.cams.drel.mbalance.cmd.SamMedicalClinicSpQueryCmd" method="queryBySql" pageSize="10">
	</model:dataset>	
<!-- 个人信息 -->
	<model:dataset id="peopleDS" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
		</model:record>
	</model:dataset>	
	<!-- 个人信息 -->
	<model:dataset id="basePeopleDs" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
		</model:record>
	</model:dataset>
	<model:dataset id="basePeopleDs2" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
		</model:record>
	</model:dataset>
	<model:dataset id="signDS" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="typeDS" enumName="EXT.BPTTYPE" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="sexDS" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
</model:datasets>
  <next:Panel name="dep_rule" width="100%"  >
	<next:Html>
	<fieldset >
		<legend>查询条件
		<img class="GroupBoxExpandButton" src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%> onclick="collapse(this);"/>										
		</legend>
			<div>
				<form  class="L5form">
						<input type="hidden" id="peopleId" name="人员信息"  />
						<input type="hidden" name="regTime" id="regTime" value="<%=DateUtil.getTime() %>" title="录入时间" />
						<table width="100%" >
							<tr>
								<td class="FieldLabel" width="10%"><label>户主姓名:</label></td>
								<td class="FieldInput" width="35%"><input type="text"  id="qName" maxlength="25"/></td>					
								<td class="FieldLabel"  width="10%"><label>身份证号:</label></td>
								<td class="FieldInput" width="30%"><input type="text"  id="qIdCard" maxlength="18" style="width: 60%"/></td>		
								<td class="FieldButton" ><button onclick="query();">查 询</button></td>	
							</tr>
							<tr>
								<td class="FieldLabel"><label>就诊时间起:</label></td>
								<td class="FieldInput"><input type="text"  id="qDateBegin" format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly"/></td>					
								<td class="FieldLabel"><label>就诊时间止:</label></td>
								<td class="FieldInput"><input type="text"  id="qDateEnd" format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly" style="width: 60%" /></td>		
								<td class="FieldButton" ><button type="reset">重 置</button></td>	
							</tr>
						</table>
					</form>
				</div>	
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="rule_Grid" name="rule_Grid"   dataset="ds" title="优抚门规信息列表" stripeRows="true" notSelectFirstRow="true" autoScroll="true" collapsible="true"  width="100%" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="录入" iconCls="add"  handler="add_rules"></next:ToolBarItem>
		<next:ToolBarItem text="修改" iconCls="edit" handler="edit_rules"></next:ToolBarItem>
		<next:ToolBarItem text="查看明细" iconCls="detail" handler="detail_rules"></next:ToolBarItem>
		<next:ToolBarItem text="提交" iconCls="detail" handler="commit_rules"></next:ToolBarItem>
		<next:ToolBarItem text="删除" iconCls="remove" handler="detele_rules"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
	     <next:RowNumberColumn width="10"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="id" header=" 门规ID" field="ID" hidden="true" width="10%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="gpeopleId" header="人员id" field="PEOPLE_ID" hidden="true" width="10%"  >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="name" header="姓名" field="NAME" sortable="true" width="10%">
			<next:TextField />
		</next:Column>
		<next:Column id="gidCard" header="身份证号码" field="ID_CARD" width="20%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="psex" header="性别" field="SEX" width="5%">
			<next:TextField />
		</next:Column>
		<next:Column id="page" header="年龄" field="AGE" width="5%">
			<next:TextField />
		</next:Column>
		<next:Column id="hospitalId" header="就诊机构" field="HOSPITAL_ID" hidden="true" width="15%">
			<next:TextField />
		</next:Column>
		<next:Column id="dateBegin" header="就诊时间起" field="DATE_BEGIN" sortable="true" width="10%">
			<next:TextField />
		</next:Column>
		<next:Column id="dateEnd" header="就诊时间止" field="DATE_END" sortable="true" width="10%">
			<next:TextField />
		</next:Column>
		<next:Column id="totalExpense" header="总费用（元）" field="TOTAL_EXPENSE"  hidden="true" align="right" width="14%">
			<next:TextField />
		</next:Column>
		<next:Column id="hospitalPay" header="医院减免金额（元）" field="HOSPITAL_PAY" hidden="true" align="right"  width="18%">
			<next:TextField />
		</next:Column>
		<next:Column id="specialPay" header="优抚补助金额（元）" field="SPECIAL_PAY" hidden="true"  align="right"  width="18%">
			<next:TextField />
		</next:Column>
		<next:Column id="sign"  header="是否已提交" field="SIGN" sortable="true"  width="10%">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
			<next:PagingToolBar dataset="ds"  />
	</next:BottomBar>
</next:GridPanel>
<next:Window id="door_rule" title="门规信息"  width="800" height="450" closeAction="hide" resizable="true" autoScroll="false" animCollapse="true">
	<next:FitLayout>
	<next:Panel id="rule_pan" autoScroll="true" collapsible="true" width="100%">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="确定" iconCls="select" handler="save_win"></next:ToolBarItem>
			<next:ToolBarItem text="关闭"  iconCls="delete" handler="close_win"></next:ToolBarItem>
		</next:TopBar>
		<next:Panel id="query_mess" collapsible="true" autoWidth="true">
			<next:Html>
				<form class="L5form" >
				<table  width="100%">
					<tr>
						<td class="FieldLabel"  width="15%">身份证号码：</td>
						<td class="FieldInput"  width="25%">
							<input type="text" id="wIdCard" maxlength="18"  style="width:95%"/> 
						</td>
						<td class="FieldLabel" width="15%">姓名：</td>
						<td class="FieldInput" width="25%">
							<input type="text" id="wName" maxlength="25" /> 
						</td>
						<td class="FieldButton" width="20%"><button onclick="queryPeople();">查 询</button></td>	
					</tr>
					<tr>
						<td class="FieldLabel">优抚类型：</td>
						<td class="FieldInput">
							<select  id="wType"  style="width:95%"><option dataset="typeDS"></option></select> 
						</td>
						<td class="FieldLabel">证件编号：</td>
						<td class="FieldInput">
							<input type="text" id="wCode"  maxlength="20"/> 
						</td>
						<td class="FieldButton" ><button type="reset">重 置</button></td>	
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
		<next:Panel id="mess_panel" autoWidth="true" autoScroll="true"  collapsible="true" title="就诊详细信息">
		<next:Html>
			<form class="L5form" dataset="ds2">
				<table width="100%">
					<tr>
						<td class="FieldLabel" width="15%">身份证号码：</td>
						<td class="FieldInput" width="20%">
							<label id="idCard" name="身份证号码：" ></label>
						</td>
						<td class="FieldLabel" width="20%">姓名：</td>
						<td class="FieldInput" width="15%">
							<label id="name" name="姓名：" ></label>
						</td>
						<td class="FieldLabel" width="15%">性别:</td>
						<td class="FieldInput" width="15%">
							<label id="sex" ></label>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">年龄：</td>
						<td class="FieldInput">
							<label id="age"></label>
						</td>
						<td class="FieldLabel">优抚类别：</td>
						<td class="FieldInput" colspan="3">
							<label id="bptType"></label>
						</td>	
					</tr>
					<tr >
						<td class="FieldLabel">就诊时间起：</td>
						<td class="FieldInput">
							<input type="text" id="dateBegin" name="就诊时间起：" field="dateBegin"  format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly" style="width:85%"/>
							<font color="red">*</font>
						</td>
						<td class="FieldLabel">就诊时间止：</td>
						<td class="FieldInput">
							<input type="text" id="dateEnd" name="就诊时间止：" field="dateEnd" format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly" style="width:85%"/>
							<font color="red">*</font>
						</td>
						<td class="FieldLabel">总费用（元）：</td>
						<td class="FieldInput">
							<input type="text" id="totalExpense" name="总费用：" onblur="changeTwo(this.value);" field="totalExpense" maxlength="16" style="width:85%"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">医院减免金额（元）：</td>
						<td class="FieldInput">
							<input type="text" id="hospitalPay" name="医院减免金额：" onblur="changeTwo1(this.value);" field="hospitalPay" style="width:85%" maxlength="16"/>
							<font color="red">*</font>
						</td>
						<td class="FieldLabel">优抚补助金额（元）：</td>
						<td class="FieldInput">
							<input type="text" id="specialPay" name="优抚补助金额：" onblur="changeTwo2(this.value);" field="specialPay"  maxlength="16" style="width:85%"/>
							<font color="red">*</font>
						</td>
						<td class="FieldLabel">自付费用（元）：</td>
						<td class="FieldInput">
							<input type="text" id="personalPay" name="自付费用：" onblur="changeTwo3(this.value);" field="personalPay"  maxlength="16" style="width:85%"/>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">人次：</td>
						<td class="FieldInput">
							<input type="text" id="num" name="人次：" field="num" maxlength="16" style="width:85%" maxlength="16" />
							<font color="red">*</font>
						</td>
						<td class="FieldLabel">门诊医师：</td>
						<td class="FieldInput">
							<input type="text" id="doctor" name="门诊医师：" field="doctor" maxlength="15" style="width:85%"/>
							<font color="red">*</font>
						</td>
						<td class="FieldLabel"></td>
						<td class="FieldInput"></td>
					</tr>
					<tr>
						<td class="FieldLabel">门诊诊断：</td>
						<td class="FieldInput" colspan="5">
							<textArea type="text" id="diagnosis" name="门诊诊断：" field="diagnosis"  cols="2" rows="5" style="width:95%;" lang="250"></textArea>
						<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td class="FieldInput" colspan="6">
							<font color=red>门诊诊断字数，不能超过500个字符，一个汉字占两个字符！ </font>
						</td>
					</tr>
				</table>
			</form>
		</next:Html>
		</next:Panel>
	</next:Panel>
	</next:FitLayout>
</next:Window>
<next:Window id="rule_detail" title="门规信息"  width="750" height="320" closeAction="hide" closeAction="hide" resizable="true"  animCollapse="true">
	<next:Panel id="detail_rule" autoScroll="true" widget="100%" height="100%" collapsible="true">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="关闭" iconCls="delete" handler="detail_rule"></next:ToolBarItem>
		</next:TopBar>
		<next:Html>
			<form class="L5form" dataset="ds3">
				<table width="100%">
					<tr>
						<td class="FieldLabel" width="15%">身份证号码：</td>
						<td class="FieldInput" width="20%">
							<label id="didCard" field="ID_CARD"></label>
						</td>
						<td class="FieldLabel" width="15%">姓名：</td>
						<td class="FieldInput" width="20%">
							<label id="rname" field="NAME"></label>
						</td>
						<td class="FieldLabel" width="15%">性别:</td>
						<td class="FieldInput" width="15%">
							<label id="rsex" field="SEX"></label>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">年龄：</td>
						<td class="FieldInput">
							<label id="rage" field="AGE"></label>
						</td>
						<td class="FieldLabel">优抚类别：</td>
						<td class="FieldInput" colspan="3">
							<label id="rbptType" field="BPT_TYPE"></label>
						</td>	
					</tr>
					<tr >
						<td class="FieldLabel">就诊时间起：</td>
						<td class="FieldInput">
							<label id="dateBegin" name="就诊时间起：" field="DATE_BEGIN"  ></label>
						</td>
						<td class="FieldLabel">就诊时间止：</td>
						<td class="FieldInput">
							<label id="dateEnd" name="就诊时间止：" field="DATE_END" ></label>
						</td>
						<td class="FieldLabel">总费用：</td>
						<td class="FieldInput">
							<label id="totalExpense" name="总费用：" field="TOTAL_EXPENSE" ></label>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">医院减免金额（元）：</td>
						<td class="FieldInput">
							<label id="hospitalPay" name="医院减免金额：" field="HOSPITAL_PAY" ></label>
						</td>
						<td class="FieldLabel">优抚补助金额（元）：</td>
						<td class="FieldInput">
							<label id="specialPay" name="优抚补助金额：" field="SPECIAL_PAY" ></label>
						</td>
						<td class="FieldLabel">自付费用（元）：</td>
						<td class="FieldInput">
							<label id="personalPay" name="自付费用：" field="PERSONAL_PAY" ></label>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">人次：</td>
						<td class="FieldInput">
							<label id="num" name="人次：" field="NUM" ></label>
						</td>
						<td class="FieldLabel">门诊医师：</td>
						<td class="FieldInput">
							<label id="doctor" name="门诊医师：" field="DOCTOR" ></label>
						</td>
						<td class="FieldLabel"></td>
						<td class="FieldInput"></td>
					</tr>
					<tr>
						<td class="FieldLabel">门诊诊断：</td>
						<td class="FieldInput" colspan="5">
							<textArea type="text" id="diagnosis" name="门诊诊断：" field="DIAGNOSIS"  cols="2" rows="5" readonly="readonly" style="width:98%;"></textArea>
						</td>
					</tr>
				</table>
			</form>
		</next:Html>
	</next:Panel>
</next:Window>
<next:Window id="people_help" title="帮助信息"  width="600" height="260" collapsible="true" closeAction="hide">
	<next:FitLayout>
	<next:GridPanel id="base_people" name="base_people" width="100%" disableSelection="true" stripeRows="true" notSelectFirstRow="true" collapsible="true" height="90%" autoScroll="true" dataset="basePeopleDs2">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="select" text="确定" handler="add_people"/>
				<next:ToolBarItem iconCls="delete" text="关闭" handler="close_help"/>
			</next:TopBar>
				<next:Columns>		
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="hpeopleId" header="人员Id" field="peopleId" hidden="true" width="10" >
					</next:Column>
					<next:Column id="hname" header="姓名" field="name"   width="9%"  >
					</next:Column>
					<next:Column id="hidCard" header="身份证号" field="idCard" width="20%" >
					</next:Column>
					<next:Column id="hsex" header="性别" field="sex" dataset="sexDS" width="8%"  >
					</next:Column>
					<next:Column id="address" header="住址" field="address" hidden="true" width="20%"  >
					</next:Column>		
					<next:Column id="readFlag" header="三红" field="readFlag" hidden="true" width="10" >
					</next:Column>
					<next:Column id="disabilityFlag" header="伤残等级" field="disabilityFlag" hidden="true" width="10" >
					</next:Column>
					<next:Column id="disabilityLevelCode" header="伤残" field="disabilityLevelCode" hidden="true" width="10" >
					</next:Column>
					<next:Column id="dependantFlag" header="遗嘱" field="dependantFlag" hidden="true" width="10" >
					</next:Column>
					<next:Column id="demobilizedFlag" header="在乡复员军人" field="demobilizedFlag" hidden="true" width="10" >
					</next:Column>
					<next:Column id="warFlag" header="参战参试" field="warFlag" hidden="true" width="10" >
					</next:Column>
				</next:Columns> 
				<next:BottomBar>
					<next:PagingToolBar dataset="basePeopleDs2"/>
				</next:BottomBar>
		</next:GridPanel>
		</next:FitLayout>
</next:Window>
</body>
</html>