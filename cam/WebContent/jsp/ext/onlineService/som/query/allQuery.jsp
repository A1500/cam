<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset==UTF-8" /> 
<meta http-equiv="x-ua-compatible" content="ie=7" />
<link href="css/style.css" rel="stylesheet" type="text/css" />

<title>社会组织查询</title>
<next:ScriptManager></next:ScriptManager>
</head>
<script src="../lib/function.js" ></script>
	<%
		String name = request.getParameter("name");
		String nameoutStr = "";
		if(name!=null){
			nameoutStr = new String(name.getBytes("iso-8859-1"),"UTF-8");
		}
		
	%>
<script language="javascript">
	var name='<%=nameoutStr%>';
	function init(){
		somOrganDataSet.setParameter("IF_BRANCH@=","0");
		somOrganDataSet.setParameter("MORG_AREA@=","370000000000");
		if(name!=''&&name!="undefined"&&name!="null"){
			somOrganDataSet.setParameter("CN_NAME@LIKE","%"+name+"%");
			document.getElementsByName("cnName")[0].value=name;
		}
		somOrganDataSet.load();
		somOrganDataSet.on("load",function(ds){
			//alert(ds.getPageSize());
			document.getElementById("totalNum").innerHTML=ds.getTotalCount()+" 个";
			document.getElementById("currentPageNum").innerHTML=ds.getPageIndex()+"/"+ds.getTotalPage()+"页";
		});
	}
	
	function turnNext(){
		somOrganDataSet.turnNext();
	}
	function turnPre(){
		somOrganDataSet.turnPrev();
	}
	function turnLast(){
		somOrganDataSet.turnLast();
	}
	function turnFirst(){
		somOrganDataSet.turnFirst();
	}
	function turnPage(){
		somOrganDataSet.turnPage(document.getElementById("to_page").value);
	}
	
	function onSubmit(){
		somOrganDataSet.setParameter("IF_BRANCH@=","0");
		somOrganDataSet.setParameter("MORG_AREA@=","370000000000");
		somOrganDataSet.setParameter("CN_NAME@LIKE","%"+document.getElementsByName("cnName")[0].value+"%");
		somOrganDataSet.setParameter("SORG_CODE@=",document.getElementsByName("sorgCode")[0].value);
		somOrganDataSet.setParameter("SORG_TYPE@=",document.getElementsByName("sorgType")[0].value);
		somOrganDataSet.load();
		somOrganDataSet.on("load",function(ds){
			//alert(ds.getPageSize());
			document.getElementById("totalNum").innerHTML=ds.getTotalCount()+" 个";
			document.getElementById("currentPageNum").innerHTML=ds.getPageIndex()+"/"+ds.getTotalPage()+"页";
		});
	}

   
</script>
<script> 
	function SetWinHeight(obj)
{
	
    var win=obj;
    if (document.getElementById)
    {
        if (win && !window.opera)
        {
            if (win.contentDocument && win.contentDocument.body.offsetHeight) 

                win.height = win.contentDocument.body.offsetHeight; 
            else if(win.Document && win.Document.body.scrollHeight)
                win.height = win.Document.body.scrollHeight;
        }
    }
}
</script>
<body>

<model:datasets>
	<%--基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomOrganOnlineQueryCommand" global="true" pageSize="20">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<!-- 社会组织状态 -->
	<model:dataset id="sorgStatus" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>	
