package com.inspur.cams.comm.diccity.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.diccity.data.DicCity;

/**
 * 行政区划查询dao接口
 * 
 * @author wangbaocai
 * @date 2011-6-23
 */
public interface IDicCityDao extends BaseCURD<DicCity> {
	
	/**
	 * 查询下级行政区划
	 * @param ups
	 * @return
	 */
	public DataSet getDirectUnderling(String ups);
	
	public DataSet queryCity(ParameterSet pset); 
	
	/**
	 * 查询下级行政区划
	 * @param ups
	 * @return
	 */
	public DataSet getDirectUnder(String ups);

	/**
	 * 查询下级行政区划，不包含本级
	 * @param ups
	 * @return
	 */
	public DataSet getDirectUnderlingWithoutSelf(String ups);
	
	public String getOrganNameById(String id);
	

}
