<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>福利企业审批</title>
<%
	String taskCode = (String) request.getParameter("taskCode");
	if (taskCode == null) {
		taskCode = IdHelp.getUUID32();
	}
%>
<next:ScriptManager />
<script type="text/javascript" src="../../../common/js/float.js"></script>
<link href="../css/welfarecorpapply2.css" type="text/css" rel="stylesheet" />
<script type="text/javascript">
 	var taskCode='<%=taskCode%>';
 	function init(){
 		var wealUnitInfoDataSet = L5.DatasetMgr.lookup("wealUnitInfoDataSet");
 		wealUnitInfoDataSet.setParameter("TASK_CODE@=", taskCode);
 		wealUnitInfoDataSet.load();
 		wealUnitInfoDataSet.on("load",function(ds){
 			if(ds.getCount()==0){
				wealUnitInfoDataSet.newRecord();
			}
 		});
 	}
	//明细页面翻页功能键
	function backPage(){
		var data = new L5.Map();
		var url='jsp/cams/welfare/welfarecorp/yearlyCheck/info/welfarecorpapply1Detail.jsp';
		data.put("taskCode",taskCode);
		var text = '网上申报';
		L5.forward(url,text,data);
	}

	function nextPage(){
		var data = new L5.Map();
		var url='jsp/cams/welfare/welfarecorp/yearlyCheck/info/welfarecorpapply3Detail.jsp';
		data.put("taskCode",taskCode);
		var text = '网上申报';
		L5.forward(url,text,data);
	}
	function lastPage(){
		var data = new L5.Map();
		var url='jsp/cams/welfare/welfarecorp/yearlyCheck/info/welfarecorpapply1Detail.jsp';
		data.put("taskCode",taskCode);
		var text = '网上申报';
		L5.forward(url,text,data);
	}
	function showWorkerDetailWin(){
 		var width = 1200;
		var height = 650;
		var url="wealworkerDetail.jsp?taskCode="+taskCode;
		var reValue=window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
 	}
</script>
</head>

<body>
<model:datasets>
	<!-- 业务表 -->
	<model:dataset id="wealUnitInfoDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealUnitInfoQueryCommand">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitInfo"></model:record>
	</model:dataset>
</model:datasets>
<div id="float">
	 <input field="" type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPage()" /> 
	 <input field="" type="button" value="上一页" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="lastPage()" />
	 <input field="" type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="backPage();"/>
</div>


<form method="post" onsubmit="return false"
	dataset="wealUnitInfoDataSet">
