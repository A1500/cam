package com.inspur.cams.bpt.query.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.core.ResultReader;
import org.loushang.persistent.jdbc.core.SqlParameter;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.jdbc.object.Procedure;
import org.loushang.persistent.util.domain.BaseJdbcDao;

@SuppressWarnings("unchecked")
public class YouDaiJinStandardDao extends BaseJdbcDao {

	public YouDaiJinStandardDao() {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
	}

	private static class Proc extends Procedure {

		public Proc(DataSource ds) {

			super(ds, "BP_BPT_QUERY_CAPITAL_STANDARD");
			// 声明参数
			declareParameter(new SqlParameter("in_xzqh", Types.VARCHAR));
			declareParameter(new SqlParameter("in_cxsj_q", Types.VARCHAR));
			declareParameter(new SqlParameter("in_cxsj_z", Types.VARCHAR));
			// 声明结果集的个数
			setNumberOfResultSet(1);
			compile();
		}

		public Map call(String xzqh, String cxsj_q, String cxsj_z) {
			Map in = new HashMap();
			// 设置入参的值，key要和声明参数的名称一致
			in.put("in_xzqh", xzqh);
			in.put("in_cxsj_q", cxsj_q);
			in.put("in_cxsj_z", cxsj_z);

			ResultReader resultReader = new ResultReaderImpl() {

				protected Object mapRow(ResultSet rs, int rowNum)
						throws SQLException {
					Record record = new Record();
					record.set("ORGAN_CODE", rs.getString("ORGAN_CODE"));
					record.set("ORGAN_NAME", rs.getString("ORGAN_NAME"));
					record.set("SOLDIER_TOWN", rs.getString("SOLDIER_TOWN"));
					record.set("SOLDIER_COUNTRY", rs
							.getString("SOLDIER_COUNTRY"));
					record.set("SANSHU_TOWN", rs.getString("SANSHU_TOWN"));
					record
							.set("SANSHU_COUNTRY", rs
									.getString("SANSHU_COUNTRY"));
					record.set("DEMOBILIIZED_SOLDIER", rs
							.getString("DEMOBILIIZED_SOLDIER"));
					record.set("DISABLED_SOLDIER", rs
							.getString("DISABLED_SOLDIER"));
					return record;
				}
			};
			ResultReader[] readerA = new ResultReader[] { resultReader };

			Map ret = execute(in, readerA);
			ret.put("results", resultReader.getResults());
			return ret;
		}
	}

	private Proc procduce = null;

	protected void init() {
		if (procduce == null) {
			procduce = new Proc(getDataSource());
		}
	}

	public DataSet getDataSet(ParameterSet pset) {
		init();
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String xzqu = (String) pset.getParameter("xzqu");// 行政区划
		String cxsj_q = (String) pset.getParameter("cxsj_q");// 查询时间_起
		String cxsj_z = (String) pset.getParameter("cxsj_z");// 查询时间_止
		if (xzqu != null) {
			object = procduce.call(xzqu, cxsj_q, cxsj_z).get("results");
		} else {

		}
		if (object instanceof ArrayList) {
			results = (List) object;
			for (Object o : results) {
				set.add((Record) o);
			}
		}
		return set;
	}

	@Override
	protected void initDao() {

	}

}
