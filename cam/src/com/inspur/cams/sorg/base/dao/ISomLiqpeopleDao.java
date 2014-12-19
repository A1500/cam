package com.inspur.cams.sorg.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.data.SomLiqpeople;

/**
 * 社会组织清算组织人员dao接口
 * 
 * @author Muqi
 * @date 2011年5月17日18:52:48
 */
public interface ISomLiqpeopleDao extends BaseCURD<SomLiqpeople> {
	/**
	 * 根据sorgId，删除社会组织清算组织人员
	 * 
	 * @param sorgId
	 */
	public void deleteBySorgId(String sorgId);
	
	public DataSet queryNoPage(ParameterSet pset);
}
