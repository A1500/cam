package com.inspur.cams.bpt.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;

import com.inspur.cams.bpt.base.data.DicBptCareer;
import com.inspur.cams.comm.diccity.data.DicCity;

/**
 * 行政区划查询dao接口
 * 
 * @author wangbaocai
 * @date 2011-6-23
 */
public interface IDicBptCareerDao extends BaseCURD<DicBptCareer> {
	
	/**
	 * 查询下级行政区划
	 * @param ups
	 * @return
	 */
	public DataSet getDirectUnderling(String ups);
	
}
