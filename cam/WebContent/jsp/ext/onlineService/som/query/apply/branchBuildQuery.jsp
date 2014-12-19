<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" /> 
<meta http-equiv="x-ua-compatible" content="ie=7" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />

<title>社会组织查询</title>
<next:ScriptManager></next:ScriptManager>
</head>
<script language="javascript">
	function init(){
		var sorgCode = parent.document.myform.sorgCode.value;
		var cnName = parent.document.myform.cnName.value;
		somOrganDataSet.setParameter("SORG_CODE@=",sorgCode);
		somOrganDataSet.setParameter("CN_NAME@=",cnName);
		somOrganDataSet.setParameter("IF_BRANCH@=","1");
		somOrganDataSet.setParameter("MORG_AREA@=","370000000000");
		somOrganDataSet.setParameter("SORG_STATUS@=","22");
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
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomOrganOnlineQueryCommand" global="true" pageSize="20" sortField="BUILD_DATE" sortDirection="DESC NULLS LAST">
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

<table width="730" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#abc3cd">
  <tr class="word-22">
    <td width="40%"  height="35" align="center" valign="middle" bgcolor="#d5e4eb">名称</td>
    <td width="10%"  align="center" valign="middle" bgcolor="#d5e4eb">登记证号</td>
    <td width="40%" align="center" valign="middle" bgcolor="#d5e4eb">住所</td>
    <td width="10%" align="center" valign="middle" bgcolor="#d5e4eb">批准时间</td>
  </tr>
</table>
<table width="730" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#abc3cd"  dataset="somOrganDataSet">
  <tr  repeat="true" class="word-22">
    <td width="40%" height="35" align="center" valign="middle" bgcolor="#FFFFFF"><label field="cnName" /></td>
    <td width="10%" align="center" valign="middle" bgcolor="#FFFFFF"><label field="sorgCode" /></td>
    <td width="40%" align="center" valign="middle" bgcolor="#FFFFFF">
	<label field="residence" /></td>
    <td width="10%" align="center" valign="middle" bgcolor="#FFFFFF">
    <label field="buildDate"/></td>
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
</body>
</html>
