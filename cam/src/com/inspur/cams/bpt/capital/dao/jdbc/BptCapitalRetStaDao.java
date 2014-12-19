package com.inspur.cams.bpt.capital.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.capital.dao.IBptCapitalRetStaDao;
import com.inspur.cams.bpt.capital.data.BptCapitalRetMarSta;
/**
 * @title 农村退役士兵补助标准列表dao
 * @author Lin Yangyang
 *
 */
public class BptCapitalRetStaDao extends EntityDao<BptCapitalRetMarSta> implements IBptCapitalRetStaDao{
	/**
	 * 必须写的（前人写好的）
	 * @throws Exception
	 */
	public BptCapitalRetStaDao() throws Exception{
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}
	/**
	 * 必须写的（前人写好的）
	 */
	@Override
	public Class getEntityClass(){
		return BptCapitalRetMarSta.class;
	}
	/**
	 * @title 新增时插入上一条生效日期止
	 * @param params
	 */
	public void udpateEndDate(ParameterSet pset){
		String end_date= (String) pset.getParameter("endDate");
		String start_date = (String)pset.getParameter("startDate");
		String sql ="update BPT_RETIRED_MARTYR_STA t set t.end_date=? where t.start_date=?";
		this.executeUpdate(sql, new int[]{Types.VARCHAR,Types.VARCHAR}, new Object[]{end_date,start_date});
	}
	/**
	 * 获得最大日期起
	 * @param pset
	 * @return
	 */
	public DataSet getMaxDate(ParameterSet pset){
		String object_type=(String) pset.getParameter("objectType");
		String standards_counties=(String) pset.getParameter("standardsCounties");
		String sql ="select distinct max(c.start_date) start_date from BPT_RETIRED_MARTYR_STA c where c.object_type=? and c.standards_counties=?";
		return this.executeDataset(sql, new int[]{Types.VARCHAR,Types.VARCHAR}, new Object[]{object_type,standards_counties}, true);
	}
}