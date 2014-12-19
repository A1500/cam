 <%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>福利企业审批 </title>
<%
	String taskCode = (String)request.getParameter("taskCode");
	String changId = (String)request.getParameter("changId");
%>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="../../../common/js/float.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<link href="../apply/welfarecorpQualification/css/welfareapply1.css" type="text/css" rel="stylesheet" />
<script language="javascript">
 	var taskCode= '<%=taskCode%>';
 	var changId = '<%=changId%>';
 	//初始化
	function init(){
		ds.setParameter("TASK_CODE@=", taskCode);
		ds.load();
		listDetail();
	}
	//返回
	function back(){
		var data = new L5.Map();
		var url='jsp/cams/welfare/welfarecorp/change/unitChangeList.jsp';
		L5.forward(url);
	}
	function listDetail(){
		detailds.setParameter("CHANG_ID@=", changId);
		detailds.load();
		detailds.on('load',function(detailds){
			for(var i=0;i < detailds.getCount();i++){
				document.getElementById('itemName'+i).innerText = detailds.getAt(i).get("itemName");
				document.getElementById('itemBefore'+i).innerText = detailds.getAt(i).get("itemBefore");
				document.getElementById('itemAfter'+i).innerText = detailds.getAt(i).get("itemAfter");
			}
		});
	}
	function MakeWord(){
	 	var word = new ActiveXObject("Word.Application");
	 	var doc = word .Documents.Add("",0,0);//不打开模版直接加入内容
	 	var   Range=doc.Range();
	 	var sel = document.body.createTextRange();
	 	sel.moveToElementText(form1);//此处form是页面form的id
	 	sel.select();
	 	sel.execCommand("Copy"); 
	 	Range.Paste();
	 	word .Application.Visible = true;
	 	sel.collapse(true);
		sel.select(); 
	}
</script>
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
	<!-- 变更备案表 -->
	<model:dataset id="ds" cmd="com.inspur.cams.welfare.base.cmd.WealFitChangerecordQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitChangerecord">
		</model:record>
	</model:dataset>
	<!-- 变更备案明细表 -->
	<model:dataset id="detailds" cmd="com.inspur.cams.welfare.base.cmd.WealFitChangerecordDetailQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitChangerecordDetail"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" >
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="back()"/>
	<input type="button" value="word打印" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="MakeWord()"/>
</div>
<form method="post" id="form1"  onsubmit="return false" dataset="ds">
<p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
vertical-align:bottom'><span lang=EN-US style='font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:6.0pt'><span
style='mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></p>
<p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
vertical-align:bottom'><span lang=EN-US style='font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:6.0pt'><span
style='mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></p>
<p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
vertical-align:bottom'><span lang=EN-US style='font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:6.0pt'><span
style='mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></p>
<div class=WordSection1>
<p class=MsoNormal align=center style='text-align:center;mso-pagination:widow-orphan;
text-autospace:none;vertical-align:bottom'><b style='mso-bidi-font-weight:normal'><span
style='font-size:18.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:2.0pt;mso-no-proof:yes'>社会福利企业<span
lang=EN-US><o:p></o:p></span></span></b></p>
<p class=MsoNormal align=center style='text-align:center;mso-pagination:widow-orphan;
text-autospace:none;vertical-align:bottom'><b style='mso-bidi-font-weight:normal'><span
style='font-size:18.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:2.0pt;mso-no-proof:yes'>事项变更</span></b><b
style='mso-bidi-font-weight:normal'><span style='font-size:18.0pt;mso-bidi-font-size:
10.0pt;font-family:宋体;mso-hansi-font-family:"Times New Roman";letter-spacing:
2.0pt'>备案表<span lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal><b style='mso-bidi-font-weight:normal'><span lang=EN-US
style='font-size:14.0pt;mso-bidi-font-size:10.0pt;font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:2.0pt'><o:p>&nbsp;</o:p></span></b></p>

<div align=center>

