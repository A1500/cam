package com.inspur.comm.cnspell.dao.jdbc;

import java.sql.Types;
import java.util.List;

import javax.sql.DataSource;

import org.loushang.persistent.jdbc.core.SqlParameter;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.jdbc.object.Queryer;

import com.inspur.comm.cnspell.dao.ISysCnCharSpellDao;

public class SysCnCharSpellJdbcDao implements ISysCnCharSpellDao {
	private static DataSource getDataSource() {
		DataSource dataSource = (DataSource) DataSourceFactory.defaultFactory
				.getDataSource("dataSource");
		return dataSource;
	}

	/**
	 * 
	 * @param cnStr
	 * @param spellType
	 * @return
	 */
	public List getCnStrSpell(String cnStr, String spellType) {
		Queryer queryer = new Queryer();
		queryer.setDataSource(getDataSource());

		StringBuffer bsSql = new StringBuffer("''");
		StringBuffer seSql = new StringBuffer();
		StringBuffer orSql = new StringBuffer();
		String[] cnArr = cnStr.split("");
		Object[] objs = new Object[cnArr.length - 1];
		for (int i = 1; i < cnArr.length; i++) {
			bsSql.append("||S");
			bsSql.append(i);

			if (i != 1) {
				seSql.append(",");
				orSql.append(",");
			}
			orSql.append("O");
			orSql.append(i);

			seSql.append("(SELECT SPELL S");
			seSql.append(i);
			if ("x".equals(spellType)) {
				seSql.append(" ,ORDER_X O");
				seSql.append(i);
			} else {
				seSql.append(" ,ORDER_M O");
				seSql.append(i);
			}
			seSql.append(" FROM SYS_CN_CHAR_SPELL WHERE CN_CHAR = ?");
			if ("x".equals(spellType)) {
				seSql.append(" ORDER BY ORDER_X)");
			} else {
				seSql.append(" ORDER BY ORDER_M)");
			}
			queryer.declareParameter(new SqlParameter(Types.VARCHAR));
			objs[i - 1] = cnArr[i];
		}
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT ");
		sql.append(bsSql);
		sql.append(" SPELL FROM ");
		sql.append(seSql);
		sql.append(" WHERE ROWNUM < 10 ORDER BY ");
		sql.append(orSql);

		queryer.setSql(sql.toString());
		queryer.setPageAble(true);
		queryer.compile();
		return queryer.execute(objs);
	}

}