<table id="tb1" align="center" class=tb1><tr><td>
	<TABLE height=629 cellSpacing=0 cellPadding=0 style="border-collapse:collapse" width=800 align=center
		id="tab" border=1 bordercolor="black">
		<TBODY>
			<tr>
				<td colspan="10"><font font-family="黑体" size="5px">一、企业基本情况</font></td>
			</tr>
			<tr>
				<td align="center" colspan="1" height="30px">法人代表</td>
				<td colspan="1">
					<label vname="法人代表" type="text" id="legalPeople" field="legalPeople"  /><font color="red">*</font>
				</td>
				<td align="center" colspan="1">联系电话</td>
				<td colspan="4">
					<label type="text" vname="联系电话" id="legalPhone" field="legalPhone"  /><font color="red">*</font>
				</td>
			</tr>
			<tr>
				<td align="center" colspan="1" height="30px">地址</td>
				<td colspan="9">
					<label type="text" vname="地址" id="address" field="address" size=70  /><font color="red">*</font>
				</td>
			</tr>
			<tr>
				<td align="center" height="30px">资格认定时间</td>		
				<td>
					<label type="text" vname="资格认定时间"   readonly="readonly" format="Y-m-d" id="regDate" field="regDate"  /><font color="red">*</font>
				</td>
				<td align="center">年末职工总数<br>
					<input id="showWorker" value="职工信息" type="button"
						onclick="showWorkerDetailWin()" /></td>			
				<td colspan="4">
					<label type="text" id="workersAll" vname="年末职工总数" field="workersAll"  /><font color="red">*</font>
				</td>
			</tr>
			<tr>
				<td rowspan="2" align="center" >其中</td>
				<td align="center">健全职工</td>
				<td colspan="4" height="30px">
					<label type="text" vname="健全职工" id="workersHealth" field="workersHealth"  /><font color="red">*</font>
				</td>
			</tr>
			<tr>
				<td align="center">残疾职工</td>
				<td colspan="4" height="30px">
					<label type="text" vname="残疾职工" id="workersDeform" field="workersDeform"  /><font color="red">*</font>
				</td>
			</tr>
			
			<tr>
				<td rowspan="3" align="center" >残疾职工情况</td>
				<td align="center" height="30px">肢体残疾</td>
				<td><label type="text" vname="肢体残疾" id="workersDeformLimb" field="workersDeformLimb"  /><font color="red">*</font></td>
				<td align="center" height="30px">听力残疾</td>
				<td><label style="width:130px" id="workersDeformHear" vname="听力残疾"  field="workersDeformHear"  /><font color="red">*</font></td>
			</tr>
			<tr>
				<td align="center" height="30px">视力残疾</td>
				<td><label type="text" id="workersDeformEye" vname="视力残疾" field="workersDeformEye"  /><font color="red">*</font></td>
				<td align="center" height="30px">综合残疾</td>
				<td><label type="text" style="width:130px" id="workersDeformMulti" vname="综合残疾" field="workersDeformMulti"  /><font color="red">*</font></td>
			</tr>
			<tr>
				<td align="center">残疾职工占职工总数比例%</td>
				<td colspan="4"><label type="text" id="scaleLimb" vname="残疾职工占职工总数比例" field="scaleLimb"  /><font color="red">*</font></td>
			</tr>
			<tr>
				<td align="center" height="30px">主营</td>
				<td><label type="text" id="firstScope" vname="主营" field="firstScope"  /><font color="red">*</font></td>
				<td align="center">主要产品</td>
				<td colspan="4"><label type="text" id="mainGoods" vname="主要产品" field="mainGoods"  /><font color="red">*</font></td>
			</tr>
			<tr>
				<td align="center" height="30px">注册资金</td>
				<td><label type="text" id="regFund" field="regFund" vname="注册资金"  /><font color="red">*</font></td>
				<td align="center">工商登记</td>
				<td colspan="4"><label type="text" id="licenseCode" field="licenseCode" vname="工商登记"  /><font color="red">*</font></td>
			</tr>
			<tr>
				<td align="center" height="30px">国税登记</td>
				<td><label type="text" id="nationtaxReg" field="nationtaxReg" vname="国税登记"  /><font color="red">*</font></td>
				<td align="center">地税登记</td>
				<td colspan="4"><label type="text" id="landtaxReg" field="landtaxReg" vname="地税登记"  /><font color="red">*</font></td>
			</tr>
			<tr>
				<td align="center" height="30px">开户银行</td>
				<td><label type="text" id="bank" field="bank" vname="开户银行"  /><font color="red">*</font></td>
				<td align="center">银行账号</td>
				<td colspan="4"><label type="text" id="accountNo" vname="银行账号" field="accountNo"  /><font color="red">*</font></td>
			</tr>
			<tr><td colspan="10"><font font-family="黑体" size="5">二、当年财务、纳税及减免情况</font></td></tr>
			<tr>
				<td align="center" height="30px">固定资产原值(万元)</td>
				<td><label type="text" id="assets" field="assets" vname="固定资产原值"  /><font color="red">*</font></td>
				<td align="center">营业收入(万元)</td>
				<td colspan="4"><label type="text" id="incomeBusiness" vname="营业收入" field="incomeBusiness"  /><font color="red">*</font></td>
			</tr>
			<tr>
				<td align="center" height="30px">费用合计(万元)</td>
				<td><label type="text" id="allcost" field="allcost" vname="费用合计"  /><font color="red">*</font></td>
				<td align="center">营业利润(万元)</td>
				<td colspan="4"><label type="text" id="gainBusiness" vname="营业利润" field="gainBusiness"  /><font color="red">*</font></td>
			</tr>
			<tr>
				<td align="center" height="30px">企业单位增加值(万元)</td>
				<td><label type="text" id="addingvalue" field="addingvalue" vname="企业单位增加值"  /><font color="red">*</font></td>
				<td align="center">纳税总额(万元)</td>
				<td colspan="4"><label type="text" id="taxAll" field="taxAll" vname="纳税总额"  /><font color="red">*</font></td>
			</tr>
			<tr>
				<td align="center" height="30px">增值税总额(万元)</td>
				<td><label type="text" id="taxAdded" field="taxAdded" vname="增值税总额"  /><font color="red">*</font></td>
				<td align="center">营业税总额(万元)</td>
				<td colspan="4"><label type="text" id="taxBusiness" vname="营业税总额" field="taxBusiness"  /><font color="red">*</font></td>
			</tr>
			<tr>
				<td align="center" height="30px">所得税总额(万元)</td>
				<td><label type="text" vname="所得税总额" id="taxIncome" field="taxIncome"  /><font color="red">*</font></td>
				<td align="center">应减免税总额(万元)</td>
				<td colspan="4"><label type="text" vname="应减免税总额" id="taxShouldReduce" field="taxShouldReduce"  /><font color="red">*</font></td>
			</tr>
			<tr>
				<td align="center" height="30px">实际减免税总额(万元)</td>
				<td><label type="text" vname="实际减免税总额" id="taxFactReduce" field="taxFactReduce"  /><font color="red">*</font></td>
				<td align="center">盈利总额(万元)</td>
				<td colspan="4"><label type="text" vname="盈利总额" id="profit" field="profit"  /><font color="red">*</font></td>
			</tr>
			<tr><td colspan="10"><font font-family="黑体" size="5" >三、当年劳动、工资及福利</font></td></tr>
			<tr>
				<td align="center" height="30px">所有区县使用最低月工资标准(元)</td>
				<td><label type="text" vname="所有区县使用最低月工资标准" id="lowWageCounty" field="lowWageCounty"  /><font color="red">*</font></td>
				<td align="center">残疾职工最低月工资含保险等(元)</td>
				<td colspan="4"><label type="text" vname="残疾职工最低月工资含保险等" id="lowWageDeform" field="lowWageDeform"  /><font color="red">*</font></td>
			</tr>
			<tr>
				<td align="center" height="30px" >职工人均年收入(元)</td>
				<td><label type="text" vname="职工人均年收入" id="incomePerworkerYear" field="incomePerworkerYear"  /><font color="red">*</font></td>
				<td align="center" >残疾职工人均年收入(元)</td>
				<td colspan="4"><label type="text" vname="残疾职工人均年收入" id="incomePerdedormYear" field="incomePerdedormYear"  /><font color="red">*</font></td>
			</tr>
			<tr>
				<td align="center" height="30px">参加养老保险残疾职工数</td>
				<td><label type="text" vname="参加养老保险残疾职工数" id="workersDeformSecurity" field="workersDeformSecurity"  /><font color="red">*</font></td>
				<td align="center">参加医疗保险残疾职工数</td>
				<td colspan="4"><label type="text" vname="参加医疗保险残疾职工数" id="workersDeformMedical" field="workersDeformMedical"  /><font color="red">*</font></td>
			</tr>
			<tr>
				<td align="center" height="30px">参加失业保险残疾职工数</td>
				<td><label type="text" id="workersDeformUnemployed" field="workersDeformUnemployed"  vname="参加失业保险残疾职工数" /><font color="red">*</font></td>
				<td align="center">参加工伤保险残疾职工数</td>
				<td colspan="4"><label type="text" vname="参加工伤保险残疾职工数" id="workersDeformInjury" field="workersDeformInjury"  /><font color="red">*</font></td>
			</tr>
			<tr>
				<td align="center" height="30px">签订用工合同残疾职工数</td>
				<td><label type="text" vname="签订用工合同残疾职工数" id="workersDeformPact" field="workersDeformPact"  /><font color="red">*</font></td>
				<td align="center">通过金融机构发放工资残疾职工数</td>
				<td colspan="4"><label type="text" vname="通过金融机构发放工资残疾职工数" id="workersDeformPaybybank" field="workersDeformPaybybank"  /><font color="red">*</font></td>
			</tr>
			<tr>
				<td colspan="10"><font font-family="黑体" size="5" >四、当年减免税金管理及使用情况</font></td>
			</tr>
			<tr>
				<td align="center" height="30px">当年减免税金额</td>
				<td colspan="6"><label style="width:100px" vname="当年减免税金额" id="taxReduce" field="taxReduce"  />(元)<font color="red">*</font></td>
			</tr>
			<tr>
				<td rowspan="2" align="center">使用情况:</td>
				<td colspan="7" align="left" height="30px">1，用于福利和各类保险 
					<label type="text" id="taxReduceWeal" vname="用于福利和各类保险" field="taxReduceWeal"  />(元)<font color="red">*</font></td>
			</tr>
			<tr>
				<td colspan="7" align="left">2，用于社会福利事业捐赠
					<label type="text" vname="用于社会福利事业捐赠" id="taxReduceDonate" field="taxReduceDonate"  />(元)<font color="red">*</font></td>
			</tr>
		</TBODY>
	</TABLE>
</td></tr>
<tr valign=bottom>
	<td height='27' valign=bottom align=center>2</td>
</tr>
</table>
</form>
<div id="float">
	 <input field="" type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPage()" /> 
	 <input field="" type="button" value="上一页" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="lastPage()" />
	 <input field="" type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="backPage();"/>
</div>
</body>
</html>
