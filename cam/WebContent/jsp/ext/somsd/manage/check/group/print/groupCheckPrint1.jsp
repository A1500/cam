<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<script language="javascript">
 	//初始化
	function init1(){
		var somCheckCouncilDataSet = L5.DatasetMgr.lookup("somCheckCouncilDataSet");
		somCheckCouncilDataSet.setParameter("TASK_CODE@=", taskCode);
		somCheckCouncilDataSet.load();
		somCheckCouncilDataSet.on("load",function(ds){
			if(ds.getCount()==0){
				somCheckCouncilDataSet.newRecord();
			}
			PROGRESS_BAR++;
		});
		//创建页面导航下拉框
		//createGroupDetailSelect();
	}
	 function docPrint(){
        document.execCommand("Print", false);
    }
</script>
<style media="print">
	.noprint     { display: none }
</style>
<style>
textarea {
	overflow: hidden;
}
.label1 {
	text-align:center;
}
</style>

<model:datasets>
	<model:dataset id="somCheckCouncilDataSet" cmd="com.inspur.cams.sorg.check.checkcouncil.cmd.SomCheckCouncilQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkcouncil.data.SomCheckCouncil"></model:record>
	</model:dataset>
	<!-- 业务主管单位 -->
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 所属行事业 -->
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织职务 -->
	<model:dataset id="sorgDutiesSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="secretarygeneralTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<div id="float"  class="noprint" style='height:15px;'>	

</div>
<div align=center style='page-break-after:always'>
<div align=left style="width:610px;">
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p  align=center style='text-align:center'><span
style='font-size:16.0pt;font-family:黑体;'>一、基本信息</></p>

<div align=center>
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<table   cellspacing=0 cellpadding=0 width="610px">
  <tr>
  <td width="100px" style='border-top:1.5pt;border-left:1.5pt;
  border-bottom:1.0pt;border-right:1.0pt;border-color:windowtext;border-style:
  solid;'>
	  <p align=center>
	  <span style='font-size:14.0pt;font-family:宋体'>名&nbsp;&nbsp;&nbsp; 称</span></p>
  </td>
  <td width="510px" colspan=5 valign=middle style='border-top:solid windowtext 1.5pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:  0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p  align=center style='line-height:24.0pt;'>
	  	<span>
	  		<label class='label1'   field="cnName" style="width:98%"/>
	  	</span>
	  </p>
  </td>
 </tr>
 <tr style='height:27.0pt'>
  <td width="100px" style='border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:27.0pt'>
  <p  align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>业务主管</span></p>
  <p  align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>单&nbsp;&nbsp;&nbsp; 位</span></p>
  </td>
  <td width="180px" colspan=2 valign=middle style='border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='line-height:28.0pt;'>
  	<span>
  		<label class='label1'  field="borgName" dataset="businessOrganSelect" style="width:98%"/>
  	</span>
  </p>
  </td>
  <td width="130px" style='border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>行业分类</p>
  </td>
  <td width="200px" colspan=2 valign=middle style='border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p  align=center style='line-height:48.0pt;'>
  <span>
	<label class='label1'  field="businessType" dataset="busScopeSelect" style="width:98%"/>
</span></p>
  </td>
 </tr>