<table border=0 cellpadding=0 cellspacing=0 width=678 class=unnamed1 style='border-collapse:
 collapse;table-layout:fixed;width:510pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2528;width:59pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:2752;width:65pt'>
 <col width=72 style='width:54pt'>
 <col width=94 style='mso-width-source:userset;mso-width-alt:3008;width:71pt'>
 <col width=72 style='width:54pt'>
 <col width=93 style='mso-width-source:userset;mso-width-alt:2976;width:70pt'>
 <col width=72 style='width:54pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:3520;width:83pt'>
 <tr height=52 style='mso-height-source:userset;height:39.0pt'>
  <td colspan=2 height=52 class=unnamed1 width=165 style='border-right:.5pt solid black;
  height:39.0pt;width:124pt'>企业名称</td>
  <td colspan=2 class=unnamed1 width=166 style='border-right:.5pt solid black;
  border-left:none;width:125pt'><div align="left"><label id="companyName" field="companyName" title="企业名称" style="width:98%;" /></div>　</td>
  <td colspan=2 class=unnamed1 width=165 style='border-right:.5pt solid black;
  border-left:none;width:124pt'>编号</td>
  <td colspan=2 class=unnamed1 width=182 style='border-right:.5pt solid black;
  border-left:none;width:137pt'><div align="left"><label id="serialNum" field="serialNum" title="编号" style="width:98%;" /></div>　</td>
 </tr>
 <tr height=52 style='mso-height-source:userset;height:39.0pt'>
  <td colspan=2 height=52 class=unnamed1 width=165 style='border-right:.5pt solid black;
  height:39.0pt;width:124pt'>联系人</td>
  <td colspan=2 class=unnamed1 width=166 style='border-right:.5pt solid black;
  border-left:none;width:125pt'><div align="left"><label id="linkman" field="linkman" title="联系人" style="width:98%;" /></div>　</td>
  <td colspan=2 class=unnamed1 width=165 style='border-right:.5pt solid black;
  border-left:none;width:124pt'>联系电话</td>
  <td colspan=2 class=unnamed1 width=182 style='border-right:.5pt solid black;
  border-left:none;width:137pt'><div align="left"><label id="phone" field="phone" title="联系电话" style="width:98%;" /></div>　</td>
 </tr>
 <tr height=52 style='mso-height-source:userset;height:39.0pt'>
  <td colspan=2 height=52 class=unnamed1 width=165 style='border-right:.5pt solid black;
  height:39.0pt;width:124pt'><div align="center">变更事项</div></td>
  <td colspan=3 class=unnamed1 width=238 style='border-right:.5pt solid black;
  border-left:none;width:179pt'><div align="center">变更前</div></td>
  <td colspan=3 class=unnamed1 width=275 style='border-right:.5pt solid black;
  border-left:none;width:207pt'><div align="center">变更后</div></td>
 </tr>
 <tr height=52 style='mso-height-source:userset;height:39.0pt' >
  <td colspan=2 height=52 class=xl65 style='border-right:.5pt solid black;
  height:39.0pt'>
  <label id=itemName0  title="变更事项" />　
  </td>
  <td colspan=3 class=unnamed1 style='border-right:.5pt solid black;border-left:
  none'><div align="left"></div><label id="itemBefore0" title="变更前" style="width:98%;" />　</td>
  <td colspan=3 class=unnamed1 style='border-right:.5pt solid black;border-left:
  none'><div align="left"></div><label id="itemAfter0"  title="变更后" style="width:98%;" />　</td>
 </tr>
 <tr height=52 style='mso-height-source:userset;height:39.0pt' >
  <td colspan=2 height=52 class=unnamed1 style='border-right:.5pt solid black;
  height:39.0pt'>
  <label id=itemName1 title="变更事项" />　
  </td>
  <td colspan=3 class=unnamed1 style='border-right:.5pt solid black;border-left:
  none'><div align="left"></div><label id="itemBefore1" title="变更前" style="width:98%;" />　</td>
  <td colspan=3 class=unnamed1 style='border-right:.5pt solid black;border-left:
  none'><div align="left"></div><label id="itemAfter1"  title="变更后" style="width:98%;" />　</td>
 </tr>
 <tr height=52 style='mso-height-source:userset;height:39.0pt' >
  <td colspan=2 height=52 class=unnamed1 style='border-right:.5pt solid black;
  height:39.0pt'>
  <label id=itemName2 title="变更事项" />
  </td>
  <td colspan=3 class=unnamed1 style='border-right:.5pt solid black;border-left:
  none'><div align="left"></div><label id="itemBefore2" title="变更前" style="width:98%;" />　</td>
  <td colspan=3 class=unnamed1 style='border-right:.5pt solid black;border-left:
  none'><div align="left"></div><label id="itemAfter2"  title="变更后" style="width:98%;" />　</td>
 </tr>
 <tr height=52 style='mso-height-source:userset;height:39.0pt' >
  <td colspan=2 height=52 class=unnamed1 style='border-right:.5pt solid black;
  height:39.0pt'>
  <label id=itemName3 title="变更事项" />
  </td>
  <td colspan=3 class=unnamed1 style='border-right:.5pt solid black;border-left:
  none'><div align="left"></div><label id="itemBefore3" title="变更前" style="width:98%;" />　</td>
  <td colspan=3 class=unnamed1 style='border-right:.5pt solid black;border-left:
  none'><div align="left"></div><label id="itemAfter3"  title="变更后" style="width:98%;" />　</td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td rowspan=5 height=200 class=unnamed1 width=79 style='border-bottom:.5pt solid black;
  height:150.0pt;border-top:none;width:59pt'><div align="center"><p>变</p>
						<p>&nbsp;</p>
						<p align="center">更</p>
						<p>&nbsp;</p>
						<p align="center">理</p>
						<p>&nbsp;</p>
						<p align="center">由</p></div></td>
  <td valign="top" colspan=7 rowspan=5 class=unnamed1 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'><label id="changeReason" field="changeReason"  validateName="变更理由" style="width:98%;height:75%;" /></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=4 rowspan=8 height=192 class=xl79 width=331 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:144.0pt;width:249pt'><span
  style='mso-spacerun:yes'>&nbsp;</span>法定代表人<br>
    <br>
    <span style='mso-spacerun:yes'>&nbsp;</span>签 章：<br>
    <span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span>年<span style='mso-spacerun:yes'>&nbsp;&nbsp; </span>月<span
  style='mso-spacerun:yes'>&nbsp;&nbsp; </span>日</td>
  <td colspan=4 rowspan=8 class=xl79 width=347 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:261pt'>企业盖章<br>
    <br>
    <span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span>年<span style='mso-spacerun:yes'>&nbsp;&nbsp; </span>月<span
  style='mso-spacerun:yes'>&nbsp;&nbsp; </span>日<br>
    </td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
 </tr>
</table>
</div>
<p class=MsoNormal style='mso-pagination:widow-orphan;text-autospace:none;
vertical-align:bottom'><span lang=EN-US style='font-family:宋体;mso-hansi-font-family:
"Times New Roman";letter-spacing:6.0pt'><span
style='mso-spacerun:yes'>&nbsp;</span><o:p></o:p></span></p>
</div>
</form>
</body>
</html>