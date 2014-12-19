package com.inspur.cams.bpt.capital.dao.jdbc;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.core.ResultReader;
import org.loushang.persistent.jdbc.core.SqlParameter;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.jdbc.object.Procedure;

import com.inspur.cams.bpt.capital.dao.IBptCapitalDetailDao;
import com.inspur.cams.bpt.capital.data.BptCapitalDetail;

/**
 * @title:BptCapitalDetailDao
 * @description:资金发放名册
 * @author:
 * @since:2011-05-28
 * @version:1.0
 */
public class BptCapitalDetailDao extends EntityDao<BptCapitalDetail> implements IBptCapitalDetailDao {

	public BptCapitalDetailDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}
    
	@Override
	public Class<BptCapitalDetail> getEntityClass() {
		return BptCapitalDetail.class;
	}


	
	private Proc2 proc = null;
	private DepdtProc2 depdtProc2 = null;
	private DemobilizedProc2 demobilizedProc2 = null;
	private DemobilizedIllProc2 demobilizedIllProc2 = null;
	private LivingAllowanceProc2 livingAllowanceProc2 = null;
	private SoldierProc2 soldierProc2 = null;
	private MartyrProc2 martyrProc2 = null;
	protected void initDao() {
		super.initDao();
		if (proc == null){
			proc = new Proc2(getDataSource());
		}
		if (depdtProc2 == null){
			depdtProc2 = new DepdtProc2(getDataSource());
		}
		if (demobilizedProc2 == null){
			demobilizedProc2 = new DemobilizedProc2(getDataSource());
		}
		if (demobilizedIllProc2 == null){
			demobilizedIllProc2 = new DemobilizedIllProc2(getDataSource());
		}
		if (martyrProc2 == null){
			martyrProc2 = new MartyrProc2(getDataSource());
		}
		if (soldierProc2 == null){
			soldierProc2 = new SoldierProc2(getDataSource());
		}
		if (livingAllowanceProc2 == null){
			livingAllowanceProc2 = new LivingAllowanceProc2(getDataSource());
		}
	}
/**********************************************伤残抚恤金发放存储过程调用 START *****************************************************/
	private static class Proc2 extends Procedure {
		public Proc2(DataSource ds) {
			super(ds, "BP_BPT_CAPITAL_DISABILITY");
			// 声明六个入参和一个出参
			// 声明的参数必须有参数名
			declareParameter(new SqlParameter("organCode", Types.VARCHAR));
			declareParameter(new SqlParameter("startDate", Types.VARCHAR));
			declareParameter(new SqlParameter("endDate", Types.VARCHAR));
			declareParameter(new SqlParameter("buildDate", Types.VARCHAR));
			declareParameter(new SqlParameter("preBuildDate", Types.VARCHAR));
			declareParameter(new SqlParameter("uuid", Types.VARCHAR));
			//declareParameter(new SqlOutParameter("var_return", Types.VARCHAR));
			// 声明结果集的个数
			setNumberOfResultSet(0);
			compile();
		}
		public Map call(String organCode,String startDate,String endDate,String buildDate,String preBuildDate,String uuid) {
			Map in = new HashMap();
			in.put("organCode", organCode);// 设置入参的值，key要和声明参数的名称一致
			in.put("startDate", startDate);
			in.put("endDate", endDate);
			in.put("buildDate", buildDate);
			in.put("preBuildDate", preBuildDate);
			in.put("uuid", uuid);
			
			// 通过匿名内部类构造3个结果集处理器
			// 数量要和声明的结果集的个数一致
			// 注意顺序
			ResultReader dicCityReader = new ResultReaderImpl() {
				// 处理数据库记录，这里只是简单的将一条记录映射成一个Map
				protected Object mapRow(ResultSet rs, int rowNum)
						throws SQLException {
					HashMap map = new HashMap();
					return map;
				}
			};			
			//可以多个
			ResultReader[] readerA = new ResultReader[] { dicCityReader };

			// 执行调用，出参都在返回的ret变量里，其中key是参数名，value是对应的参数值(java.lang.Object类型)
			Map ret = execute(in);
			// 可以通过结果集处理器的getResults()方法获得List
			//ret.put("dicCityList", dicCityReader.getResults());
			return ret;
		}
	}

	/**
	 * 通过调用存储过程添加伤残抚恤金发放名册明细
	 * @param pset
	 */
	public void insertDisaPesionDetail(ParameterSet pset){
		String organCode = (String)pset.getParameter("organCode");
		String buildDate = (String)pset.getParameter("buildDate");
		String startDate = (String)pset.getParameter("startDate");
		String endDate = (String)pset.getParameter("endDate");
		String preBuildDate = (String)pset.getParameter("preBuildDate");
		String uuid = (String)pset.getParameter("uuid");
		Map ret=proc.call(organCode,startDate,endDate,buildDate,preBuildDate,uuid);
	}

/*******************************************伤残抚恤金发放存储过程调用 END ***********************************************/
	
/***********************************************三属定期抚恤金发放存储过程调用 【START】***********************************/
	private static class DepdtProc2 extends Procedure {
		public DepdtProc2(DataSource ds) {
			super(ds, "BP_BPT_CAPITAL_DEPENDANT");
			// 声明六个入参和一个出参
			// 声明的参数必须有参数名
			declareParameter(new SqlParameter("organCode", Types.VARCHAR));
			declareParameter(new SqlParameter("startDate", Types.VARCHAR));
			declareParameter(new SqlParameter("endDate", Types.VARCHAR));
			declareParameter(new SqlParameter("buildDate", Types.VARCHAR));
			declareParameter(new SqlParameter("preBuildDate", Types.VARCHAR));
			declareParameter(new SqlParameter("uuid", Types.VARCHAR));
			//declareParameter(new SqlOutParameter("var_return", Types.VARCHAR));
			// 声明结果集的个数
			setNumberOfResultSet(0);
			compile();
		}
		public Map call(String organCode,String startDate,String endDate,String buildDate,String preBuildDate,String uuid) {
			Map in = new HashMap();
			in.put("organCode", organCode);// 设置入参的值，key要和声明参数的名称一致
			in.put("startDate", startDate);
			in.put("endDate", endDate);
			in.put("buildDate", buildDate);
			in.put("preBuildDate", preBuildDate);
			in.put("uuid", uuid);
			// 通过匿名内部类构造3个结果集处理器
			// 数量要和声明的结果集的个数一致
			// 注意顺序
			ResultReader dicCityReader = new ResultReaderImpl() {
				// 处理数据库记录，这里只是简单的将一条记录映射成一个Map
				protected Object mapRow(ResultSet rs, int rowNum)
						throws SQLException {
					HashMap map = new HashMap();
					return map;
				}
			};			
			//可以多个
			ResultReader[] readerA = new ResultReader[] { dicCityReader };
			// 执行调用，出参都在返回的ret变量里，其中key是参数名，value是对应的参数值(java.lang.Object类型)
			Map ret = execute(in);
			// 可以通过结果集处理器的getResults()方法获得List
			//ret.put("dicCityList", dicCityReader.getResults());
			return ret;
		}
	}
	
	/**
	 * 通过调用存储过程添加三属定期抚恤金发放名册明细
	 * @param pset
	 */
	public void insertDepdtPesionDetail(ParameterSet pset){
		String organCode = (String)pset.getParameter("organCode");
		String buildDate = (String)pset.getParameter("buildDate");
		String startDate = (String)pset.getParameter("startDate");
		String endDate = (String)pset.getParameter("endDate");
		String preBuildDate = (String)pset.getParameter("preBuildDate");
		String uuid = (String)pset.getParameter("uuid");
		Map ret=depdtProc2.call(organCode,startDate,endDate,buildDate,preBuildDate,uuid);
	}
/***********************************************三属定期抚恤金发放存储过程调用 【END】***********************************/
	
/***********************************************复员军人定期定量生活补助金发放存储过程调用【START】***********************************/	
	private static class DemobilizedProc2 extends Procedure {
		public DemobilizedProc2(DataSource ds) {
			super(ds, "BP_BPT_CAPITAL_REGULAR");
			// 声明六个入参和一个出参
			// 声明的参数必须有参数名
			declareParameter(new SqlParameter("organCode", Types.VARCHAR));
			declareParameter(new SqlParameter("startDate", Types.VARCHAR));
			declareParameter(new SqlParameter("endDate", Types.VARCHAR));
			declareParameter(new SqlParameter("buildDate", Types.VARCHAR));
			declareParameter(new SqlParameter("preBuildDate", Types.VARCHAR));
			declareParameter(new SqlParameter("uuid", Types.VARCHAR));
			//declareParameter(new SqlOutParameter("var_return", Types.VARCHAR));
			// 声明结果集的个数
			setNumberOfResultSet(0);
			compile();
		}
		public Map call(String organCode,String startDate,String endDate,String buildDate,String preBuildDate,String uuid) {
			Map in = new HashMap();
			in.put("organCode", organCode);// 设置入参的值，key要和声明参数的名称一致
			in.put("startDate", startDate);
			in.put("endDate", endDate);
			in.put("buildDate", buildDate);
			in.put("preBuildDate", preBuildDate);
			in.put("uuid", uuid);
			// 通过匿名内部类构造3个结果集处理器
			// 数量要和声明的结果集的个数一致
			// 注意顺序
			ResultReader dicCityReader = new ResultReaderImpl() {
				// 处理数据库记录，这里只是简单的将一条记录映射成一个Map
				protected Object mapRow(ResultSet rs, int rowNum)
						throws SQLException {
					HashMap map = new HashMap();
					return map;
				}
			};			
			//可以多个
			ResultReader[] readerA = new ResultReader[] { dicCityReader };
			// 执行调用，出参都在返回的ret变量里，其中key是参数名，value是对应的参数值(java.lang.Object类型)
			Map ret = execute(in);
			// 可以通过结果集处理器的getResults()方法获得List
			//ret.put("dicCityList", dicCityReader.getResults());
			return ret;
		}
	}
	
	/**
	 * 添加复员军人定期定量生活补助金发放明细
	 */
	public void insertDemobilizedPesionDetail(ParameterSet pset){
		String organCode = (String)pset.getParameter("organCode");
		String buildDate = (String)pset.getParameter("buildDate");
		String startDate = (String)pset.getParameter("startDate");
		String endDate = (String)pset.getParameter("endDate");
		String preBuildDate = (String)pset.getParameter("preBuildDate");
		String uuid = (String)pset.getParameter("uuid");
		Map ret=demobilizedProc2.call(organCode,startDate,endDate,buildDate,preBuildDate,uuid);
	}
	
