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
public class LivingSubsidyPaymentDao extends BaseJdbcDao {

	public LivingSubsidyPaymentDao() {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
	}
	private static class Proc extends Procedure {
		
		public Proc(DataSource ds) {

			super(ds, "BP_BPT_QUERY_CAPITAL_GRANT");
			//声明参数
			declareParameter(new SqlParameter("in_xzqh", Types.VARCHAR));
			declareParameter(new SqlParameter("in_cxsj_q",Types.VARCHAR));
			declareParameter(new SqlParameter("in_cxsj_z",Types.VARCHAR));
			declareParameter(new SqlParameter("in_pxzd",Types.VARCHAR));
			declareParameter(new SqlParameter("in_pxfs",Types.VARCHAR));
			// 声明结果集的个数
			setNumberOfResultSet(1);
			compile();
		}

		public Map call(String xzqh,String cxsj_q,String cxsj_z,String pxzd,String pxfs) {
			Map in = new HashMap();
			// 设置入参的值，key要和声明参数的名称一致
			in.put("in_xzqh", xzqh);
			in.put("in_cxsj_q", cxsj_q);
			in.put("in_cxsj_z",  cxsj_z);
			in.put("in_pxzd", pxzd);
			in.put("in_pxfs", pxfs);
			
			ResultReader resultReader = new ResultReaderImpl() {

				protected Object mapRow(ResultSet rs, int rowNum)
						throws SQLException {
					Record record = new Record();
					record.set("organ_code", rs.getString("organ_code"));
					record.set("organ_name", rs.getString("organ_name"));
					record.set("count",rs.getString("count"));
					record.set("people_num",rs.getString("people_num"));
					record.set("demobilized_num", rs.getString("demobilized_num"));
					record.set("demobilized_mon", rs.getString("demobilized_mon"));
					record.set("demobilized_avg_mon", rs.getString("demobilized_avg_mon"));
					record.set("demobilized_iliness_num", rs.getString("demobilized_iliness_num"));
					record.set("demobilized_iliness_mon", rs.getString("demobilized_iliness_mon"));
					record.set("demobilized_iliness_avg_mon", rs.getString("demobilized_iliness_avg_mon"));
					record.set("war_num", rs.getString("war_num"));
					record.set("war_town_mon", rs.getString("war_town_mon"));
					record.set("war_town_avg_mon", rs.getString("war_town_avg_mon"));
					record.set("tested_num", rs.getString("tested_num"));
					record.set("tested_town_mon", rs.getString("tested_town_mon"));
					record.set("tested_town_avg_mon", rs.getString("tested_town_avg_mon"));
					record.set("martyr_num", rs.getString("martyr_num"));
					record.set("martyr_town_mon", rs.getString("martyr_town_mon"));
					record.set("martyr_town_avg_mon", rs.getString("martyr_town_avg_mon"));
					record.set("soldier_num", rs.getString("soldier_num"));
					record.set("soldier_town_mon", rs.getString("soldier_town_mon"));
					record.set("soldier_town_avg_mon", rs.getString("soldier_town_avg_mon"));
					return record;
				}
			};
			ResultReader[] readerA = new ResultReader[] { resultReader };

			Map ret = execute(in,readerA);
			ret.put("results", resultReader.getResults());
			return ret;
		}
	}
	
	private Proc procduce = null;
	
	protected void  init(){
		if(procduce==null){
			procduce = new Proc(getDataSource());
		}	
	}
	
	public DataSet getDataSet(ParameterSet pset){
		init();
		DataSet set = new DataSet();
		List results=null;
		Object object =null;
		String xzqu = (String) pset.getParameter("xzqu");//行政区划
		String cxsj_q = (String) pset.getParameter("cxsj_q");//查询时间_起
		String cxsj_z = (String) pset.getParameter("cxsj_z");//查询时间_止
//		String pxzd = (String) pset.getParameter("pxzd");//排序字段
//		String pxfs = (String) pset.getParameter("pxfs");//排序顺序 升序/降序
		
		object= procduce.call(xzqu, cxsj_q,cxsj_z,"","").get("results");
		if (object instanceof ArrayList ) {
			 results = (List) object;
			 for(Object o:results){
				set.add((Record) o);
			 }
		}
		return set;
	}

	@Override
	protected void initDao() {
		
	}

}
