<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
   <head>
      <next:ScriptManager />
      <script type="text/javascript" src="../js/float1.js"></script>
   </head>
   <body>
    <div id="float1" >
	   <input field="" type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPage('3')"/>
	   <input field="" type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="lastPage('1')"/>
	   <input field="" type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" />
	   <input field="" type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="backPage();"/>
     </div>
     <style type='text/css'>
<!--
.style1 {
	color: #FF0000;
	font-weight: bold;
}
-->
</style>
<STYLE>
body {
	background-color: #ffffff;
	color: #000000;
	margin-left: 0;
	margin-top: 0;
	margin-width: 0;
	margin-height: 0;
	margin: 0px;
	font-size: 12px;
	font-family: '宋体 ';
	font-weight: normal;
	line-height: 18px;
}

table {
	color: #000000;
	font-size: 14px;
	font-family: '宋体 ';
	font-weight: normal;
}

textarea {
	overflow-x: hidden;
	overflow-y: hidden;
}

.text {
	font-size: 14px;
	line-height: 20px;
}

.text1 {
	font-size: 16px;
	letter-spacing: normal;
}

.text2 {
	font-size: 14px;
	line-height: 30px;
	letter-spacing: normal;
}

.unnamed1 {
	border: 1 solid #000000;
	font-size: 14px;
}

.unnamed2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.unnamed3 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 14px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.unnamed4 {
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.unnamed5 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 2px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.unnamed6 {
	border-right-width: 2px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}
.f16ps-size1 {
	border: 1 solid #000000;
	font-size: 16pt;
}

.f16ps-size2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 16pt;
}

.f16ps-size3 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 16pt;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.f16ps-size4 {
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 16pt;
}

.boder1 {
	border: 1 solid #000000;
	font-size: 16px;
	line-height: 25px;
}

.boder2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 16px;
	line-height: 25px;
}

.boder3 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 16px;
	line-height: 25px;
}

.boder4 {
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 16px;
	line-height: 25px;
}

.table {
	font-size: 14px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
}

.boder16pt-0 {
	font-size: 16pt;
	border: 0px none;
	vertical-align: middle;
}

.boderbgh-0 {
	font-size: 14px;
	border: 0px none;
	vertical-align: middle;
	color: #000000;
	background-color: #CCCCCC;
}

.boder0-color {
	font-size: 14px;
	border: 0px none;
	vertical-align: middle;
	background-color: #D8D8D8;
}

.table-text16 {
	font-size: 16px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
}

.boder16-0 {
	font-size: 16px;
	border: 0px none;
	vertical-align: middle;
}

.title {
	font-family: '宋体';
	font-size: 20px;
	font-weight: bold;
	color: #000000;
	text-align: right;
}

.title1 {
	font-family: '宋体';
	font-size: 18px;
	font-weight: bold;
	color: #000000;
}

.text-12s {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
	line-height: 21px;
	word-spacing: 120em;
}

.title2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-family: '宋体';
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	font-size: 18px;
	font-weight: bold;
	color: #000000;
	text-align: right;
}

.biaoti {
	font-family: '宋体';
	font-size: 15px;
	font-weight: bold;
	color: #000000;
}

.minfei-bt {
	font-family: '黑体';
	font-size: 32px;
	font-weight: bold;
	color: #000000;
}

.minfei-bt1 {
	font-family: '宋体';
	font-size: 22px;
	color: #000000;
}

.minfei-bt2 {
	font-size: 20px;
	font-weight: bold;
	color: #000000;
	letter-spacing: 4pt;
}

.npo-bt {
	font-size: 42px;
	line-height: 25px;
	font-weight: bold;
	color: #000000;
	font-family: '宋体';
	text-indent: 10pt;
}

.npo-zi {
	font-family: '宋体';
	font-size: 20px;
	font-weight: bold;
	color: #000000;
}

.npo-font {
	font-family: '黑体';
	font-size: 22px;
	font-weight: normal;
	color: #000000;
}

.npo-bottomtext {
	font-family: '宋体';
	font-size: 28px;
	line-height: 15px;
	font-weight: bolder;
	color: #000000;
}

.font12s {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
}

.font12size {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
	letter-spacing: 4px;
}

.font16pt {
	font-family: '宋体';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 4px;
	line-height: 30pt;
}

.table-text12 {
	font-size: 12px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
}

.font12size1 {
	border: 1 solid #000000;
	font-size: 12px;
	line-height: 22px;
}

.font12size2 {
	line-height: 22px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 12px;
}