/***********************************************复员军人定期定量生活补助金发放存储过程调用 【END】***********************************/	

/* ---------------------- {带病回乡退伍军人}生活补助金发放存储过程调用【START】--------------------------------- */	
	private static class DemobilizedIllProc2 extends Procedure {
		public DemobilizedIllProc2(DataSource ds) {
			super(ds, "BP_BPT_CAPITAL_REGU_ILL");
			// 声明六个入参和一个出参
			// 声明的参数必须有参数名
			declareParameter(new SqlParameter("organCode", Types.VARCHAR));
			declareParameter(new SqlParameter("startDate", Types.VARCHAR));
			declareParameter(new SqlParameter("endDate", Types.VARCHAR));
			declareParameter(new SqlParameter("buildDate", Types.VARCHAR));
			declareParameter(new SqlParameter("preBuildDate", Types.VARCHAR));
			declareParameter(new SqlParameter("uuid", Types.VARCHAR));
			//declareParameter(new SqlOutParameter("var_return", Types.VARCHAR));
			// 声明结果集的个数
			setNumberOfResultSet(0);
			compile();
		}
		public Map call(String organCode,String startDate,String endDate,String buildDate,String preBuildDate,String uuid) {
			Map in = new HashMap();
			in.put("organCode", organCode);// 设置入参的值，key要和声明参数的名称一致
			in.put("startDate", startDate);
			in.put("endDate", endDate);
			in.put("buildDate", buildDate);
			in.put("preBuildDate", preBuildDate);
			in.put("uuid", uuid);
			// 通过匿名内部类构造3个结果集处理器
			// 数量要和声明的结果集的个数一致
			// 注意顺序
			ResultReader dicCityReader = new ResultReaderImpl() {
				// 处理数据库记录，这里只是简单的将一条记录映射成一个Map
				protected Object mapRow(ResultSet rs, int rowNum)
						throws SQLException {
					HashMap map = new HashMap();
					return map;
				}
			};			
			//可以多个
			ResultReader[] readerA = new ResultReader[] { dicCityReader };
			// 执行调用，出参都在返回的ret变量里，其中key是参数名，value是对应的参数值(java.lang.Object类型)
			Map ret = execute(in);
			// 可以通过结果集处理器的getResults()方法获得List
			//ret.put("dicCityList", dicCityReader.getResults());
			return ret;
		}
	}
	
	/**
	 * 添加{带病回乡退伍军人}生活补助金发放明细
	 */
	public void insertDemobilizedPesionIllDetail(ParameterSet pset){
		String organCode = (String)pset.getParameter("organCode");
		String buildDate = (String)pset.getParameter("buildDate");
		String startDate = (String)pset.getParameter("startDate");
		String endDate = (String)pset.getParameter("endDate");
		String preBuildDate = (String)pset.getParameter("preBuildDate");
		String uuid = (String)pset.getParameter("uuid");
		Map ret=demobilizedIllProc2.call(organCode,startDate,endDate,buildDate,preBuildDate,uuid);
	}
	
/*-------------------------------- { 带病回乡退伍军人 }生活补助金发放存储过程调用 【END】----------------------------------*/	
	/* ---------------------- {60岁}生活补助金发放存储过程调用【START】--------------------------------- */	
	private static class SoldierProc2 extends Procedure {
		public SoldierProc2(DataSource ds) {
			super(ds, "BP_BPT_CAPITAL_REGU_SOLDIER");
			// 声明六个入参和一个出参
			// 声明的参数必须有参数名
			declareParameter(new SqlParameter("organCode", Types.VARCHAR));
			declareParameter(new SqlParameter("startDate", Types.VARCHAR));
			declareParameter(new SqlParameter("endDate", Types.VARCHAR));
			declareParameter(new SqlParameter("buildDate", Types.VARCHAR));
			declareParameter(new SqlParameter("preBuildDate", Types.VARCHAR));
			declareParameter(new SqlParameter("uuid", Types.VARCHAR));
			//declareParameter(new SqlOutParameter("var_return", Types.VARCHAR));
			// 声明结果集的个数
			setNumberOfResultSet(0);
			compile();
		}
		public Map call(String organCode,String startDate,String endDate,String buildDate,String preBuildDate,String uuid) {
			Map in = new HashMap();
			in.put("organCode", organCode);// 设置入参的值，key要和声明参数的名称一致
			in.put("startDate", startDate);
			in.put("endDate", endDate);
			in.put("buildDate", buildDate);
			in.put("preBuildDate", preBuildDate);
			in.put("uuid", uuid);
			// 通过匿名内部类构造3个结果集处理器
			// 数量要和声明的结果集的个数一致
			// 注意顺序
			ResultReader dicCityReader = new ResultReaderImpl() {
				// 处理数据库记录，这里只是简单的将一条记录映射成一个Map
				protected Object mapRow(ResultSet rs, int rowNum)
						throws SQLException {
					HashMap map = new HashMap();
					return map;
				}
			};			
			//可以多个
			ResultReader[] readerA = new ResultReader[] { dicCityReader };
			// 执行调用，出参都在返回的ret变量里，其中key是参数名，value是对应的参数值(java.lang.Object类型)
			Map ret = execute(in);
			// 可以通过结果集处理器的getResults()方法获得List
			//ret.put("dicCityList", dicCityReader.getResults());
			return ret;
		}
	}
	
	/**
	 * 添加{60岁}生活补助金发放明细
	 */
	public void insertSoldierPesionIllDetail(ParameterSet pset){
		String organCode = (String)pset.getParameter("organCode");
		String buildDate = (String)pset.getParameter("buildDate");
		String startDate = (String)pset.getParameter("startDate");
		String endDate = (String)pset.getParameter("endDate");
		String preBuildDate = (String)pset.getParameter("preBuildDate");
		String uuid = (String)pset.getParameter("uuid");
		Map ret=soldierProc2.call(organCode,startDate,endDate,buildDate,preBuildDate,uuid);
	}
	
	/* ---------------------- {老烈子女}生活补助金发放存储过程调用【START】--------------------------------- */	
	private static class MartyrProc2 extends Procedure {
		public MartyrProc2(DataSource ds) {
			super(ds, "BP_BPT_CAPITAL_REGU_MARTYR");
			// 声明六个入参和一个出参
			// 声明的参数必须有参数名
			declareParameter(new SqlParameter("organCode", Types.VARCHAR));
			declareParameter(new SqlParameter("startDate", Types.VARCHAR));
			declareParameter(new SqlParameter("endDate", Types.VARCHAR));
			declareParameter(new SqlParameter("buildDate", Types.VARCHAR));
			declareParameter(new SqlParameter("preBuildDate", Types.VARCHAR));
			declareParameter(new SqlParameter("uuid", Types.VARCHAR));
			//declareParameter(new SqlOutParameter("var_return", Types.VARCHAR));
			// 声明结果集的个数
			setNumberOfResultSet(0);
			compile();
		}
		public Map call(String organCode,String startDate,String endDate,String buildDate,String preBuildDate,String uuid) {
			Map in = new HashMap();
			in.put("organCode", organCode);// 设置入参的值，key要和声明参数的名称一致
			in.put("startDate", startDate);
			in.put("endDate", endDate);
			in.put("buildDate", buildDate);
			in.put("preBuildDate", preBuildDate);
			in.put("uuid", uuid);
			// 通过匿名内部类构造3个结果集处理器
			// 数量要和声明的结果集的个数一致
			// 注意顺序
			ResultReader dicCityReader = new ResultReaderImpl() {
				// 处理数据库记录，这里只是简单的将一条记录映射成一个Map
				protected Object mapRow(ResultSet rs, int rowNum)
						throws SQLException {
					HashMap map = new HashMap();
					return map;
				}
			};			
			//可以多个
			ResultReader[] readerA = new ResultReader[] { dicCityReader };
			// 执行调用，出参都在返回的ret变量里，其中key是参数名，value是对应的参数值(java.lang.Object类型)
			Map ret = execute(in);
			// 可以通过结果集处理器的getResults()方法获得List
			//ret.put("dicCityList", dicCityReader.getResults());
			return ret;
		}
	}
	
	/**
	 * 添加{60岁}生活补助金发放明细
	 */
	public void insertMartyrPesionIllDetail(ParameterSet pset){
		String organCode = (String)pset.getParameter("organCode");
		String buildDate = (String)pset.getParameter("buildDate");
		String startDate = (String)pset.getParameter("startDate");
		String endDate = (String)pset.getParameter("endDate");
		String preBuildDate = (String)pset.getParameter("preBuildDate");
		String uuid = (String)pset.getParameter("uuid");
		Map ret=martyrProc2.call(organCode,startDate,endDate,buildDate,preBuildDate,uuid);
	}
	
/*-------------------------------- { 带病回乡退伍军人 }生活补助金发放存储过程调用 【END】----------------------------------*/	
	
