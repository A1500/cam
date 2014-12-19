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
public class BptBusinessManageDao extends BaseJdbcDao {

	public BptBusinessManageDao() {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
	}
	private static class Proc extends Procedure {
		
		public Proc(DataSource ds) {

			super(ds, "BP_BPT_BUSINESS_MANAGE");
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
					record.set("disability_assess",rs.getString("disability_assess"));
					record.set("disability_adjust", rs.getString("disability_adjust"));
					record.set("disability_exchace", rs.getString("disability_exchace"));
					record.set("disability_migrate", rs.getString("disability_migrate"));
					record.set("dependant_assess", rs.getString("dependant_assess"));
					record.set("dependant_migrate", rs.getString("dependant_migrate"));
					record.set("demobilize_assess", rs.getString("demobilize_assess"));
					record.set("demobilize_migrate", rs.getString("demobilize_migrate"));
					record.set("demobilizeill_assess", rs.getString("demobilizeill_assess"));
					record.set("demobilizeill_migrate", rs.getString("demobilizeill_migrate"));
					record.set("war_assess", rs.getString("war_assess"));
					record.set("war_migrate", rs.getString("war_migrate"));
					record.set("tested_assess", rs.getString("tested_assess"));
					record.set("tested_migrate", rs.getString("tested_migrate"));
					record.set("mon_count", rs.getString("mon_count"));
					record.set("disability_count", rs.getString("disability_count"));
					record.set("dependant_count", rs.getString("dependant_count"));
					record.set("demobilize_count", rs.getString("demobilize_count"));
					record.set("demobilizeill_count", rs.getString("demobilizeill_count"));
					record.set("war_count", rs.getString("war_count"));
					record.set("tested_count", rs.getString("tested_count"));
					record.set("soldier_assess", rs.getString("soldier_assess"));
					record.set("soldier_migrate", rs.getString("soldier_migrate"));
					record.set("soldier_count", rs.getString("soldier_count"));
					record.set("martyr_assess", rs.getString("martyr_assess"));
					record.set("martyr_migrate", rs.getString("martyr_migrate"));
					record.set("martyr_count", rs.getString("martyr_count"));
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
