package com.inspur.cams.bpt.util;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

/**
 * 读取excel
 * 
 * @author wang_yong
 * 
 */
public class ReadExcel {
	private static String tableName = "bpt_imp_people_disability";// 伤残人员信息及类别信息
	private static String tableNameMake = "bpt_imp_people_disability_make";// 伤残人员信息及类别信息
	private static Connection conn = null;
	private static String drive = "oracle.jdbc.OracleDriver";
	private static String DBurl = "jdbc:oracle:thin:@10.9.12.11:1521:cams";
	private static String name = "cams"; // 数据库账号
	private static String pwd = "cams"; // 数据库,密码
	private static Statement st = null;
	private static String errorMess = "";
	static boolean valiFlag = true;

	// private static final String
	// disability_cols=CamsProperties.getString("disability_cols");//可以通过配置文件定义

	public static void main(String[] args) {
		// setTableName("bpt_imp_people_disability");
		System.out.println("-------------------开始-------------------");
		System.out.println("-----------------删除开始------------------");
		deleImpotData("370102000000");
		System.out.println("-----------------删除结束------------------");
		System.out.println("-----------------读取文件开始------------------");
		readExcel("D:/disability.xls", "370102000000");
		System.out.println("-----------------读取文件结束------------------");
		deleMakeData("370102000000");
		validate("370102000000");
		try {
			conn.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			Close();
		}

	}