/**********************************************生活补助费发放存储过程调用 【START】***********************************/	
	private static class LivingAllowanceProc2 extends Procedure {
		public LivingAllowanceProc2(DataSource ds) {
			super(ds, "BP_BPT_CAPITAL_LIVINGALLOW");
			// 声明六个入参和一个出参
			// 声明的参数必须有参数名
			declareParameter(new SqlParameter("organCode", Types.VARCHAR));
			declareParameter(new SqlParameter("startDate", Types.VARCHAR));
			declareParameter(new SqlParameter("endDate", Types.VARCHAR));
			declareParameter(new SqlParameter("buildDate", Types.VARCHAR));
			declareParameter(new SqlParameter("preBuildDate", Types.VARCHAR));
			declareParameter(new SqlParameter("uuid", Types.VARCHAR));
			//declareParameter(new SqlOutParameter("var_return", Types.VARCHAR));
			// 声明结果集的个数
			setNumberOfResultSet(0);
			compile();
		}
		public Map call(String organCode,String startDate,String endDate,String buildDate,String preBuildDate,String uuid) {
			Map in = new HashMap();
			in.put("organCode", organCode);// 设置入参的值，key要和声明参数的名称一致
			in.put("startDate", startDate);
			in.put("endDate", endDate);
			in.put("buildDate", buildDate);
			in.put("preBuildDate", preBuildDate);
			in.put("uuid", uuid);
			// 通过匿名内部类构造3个结果集处理器
			// 数量要和声明的结果集的个数一致
			// 注意顺序
			ResultReader dicCityReader = new ResultReaderImpl() {
				// 处理数据库记录，这里只是简单的将一条记录映射成一个Map
				protected Object mapRow(ResultSet rs, int rowNum)
						throws SQLException {
					HashMap map = new HashMap();
					return map;
				}
			};			
			//可以多个
			ResultReader[] readerA = new ResultReader[] { dicCityReader };
			// 执行调用，出参都在返回的ret变量里，其中key是参数名，value是对应的参数值(java.lang.Object类型)
			Map ret = execute(in);
			// 可以通过结果集处理器的getResults()方法获得List
			//ret.put("dicCityList", dicCityReader.getResults());
			return ret;
		}
	}
	
	/**
	 * 通过调用存储过程添加生活补助费发放明细
	 */
	public void insertLivingAllowPesionDetail(ParameterSet pset){
		String organCode = (String)pset.getParameter("organCode");
		String buildDate = (String)pset.getParameter("buildDate");
		String startDate = (String)pset.getParameter("startDate");
		String endDate = (String)pset.getParameter("endDate");
		String preBuildDate = (String)pset.getParameter("preBuildDate");
		String uuid = (String)pset.getParameter("uuid");
		Map ret=livingAllowanceProc2.call(organCode,startDate,endDate,buildDate,preBuildDate,uuid);
	}	