.font12size3 {
	line-height: 22px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 12px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.font12size4 {
	line-height: 22px;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 12px;
}

.boder12-0 {
	font-size: 12px;
	border: 0px none;
	vertical-align: middle;
}

.input-line16 {
	font-size: 16pt;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	font-family: '宋体';
	color: #000000;
}

.font16fpt {
	font-family: '仿宋_GB2312';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 4px;
	line-height: 30pt;
}

.font18pt {
	font-size: 16pt;
	color: #000000;
}

.input-line16f {
	font-size: 16pt;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
	font-family: '仿宋_GB2312';
}

.input-line16zc {
	font-size: 16pt;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
	font-family: '仿宋_GB2312';
	text-align: center;
}

.input-line18 {
	font-size: 18pt;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
	font-family: '宋体';
	line-height: 40pt;
}

.stb-bt {
	font-family: '黑体';
	font-size: 30px;
	font-weight: bold;
	color: #000000;
	line-height: 40pt;
}

.stb-bt1 {
	font-family: '宋体';
	font-size: 30px;
	font-weight: bold;
	color: #000000;
	line-height: 40pt;
}

.boder18-0 {
	font-size: 18pt;
	border: 0px none;
	vertical-align: middle;
}

.select {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
	width: 80px;
}

.font16fpt-001 {
	font-family: '仿宋_GB2312';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 2px;
	line-height: 24pt;
}

.font16pt-001 {
	font-family: '仿宋';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 2px;
	line-height: 24pt;
}

.hw-bt {
	font-family: '华文中宋';
	font-size: 26pt;
	font-weight: bold;
	color: #000000;
	letter-spacing: 2pt;
}

.kt-text {
	font-family: '楷体_GB2312';
	font-size: 16pt;
	color: #000000;
	font-weight: normal;
}

.hw-bt2 {
	font-family: '华文中宋';
	font-size: 18pt;
	font-weight: bold;
	color: #000000;
}

.fs-text {
	font-family: '仿宋_GB2312';
	font-size: 16pt;
	font-weight: normal;
	color: #000000;
	letter-spacing: 1pt;
	line-height: 160%;
}

.ht-text {
	font-family: '黑体';
	font-size: 16pt;
	line-height: 110%;
	font-weight: normal;
	color: #000000;
	letter-spacing: 1pt;
}

.red {
	font-family: '仿宋_GB2312';
	font-size: 16pt;
	color: #FF0000;
	line-height: 160%;
	letter-spacing: 1pt;
}

.textarea01 {
	font-family: '仿宋_GB2312';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 1pt;
	border: 1px solid #000000;
	line-height: 160%;
}

.txt_ {
	text-align: center; ;
	font-size: 12px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
}
</STYLE>
<form method="post" onsubmit="return false" >

<div align="center">
<p class=border12-0 align=center>&nbsp;</p>
<p class=border12-0 align=center>&nbsp;</p>
<p class=border12-0 align=center>&nbsp;</p>

<p class=border12-0 align=center>&nbsp;</p>
<table cellspacing="0" cellpadding="0" width="931" style="border:1px solid black;" border=1>
<tr>
    
    <td colspan="11">一、基本信息</td>
    
  </tr>
  <tr>
    <td width="68"  colspan="2" align=center>法人代表 </td>
    <td colspan="3">
    <input type="text" name="法人代表" id="法人代表"/></td>
    
    <td width="68"  colspan="2" align=center>联系电话 </td>
    <td colspan="4">
    <input type="text" name="联系电话" id="联系电话"/></td>
  </tr>
  <tr>
    <td width="68" align=center><p>地址 </p></td>
    <td colspan="10">
   <input type="text" name="地址" id="地址"/></td>
  </tr>
  <tr>
  	<td rowspan="3" colspan="3">资格认定时间</td>
  	<td rowspan="3" colspan="3"><input type="text" name="资格认定时间" id="资格认定时间"/></td>
  	<td colspan="5">年末职工总数：<input type="text" name="年末职工总数" id="年末职工总数"/></td>
  </tr>
  <tr>
  	<td rowspan="2" colspan="2">其中</td>
  	<td colspan="3">健全职工<input type="text" name="健全职工" id="健全职工"/>人</td>
  	
  </tr>
  <tr>
  	<td colspan="3">残疾职工<input type="text" name="残疾职工" id="残疾职工"/>人</td>
  </tr>
  <tr>
  	
  </tr>
  <tr>
  	<td colspan="2">主&nbsp;&nbsp;营</td>
  	<td colspan="3"><input type="text" name="主营" id="主营"/></td>
  	<td colspan="5">残疾职工情况</td>
  </tr>
  <tr>
  	<td colspan="2">主要产品</td>
  	<td colspan="3"><input type="text" name="主要产品" id="主要产品"/></td>
  	<td colspan="5">1、肢体残疾<input type="text" name="肢体残疾" id="肢体残疾"/>人</td>
  </tr><tr>
  	<td colspan="2">注册资金</td>
  	<td colspan="3"><input type="text" name="注册资金" id="注册资金"/></td>
  	<td colspan="5">2、听力语言残疾<input type="text" name="听力语言残疾" id="听力语言残疾"/>人</td>
  </tr><tr>
  	<td colspan="2">工商登记</td>
  	<td colspan="3"><input type="text" name="工商登记" id="工商登记"/></td>
  	<td colspan="5">3、视力残疾<input type="text" name="视力残疾" id="视力残疾"/>人 </td>
  </tr><tr>
  	<td colspan="2">国税登记</td>
  	<td colspan="3"><input type="text" name="国税登记" id=国税登记/></td>
  	<td colspan="5">4、综合残疾<input type="text" name="综合残疾" id="综合残疾"/>人</td>
  </tr><tr>
  	<td colspan="2">地税登记</td>
  	<td colspan="3"><input type="text" name="地税登记" id=地税登记/></td>
  	<td colspan="5">残疾职工占职工总数比例<input type="text" name="综合残疾" id="综合残疾"/>%</td>
  </tr><tr>
  	<td colspan="2">开户银行</td>
  	<td colspan="3"><input type="text" name="开户银行" id="开户银行"/></td>
  	<td colspan="5">银行账户：<input type="text" name="银行账户" id="银行账户"/></td>
  </tr>
  <tr>
  	<td colspan="11">二、当年财务、纳税及减免税情况</td>
  </tr>
  <tr>
	<td colspan="2">固定资产原值</td><td colspan="3" nowrap="nowrap"><input type="text" name="银行账户" id="银行账户"/>万元</td><td colspan="3">营业收入</td><td colspan="3"><input type="text" name="银行账户" id="银行账户"/>万元</td>
	</tr>
	<tr>
	<td colspan="2">费用合计</td><td colspan="3" nowrap="nowrap"><input type="text" name="银行账户" id="银行账户"/>万元</td><td colspan="3">营业利润</td><td colspan="3"><input type="text" name="银行账户" id="银行账户"/>万元</td>
	</tr>
	<tr>
	<td colspan="2">企业单位增加值</td><td colspan="3" nowrap="nowrap"><input type="text" name="银行账户" id="银行账户"/>万元</td><td colspan="3">纳税总额</td><td colspan="3"><input type="text" name="银行账户" id="银行账户"/>万元</td>
	</tr>
	<tr>
	<td colspan="2">增值税总额</td><td colspan="3" nowrap="nowrap"><input type="text" name="银行账户" id="银行账户"/>万元</td><td colspan="3">营业税总额</td><td colspan="3"><input type="text" name="银行账户" id="银行账户"/>万元</td>
	</tr>
	<tr>
	<td colspan="2">所得税总额</td><td colspan="3" nowrap="nowrap"><input type="text" name="银行账户" id="银行账户"/>万元</td><td colspan="3">应减免税金总额</td><td colspan="3"><input type="text" name="银行账户" id="银行账户"/>万元</td>
	</tr>
	<tr>
	<td colspan="2">实际减免税金总额</td><td colspan="3" nowrap="nowrap"><input type="text" name="银行账户" id="银行账户"/>万元</td><td colspan="3">盈利总额</td><td colspan="3"><input type="text" name="银行账户" id="银行账户"/>万元</td>
	
  </tr>
  <tr>
  	<td colspan="11">三、当年劳动、工资及福利</td>
  	
  </tr>
  <tr>
  	<td colspan="11">所在区县适用最低月工资标准<input type="text" name="银行账户" id="银行账户"/>元</td>
  	
  </tr>
   <tr>
  	<td colspan="11">残疾职工最低月工资（含保险等）<input type="text" name="银行账户" id="银行账户"/>元</td>
  	
  </tr>
  <tr>
  	<td colspan="5">职工人均年收入<input type="text" name="银行账户" id="银行账户"/> 元</td><td colspan="6">残疾职工年人均收入  <input type="text" name="银行账户" id="银行账户"/>元</td>
  </tr>
 <tr>
  	<td colspan="5">参加养老保险残疾职工数 <input type="text" name="银行账户" id="银行账户"/>人</td><td colspan="6">参加医疗保险残疾职工数 <input type="text" name="银行账户" id="银行账户"/>人</td>
  </tr><tr>
  	<td colspan="5">参加失业保险残疾职工数<input type="text" name="银行账户" id="银行账户"/>人</td><td colspan="6">参加工伤保险残疾职工数<input type="text" name="银行账户" id="银行账户"/>人</td>
  </tr><tr>
  	<td colspan="5">签订用工合同残疾职工数<input type="text" name="银行账户" id="银行账户"/>人</td><td colspan="6">通过金融机构发放工资残疾职工数<input type="text" name="银行账户" id="银行账户"/>人</td>
  </tr>
  
  <tr>
  <td colspan="11">
  	四、当年减免税金管理及使用情况
  </td>
  <tr>
  <td colspan="11">
  	当年减免税金额  <input type="text" name="银行账户" id="银行账户"/>元，使用情况：<input type="text" name="银行账户" id="银行账户"/></td>
  </tr><tr><td colspan="11">
1、用于福利和各类保险<input type="text" name="银行账户" id="银行账户"/>元
  </td></tr><tr>
  <td colspan="11">
  2、用于社会福利事业捐赠<input type="text" name="银行账户" id="银行账户"/>元
  </td>
  </tr>
  <tr>
    <td width="68"><p align="center">企业法人 </p></td>
    <td width="168"><p>
      <input type="text" name="企业法人" id="企业法人"/>
    </p></td>
    <td colspan="3"><p align="center">经办人 </p></td>
    <td colspan="3"><p align="center">
      <input type="text" name="经办人" id="经办人"/>
    </p></td>
    <td width="165"><p align="center">联系电话 </p></td>
    <td colspan="2"><p align="left">
      <input type="text" name="联系电话" id="联系电话"/>
    </p></td>
  </tr>
  <tr>
    <td width="68"><p align="center">经济性质 </p></td>
    <td width="168"><p>
      <input type="text" name="经济性质" id="经济性质"/>
    </p></td>
    <td colspan="3"><p align="center">注册资金</p><p align=center>(万元)</p></td>
    <td colspan="3"><p align="center">
      <input type="text" name="注册资金" id="注册资金"/>
    </p></td>
    <td width="165"><p align="center">成立时间 </p></td>
    <td colspan="2"><p align="left">
      <input type="text" name="成立时间" id="成立时间"/>
    </p></td>
  </tr>
  <tr>
    <td width="68"><p align="center">营业执照编   号 </p></td>
    <td width="168"><p>
      <input type="text" name="营业执照编号" id="营业执照编号"/>
    </p></td>
    <td colspan="3"  nowrap="nowrap"><p align="center" >税务登记编号 </p></td>
    <td colspan="3"><p align="center">
      <input type="text" name="税务登记编号" id="税务登记编号"/>
    </p></td>
    <td width="165"><p align="center">组织机构代码 </p></td>
    <td colspan="2"><p align="left">
      <input type="text" name="组织机构代码 " id="组织机构代码 "/>
    </p></td>
  </tr>
  <tr>
    <td width="68" rowspan="2"><p align="center">年度经营状况(万元)</p></td>
    <td width="168" nowrap="nowrap"><p align="center">经营收入 </p></td>
    <td colspan="6"><p align="left">
      <input type="text" name="经营收入 " id="经营收入 "/>
    </p></td>
    <td width="165"><p align="center">利润 </p></td>
    <td colspan="2"><p align="left">
      <input type="text" name="通讯地址12" id="通讯地址12"/>
    </p></td>
  </tr>
  <tr>
    <td width="168"><p align="center">年度退税额 </p></td>
    <td colspan="9"><p align="left">
      <input type="text" name="年度退税额 " id="年度退税额 "/>
    </p></td>
  </tr>
  <tr>
    <td width="68"><p align="center">网站地址 </p></td>
    <td colspan="3"><p align="left">
      <input type="text" name="网站地址" id="通讯地址14"/>
    </p></td>
    <td colspan="2"><p align="center">电子邮箱 </p></td>
    <td colspan="3"><p align="left">
      <input type="text" name="电子邮箱 " id="电子邮箱 "/>
    </p></td>
    <td width="68" nowrap="nowrap"><p align="center">邮政编码 </p></td>
    <td width="168"><p align="center">
      <input type="text" name="通讯地址16" id="通讯地址16"/>
    </p></td>
  </tr>
  <tr>
    <td width="68" rowspan="2"><p align="center">职工人数 </p></td>
    <td colspan="2"><p align="center">合计 </p></td>
    <td colspan="4" nowrap="nowrap"><p align="center">非生产人员 </p></td>
    <td colspan="2" nowrap="nowrap"><p align="center">生产人员 </p></td>
    <td colspan="2"><p align="center">残疾职工 </p></td>
  </tr>
  辅导费是发送方
  
</table>
</div>
</form>
</body>
</html>