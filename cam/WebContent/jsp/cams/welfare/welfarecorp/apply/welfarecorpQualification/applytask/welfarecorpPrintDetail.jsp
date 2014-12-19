<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<%
	String taskCode = (String)request.getParameter("taskCode");
	if(taskCode==null){
		taskCode=IdHelp.getUUID32();
	}
	//行政区划
	//String organArea=BspUtil.getCorpOrgan().getOrganCode();

%>
<next:ScriptManager />
<link href="../css/welfarecorpPrint.css" type="text/css" rel="stylesheet" />
<style type="text/css"> 
	label {
		font-size: 14.0pt;
		font-family: 宋体;
	} 
</style> 

<script type="text/javascript">
 	var taskCode='<%=taskCode%>';
 	var cpIndex=1;
 	function init(){
 		var wealUnitInfoDataSet = L5.DatasetMgr.lookup("wealUnitInfoDataSet");
 		wealUnitInfoDataSet.setParameter("TASK_CODE@=", taskCode);
 		wealUnitInfoDataSet.load();
 		wealUnitInfoDataSet.on("load",function(ds){
 			if(ds.getCount()==0){
				wealUnitInfoDataSet.newRecord();
 			}else{
				queryWorker();
			}
 		});
 		//生产能力信息
		var wealFitProductivepowerDataSet = L5.DatasetMgr.lookup("wealFitProductivepowerDataSet");
		wealFitProductivepowerDataSet.setParameter("TASK_CODE@=", taskCode);
		wealFitProductivepowerDataSet.load();
		wealFitProductivepowerDataSet.on('load',function(ds){
			var productValueTotle=0;
			if(ds.getCount()>0){
				for(var i=0;i<ds.getCount();i++){
					var otr=pntable.insertRow();//插入一个tr 
			 		 var ocel1=otr.insertCell(0);//插入一个td   
			 		 ocel1.innerHTML="<div align='center'><label  id='productName"+i+"' /></div>";  
			 		 var otrrr=pvtable.insertRow();
			 		 var ocel3=otrrr.insertCell(0);
			 		 ocel3.innerHTML="<div align='center'><label  id='productValue"+i+"' name='productValue'/></div>";
			 		if(ds.getCount()!=i+1){
			 			ocel1.className="td";
			 			ocel3.className="td";
			 		 }
					document.getElementById("productName"+i).innerHTML=ds.getAt(i).get('productName');
					document.getElementById("productValue"+i).innerHTML=ds.getAt(i).get('productValue');
					productValueTotle+=ds.getAt(i).get('productValue');
					
					cpIndex=1;
					cpIndex=cpIndex+ds.getCount();
				}
				
			}
			document.getElementById("productValueT").innerHTML=productValueTotle+" 万元";
		});
 	}
 	function queryWorker(){
 		//职工统计信息
		var command = new L5.Command("com.inspur.cams.welfare.welfarecorp.apply.cmd.UnitWorkerQueryCmd");
		command.setParameter("taskCode", taskCode);
		command.execute("queryUnitWorkerSum");
		var totalNum=command.getReturn("totalNum");
		var disNum=command.getReturn("disNum");
		var noProNum=command.getReturn("noProNum");
		var proNum=command.getReturn("proNum");
				
		document.getElementById("totalNum").innerHTML=totalNum==null?"0":totalNum;
		document.getElementById("disNum").innerHTML=disNum==null?"0":disNum;
		document.getElementById("noProNum").innerHTML=noProNum==null?"0":noProNum;
		document.getElementById("proNum").innerHTML=proNum==null?"0":proNum;
				
		//残疾职工明细信息
		command.execute("queryUnitWorkerDisability");
		var slcj=command.getReturn("slcj");
		var tlcj=command.getReturn("tlcj");
		var yycj=command.getReturn("yycj");
		var ztcj=command.getReturn("ztcj");
		var zljscj=command.getReturn("zljscj");
				
		document.getElementById("slcj").innerHTML=slcj==null?"0":slcj;
		document.getElementById("tlcj").innerHTML=tlcj==null?"0":tlcj;
		document.getElementById("yycj").innerHTML=yycj==null?"0":yycj;
		document.getElementById("ztcj").innerHTML=ztcj==null?"0":ztcj;
		document.getElementById("zljscj").innerHTML=zljscj==null?"0":zljscj;
 	}
 	function MakeWord()
 	{
 	var word = new ActiveXObject("Word.Application");
 	// var doc = word .documents.open("c:test.doc");     //此处为打开已有的模版
 	var doc = word .Documents.Add("",0,0);//不打开模版直接加入内容
 	var   Range=doc.Range();
 	var sel = document.body.createTextRange();
 	sel.moveToElementText(form0);//此处form是页面form的id
 	sel.select();
 	sel.execCommand("Copy");
 	Range.Paste();
 	
 	/* var selection = word.Selection;
 	//selection.InsertBreak(7);
 	selection.Font.Size = 10;
　　　　//ctrl+A 全选操作
　　　　selection.WholeStory();
　　　　//清除格式
　　　　selection.Find.ClearFormatting(); */

 	
 	
 	
 	Range =doc.Range(Range.End-1,Range.End);
 	var sel = document.body.createTextRange();
 	sel.moveToElementText(form);//此处form是页面form的id
 	sel.select();
 	sel.execCommand("Copy");
 	Range.Paste();
 	//Range.InsertAfter();
 	//word.ActiveWindow.View.TableGridlines = false;
 	
 	word .Application.Visible = true;
 	sel.collapse(true);
	sel.select();
 	/* alert("s");
 	word.Application.Selection.InlineShapes.AddPicture("c:\m20.gif");
 	alert("n");
 	doc .saveAs("c:\ba.doc");     //存放到指定的位置注意路径一定要是“\”不然会报错 */
 	}