<div id="html_1"><iframe align="center" width="998" height="195" src="http://www.sdmz.gov.cn/mgj/channels/ch00266/" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no"></iframe></div>
<div style=" width:998px;margin:0 auto;">
	
	<div class="f-div" style="margin:0 auto;">
	<div class="bscx-div-1">
	<div class="bscx-div-2" align="center">
	<img src="images/bscw-1.jpg" width="220" height="30" />
	<form name="myform" method="post" action=""> 
	<table width="630" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="mar-top">
	  <tr>
	  	<td colspan="4"  bgcolor="#FFFFFF" align="center">
	  		<span>查询系统测试运行阶段，信息仅供参考，相关信息以社会组织登记档案记载为准。</span>
	  	</td>
	  </tr>
	  <tr>
	    <td width="15%" height="35" align="right" bgcolor="#FFFFFF" >社会组织名称：</td>
	    <td colspan="3" bgcolor="#FFFFFF">&nbsp;<input type="text" name="cnName"  value="" class="bscx-input"/></td>
	    </tr>
	  <tr>
	    <td  height="35" align="right" bgcolor="#FFFFFF">社会组织类型：</td>
	    <td  width="35%" bgcolor="#FFFFFF">&nbsp;
		<select name="sorgType">
			<option value="">全部</option>
			<option value="S">社会团体</option>
			<option value="M">民办非企业单位</option>
			<option value="J">基金会</option>
		</select>
		</td>
		<td  height="35" align="right" bgcolor="#FFFFFF">登记证号：</td>
	    <td width="35%" bgcolor="#FFFFFF">&nbsp;<input type="text" name="sorgCode" value="" class="bscx-input"/></td>
	  </tr>
	</table>
	</form>
	<div class="bscx-div-3"><a href="#"><img src="images/bscw-2.jpg" width="48" height="20" border="0" onClick="onSubmit()" /></a></div>
	
	<div  class="bscx-div-4">
	<div  class="bscx-div-5 word-29">社会组织查询结果</div>
	<div  class="bscx-div-6"><a href="allQueryApply.jsp" target="_parent">行政许可</a></div>
	<div  class="bscx-div-6"><a href='allQueryCheck.jsp' target="_parent">年检结果</a></div>
	
	
	</div>
	
	<div class="bscx-div-7">
	
	<table width="630" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#abc3cd" class="mar-top">
	  <tr class="word-22">
	    <td width="30%"  height="35" align="center" valign="middle" bgcolor="#d5e4eb">名称</td>
	    <td width="10%"  align="center" valign="middle" bgcolor="#d5e4eb">登记证号</td>
	    <td width="17%"  align="center" valign="middle" bgcolor="#d5e4eb">业务主管单位</td>
	    <td width="11%"  align="center" valign="middle" bgcolor="#d5e4eb">法定代表人</td>
	    <td width="22%" align="center" valign="middle" bgcolor="#d5e4eb">住所</td>
	    <td width="10%" align="center" valign="middle" bgcolor="#d5e4eb">状态</td>
	  </tr>
	</table>
	<table width="630" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#abc3cd"  dataset="somOrganDataSet">
	  <tr  repeat="true" class="word-22">
	    <td width="30%" height="35" align="center" valign="middle" bgcolor="#FFFFFF"><label field="cnName" /></td>
	    <td width="10%" align="center" valign="middle" bgcolor="#FFFFFF"><label field="sorgCode" /></td>
	    <td width="17%" align="center" valign="middle" bgcolor="#FFFFFF"><label  field="borgName" dataset="businessOrganSelect"/></td>
	    <td width="11%" align="center" valign="middle" bgcolor="#FFFFFF"><label field="legalPeople" /></td>
	    <td width="22%" align="center" valign="middle" bgcolor="#FFFFFF">
		<label field="residence" /></td>
	    <td width="10%" align="center" valign="middle" bgcolor="#FFFFFF">
	    <label field="sorgStatus" dataset="sorgStatus"/></td>
	  </tr>
	</table>
	<div class="bscx-div-8">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="41%" height="40" align="left">查到的社会组织共有 <label id="totalNum" /></td>
	        <td width="59%" align="right">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="page">
					<tr>
						<form name="searchOrgForm" action="searchOrgList.do?action=searchOrgList" method="post">
							<td align="left">
								<input type="hidden" name="orgName" value="">    	        
								<input type="hidden" name="corporateType" value="">
								<input type="hidden" name="managerDeptCode" value="">
								<input type="hidden" name="registrationNo" value="">
								<input type="hidden" name="page_flag" value="true">
								<input type="hidden" name="pagesize_key" value="result">
								<input type="hidden" name="goto_page" value="">
								<input type="hidden" name="current_page" value="1">
								<input type="hidden" name="total_count" value="2136">
								<td align="right">
									&nbsp;<a href="#" onclick="turnFirst()">首页</a>&nbsp;|&nbsp;<a href="#" onclick="turnPre();">上页</a>&nbsp;|&nbsp;<a href="#" onclick="turnNext();">下页</a>&nbsp;|&nbsp;<a href="#" onclick="turnLast();">末页</a>&nbsp;&nbsp;第<label id="currentPageNum" />&nbsp;转到<input type="text" id="to_page" size="2">页<button onclick="turnPage();">-&gt;</button>
								</td>
							</td>
						</form>
					</tr>
				</table>
	 		</td>
	      </tr>
	</table>
	</div>
	</div>
	</div>
	</div>
</div>
</body>
</html>