	public static void deleImpotData(String organ_code) {
		StringBuffer sql = new StringBuffer("delete from ").append(tableName)
				.append(" where organ_code ='").append(organ_code).append("'");
		System.out.println("delete sql is------" + sql.toString());
		delete(sql.toString());
		try {
			conn.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public static void deleMakeData(String organ_code) {
		StringBuffer sql = new StringBuffer("delete from ").append(
				tableNameMake).append(" where organ_code ='")
				.append(organ_code).append(
						"' and  id_card in(select id_card from ").append(
						tableName).append(" where organ_code ='").append(
						organ_code).append("')");
		System.out.println("delete sql is------" + sql.toString());
		delete(sql.toString());
		try {
			conn.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public static void readExcel(String url, String organ_code) {
		File filename = new File(url);
		Workbook wb = null;
		String parameter = "organ_code,id_card,name,nation,sex,"
				+ "relationship_type,domicile_type,domicile_code,"
				+ "domicile_address,apanage_code,address,safeguard_type,"
				+ "medical_code,pension_code,tel_mobile,tel_other,post_code,"
				+ "marriage_code,edu_code,health_code,political_code,"
				+ "employment_code,income_year,work_unit_name,work_unit_character,work_unit_tel,"
				+ "work_unit_add,disability_type_code,disability_level_code,disability_case_code,"
				+ "disability_state_code,disability_no,approve_date,conscript_date,disability_war_code,"
				+ "disability_genus_code,veterans_date,retired_date,uinit_of_disability,"
				+ "disability_add,disability_body,"
				+ "disability_reason,old_lonely_flag,insanity_flag,work_ability_code,viability_code,"
				+ "support_pattern,bank, account_code,note )";
		String value = "";
		try {
			wb = Workbook.getWorkbook(filename);
			Sheet s = wb.getSheet(0);// 第1个sheet
			Cell c = null;
			int row = s.getRows();// 总行数
			int col = s.getColumns();// 总列数
			System.out.println("总列数=" + col);
			System.out.println("总行数=" + row);
			for (int i = 1; i < row; i++) {
				value = "";
				StringBuffer sql = new StringBuffer("insert into ").append(
						tableName).append(" ( ");
				for (int j = 1; j < col; j++) {
					c = s.getCell(j, i);
					if (j < col - 1) {
						value += "'" + c.getContents().trim() + "',";
					} else {
						value += "'" + c.getContents().trim() + "'";
					}
				}
				sql.append(parameter).append(" values ('" + organ_code + "',")
						.append(value).append(")");
				System.out.println("添加语句-------" + sql.toString());
				int a = insert(sql.toString());
				if (a > 0) {
					System.out.println("成功添加第" + i + "行");
				} else {
					System.out.println("第" + i + "行添加失败了");
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (BiffException e) {
			e.printStackTrace();
		}
	}

	public static Connection getConn() {
		try {
			Class.forName(drive);
			if (conn == null) {
				conn = DriverManager.getConnection(DBurl, name, pwd);
				// System.out.println(conn);
				// conn.setAutoCommit(false);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	public static void Close() {
		if (conn != null)
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
	}

	public static int insert(String sql) {
		int result = 0;
		try {
			st = getConn().createStatement();
			result = st.executeUpdate(sql);
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			System.out.println("添加失败");
		}
		return result;
	}

	public static int delete(String sql) {
		int result = 0;
		try {
			st = getConn().createStatement();
			result = st.executeUpdate(sql);
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			System.out.println("删除失败");
		}
		return result;
	}

	public static int Create(String sql) throws Exception {
		int result = 0;
		try {
			st = getConn().createStatement();
			result = st.executeUpdate(sql);
		} finally {
			st.close();
		}
		return result;
	}

	/**
	 * 
	 * @param sql
	 * @return 0或1
	 */
	public static int getCount(String sql) {
		try {
			st = getConn().createStatement();
			ResultSet res = st.executeQuery(sql);
			while (res.next()) {
				if (res.getInt(1) >= 1)
					return 1;
				else
					return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				st.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return 0;
	}
	/**
	 * 
	 * @param organ_code
	 */
	public static void validate(String organ_code) {
		String sql = "select * from " + tableName + " where organ_code='"
				+ organ_code + "'";
		try {
			st = getConn().createStatement();
			ResultSet res = st.executeQuery(sql);
			int c = res.getMetaData().getColumnCount();
			String columnName = "";
			String value = "";
			String sqlValue = "";
			StringBuffer insertSql;
			String parameter = "";
			int row = 0;
			while (res.next()) {
				insertSql = new StringBuffer("insert into ").append(
						tableNameMake).append("(");
				sqlValue = "";
				errorMess = "";
				parameter = "";
				valiFlag=true;
				for (int i = 1; i <= c; i++) {
					columnName = res.getMetaData().getColumnName(i)
							.toUpperCase();// 获得字段名称
					value = res.getString(i);
					value = value == null ? "" : value;
					if (i < c) {
						parameter += columnName + ",";
						if (valiFlag) {
							sqlValue += "'"
									+ make(columnName, value, organ_code)
									+ "',";
						} else {
							sqlValue += "'"
									+ make(columnName, value, organ_code)
									+ "',";
						}
					} else {
						parameter += columnName
								+ ",validate_flag,ERROR_MESSAGE,COMMIT_FLAG";
						if (valiFlag) {
							sqlValue += "'"
									+ make(columnName, value, organ_code)
									+ "','1','','0'";
						} else
						{
							sqlValue += "'"
									+ make(columnName, value, organ_code)
									+ "','0','" + errorMess + "','0'";
						}
					}
					System.out.println("errorMess---" + errorMess);
					System.out.println("valiFlag---" + valiFlag);
				}
				row++;
				insertSql.append(parameter).append(") values( ").append(
						sqlValue).append(")");
				System.out.println("添加语句-------" + insertSql.toString());
				int a = insert(insertSql.toString());
				if (a > 0) {
					System.out.println("成功添加第" + row + "行");
				} else {
					System.out.println("第" + row + "行添加失败了");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				st.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/*
	 * private static void setTableName(String tableName) { tableName=tableName; }
	 */
	static String make(String columnName, String value, String organ_code) {
		String[] columnValue = { "", "" };
		if (columnName.equals("ID_CARD")) {
			columnValue = DisabilityValidate.is_id_card(value);
			if (columnValue[0].equals("0"))// 校验未通过
			{
				valiFlag = false;
				errorMess += "身份证格式不正确" + ",";				
			} 
			return columnValue[1];
		} else if (columnName.equals("NAME")) {
			columnValue = DisabilityValidate.is_name(value);
		} else if (columnName.equals("SEX")) {
			columnValue = DisabilityValidate.is_sex(value);
		} else if (columnName.equals("RELATIONSHIP_TYPE")) {
			columnValue = DisabilityValidate.is_relationship_type(value);
		} else if (columnName.equals("DOMICILE_TYPE")) {
			columnValue = DisabilityValidate.is_domicile_type(value);
		} else if (columnName.equals("DOMICILE_CODE")) {
			columnValue = DisabilityValidate
					.is_domicile_code(value, organ_code);
		} else if (columnName.equals("APANAGE_CODE")) {
			columnValue = DisabilityValidate.is_apanage_code(value, organ_code);
		} else if (columnName.equals("SAFEGUARD_TYPE")) {
			columnValue = DisabilityValidate.is_safeguard_type(value);
		} else if (columnName.equals("PENSION_CODE")) {
			columnValue = DisabilityValidate.is_pension_code(value);
		} else if (columnName.equals("POST_CODE")) {
			columnValue = DisabilityValidate.is_post_code(value);
		} else if (columnName.equals("MARRIAGE_CODE")) {
			columnValue = DisabilityValidate.is_marriage_code(value);
		} else if (columnName.equals("EDU_CODE")) {
			columnValue = DisabilityValidate.is_edu_code(value);
		} else if (columnName.equals("HEALTH_CODE")) {
			columnValue = DisabilityValidate.is_health_code(value);// 政治面貌
		} else if (columnName.equals("POLITICAL_CODE")) {
			columnValue = DisabilityValidate.is_political_code(value);// 就业状况
		} else if (columnName.equals("EMPLOYMENT_CODE")) {
			columnValue = DisabilityValidate.is_employment_code(value);
		} else if (columnName.equals("INCOME_YEAR")) {
			columnValue = DisabilityValidate.is_income_year(value);
		} else if (columnName.equals("DISABILITY_TYPE_CODE")) {
			columnValue = DisabilityValidate.is_disability_type_code(value);
		} else if (columnName.equals("DISABILITY_LEVEL_CODE")) {
			columnValue = DisabilityValidate.is_disability_level_code(value);
		} else if (columnName.equals("DISABILITY_CASE_CODE")) {
			columnValue = DisabilityValidate.is_disability_case_code(value);
		} else if (columnName.equals("DISABILITY_STATE_CODE")) {
			columnValue = DisabilityValidate.is_disability_state_code(value);
		} else if (columnName.equals("DISABILITY_NO")) {
			columnValue = DisabilityValidate.is_disability_no(value);
		} else if (columnName.equals("APPROVE_DATE")) {
			columnValue = DisabilityValidate.is_approve_date(value);
		} else if (columnName.equals("CONSCRIPT_DATE"))// 入伍参加工作时间
		{
			columnValue = DisabilityValidate.is_conscript_date(value);
		} else if (columnName.equals("DISABILITY_WAR_CODE")) {
			columnValue = DisabilityValidate.is_disability_war_code(value);
		} else if (columnName.equals("DISABILITY_GENUS_CODE")) {
			columnValue = DisabilityValidate.is_disability_genus_code(value);
		} else if (columnName.equals("VETERANS_DATE")) {
			columnValue = DisabilityValidate.is_veterans_date(value);
		} else if (columnName.equals("RETIRED_DATE")) {
			columnValue = DisabilityValidate.is_retired_date(value);
		} else if (columnName.equals("DISABILITY_ADD")) {
			columnValue = DisabilityValidate.is_disability_add(value);
		} else if (columnName.equals("DISABILITY_BODY")) {
			columnValue = DisabilityValidate.is_disability_body(value);
		} else if (columnName.equals("DISABILITY_REASON")) {
			columnValue = DisabilityValidate.is_disability_reason(value);
		} else if (columnName.equals("OLD_LONELY_FLAG")) {
			columnValue = DisabilityValidate.is_old_lonely_flag(value);
		} else if (columnName.equals("INSANITY_FLAG")) {
			columnValue = DisabilityValidate.is_insanity_flag(value);
		} else if (columnName.equals("WORK_ABILITY_CODE")) {
			columnValue = DisabilityValidate.is_work_ability_code(value);
		} else if (columnName.equals("VIABILITY_CODE")) {
			columnValue = DisabilityValidate.is_viability_code(value);
		} else if (columnName.equals("SUPPORT_PATTERN")) {
			columnValue = DisabilityValidate.is_support_pattern(value);
		} else if (columnName.equals("BANK")) {
			columnValue = DisabilityValidate.is_bank(value);
		} else if (columnName.equals("ACCOUNT_CODE")) {
			columnValue = DisabilityValidate.is_account_code(value);
		} else {
			columnValue[0] = "1";
			columnValue[1] = value;
		}
		if (columnValue[0].equals("0"))// 校验未通过
		{
			valiFlag = false;
			errorMess += columnValue[1] + ",";
			System.out.println(errorMess);
			return "";
		} else// 校验通过
		{
			// valiFlag=true;
			// errorMess+=columnValue[1];
			return columnValue[1];
		}

	}
}