<tr style='height:27.0pt'>
  <td width="100px" style='border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  mso-border-left-alt:solid windowtext 1.5pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>业务范围<span>
  </p>
  </td>
  <td width="510px" colspan=5 valign=middle style='border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  height:27.0pt'>
  <p align=center style='line-height:28.0pt;'>
  	<span>
		<textarea rows="5" name='业务范围' field="business" style="width:510px;" readonly="readonly"></textarea>
	</span>
  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="100px" style='border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:27.0pt'>
  <p  align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>登记证号<span><o:p></o:p></span></span></p>
  </td>
  <td width="130px" colspan=2 valign=middle style='border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p  align=center style='line-height:28.0pt;'>
  	<span>
		<label class='label1'   field="sorgCode" style="width:98%"/>
	</span>
  </p>
  </td>
  <td width="180px"  style='border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>组织机构代码
  </span></p>
  </td>
  <td width="200px" colspan=2 valign=middle style='border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='line-height:28.0pt;'>
  	<span>
		<label class='label1'   field="organCode" style="width:98%"/>
	</span>
  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="20%" style='border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt; height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>成立时间</span></p>
  </td>
  <td width="30%" colspan=2 valign=middle style='border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p  align=center style='line-height:28.0pt;'>
	  <span style='font-size:14.0pt;font-family:宋体'>
	  	<label class='label1'   field="buildDate" style="width:98%"/>
	  </span>
  </p>
  </td>
  <td width="20%" style='border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>注册资金
  </span>
  </p>
  </td>
  <td width="30%" colspan=2 style='border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p  align=center>
  <span><label class='label1'   style="text-align:right" field="regMon" style="width:40%"></label>万元</span></p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="20%" style='border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;
  height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>住&nbsp;&nbsp;&nbsp; 所</span>
  </p>
  </td>
  <td valign=middle colspan=2 width="30%" style='border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center>
	 	 <label class='label1'   field="residence" style="width:98%"/>
	  </p>
  </td>
  <td width="20%" valign=top style='border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:27.0pt'>
	  <p align=center style='text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>邮政编码</span>
	  </p>
  </td>
  <td valign=middle colspan=2 width="30%" style='border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center>
	  	<label class='label1'   field="sorgPost" style="width:98%"/>
	  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="20%"  style='border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
	  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
	  <span style='font-size:14.0pt;font-family:宋体'>联系电话
	  </span>
	  </p>
  </td>
  <td valign=middle colspan=2 width="30%"  style='border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center>
  	<label class='label1'   field="sorgPhone" style="width:98%"/>
  </p>
  </td>
  <td width="20%"  style='border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>传&nbsp;&nbsp;&nbsp; 真</span></p>
  </td>
  <td valign=middle colspan=2 width="30%" style='border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center>
		<label class='label1'   field="sorgFax" style="width:98%"/>
  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="16.8%" style='width:16.88%;border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;
  height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>联&nbsp;系&nbsp;人</span>
  </p>
  </td>
  <td valign=middle width="16.8%"   style='border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center>
	 	 <label class='label1'   field="linkmanName" style="width:98%"/>
	  </p>
  </td>
  <td width="16.6%" valign=top style='width:15.8%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:27.0pt'>
	  <p align=center style='text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>电话</span>
	  </p>
  </td>
  <td valign=middle width="16.6%"style='width:16.4%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center>
	  	<label class='label1'   field="linkmanPhone" style="width:98%"/>
	  </p>
  </td>
  <td width="16.6%" valign=top style='width:15.8%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 1.4pt 0cm 1.4pt;height:27.0pt'>
	  <p align=center style='text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>手机</span>
	  </p>
  </td>
  <td valign=middle width="16.6%" style='width:16.4%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center>
	  	<label class='label1'   field="linkmanMobile" style="width:98%"/>
	  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="20%" style='border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  	<span style='font-size:14.0pt;font-family:宋体'>网站地址</span>
  </p>
  </td>
  <td width="30%" colspan=2 valign=middle style='border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center>
  	<label class='label1'   field="sorgWeb" style="width:98%"/>
  </p>
  </td>
  <td width="20%" style='border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  	<span style='font-size:14.0pt;font-family:宋体'>电子邮箱</span>
  </p>
  </td>
  <td width="30%" colspan=2 valign=middle style='border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center>
  	<label class='label1'   field="sorgEmail" style="width:98%"/>
  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="20%" style='border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  	<span style='font-size:14.0pt;font-family:宋体'>单位会员数</span>
  </p>
  </td>
  <td width="30%" colspan=2 valign=middle style='border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center>
  	<label class='label1'   field="unitsNum" style="width:98%"/>
  </p>
  </td>
  <td width="20%" style='border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  	<span style='font-size:14.0pt;font-family:宋体'>个人会员数</span>
  </p>
  </td>
  <td width="30%" colspan=2 valign=middle style='border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center>
  	<label class='label1'   field="peopleNum" style="width:98%"/>
  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="20%" style='border-top:none;border-left:solid windowtext 1.5pt;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;;padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  	<span style='font-size:14.0pt;font-family:宋体'>法定代表人</span>
  </p>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  	<span style='font-size:14.0pt;font-family:宋体'>姓&nbsp;名</span>
  </p>
  </td>
  <td width="30%" colspan=2 valign=middle style='border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center>
  	<label class='label1'   field="legalPeople" style="width:98%"/>
  </p>
  </td>
  <td width="20%" style='border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>法定代表人<span
  lang=EN-US><o:p></o:p></span></span></p>
  <p  align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
  <span style='font-size:14.0pt;font-family:宋体'>担任职务<span
  lang=EN-US><o:p></o:p></span></span></p>
  </td>
  <td width="30%" colspan=2 valign=middle style='border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center>
		<label class='label1'  field="legalPeopleDuty" dataset="sorgDutiesSelect" style="width:98%"/>
  </p>
  </td>
 </tr>
 </table>
