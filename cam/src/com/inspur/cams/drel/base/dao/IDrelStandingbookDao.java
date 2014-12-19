package com.inspur.cams.drel.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.base.data.DrelStandingbook;

/**
 * 台账表dao
 * @author 
 * @date 2013-09-09
 */
public interface IDrelStandingbookDao extends BaseCURD<DrelStandingbook> {
	
	
	/**
	 *  台账表导出查询
	 * @param domicileCode
	 */
	public DataSet queryInfo(ParameterSet pset);
	

}