</script>

</head>

<body>
<model:datasets>
	<!-- 业务表 -->
	<model:dataset id="wealUnitInfoDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealUnitInfoQueryCommand">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitInfo"></model:record>
	</model:dataset>
	<!-- 经济性质字典表 -->
	<model:dataset id="ecoDataSet"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='WEAL_DIC_ECONOMICNATURE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 生产能力信息 -->
	<model:dataset id="wealFitProductivepowerDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitProductivepowerQueryCommand"  global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitProductivepower"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" >
	<input field="" type="button" value="word" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="MakeWord();"/>

</div>
<form id="form0" method="post"  onsubmit="return false">
<TABLE height=600 cellSpacing=0 cellPadding=0 width=700 align=center
	border=0>
	<TBODY>
		<TR>
			<TD width=671 height=80>&nbsp;</TD>
		</TR>
		<TR>
			<TD vAlign=top height=597>
			<TABLE height=677 cellSpacing=0 cellPadding=0 width=668 align=center dataset="wealUnitInfoDataSet"
				border=0>
				<TBODY>
					<TR>
						<TD width='668' height=34 align=right class=title3><STRONG>编号：鲁福企字第（<label  field="serialNum" id='serialNum' style='font-size: 14.0pt; font-family: 宋体'></label>）号
						</STRONG></TD>
					</TR>
					<TR>
						<TD class=title1 vAlign=top align=middle height=150>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD height=150></TD>
								</TR>
							</TBODY>
						</TABLE>
						<DIV align=center></DIV>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD width='600' height=34 align=middle class=title1><STRONG>社会福利企业
									</STRONG></TD>
								</TR>
								<TR>
									<TD height=50></TD>
								</TR>
								<TR>
									<TD width='600' height=34 align=middle class=title1><STRONG>资格认定申请表
									</STRONG></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
		<TR>
			<TD height=150>
			<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0 dataset="wealUnitInfoDataSet">
				<TBODY>
					<TR >
						<TD width="20%" align="left" height=150>&nbsp;</TD>
						<TD  align="left" class=title3 width="200"><STRONG>企业名称（章）： </STRONG></TD>
						<TD height=40 colspan='4'><label 
							name='企业名称' field="companyName" style='font-size: 14.0pt; font-family: 宋体' id='companyName' SIZE='70' MAXLENGTH='72'/></TD>
					</TR>
					<TR>
						<TD height=150 align="left">&nbsp;</TD>
						<TD class=title3 align="left"><br>
						<STRONG>法&nbsp;人&nbsp;代&nbsp;表&nbsp;：</STRONG></TD>
						<TD height=40 colspan='4' align="left" ><label 
							name='法人代表' style='font-size: 14.0pt; font-family: 宋体' field="legalPeople" id='legalPeople'
							height=40 SIZE='70' MAXLENGTH='72'/></TD>
					</TR>
					<TR>
						<TD height=150 align="left">&nbsp;</TD>
						<TD class=title3 align="left"><STRONG>填&nbsp;表&nbsp;时&nbsp;间&nbsp;：</STRONG></TD>
						<td height=40 colspan='4'>
						<label name='填表时间' field="regDate" id='regDate' style='font-size: 14.0pt; font-family: 宋体' height=40 /></td>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
		<TR>
			<TD align="middle" height=100 class="title3" style="font-size: 25px"><strong>山东省民政厅监制</strong>
			</TD>
		</TR>
		<tr valign=bottom>
			<td height='27' valign=bottom align=center>第1页</td>
		</tr>
	</TBODY>