/***********************************************生活补助费发放存储过程调用 【END】***********************************/		
	
	
	
	/**
	 * 获得上期生成日期
	 * @param organId 当前行政区划
	 * @return
	 */
	public String[] getPreBuildDate(String organId,String registerType) {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT MAX(S.BUILD_DATE) AS PRE_BUILD_DATE,MAX(S.END_DATE) AS PRE_END_DATE\n");
		sql.append("  FROM BPT_CAPITAL_SUMMARY S\n"); 
		sql.append(" WHERE S.REGISTER_TYPE = ?\n");
		sql.append("   AND SUBSTR(S.ORGAN_CODE,1,6) = ?");
		Record rd  = this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR}, new Object[]{registerType,organId},true).getRecord(0);
		String[] result = new String[2];
		if(rd.get("PRE_BUILD_DATE")==null){
			result[0] = null;
		}else{
			result[0] = rd.get("PRE_BUILD_DATE").toString();
		}
		
		if(rd.get("PRE_END_DATE")==null){
			result[1] = null;
		}else{
			result[1] = rd.get("PRE_END_DATE").toString();
		}
		return result;
	}

	/**
	 * 
	 * 根据更改的数据并要更新名册汇总表总金额
	 */
	public void updateData(ParameterSet pset) {
		String regId = (String) pset.getParameter("regId");
		int totalMon = (Integer) pset.getParameter("totalMon");
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE BPT_CAPITAL_SUMMARY SET GRANT_MON=?");
		sql.append(" WHERE REGISTER_ID=?");
		this.executeUpdate(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR}, new Object[]{totalMon,regId});
	}

	/**
	 * 删除名册明细表中的数据
	 * 
	 * @param delIds
	 */
	public void deleteData(String[] delIds) {
		if (delIds.length != 0) {
			for (int i = 0; i < delIds.length; i++) {
				StringBuffer sql = new StringBuffer(
						"DELETE BPT_CAPITAL_DETAIL  WHERE REGISTER_ID=?");
				this.executeUpdate(sql.toString(),new int[]{Types.VARCHAR}, new Object[]{delIds[i]});
			}
		}
	}

	/**
	 * 查询用存储过程生成的人员【点击生成明细时】，{伤残、三属、老复员、带病回乡、两参}
	 */
	public DataSet queryDisabilityDataSet(ParameterSet pset) {
		String registerType = (String)pset.getParameter("registerType");
		String organId =(String) pset.getParameter("organId");
		String startDate = (String) pset.getParameter("startDate");
		String endDate = (String) pset.getParameter("endDate");
		String buildDate = (String) pset.getParameter("buildDate");
		int start =pset.getPageStart();
		int limit =pset.getPageLimit();
		StringBuffer sql = new StringBuffer();
		sql.append( "SELECT D.REG_DETAIL_ID,\n");
		sql.append( "D.REGISTER_ID,\n"); 
		sql.append( "D.DOMICILE_CODE,\n"); 
		sql.append( "D.DOMICILE_NAME,\n"); 
		sql.append("D.REGISTER_TYPE,\n"); 
		sql.append("D.RESPECTIVE_YEARS,\n"); 
		sql.append("D.PEOPLE_ID,\n"); 
		sql.append("D.CHANGE_STATE,\n"); 
		sql.append("D.NAME,\n"); 
		sql.append("D.ID_CORD,\n"); 
		sql.append("D.ACCOUNT_CODE,\n"); 
		sql.append("D.OBJECT_TYPE,\n"); 
		sql.append("D.CREDENTIALS_NO,\n"); 
		sql.append("D.DOMICILE_TYPE,\n"); 
		sql.append("D.DISABILITY_GENUS_CODE,\n"); 
		sql.append("D.DISABILITY_CASE_CODE,\n"); 
		sql.append("D.DISABILITY_LEVEL_CODE,\n"); 
		sql.append("D.DISABILITY_WAR_CODE,\n"); 
		sql.append("D.BELONG_DATE,\n"); 
		sql.append("D.OLD_LONELY_FLAG,\n"); 
		sql.append("D.GRANT_STA_MON,\n"); 
		sql.append("D.GRANT_MONTHS,\n"); 
		sql.append("D.GRANT_MON,\n"); 
		sql.append("D.SUB_TOTAL,\n"); 
		sql.append("D.NURSING_MON,\n"); 
		sql.append("D.INCREASE_MECHANISM,\n"); 
		sql.append("D.GRAIN_OIL_MON,\n"); 
		sql.append("D.COAL_SUBSIDY_MON,\n"); 
		sql.append("D.ANTI_JAPANESE_MON,\n"); 
		sql.append("D.OLD_LONELY_MON,\n"); 
		sql.append("D.SUPPLY_MON,\n"); 
		sql.append("D.OTHER_SUBSIDY_ONE,\n"); 
		sql.append("D.OTHER_SUBSIDY_TWO,\n"); 
		sql.append("D.OTHER_SUBSIDY_THREE,\n"); 
		sql.append("D.OTHER_SUBSIDY_FOUR,\n"); 
		sql.append("D.OTHER_SUBSIDY_FIVE,\n"); 
		sql.append("D.GRANT_MON_SUM,\n"); 
		sql.append("D.NOTE \n");
		sql.append(" FROM BPT_CAPITAL_DETAIL D\n "); 
	    sql.append(" WHERE D.REGISTER_ID = (SELECT S.REGISTER_ID\n"); 
		sql.append("                          FROM BPT_CAPITAL_SUMMARY S\n"); 
		sql.append("                         WHERE S.ORGAN_CODE = ?\n"); 
		sql.append("                           AND S.START_DATE = ?\n"); 
		sql.append("                           AND S.END_DATE = ?\n"); 
		sql.append("                           AND S.BUILD_DATE = ?\n"); 
		sql.append("                           AND S.REGISTER_TYPE = ?)\n");
		sql.append("ORDER BY D.CHANGE_STATE ");
		
		DataSet resultDataSet  =this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},
				                                    new Object[]{organId,startDate,endDate,buildDate,registerType}, start,limit,true);
        for (int i = 0; i < resultDataSet.getCount(); i++) {
			Record m = resultDataSet.getRecord(i); //
			m.set("regDetailId", (String) m.get("REG_DETAIL_ID"));
			m.set("registerId", (String) m.get("REGISTER_ID"));
			m.set("domicileCode", (String) m.get("DOMICILE_CODE"));
			m.set("domicileName", (String) m.get("DOMICILE_NAME"));
			m.set("registerType", (String) m.get("REGISTER_TYPE"));
			m.set("respectiveYears", (String) m.get("RESPECTIVE_YEARS"));
			m.set("peopleId", (String) m.get("PEOPLE_ID"));
			m.set("changeState", (String) m.get("CHANGE_STATE"));
			m.set("name", (String) m.get("NAME"));
			m.set("idCord", (String) m.get("ID_CORD"));
			m.set("accountCode", (String) m.get("ACCOUNT_CODE"));
			m.set("objectType", (String) m.get("OBJECT_TYPE"));
			m.set("credentialsNo", (String) m.get("CREDENTIALS_NO"));
			m.set("disabilityGenusCode", (String) m.get("DISABILITY_GENUS_CODE"));
			m.set("disabilityCaseCode", (String) m.get("DISABILITY_CASE_CODE"));
			m.set("disabilityLevelCode", (String) m.get("DISABILITY_LEVEL_CODE"));
			m.set("disabilityWarCode", (String) m.get("DISABILITY_WAR_CODE"));
			m.set("belongDate", (String) m.get("BELONG_DATE"));
			m.set("domicileType", (String) m.get("DOMICILE_TYPE"));
			m.set("oldLonelyFlag", (String) m.get("OLD_LONELY_FLAG"));
			m.set("grantMon", (BigDecimal) m.get("GRANT_MON"));
			m.set("grantStaMon", (BigDecimal) m.get("GRANT_STA_MON"));
			m.set("grantMonths", (BigDecimal) m.get("GRANT_MONTHS"));
			m.set("nursingMon", (BigDecimal) m.get("NURSING_MON"));
			m.set("subTotal", (BigDecimal) m.get("SUB_TOTAL"));
			m.set("increaseMechanism", (BigDecimal) m.get("INCREASE_MECHANISM"));
			m.set("grainOilMon", (BigDecimal) m.get("GRAIN_OIL_MON"));
			m.set("coalSubsidyMon", (BigDecimal) m.get("COAL_SUBSIDY_MON"));
			m.set("antiJapaneseMon", (BigDecimal) m.get("ANTI_JAPANESE_MON"));
			m.set("oldLonelyMon", (BigDecimal) m.get("OLD_LONELY_MON"));
			m.set("supplyMon", (BigDecimal) m.get("SUPPLY_MON"));
			m.set("otherSubsidyOne", (BigDecimal) m.get("OTHER_SUBSIDY_ONE"));
			m.set("otherSubsidyTwo", (BigDecimal) m.get("OTHER_SUBSIDY_TWO"));
			m.set("otherSubsidyThree", (BigDecimal) m.get("OTHER_SUBSIDY_THREE"));
			m.set("otherSubsidyFour", (BigDecimal) m.get("OTHER_SUBSIDY_FOUR"));
			m.set("otherSubsidyFive", (BigDecimal) m.get("OTHER_SUBSIDY_FIVE"));
			m.set("grantMonSum", (BigDecimal) m.get("GRANT_MON_SUM"));
			m.set("note", (String) m.get("NOTE"));
		}
		return resultDataSet;
	}

	/**
	 * 查询三属名单
	 */
    public DataSet queryGeneraDataSet(ParameterSet pset) {
		String organId =(String) pset.getParameter("organId");
		String startDate = (String) pset.getParameter("startDate");
		String endDate = (String) pset.getParameter("endDate");
		int start =pset.getPageStart();
		int limit =pset.getPageLimit();
		
		StringBuffer sql = new StringBuffer();
				sql.append("SELECT A.PEOPLE_ID,A.NAME,A.ID_CARD,A.DOMICILE_CODE,A.ACCOUNT_CODE,A.DISABILITY_NO,A.DEPENDANT_TYPE_CODE AS OBJECT_TYPE,A.DISABILITY_LEVEL_CODE,");
			    sql.append( "A.OLD_LONELY_FLAG,A.DISABILITY_CASE_CODE," );
			    sql.append( "NVL(B.NEWMOON_STANDARDS *(MONTHS_BETWEEN(TO_DATE(?, 'YYYY-MM'),TO_DATE(?, 'YYYY-MM'))+1),0) NEWMOON_STANDARDS FROM " );
			    sql.append("(SELECT D.PEOPLE_ID,D.NAME,D.ID_CARD,D.DOMICILE_CODE,E.ACCOUNT_CODE,D.DISABILITY_NO,D.DISABILITY_LEVEL_CODE,");
				sql.append( "E.OLD_LONELY_FLAG,E.DEPENDANT_TYPE_CODE,D.DISABILITY_CASE_CODE FROM BASEINFO_PEOPLE D, BPT_PEOPLE E, BPT_PEOPLE_DEPENDANT F");
				sql.append( " WHERE D.DOMICILE_CODE = ? AND D.DEPENDANT_FLAG = '1' AND D.DEPENDANT_STATE_CODE= '2'");
				sql.append( " AND D.PEOPLE_ID = E.PEOPLE_ID AND D.PEOPLE_ID = F.PEOPLE_ID) A  LEFT JOIN (SELECT C.NEWMOON_STANDARDS,C.OBJECT_TYPE");
				sql.append( " FROM BPT_CAPITALSTA C WHERE C.STANDARDS_COUNTIES = ? AND C.TYPE = '2'");
				sql.append( " AND C.START_DATE = (SELECT MAX(START_DATE)FROM BPT_CAPITALSTA WHERE STANDARDS_COUNTIES = ? AND TYPE= '2')) B ON A.DEPENDANT_TYPE_CODE = B.OBJECT_TYPE");
		
		DataSet resultDataSet  =this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},
                new Object[]{endDate,startDate,organId,organId,organId}, start,limit,true);
		
		for (int i = 0; i < resultDataSet.getCount(); i++) {
			Record m = resultDataSet.getRecord(i); 
            
			m.set("peopleId", (String) m.get("PEOPLE_ID"));
			m.set("name", (String) m.get("NAME"));
			m.set("idCord", (String) m.get("ID_CARD"));
			m.set("domicileCode", (String) m.get("DOMICILE_CODE"));
			m.set("bankNo", (String) m.get("ACCOUNT_CODE"));
			m.set("disabilityNo", (String) m.get("DISABILITY_NO"));
			m.set("objectType", (String) m.get("OBJECT_TYPE"));
			m.set("disabilityLevelCode", (String) m.get("DISABILITY_LEVEL_CODE"));
			m.set("oldLonelyFlag", (String) m.get("OLD_LONELY_FLAG"));
			m.set("grantMon", (BigDecimal) m.get("NEWMOON_STANDARDS"));
			m.set("reissueMonOne",new BigDecimal(0));
			m.set("reissueMonTwo",new BigDecimal(0));
			m.set("reissueMonThree",new BigDecimal(0));
			m.set("note", "");
			
		}
		return resultDataSet;
	}

	/**
	 * 查询复员军人定期定量生活补助
	 */
	public DataSet queryLifeDataSet(ParameterSet pset) {
		String organId =(String) pset.getParameter("organId");
		String startDate = (String) pset.getParameter("startDate");
		String endDate = (String) pset.getParameter("endDate");
		int start =pset.getPageStart();
		int limit =pset.getPageLimit();
		StringBuffer sql = new StringBuffer();
				sql.append("SELECT G.PEOPLE_ID,G.NAME,G.ID_CARD,G.DOMICILE_CODE,G.ACCOUNT_CODE,G.DISABILITY_NO,G.OBJECT_TYPE,G.OLD_LONELY_FLAG,");
				sql.append( "NVL(B.NEWMOON_STANDARDS*(MONTHS_BETWEEN(TO_DATE(?, 'YYYY-MM'),TO_DATE(?, 'YYYY-MM'))+1),0) NEWMOON_STANDARDS ");
				sql.append( "  FROM (SELECT A.PEOPLE_ID,A.NAME,A.ID_CARD,A.DOMICILE_CODE,E.ACCOUNT_CODE,A.DISABILITY_NO, E.OLD_LONELY_FLAG,");
				sql.append( "CASE WHEN E.DEMOBILIZED_TYEP_CODE !='00' THEN DEMOBILIZED_TYEP_CODE ");
				sql.append( "     WHEN E.WAR_TYPE_CODE!='00'  THEN WAR_TYPE_CODE END OBJECT_TYPE");
				sql.append( " FROM (SELECT D.PEOPLE_ID,D.NAME,D.ID_CARD,D.DOMICILE_CODE,D.DISABILITY_NO,D.DISABILITY_LEVEL_CODE,");
				sql.append( " D.DISABILITY_CASE_CODE FROM BASEINFO_PEOPLE D WHERE D.WAR_FLAG = '1' OR D.DEMOBILIZED_FLAG = '1' ");
				sql.append( "  AND D.DOMICILE_CODE = ? AND D.DISABILITY_STATE_CODE = '2') A,BPT_PEOPLE E,BPT_PEOPLE_DISABILITY F ");
				sql.append( "  WHERE A.PEOPLE_ID = E.PEOPLE_ID AND A.PEOPLE_ID = F.PEOPLE_ID) G LEFT JOIN (SELECT C.NEWMOON_STANDARDS,C.OBJECT_TYPE FROM BPT_CAPITALSTA C ");
				sql.append( " WHERE C.STANDARDS_COUNTIES = ? AND C.TYPE = '3' AND C.START_DATE = (SELECT MAX(START_DATE) FROM BPT_CAPITALSTA ");
				sql.append( " WHERE STANDARDS_COUNTIES = ? AND TYPE = '3')) B ON G.OBJECT_TYPE = B.OBJECT_TYPE");
		DataSet resultDataSet  =this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},
                new Object[]{endDate,startDate,organId,organId,organId}, start,limit,true);
		
		for (int i = 0; i < resultDataSet.getCount(); i++) {
			Record m =resultDataSet.getRecord(i);
			
			m.set("peopleId", (String) m.get("PEOPLE_ID"));
			m.set("name", (String) m.get("NAME"));
			m.set("idCord", (String) m.get("ID_CARD"));
			m.set("domicileCode", (String) m.get("DOMICILE_CODE"));
			m.set("bankNo", (String) m.get("ACCOUNT_CODE"));
			m.set("disabilityNo", (String) m.get("DISABILITY_NO"));
			m.set("objectType", (String) m.get("OBJECT_TYPE"));
			m.set("oldLonelyFlag", (String) m.get("OLD_LONELY_FLAG"));
			m.set("grantMon", (BigDecimal) m.get("NEWMOON_STANDARDS"));
			m.set("reissueMonOne",new BigDecimal(0));
			m.set("reissueMonTwo",new BigDecimal(0));
			m.set("reissueMonThree",new BigDecimal(0));
			m.set("note", "");
			
		}
	
		return resultDataSet;
	}
    
	public DataSet queryGrantFund(ParameterSet pset) {
		StringBuffer sql1= new StringBuffer("SELECT A.PEOPLE_ID,A.NAME,A.ID_CARD,");
				sql1.append("CASE " );
			sql1.append("WHEN B.DISABILITY_TYPE_CODE != '00' THEN DISABILITY_TYPE_CODE " );
				sql1.append("WHEN B.DEPENDANT_TYPE_CODE != '00' THEN DEPENDANT_TYPE_CODE " );
				sql1.append("WHEN B.REDA_TYPE_CODE != '00' THEN REDA_TYPE_CODE " );
				sql1.append("WHEN B.DEMOBILIZED_TYEP_CODE != '00' THEN DEMOBILIZED_TYEP_CODE " );
				sql1.append("WHEN B.WAR_TYPE_CODE != '00' THEN WAR_TYPE_CODE END OBJECT_TYPE," );
				sql1.append("CASE " );
				sql1.append("WHEN A.DISABILITY_NO IS NOT NULL THEN DISABILITY_NO " );
				sql1.append("WHEN A.REDA_NO IS NOT NULL THEN REDA_NO " );
				sql1.append("WHEN A.DEPENDANT_NO IS NOT NULL THEN DEPENDANT_NO " );
				sql1.append("WHEN A.DEMOBILIZED_NO IS NOT NULL THEN DEMOBILIZED_NO " );
				sql1.append("WHEN A.WAR_NO IS NOT NULL THEN WAR_NO END NO, " );
				sql1.append("B.BANK," );
				sql1.append("B.ACCOUNT_CODE," );
				sql1.append("(SELECT (GRANT_MON + REISSUE_MON_F + REISSUE_MON_S +REISSUE_MON_T) GRANT_MON  FROM BPT_CAPITAL_DETAIL WHERE PEOPLE_ID = ?)MON," );
				sql1.append("(SELECT E.REGISTER_TYPE FROM BPT_CAPITAL_DETAIL C, BPT_CAPITAL_SUMMARY E WHERE C.REGISTER_ID = E.REGISTER_ID AND C.PEOPLE_ID = ?) REGISTER_TYPE,");
				sql1.append("(SELECT  E.GRANT_DATE  FROM BPT_CAPITAL_DETAIL C,BPT_CAPITAL_SUMMARY E WHERE C.REGISTER_ID=E.REGISTER_ID AND C.PEOPLE_ID = ?)GRANT_DATE," );
				sql1.append("(SELECT  NOTE FROM BPT_CAPITAL_DETAIL  WHERE PEOPLE_ID = ?)NOTE " );
				sql1.append("FROM BASEINFO_PEOPLE A, BPT_PEOPLE B " );
				sql1.append("WHERE A.PEOPLE_ID = B.PEOPLE_ID AND A.PEOPLE_ID =?");
		return this.executeDataset(sql1.toString(),new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},
                new Object[]{pset.getParameter("peopleId"),pset.getParameter("peopleId"),pset.getParameter("peopleId"),pset.getParameter("peopleId"),pset.getParameter("peopleId")}, false);
	}
	
	/**
	 * 获取新增的伤残抚恤金发放对象
	 */
	public DataSet getNewDisabiGrantDs(ParameterSet pset){
		String registerId = (String)pset.getParameter("registerId"),
		       peopleId = (String)pset.getParameter("peopleId");
		StringBuffer sql = new StringBuffer();
			sql.append("SELECT SYS_GUID() AS REG_DETAIL_ID,\n" );
			sql.append("       ? AS REGISTER_ID,\n" ); 
			sql.append("		P.DOMICILE_CODE,\n" );
			sql.append("       C.FULL_NAME,\n");
			sql.append("       ? AS REGISTER_TYPE,\n" ); 
			sql.append("       S.RESPECTIVE_YEARS,\n" ); 
			sql.append("       P.PEOPLE_ID,\n" ); 
			sql.append("       P.NAME,\n" ); 
			sql.append("       P.ID_CARD,\n" ); 
			sql.append("       T.ACCOUNT_CODE,\n" ); 
			sql.append("       T.DISABILITY_TYPE_CODE,\n" ); 
			sql.append("       P.DISABILITY_NO AS CREDENTIALS_NO,\n" ); 
			sql.append("       P.DOMICILE_TYPE,\n" ); 
			sql.append("       D.DISABILITY_GENUS_CODE,\n" ); 
			sql.append("       D.DISABILITY_CASE_CODE,\n" ); 
			sql.append("       D.DISABILITY_LEVEL_CODE,\n" ); 
			sql.append("		D.DISABILITY_WAR_CODE,\n");
			sql.append("       T.OLD_LONELY_FLAG\n" ); 
			sql.append("  FROM BASEINFO_PEOPLE       P,\n" ); 
			sql.append("       BPT_CAPITAL_SUMMARY   S,\n" ); 
			sql.append("       BPT_PEOPLE_DISABILITY D,\n" ); 
			sql.append("       BPT_PEOPLE            T,\n" ); 
			sql.append("		DIC_CITY			  C \n");	
			sql.append(" WHERE P.PEOPLE_ID = D.PEOPLE_ID\n" ); 
			sql.append("   AND P.PEOPLE_ID = T.PEOPLE_ID\n" ); 
			sql.append("   AND D.PEOPLE_ID = T.PEOPLE_ID\n" ); 
			sql.append("   AND C.ID = P.DOMICILE_CODE\n");
			sql.append("   AND P.PEOPLE_ID = ?\n" ); 
			sql.append("   AND D.PEOPLE_ID = ?\n" ); 
			sql.append("   AND T.PEOPLE_ID = ?\n" ); 
			sql.append("   AND S.REGISTER_ID = ?");
		DataSet ds = this.executeDataset(sql.toString(), new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},
				new Object[]{registerId,11,peopleId,peopleId,peopleId,registerId}, true);
		Record rd = ds.getRecord(0);
		Record resultRecord = new Record();
		resultRecord.set("regDetailId",rd.get("REG_DETAIL_ID").toString());
		resultRecord.set("registerId",(String)rd.get("REGISTER_ID"));
		resultRecord.set("domicileCode", (String)rd.get("DOMICILE_CODE"));
		resultRecord.set("domicileName", (String)rd.get("FULL_NAME"));
		resultRecord.set("registerType", rd.get("REGISTER_TYPE").toString());
		resultRecord.set("respectiveYears", (String)rd.get("RESPECTIVE_YEARS"));
		resultRecord.set("peopleId", (String)rd.get("PEOPLE_ID"));
		resultRecord.set("name", (String)rd.get("NAME"));
		resultRecord.set("idCord", (String)rd.get("ID_CARD"));
		resultRecord.set("accountCode", (String)rd.get("ACCOUNT_CODE"));
		resultRecord.set("objectType", (String)rd.get("DISABILITY_TYPE_CODE"));
		resultRecord.set("credentialsNo", (String)rd.get("CREDENTIALS_NO"));
		resultRecord.set("domicileType", (String)rd.get("DOMICILE_TYPE"));
		resultRecord.set("disabilityGenusCode", (String)rd.get("DISABILITY_GENUS_CODE"));
		resultRecord.set("disabilityCaseCode", (String)rd.get("DISABILITY_CASE_CODE"));
		resultRecord.set("disabilityLevelCode", (String)rd.get("DISABILITY_LEVEL_CODE"));
		resultRecord.set("disabilityWarCode", (String)rd.get("DISABILITY_WAR_CODE"));
		resultRecord.set("oldLonelyFlag", (String)rd.get("OLD_LONELY_FLAG"));
		DataSet resultDs = new DataSet();
		resultDs.add(resultRecord);
		return resultDs;
	}
	/**
	 * 获取新增的三属抚恤金发放对象
	 */
	public DataSet getNewDepandGrantDs(ParameterSet pset){
		String registerId = (String)pset.getParameter("registerId"),
	       peopleId = (String)pset.getParameter("peopleId");
		StringBuffer sql = new StringBuffer();
			sql.append("SELECT SYS_GUID() AS REG_DETAIL_ID,\n" );
			sql.append("             ? AS REGISTER_ID,\n" ); 
			sql.append("             P.DOMICILE_CODE,\n" ); 
			sql.append("             C.FULL_NAME,\n" ); 
			sql.append("             ? AS REGISTER_TYPE,\n" ); 
			sql.append("             S.RESPECTIVE_YEARS,\n" ); 
			sql.append("             P.PEOPLE_ID,\n" ); 
			sql.append("             P.NAME,\n" ); 
			sql.append("             P.ID_CARD,\n" ); 
			sql.append("             T.ACCOUNT_CODE,\n" ); 
			sql.append("             T.DEPENDANT_TYPE_CODE,\n" ); 
			sql.append("             P.DEPENDANT_NO AS CREDENTIALS_NO,\n" ); 
			sql.append("             P.DOMICILE_TYPE,\n" ); 
			sql.append("             T.OLD_LONELY_FLAG\n" ); 
			sql.append("        FROM BASEINFO_PEOPLE      P,\n" ); 
			sql.append("             BPT_CAPITAL_SUMMARY  S,\n" ); 
			sql.append("             BPT_PEOPLE_DEPENDANT D,\n" ); 
			sql.append("             BPT_PEOPLE           T,\n" ); 
			sql.append("             DIC_CITY             C\n" ); 
			sql.append("       WHERE P.PEOPLE_ID = D.PEOPLE_ID\n" ); 
			sql.append("         AND P.PEOPLE_ID = T.PEOPLE_ID\n" ); 
			sql.append("         AND D.PEOPLE_ID = T.PEOPLE_ID\n" ); 
			sql.append("         AND P.DOMICILE_CODE = C.ID\n" ); 
			sql.append("         AND P.PEOPLE_ID = ?\n" ); 
			sql.append("         AND D.PEOPLE_ID = ?\n" ); 
			sql.append("         AND T.PEOPLE_ID = ?\n" ); 
			sql.append("         AND S.REGISTER_ID = ?");
		DataSet ds = this.executeDataset(sql.toString(), new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},
				new Object[]{registerId,21,peopleId,peopleId,peopleId,registerId}, true);
		Record rd = ds.getRecord(0);
		Record resultRecord = new Record();
		resultRecord.set("regDetailId",rd.get("REG_DETAIL_ID").toString());
		resultRecord.set("registerId",(String)rd.get("REGISTER_ID"));
		resultRecord.set("domicileCode", (String)rd.get("DOMICILE_CODE"));
		resultRecord.set("domicileName", (String)rd.get("FULL_NAME"));
		resultRecord.set("registerType", rd.get("REGISTER_TYPE").toString());
		resultRecord.set("respectiveYears", (String)rd.get("RESPECTIVE_YEARS"));
		resultRecord.set("peopleId", (String)rd.get("PEOPLE_ID"));
		resultRecord.set("name", (String)rd.get("NAME"));
		resultRecord.set("idCord", (String)rd.get("ID_CARD"));
		resultRecord.set("accountCode", (String)rd.get("ACCOUNT_CODE"));
		resultRecord.set("objectType", (String)rd.get("DEPENDANT_TYPE_CODE"));
		resultRecord.set("credentialsNo", (String)rd.get("CREDENTIALS_NO"));
		resultRecord.set("domicileType", (String)rd.get("DOMICILE_TYPE"));
		resultRecord.set("oldLonelyFlag", (String)rd.get("OLD_LONELY_FLAG"));
		DataSet resultDs = new DataSet();
		resultDs.add(resultRecord);
		return resultDs;
	}
	
	/**
	 * 获取新增的复员军人抚恤金发放对象
	 */
	public DataSet getNewDemobilizedGrantDs(ParameterSet pset){
		String registerId = (String)pset.getParameter("registerId"),
			   peopleId = (String)pset.getParameter("peopleId");
		StringBuffer sql = new StringBuffer();
			sql.append("SELECT SYS_GUID() AS REG_DETAIL_ID,\n");
			sql.append("     ? AS REGISTER_ID,\n"); 
			sql.append("     P.DOMICILE_CODE,\n"); 
			sql.append("     C.FULL_NAME AS DOMICILE_NAME,\n"); 
			sql.append("     ? AS REGISTER_TYPE,\n"); 
			sql.append("     S.RESPECTIVE_YEARS,\n"); 
			sql.append("     P.PEOPLE_ID,\n"); 
			sql.append("     P.NAME,\n"); 
			sql.append("     P.ID_CARD,\n"); 
			sql.append("     T.ACCOUNT_CODE,\n"); 
			sql.append("     T.DEMOBILIZED_TYEP_CODE,\n"); 
			sql.append("     P.DEMOBILIZED_NO AS CREDENTIALS_NO,\n"); 
			sql.append("     D.BELONGDATE,\n"); 
			sql.append("     P.DOMICILE_TYPE,\n"); 
			sql.append("     T.OLD_LONELY_FLAG\n"); 
			sql.append(" FROM BASEINFO_PEOPLE        P,\n"); 
			sql.append("     BPT_CAPITAL_SUMMARY    S,\n"); 
			sql.append("     BPT_PEOPLE_DEMOBILIZED D,\n"); 
			sql.append("     BPT_PEOPLE             T,\n"); 
			sql.append("     DIC_CITY               C\n"); 
			sql.append(" WHERE P.PEOPLE_ID = D.PEOPLE_ID\n"); 
			sql.append(" AND P.PEOPLE_ID = T.PEOPLE_ID\n"); 
			sql.append(" AND D.PEOPLE_ID = T.PEOPLE_ID\n"); 
			sql.append(" AND P.DOMICILE_CODE = C.ID\n"); 
			sql.append(" AND P.PEOPLE_ID = ?\n"); 
			sql.append(" AND D.PEOPLE_ID = ?\n"); 
			sql.append(" AND T.PEOPLE_ID = ?\n"); 
			sql.append(" AND S.REGISTER_ID = ?");
		DataSet ds = this.executeDataset(sql.toString(), new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},
				new Object[]{registerId,41,peopleId,peopleId,peopleId,registerId}, true);
		Record rd = ds.getRecord(0);
		Record resultRecord = new Record();
		resultRecord.set("regDetailId",rd.get("REG_DETAIL_ID").toString());
		resultRecord.set("registerId",(String)rd.get("REGISTER_ID"));
		resultRecord.set("domicileCode", (String)rd.get("DOMICILE_CODE"));
		resultRecord.set("domicileName", (String)rd.get("DOMICILE_NAME"));
		resultRecord.set("registerType", rd.get("REGISTER_TYPE").toString());
		resultRecord.set("respectiveYears", (String)rd.get("RESPECTIVE_YEARS"));
		resultRecord.set("peopleId", (String)rd.get("PEOPLE_ID"));
		resultRecord.set("name", (String)rd.get("NAME"));
		resultRecord.set("idCord", (String)rd.get("ID_CARD"));
		resultRecord.set("accountCode", (String)rd.get("ACCOUNT_CODE"));
		resultRecord.set("objectType", (String)rd.get("DEMOBILIZED_TYEP_CODE"));
		resultRecord.set("belongDate", (String)rd.get("BELONGDATE"));
		resultRecord.set("credentialsNo", (String)rd.get("CREDENTIALS_NO"));
		resultRecord.set("domicileType", (String)rd.get("DOMICILE_TYPE"));
		resultRecord.set("oldLonelyFlag", (String)rd.get("OLD_LONELY_FLAG"));
		DataSet resultDs = new DataSet();
		resultDs.add(resultRecord);
		return resultDs;
	}
	
	/**
	 * 获取新增的带病回乡退伍军人抚恤金发放对象
	 */
	public DataSet getNewDemobilizedIllGrantDs(ParameterSet pset){
		String registerId = (String)pset.getParameter("registerId"),
			   peopleId = (String)pset.getParameter("peopleId");
		StringBuffer sql = new StringBuffer();
			sql.append("SELECT SYS_GUID() AS REG_DETAIL_ID,\n" );
			sql.append("     ? AS REGISTER_ID,\n" ); 
			sql.append("     P.DOMICILE_CODE,\n" ); 
			sql.append("     C.FULL_NAME AS DOMICILE_NAME,\n" ); 
			sql.append("     ? AS REGISTER_TYPE,\n" ); 
			sql.append("     S.RESPECTIVE_YEARS,\n" ); 
			sql.append("     P.PEOPLE_ID,\n" ); 
			sql.append("     P.NAME,\n" ); 
			sql.append("     P.ID_CARD,\n" ); 
			sql.append("     T.ACCOUNT_CODE,\n" ); 
			sql.append("     T.DEMOBILIZED_TYEP_CODE,\n" ); 
			sql.append("     P.DEMOBILIZED_NO AS CREDENTIALS_NO,\n" ); 
			sql.append("     P.DOMICILE_TYPE,\n" ); 
			sql.append("     T.OLD_LONELY_FLAG\n" ); 
			sql.append(" FROM BASEINFO_PEOPLE        P,\n" ); 
			sql.append("     BPT_CAPITAL_SUMMARY    S,\n" ); 
			sql.append("     BPT_PEOPLE_DEMOBILIZED_ILLNESS D,\n" ); 
			sql.append("     BPT_PEOPLE             T,\n" ); 
			sql.append("     DIC_CITY               C\n" ); 
			sql.append(" WHERE P.PEOPLE_ID = D.PEOPLE_ID\n" ); 
			sql.append(" AND P.PEOPLE_ID = T.PEOPLE_ID\n" ); 
			sql.append(" AND D.PEOPLE_ID = T.PEOPLE_ID\n" ); 
			sql.append(" AND P.DOMICILE_CODE = C.ID\n" ); 
			sql.append(" AND P.PEOPLE_ID = ?\n" ); 
			sql.append(" AND D.PEOPLE_ID = ?\n" ); 
			sql.append(" AND T.PEOPLE_ID = ?\n" ); 
			sql.append(" AND S.REGISTER_ID = ?");
		DataSet ds = this.executeDataset(sql.toString(), new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},
				new Object[]{registerId,42,peopleId,peopleId,peopleId,registerId}, true);
		Record rd = ds.getRecord(0);
		Record resultRecord = new Record();
		resultRecord.set("regDetailId",rd.get("REG_DETAIL_ID").toString());
		resultRecord.set("registerId",(String)rd.get("REGISTER_ID"));
		resultRecord.set("domicileCode", (String)rd.get("DOMICILE_CODE"));
		resultRecord.set("domicileName", (String)rd.get("DOMICILE_NAME"));
		resultRecord.set("registerType", rd.get("REGISTER_TYPE").toString());
		resultRecord.set("respectiveYears", (String)rd.get("RESPECTIVE_YEARS"));
		resultRecord.set("peopleId", (String)rd.get("PEOPLE_ID"));
		resultRecord.set("name", (String)rd.get("NAME"));
		resultRecord.set("idCord", (String)rd.get("ID_CARD"));
		resultRecord.set("accountCode", (String)rd.get("ACCOUNT_CODE"));
		resultRecord.set("objectType", (String)rd.get("DEMOBILIZED_TYEP_CODE"));
		resultRecord.set("credentialsNo", (String)rd.get("CREDENTIALS_NO"));
		resultRecord.set("domicileType", (String)rd.get("DOMICILE_TYPE"));
		resultRecord.set("oldLonelyFlag", (String)rd.get("OLD_LONELY_FLAG"));
		DataSet resultDs = new DataSet();
		resultDs.add(resultRecord);
		return resultDs;
	}
	/**
	 * 获取新增的60岁抚恤金发放对象
	 */
	public DataSet getNewSoldierGrantDs(ParameterSet pset){
		String registerId = (String)pset.getParameter("registerId"),
			   peopleId = (String)pset.getParameter("peopleId");
		StringBuffer sql = new StringBuffer();
			sql.append("SELECT SYS_GUID() AS REG_DETAIL_ID,\n" );
			sql.append("     ? AS REGISTER_ID,\n" ); 
			sql.append("     P.DOMICILE_CODE,\n" ); 
			sql.append("     C.FULL_NAME AS DOMICILE_NAME,\n" ); 
			sql.append("     ? AS REGISTER_TYPE,\n" ); 
			sql.append("     S.RESPECTIVE_YEARS,\n" ); 
			sql.append("     P.PEOPLE_ID,\n" ); 
			sql.append("     P.NAME,\n" ); 
			sql.append("     P.ID_CARD,\n" ); 
			sql.append("     T.ACCOUNT_CODE,\n" ); 
			sql.append("     T.retired_type_code,\n" ); 
			sql.append("     P.retired_no AS CREDENTIALS_NO,\n" ); 
			sql.append("     P.DOMICILE_TYPE,\n" ); 
			sql.append("     T.OLD_LONELY_FLAG\n" ); 
			sql.append(" FROM BASEINFO_PEOPLE        P,\n" ); 
			sql.append("     BPT_CAPITAL_SUMMARY    S,\n" ); 
			sql.append("     BPT_PEOPLE             T,\n" ); 
			sql.append("     DIC_CITY               C\n" ); 
			sql.append(" WHERE  P.PEOPLE_ID = T.PEOPLE_ID\n" ); 
			sql.append(" AND P.DOMICILE_CODE = C.ID\n" ); 
			sql.append(" AND P.PEOPLE_ID = ?\n" ); 
			sql.append(" AND T.PEOPLE_ID = ?\n" ); 
			sql.append(" AND S.REGISTER_ID = ?");
		DataSet ds = this.executeDataset(sql.toString(), new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},
				new Object[]{registerId,81,peopleId,peopleId,registerId}, true);
		Record rd = ds.getRecord(0);
		Record resultRecord = new Record();
		resultRecord.set("regDetailId",rd.get("REG_DETAIL_ID").toString());
		resultRecord.set("registerId",(String)rd.get("REGISTER_ID"));
		resultRecord.set("domicileCode", (String)rd.get("DOMICILE_CODE"));
		resultRecord.set("domicileName", (String)rd.get("DOMICILE_NAME"));
		resultRecord.set("registerType", rd.get("REGISTER_TYPE").toString());
		resultRecord.set("respectiveYears", (String)rd.get("RESPECTIVE_YEARS"));
		resultRecord.set("peopleId", (String)rd.get("PEOPLE_ID"));
		resultRecord.set("name", (String)rd.get("NAME"));
		resultRecord.set("idCord", (String)rd.get("ID_CARD"));
		resultRecord.set("accountCode", (String)rd.get("ACCOUNT_CODE"));
		resultRecord.set("objectType", (String)rd.get("RETIRED_TYPE_CODE"));
		resultRecord.set("credentialsNo", (String)rd.get("CREDENTIALS_NO"));
		resultRecord.set("domicileType", (String)rd.get("DOMICILE_TYPE"));
		resultRecord.set("oldLonelyFlag", (String)rd.get("OLD_LONELY_FLAG"));
		DataSet resultDs = new DataSet();
		resultDs.add(resultRecord);
		return resultDs;
	}
	/**
	 * 获取新增的老烈子女抚恤金发放对象
	 */
	public DataSet getNewMartyrGrantDs(ParameterSet pset){
		String registerId = (String)pset.getParameter("registerId"),
			   peopleId = (String)pset.getParameter("peopleId");
		StringBuffer sql = new StringBuffer();
			sql.append("SELECT SYS_GUID() AS REG_DETAIL_ID,\n" );
			sql.append("     ? AS REGISTER_ID,\n" ); 
			sql.append("     P.DOMICILE_CODE,\n" ); 
			sql.append("     C.FULL_NAME AS DOMICILE_NAME,\n" ); 
			sql.append("     ? AS REGISTER_TYPE,\n" ); 
			sql.append("     S.RESPECTIVE_YEARS,\n" ); 
			sql.append("     P.PEOPLE_ID,\n" ); 
			sql.append("     P.NAME,\n" ); 
			sql.append("     P.ID_CARD,\n" ); 
			sql.append("     T.ACCOUNT_CODE,\n" ); 
			sql.append("     T.retired_type_code,\n" ); 
			sql.append("     P.retired_no AS CREDENTIALS_NO,\n" ); 
			sql.append("     P.DOMICILE_TYPE,\n" ); 
			sql.append("     T.OLD_LONELY_FLAG\n" ); 
			sql.append(" FROM BASEINFO_PEOPLE        P,\n" ); 
			sql.append("     BPT_CAPITAL_SUMMARY    S,\n" ); 
			sql.append("     BPT_PEOPLE             T,\n" ); 
			sql.append("     DIC_CITY               C\n" ); 
			sql.append(" WHERE  P.PEOPLE_ID = T.PEOPLE_ID\n" ); 
			sql.append(" AND P.DOMICILE_CODE = C.ID\n" ); 
			sql.append(" AND P.PEOPLE_ID = ?\n" ); 
			sql.append(" AND T.PEOPLE_ID = ?\n" ); 
			sql.append(" AND S.REGISTER_ID = ?");
		DataSet ds = this.executeDataset(sql.toString(), new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},
				new Object[]{registerId,"B1",peopleId,peopleId,registerId}, true);
		Record rd = ds.getRecord(0);
		Record resultRecord = new Record();
		resultRecord.set("regDetailId",rd.get("REG_DETAIL_ID").toString());
		resultRecord.set("registerId",(String)rd.get("REGISTER_ID"));
		resultRecord.set("domicileCode", (String)rd.get("DOMICILE_CODE"));
		resultRecord.set("domicileName", (String)rd.get("DOMICILE_NAME"));
		resultRecord.set("registerType", rd.get("REGISTER_TYPE").toString());
		resultRecord.set("respectiveYears", (String)rd.get("RESPECTIVE_YEARS"));
		resultRecord.set("peopleId", (String)rd.get("PEOPLE_ID"));
		resultRecord.set("name", (String)rd.get("NAME"));
		resultRecord.set("idCord", (String)rd.get("ID_CARD"));
		resultRecord.set("accountCode", (String)rd.get("ACCOUNT_CODE"));
		resultRecord.set("objectType", (String)rd.get("RETIRED_TYPE_CODE"));
		resultRecord.set("credentialsNo", (String)rd.get("CREDENTIALS_NO"));
		resultRecord.set("domicileType", (String)rd.get("DOMICILE_TYPE"));
		resultRecord.set("oldLonelyFlag", (String)rd.get("OLD_LONELY_FLAG"));
		DataSet resultDs = new DataSet();
		resultDs.add(resultRecord);
		return resultDs;
	}
	/**
	 * 获取新增的生活补助费发放对象
	 */
	public DataSet getNewLiveAllowGrantDs(ParameterSet pset){
		String registerId = (String)pset.getParameter("registerId"),
		   peopleId = (String)pset.getParameter("peopleId"),
		   objectType = (String)pset.getParameter("objectType");
		DataSet ds = new DataSet();
		StringBuffer warSql = new StringBuffer();
		warSql.append("SELECT SYS_GUID() AS REG_DETAIL_ID,\n" );
		warSql.append("       ? AS REGISTER_ID,\n" ); 
		warSql.append("       P.DOMICILE_CODE,\n" ); 
		warSql.append("       C.FULL_NAME,\n" ); 
		warSql.append("       ? AS REGISTER_TYPE,\n" ); 
		warSql.append("       S.RESPECTIVE_YEARS,\n" ); 
		warSql.append("       P.PEOPLE_ID,\n" ); 
		warSql.append("       P.NAME,\n" ); 
		warSql.append("       P.ID_CARD,\n" ); 
		warSql.append("       T.ACCOUNT_CODE,\n" ); 
		warSql.append("       T.WAR_TYPE_CODE AS OBJECT_TYPE,\n" ); 
		warSql.append("       P.WAR_NO AS CREDENTIALS_NO,\n" ); 
		warSql.append("       P.DOMICILE_TYPE,\n" ); 
		warSql.append("       T.OLD_LONELY_FLAG\n" ); 
		warSql.append("  FROM BASEINFO_PEOPLE     P,\n" ); 
		warSql.append("       BPT_CAPITAL_SUMMARY S,\n" ); 
		warSql.append("       BPT_PEOPLE_WAR      D,\n" ); 
		warSql.append("       BPT_PEOPLE          T,\n" ); 
		warSql.append("       DIC_CITY            C\n" ); 
		warSql.append(" WHERE P.PEOPLE_ID = D.PEOPLE_ID\n" ); 
		warSql.append("   AND D.PEOPLE_ID = T.PEOPLE_ID\n" ); 
		warSql.append("   AND P.DOMICILE_CODE = C.ID\n" ); 
		warSql.append("   AND P.PEOPLE_ID = ?\n" ); 
		warSql.append("   AND D.PEOPLE_ID = ?\n" ); 
		warSql.append("   AND T.PEOPLE_ID = ?\n" ); 
		warSql.append("   AND S.REGISTER_ID = ?");
		StringBuffer testedSql = new StringBuffer();
		testedSql.append("SELECT SYS_GUID() AS REG_DETAIL_ID,\n" );
		testedSql.append("         ? AS REGISTER_ID,\n" ); 
		testedSql.append("         P.DOMICILE_CODE,\n" ); 
		testedSql.append("         C.FULL_NAME,\n" ); 
		testedSql.append("         ? AS REGISTER_TYPE,\n" ); 
		testedSql.append("         S.RESPECTIVE_YEARS,\n" ); 
		testedSql.append("         P.PEOPLE_ID,\n" ); 
		testedSql.append("         P.NAME,\n" ); 
		testedSql.append("         P.ID_CARD,\n" ); 
		testedSql.append("         T.ACCOUNT_CODE,\n" ); 
		testedSql.append("         T.WAR_TYPE_CODE AS OBJECT_TYPE,\n" ); 
		testedSql.append("         P.WAR_NO AS CREDENTIALS_NO,\n" ); 
		testedSql.append("         P.DOMICILE_TYPE,\n" ); 
		testedSql.append("         T.OLD_LONELY_FLAG\n" ); 
		testedSql.append("    FROM BASEINFO_PEOPLE     P,\n" ); 
		testedSql.append("         BPT_CAPITAL_SUMMARY S,\n" ); 
		testedSql.append("         BPT_PEOPLE_WAR      D,\n" ); 
		testedSql.append("         BPT_PEOPLE          T,\n" ); 
		testedSql.append("         DIC_CITY            C\n" ); 
		testedSql.append("   WHERE P.PEOPLE_ID = D.PEOPLE_ID\n" ); 
		testedSql.append("     AND D.PEOPLE_ID = T.PEOPLE_ID\n" ); 
		testedSql.append("     AND P.DOMICILE_CODE = C.ID\n" ); 
		testedSql.append("     AND P.PEOPLE_ID = ?\n" ); 
		testedSql.append("     AND D.PEOPLE_ID = ?\n" ); 
		testedSql.append("     AND T.PEOPLE_ID = ?\n" ); 
		testedSql.append("     AND S.REGISTER_ID = ?");

			
		if("51".equals(objectType)){
			ds = this.executeDataset(warSql.toString(), new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},
					new Object[]{registerId,51,peopleId,peopleId,peopleId,registerId}, true);
		}else if("61".equals(objectType)){
			ds = this.executeDataset(testedSql.toString(), new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},
					new Object[]{registerId,51,peopleId,peopleId,peopleId,registerId}, true);
		}
		Record rd = ds.getRecord(0);
		Record resultRecord = new Record();
		resultRecord.set("regDetailId",rd.get("REG_DETAIL_ID").toString());
		resultRecord.set("registerId",(String)rd.get("REGISTER_ID"));
		resultRecord.set("domicileCode", (String)rd.get("DOMICILE_CODE"));
		resultRecord.set("domicileName", (String)rd.get("FULL_NAME"));
		resultRecord.set("registerType", rd.get("REGISTER_TYPE").toString());
		resultRecord.set("respectiveYears", (String)rd.get("RESPECTIVE_YEARS"));
		resultRecord.set("peopleId", (String)rd.get("PEOPLE_ID"));
		resultRecord.set("name", (String)rd.get("NAME"));
		resultRecord.set("idCord", (String)rd.get("ID_CARD"));
		resultRecord.set("accountCode", (String)rd.get("ACCOUNT_CODE"));
		resultRecord.set("objectType", (String)rd.get("OBJECT_TYPE"));
		resultRecord.set("credentialsNo", (String)rd.get("CREDENTIALS_NO"));
		resultRecord.set("domicileType", (String)rd.get("DOMICILE_TYPE"));
		resultRecord.set("oldLonelyFlag", (String)rd.get("OLD_LONELY_FLAG"));
		DataSet resultDs = new DataSet();
		resultDs.add(resultRecord);
		return resultDs;
	}
	
	/**
	 * 导出数据
	 */
	public DataSet queryExportData(ParameterSet pset){
		 String registerId = (String)pset.get("registerId"); 
		 StringBuffer sql = new StringBuffer();
		 sql.append( "SELECT REG_DETAIL_ID,\n" );
		sql.append("       REGISTER_ID,\n" ); 
		sql.append("       DOMICILE_CODE,\n" ); 
		sql.append("       REGISTER_TYPE,\n" ); 
		sql.append("       RESPECTIVE_YEARS,\n" ); 
		sql.append("       PEOPLE_ID,\n" ); 
		sql.append("       CHANGE_STATE,\n" ); 
		sql.append("       NAME,\n" ); 
		sql.append("       ID_CORD,\n" ); 
		sql.append("       ACCOUNT_CODE,\n" ); 
		sql.append("       OBJECT_TYPE,\n" ); 
		sql.append("       CASE OBJECT_TYPE\n" ); 
		sql.append("         WHEN '11' THEN\n" ); 
		sql.append("          '残疾军人'\n" ); 
		sql.append("         WHEN '12' THEN\n" ); 
		sql.append("          '伤残国家机关工作人员'\n" ); 
		sql.append("         WHEN '13' THEN\n" ); 
		sql.append("          '伤残人民警察'\n" ); 
		sql.append("         WHEN '14' THEN\n" ); 
		sql.append("          '伤残民兵民工'\n" ); 
		sql.append("         WHEN '15' THEN\n" ); 
		sql.append("          '因战因公伤残人员'\n" ); 
		sql.append("         WHEN '21' THEN\n" ); 
		sql.append("          '烈士家属'\n" ); 
		sql.append("         WHEN '22' THEN\n" ); 
		sql.append("          '因公牺牲军人家属'\n" ); 
		sql.append("         WHEN '23' THEN\n" ); 
		sql.append("          '病故军人家属'\n" ); 
		sql.append("         WHEN '41' THEN\n" ); 
		sql.append("          '在乡复员军人'\n" ); 
		sql.append("         WHEN '42' THEN\n" ); 
		sql.append("          '带病回乡复员军人'\n" ); 
		sql.append("         WHEN '51' THEN\n" ); 
		sql.append("          '参战'\n" ); 
		sql.append("         WHEN '61' THEN\n" ); 
		sql.append("          '参试'\n" ); 
		sql.append("		   ELSE ''\n");
		sql.append("       END OBJECT_TYPE,\n" ); 
		sql.append("       CREDENTIALS_NO,\n" ); 
		sql.append("       CASE DOMICILE_TYPE\n" ); 
		sql.append("         WHEN '1' THEN\n" ); 
		sql.append("          '农村'\n" ); 
		sql.append("         WHEN '2' THEN\n" ); 
		sql.append("          '城镇'\n" ); 
		sql.append("		   ELSE ''\n");
		sql.append("       END DOMICILE_TYPE,\n" ); 
		sql.append("       CASE DISABILITY_GENUS_CODE\n" ); 
		sql.append("         WHEN '1' THEN\n" ); 
		sql.append("          '在乡'\n" ); 
		sql.append("         WHEN '2' THEN\n" ); 
		sql.append("          '在职'\n" ); 
		sql.append("		   ELSE ''\n");
		sql.append("       END DISABILITY_GENUS_CODE,\n" ); 
		sql.append("       CASE DISABILITY_CASE_CODE\n" ); 
		sql.append("         WHEN '1' THEN\n" ); 
		sql.append("          '因战'\n" ); 
		sql.append("         WHEN '2' THEN\n" ); 
		sql.append("          '因公'\n" ); 
		sql.append("         WHEN '3' THEN\n" ); 
		sql.append("          '因病'\n" ); 
		sql.append("		   ELSE ''\n");
		sql.append("       END DISABILITY_CASE_CODE,\n" ); 
		sql.append("       CASE DISABILITY_LEVEL_CODE\n" ); 
		sql.append("         WHEN '01' THEN\n" ); 
		sql.append("          '一级'\n" ); 
		sql.append("         WHEN '02' THEN\n" ); 
		sql.append("          '二级'\n" ); 
		sql.append("         WHEN '03' THEN\n" ); 
		sql.append("          '三级'\n" ); 
		sql.append("         WHEN '04' THEN\n" ); 
		sql.append("          '四级'\n" ); 
		sql.append("         WHEN '05' THEN\n" ); 
		sql.append("          '五级'\n" ); 
		sql.append("         WHEN '06' THEN\n" ); 
		sql.append("          '六级'\n" ); 
		sql.append("         WHEN '07' THEN\n" ); 
		sql.append("          '七级'\n" ); 
		sql.append("         WHEN '08' THEN\n" ); 
		sql.append("          '八级'\n" ); 
		sql.append("         WHEN '09' THEN\n" ); 
		sql.append("          '九级'\n" ); 
		sql.append("         WHEN '10' THEN\n" ); 
		sql.append("          '十级'\n" ); 
		sql.append("		   ELSE ''\n");
		sql.append("       END DISABILITY_LEVEL_CODE,\n" ); 
		sql.append("       CASE BELONG_DATE\n" ); 
		sql.append("         WHEN '1' THEN\n" ); 
		sql.append("          '抗日战争'\n" ); 
		sql.append("         WHEN '2' THEN\n" ); 
		sql.append("          '解放战争'\n" ); 
		sql.append("         WHEN '3' THEN\n" ); 
		sql.append("          '建国后'\n" ); 
		sql.append("		   ELSE ''\n");
		sql.append("       END BELONG_DATE,\n" ); 
		sql.append("       CASE OLD_LONELY_FLAG\n" ); 
		sql.append("         WHEN '0' THEN\n" ); 
		sql.append("          '否'\n" ); 
		sql.append("         WHEN '1' THEN\n" ); 
		sql.append("          '是'\n" ); 
		sql.append("		   ELSE ''\n");
		sql.append("       END OLD_LONELY_FLAG,\n" ); 
		sql.append("       GRANT_STA_MON,\n" ); 
		sql.append("       GRANT_MONTHS,\n" ); 
		sql.append("       GRANT_MON,\n" ); 
		sql.append("       INCREASE_MECHANISM,\n" ); 
		sql.append("       GRAIN_OIL_MON,\n" ); 
		sql.append("       COAL_SUBSIDY_MON,\n" ); 
		sql.append("       ANTI_JAPANESE_MON,\n" ); 
		sql.append("       OLD_LONELY_MON,\n" ); 
		sql.append("       SUPPLY_MON,\n" ); 
		sql.append("       OTHER_SUBSIDY_ONE,\n" ); 
		sql.append("       OTHER_SUBSIDY_TWO,\n" ); 
		sql.append("       OTHER_SUBSIDY_THREE,\n" ); 
		sql.append("       OTHER_SUBSIDY_FOUR,\n" ); 
		sql.append("       OTHER_SUBSIDY_FIVE,\n" ); 
		sql.append("       GRANT_MON_SUM,\n" ); 
		sql.append("       NOTE,\n" ); 
		sql.append("       REG_ID,\n" ); 
		sql.append("       REG_TIME,\n" ); 
		sql.append("       MOD_ID,\n" ); 
		sql.append("       MOD_TIME,\n" ); 
		sql.append("       DOMICILE_NAME,\n" ); 
		sql.append("       NURSING_MON,\n" ); 
		sql.append("       SUB_TOTAL,\n" ); 
		sql.append("       CASE DISABILITY_WAR_CODE\n" ); 
		sql.append("         WHEN '1' THEN\n" ); 
		sql.append("          '抗日战争'\n" ); 
		sql.append("         WHEN '2' THEN\n" ); 
		sql.append("          '解放战争'\n" ); 
		sql.append("         WHEN '3' THEN\n" ); 
		sql.append("          '建国后'\n" ); 
		sql.append("		   ELSE ''\n");
		sql.append("       END DISABILITY_WAR_CODE\n" ); 
		sql.append("  FROM BPT_CAPITAL_DETAIL T\n" ); 
		sql.append(" WHERE T.REGISTER_ID = ?");
		 DataSet ds = this.executeDataset(sql.toString(), new int[]{Types.VARCHAR}, new Object[]{registerId},true);
		 return ds;
	}
}