</form>
<form method="post" dataset="somCheckCouncilDataSet" onsubmit="return false">
 <table   cellspacing=0 cellpadding=0 width="610px">
 <tr style='height:27.0pt;' >
  <td width="20%" rowspan=4 style='border-top:none;border-left:
  solid windowtext 1.5pt;border-bottom:solid windowtext 1.5pt;border-right:
  solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
	  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>理事会情况</span>
	  </p>
  </td>
  <td width="11%" valign=top style='width:11.44%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='margin-right:-5.35pt;text-align:center;line-height:28.0pt;'><span
	  style='font-size:14.0pt;font-family:宋体'>理事长</span></p>
	  <p align=center style='margin-right:-5.35pt;text-align:center;line-height:28.0pt;'><span
	  style='font-size:14.0pt;font-family:宋体'>姓&nbsp; 名</span>
	  </p>
  </td>
  <td width="26%" colspan=2 valign=middle style='width:16.04%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center>
  		<label class='label1'   field="chairmanName" style="width:98%"/>
  </p>
  </td>
  <td width="13%" colspan=2 style='width:13.72%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
	  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
	 	 <span style='font-size:14.0pt;font-family:宋体'>理事人数</span>
	  </p>
  </td>
  <td width="12%" colspan=2 style='width:12.24%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center>
	  	<label class='label1'   field="councilNum" style="width:98%"/>
	  </p>
  </td>
  <td width="17%" colspan=2 style='width:17.1%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='margin-top:0cm;margin-right:-5.25pt;
	  margin-bottom:0cm;margin-left:-5.35pt;margin-bottom:.0001pt;text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>秘书长以上负责人人数</span>
	  </p>
  </td>
  <td width="12%" style='width:12.5%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center>
	  		<label class='label1'   field="secretarygeneralNum" style="width:98%"/>
	  </p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="11%" style='width:11.44%;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='margin-right:-5.35pt;'><span
	  style='font-size:14.0pt;font-family:宋体'>秘书长</span></p>
	  <p align=center style='margin-right:-5.35pt;text-align:center;line-height:28.0pt;'><span
	  style='font-size:14.0pt;font-family:宋体'>姓&nbsp; 名</span></p>
  </td>
  <td width="26%" colspan=2 style='width:16.04%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center>
	  		<label class='label1'   field="secretarygeneralName" style="width:98%"/>
	  </p>
  </td>
  <td width="13%" colspan=2 style='width:13.72%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='margin-right:-5.35pt;text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>常务理事</span>
	  </p>
	  <p align=center style='margin-right:-5.35pt;text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>人&nbsp;&nbsp; 数</span>
	  </p>
  </td>
  <td width="12%" colspan=2 style='width:12.24.2%;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center>
	  		<label class='label1'   field="executiveDirectorNum" style="width:98%"/>
	  </p>
  </td>
  <td width="17%" colspan=2 style='width:17.1%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='text-align:center;line-height:28.0pt;'>
  	<span style='font-size:14.0pt;font-family:宋体'>秘书长为</span>
  </p>
  </td>
  <td width="12%" valign=middle style='width:12.5%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p class=MsoNormal style='line-height:28.0pt;mso-line-height-rule:exactly'><span
  lang=EN-US style='font-size:14.0pt;font-family:宋体;'><o:p>
    <label class='label1'  field='secretarygeneralType'style='width:98%' dataset='secretarygeneralTypeSelect'/>
  </o:p></span></p>
  </td>
 </tr>
 <tr style='page-break-inside:avoid;height:27.0pt'>
  <td width="25%" colspan=3 style='width:25.48%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
  <p align=center style='margin-right:-5.4pt;text-align:center;
  line-height:28.0pt;'><span style='font-size:14.0pt;
  font-family:宋体'>现职公务员兼任</p>
  <p align=center style='margin-right:-5.4pt;text-align:center;
  line-height:28.0pt;'><span style='font-size:14.0pt;
  font-family:宋体'>负责人情况</span></p>
  </td>
  <td width="57%" colspan=8 style='width:57.64%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p style='line-height:28.0pt;'>
		  <span style='font-size:14.0pt;font-family:宋体'>
		  省部级及以上(<label class='label1'   field="servantProNum" style="width:25"></label>)人；
		  地厅级(<label class='label1'   field="servantCityNum" style="width:25"></label>)人；
		  县处级(<label class='label1'   field="servantTownNum" style="width:25"></label>)人
		  </span>
	  </p>
  </td>
 </tr>
 <tr style='mso-yfti-lastrow:yes;page-break-inside:avoid;height:27.0pt'>
  <td width="25%" colspan=3 style='width:25.48%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.5pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p align=center style='text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>离退休人员担任</span>
	  </p>
	  <p align=center style='text-align:center;line-height:28.0pt;'>
	  	<span style='font-size:14.0pt;font-family:宋体'>负责人情况</span>
	  </p>
  </td>
  <td width="57%" colspan=8 style='width:57.64%;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.5pt;border-right:solid windowtext 1.5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:27.0pt'>
	  <p style='margin-right:-.7pt;line-height:28.0pt;'>
		  <span style='font-size:14.0pt;font-family:宋体'>
		  总数(<label class='label1'   field="retiredSumNum" style="width:25"></label>)人，
		  其中地厅级及以上(<label class='label1'   field="retiredCityNum" style="width:25"></label>)人；
		  70岁以上(<label class='label1'   field="retiredOldNum" style="width:25"></label>)人
		  </span>
	  </p>
  </td>
 </tr>
</table>
</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>


</div>
</div>
