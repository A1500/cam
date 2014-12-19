<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*,java.util.*,java.sql.*,javax.sql.*,javax.naming.*"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
</head>
<body>

<%!public static String excuteFile(File file, String linepara, Statement stmt,
			org.loushang.next.i18n.ResourceBundle res) {
		if (!file.isFile())
			return res.get("BSPOTHER.NEW_URL_A_FILE") + file;
		BufferedReader is = null;
		StringBuffer message = new StringBuffer();
		message.append("<BR>" + res.get("BSPOTHER.READ_FILE") + file);
		try {
			is = new BufferedReader(new InputStreamReader(new FileInputStream(
					file), "UTF-8"));
			String readline = "";
			StringBuffer sqlstr = new StringBuffer();
			int i = 0;
			while ((readline = is.readLine()) != null) {
				readline = readline.trim();

				if (readline.startsWith("--")
						|| readline.equalsIgnoreCase("COMMIT;"))
					continue;
				sqlstr.append(" " + readline);
				if (readline.endsWith(linepara)) {
					try {						
						sqlstr.append(linepara);						
						stmt.executeUpdate(sqlstr.toString().replaceAll(
								linepara + linepara, ""));						
						i++;						
					} catch (SQLException e) {
						message.append("<br><font color=red>"
								+ res.get("BSPOTHER.EXECUTE_SQL_ERROR")
								+ sqlstr.toString().replaceAll(
										linepara + linepara, "")
								+ "</font><br>"
								+ res.get("BSPOTHER.ERROR_EXCEPTION_INFO") + e);

					}
					sqlstr = new StringBuffer();
				}
			}
			is.close();
			is = null;
			message.append("<BR><font color=blue>"
					+ res.get("BSPOTHER.OVER_EXECUTE_SUCCESS_SQL") + i
					+ res.get("BSPOTHER.RECORD") + "</font>");
		} catch (FileNotFoundException e) {
			message.append("<br><font color=red>"+res.get("BSPOTHER.FILE") + file
					+ res.get("BSPOTHER.NOT_FOUND") + e);
			e.printStackTrace();
		} catch (IOException e) {
			message.append("<br><font color=red>"
					+ res.get("BSPOTHER.READ_FILE") + file
					+ res.get("BSPOTHER.IS_ERROR") + e);
			e.printStackTrace();
		} finally {
			if (is != null)
				try {
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			is = null;
		}

		return message.toString();
	};


	public List findFile(File dir) {
		//out.println("<br>查看文件路径：" + dir + "下面的文件");
		if (dir == null || !dir.isDirectory())
			return new ArrayList();
		File files[] = queue(dir.listFiles());
		List list = new ArrayList();
		for (int i = 0; i < files.length; i++) {
			if (files[i].isFile())
				list.add(files[i]);
		}
		return list;
	}

	public List findDirectoy(File dir) {
		//out.println("<br>查看文件路径：" + dir + "下面的文件");
		if (dir == null || !dir.isDirectory())
			return new ArrayList();
		File files[] = queue(dir.listFiles());
		List list = new ArrayList();
		for (int i = 0; i < files.length; i++) {
			if (files[i].isDirectory())
				list.add(files[i]);
		}
		return list;
	}

	public List findAllFile(File dir) {
		if (dir == null || !dir.isDirectory())
			return new ArrayList();
		List filelist = new ArrayList();
		filelist.addAll(findFile(dir));
		List directorylist = findDirectoy(dir);

		for (int i = 0; i < directorylist.size(); i++)
			filelist.addAll(findAllFile((File) directorylist.get(i)));

		return filelist;
	}

	public String null2String(String s) {
		return s != null ? s : "";
	}

	public static File[] queue(File fileList[]) {
		for (int i = 0; i < fileList.length; i++) {
			for (int j = i + 1; j < fileList.length; j++) {
				if (fileList[i].compareTo(fileList[j]) > 0) {
					File tmpfileList = fileList[i];
					fileList[i] = fileList[j];
					fileList[j] = tmpfileList;
				}
			}
		}
		return fileList;
	}
	public static List queueFile(List filelist) {
		List createTableFiles = new ArrayList();
		List initTableFiles = new ArrayList();
		
		for (int i = 0; i < filelist.size(); i++) {
			try {
				File sqlFile = (File) filelist.get(i);
				if (sqlFile.toString().indexOf("1_Create") != -1) {
					createTableFiles.add(sqlFile);
				} else {
					initTableFiles.add(sqlFile);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		for (int i = 0; i < initTableFiles.size(); i++) {
			try {
				File initSqlFile = (File) initTableFiles.get(i);
				createTableFiles.add(initSqlFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return createTableFiles;
	}
%>
<%
	response.setHeader("cache-control", "no-cache");
	response.setHeader("pragma", "no-cache");

	String dbserver = null2String(request.getParameter("dbserver"));
	String dbname = null2String(request.getParameter("dbname"));
	String username = null2String(request.getParameter("username"));
	String password = null2String(request.getParameter("password"));
	String dbtype = null2String(request.getParameter("dbtype"));
	String jndiType = null2String(request.getParameter("jndiType"));
	String jndiName = null2String(request.getParameter("jndiName"));
%>
<%
	String url = "";
	String forname = "";
	StringBuffer message = new StringBuffer();
	String path = getServletConfig().getServletContext().getRealPath(
			"/sql");
	String linepara = ";";
	String sqlfile = "";

	Connection conn = null;
	Statement stmt = null;
	ResultSet set = null;

	response.flushBuffer();
	if (dbtype.equals(""))
		dbtype = "dataSource";
	if (dbtype.equals("dataSource")) {
		try {//取默认的数据源对象
			out.println("<BR>"
					+ res.get("BSPOTHER.USE_CONFIG_CONNECT_DB"));
			DataSource dataSource = org.loushang.persistent.jdbc.datasource.DataSourceFactory.defaultFactory
					.getDataSource("dataSource");
			conn = dataSource.getConnection();
		} catch (Exception f) {
			message.append(res
					.get("BSPOTHER.GET_DEFAULT_DATASOURCE_ERROR")
					+ f);
		}
	} else if (dbtype.equals("jndi")) {
		if (jndiType.equals("2"))
			jndiName = "java:comp/env/" + jndiName;
		out.println("<BR>" + res.get("BSPOTHER.CONNECT_TYPE_JNDI")
				+ "jndiName=" + jndiName);
		try {
			Context ctx = new InitialContext(); // 访问jndi根目录
			DataSource ds = (DataSource) ctx.lookup(jndiName);
			conn = ds.getConnection();			
		} catch (NamingException e1) {

			message.append("<BR>" + res.get("BSPOTHER.IS_ERROR") + e1);
			e1.printStackTrace();
			// throw new RuntimeException(e1);

		} catch (SQLException e1) {

			message.append("<BR>" + res.get("BSPOTHER.IS_ERROR") + e1);
			e1.printStackTrace();
		}
	} else {
		if (dbtype.equals("1")) {
			url = "jdbc:microsoft:sqlserver://" + dbserver
					+ ":1433;DatabaseName=" + dbname;
			forname = "com.microsoft.jdbc.sqlserver.SQLServerDriver";

		} else if (dbtype.equals("2")) {
			url = "jdbc:oracle:thin:@" + dbserver + ":1521:" + dbname;
			forname = "oracle.jdbc.OracleDriver";
		} else if (dbtype.equals("4")) {
			url = "jdbc:db2://" + dbserver + ":50000/" + dbname;
			// forname = "COM.ibm.db2.jdbc.net.DB2Driver";
			forname = "com.ibm.db2.jcc.DB2Driver";
		} else if (dbtype.equals("3")) {
			url = "jdbc:db2:" + dbname;
			forname = "COM.ibm.db2.jdbc.app.DB2Driver";
		}
		try {
			out.println("<BR>"
					+ res.get("BSPOTHER.CONNECT_TYPE_DIRECT_CONNECT")
					+ "url=" + url);
			Driver driver = (Driver) Class.forName(forname)
					.newInstance();
			DriverManager.registerDriver(driver);
			Properties props = new Properties();
			props.put("user", username);
			props.put("password", password);
			props.put("CHARSET", "ISO");
			conn = DriverManager.getConnection(url, props);
		} catch (InstantiationException e) {
			message.append("<BR>" + res.get("BSPOTHER.DB_DRIVER_ERROR")
					+ e);
			e.printStackTrace();
			//throw new RuntimeException("可能原因：数据库驱动程序不正确", e);
		} catch (IllegalAccessException e) {
			//out.println("<BR>出错了：" + e);
			message.append("<BR>" + res.get("BSPOTHER.IS_ERROR") + e);
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			//out.println("<BR>出错了：" + e);
			message.append("<BR>" + res.get("BSPOTHER.IS_ERROR") + e);
			e.printStackTrace();
		} catch (SQLException e) {
			//out.println("<BR>出错了：" + e);
			message.append("<BR>" + res.get("BSPOTHER.IS_ERROR") + e);
			e.printStackTrace();
		}

	}
	if (!message.toString().equals("")) {
		out.println("<BR>" + res.get("BSPOTHER.DB_CONNECT_FAIL")
				+ "<BR>");
		message.append("<BR><A HREF=\"../../\">"
				+ res.get("BSPOTHER.ENTER_OS") + "</A>");
		message.append("<br><A HREF=\"datamain.jsp\">"
				+ res.get("BSPOTHER.BACK") + "</A>");

		out.println(message);
		try {
			if (conn != null)
				conn.close();
		} catch (java.sql.SQLException se) {
		}
		conn = null;
		return;
	}

	String dbName = null;
	try {
		if (conn != null) {
			DatabaseMetaData dbmd = conn.getMetaData();
			if (dbmd != null) {
				dbName = dbmd.getDatabaseProductName();
				out.println("<br>" + res.get("SYS.DATABASETYPE") + ":"
						+ dbName);
				if (dbName != null && dbName.startsWith("DB2/")) {
					path = getServletConfig().getServletContext()
							.getRealPath("/sql/DB2");//DB2 
				} else if (dbName != null
						&& dbName.startsWith("Adaptive")) {
					path = getServletConfig().getServletContext()
							.getRealPath("/sql/Sybase");//Sybase 
				} else if (dbName != null
						&& dbName.startsWith("Microsoft")) {
					path = getServletConfig().getServletContext()
							.getRealPath("/sql/SqlServer");//Microsoft SQL Server
				} else if (dbName != null
						&& dbName.startsWith("Oracle")) {
					path = getServletConfig().getServletContext()
							.getRealPath("/sql/Oracle");//Oracle
				}
			}

		}

	} catch (SQLException e1) {
		e1.printStackTrace();
	}

	out.println("<BR>" + res.get("BSPOTHER.DB_CONNECT_SUCCESSFUL")
			+ "<BR>");
	out.println("<BR>" + res.get("BSPOTHER.START_READ_INIT_FILE")
			+ "<BR>");
	File dir = null;
	String fileList[] = null;

	try {
		try {
			dir = new File(path);
			fileList = dir.list();
			if (fileList == null) {
				dir = new File(getServletConfig().getServletContext()
						.getRealPath("/sql"));
				fileList = dir.list();
			}
		} catch (Exception e) {
			out.println("<BR>" + res.get("BSPOTHER.IS_ERROR") + e);
			e.printStackTrace();
		}
		if (fileList == null) {
			out
					.println("<BR>"
							+ res
									.get("BSPOTHER.ERROR_NOT_FOUND_FOLDER")
							+ path);
			out.println("<BR><A HREF=\"../../\">"
					+ res.get("BSPOTHER.ENTER_OS") + "</A>");
			out.println("<br><A HREF=\"datamain.jsp\">"
					+ res.get("BSPOTHER.BACK") + "</A>");
			return;
		}
		out.println("<br>" + res.get("BSPOTHER.START_EXECUTE_SQL"));
		stmt = conn.createStatement();

		List filelist = findAllFile(dir);
		filelist = queueFile(filelist);
		for (int i = 0; i < filelist.size(); i++) {
			try {
				File sqlFile = (File) filelist.get(i);

				if (sqlFile.toString().endsWith(".sql")) {
					out
							.println(excuteFile(sqlFile, linepara,
									stmt, res));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	} catch (SQLException e) {
		out.println("<BR>" + res.get("BSPOTHER.IS_ERROR") + e);
		e.printStackTrace();
	} catch (Exception e) {
		out.println("<BR>" + res.get("BSPOTHER.IS_ERROR") + e);
		e.printStackTrace();
	} finally {
		if (set != null) {
			try {
				set.close();
			} catch (SQLException e) {
			}
			set = null;
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (SQLException e) {
			}
			stmt = null;
		}
		try {
			if (conn != null)
				conn.close();
		} catch (java.sql.SQLException se) {
		}
		conn = null;
	}	
%>
<%//=message%>
<br>
<br>
<%=res.get("BSPOTHER.INIT_OVER")%>
<br>
<A HREF="../../"><%=res.get("BSPOTHER.ENTER_OS")%></A>
<BR>
<A HREF="datamain.jsp"><%=res.get("BSPOTHER.BACK")%></A>

</body>
</html>
