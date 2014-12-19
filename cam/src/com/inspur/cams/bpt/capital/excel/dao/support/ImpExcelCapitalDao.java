package com.inspur.cams.bpt.capital.excel.dao.support;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Types;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.capital.excel.dao.IImpExcelCapitalDao;
import com.inspur.cams.bpt.capital.excel.data.BptImpExcelCapitalTempMark;
import com.inspur.cams.bpt.excelToTable.ParseValidate;
import com.inspur.cams.bpt.excelToTable.data.ToTable;
import com.inspur.cams.bpt.excelToTable.data.ToTableField;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 资金发放excel导入dao接口类
 * 
 * @author zhanghui
 * 
 */
@SuppressWarnings("unchecked")
public class ImpExcelCapitalDao extends EntityDao<BptImpExcelCapitalTempMark>
		implements IImpExcelCapitalDao {

	private StringBuffer sqlBase = new StringBuffer(
			" select m.id_card as ID_CORD,"
					+ " m.name,"
					+ " m.grant_mon,"
					+ " m.grant_date,"
					+ " m.increase_mechanism,"
					+ " m.grain_oil_mon, "
					+ " m.old_lonely_mon, "
					+ " m.other_subsidy_one,"
					+ " m.other_subsidy_two,"
					+ " m.other_subsidy_three,"
					+ " m.other_subsidy_four,"
					+ " m.other_subsidy_five,"
					+ " m.increase_mechanism + m.grain_oil_mon + m.old_lonely_mon +"
					+ " m.other_subsidy_one + m.other_subsidy_two + m.other_subsidy_three +"
					+ " m.other_subsidy_four + m.other_subsidy_five as SUB_TOTAL,"
					+ " m.increase_mechanism + m.grain_oil_mon + m.old_lonely_mon +"
					+ " m.other_subsidy_one + m.other_subsidy_two + m.other_subsidy_three +"
					+ " m.other_subsidy_four + m.other_subsidy_five + m.grant_mon as GRANT_MON_SUM,");

	public ImpExcelCapitalDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	protected Class getEntityClass() {
		return BptImpExcelCapitalTempMark.class;
	}

	/**
	 * 拼装sql语句
	 * 
	 * @param toTable
	 * @param pset
	 * @return String[]
	 */
	private String[] appendSql(ToTable toTable, ParameterSet pset) {

		StringBuffer insertSql = new StringBuffer("insert into "); // 添加sql
		StringBuffer deleteSql = new StringBuffer("delete from "); // 删除sql
		StringBuffer insertSql_mark = new StringBuffer("insert into ");// 添加验证sql

		StringBuffer insertValues = new StringBuffer("values ("); // 添加sql
		// values部分
		StringBuffer insertField = new StringBuffer(" (");// 添加sql表字段部分

		String temp_table = toTable.getTempTableName(); // 获得临时表名
		String temp_table_mark = toTable.getMakeTableName(); // 获得临时验证表名
		List<ToTableField> fieldlist = toTable.getFieldList(); // xml字段列表

		insertSql.append(temp_table); // 拼装插入sql临时表表名

		insertSql_mark.append(temp_table_mark); // 拼装插入sql验证表表名

		String tempName;
		for (int i = 0; i < fieldlist.size(); i++) {
			tempName = fieldlist.get(i).getFieldName();
			if (i < fieldlist.size() - 1) {
				insertField.append(tempName + ","); // 拼装插入sql表字段
				insertValues.append(" ?, "); // 拼装插入sql中values占位符
			} else {
				insertField.append(tempName);
				insertValues.append(" ? ");
			}

		}
		insertSql.append(insertField).append(" ) ").append(insertValues)
				.append(" ) "); // 完成拼装插入临时表sql
		insertSql_mark.append(insertField).append(
				",VALIDATE_FLAG,ERROR_MESSAGE,COMMIT_FLAG,ID )").append(
				insertValues).append(" ,?,?,?,? )");// 完成拼装插入验证表sql
		deleteSql.append(temp_table).append(
				"  where organ_code = ? and register_type = ?");// 插入临时表前清空相同行政区划且同类型数据

		String[] sql = new String[] { deleteSql.toString(),
				insertSql.toString(), insertSql_mark.toString() };
		return sql;
	}

	/**
	 * 优抚资金发放excel导入临时表
	 * 
	 * @param excelData
	 * @param toTable
	 * @param pset
	 */
	public void importExcel(String[][] excelData, ToTable toTable,
			ParameterSet pset) {
		String[] sql = appendSql(toTable, pset);
		String registerType = (String) pset.getParameter("registerType"); // 业务类型
		String organCode = (String) pset.getParameter("organCode");// 行政区划
		this.executeUpdate(sql[0], new int[] { Types.VARCHAR, Types.VARCHAR },
				new Object[] { organCode, registerType }); // 删除临时表数据

		Connection con = null;
		PreparedStatement pst = null;
		try {
			con = getDataSource().getConnection(); // 获得数据库连接
			con.setAutoCommit(false); // 手动提交事务
			pst = con.prepareStatement(sql[1]);
			for (int row = 0; row < excelData.length; row++) {
				int colCount = excelData[0].length;// excel列数
				for (int col = 0; col < colCount; col++) {
					pst.setString(col + 1, excelData[row][col]);// 将excel内容设置对应表字段
				}
				pst.setString(++colCount, organCode); // 设置行政区划
				pst.setString(++colCount, registerType);// 设置业务类型
				pst.addBatch();
			}

			pst.executeBatch(); // 批量插入临时表

			pst = con.prepareStatement(sql[2]); // 导入验证表
			importMark(pst, pset, excelData, toTable);// 批量插入验证表

			con.commit(); // 提交事务
			con.setAutoCommit(true);
		} catch (Exception e) {
			e.printStackTrace();
			try {
				con.rollback();// 回滚事务
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally { // 关闭资源
			try {
				if (null != pst) {
					pst.close();
					pst = null;
				}
				if (null != con) {
					con.close();
					con = null;
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 导入验证表
	 * 
	 * @param pst
	 * @param pset
	 * @param excelData
	 * @param toTable
	 */
	private void importMark(PreparedStatement pst, ParameterSet pset,
			String[][] excelData, ToTable toTable) throws Exception {
		String registerType = (String) pset.getParameter("registerType"); // 业务类型
		String organCode = (String) pset.getParameter("organCode");// 行政区划
		String validateClass = toTable.getVailClass(); // 验证类
		String[] validateInfo = new String[2]; // 验证信息
		String temp_value;

		List<ToTableField> table_field = toTable.getFieldList(); // xml字段信息
		for (int row = 0; row < excelData.length; row++) {
			int colCount = excelData[0].length;// excel列数
			boolean ifContinue = true; // 是否继续表示（如某列已验证不通过，则本行数据无需再做下一步验证）
			for (int col = 0; col < colCount; col++) {
				temp_value = excelData[row][col];
				pst.setString(col + 1, temp_value);
				if (ifContinue) {
					validateInfo = ParseValidate.validateMark(temp_value,
							table_field.get(col).getFieldValiList(),
							validateClass); // 获得验证信息
					if (validateInfo[0] == null) {
						validateInfo[0] = "1";
						validateInfo[1] = "找不到验证类";
						ifContinue = false;
					} else if ("1".equals(validateInfo[0])) {
						ifContinue = false;
					}
				}
			}

			pst.setString(++colCount, organCode);
			pst.setString(++colCount, registerType);
			pst.setString(++colCount, validateInfo[0]);
			pst.setString(++colCount, validateInfo[1]);
			pst.setString(++colCount, "0"); // 设置是否入库
			pst.setString(++colCount, IdHelp.getUUID30());// 设置临时表主键
			pst.addBatch();
		}
		pst.executeBatch();
	}

	/**
	 * 删除以id_card、register_type分组删除重复数据
	 */
	public void deleteRepeat() {
		StringBuffer sql = new StringBuffer(
				"delete from bpt_imp_capital_temp_mark "
						+ " where rowid in ( select rowid  from (select rowid, "
						+ " row_number() over(partition by t.organ_code, t.register_type, "
						+ " t.id_card order by t.organ_code, t.register_type, t.id_card) id_num  "
						+ " from bpt_imp_capital_temp_mark t ) a  "
						+ " where a.id_num>1)");
		this.executeUpdate(sql.toString());
	}

	/**
	 * 资金发放伤残excel导入临时表表级验证
	 * 
	 * @param pset
	 */
	public void disablityValidate(ParameterSet pset) {
		/*
		 * StringBuffer updateSql = new StringBuffer( // 修改验证表中金额相关计算数据 "update
		 * bpt_imp_capital_temp_mark b " + " set b.grant_sta_mon =
		 * trunc(b.grant_mon / b.grant_months, 2)," + " b.sub_total =
		 * b.increase_mechanism + b.grain_oil_mon +" + " b.coal_subsidy_mon +
		 * b.anti_japanese_mon +" + " b.old_lonely_mon + b.other_subsidy_one +" + "
		 * b.other_subsidy_two + b.other_subsidy_three +" + "
		 * b.other_subsidy_four + b.other_subsidy_five," + " b.grant_mon_sum =
		 * b.increase_mechanism + b.grain_oil_mon+ " + " b.old_lonely_mon +
		 * b.other_subsidy_one+ " + " b.other_subsidy_two +
		 * b.other_subsidy_three+ " + " b.other_subsidy_four +
		 * b.other_subsidy_five+ " + " b.grant_mon + b.nursing_mon");
		 * 
		 * updateSql .append(" where b.organ_code = ? and b.register_type = ?
		 * and b.commit_flag='0'"); this.executeUpdate(updateSql.toString(), new
		 * int[] { Types.VARCHAR, Types.VARCHAR }, new Object[] {
		 * pset.getParameter("organCode"), pset.getParameter("registerType") });
		 */

	}

	/**
	 *  验证全部身份证号是否为该业务人员
	 * @param pset
	 */
	public void excelIdCardValidateAll(ParameterSet pset) {
		String registerType = (String) pset.getParameter("registerType");
		String validateName = "";
		String viewName = "";
		if ("11".equals(registerType)) {
			validateName = "该人员非伤残人员";
			viewName = "v_bpt_people_disability";
		} else if ("21".equals(registerType)) {
			validateName = "该人员非三属人员";
			viewName = "V_BPT_PEOPLE_DEPENDANT";
		} else if ("41".equals(registerType)) {
			validateName = "该人员非在乡复员人员";
			viewName = "V_BPT_PEOPLE_DEPENDANT";
		} else if ("42".equals(registerType)) {
			validateName = "该人员非带病回乡人员";
			viewName = "V_BPT_PEOPLE_DEM_ILLNESS";
		} else if ("51".equals(registerType)) {
			validateName = "该人员非两参人员";
			viewName = "V_BPT_PEOPLE_WARANDTESTED";
		} else if ("00".equals(registerType)) {
			validateName = "该人员非优待金发放人员";
			viewName = "(select * from V_BPT_OBJECT_UNION t where t.OBJECT_TYPE <> '51' and t.OBJECT_TYPE <> '61')";
		}
		StringBuffer sql = new StringBuffer(
				"update bpt_imp_capital_temp_mark b "
						+ " set b.validate_flag='1',b.error_message= ? "
						+ " where not exists(select v.ID_CARD from ");
		sql.append(viewName);
		sql
				.append(" v where v.ID_CARD=b.id_card and v.OBJECT_STATE='2') and b.validate_flag='0' "
						+ " and b.commit_flag='0' and b.organ_code = ? and b.register_type = ?");

		this.executeUpdate(sql.toString(), new int[] { Types.VARCHAR,
				Types.VARCHAR, Types.VARCHAR }, new Object[] { validateName,
				pset.getParameter("organCode"),
				pset.getParameter("registerType") });

	}

	/**
	 * 根据身份证查询该业务人员
	 * 
	 * @param idCard
	 * @param viewName
	 */
	public DataSet excelIdCardValidate(ParameterSet pset) {
		String idCard = (String) pset.getParameter("ID_CARD");
		String registerType = (String) pset.getParameter("REGISTER_TYPE");
		String viewName = "";
		if ("11".equals(registerType)) {
			viewName = "v_bpt_people_disability";
		} else if ("21".equals(registerType)) {
			viewName = "V_BPT_PEOPLE_DEPENDANT";
		} else if ("41".equals(registerType)) {
			viewName = "V_BPT_PEOPLE_DEMOBILIZED";
		} else if ("42".equals(registerType)) {
			viewName = "V_BPT_PEOPLE_DEM_ILLNESS";
		} else if ("51".equals(registerType)) {
			viewName = "V_BPT_PEOPLE_WARANDTESTED";
		} else if ("00".equals(registerType)) {
			viewName = "(select * from V_BPT_OBJECT_UNION t where t.OBJECT_TYPE <> '51' and t.OBJECT_TYPE <> '61')";
		}
		StringBuffer sql = new StringBuffer("select * from  ");
		sql.append(viewName);
		sql.append(" v where v.id_card = ? and v.OBJECT_STATE='2'");
		return this.executeDataset(sql.toString(), new int[] { Types.VARCHAR },
				new Object[] { idCard }, true);
	}

	/**
	 * 验证该时期内资金是否已发放
	 */
	public void excelIfGrant(String errorMessage, String viewName,
			ParameterSet pset) {
		StringBuffer sql = new StringBuffer( // 验证该时期内资金是否已发放
				"update bpt_Imp_Capital_Temp_Mark m"
						+ " set m.validate_flag = '1', m.error_message = ?  "
						+ " where exists (select t.id  " + "from (select b.id "
						+ " from Bpt_Imp_Capital_Temp_Mark b,   ");
		sql.append(viewName);
		sql
				.append("   v,  "
						+ "bpt_capital_summary  s, "
						+ "bpt_capital_detail  d  "
						+ "where b.id_card = v.ID_CARD "
						+ "and v.PEOPLE_ID = d.people_id  "
						+ "and s.register_id = d.register_id  "
						+ "and (((b.start_date < s.end_date) and "
						+ "(b.start_date >= s.start_date)) or "
						+ " ((b.start_date < s.start_date) and  "
						+ "(s.start_date < b.end_date))) "
						+ "and b.commit_flag = '0' and  b.validate_flag='0'  "
						+ "and b.organ_code = ?  "
						+ "and b.register_type = ? and s.register_type = ? and d.register_type = ?) t  "
						+ "where t.id = m.id)");

		this.executeUpdate(sql.toString(), new int[] { Types.VARCHAR,
				Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR },
				new Object[] { errorMessage, pset.getParameter("organCode"),
						pset.getParameter("registerType"),
						pset.getParameter("registerType"),
						pset.getParameter("registerType") });
	}

	/**
	 * 验证该时期内资金是否已发放
	 */
	public DataSet excelIfGrant(ParameterSet pset) {
		String registerType = (String) pset.getParameter("registerType");
		int[] types;
		Object[] args;
		StringBuffer sql;
		if ("00".equals(registerType)) { // 优待金发放
			sql = new StringBuffer( // 验证该时期内资金是否已发放
					" select s.register_id from  BPT_COMPULSORY_SUMMARY  s  "
							+ "where (((? < s.end_date) and "
							+ "(? >= s.start_date)) or "
							+ " ((? < s.start_date) and  "
							+ "(s.start_date < ?))) "
							+ "and s.grant_unit = ?  ");
			types = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,
					Types.VARCHAR, Types.VARCHAR };
			args = new Object[] { pset.getParameter("startDate"),
					pset.getParameter("startDate"),
					pset.getParameter("startDate"),
					pset.getParameter("endDate"),
					pset.getParameter("organCode") };
		} else {
			sql = new StringBuffer( // 验证该时期内资金是否已发放
					" select s.register_id from  bpt_capital_summary  s  "
							+ "where (((? < s.end_date) and "
							+ "(? >= s.start_date)) or "
							+ " ((? < s.start_date) and  "
							+ "(s.start_date < ?))) "
							+ "and s.organ_code = ?  "
							+ "and s.register_type = ?");
			types = new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,
					Types.VARCHAR, Types.VARCHAR, Types.VARCHAR };
			args = new Object[] { pset.getParameter("startDate"),
					pset.getParameter("startDate"),
					pset.getParameter("startDate"),
					pset.getParameter("endDate"),
					pset.getParameter("organCode"),
					pset.getParameter("registerType") };
		}

		return this.executeDataset(sql.toString(), types, args, true);
	}

	/**
	 * 验证某日期资金是否发放
	 * 
	 * @param pset
	 * @return
	 */
	public boolean ifGrant(ParameterSet pset) {
		StringBuffer sql = new StringBuffer(" select d.register_id "
				+ " from bpt_capital_summary s, bpt_capital_detail d "
				+ " where s.register_id = d.register_id "
				+ " and (((? < s.end_date) and " + " (? >= s.start_date)) or  "
				+ " ((? < s.start_date) and " + " (s.start_date < ?)))"
				+ " and d.id_cord = ?" + " and d.register_type = ? "
				+ " and s.register_type = ?");

		DataSet ds = this.executeDataset(sql.toString(), new int[] {
				Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,
				Types.VARCHAR, Types.VARCHAR, Types.VARCHAR }, new Object[] {
				pset.getParameter("startDate"), pset.getParameter("startDate"),
				pset.getParameter("startDate"), pset.getParameter("endDate"),
				pset.getParameter("idCard"), pset.getParameter("registerType"),
				pset.getParameter("registerType") }, true);
		return ds.getCount() > 0;
	}

	/**
	 * 删除资金发放excel导入验证信息表记录
	 * 
	 * @param ids
	 */
	public void delete(String id) {
		StringBuffer sql = new StringBuffer(
				"delete from bpt_imp_capital_temp_mark " + "m where m.id=?");
		this.executeUpdate(sql.toString(), new int[] { Types.VARCHAR },
				new Object[] { id });
	}

	/**
	 * 删除某类资金发放excel导入验证信息表记录
	 * 
	 * @param pset
	 */
	public void delete(ParameterSet pset) {
		StringBuffer sql = new StringBuffer(
				"delete from bpt_imp_capital_temp_mark m "
						+ "where m.organ_code=? and m.register_type=?");
		this.executeUpdate(sql.toString(), new int[] { Types.VARCHAR,
				Types.VARCHAR }, new Object[] {
				pset.getParameter("ORGAN_CODE"),
				pset.getParameter("REGISTER_TYPE") });
	}

	/**
	 * 计算导入数据库发放资金总额
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryGrantMonSum(ParameterSet pset) {
		StringBuffer sql = new StringBuffer(
				"select sum(m.grant_mon_sum) as grant_mon_sum "
						+ "from bpt_imp_capital_temp_mark m "
						+ "where m.organ_code=? and m.register_type=?");
		return this.executeDataset(sql.toString(), new int[] { Types.VARCHAR,
				Types.VARCHAR }, new Object[] {
				pset.getParameter("ORGAN_CODE"),
				pset.getParameter("REGISTER_TYPE") }, true);
	}

	/**
	 * 伤残资金发放导入数据库
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryDisability(ParameterSet pset) {
		StringBuffer sql = new StringBuffer(
				"select m.id_card as ID_CORD,"
						+ " m.name,"
						+ " m.nursing_mon,"
						+ " m.grant_mon,"
						+ " m.grant_date,"
						+ " m.increase_mechanism,"
						+ " m.grain_oil_mon,"
						+ " m.coal_subsidy_mon,"
						+ " m.anti_japanese_mon,"
						+ " m.old_lonely_mon, "
						+ " m.other_subsidy_one,"
						+ " m.other_subsidy_two,"
						+ " m.other_subsidy_three, "
						+ " m.other_subsidy_four,"
						+ " m.other_subsidy_five,"
						+ " m.increase_mechanism + m.grain_oil_mon + m.coal_subsidy_mon +"
						+ " m.anti_japanese_mon + m.old_lonely_mon + m.other_subsidy_one +"
						+ " m.other_subsidy_two + m.other_subsidy_three + m.other_subsidy_four +"
						+ " m.other_subsidy_five as SUB_TOTAL, "
						+ " m.increase_mechanism + m.grain_oil_mon + m.coal_subsidy_mon +"
						+ " m.anti_japanese_mon + m.old_lonely_mon + m.other_subsidy_one +"
						+ " m.other_subsidy_two + m.other_subsidy_three + m.other_subsidy_four +"
						+ " m.other_subsidy_five + m.nursing_mon + m.grant_mon as GRANT_MON_SUM,"
						+ " v.DOMICILE_CODE,"
						+ " v.DOMICILE_NAME,"
						+ " v.PEOPLE_ID,"
						+ " v.account_code, "
						+ " v.DISABILITY_TYPE_CODE  object_type,"
						+ " v.BPT_NO                CREDENTIALS_NO,"
						+ " v.domicile_type,"
						+ " v.DISABILITY_GENUS_CODE,"
						+ " v.DISABILITY_LEVEL_CODE,"
						+ " v.DISABILITY_CASE_CODE,"
						+ " v.DISABILITY_WAR_CODE,"
						+ " v.old_lonely_flag "
						+ " from bpt_imp_capital_temp_mark m, v_bpt_people_disability v "
						+ " where m.id_card = v.ID_CARD "
						+ " and m.register_type = '11' and m.organ_code=?");

		return this.executeDataset(sql.toString(), new int[] { Types.VARCHAR },
				new Object[] { pset.getParameter("ORGAN_CODE") }, true);
	}

	/**
	 * 三属资金发放导入数据库
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryDependant(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append(sqlBase);
		sql
				.append(" v.DOMICILE_CODE,"
						+ " v.DOMICILE_NAME,"
						+ " v.PEOPLE_ID,"
						+ " v.account_code, "
						+ " v.DEPENDANT_TYPE_CODE object_type,"
						+ " v.BPT_NO CREDENTIALS_NO,"
						+ " v.domicile_type, "
						+ " v.old_lonely_flag "
						+ " from bpt_imp_capital_temp_mark m, v_bpt_people_dependant v "
						+ " where m.id_card = v.ID_CARD "
						+ " and m.register_type = '21' and m.organ_code=?");
		return this.executeDataset(sql.toString(), new int[] { Types.VARCHAR },
				new Object[] { pset.getParameter("ORGAN_CODE") }, true);
	}

	/**
	 * 在乡复员资金发放导入数据库
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryDemobilized(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append(sqlBase);
		sql
				.append("  v.DOMICILE_CODE,"
						+ "  v.DOMICILE_NAME,"
						+ "  v.PEOPLE_ID,"
						+ "  v.account_code, "
						+ "  v.DEMOBILIZED_TYEP_CODE object_type,"
						+ "  v.BPT_NO CREDENTIALS_NO, "
						+ "  v.domicile_type,"
						+ "  v.old_lonely_flag,"
						+ "  v.BELONGDATE BELONG_DATE"
						+ "  from bpt_imp_capital_temp_mark m, v_bpt_people_demobilized v "
						+ "  where m.id_card = v.ID_CARD "
						+ "  and m.register_type = '41' and  m.organ_code=?");
		return this.executeDataset(sql.toString(), new int[] { Types.VARCHAR },
				new Object[] { pset.getParameter("ORGAN_CODE") }, true);
	}

	/**
	 * 带病回乡资金发放导入数据库相关信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryDemobilizedIll(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append(sqlBase);

		sql
				.append(" v.DOMICILE_CODE,"
						+ "  v.DOMICILE_NAME,"
						+ "  v.PEOPLE_ID,"
						+ "  v.account_code,"
						+ "  v.DEMOBILIZED_TYEP_CODE object_type,"
						+ "  v.BPT_NO CREDENTIALS_NO,"
						+ "  v.domicile_type,"
						+ "  v.old_lonely_flag  "
						+ "  from bpt_imp_capital_temp_mark m, v_bpt_people_dem_illness v"
						+ "  where m.id_card = v.ID_CARD "
						+ "  and m.register_type = '42' and m.organ_code=?");

		return this.executeDataset(sql.toString(), new int[] { Types.VARCHAR },
				new Object[] { pset.getParameter("ORGAN_CODE") }, true);
	}

	/**
	 * 两参资金发放导入数据库相关信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryWarAndTested(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append(sqlBase);

		sql
				.append("  v.DOMICILE_CODE,"
						+ "  v.DOMICILE_NAME,"
						+ "  v.PEOPLE_ID,"
						+ "  v.account_code,"
						+ "  v.object_type object_type,"
						+ "  v.BPT_NO CREDENTIALS_NO,"
						+ "  v.domicile_type,"
						+ "  v.old_lonely_flag"
						+ "  from bpt_imp_capital_temp_mark m, v_bpt_people_warandtested v"
						+ "  where m.id_card = v.ID_CARD"
						+ "  and m.register_type = '51' and m.organ_code=?");
		return this.executeDataset(sql.toString(), new int[] { Types.VARCHAR },
				new Object[] { pset.getParameter("ORGAN_CODE") }, true);

	}
	
	
	/**
	 * 优待金导入数据库相关信息
	 * @param pset
	 * @return
	 */
	public DataSet queryCompulsory(ParameterSet pset) {
		StringBuffer sql = new StringBuffer("select m.id_card as ID_CARD," +
				" m.name," +
				" m.grant_mon," +
				" m.grant_date," +
				" m.old_lonely_mon," +
				" m.other_subsidy_one," +
				" m.other_subsidy_two," +
				" m.other_subsidy_three," +
				" m.other_subsidy_four," +
				" m.other_subsidy_five," +
				" m.old_lonely_mon + m.other_subsidy_one + m.other_subsidy_two +" +
				" m.other_subsidy_three + m.other_subsidy_four + m.other_subsidy_five +" +
				" m.grant_mon as GRANT_MON_SUM," +
				" v.DOMICILE_CODE," +
				" v.DOMICILE_NAME," +
				" v.PEOPLE_ID," +
				" v.account_code," +
				" v.object_type     object_type_code," +
				" v.BPT_NO          CREDENTIALS_NO," +
				" v.domicile_type," +
				" v.old_lonely_flag" +
				" from bpt_imp_capital_temp_mark m," +
				" (select *" +
				" from V_BPT_OBJECT_UNION t" +
				"  where t.OBJECT_TYPE <> '51'" +
				"  and t.OBJECT_TYPE <> '61') v " +
				" where m.id_card = v.ID_CARD" +
				" and m.register_type = '00' and m.organ_code= ? ");
		return this.executeDataset(sql.toString(), new int[] { Types.VARCHAR },
				new Object[] { pset.getParameter("ORGAN_CODE") }, true);
		
	}
}
