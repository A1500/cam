<%@page contentType="text/html; charset=UTF-8"  session="false"%>

<%@page import="java.sql.*"%>

<%@page
	import="org.loushang.persistent.jdbc.datasource.DataSourceFactory"%>

<%@page import="javax.sql.DataSource"%>

<style type="text/css">
.red {
	color: red;
	background-color: #ffffcc;
	border: #ccc 1px solid;
	line-height: 25px;
	margin: 5px 0;
	font-family: Arial
}

.blue {
	color: blue;
	background-color: #ffffcc;
	border: #ccc 1px solid;
	line-height: 25px;
	margin: 5px 0;
	font-family: Arial
}

div {
	font-size: 16px;
	font-weight: bold;
	padding: 5px 0;
	font-family: Arial
}

table {
	border-collapse: collapse;
	width: 100%;
	font-size: 16px;
	font-family: Arial;
	line-height: 25px;
}

table th {
	background-color: #ccc;
	font-weight: bold
}

textarea {
	border: #000 1px solid;
	overflow: hidden;
	font-weight: bold;
	width: 100%;
	height: 100px;
	font-family: Arial
	color:red;
}

input {
	border: #000 1px solid;
	background-color: #fff;
	height: 22px;
	cursor: pointer;
	font-family: Arial
}
</style>

<%
	Connection con = null;

	PreparedStatement pst = null;

	try {

		DataSource dataSource = DataSourceFactory.defaultFactory
				.getDataSource("dataSource");

		con = dataSource.getConnection();

		DatabaseMetaData dbmeta = con.getMetaData();

%>

<div>
<table>
<tr>
<td>
数据库产品版本: </td><td><%=dbmeta.getDatabaseProductVersion()%></td>
</tr>
<tr><td>

数据源URL:</td><td><%=dbmeta.getURL()%></td></tr><tr>
<td>

用户schema:</td><td><%=dbmeta.getUserName()%></td></tr></table>
</div>

<hr size=1>
<div>
</div>
<%
	String sql = request.getParameter("sql");

		if (sql == null || "".equals(sql))

			sql="";
%>

<form method=post action="" style="margin: 2px 0;">
<textarea
	id="sqlarea" name="sql" id="sql" style="color:red"><%=sql %></textarea>

<div><select
	onchange="document.getElementById('sqlarea').style.fontSize=this.value;"
	name="fontSize">

	<option value="12" selected>12px</option>

	<option value="14" ${param.fontSize==14?'selected':''}>14px</option>

	<option value="16" ${param.fontSize==16?'selected':''}>16px</option>

	<option value="18" ${param.fontSize==18?'selected':''}>18px</option>

	<option value="20" ${param.fontSize==20?'selected':''}>20px</option>

	<option value="24" ${param.fontSize==24?'selected':''}>24px</option>

</select> <input type="button" value="执行" onclick="document.forms[0].submit()">

</div>

</form>



<hr size="1">

<%
if (sql == null || "".equals(sql))

	return ;
	pst = con.prepareStatement(sql, 1004, 1008);

		if (pst.execute()) {

			ResultSet rs = pst.getResultSet();

			rs.last();

			int rowCount = rs.getRow();

			out.println("<div class=blue>查询行数：" + rowCount + "</div>");

			rs.beforeFirst();

			ResultSetMetaData metaData = rs.getMetaData();

			int columnCount = metaData.getColumnCount();

			String fontSize = request.getParameter("fontSize");

			out

			.print("<table border=1 bordercolor=#000 style='font-size:"

			+ (fontSize == null ? "12" : fontSize)

			+ "px'><tr><th width='100'></th>");

			for (int i = 1; i <= columnCount; i++)

				out.println("<th>" + metaData.getColumnName(i)

				+ "</th>");

			out.println(" </tr>");

			int rowscount = 1;

			while (rs.next()) {

				out.println("<tr><th>" + rowscount + "</th>");

				for (int i = 1; i <= columnCount; i++)

					out.println("<td>" + rs.getObject(i) + "</td>");

				out.println("</tr>");

				rowscount++;

			}

			out.println("</table>");

			out.println("<div class=blue>查询行数：" + rowCount + "</div>");

		} else

			out.println("<div class=blue>影响行数：" + pst.getUpdateCount()

			+ "</div>");

	} catch (Exception ex) {

		out.println("<div class=red>" + ex.toString() + "</div>");

	} finally {

		try {

			if (pst != null)

				pst.close();

			if (con != null)

				con.close();

		} catch (Exception ex) {

			out.println("<div class=red>" + ex.toString() + "</div>");

		}

	}
%>