</TABLE>
</form>

<form method="post" onsubmit="return false"
	dataset="wealUnitInfoDataSet">
<TABLE height=629 cellSpacing=0 id="form" cellPadding=0 width=668 align=center
	id="tab" border=0>
	<TBODY>
		<TR>
			<TD class=title1 align=middle height=67>&nbsp;</TD>
		</TR>
		<TR>
			<TD align="middle" height=40 class="title3"><br>
			<br>
			</TD>
		</TR>
		<TR >
			<TD vAlign=top height=522>
			<table border=0 cellpadding=0 cellspacing=0 width=690
				style='border-collapse: collapse; table-layout: fixed; width: 520pt'
				class=unnamed1>
				<col width=53 span=11 style='width: 40pt'>
				<col width=107
					style='mso-width-source: userset; mso-width-alt: 3424; width: 80pt'>
				<tr height=45 style='mso-height-source: userset; height: 33.95pt'>
					<td colspan=2 class=unnamed1 height=45 width=106
						style='height: 33.95pt; width: 80pt'>
					<div align="center">企业名称</div>
					</td>
					<td colspan=11 class=unnamed1 width=584
						style='border-left: none; width: 440pt'>
					<div align="left"><label type="text" vname="企业名称"
						id="companyName" field="companyName" size=70 /><font color="red">*</font>
					</div>
					</td>
				</tr>
				<tr height=45 style='mso-height-source: userset; height: 33.95pt'>
					<td colspan=2 height=45 class=unnamed1 style='height: 33.95pt'>
					<div align="center">通讯地址</div>
					</td>
					<td colspan=6 class=unnamed1 style='border-left: none'>
					<div align="left"><label type="text" vname="通讯地址"
						id="address" field="address" size=50 /><font color="red">*</font>
					</div>
					</td>
					<td colspan=2 class=unnamed1 style='border-left: none'>
					<div align="center">邮编</div>
					</td>
					<td colspan=3 class=unnamed1 style='border-left: none'>
					<div align="left"><label type="text" vname="邮编" id="postCode"
						field="postCode" /><font color="red">*</font></div>
					</td>
				</tr>
				<tr height=45 style='mso-height-source: userset; height: 33.95pt'>
					<td colspan=2 height=45 class=unnamed1 style='height: 33.95pt'>
					<div align="center">法定代表人</div>
					</td>
					<td colspan=4 class=unnamed1 style='border-left: none'>
					<div align="left"><label type="text" vname="法人"
						id="legalPeople" field="legalPeople" /></div>
					</td>
					<td colspan=2 class=unnamed1 style='border-left: none'>
					<div align="center">身份证号</div>
					</td>
					<td colspan=4 class=unnamed1 style='border-left: none'>
					<div align="left"><label type="text" vname="法人身份证号"
						id="legalIdCard" field="legalIdCard" /></div>
					</td>
				</tr>
				<tr height=45 style='mso-height-source: userset; height: 33.95pt'>
					<td colspan=2 height=45 class=unnamed1 style='height: 33.95pt'>
					<div align="center">固定电话</div>
					</td>
					<td colspan=4 class=unnamed1 style='border-left: none'>
					<div align="left"><label type="text" vname="法人固定电话"
						id="legalPhone" field="legalPhone" /></div>
					</td>
					<td colspan=2 class=unnamed1 style='border-left: none'>
					<div align="center">手机</div>
					</td>
					<td colspan=4 class=unnamed1 style='border-left: none'>
					<div align="left"><label type="text" vname="法人手机"
						id="legalTelphone" field="legalTelphone" /></div>
					</td>
				</tr>
				<tr height=45 style='mso-height-source: userset; height: 33.95pt'>
					<td colspan=2 height=45 class=unnamed1 style='height: 33.95pt'>
					<div align="center">经办人</div>
					</td>
					<td colspan=5 class=unnamed1 style='border-left: none'>
					<div align="left"><label type="text" vname="经办人"
						id="agentPeople" field="agentPeople" /><font color="red">*</font></div>
					</td>
					<td colspan=2 class=unnamed1 style='border-left: none'>
					<div align="center">联系电话</div>
					</td>
					<td colspan=4 class=unnamed1 style='border-left: none'>
					<div align="left"><label type="text" vname="联系电话"
						id="agentPhone" field="agentPhone" /><font color="red">*</font></div>
					</td>
				</tr>
				<tr height=45 style='mso-height-source: userset; height: 33.95pt'>
					<td colspan=2 height=45 class=unnamed1 style='height: 33.95pt'>
					<div align="center">电子邮箱</div>
					</td>
					<td colspan=11 class=unnamed1 style='border-left: none'>
					<div align="left"><label type="text" vname="电子邮箱"
						id="agentEmail" field="agentEmail" size=50 /><font color="red">*</font>
					</div>
					</td>
				</tr>
				<tr height=45 style='mso-height-source: userset; height: 33.95pt'>
					<td colspan=2 height=45 class=unnamed1 style='height: 33.95pt'>
					<div align="center">网站地址</div>
					</td>
					<td colspan=11 class=unnamed1 style='border-left: none'>
					<div align="left"><label type="text" vname="网站地址"
						id="webAddress" field="webAddress" size=50 /><font color="red">*</font>
					</div>
					</td>
				</tr>
				<tr height=45 style='mso-height-source: userset; height: 33.95pt'>
					<td colspan=2 height=45 class=unnamed1 style='height: 33.95pt'>
					<div align="center">经济性质</div>
					</td>
					<td colspan=4 class=unnamed1 style='border-left: none'><label
						id=economicNatureCode field="economicNatureCode" dataset="ecoDataSet" vname="经济性质">
					</label></td>
					<td colspan=3 class=unnamed1 width=106
						style='border-left: none; width: 80pt'>
					<div align="center">组织机<br />
					构代码</div>
					</td>
					<td colspan=4 class=unnamed1 style='border-left: none'>
					<div align="left"><label type="text" vname="组织机构代码"
						id="organCode" field="organCode" /><font color="red">*</font></div>
					</td>
				</tr>
				<tr height=45 style='mso-height-source: userset; height: 33.95pt'>
					<td colspan=2 height=45 class=unnamed1 width=106
						style='height: 33.95pt; width: 80pt'>
					<div align="center">营业执照<br />
					编&nbsp;&nbsp;号</div>
					</td>
					<td colspan=4 class=unnamed1 style='border-left: none'>
					<div align="left"><label type="text" vname="营业执照编号"
						id="licenseCode" field="licenseCode" /><font color="red">*</font></div>
					</td>
					<td colspan=2 class=unnamed1 width=106
						style='border-left: none; width: 80pt'>
					<div align="center">税务登<br />
					记编号</div>
					</td>
					<td colspan=5 class=unnamed1 style='border-left: none'>
					<div align="left"><label type="text" vname="税务登记编号"
						id="registrationCode" field="registrationCode" /><font
						color="red">*</font></div>
					</td>
				</tr>
				<tr height=45>
					<td colspan=2 rowspan=2 height=90 class=unnamed1>
					<div align="center">经营范围</div>
					</td>
					<td colspan=2 height=45 class=unnamed1>
					<div align="center">主营</div>
					</td>
					<td colspan=9 class=unnamed1>
					<div align="left"><label type="text" vname="主营"
						id="firstScope" field="firstScope" style="width: 70%" /><font
						color="red">*</font></div>
					</td>
				</tr>
				<tr height=45>
					<td colspan=2 height=45 class=unnamed1>
					<div align="center">兼营</div>
					</td>
					<td colspan=9 class=unnamed1>
					<div align="left"><label type="text" vname="兼营"
						id="secondScope" field="secondScope" style="width: 70%" /><font
						color="red">*</font></div>
					</td>
				</tr>
				<tr height=45 style='mso-height-source: userset; height: 33.95pt'>
					<td colspan=3 height=45 class=unnamed1 width=106
						style='height: 33.95pt; width: 80pt'>
					<div align="center">注册资金<br />
					（万元）</div>
					</td>
					<td colspan=10 class=unnamed1 style='border-left: none'>
					<div align="left"><label type="text" vname="注册资金（万元）"
						id="regFund" field="regFund" /><font color="red">*</font></div>
					</td>
				</tr>
				<tr height=45>
					<td colspan=2 rowspan=2 height=90 class=unnamed1>
					<div align="center">职工人数<br>
					<label id="showWorker" value="职工信息" type="button"
						onclick="showWorkerWin()" /></div>
					</td>
					<td colspan=2 class=unnamed1>
					<div align="center">合计</div>
					</td>
					<td colspan=3 class=unnamed1>
					<div align="center">非生产人员</div>
					</td>
					<td colspan=3 class=unnamed1>
					<div align="center">生产人员</div>
					</td>
					<td colspan=3 class=unnamed1>
					<div align="center">残疾职工</div>
					</td>
				</tr>
				<tr height=45>
					<td colspan=2 height=45 class=unnamed1>
					<div align="center"><label type="text" name="合计"
						id="totalNum" /></div>
					</td>
					<td colspan=3 class=unnamed1>
					<div align="center"><label type="text" name="非生产人员"
						id="noProNum" /></div>
					</td>
					<td colspan=3 class=unnamed1>
					<div align="center"><label type="text" name="生产人员"
						id="proNum" /></div>
					</td>
					<td colspan=3 class=unnamed1>
					<div align="center"><label type="text" name="残疾职工"
						id="disNum" /></div>
					</td>
				</tr>
				<tr height=45>
					<td colspan=13 height=45 class=unnamed1>残疾职工其中：视力残疾 <label
						type="text" name="视力残疾" id="slcj"></label> 人、听力残疾 <label
						type="text" name="听力残疾" id="tlcj"></label> 人、言语残疾 <label
						type="text" name="言语残疾" id="yycj"></label> 人、肢体残疾 <label
						type="text" name="肢体残疾" id="ztcj"></label> 人、<br>
					智力和精神病残疾 <label type="text" name="智力和精神病残疾" id="zljscj" /></label> 人。</td>
				</tr>
				<tr height=45>
					<td colspan=2 rowspan=3 height=180 class=unnamed1>
					<div align="center">主<br />
					要<br />
					产<br />
					品<br />
					</div>
					</td>
					<td colspan=5 class=unnamed1 style='border-left: none'>
					<div align="center">产品名称</div>
					</td>
					<td colspan=6 class=unnamed1 style='border-left: none'>
					<div align="center">年销售收入（万元）</div>
					</td>
				</tr>
				<tr height=45>
					<td colspan=5 height=45 class=unnamed1>
					<div align="center">(合计)</div>
					</td>
					<td colspan=6 class=unnamed1>
					<div align="center"><label name="产值" id="productValueT"/></div>
					</td>
				</tr>
				<tr height=45>
					<td colspan=5 height=45 class=unnamed1>
					<div align="center"><table id="pntable" style="width:100%;height:100%"></table></div>
					</td>
					<td colspan=6 class=unnamed1>
					<div align="center"><table id="pvtable" style="width:100%;height:100%"></table></div>
					</td>
				</tr>
				<TR height=45>
						<TD colspan=2 height=180 class=unnamed1 align=middle >
						<p>申</p>
						<p>&nbsp;</p>
						<p align="center">请</p>
						<p>&nbsp;</p>
						<p align="center">理</p>
						<p>&nbsp;</p>
						<p align="center">由</p>
						</TD>
						<TD colspan=10  valign="top"><label
							vname='申请理由' style="width:100%; height:45" id="reason"
							field="reason">
							</label>
						</TD>
				</TR>
				<%-- 
				<tr >
					<td width="8%" colspan="1" class="unnamed1" height="200"><font font-family=黑体; size=4>县民政局意见</font></td>
					<td width="100%" colspan="13" class="unnamed1"  height="200">
							<table width="100%" height="200">
								<tbody>
									<tr>
										<td valign="top" ><label filed="" id=""></label></td>
									</tr>
									<tr>
										<td align="right" valign="bottom"><label filed="" id=""></label></td>
									</tr>
								</tbody>
							</table>
						</td>
				</tr>
				<tr >
					<td width="8%" colspan="1" class="unnamed1" height="200"><font font-family=黑体; size=4>县国税局意见</font></td>
					<td width="100%" colspan="13" class="unnamed1"  height="200">
							<table width="100%" height="200">
								<tbody>
									<tr>
										<td valign="top" ><label filed="countynationtaxOpinion" id="countynationtaxOpinion"></label></td>
									</tr>
									<tr>
										<td align="right" valign="bottom"><label filed="countynationtaxTime" id="countynationtaxTime"></label></td>
									</tr>
								</tbody>
							</table>
						</td>
				</tr>
				<tr >
					<td width="8%" colspan="1" class="unnamed1" height="200"><font font-family=黑体; size=4>县地税局意见</td>
					<td width="100%" colspan="13" class="unnamed1"  height="200">
							<table width="100%" height="200">
								<tbody>
									<tr>
										<td valign="top" ><label filed="countylandtaxOpinion" id="countylandtaxOpinion"></label></td>
									</tr>
									<tr>
										<td align="right" valign="bottom"><label filed="countylandtaxTime" id="countylandtaxTime"></label></td>
									</tr>
								</tbody>
							</table>
						</td>
				</tr>
				<tr >
					<td width="8%" colspan="1" class="unnamed1" height="200"><font font-family=黑体; size=4>最终年审结果(市一级填写)</td>
					<td width="100%" colspan="13" class="unnamed1"  height="200">
						<tbody>
								<tr>
									<td valign="top" ><label filed="" id=""></label></td>
								</tr>
								<tr>
									<td align="right" valign="bottom"><label filed="" id=""></label></td>
								</tr>
						</tbody>
					</td>
				</tr>
				--%>
			</table>
			</TD>
		</TR>
		<tr valign=bottom>
			<td height='27' valign=bottom align=center>第2页</td>
		</tr>
	</TBODY>
</TABLE>
</form>
</body>
</html>
